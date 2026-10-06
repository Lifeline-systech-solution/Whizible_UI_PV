<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_wbs_card.aspx.vb" Inherits="Whizible.PM_wbs_card" %>

<!DOCTYPE html>
<html>


    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("WBS")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>WBS</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2" />

    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <!--bootstrap multiselect---->
    <link href="../../../Whizible2.0-new/dist/css/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <!-- project style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <!-- project style -->

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/gist.css">
    
    <!-- bootstrap datepicker -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css">
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

</head>

    <style>
        /*CSS Added command Commented by Madhuri.K content 29-Aug-2024*/

        @media (min-width: 992px) {
    .collapsed {
         margin-right: 0%; 
    }
}
        .input-group-btn button.btn.btncalendar {
            height: 35px;
        }
        .filterpanelbody .btncalendar {
    margin-top: 0px !important;
    margin-left: -2px !important;
}
         /*CSS Added command Commented by Madhuri.K content 29-Aug-2024*/
        .alertify-notifier {
            z-index: 99999 !important;
        }

        .ui-sortable-placeholder:empty {
            min-height: 100px
        }

        .some {
            background-color: red
        }

        section.content {
            min-height: auto
        }
        /* Modified CSS by Gauri on 3rd Oct 2024 for text color Issue */
        .InvalidRows td {
            color: red;
        }

        .ValidRows td {
            color: #228b22;
        }
        /* End of Modified CSS by Gauri on 3rd Oct 2024 for text color Issue */

        .circle_green {
            border: 2px solid #a1a1a1;
            padding: 10px 11px;
            background: green;
            width: 2px;
            border-radius: 100%;
            margin-left: auto;
            margin-right: auto;
            width: 1%
        }

        .circle_red {
            border: 2px solid #a1a1a1;
            padding: 10px 11px;
            background: red;
            width: 2px;
            border-radius: 100%;
            margin-left: auto;
            margin-right: auto;
            width: 1%
        }

        .scrolledTable {
            overflow-y: auto;
            overflow-x: auto;
            clear: both
        }

        /*Custom style to add dynamically basis on task card staus and start and end date*/
        .taskcardbox.taskcardbox_todo.Amber {
            border-left: 12px solid #ffbf00
        }

        .taskcardbox.taskcardbox_todo.Red {
            border-left: 12px solid #CD0000
        }

        .taskcardbox.taskcardbox_todo.Green {
            border-left: 12px solid green
        }



        .prioritylabelNotSet {
            background-color: gray
        }

        .displaybutton {
            float: right
        }

        .inactiveTasks {
            background-color: #ccc
        }

        .horizanalscroll {
            width: auto;
            overflow-x: auto;
            white-space: nowrap
        }

        .gutter {
            float: left;
            cursor: ew-resize;
            flex-basis: 1px !important;
            padding: 0;
            border-right: 1px dashed #ccc;
            box-shadow: 0 0 1px 1px #999;
            margin: 0 15px;
            height: 200%
        }

            .gutter::after {
                position: absolute;
                top: 0;
                content: "-----";
                width: 30px;
                left: 0;
                right: 0;
                text-align: center;
                height: 10px;
                margin-left: -13px;
                background: url(../../../Whizible2.0-new/dist/img/split.png) 0 0 no-repeat
            }

        .gist .gist-data {
            white-space: nowrap
        }

        .cardfooter {
            display: flex
        }

        .taskcardbox {
            cursor: move
        }

        .taskcardboxinactiveTask {
            cursor: not-allowed
        }

        .d-inline {
            display: inline-block
        }

        .hrzntlSearch.d-inline {
            margin-left: 5px
        }

        .hrzntlSearch input[type=text] {
            width: 130px;
            box-sizing: border-box;
            border: 1px solid #464a4c;
            border-radius: 4px;
            font-size: 16px;
            background-color: #fff;
            background-image: url(../../../Whizible2.0-new/dist/img/search.svg);
            background-position: 6px 6px;
            background-repeat: no-repeat;
            padding: 6px 20px 6px 40px;
            -webkit-transition: width .4s ease-in-out;
            transition: width .4s ease-in-out;
            background-size: 24px;
            margin-top: 7px
        }

            .hrzntlSearch input[type=text]:focus {
                width: 100%;
                outline: none;
                background-color: #eee
            }

        .hrzntlSearch ul.dropdown-menu {
            width: 260px; min-height:200px;
            border: 1px solid rgba(0,0,0,.2);
            border-radius: 6px;
            -webkit-box-shadow: 0 5px 10px rgba(0,0,0,.2);
            box-shadow: 0 5px 10px rgba(0,0,0,.2);
            line-break: auto;
            overflow: auto;
            -webkit-transition: all 1s -.25s ease-out;
            -moz-transition: all 1s -.25s ease-out;
            -o-transition: all 1s -.25s ease-out;
            -ms-transition: all 1s -.25s ease-out;
            transition: all 1s -.25s ease-out;
            max-height: 0
        }

        .dropdown .hrzntlSearch.open ul.dropdown-menu {
            -webkit-transition: all .6s ease;
            -moz-transition: all .6s ease;
            -o-transition: all .6s ease;
            -ms-transition: all .6s ease;
            transition: all .6s ease;
            max-height: 290px
        }

        .hrzntlSearch ul.dropdown-menu li {
            position: relative
        }

            .hrzntlSearch ul.dropdown-menu li a {
                white-space: normal;
                padding-left: 42px
            }

                .hrzntlSearch ul.dropdown-menu li a .fas {
                    position: absolute;
                    left: 15px;
                    top: 8px
                }

        .gwbsdetaillist {
            padding: 0
        }

            .gwbsdetaillist li {
                display: inline-block;
                margin: 5px;
                width: 46%;
                display: inline-block
            }

        .flagdetailpoover.dropdown.open i.far.fa-flag {
            display: none
        }

        .flagdetailpoover.dropdown.open i.fas.fa-flag {
            display: block !important
        }

        .Tskflag .fas.fa-flag {
            display: none
        }

        .tab-slider--tabs li:first-child span {
            padding-left: 5px;
            padding-right: 10%
        }

        .wbs .tab-slider--tabs.slide:after {
            left: 46%
        }

        .wbs li[rel="wbsmpptab"] {
            padding-left: 0
        }

        .weeklyanddaily span {
            display: block
        }

        .tab-slider--tabs:after {
            padding: 11px 10px
        }

        .WBSwhizndmpptask .tab-slider--tabs:after {
            width: 48%
        }

        .WBSwhizndmpptask .tab-slider--trigger {
            /*Commented & Added By Dipali V On 9th Nov 2020 For UI changes*/
            /*width: 113px;*/
            width: 108px;
            padding: 11px 6px 11px 6px
        }
        /*modified by pradip on 9-6-2020*/


        .tab-slider--tabs li:first-child span {
            padding: 0
        }

        .WBSactivnall .tab-slider--tabs:after {
            width: 48%
        }

        .WBSactivnall .tab-slider--trigger {
            width: 68px;
            padding: 11px 12px 11px 12px
        }
        /*modified by pradip on 9-10-2020*/

        ul#popover_content_flagdetailswrap {
            padding: 20px
        }

        .date-picker-wrapper.no-topbar {
            padding-top: 12px;
            z-index: 9999
        }

        .date-picker-wrapper .month-wrapper {
            overflow: hidden
        }

        #draggable-menu > div:last-child ul.dropdown-menu.flagdetailswrap {
            right: 0;
            left: auto
        }

        .selectedDiv {
            border-block-end-color: grey;
            border-block-end-width: 10px;
            border-block-start-color: grey;
            border-block-start-width: 10px
        }


        /*Multiselect added by pradip*/

        .multiselect-native-select .btn-group {
            width: 100%
        }

            .multiselect-native-select .btn-group button {
                width: 100%;
                min-height: 34px;
                text-align: left;
                overflow: hidden;
                text-overflow: ellipsis
            }

                .multiselect-native-select .btn-group button b.caret {
                    float: right;
                    text-align: right;
                    margin-top: 6px
                }

        .multiselect-native-select .multiselect-container {
            width: 100%
        }

        .multiselect-native-select .dropdown-menu > .active > a, .multiselect-native-select .dropdown-menu > .active > a:focus, .multiselect-native-select .dropdown-menu > .active > a:hover {
            background-color: #f0f1f5;
            color: #464a4c
        }

        .multiselect-native-select .btn-group button span.multiselect-selected-text {
            width: 90%;
            display: inline-block;
            overflow: hidden;
            text-overflow: ellipsis
        }

        .commentedtitor {
            margin-top: 20px;
            margin-bottom: 0
        }

        /*Multiselect end*/
        /*css added by pradip on 21-12-2019*/
        .resourceallocation_header .btnlistinline li {
            vertical-align: middle;
        }

        #ui-datepicker-div {
            z-index: 999999 !important;
        }

        /*Added by Omkar T on 13-01-20*/
        .ml-05 {
            margin-left: 5px !important;
        }

        #sectionMain {
            background-color: #f5f5f5 !important;
        }

        .filterpanelwrap {
            border-bottom: 1px solid #ccc;    background: #f5f5f5;
    margin-bottom: 10px;
        }

        .hrzntlSearch input[type=text] {
            border: 1px solid #ccc;
        }

        .wbstaskpanel_heading {
            margin: 0px 0px 10px;
        }

        .draggablemenu {
            /*height: 100% !important;*/ /*Commented by pradip on 15-01-2020*/
            border-left: 1px solid #ccc;
            padding: 0px 5px;
        }

            .draggablemenu:first-child {
                border: none;
            }

            .draggablemenu:first-child, .draggablemenu:nth-child(3), .draggablemenu:nth-child(4) {
                padding: 0px 5px;
            }

            .draggablemenu:last-child {
                padding: 0px 0px 0px 5px;
            }

      
        #draggable-menu {
            height: 100%;
            display: flex;
            flex-direction: row;
            flex: unset;
            flex-flow: row;
        }
      
        .hrzntlSearch input[type=text] {
            margin: 7px 0px;
        }
        /*Added by Omkar T on 14-01-20*/
        .card-title {
            margin: 4px 95px 10px 0px;
        }
        /*Added by Omkar T on 15-01-20*/
        #taskeditor .modal-dialog {
            width: 900px; min-width:900px;
        }

        .mb-10 {
            margin-bottom: 10px;
        }

        .mb-15 {
            margin-bottom: 15px;
        }

        .selectedDiv {
            border-block-end-color: #808080;
            border-block-end-width: 0px;
            border-block-start-color: #808080;
            border-block-start-width: 0px;
            border: 1px solid #ddd;
        }

        .disabledbutton {
            pointer-events: none;
            opacity: 0.9;
        }


        #btnDeleteStage {
            width: 48px;
        }

            #btnDeleteStage img {
                width: 15px;
                display: none;
            }

        .wbstaskpanel_heading:hover > #btnDeleteStage img {
            display: block;
        }
        /*End Added style by Omkar T on 15-01-20*/

        /*New style Added by pradip on 15-01-2020*/
        #sectionMain {
            padding-top: 0;
        }

        .wbstaskpanel_heading {
            border-top: 15px solid #f5f5f5;
            border-bottom: 15px solid #f5f5f5;
            margin-bottom: 0;
        }

        .addwbstaskbtn {
            opacity: 1;
        }

        .addwbstaskbtn {
            width: 410px;
        }

        .taskcardbox:hover {
            box-shadow: 0px 0px 6px 2px #ddd;
        }

        .tskcardBox {
            position: relative;
            z-index: 9;
        }

        
        .ui-sortable {
            width: 425px !important;
            display: inline-block;
            vertical-align: top;
            flex: 1;
            flex-flow: 1;
            min-height: 690px;
            min-width: 425px;
        }

        /*Added by Omkar T on 16-01-20*/
        #btnDeleteStage {
            width: 48px;
            position: absolute;
            right: 0px;
        }

        .btn.active.focus, .btn.active:focus, .btn.focus, .btn:active.focus, .btn:active:focus, .btn:focus {
            outline: thin dotted;
            outline: 0px auto -webkit-focus-ring-color;
            outline-offset: 0px;
        }

        .selectedDiv .card.gist-data {
            background-color: #f0f9ff;
        }

        .filter button[aria-expanded="true"] {
            background: none;
            color: #464a4c;
        }

        .filter button.filteractive {
            background: #1359ac;
            color: white;
        }

        /*Added By Pradip P On 23rd Jan 2020 For Note Alignment*/
        ul.dropdown-menu.flagdetailswrap {
            max-width: 320px;
            word-wrap: break-word;
            white-space: normal;
            max-height: 205px;
            overflow: auto;
            min-width: 320px;
        }


        @media all and (-ms-high-contrast:none) {
            *::-ms-backdrop, .hrzntlSearch input[type=text] {
                background-position: -26px 5px;
                background-color: #ffffff !important;
                background-size: 69%;
                background-image: url(../../../Whizible2.0-new/dist/img/search.svg);
            }
                /* IE11 */
                .hrzntlSearch input[type=text]:focus {
                    background-position: -74px 5px;
                }
        }

        #tblUploadedExcel_length {
            display: none;
        }

        ul.nav-wizard li.disabled {
            cursor: no-drop;
        }

            ul.nav-wizard li.disabled a {
                pointer-events: none;
                cursor: no-drop;
            }
        /*End of Added By Pradip P On 23rd Jan 2020 For Note Alignment*/
        .disabledNote {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
        }

      
        .tskexcel_tbl tr th {
            min-width: 100px;
        }
       

        /*Addition By dipali V On 12th Feb 2020 For Flag */
        .FlagColor_Red {
            color: red
        }

        /*End of Addition By dipali V On 12th Feb 2020 For Flag */

        /*Added by Chetan M on 14th Feb 2020 for clear datatable*/
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }
        /*End of Added by Chetan M on 14th Feb 2020 for clear datatable*/

        /*Added  By Dipali V On 17th Feb 2020 For Restrict Void task Deletion*/
        .disabledDiv {
            /*opacity: .4;*/
            /*cursor: no-drop;*/
        }
        /*End of Added  By Dipali V On 17th Feb 2020 For Restrict Void task Deletion*/


        #tblUploadedExcel_paginate {
            display: none !important;
        }
        /*Added By Usha Pandit On 30.08.2020 For display message when no matching records are found as per filter applied*/
        .clswbswhizibletab {
            text-align: center !important;
        }

        .clsdraggable-menu {
            display: inline !important;
        }

        .clsStage {
            display: none !important;
        }

           #CloseableAlert .close {
            float: right;
            border: none;
        }
        /*End Of Added By Usha Pandit On 30.08.2020 For display message when no matching records are found as per filter applied*/
/*BS5 changes*/
.btn span.caret{ display:none;}
.popupboxtabs li > a{ padding:4px 12px;}
ul.nav.ganttmainactionbtnlist {display: inline-flex;align-items: center;}
.filedownload .dropdown-toggle::after{ display:none;}
.filedownload .dropdown-menu li a{ display:block;}
/*End BS5 changes*/

/*added by Ashwini M on 24-3-2023*/
.ClosaeblealertMsg{ display:none;}
.alert .close {color: #fff;opacity: 1;float: right;font-size: 16px; background:none; border:none;}
.flagdetailswrap .form-select, .flagdetailswrap .form-control{margin-bottom:1rem}
/*End of added by Ashwini M on 24-3-2023*/


        #exceluploadsteps .modal-content {
            width: 839px;
            margin-left: -198px;
        }

        #tblUploadedExcel_wrapper .dataTables_scroll {
            margin-top: 10px !important;
        }
         /*Added By Dipali V On 20th Jan 2026 For W26 Changes*/
        .ui-sortable {
            width: auto !important;
            display: inline-block;
            vertical-align: top;
            flex: 1;
            flex-flow: 1;
            min-height: auto !important;
            min-width: auto !important;
        }
                .btn-primary-action {
    background: #fef3c7;
    color: #d97706;
    border: none;
    padding: 0.3rem 0.78rem;
    font-weight: 400;
    font-size: 0.8125rem;
    border-radius: 6px;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    box-shadow: none;
}
                    .btn-primary-action:hover {
                        background: #fde68a;
                        color: #b45309;
                        transform: translateY(-1px);
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                    }
    .form-group label
        {
            margin-bottom: 5px;
             /* Modified By Madhuri.K On 26-03-2026 */
             font-size: 11.5px!important;
        }
        .form-control, .btn, a, p, input, select.form-select {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }

           .input-group:not(.has-validation)>.dropdown-toggle:nth-last-child(n+3), .input-group:not(.has-validation)>.form-floating:not(:last-child)>.form-control, .input-group:not(.has-validation)>.form-floating:not(:last-child)>.form-select, .input-group:not(.has-validation)>:not(:last-child):not(.dropdown-toggle):not(.dropdown-menu):not(.form-floating){
       /* Modified By Madhuri.K On 26-03-2026 */
       font-size: 11.5px !important;
   }

        #taskmapping ,#PRattachment{
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }

       .card-title,.dropdown-menu{
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }

       .tooltip-inner {
    font-size: 11px;
    max-width: 220px;
    padding: 6px 8px;
}


    /*End of Added By Dipali V On 20th Jan 2026 For W26 Changes*/     
    </style>

<%--add by omkar 03/02/2020--%>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodywbs" onmouseup="javascript:MouseClick()">
    <%--end of add by omkar 03/02/2020--%>

    <!-- Content Wrapper. Contains page content -->
    <div class="bgwhite wbs">
        <!-- Content Header (Page header) -->

        <div class="graybg resourceallocation_header container-fluid pt-1 pb-1">
            <div class="row">
                <div class="col-sm-2">

                    <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-select ' onChange='javascript:CboProject_OnChange(this.value);'", False,, ) %>--%>
                    <%=CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_WithSelected " & Session("intUserID") & ",'" & Session("LoginType") & "',1,0,'[Over] = ''0''','ProjectName ASC'," & IIf(String.IsNullOrEmpty(Convert.ToString(Session("intProjectID"))) OrElse Convert.ToString(Session("intProjectID")) = "0", "NULL", Session("intProjectID")),,, "onchange='CboProject_OnChange(this.value);' class='form-select'",,,) %>

                    <%--<div class="col-sm-6">                           
                            <% CommonFunctions.HTMLControls.DrawComboBox("CboTaskView", "usp_Whizible2_Sel_TaskView",,, "class='form-control' onChange='javascript:ChangeView(this.value);'", False,, ) %>
                        </div>--%>
                </div>

                <div class="col-sm-3 headertodisable">
                    <div class="weeklyanddaily WBSactivnall">
                        <div class="tab-slider--nav float-end">
                            <ul class="tab-slider--tabs">
                                <li class="tab-slider--trigger active" id="tabActive" rel="wbsactivtasktab" data-bs-toggle="tooltip" data-bs-placement="bottom" title='<%= MyBase.GetResourceString("C_ActiveToolTip") %>' onclick="GetActiveTasks()">
                                    <span><%= MyBase.GetResourceString("C_ActiveButton") %></span>
                                </li>
                                <li data-bs-toggle="tooltip" data-bs-placement="bottom" id="tabAll" title='<%= MyBase.GetResourceString("C_AllTasksToolTip") %>' class="tab-slider--trigger" rel="wbsalltasktab" onclick="GetAllTasks()">
                                    <%= MyBase.GetResourceString("C_AllButton") %></li>
                            </ul>

                        </div>
                    </div>
                </div>
                <div class="col-sm-3 headertodisable">
                    <div class="weeklyanddaily WBSwhizndmpptask">
                        <div class="tab-slider--nav float-end">
                            <ul class="tab-slider--tabs">
                                <li class="tab-slider--trigger active" rel="wbswhizibletab" id="tabWhizibleTasks" onclick="GetWhizibleTask()" data-bs-toggle="tooltip" data-bs-placement="bottom" title='<%= MyBase.GetResourceString("C_WhizibleTaskToolTip") %>'>
                                    <span><%= MyBase.GetResourceString("C_WhizibleTasksButton") %></span>
                                </li>
                                <li data-bs-toggle="tooltip" data-bs-placement="bottom" id="tabMPPTasks" title='<%= MyBase.GetResourceString("C_MPPTaskToolTip") %>' class="tab-slider--trigger" onclick="GetMPPTasks()" rel="wbsmpptab">
                                    <%= MyBase.GetResourceString("C_MPPTasks") %></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4 headertodisable">
                    <ul class="float-end btnlistinline" id="btnExportLinks" style="margin-top: 2px;">
                        <li>
                            <div class="dropdown filedownload">
                                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" data-bs-placement="bottom" title="" data-original-title="Click here to download" autocomplete="off"><i class="fas fa-download"></i></button>

                                <ul class="dropdown-menu" id="fas-download">
                                    <li>
                                        <a href="#" onclick="DownloadReport('PDF')">
                                            <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('EXCEL')">
                                            <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('XML')">
                                            <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('TEXT')">
                                            <%--<img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Doc--%>
                                            <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Text
                                        </a>
                                    </li>
                                </ul>
                            </div>

                        </li>
                        <li class="ml-05 dropdown uploadexcelbtn">
                            <button class="btn borderbtn nobtnstyle-xs dropdown-toggle" data-bs-toggle="dropdown" id="btnimport" onclick="Doimport()">
                                <%= MyBase.GetResourceString("C_ImportButton") %>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu right float-end">
                                <%--    Added & Commented By Dipali V On 21st Jan 2020 For Caption change--%>
                                <%--                             <li><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#exceluploadsteps">Excel To Upload</a></li>--%>
                                <li><a data-bs-toggle="modal" data-bs-target="#exceluploadsteps">Task Excel Upload</a></li>
                                <%--End of Added & Commented By Dipali V On 21st Jan 2020 For Caption change--%>
                            </ul>
                            <!-- Excel-to-upload-modal start -->
                            <div id="exceluploadsteps" class="modal fade custmodal" data-backdrop="static" data-keyboard="false">
                                <div class="modal-dialog" style="width: 75%">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <%--    Added & Commented By Dipali V On 22nd Jan 2020 For Caption change--%>
                                            <%-- <h5 class="modal-title" id="">Task Upload Excel</h5>--%>
                                            <h5 class="modal-title" id="">Task Excel Upload</h5>
                                            <%--End of  Added & Commented By Dipali V On 22nd Jan 2020 For Caption change--%>
                                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">×</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <!--step_wizard-->
                                            <ul class="nav nav-wizard">
                                                <li class="active" id="tabStep1">
                                                    <a data-bs-toggle="tab">Step 1</a>
                                                </li>
                                                <li class="disabled" id="tabStep2">
                                                    <a data-bs-toggle="tab">Step 2</a>
                                                </li>
                                                <li class="disabled" id="tabStep3">
                                                    <a data-bs-toggle="tab">Step 3</a>
                                                </li>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane active" id="PBEUstep1">
                                                    <br />
                                                    <br />
                                                    <div class="file_attach">
                                                        <form>

                                                            <input type="file" multiple id="taskFile" onchange="Vdfileexe(this);">
                                                            <%--<p>Attach file or drop here</p>--%>
                                                            <p>Click here to upload</p>
                                                            <%--<button type="submit">Upload</button>--%>
                                                        </form>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <br />
                                                    <br />
                                                    <ul class="list-inline float-end">
                                                        <li>
                                                            <%--<button id="btnBack" type="button" class="btn borderbtn btnPrevious">Back</button>--%>
                                                            <button type="button" class="btn btnyellow nextwizardbtn ml-1 " id="btnStepOne">Next</button></li>
                                                    </ul>
                                                </div>
                                                <div class="tab-pane" id="PBEUstep2">
                                                    <div class="form-group row">

                                                        <div class="col-sm-6">
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Note :- <span style="color: red; font-weight: 100">System validate story  points with user story's remaining story points</span></label>

                                                        </div>
                                                    </div>





                                                    <div class="form-group row">

                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-A</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnA", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn ' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnA", "select '' ",,, "class='form-control ExcelColumn ' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnA", "select '' ",,, "class='form-select ExcelColumn ' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-B</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnB", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnB", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnB", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-C</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnC", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnC", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnC", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-D</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnD", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnD", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnD", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-E</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnE", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnE", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnE", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-F</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnF", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnF", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnF", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-G</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnG", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnG", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnG", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-H</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnH", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnH", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnH", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-I</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnI", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnI", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnI", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-J</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnJ", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnJ", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnJ", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-K</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnK", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnK", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnK", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-L</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnL", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnL", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnL", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-M</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnM", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnM", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnM", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-N</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnN", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnN", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnN", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-O</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnO", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnO", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnO", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-P</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnP", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnP", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnP", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-Q</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnQ", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnQ", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnQ", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-R</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnR", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnR", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnR", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-S</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnS", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnS", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnS", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-T</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnT", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnT", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnT", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-U</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnU", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnU", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnU", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label class="">Excel Column-V</label>
                                                            <%--Comment and added by imran on 10-01-2022 for performance related--%>
                                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnV", "Usp_Whizible2_Sel_tbl_WBS_TaskFields ",,, "class='form-control ExcelColumn' ", False,, ) %>--%>
                                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnV", "select '' ",,, "class='form-control ExcelColumn' ", False,, ) %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboExcelColumnV", "select '' ",,, "class='form-select ExcelColumn' ", False,, ) %>
                                                        </div>
                                                    </div>

                                                    <br />
                                                    <br />
                                                    <ul class="list-inline float-end">
                                                        <li>
                                                            <button id="btnBackToStepOne" type="button" class="btn borderbtn btnPrevious">Back</button>
                                                            <button type="button" class="btn btnyellow nextwizardbtn ml-1 " id="btnStepTwo">Next</button></li>
                                                    </ul>

                                                </div>
                                                <div class="tab-pane" id="PBEUstep3">
                                                    <p class="float-start" id="uploadedFilName"><a href="#">Uploaded Data :-</a> Book1.xlsx(12-07-2019 17:29:02)</p>
                                                    <div class="form-group float-end">
                                                        <%--<div class="input-group searchsetting" id="searchsetting">
                                                            <input id="searchpracsetting" onkeyup="rsearch()" type="text" class="form-control" placeholder="Search for snippets">
                                                            <span class="input-group-addon">
                                                                <button type="submit">
                                                                    <span class="glyphicon glyphicon-search"></span>
                                                                </button>
                                                            </span>
                                                        </div>--%>
                                                        <div class="circle_green">
                                                        </div>
                                                        <label>Valid Records <span id="validateRecords"></span></label>
                                                        <div class="circle_red">
                                                        </div>
                                                        <label>Invalid Records <span id="InvalidateRecords"></span></label>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <div class="tskexcel_tbl">
                                                        <table class="table bgwhite table-bordered table-fixed-header paginated" id="tblUploadedExcel">
                                                           
                                                        </table>
                                                    </div>
                                                    <br />
                                                    <br />
                                                    <ul class="list-inline float-end">
                                                        <li>
                                                            <button id="btnBackToStepTwo" type="button" class="btn borderbtn btnPrevious">Back</button>
                                                            <button type="button" class="btn btnyellow nextwizardbtn ml-1 uploadbtn" <%--data-bs-dismiss="modal"--%> id="btnUploadExcel">Upload</button></li>
                                                    </ul>


                                                </div>

                                                <div class="clearfix"></div>
                                            </div>

                                        </div>

                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.Excel-to-upload-modal -->
                        </li>
                        <li class="ml-1">
                            <div class="form-inline float-end">
                                <%--<button id="#btnClearAllFilters" class="btn borderbtn mrOnehalf clearfilterbtn" data-bs-toggle="tooltip" data-bs-placement="top" title="Clear Filter" onclick="GetMilestoneList(null)">Clear All Filters</button>--%>
                                <%--Commented And Added By Usha Pandit On 02.12.2020 For Clear all filter issue on IE browser--%>
                                <%--<a class="clearalllink" href="" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Clear Filter" id="TaskClearAllFilter" onclick="GetDeafultFilter()" style="display: none"><strong><%= MyBase.GetResourceString("C_ClearAll") %></strong></a>--%>
                                <a class="clearalllink" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Clear Filter" id="TaskClearAllFilter" onclick="GetDeafultFilter()" style="display: none"><strong style="cursor: pointer;">Clear All</strong></a>
                                <%--End Of Added By Usha Pandit On 02.12.2020 For Clear all filter issue on IE browser--%>
                            </div>
                        </li>
                        <li class="ml-1">
                            <div class="filter float-end">
                                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter"><i class="fas fa-filter"></i></button>
                            </div>
                        </li>

                    </ul>
                </div>

            </div>
        </div>

        <div id="filterpanel" class="filterpanelwrap collapse">
            <div class="filterpanelbody">
                <div class="row form-group">
                    <div class="col-sm-3">
                        <%-- Commented & Added By Dipali V On 22nd Jan 2020 For Remove Mandatory--%>
                        <%--<label class="control-label required">Employee </label>--%>
                        <label class="control-label">Employee </label>
                        <%-- End of Commented & Added By Dipali V On 22nd Jan 2020 For Remove Mandatory--%>
                        <select class="form-control form-select" id="cboEmployeeIDFilter" name="cboEmployeeIDFilter"></select>
                    </div>
                    <div class="col-sm-3">
                        <label class="control-label">Task Type</label>
                        <select class="form-control form-select" id="cboTaskTypeFilter" name="cboTaskTypeFilter"></select>
                    </div>
                    <div class="col">
                        <label class="control-label">Start Date</label>
                        <div class="input-group datefielddiv">
                            <% CommonFunctions.HTMLControls.DrawTextBox("txtStartDateFilter", "txtStartDateFilter", "form-control",, 50,,,,,,,,,,,,,,, True)%>
                            <span class="input-group-btn">
                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                            </span>
                        </div>
                    </div>
                    <div class="col">
                        <label class="control-label">End Date</label>
                        <div class="input-group datefielddiv">
                            <% CommonFunctions.HTMLControls.DrawTextBox("txtEndDateFilter", "txtEndDateFilter", "form-control",, 50,,,,,,,,,,,,,,, True)%>
                            <span class="input-group-btn">
                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                            </span>
                        </div>
                    </div>
                    <div class="col-sm-2 text-center">
                        <label class="control-label d-block">&nbsp;</label>
                        <button id="btnFilter" class="btn btnyellow clearfix">Show</button>
                    </div>
                </div>
               
                <div class="clearfix"></div>
            </div>

        </div>


        <div class="resourceallocation_header container-fluid headertodisable">
            <div class="ganttactionbuttons">
                <div class="row">
                    <div class="col-sm-8">
                        <div class="buttons">

                            <ul class="nav ganttmainactionbtnlist">

                                <li>
                                    <%If m_DeleteAccess = True Then%>
                                    <button class="btn nostylebtn" id="btnMainDelete">
                                        <img src="../../../Whizible2.0-new/dist/img/trash.svg" height="24" data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_DeleteTask") %>"></button>
                                    <%End If %>
                                </li>

                                <li>
                                    <%If m_AddAccess = True Then%>
                                    <button class="btn nostylebtn" id="btnAddTasks">
                                        <img src="../../../Whizible2.0-new/dist/img/plus.svg" height="24" data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_Add") %>"></button>
                                    <%End If %>
                                    <!-- Taken from task modal -->
                                    <div id="wbscreatlist" class="modal fade custmodal" data-backdrop="static" data-keyboard="false">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="">Create List</h5>
                                                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">×</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Title</p>
                                                    <input type="text" name="" class="form-control">
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btnyellow" data-bs-dismiss="modal">Save</button>
                                                </div>
                                            </div>
                                            <!-- /.modal-content -->
                                        </div>
                                        <!-- /.modal-dialog -->
                                    </div>
                                    <!-- /.modal -->

                                </li>

                                <li class="dropdown">
                                    <div class="hrzntlSearch d-inline" id="divSearchBar">
                                        <input data-bs-toggle="dropdown" class="dropdown-toggle" id="wbssearchinputtasklist" autocomplete="off" type="text" name="search" placeholder="<%= MyBase.GetResourceString("C_Search") %>">
                                        <input type="hidden" id="wbssearchinputtasklistval" />

                                    </div>
                                </li>

                            </ul>

                        </div>
                    </div>
                    <%-- <div class="col-sm-4 pt-1 pb-1">
                        <ul class="float-end btnlistinline mt-0">
                            <li>
                                <button class="btn borderbtn">Back</button>
                            </li>
                            <li class="hidden-xs"></li>
                        </ul>

                    </div>--%>
                </div>
            </div>
        </div>


        <!-- Main content -->
        <section class="content bodybg horizanalscroll" id="sectionMain">

            <div class="clearfix"></div>

            <div class="scroller">
                <div id="wbswhizibletab" class="tab-slider--body2 ">
                    <div id="draggable-menu" class="tasksplitcontainer menu">
                        <%--dynamic content here--%>
                    </div>
                    <!--removed flex class by pradip on 16-01-2020-->
                </div>
            </div>
        </section>
        <!-- /.content -->
        <!-- Modal -->

        <div class="modal custmodal  fade" id="taskeditor" tabindex="-1" role="dialog" aria-labelledby="taskeditorlabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" role="document">
                <div class="modal-content">

                    <!--taskeditor modal popup start here-->
                    <div class="modal-header">
                        <%--  Added & Commented by dipali V On 21st Jan 2020 For Caption Change--%>
                        <%--  <h5 class="modal-title" id="">Task editor</h5>--%>
                        <h5 class="modal-title" id="TaskHeading"></h5>
                        <%--  End of Added & Commented by dipali V On 21st Jan 2020 For Caption Change--%>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs popupboxtabs">
                            <li id="liwbsbasic" class="active"><a href="#wbsbasic" data-bs-toggle="tab" class="active">Task Information</a>
                            </li>
                            <li id="liCDallattachments" class=""><a href="#CDallattachments" data-bs-toggle="tab">All Attachments</a>                                
                            </li>
                        </ul>
                        <div class="tab-content ">
                            <div class="tab-pane active" id="wbsbasic">
                                <div class="row">
                                    <div class="form-group d-flex">
                                        <div class="col-sm-4">
                                            <label class="required"><%= MyBase.GetResourceString("C_Task_Name")%></label>                                            
                                            <input type="hidden" id="hdnTaskID" />
                                            <input type="hidden" id="hdn_txtActualWork" />
                                            <input type="hidden" id="hdn_txtPlannedWork" />
                                            <input type="hidden" id="txthdnCurrentWork" />
                                            <input type="hidden" id="hdn_txtTaskEndDate" />
                                            <input type="hidden" id="hdn_txtTaskStartDate" />
                                            <input type="hidden" id="hdn_txtActualStartDate" />
                                            <input type="hidden" id="hdn_txtActualEndDate" />
                                            <input type="hidden" id="txthdnMilestone" />
                                            <input type="hidden" id="txthdnSubProject" />
                                            <input type="hidden" id="txthdnModule" />
                                            <input type="hidden" id="txthdnPhase" />
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", "form-control",, 255,,,,,,,, "autocomplete='off'",,,,,,, True)%>
                                        </div>
                                        <div class="col-sm-4">
                                            <label class="required"><%= MyBase.GetResourceString("C_Resource")%></label>
                                            <div class="row">
                                                <div class="col-sm-12">                                                   
                                                    <select class="form-control form-select" id="cboResource" name="cboResource" disabled></select>
                                                </div>                                               
                                            </div>
                                        </div>
                                        <div class="col-sm-4 ShowEstimationTypeInAT">
                                            <label class="EstimationTypeMandatoryInAT">Estimation Type</label>
                                            <select class="form-control form-select" id="cboEstimationType" name="cboEstimationType"></select>
                                        </div>
                                    </div>
                                    <div class="form-group d-flex">
                                        <div class="col-sm-4">
                                            <label class="required">Start Date</label>
                                            <div class="input-group">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate", "form-control",, 50,,,,,,,, "autocomplete='off'",,,,,,, True)%>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt" data-original-title="" title=""></i></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <label class="required">End Date</label>
                                            <div class="input-group">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control",, 50,,,,,,,, "autocomplete='off'",,,,,,, True)%>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt" data-original-title="" title=""></i></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 AgileDiv">
                                            <label class="" id="isAgilelabel">User Story</label>
                                            <div class="input-group-box">
                                                <select class="form-control form-select" id="cboUserStory" name="cboUserStory" onchange="GetSprintRelease($('#cboUserStory').val())"></select>
                                               
                                            </div>
                                          
                                        </div>
                                    </div>                                  
                                    <div class="form-group d-flex">
                                        <div class="col-sm-4 addtaskduration">
                                            <%--  //Added & Commented By Dipali v On 23rd Jan 2020 for caption change--%>
                                            <%--   <label class="">Duration (H:M)</label>--%>
                                            <label class="">Duration </label>
                                            <%-- // End of Added & Commented By Dipali v On 23rd Jan 2020 for caption change--%>
                                            <%--     <input type="text" class="form-control" value="03">--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtDuration", "txtDuration", "form-control",, 6,,,, True,,,, "autocomplete='off'",,,,,,, True)%>
                                        </div>
                                        <div class="col-sm-4">
                                            <label class="required">Work (H:M)</label>
                                            <%--<input type="text" class="form-control" value="03">--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtWorks", "txtWorks", "form-control",, 6,,,,,,,, "autocomplete='off'",,,,,,, True)%>
                                        </div>
                                        <div class="col-sm-4">
                                            <label class="required">Priority</label>
                                            <select class="form-control form-select" id="cboPriority" name="cboPriority"></select>
                                            <% 'CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_Whizible2_Sel_tbl_IB_Priorities ",,, "class='form-control Mandatory' ", True,, ) %>
                                        </div>
                                    </div>
                                    <div class="form-group d-flex">
                                        <div class="col-sm-8">
                                            <label class="">Description</label>
                                            <textarea class="form-control" id="txtTaskNotes" maxlength="1000" autocomplete='off'></textarea>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="row">
                                                <div class="col-sm-12 mb-10">
                                                    <label class="">&nbsp;</label>
                                                    <div class="custom_chckbox">
                                                        <input type="checkbox" id="chkBillable" class="">
                                                        <label for="chkBillable">Billable</label>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12">
                                                    <%--<label class="">&nbsp;</label>--%>
                                                    <div class="custom_chckbox">
                                                        <input type="checkbox" id="chkOnHold" class="">
                                                        <label for="chkOnHold">On Hold</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                   
                                    <!--Added by Omkar t on 16-01-20-->
                                    <div class="clearfix"></div>
                                    <div class="formcollapsible_panel mb-3">
                                        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                            <div class="panel panel-default">
                                                <div class="panel-heading" role="tab" id="headingTwo" >
                                                    <h4 class="panel-title">
                                                        <a class="collapsed" data-bs-toggle="collapse" data-parent="#accordion" href="#taskmapping" aria-expanded="false" aria-controls="taskmapping">Task Mapping
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="taskmapping" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                                    <div class="panel-body">
                                                        <div class="form-body">

                                                            <div class="row">
                                                                
                                                                <div class="col-sm-4 mb-15">
                                                                    <label class="required">Task Type</label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes_Names " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control'", False,, ) %>
                                                                    
                                                                </div>
                                                                <div class="col-sm-4 mb-15 ShowPhaseInAT">
                                                                    <label class="PhaseMandatoryInAT ">Phase</label>
                                                                    <select class="form-control form-select" id="cboPhase" name="cboPhase"></select>
                                                                    
                                                                </div>
                                                                
                                                                <div class="col-sm-4 mb-15 ShowMilestoneInAT">
                                                                    <label class="MilestoneMandatoryInAT">Milestone</label>
                                                                    <select class="form-control form-select" id="cboMilestone" name="cboMilestone"></select>
                                                                </div>
                                                                <div class="col-sm-4 mb-15">
                                                                    <label class="">Deliverable</label>
                                                                    <select class="form-control form-select" id="cboDeliverable" name="cboDeliverable"></select>
                                                                   
                                                                </div>
                                                               
                                                                <div class="col-sm-4 mb-15 ShowModuleInAT">
                                                                    <label class="ModuleMandatoryInAT">Module</label>
                                                                    <select class="form-control form-select" id="cboModule" name="cboModule"></select>
                                                                   
                                                                </div>
                                                                <div class="col-sm-4 mb-15 ShowSubProjectInAT">
                                                                    <label class="SubProjectMandatoryInAT">Sub Project</label>
                                                                    <select class="form-control form-select" id="cboSubProject" name="cboSubProject"></select>
                                                                   
                                                                </div>
                                                               
                                                                <div class="col-sm-4 mb-15 AgileDiv">
                                                                    <label class="">Release</label>
                                                                    <%--<input type="text" class="form-control" />--%>
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtRelease", "txtRelease", "form-control",, 8,,,, True,,,,,,,,,,, True)%>
                                                                </div>
                                                                <div class="col-sm-4 mb-15 AgileDiv">
                                                                    <label class="">Sprint</label>
                                                                    <%--<input type="text" class="form-control" />--%>
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtSprint", "txtSprint", "form-control",, 8,,,, True,,,,,,,,,,, True)%>
                                                                </div>
                                                                
                                                                <div class="col-sm-4 mb-15 ShowChangeRequestInAT">
                                                                    <label class="ChangeRequestMandatoryInAT">Change Request</label>
                                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequest", "usp_Whizible2_Sel_tbl_PM_ChangeRequest_Master " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control'", False,, ) %>
                                                                    
                                                                </div>
                                                                <div class="col-sm-4 mb-15 AgileDiv">
                                                                    <label class="" id="lbstorypoints">Story Point</label>
                                                                    <%--       <input type="text" class="form-control" />--%>
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control",, 8,,,,,,,, "autocomplete='off'",,,,,,, True)%>
                                                                    <input type="hidden" id="hdnstorypoints" />
                                                                </div>
                                                               
                                                                <div class="col-sm-4 mb-15 ShowFeatureInAT">
                                                                    <label class="FeatureMandatoryInAT">Feature</label>
                                                                    <select class="form-control form-select" id="cboFeature" name="cboFeature"></select>
                                                                </div>

                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <%--by vishal Mahajan temp--%>
                                            <div class="panel panel-default" >
                                                <div class="panel-heading" role="tab" id="headingTwo" style="display:none">
                                                    <h4 class="panel-title">
                                                        <a class="collapsed" data-bs-toggle="collapse" data-parent="#accordion" href="#AddnewSiteSheduleDetail" aria-expanded="false" aria-controls="AddnewSiteSheduleDetail">Custom Field
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="AddnewSiteSheduleDetail" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                                    <div class="panel-body">
                                                        <div class="form-body">
                                                            <div class="form-group" id="divCustomFields">
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Added by Omkar T on 16-01-20-->
                                    <div class="clearfix"></div>
                                    <div class="mt-1">
                                       <%-- Commented & Added By Dipali V On 20th Jan 2026 For Save button generic--%>
                                        <%--<button class="btn btnyellow" id="btnTaskSave">Save</button>--%>
                                        <button class="btn btn-primary-action" id="btnTaskSave"><i class="fas fa-save"></i> Save</button>
                                         <%--End of Commented & Added By Dipali V On 20th Jan 2026 For Save button generic--%>
                                        <button class="btn borderbtn float-end" data-bs-dismiss="modal">Cancel</button>
                                    </div>
                                    <!--End Added code by Omkar T on 16-01-20-->
                                </div>
                            </div>

                            <div class="tab-pane" id="CDallattachments">
                                <div class="commentboxbody">
                                    <div class="all_attachedfileslist col-sm-12">
                                        <table id="PRattachment" style="display: block; overflow-x: auto; white-space: nowrap;" class="table table-fixed-header table-bordered  table-outer table-stripped order_attchmentlist">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: left"><%= MyBase.GetResourceString("C_Document_Category") %></th>
                                                    <th style="text-align: left"><%= MyBase.GetResourceString("C_Document_Sub_Category") %></th>
                                                    <th style="text-align: left"><%= MyBase.GetResourceString("C_Document_Name") %></th>
                                                    <th style="text-align: left"><%= MyBase.GetResourceString("C_Description") %></th>

                                                    <th style="text-align: left"><%= MyBase.GetResourceString("C_File_Size") %></th>
                                                    <th style="text-align: left"><%= MyBase.GetResourceString("C_Upload_Date") %> </th>
                                                    <th style="text-align: left; width: 5%" class="text-start"></th>


                                                </tr>
                                            </thead>
                                            <tbody id="PRattachmentBody">
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                <td class="text-start">
                                                    <%If m_EditAccess = True Then%>
                                                    <button id="PRaddattachnebtrow" value="Add Row" class="btn borderbtn" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Add New Attachment">+ Add New Attachment</button>
                                                    <%End If %>
                                                </td>
                                                <td colspan="6">
                                                    <%If m_EditAccess = True Then %>
                                                    <button id="PRUpload" type="button" class="btn btnyellow ml-1 float-end" disabled>Upload</button>
                                                    <%End If %>
                                                </td>
                                                    </tr>
                                            </tfoot>
                                        </table>
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
        <!--Taskeditor modalpopup end here-->



        <!--Modal New Stage -->
        <div class="modal custmodal  fade" id="divAddStage" tabindex="-1" role="dialog" aria-labelledby="taskeditorlabel" aria-hidden="true">
            <input type="hidden" value="" id="hdnModalStage">
            <input type="hidden" value="" id="hdnModalOrder">
            <div class="modal-dialog modalsmall ui-draggable" role="document">
                <div class="modal-content" id="NewStageContent">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Add New Stage</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="tab-content ">
                            <div class="tab-pane active" id="wbsbasic">
                                <!--Edited by Omkar T on 16-01-20-->
                                <div class="row mb-3">
                                    <div class="col-sm-12 form-group mb-3">
                                        <div class="">
                                            <label class="control-label required">Stage Name</label>
                                            <textarea class="form-control" maxlength="50" id="txtStageName"></textarea>
                                        </div>
                                    </div>

                                    <%--<div class="form-group">&nbsp;</div>--%>
                                    <div class="clearfix"></div>
                                    <div class="col-sm-12">
                                        <%--added by Vishal M 13-01-2020--%>
                                        <button class="btn btnyellow" id="btnSaveStage" onclick="SaveStage(this.id)">Save</button>
                                        <%--<button class="btn borderbtn borderbtnfill" id="btnSaveStage" onclick="SaveStage(this.id)" data-bs-dismiss="modal">Save</button>--%>
                                        <button class="btn borderbtn float-end" data-bs-dismiss="modal">Cancel</button>
                                    </div>
                                </div>
                                <!--End Edited by Omkar T on 16-01-20-->

                            </div>
                            <!-- /.content -->


                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Modal End Here -->
            <div class="clearfix"></div>
        </div>

        <!--bootstrap_Alertify-->
        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg">
            <button type="button" id="btnCloseableAlert" onclick="CloseShowAlert()" class="close">×</button>
            <p id="alertMsg"></p>
        </div>


        <!-- DELETE task Modal Start here-->
        <div id="deletetaskmodal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" onclick="CancelDeleteTask();" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>

                    <div class="modal-body">
                        <p align="center">Are you sure you want to delete task ?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="CancelDeleteTask();" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteTask()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- DELETE task Modal End here-->

    </div>


    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js?v1"></script>--%>    
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-migrate-3.3.2.js"></script>--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
   <%-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
   <%-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>

    <script src="../../../Whizible2.0-new/dist/js/split.min.js"></script>
    <%--<script src="../../General/CommonFunctions.js"></script>
    <!--added by Vishal Mahajan 09-01-2020 -->
    <script src="../../General/CommonValidations.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/common_filters.js"></script>
    <%--<script src="../../../Whizible2.0-new/dist/js/bootstrap-multiselect.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

    <script type="text/javascript">
        //Added By Rehan C To check validation for Special characters  on 15th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var UserName = '<%= Session("strUserName") %>';
    //let LoginId = '<%= Session("intLoginID") %>';
        var LoginId = '<%= Session("intUserID") %>';
        //added by Vishal M
        var UserID = '<%= Session("intUserID") %>';

        var EditAccess = "";
        var DailyTask;
        var AddRole;
        var DeleteRole;
        let generatedToken;
        let isValid;
        let UploadedExcelContent;
        let divNewPosition;
        let divOldPosition;
        var list = new Array();
        var listRedo = new Array();
        var validRedoList = new Array();
        var m_AddAccess = "";
        var m_EditAccess = "";
        var m_DeleteAccess = "";
        var m_ViewAccess = "";
        var SelectedOptionsForUpload = new Array();
        var strMandatoryFields = ("Task Name,Resources,Start Date,End Date,Priority,Task Type,Work");
        var strMandatoryFieldsError = ("Task Name,Resources,Start Date,End Date,Priority,Task Type,Work");
        var MandatoryFields = new Array();
        var MandatoryFieldsError = new Array();
        MandatoryFields = strMandatoryFields.split(',');
        MandatoryFieldsError = strMandatoryFieldsError.split(',');
        //Added by Chetan M on 7th Feb 2020 for IssueID = 21651
        var GlobalTaskEmployeeID = 0;
        //End of Added by Chetan M on 7th Feb 2020 for IssueID = 21651


        /**
         * Created Date     :   17 Aug 2019.
         * Purpose          :   Onload function of page.
         * Author           :   Chandrashekhar Salagar.
         * */
        //get session project on load
        function GetSessionProject() {

            var userRoleAccess = '<%=m_roleLevel%>';
            m_AddAccess = '<%=m_AddAccess%>';
            m_EditAccess = '<%=m_EditAccess%>';
            m_DeleteAccess = '<%=m_DeleteAccess%>';
            m_ViewAccess = '<%=m_ViewAccess%>';
            var UserName = '<%= Session("strUserName") %>';
            var SessionProjectId = '<%= Session("intProjectID") %>';
            var SessionRoleId = '<%= Session("intPostID") %>';
            var LoginType = '<%= Session("LoginType") %>';
            var listRoleAccess = "";
            SetUserAccess(listRoleAccess)
            //CheckUserRole(22597, SessionRoleId);
            if (SessionProjectId.length) {
                GenerateToken(22597, SessionProjectId, '<%= Session("intUserID") %>');
                 ValidateToken(22597, $("#CboProject").val(), '<%= Session("intUserID") %>', generatedToken);
                 isValid == true;
                 if (isValid == true) {
                     //commented and added  by omkar 28/01/2020 for set SessionProjectID to cboProject
                     // $("#CboProject").val(SessionProjectId);
                     //alert(LoginType);
                     fillprojectname();
                     $('#CboProject option[value=' + SessionProjectId + ']').attr("selected", "selected");
                     //end of commented and added by omkar 28/01/2020 for set SessionProjectID to cboProject
                     $('#tabActive').css('tab-slider-trigger,.active');
                     $('#tabWhizibleTasks').css('tab-slider-trigger,.active');

                     //added by imran for filter Resource drop down
                     GetEmployees();
                     GetTaskTypes("LOAD");
                     CheckProjectOnHold();
                     getProjectDetails();
                     GetPriorities();
                     GetProjectPhases();
                     GetProjectDeliverables();
                     GetUserStories();
                     GetChangeRequest();
                     GetFeatures();
                     GetEstimationTypes();
                     //End of comment by imran on 24-02-2022

                     GetDefaultStages(SessionProjectId, 1, "");

                     //Commented by imran on 23-02-2022
                     //Added By Dipali V On 23rd Jan 2020 For Filter                   
                     //$("select #CboProject").change(CboProject_OnChange());
                 }
                 else {
                     //Added & Commented By Dipali V On 21st Jan 2020 For If Session was not there then error page redirect
                     // alert("Not a authorized person");
                     window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                     //End of Added & Commented By Dipali V On 21st Jan 2020 For If Session was not there then error page redirect
                 }
             }
             else {
                 showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
            }
        }

        //add by omkar 03/02/2020
        $(document).ready(function () {

            document.onkeyup = PresTab;
            function PresTab(e) {
                var keycode = (window.event) ? event.keyCode : e.keyCode;
                if (keycode == 9)
                    MouseClick();
            }
        });
        //end of add by omkar 03/02/2020


        /**
         * Created Date     :   17 Aug 2019.
         * Purpose          :   Generate token.
         * Author           :   Chandrashekhar Salagar.
         * @param tagId
         * @param projectID
         * @param userId
         */
        function GenerateToken(TagId, ProjectID, UserId) {
            tokenGeneration = {
                tagId: encodeURI(TagId),
                projectID: encodeURI(ProjectID),
                userId: encodeURI(UserId)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GenerateToken',
                type: "POST",
                data: JSON.stringify(tokenGeneration),
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (tokenGeneration) {
                        xhr.setRequestHeader("Params", encryptString(isJson(tokenGeneration) ? tokenGeneration : JSON.stringify(tokenGeneration)));
                    }
                },
                async: false,
                success: function (Token) {
                    generatedToken = Token;
                    //alert(generatedToken);
                },
                error: function (xhr, status, error) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                    //alert(err.Message);
                }
            })

        }

        /**
         * Created Date     :   17 Aug 2019
         * Purpose          :   Validate Token
         * Author           :   Chandrashekhar Salager
         * @param TagId
         * @param ProjectID
         * @param UserId
         * @param Token
         */
        function ValidateToken(TagId, ProjectID, UserId, Token) {
            validateToken = {
                tagId: encodeURI(TagId),
                projectID: encodeURI(ProjectID),
                userId: encodeURI(UserId),
                Token: encodeURI(Token)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/ValidateToken',
                type: "POST",
                data: JSON.stringify(validateToken),
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (validateToken) {
                        xhr.setRequestHeader("Params", encryptString(isJson(validateToken) ? validateToken : JSON.stringify(validateToken)));
                    }
                },
                async: false,
                success: function (xhr) {
                    isValid = true;
                    return xhr;
                },
                error: function (xhr, status, error) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                    //alert(err.Message);
                }
            })

        }

        //#region checkRoles
        // Should check user's role for this page to give access accordingly.
        function CheckUserRole(TagId, RoleID) {
            var roleAccess = {
                TagID: encodeURI(TagId),
                RoleID: encodeURI(RoleID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetRoleAccess',
                type: "POST",
                data: JSON.stringify(roleAccess),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (roleAccess) {
                        xhr.setRequestHeader("Params", encryptString(isJson(roleAccess) ? roleAccess : JSON.stringify(roleAccess)));
                    }
                },
                async: false,
                success: function (listRoleAccess) {
                    SetUserAccess(listRoleAccess)
                },
                error: function () {
                }
            })
        }
        //#endregion

        /**
         * Created Date :   16 Aug 2019
         * Purpose      :   To set access
         * Author       :   Chandrashekhar Salagar
         * @param listRoleAccess
         */
        function SetUserAccess(listRoleAccess) {
            //debugger;
            let AddAccess = m_AddAccess;
            EditAccess = "True"//m_EditAccess;
            AddRole = m_AddAccess;
            let DeleteAccess = m_DeleteAccess;
            DeleteRole = m_DeleteAccess;
            let ViewAccess = m_ViewAccess;

            if (ViewAccess == "False") {
                if (AddAccess == "False") {
                    $('#btnAddTasks').hide();
                    $('#btnExportLinks').hide();
                }
                else if (AddAccess == "True") {
                    $('#btnAddTasks').show();
                    $('#btnExportLinks').show();
                }
                else if (DeleteAccess == "False") {
                    $('#btnMainDelete').hide();
                }
                else if (DeleteAccess == "True") {
                    $('#btnMainDelete').show();
                }
            }
            else {

                if (AddAccess == "False") {
                    $('#btnAddTasks').hide();
                    $('#btnExportLinks').hide();
                }
                else {
                    $('#btnAddTasks').show();
                    $('#btnExportLinks').show();
                }
                if (DeleteAccess == "False") {
                    $('#btnMainDelete').hide();
                }
                else {
                    $('#btnMainDelete').show();
                }
                if (AddAccess == "False" && DeleteAccess == "False") {
                    $('li.gantticonseprtr').each(function (index) {
                        if (index >= 1) {
                            $(this).hide();
                        }
                    });
                }
            }
        }


        /** 
         *  Created Date    :   16 Aug 2019
         *  Purpose         :   Drop-down change event
         *  Author          :   Chandrashekhar Salagar
         */
        //#region Get Card Details
        function CboProject_OnChange() {
            list = [];
            listRedo = [];
            $("#wbssearchinputtasklist").val("")//added by dipali v on 21st jan 2020 for clear search value after project change
            enableDisabledControls();
            //list = "";
            GenerateToken(22597, $("#CboProject").val(), '<%= Session("intUserID") %>')
            ValidateToken(22597, $("#CboProject").val(), '<%= Session("intUserID") %>', generatedToken);

            if (isValid == true) {
                IsProjectOver = CheckProjectOver();
                CheckProjectOnHold(); //Added by Dipali V On 23rd Jan 2020 For Check PRoject On hold or not
                //added by Vishal Mahajan 08-01-2020
                GetEmployees();
                getProjectDetails();
                //isAgileMethodFollowed();
                GetPriorities();
                GetTaskTypes("LOAD");
                GetProjectPhases();
                GetProjectDeliverables();
                GetUserStories();
                GetChangeRequest();
                GetFeatures();
                GetEstimationTypes();

                var WhichTask;
                var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                var getClassName = $('#tabWhizibleTasks').attr('class');
                if (getClassName == "tab-slider--trigger active") {
                    WhichTask = "";
                }
                else {
                    WhichTask = "M";
                }

                if (ActiveTab == "tabActive") {
                    GetActiveTasks();
                    //Comment added by imran on 23-02-2022
                    //GetDefaultStages($("#CboProject").val(), 1, WhichTask);
                    //End Of Comment by imran on 23-02-2022
                    //alert(getClassName);
                }
                else if (ActiveTab == "tabAll") {
                    GetAllTasks();
                    //Comment added by imran on 23-02-2022
                    //GetDefaultStages($("#CboProject").val(), 0, WhichTask);
                    //End Of Comment by imran on 23-02-2022
                }

                if (getClassName == "tab-slider--trigger active") {
                    GetWhizibleTask();
                }
                else {
                    GetMPPTasks();
                }

                if (IsProjectOver == 1) {
                    $("#btnAddTasks").prop("disabled", true);
                    $("#btnMainDelete").prop("disabled", true);
                    $("#btnSaveStage").prop("disabled", true);
                    $("#btnimport").prop("disabled", true);
                } else {
                    $("#btnAddTasks").prop("disabled", false);
                    $("#btnMainDelete").prop("disabled", false);
                    $("#btnSaveStage").prop("disabled", false);
                    $("#btnimport").prop("disabled", false);
                }
                //Added By Dipali V On 10th Feb 2020 For Filter Clear onchange of Project
                $("#TaskClearAllFilter").css("display", "none");
                $("#AdvanceFilterIcon").removeClass("filteractive");
                //End of Added By Dipali V On 10th Feb 2020 For Filter Clear onchange of Project
            }
            else {
                alert("Not a valid request");
            }

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
        }
        //#endregion

        function RefreshList() {
            var WhichTask;
            var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
            var getClassName = $('#tabWhizibleTasks').attr('class');
            if (getClassName == "tab-slider--trigger active") {
                WhichTask = "";
            }
            else {
                WhichTask = "M";
            }
            if (ActiveTab == "tabActive") {
                GetDefaultStages($("#CboProject").val(), 1, WhichTask);
                //alert(getClassName);
            }
            else if (ActiveTab == "tabAll") {
                GetDefaultStages($("#CboProject").val(), 0, WhichTask);
            }
        }

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   Ajax call to get all project task of logged in user.
         * Author           :   Chandrashekhar Salagar.
         * @param TaskStatus
         * @param WhichTask
         */
        //#region GetProjectTasks
        var PM_wbs_card_forReport;
        var GlobalWhichTask = '';
        function GetProjectTasks(TaskStatus, WhichTask, userRoleAccess, EmployeeID, TaskTypeID, StartDate, EndDate) {
            //debugger;           
            GlobalWhichTask = WhichTask;
            var wbssearchinputtasklist = $("#wbssearchinputtasklist").val();
            var ProjectID = $('select#CboProject option:selected').val();
            //alert(ProjectID);
            if (ProjectID != "") {//Added by Dipali V On 25th Jan 2020 for If Selected project Close then Page crash

                //Added by imran on 14-09-2022
                if (EmployeeID == "") {
                    EmployeeID = 0;
                }
                if (TaskTypeID == "") {
                    TaskTypeID = 0;
                }
                //End of comment by imran on 14-09-2022

                var PM_wbs_card = {
                    ProjectID: encodeURI(ProjectID),
                    IsActive: encodeURI(TaskStatus),
                    WhichTask: encodeURI(WhichTask),
                    LoginID: encodeURI(EmployeeID),
                    RoleAccess: encodeURI(userRoleAccess),
                    TaskTypeID: TaskTypeID,
                    StartDate: encodeURI(StartDate),
                    EndDate: encodeURI(EndDate),
                };

                PM_wbs_card_forReport = PM_wbs_card;
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_wbs_card/getProjectTasks',
                    type: "POST",
                    data: JSON.stringify(PM_wbs_card),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PM_wbs_card) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PM_wbs_card) ? PM_wbs_card : JSON.stringify(PM_wbs_card)));
                        }
                    },
                    async: false,
                    success: function (projectTasklist) {

                        //Added By Chetan M on 14th feb 2020 for IssueID = 21829
                        TasksForSearch(projectTasklist);
                        //End of added By Chetan M on 14th feb 2020 for IssueID = 21829
                        if (projectTasklist.length == 0) {
                            $("#btnMainDelete").addClass("disabledbutton");
                        } else {
                            $("#btnMainDelete").removeClass("disabledbutton");
                        }
                        var taskName = new Array();
                        var taskId = new Array();
                        /* $("div.draggable-menu").html("");*///Clear dom contents to set project task.
                        $("div.draggable-menu").html("");
                        //Added By Usha Pandit On 30.08.2020 For display message when no matching records are found as per filter applied
                        if (projectTasklist.length == 0) {
                            //Added By Usha Pandit On 02.12.2020 For duplicate plotting for no records message
                            $("#draggable-menu").children("div[id=norecorddiv]:last").remove();
                            //End Of Added By Usha Pandit On 02.12.2020 For duplicate plotting for no records message
                            $('#draggable-menu').append("<div id='norecorddiv' style='margin-top:2%'><b>There are no records to show<b></div>");
                            $("*[id*=Stage]").addClass("clsStage");
                            $("#wbswhizibletab").addClass("clswbswhizibletab");
                            $("#draggable-menu").addClass("clsdraggable-menu");
                        }
                        else {
                            if ($('#draggable-menu').children(":last").attr("id") == "norecorddiv") {
                                $('#draggable-menu').children(":last").remove();
                            }
                            $("*[id*=Stage]").removeClass("clsStage");
                            $("#wbswhizibletab").removeClass("clswbswhizibletab");
                            $("#draggable-menu").removeClass("clsdraggable-menu");
                        }
                        //End Of Added By Usha Pandit On 30.08.2020 For display message when no matching records are found as per filter applied

                        for (var i = 0; i < projectTasklist.length; i++) {
                            if (wbssearchinputtasklist != "") {
                                if (String(projectTasklist[i].TaskName).indexOf(wbssearchinputtasklist) == -1 && String(projectTasklist[i].ActualStartDate).indexOf(wbssearchinputtasklist) == -1) {
                                    continue;
                                }
                            }

                            taskName.push(projectTasklist[i].TaskName);
                            taskId.push(projectTasklist[i].TaskID);
                            if (projectTasklist[i].ActualStartDate == "") {// Actual start date is not available yhen it will be Task TaskToDo
                                try {
                                    //debugger;
                                    DrawTaskToDo(projectTasklist[i]);
                                } catch (ex) {
                                    //alert(ex)

                                }
                            }
                            else if (projectTasklist[i].ActualStartDate != "" && projectTasklist[i].IsTaskComplete == "0") {
                                // if actual start date is ther and completed flag is false then it will task iin progress.
                                try {
                                    DrawTaskInProgress(projectTasklist[i]);
                                } catch (ex) {
                                    //alert(ex)

                                }
                            }

                            else if (projectTasklist[i].IsTaskComplete == "1") {// if IsTaskComplete is true then it is completed task. 
                                try {
                                    DrawCompletedTasks(projectTasklist[i])
                                } catch (ex) {
                                    // alert(ex)

                                }
                            }
                            else if (projectTasklist[i].MasterStageID == "4") {
                                //all custome task between in progress and yet to complete.
                                DrawCustomTaks(projectTasklist[i])
                            }


                        }
                       
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $('[data-bs-toggle="popover"]').popover();

                        if (m_EditAccess == "True") {
                            $(".editTask").show();
                        } else {
                            $(".editTask").hide();
                        }
                        enableDisabledControls();
                        if (projectTasklist.length == 0) {
                            $("#btnMainDelete").addClass("disabledbutton");
                        } else {
                            $("#btnMainDelete").removeClass("disabledbutton");
                        }

                        // Addded by Chetan M on 12th Feb 2020 for IssueID = 21838                       
                        if (m_ViewAccess == "False") {
                            $(".flagdetailpoover").hide();
                        }
                        else {
                            $(".flagdetailpoover").show();
                        }
                        if (m_AddAccess == "False" && m_EditAccess == "False") {
                            $(".setAccessClass").hide();
                            $(".unFlagSetAccessClass").hide();
                        }
                        else {
                            $(".setAccessClass").show();
                        }
                        IsProjectOver = CheckProjectOver();
                        if (IsProjectOver == 1) {
                            $(".setAccessClass").hide();
                            $(".unFlagSetAccessClass").hide();
                            $("#btnAddTasks").prop("disabled", true);
                            $("#btnMainDelete").prop("disabled", true);
                            $("#btnSaveStage").prop("disabled", true);
                            $("#btnimport").prop("disabled", true);
                        }
                        //End of Addded by Chetan M on 12th Feb 2020 for IssueID = 21838
                    },
                    error: function (result) {
                        console.log(result);
                    }
                });
            }
        }
        //#endregion

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will draw all task to do.
         * Author           :   Chandrashekhar Salagar
         * @param Projectlist
         */
        //#region drawTasks
        function DrawTaskToDo(Projectlist) {
            var dbStartDate = "";
            var dbActualStartDate = "";
            var dbEndDate = "";
            var EndDate = "";
            var dbActulaEndDate = "";
            var ActualEndDate = "";
            var EndDate = "";
            var startDate = "";
            var actualStartDate = "";
            var TaskCss = "";
            var StartGetTime = "";
            var EndGetTime = "";
            var TaskFlagCss = "";
            //get start date and actual start date for comparing.                
            var today = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());

            if (Projectlist.StartDate != "") {
                dbStartDate = Projectlist.StartDate.split("/");
                startDate = new Date(dbStartDate[2], dbStartDate[1] - 1, dbStartDate[0]);

                StartGetTime = startDate.getTime()
                // startDate = Projectlist.StartDate;
            }

            if (Projectlist.ActualStartDate != "") {
                dbActualStartDate = Projectlist.ActualStartDate.split("/");
                actualStartDate = new Date(dbActualStartDate[2], dbActualStartDate[1] - 1, dbActualStartDate[0]);

                GetActualTime = actualStartDate.getTime();
                //actualStartDate = Projectlist.ActualStartDate;
            }

            if (Projectlist.EndDate != "") {
                dbEndDate = Projectlist.EndDate.split("/");
                EndDate = new Date(dbEndDate[2], dbEndDate[1] - 1, dbEndDate[0]);

                EndGetTime = EndDate.getTime()
                //EndDate = Projectlist.EndDate;
            }
            //alert(EndDate);
            //return;
            if (Projectlist.ActualEndDate != "") {
                dbActulaEndDate = Projectlist.ActualEndDate.split("/");
                ActualEndDate = new Date(dbActulaEndDate[2], dbActulaEndDate[1] - 1, dbActulaEndDate[0]);
            }

            if (Projectlist.ActualStartDate != "") {
                dbActualStartDate = Projectlist.ActualStartDate.split("/");
                actualStartDate = new Date(dbActualStartDate[2], dbActualStartDate[1] - 1, dbActualStartDate[0]);
            }
            //debugger;
            //Start of task is today but thre is no actual start.//
            if ((today.getTime() == StartGetTime) && actualStartDate == "") {
                TaskCss = "taskcardbox taskcardbox_todo Amber";
            }

            //End of task is today but there is no actual end.//
            else if ((today.getTime() == EndGetTime) && ActualEndDate == "") {
                TaskCss = "taskcardbox taskcardbox_todo Amber";
            }
            else if ((actualStartDate > startDate)) {
                TaskCss = "taskcardbox taskcardbox_todo Amber";
            }
            //Did not start yet (Start date of task is less than todays.) ||  Did not end (End date is less than today.)  //
            else if (((today.getTime() > StartGetTime) && actualStartDate == "") || ((today.getTime() > EndGetTime) && ActualEndDate == "")) {
                TaskCss = "taskcardbox taskcardbox_todo Red";
            }

            else {
                TaskCss = "taskcardbox taskcardbox_todo Amber";
            }



            //#region DynamicContent
            var EmployeeName = Projectlist.EmployeeName;
            var empShotName;
            var TaskColor;
            var editIconStyle = "";
            var cssInactive = "";
            var cssPriority = "";
            var Priority = "";
            var IsvoidTask = "NovoidTask";
            var IsDisabled = "";
            // debugger;
            //Added & Commented By Dipali V On 21st Jan 2020 For Short Name 
            //var arrEmployeeName = EmployeeName.split(' ');
            //if (arrEmployeeName.length == 2) {
            //    empShotName = arrEmployeeName[0].charAt(0) + arrEmployeeName[1].charAt(0);
            //}
            //else {
            //    empShotName = EmployeeName;
            //}
            //End of Added & Commented By Dipali V On 21st Jan 2020 For Short Name 
            empShotName = getShortName(EmployeeName);
            if (Projectlist.Priority.toLowerCase() == "high" || Projectlist.Priority.toLowerCase() == "critical") {
                //Priority = "critical";
                cssPriority = "high";
            }
            else if (Projectlist.Priority.toLowerCase() == "medium") {
                cssPriority = "medium";
                Priority = "medium";

            }
            else if (Projectlist.Priority.toLowerCase() == "low" || Projectlist.Priority.toLowerCase() == "minor") {
                cssPriority = "low";

            }
            // Added by Dipali V On 23rd Jan 2020 For priority Issues
            else if (Projectlist.Priority.toLowerCase() == "") {
                cssPriority = "NotSet";
                Projectlist.Priority = "Priority Not Set";

            }
            else {
                cssPriority = "NotSet";
                Projectlist.Priority = Projectlist.Priority;
            }
            //End of Commented by Dipali V On 23rd Jan 2020 For priority Issues
            //Commented by Dipali V On 23rd Jan 2020 For priority Issues
            if (Projectlist.IsActive == "False") {
                cssInactive = " style='background-color: #cccccc;'";
                IsvoidTask = "YesvoidTask";//Added By Dipali V On 24th Jan 2020 Void Task Should not get Dragged
                IsDisabled = "Disabled";
                // $(".flagdetailswrap > div.form-group.text-center > button").prop("disabled", true)

            }

            if (Projectlist.IsTaskComplete == "True" || Projectlist.IsTaskComplete == "1") {
                IsDisabled = "Disabled";

            }
            //debugger;
            // alert(Projectlist.WhichTask);
            if (m_EditAccess == "False" || Projectlist.WhichTask == "M") {
                editIconStyle = "style=display:none";
            }
            //Commented and added by Chetan M on 7th Feb 2020 for IssueID = 21651
            var myvar = '<div class="' + IsvoidTask + ' ' + TaskCss + ' gist taskcardboxActive" id="' + Projectlist.TaskID + '"> <input type="hidden" value=' + Projectlist.StageID + ' id=hdnStageId' + Projectlist.TaskID + '> <input type="hidden" value=' + Projectlist.TaskID + ' id= hdnTaskId' + Projectlist.TaskID + '> <input type="hidden" value=' + Projectlist.EmployeeID + ' id= hdnEmployeeID' + Projectlist.TaskID + '>' +
                //var myvar = '<div class="' + IsvoidTask + ' '  + TaskCss + ' gist taskcardboxActive" id="' + Projectlist.TaskID + '"> <input type="hidden" value=' + Projectlist.StageID + ' id=hdnStageId' + Projectlist.TaskID + '> <input type="hidden" value=' + Projectlist.TaskID + ' id= hdnTaskId' + Projectlist.TaskID + '>' +
                //End of Commented and added by Chetan M on 7th Feb 2020 for IssueID = 21651
                '                            <div class="card gist-data"' + cssInactive + '>' +
                '                                <div class="card-body">' +
                //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21828
                //'                                    <div class="card-heading">' + Projectlist.SubTaskTypes + ' ' +
                '                                    <div class="card-heading">' +
                //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21828
                '                                        <!-- <label class="rank float-end mb-0">1.1.1</label> -->' +
                '                                        <div class="clearfix"></div>' +
                '                                        <span class="prioritylabel prioritylabel' + cssPriority + '">' + Projectlist.Priority + '</span>' +
                '                                    </div>' +
                '                                    <h4 class="card-title">' + Projectlist.TaskName + '</h4>' +
                '                                    <div class="mb-10 cardtask_duration">' +
            '                                        <span><%= MyBase.GetResourceString("C_StartDate") %> :  ' + Projectlist.StartDate + ' </span>' +
            '                                       <b><a href=""> <span class="float-end"  data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_PlanningHours") %>" style=color:black>' + Projectlist.WorkInHours + '</span></a> </b>' +
                '                                    </div>' +
                '                                    <div class="cardtask_duration">' +
            '                                        <span><%= MyBase.GetResourceString("C_EndDate") %> :  ' + Projectlist.EndDate + ' </span>' +
                '                                        <span class="float-end">' + Projectlist.DaysRemaining + ' Day(s)</span>' +
                '                                    </div>' +
                '                                </div>' +
                '                                <div class="cardfooter">' +
                '                                    <div class="cardresource float-start">' +
                '                                        <a href=""><span data-bs-toggle="tooltip" data-title="' + Projectlist.EmployeeName + '" class="usernameshort circle-bggreen usernamecirclesmall" data-bs-original-title="' + Projectlist.EmployeeName + '" title="">' + empShotName + '</span></a>' +
                '                                        <!--  <a href=""><span data-bs-toggle="tooltip" data-title="John Smith" class="usernameshort circle-bgblue usernamecirclesmall" data-original-title="" title="">JS</span></a>' +
                '                                          <a href=""><span data-bs-toggle=tooltip" data-title=' + empShotName + ' class="usernameshort circle-bgorange usernamecirclesmall" data-original-title="" title="">' + empShotName + '</span></a> -->' +
                '                                    </div>' +
                '                                    <ul class="cardresource_actionbuttons">' +
                '                                        <li><a href="">' +
                '                                            <!-- <img data-bs-toggle="tooltip" data-bs-placement="top" title="Flag" src="dist/img/flag.svg" width="18" alt=""> -->' +
                '                                           <!-- <img data-bs-toggle="tooltip" data-bs-placement="top" title="Priority" src="../../../Whizible2.0-new/dist/img/priority.svg" width="16" alt=""></a></li>-->' +
                '                                        <li class="flagdetailpoover dropdown keep-inside-clicks-open">' +
                '                                            <a href="" class="Tskflag dropdown-toggle" data-bs-toggle="dropdown" data-original-title="" title="" data-bs-auto-close="false" aria-expanded="true" id="flagdetails"><i data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_FlagView") %>" class="far fa-flag" id="Flagid_' + Projectlist.TaskID + '"  onclick="GetFlagDetails(' + Projectlist.TaskID + ')" ></i><i class="fas fa-flag" id="FlagidNw_' + Projectlist.TaskID + '"></i></a>' +
                '' +
                '                                            <ul id="ul_' + Projectlist.TaskID + '" class="dropdown-menu flagdetailswrap">' +
                '                                                <div class="form-group mb-3">' +
                '                                                    <select id="wbsfdselect1" class="form-control form-select ">' +
                '                                                        <option>Review</option>' +
                '                                                        <option>Follow Up</option>' +
                '                                                    </select>' +
                '                                                </div>' +
                '' +
                '                                                <div class="form-group mb-3">' +
                '' +
                '                                                    <div class="input-group datefielddiv">' +
                //Commented And Added By Usha Pandit On 27.08.2020 For preventing to enter text in date picker 
                //<input id="duedate_' + Projectlist.TaskID + '" type="text" class="form-control" autocomplete="off" onPaste="return false" onkeypress="return Date_OnKeyPress(event)">' +
                '                                                        <input id="duedate_' + Projectlist.TaskID + '" type="text" readonly class="form-control" autocomplete="off" onPaste="return false" onkeypress="return Date_OnKeyPress(event)">' +
                //End Of Added By Usha Pandit On 27.08.2020 For preventing to enter text in date picker 
                '                                                        <input id="TaskFlagID_' + Projectlist.TaskID + '" type="hidden" class="form-control">' +
                '                                                        <span class="input-group-btn">' +
                '                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>' +
                '                                                        </span>' +
                '                                                    </div>' +
                '                                                </div>' +
                '' +
                '                                                <div class="form-group text-center">' +
                //Commented and Addded by Chetan M on 12th Feb 2020 for IssueID = 21838
                //'                                                    <button class="btn btnyellow" data-bs-dismiss="popover" id="BtnUnflag_' + Projectlist.TaskID + '" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',0)" >Unflag</button>' +
                //'                                                    ' +
                //'                                                    <button class="btn btnyellow" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',1)">Save</button>' +
                '                                                    <button class="btn btnyellow unFlagSetAccessClass ' + IsDisabled + '"  data-bs-dismiss="popover" id="BtnUnflag_' + Projectlist.TaskID + '" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',0,&quot;' + Projectlist.EndDate + '&quot,&quot;' + Projectlist.startDate + '&quot;)">Unflag</button>' +
                '                                                    ' +
                '                                                    <button class="btn btnyellow setAccessClass ' + IsDisabled + '" id="saveBtnUnflag_' + Projectlist.TaskID + '"  onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',1,&quot;' + Projectlist.EndDate + '&quot;,&quot;' + Projectlist.startDate + '&quot;)">Save</button>' +
                //End of Commented and Addded by Chetan M on 12th Feb 2020 for IssueID = 21838
                '                                                </div>' +
                '                                            </ul>' +
                '' +
                '                                        </li>' +
                '                                         <li class="flagdetailpoover dropdown keep-inside-clicks-open">' +
                '                                            <a href="" class="Tskflag dropdown-toggle" data-bs-toggle="dropdown" data-original-title="" data-bs-auto-close="false" title="" aria-expanded="true" id="wbstasknote"><i data-bs-toggle="tooltip" data-bs-placement="top" title="Note" class="far fa-list-alt"></i> </a>' +
                '' +
                '                                            <ul id="" class="dropdown-menu flagdetailswrap">' +
                '                                            <div id = "popover-content-wbstasknote" Class="form-group">' +
            '                                        <strong><%= MyBase.GetResourceString("C_Note") %> : </strong>' + Projectlist.TaskNotes +
                '                                            </div>' +
                '                                            </ul>' +
                '' +
                '                                        </li>' +
                // Added by Vishal Mahajan 08-01-2020
                //'                                        <li ' + editIconStyle + '><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#taskeditor">' +
                //Commented & Added By Dipali V On 11th June 2020 For JS Issuess
                // <li ' + editIconStyle + ' class="editTask"><a href="javascript:;" data-bs-toggle="modal"  onclick="editTask(' + Projectlist.TaskID + ')">' +
                '                                        <li ' + editIconStyle + ' class="editTask"><a data-bs-toggle="modal"  onclick="editTask(' + Projectlist.TaskID + ')">' +
                //End of Commented & Added By Dipali V On 11th June 2020 For JS Issuess
            '                                            <img data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_Edit") %>" src="../../../Whizible2.0-new/dist/img/edit.svg" width="18" alt=""></a></li>' +
                '                                    </ul>' +
                '                                    <div class="clearfix"></div>' +
                '                                </div>' +
                '                            </div>' +
                '                            <!-- <div class="taskcard_phase"><label>Milestone I</label></div> -->' +
                '                        </div>';
            //#endregion
            //Added By Dipali V on 10th Feb 2020 For Duplidate Task display issues
            $('#Stage' + Projectlist.StageID + '').append("");
            //End of Added By Dipali V on 10th Feb 2020 For Duplidate Task display issues

            $('#Stage' + Projectlist.StageID + '').append(myvar);
            //debugger;
            //alert(IsvoidTask);
            if (IsvoidTask == "YesvoidTask") {
                // $('#saveBtnUnflag_' + Projectlist.TaskID + '').prop("disabled", true)
                // $('#BtnUnflag_' + Projectlist.TaskID + '').prop("disabled", true)
            }
            //} else {
            //    $(".flagdetailswrap > div.form-group.text-center > button").prop("disabled", false)
            //}
            $("#ul_" + selectedDivID).css("display", "none");
            CustomDueDatePicker(Projectlist.TaskID);//Added By Dipali V On 25th Jan 2020 For Datepicker
            //GetFlagDetails(Projectlist.TaskID)//Added By Dipali V On 25th Jan 2020 for Flag Details

        }

        //Added & Commented By Dipali V On 21st Jan 2020 For Short Name 

        function getShortName(fullName) {
            if (fullName != "") { //Added By Usha Pandit On 28.08.2020 For javascript error
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
                        //Added By Usha Pandit On 28.08.2020 For javascript error
                        if ((details1[details1.length - 1][0]) == undefined) {
                            shortName = "";
                        }
                        else {
                            //End Of Added By Usha Pandit On 28.08.2020 For javascript error
                            shortName = (details1[details1.length - 1][0]).toString().toUpperCase();
                        }
                    }
                    else {
                        //Added By Usha Pandit On 28.08.2020 For javascript error
                        if ((details1[details1.length - 1][0]) == undefined) {
                            shortName = (details1[0][0]).toString().toUpperCase();
                        }
                        else {
                            //End Of Added By Usha Pandit On 28.08.2020 For javascript error
                            shortName = (details1[0][0]).toString().toUpperCase() + (details1[details1.length - 1][0]).toString().toUpperCase();
                        }
                    }
                }
                return shortName;
            }
            //Added By Usha Pandit On 28.08.2020 For javascript error
            else
                return "";
            //End Of Added By Usha Pandit On 28.08.2020 For javascript error
        }

        //End of Added & Commented By Dipali V On 21st Jan 2020 For Short Name 

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will draw all the task which are in progress.
         * Author           :   chandrashekhar Salagar
         * @param Projectlist
         */
        function DrawTaskInProgress(Projectlist) {
            var TaskCss = "";
            if (Projectlist.TaskID == 30373)

                var dbStartDate = "";
            var dbActualStartDate = "";
            var startDate = "";
            var actualStartDate = "";
            var StartGetTime = "";
            var GetActualTime = "";
            var dbEndDate = "";
            var EndDate = "";
            var dbActulaEndDate = "";
            var ActualEndDate = "";
            var TaskFlagCss = "";
            //get start date and actual start date for comparing.                
            var today = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());
            if (Projectlist.StartDate != "") {
                dbStartDate = Projectlist.StartDate.split("/");
                startDate = new Date(dbStartDate[2], dbStartDate[1] - 1, dbStartDate[0]);
                StartGetTime = startDate.getTime()
            }

            if (Projectlist.ActualStartDate != "") {
                dbActualStartDate = Projectlist.ActualStartDate.split("/");
                actualStartDate = new Date(dbActualStartDate[2], dbActualStartDate[1] - 1, dbActualStartDate[0]);
                GetActualTime = actualStartDate.getTime();
            }


            if (Projectlist.EndDate != "") {
                dbEndDate = Projectlist.EndDate.split("/");
                EndDate = new Date(dbEndDate[2], dbEndDate[1] - 1, dbEndDate[0]);
                EndGetTime = EndDate.getTime()
            }

            if (Projectlist.ActualEndDate != "") {
                dbActulaEndDate = Projectlist.ActualEndDate.split("/");
                ActualEndDate = new Date(dbActulaEndDate[2], dbActulaEndDate[1] - 1, dbActulaEndDate[0]);
                getActulaEndTime = ActualEndDate.getTime();
            }

            //  1) For tasks in progress first condition i.e. no actual start will not be applicable///

            //  2) Planned end date is today and there is no actual end date //
            if ((today.getTime() == EndGetTime) && ActualEndDate == "") {
                TaskCss = "taskcardbox taskcardbox_todo Amber";
            }


            else if ((actualStartDate > startDate)) {
                TaskCss = "taskcardbox taskcardbox_todo Amber";
            }
            //  3) for task in progress "did not start condition" will not be applicable//

            //  4) Planned end date is less than today and there is no actual end date i.e.Did not end//

            else if (((today.getTime() > EndGetTime) && ActualEndDate == "") || (GetActualTime > StartGetTime) ||
                (parseInt(Projectlist.WorkInHours) > parseInt(Projectlist.ActualWork))) {
                TaskCss = "taskcardbox taskcardbox_todo Red";
            }
            //  8) Actual start date is less than planned start date. i.e. Started early//
            else if (GetActualTime < StartGetTime) {
                TaskCss = "taskcardbox taskcardbox_todo Green";
            }
            ////Actual start end is less than planned end date. i.e. Ended early//
            //if (getActulaEndTime <= EndGetTime) {
            //    TaskCss = "taskcardbox taskcardbox_todo Green";
            //}

            //#region Dynamic Content
            var EmployeeName = Projectlist.EmployeeName;
            var empShotName;
            var Priority = "inprogress";
            var cssPriority;
            var editIconStyle = '';
            var cssInactive = "";
            var IsvoidTask = "NovoidTask";//Added By Dipali V On 24th jan 2020 For maintain Void task Flag And Draggable
            var IsDisabled = "";
            //Added & Commented By Dipali V On 21st Jan 2020 For Short Name 
            //var arrEmployeeName = EmployeeName.split(' ');
            //if (arrEmployeeName.length == 2) {
            //    empShotName = arrEmployeeName[0].charAt(0) + arrEmployeeName[1].charAt(0);
            //}
            //else {
            //    empShotName = EmployeeName;
            //}
            //End of Added & Commented By Dipali V On 21st Jan 2020 For Short Name 
            empShotName = getShortName(EmployeeName);
            if (Projectlist.Priority.toLowerCase() == "high" || Projectlist.Priority.toLowerCase() == "critical") {
                Priority = "critical";
                cssPriority = "high";
            }
            else if (Projectlist.Priority.toLowerCase() == "medium") {
                cssPriority = "medium";
                Priority = "medium";

            }
            else if (Projectlist.Priority.toLowerCase() == "low" || Projectlist.Priority.toLowerCase() == "minor") {
                cssPriority = "low";

            }
            // Added by Dipali V On 23rd Jan 2020 For priority Issues
            else if (Projectlist.Priority.toLowerCase() == "") {
                cssPriority = "NotSet";
                Projectlist.Priority = "Priority Not Set";

            }
            else {
                cssPriority = "NotSet";
                Projectlist.Priority = Projectlist.Priority;
            }
            //End of Commented by Dipali V On 23rd Jan 2020 For priority Issues
            //Commented by Dipali V On 23rd Jan 2020 For priority Issues
            if (Projectlist.IsActive == "False") {
                cssInactive = " style='background-color: #cccccc;'";
                IsvoidTask = "YesvoidTask";//Added By Dipali V On 24th Jan 2020 Void Task Should not get Dragged
                IsDisabled = "Disabled";
                //$(".flagdetailswrap > div.form-group.text-center > button").prop("disabled", true)

            } else {
                $//(".flagdetailswrap > div.form-group.text-center > button").prop("disabled", false)
            }

            if (Projectlist.IsTaskComplete == "True" || Projectlist.IsTaskComplete == "1") {
                IsDisabled = "Disabled";

            }
            if (m_EditAccess == "False" || Projectlist.WhichTask == "M") {
                editIconStyle = "style=display:none"
            }


            ////Added BY Dipali V On 12th Feb 2020 For Flag Color change
            //var Enddate = EndDate.toShortFormat();
            //var today = today.toShortFormat();
            //if (Date.parse(Enddate) < Date.parse(today)) {
            //    TaskFlagCss = "FlagColor_Red";
            //} else {
            //     TaskFlagCss = "FlagColor_Green";

            //}
            // //End of Added BY Dipali V On 12th Feb 2020 For Flag Color change



            var myvar = '<div class="taskcardbox taskcardbox_' + Priority + ' ' + TaskCss + ' gist taskcardboxActive ' + IsvoidTask + '" id="' + Projectlist.TaskID + '"> <input type="hidden" value=' + Projectlist.StageID + ' id=hdnStageId' + Projectlist.TaskID + '><input type="hidden" value=' + Projectlist.TaskID + ' id= hdnTaskId' + Projectlist.TaskID + '> <input type="hidden" value=' + Projectlist.EmployeeID + ' id= hdnEmployeeID' + Projectlist.TaskID + '>' +
                '                            <div class="card gist-data "' + cssInactive + '>' +
                '                                <div class="card-body">' +
                //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21828
                //'                                    <div class="card-heading">' + Projectlist.SubTaskTypes + '' +
                '                                    <div class="card-heading">' +
                //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21828
                '                                        <!-- <label class="rank float-end mb-0">2.1.2</label> -->' +
                '                                        <div class="clearfix"></div>' +
                '                                        <span class="prioritylabel prioritylabel' + cssPriority + '">' + Projectlist.Priority + '</span>' +
                '                                    </div>' +
                '                                    <h4 class="card-title">' + Projectlist.TaskName + '</h4>' +
                '                                    <div class="mb-10 cardtask_duration">' +
                '                                        <span><%= MyBase.GetResourceString("C_StartDate") %> :  ' + Projectlist.StartDate + ' </span>' +
                '                                       <b><a href=""> <span class="float-end"  data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_PlanningHours") %>" style=color:black>' + Projectlist.WorkInHours + '</span></a> </b>' +
                '                                    </div>' +
                '                                    <div class="cardtask_duration">' +
                '                                        <span><%= MyBase.GetResourceString("C_EndDate") %> : ' + Projectlist.EndDate + '</span>' +
                '                                        <span class="float-end">' + Projectlist.DaysRemaining + ' Day(s)</span>' +
                '                                    </div>' +
                '                                </div>' +
                '                                <div class="cardfooter">' +
                '                                    <div class="cardresource float-start">' +
                '                                        <a href=""><span data-bs-toggle="tooltip" data-title="' + Projectlist.EmployeeName + '" class="usernameshort circle-bggreen usernamecirclesmall" data-bs-original-title="' + Projectlist.EmployeeName + '" title="">' + empShotName + '</span></a>' +
                '' +
                '                                    </div>' +
                '                                    <ul class="cardresource_actionbuttons">' +
                '                                        <li><a href="">' +
                '                                            <!-- <img data-bs-toggle="tooltip" data-bs-placement="top" title="Flag" src="dist/img/flag.svg" width="18" alt=""> -->' +
                '                                           <!-- <img data-bs-toggle="tooltip" data-bs-placement="top" title="Priority" src="dist/img/priority.svg" width="16" alt=""></a></li>--> ' +
                '                                        <li class="flagdetailpoover dropdown keep-inside-clicks-open">' +
                '                                            <a href="" class="Tskflag dropdown-toggle" data-bs-toggle="dropdown" data-original-title="" data-bs-auto-close="false" title="" aria-expanded="true" id="flagdetails"><i data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_FlagView") %>" class="far fa-flag" id="Flagid_' + Projectlist.TaskID + '" onclick="GetFlagDetails(' + Projectlist.TaskID + ')" ></i><i class="fas fa-flag" id="FlagidNw_' + Projectlist.TaskID + '"></i> </a>' +
                '' +
                '                                            <ul id="ul_' + Projectlist.TaskID + '" class="dropdown-menu flagdetailswrap">' +
                '                                                <div class="form-group">' +
                '                                                    <select id="wbsfdselect1" class=" form-select form-control">' +
                '                                                        <option>Review</option>' +
                '                                                        <option>Follow Up</op  tion>' +
                '                                                    </select>' +
                '                                                </div>' +
                '' +
                '                                                <div class="form-group">' +
                '' +
                '                                                    <div class="input-group datefielddiv">' +
                //Commented And Added By Usha Pandit On 27.08.2020 For preventing to enter text in date picker
                //<input id="duedate_' + Projectlist.TaskID + '" type="text" class="form-control" autocomplete="off">' +
                '                                                       <input id="duedate_' + Projectlist.TaskID + '" type="text" readonly class="form-control" autocomplete="off">' +
                //End Of Added By Usha Pandit On 27.08.2020 For preventing to enter text in date picker 
                '                                                        <input id="TaskFlagID_' + Projectlist.TaskID + '" type="hidden" class="form-control">' +
                '                                                        <span class="input-group-btn">' +
                '                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>' +
                '                                                        </span>' +
                '                                                    </div>' +
                '                                                </div>' +
                '' +
                '                                                <div class="form-group text-center">' +
                //Commented and Addded by Chetan M on 12th Feb 2020 for IssueID = 21838
                //'                                                    <button class="btn btnyellow" data-bs-dismiss="popover" id="BtnUnflag_' + Projectlist.TaskID + '" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',0)">Unflag</button>' +
                //'                                                  ' +
                //'                                                    <button class="btn btnyellow" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',1)">Save</button>' +
                '                                                    <button class="btn btnyellow unFlagSetAccessClass  ' + IsDisabled + '"  data-bs-dismiss="popover" id="BtnUnflag_' + Projectlist.TaskID + '" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',0,&quot;' + Projectlist.EndDate + '&quot;,&quot;' + Projectlist.startDate + '&quot;)" >Unflag</button>' +
                '                                                  ' +
                '                                                    <button class="btn btnyellow setAccessClass  ' + IsDisabled + '"   id="saveBtnUnflag_' + Projectlist.TaskID + '"  onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',1,&quot;' + Projectlist.EndDate + '&quot;,&quot;' + Projectlist.startDate + '&quot;)">Save</button>' +
                //End of Commented and Addded by Chetan M on 12th Feb 2020 for IssueID = 21838
                '                                                </div>' +
                '                                            </ul>' +
                '' +
                '                                        </li>' +
                '                                         <li class="flagdetailpoover dropdown keep-inside-clicks-open">' +
                '                                            <a href="" class="Tskflag dropdown-toggle" data-bs-toggle="dropdown" data-original-title="" data-bs-auto-close="false" title="" aria-expanded="true" id="wbstasknote"><i data-bs-toggle="tooltip" data-bs-placement="top" title="Note" class="far fa-list-alt"></i> </a>' +
                '' +
                '                                            <ul id="" class="dropdown-menu flagdetailswrap">' +
                '                                            <div id = "popover-content-wbstasknote" Class="form-group">' +
                '                                        <strong><%= MyBase.GetResourceString("C_Note") %> : </strong>' + Projectlist.TaskNotes +
                '                                            </div>' +
                '                                            </ul>' +
                '' +
                '                                        </li>' +
                //added by Vishal Mahajan 08-01-2020
                //'                                        <li ' + editIconStyle + '><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#taskeditor">' +
                '                                        <li ' + editIconStyle + '  class="editTask"><a href="" data-bs-toggle="modal" onclick="editTask(' + Projectlist.TaskID + ')">' +
                '                                            <img data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_Edit") %>" src="../../../Whizible2.0-new/dist/img/edit.svg" width="18" alt=""></a></li>' +
                '                                    </ul>' +
                '                                    <div class="clearfix"></div>' +
                '                                </div>' +
                '                            </div>' +
                '' +
                '                        </div>';


            //#endregion
            //Added By Dipali V on 10th Feb 2020 For Duplidate Task display issues
            $('#Stage' + Projectlist.StageID + '').append("");
            //End of Added By Dipali V on 10th Feb 2020 For Duplidate Task display issues

            $('#Stage' + Projectlist.StageID + '').append(myvar);
            //debugger;
            //alert(IsvoidTask);   
            if (IsvoidTask == "YesvoidTask") {
                //$('#saveBtnUnflag_' + Projectlist.TaskID + '').prop("disabled", true)
                // $('#BtnUnflag_' + Projectlist.TaskID + '').prop("disabled", true)
            }
            //} else {
            //    $(".flagdetailswrap > div.form-group.text-center > button").prop("disabled", false)
            //}
            // $("#ul_" + selectedDivID).css("display", "none");
            CustomDueDatePicker(Projectlist.TaskID);//added by Dipali v On 25th Jan 2020 For CustomdatePicker
            //GetFlagDetails(Projectlist.TaskID)//Added By Dipali V On 25th Jan 2020 for Flag Details
        }


        //Added By Dipali v On 25th jan 2020 For datepicker to Due date

        function CustomDueDatePicker(TaskID) {

            var filedid = "#duedate_" + TaskID;
            $(filedid).datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                //Change By Dipali V On 16th Aug 2019
                dateFormat: 'dd M yy'
                //End of Change By Dipali V On 16th Aug 2019
            });


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

            // alert(selectedDivID);
            //$("#ul_" + selectedDivID).css("display", "");

            $(document).on('click', '.ui-datepicker-next', function () {
                // alert(selectedDivID);
                //debugger;

                $("#ul_" + selectedDivID).css("display", "");
                $("#ul_" + selectedDivID).css("display", "block");

            });

            $(document).on('click', '.ui-datepicker-prev', function () {
                $("#ul_" + selectedDivID).css("display", "");
                $("#ul_" + selectedDivID).css("display", "block");

            });

            //Added By Dipali V On 28th Feb 2020 For Flag Div Was Closed on change of month
            $(document).on('change', '.ui-datepicker-month', function () {
                $("#ul_" + selectedDivID).css("display", "");
                $("#ul_" + selectedDivID).css("display", "block");

            });


            $(document).on('click', '.ui-datepicker-month', function () {
                $("#ul_" + selectedDivID).css("display", "");
                $("#ul_" + selectedDivID).css("display", "block");

            });
            //End of Added By Dipali V On 28th Feb 2020 For Flag Div Was Closed on change of month
        }




        //End of Added By Dipali v On 25th jan 2020 For datepicker to Due date





        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will draw all the task which are completed.
         * Author           :   Chandrashekhar Salagar
         * @param Projectlist
         */
        function DrawCompletedTasks(Projectlist) {
            //debugger;
            var TaskCss = "";
            var dbEndDate = "";
            var EndDate = "";
            var dbActulaEndDate = "";
            var ActualEndDate = "";
            var getActulaEndTime = "";
            var EndDate = "";
            var StartGetTime = "";
            var EndGetTime = "";
            //get start date and actual start date for comparing.                
            var today = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());
            if (Projectlist.EndDate != "") {
                dbEndDate = Projectlist.EndDate.split("/");
                EndDate = new Date(dbEndDate[2], dbEndDate[1] - 1, dbEndDate[0]);
                EndGetTime = EndDate.getTime()
            }

            if (Projectlist.ActualEndDate != "") {
                dbActulaEndDate = Projectlist.ActualEndDate.split("/");
                ActualEndDate = new Date(dbActulaEndDate[2], dbActulaEndDate[1] - 1, dbActulaEndDate[0]);
                getActulaEndTime = ActualEndDate.getTime();
            }

            /*
                1) First condition i.e. Planned start date is today and actual start date is null will not be applicable in task completed stage
                2) Second condtion i.e. Planned end date is today and actual end date is null will not be applicable for task completed stage 
                3) Third Condition i.e. Planned start date is less than today and no actual start date will no be applicable for task completed stage//
                4) Fourth constion i.e. Planned start end date is less than today and no actual end date also not be applicable for or task completed stage
                5) Fifth condition i.e. Actual start date is more than planned start date will not be applicable because task comes under this stage will be completed, 
                so it does not matter it startd late.
                8) Seventh Condtion i.e. Started early also not applicablebecause task comes under this stage will be completed
            */
            //debugger;
            /*6) Actual end date is more than planned end date i.e. Ended late* ||  7) Actual effort is more than planned effort*/
            //Commented & Added By Dipali V On 14th Feb 2020 For Early Completed Colour
            //if ((getActulaEndTime > EndGetTime) || (parseInt(Projectlist.WorkInHours) > parseInt(Projectlist.ActualWork))) {
            if ((getActulaEndTime > EndGetTime) || (parseInt(Projectlist.WorkInHours) < parseInt(Projectlist.ActualWork))) {
                TaskCss = "taskcardbox taskcardbox_todo Red";
            }
            //End of Commented & Added By Dipali V On 14th Feb 2020 For Early Completed Colour

            /*Actual end date is less than  planned end date i.e. Ended early*/
            else if (getActulaEndTime <= EndGetTime) {
                TaskCss = "taskcardbox taskcardbox_todo Green";
            }

            //#region DynamicContentwindow.onload
            var EmployeeName = Projectlist.EmployeeName;
            var Priority = "inprogress";
            var cssPriority;
            var cssInactive = "";
            var editIconStyle = "";
            var IsvoidTask = "NovoidTask";//Added By Dipali V On 24th jan 2020 For maintain Void task Flag And Draggable
            var IsDisabled = "";
            //Added & Commented By Dipali V On 21st Jan 2020 For Short Name 
            //var arrEmployeeName = EmployeeName.split(' ');
            //if (arrEmployeeName.length == 2) {
            //    empShotName = arrEmployeeName[0].charAt(0) + arrEmployeeName[1].charAt(0);
            //}
            //else {
            //    empShotName = EmployeeName;
            //}
            //End of Added & Commented By Dipali V On 21st Jan 2020 For Short Name 
            empShotName = getShortName(EmployeeName);

            if (Projectlist.Priority.toLowerCase() == "high" || Projectlist.Priority.toLowerCase() == "critical") {
                Priority = "critical";
                cssPriority = "high";
            }
            else if (Projectlist.Priority.toLowerCase() == "medium") {
                cssPriority = "medium";
                Priority = "medium";

            }
            else if (Projectlist.Priority.toLowerCase() == "low" || Projectlist.Priority.toLowerCase() == "minor") {
                cssPriority = "low";

            }
            // Added by Dipali V On 23rd Jan 2020 For priority Issues
            else if (Projectlist.Priority.toLowerCase() == "") {
                cssPriority = "NotSet";
                Projectlist.Priority = "Priority Not Set";

            }
            else {
                cssPriority = "NotSet";
                Projectlist.Priority = Projectlist.Priority;
            }
            //End of Commented by Dipali V On 23rd Jan 2020 For priority Issues
            //Commented by Dipali V On 23rd Jan 2020 For priority Issues

            if (Projectlist.IsActive == "False") {
                IsDisabled = "Disabled";
                cssInactive = " style='background-color: #cccccc;'";
                IsvoidTask = "YesvoidTask";//Added By Dipali V On 24th Jan 2020 Void Task Should not get Dragged
                $(".flagdetailswrap > div.form-group.text-center > button").prop("disabled", true)

            } else {
                $(".flagdetailswrap > div.form-group.text-center > button").prop("disabled", false)
            }


            if (Projectlist.IsTaskComplete == "True" || Projectlist.IsTaskComplete == "1") {
                IsDisabled = "Disabled";

            }

            if (m_EditAccess == "False" || Projectlist.WhichTask == "M") {
                editIconStyle = "style=display:none"
            }


            // //Added BY Dipali V On 12th Feb 2020 For Flag Color change
            //var TaskFlagCss = "";
            //var Enddate = EndDate.toShortFormat();
            //var today = today.toShortFormat();
            //if (Date.parse(Enddate) < Date.parse(today)) {
            //    TaskFlagCss = "FlagColor_Red";
            //} else {
            //  TaskFlagCss = "FlagColor_Green";

            //}
            // //End of Added BY Dipali V On 12th Feb 2020 For Flag Color change


            var myvar = '<div class="' + TaskCss + ' taskcardboxActive ' + IsvoidTask + '"  id="' + Projectlist.TaskID + '"> <input type="hidden" value=' + Projectlist.StageID + ' id=hdnStageId' + Projectlist.TaskID + '> <input type="hidden" value=' + Projectlist.TaskID + ' id= hdnTaskId' + Projectlist.TaskID + '> <input type="hidden" value=' + Projectlist.EmployeeID + ' id= hdnEmployeeID' + Projectlist.TaskID + '>' +
                '                            <div class="card gist-data"' + cssInactive + '>' +
                '                                <div class="card-body">' +
                //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21828
                //'                                    <div class="card-heading">' + Projectlist.SubTaskTypes + '' +
                '                                    <div class="card-heading">' +
                //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21828
                '                                        <!-- <label class="rank float-end mb-0">3.1.3</label> -->' +
                '                                        <div class="clearfix"></div>' +
                '                                        <span class="prioritylabel prioritylabel' + cssPriority + '">' + Projectlist.Priority + '</span>' +
                '                                    </div>' +
                '                                    <h4 class="card-title">' + Projectlist.TaskName + '</h4>' +
                '                                    <div class="mb-10 cardtask_duration">' +
            '                                        <span><%= MyBase.GetResourceString("C_StartDate") %> :  ' + Projectlist.StartDate + ' </span>' +
            '                                       <b><a href=""> <span class="float-end"  data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_PlanningHours") %>" style=color:black>' + Projectlist.WorkInHours + '</span></a> </b>' +
                '                                    </div>' +
                '                                   <div class="cardtask_duration">' +
            '                                        <span><%= MyBase.GetResourceString("C_EndDate") %> : ' + Projectlist.EndDate + '</span>' +
                '                                        <span class="float-end">' + Projectlist.DaysRemaining + ' Day(s)</span>' +
                '                                    </div>' +
                '                                </div>' +
                '                                <div class="cardfooter">' +
                '                                    <div class="cardresource float-start">' +
                '                                        <a href=""><span data-bs-toggle="tooltip" data-title="' + Projectlist.EmployeeName + '" class="usernameshort circle-bggreen usernamecirclesmall" data-bs-original-title="' + Projectlist.EmployeeName + '" title="">' + empShotName + '</span></a>' +
                '' +
                '                                    </div>' +
                '                                    <ul class="cardresource_actionbuttons">' +
                '                                        <li><a href="">' +
                '                                            <!-- <img data-bs-toggle="tooltip" data-bs-placement="top" title="Flag" src="../../../Whizible2.0-new/dist/img/flag.svg" width="18" alt=""> -->' +
                '                                           <!--  <img data-bs-toggle="tooltip" data-bs-placement="top" title="Priority" src="dist/img/priority.svg" width="16" alt=""></a></li>-->' +
                '                                        <li class="flagdetailpoover dropdown keep-inside-clicks-open">' +
                '                                            <a href="" class="Tskflag dropdown-toggle" data-bs-toggle="dropdown" data-original-title="" data-bs-auto-close="false" title="" aria-expanded="true" id="flagdetails"><i data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_FlagView") %>" class="far fa-flag" id="Flagid_' + Projectlist.TaskID + '" onclick="GetFlagDetails(' + Projectlist.TaskID + ')" ></i><i class="fas fa-flag" id="FlagidNw_' + Projectlist.TaskID + '"></i> </a>' +
                '' +
                '                                            <ul id="ul_' + Projectlist.TaskID + '" class="dropdown-menu flagdetailswrap">' +
                '                                                <div class="form-group">' +
                '                                                    <select id="wbsfdselect1" class=" form-select form-control">' +
                '                                                        <option>Review</option>' +
                '                                                        <option>Follow Up</option>' +
                '                                                    </select>' +
                '                                                </div>' +
                '' +
                '                                                <div class="form-group">' +
                '' +
                '                                                    <div class="input-group datefielddiv">' +
                //Commented And Added By Usha Pandit On 27.08.2020 For preventing to enter text in date picker
                //<input id="duedate_' + Projectlist.TaskID + '" type="text" class="form-control" autocomplete="off">' +
                '                                                     <input id="duedate_' + Projectlist.TaskID + '" type="text" readonly class="form-control" autocomplete="off">' +
                //End Of Added By Usha Pandit On 27.08.2020 For preventing to enter text in date picker
                '                                                     <input id="TaskFlagID_' + Projectlist.TaskID + '" type="hidden" class="form-control">' +
                '                                                        <span class="input-group-btn">' +
                '                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>' +
                '                                                        </span>' +
                '                                                    </div>' +
                '                                                </div>' +
                '' +
                '                                                <div class="form-group text-center">' +
                //Commented and Addded by Chetan M on 12th Feb 2020 for IssueID = 21838
                //'                                                    <button class="btn btnyellow" data-bs-dismiss="popover" id="BtnUnflag_' + Projectlist.TaskID + '" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',0)">Unflag</button>' +
                //'                                                    ' +
                //'                                                    <button class="btn btnyellow" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',1)">Save</button>' +
                //'                                                    <button class="btn btnyellow unFlagSetAccessClass" data-bs-dismiss="popover" id="BtnUnflag_' + Projectlist.TaskID + '" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',0,&quot;' + EndDate.toShortFormat() + '&quot;)" disabled>Unflag</button>' +
                //'                                                    ' +
                //'                                                    <button class="btn btnyellow setAccessClass" id="saveBtnUnflag_'+ Projectlist.TaskID +'"  onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',1,&quot;' + EndDate.toShortFormat() + '&quot;)" disabled>Save</button>' +
                //End of Commented and Addded by Chetan M on 12th Feb 2020 for IssueID = 21838
                '                                                </div>' +
                '                                            </ul>' +
                '' +
                '                                        </li>' +
                '                                         <li class="flagdetailpoover dropdown keep-inside-clicks-open">' +
                '                                            <a href="" class="Tskflag dropdown-toggle" data-bs-toggle="dropdown" data-original-title="" data-bs-auto-close="false" title="" aria-expanded="true" id="wbstasknote"><i data-bs-toggle="tooltip" data-bs-placement="top" title="Note" class="far fa-list-alt"></i> </a>' +
                '' +
                '                                            <ul id="" class="dropdown-menu flagdetailswrap">' +
                '                                            <div id = "popover-content-wbstasknote" Class="form-group">' +
            '                                        <strong><%= MyBase.GetResourceString("C_Note") %> : </strong>' + Projectlist.TaskNotes +
                '                                            </div>' +
                '                                            </ul>' +
                '' +
                '                                        </li>' +
                //ADDED by Vishal Mahajan 08-01-2020
                //'                                        <li ' + editIconStyle + '><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#taskeditor">' +
                '                                        <li ' + editIconStyle + '  class="editTask"><a href="" data-bs-toggle="modal" onclick="editTask(' + Projectlist.TaskID + ')">' +
            '                                            <img data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_Edit") %>" src="../../../Whizible2.0-new/dist/img/edit.svg" width="18" alt=""></a></li>' +
                '                                    </ul>' +
                '                                    <div class="clearfix"></div>' +
                '                                </div>' +
                '                            </div>' +
                '' +
                '                        </div>';
            //Added By Dipali V on 10th Feb 2020 For Duplidate Task display issues
            $('#Stage' + Projectlist.StageID + '').append("");
            //End of Added By Dipali V on 10th Feb 2020 For Duplidate Task display issues
            $('#Stage' + Projectlist.StageID + '').append(myvar);
            //For Completed Task we not able to set Flag

            //End of For Completed Task we not able to set Flag
            // $("#ul_" + selectedDivID).css("display", "none");
            CustomDueDatePicker(Projectlist.TaskID);//added by Dipali v On 25th Jan 2020 For CustomdatePicker
            //GetFlagDetails(Projectlist.TaskID)//Added By Dipali V On 25th Jan 2020 for Flag Details
            //$('#saveBtnUnflag_' + Projectlist.TaskID + '').prop("disabled", true)
            //$('#BtnUnflag_' + Projectlist.TaskID + '').prop("disabled", true)

            //#endregion
        }

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will draw all the task which are custome i.e. in between in progress & completed.
         * Author           :   Chandrashekhar Salagar
         * @param Projectlist
         */
        function DrawCustomTaks(Projectlist) {
            var TaskCss = "";
            var dbStartDate = "";
            var dbActualStartDate = "";
            var dbEndDate = "";
            var EndDate = "";
            var dbActulaEndDate = "";
            var ActualEndDate = "";
            var EndDate = "";
            var startDate = "";
            var actualStartDate = "";
            var TaskCss = "";
            var StartGetTime = "";
            var EndGetTime = "";
            //get start date and actual start date for comparing.                
            var today = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());
            if (Projectlist.StartDate != "") {
                dbStartDate = Projectlist.StartDate.split("/");
                startDate = new Date(dbStartDate[2], dbStartDate[1] - 1, dbStartDate[0]);
                StartGetTime = startDate.getTime()
            }

            if (Projectlist.ActualStartDate != "") {
                dbActualStartDate = Projectlist.ActualStartDate.split("/");
                actualStartDate = new Date(dbActualStartDate[2], dbActualStartDate[1] - 1, dbActualStartDate[0]);
            }

            if (Projectlist.EndDate != "") {
                dbEndDate = Projectlist.EndDate.split("/");
                EndDate = new Date(dbEndDate[2], dbEndDate[1] - 1, dbEndDate[0]);
                EndGetTime = EndDate.getTime()
            }

            if (Projectlist.ActualEndDate != "") {
                dbActulaEndDate = Projectlist.ActualEndDate.split("/");
                ActualEndDate = new Date(dbActulaEndDate[2], dbActulaEndDate[1] - 1, dbActulaEndDate[0]);
            }

            if (Projectlist.ActualStartDate != "") {
                dbActualStartDate = Projectlist.ActualStartDate.split("/");
                actualStartDate = new Date(dbActualStartDate[2], dbActualStartDate[1] - 1, dbActualStartDate[0]);
            }

            /*
               1) First condition i.e. Planned start date is today and actual start date is null condition will not be applicable in Custom stage because all task in this stage has Actual start date
               3) Third condition i.e. Planned end start date is less than today and actaul end date is null condition will not be applicable in Custom stage because all task in this stage has Actual 
               start date 
               6) Sixth condition ie.  Actual end date is more than planned end date will not come under this stage.
           */

            /*  2) Planned end date is today and no actual end date */
            if ((today.getTime() == EndGetTime) && ActualEndDate == "") {
                TaskCss = "taskcardbox taskcardbox_todo Amber";
            }

            /*  4) Planned end date is less than today and no actual end date.
                5) Actual start date is more than planned start date i.e. Started late 
                7) Task is taking moe time to complete
                */
            else if (((today.getTime() > EndGetTime) && ActualEndDate == "") ||
                (GetActualTime > StartGetTime) || (parseInt(Projectlist.WorkInHours) > parseInt(Projectlist.ActualWork))) {
                TaskCss = "taskcardbox taskcardbox_todo Red";
            }

            /*8) Started early*/
            else if (GetActualTime < StartGetTime) {
                TaskCss = "taskcardbox taskcardbox_todo Green";
            }

            //#region DynamicContent
            var EmployeeName = Projectlist.EmployeeName;
            var Priority = "inprogress";
            var editIconStyle = "";
            var cssPriority;
            var cssInactive = "";
            var IsDisabled = "";
            var IsvoidTask = "NovoidTask";//Added By Dipali V On 24th jan 2020 For maintain Void task Flag And Draggable
            //Added & Commented By Dipali V On 21st Jan 2020 For Short Name 
            //var arrEmployeeName = EmployeeName.split(' ');
            //if (arrEmployeeName.length == 2) {
            //    empShotName = arrEmployeeName[0].charAt(0) + arrEmployeeName[1].charAt(0);
            //}
            //else {
            //    empShotName = EmployeeName;
            //}
            //End of Added & Commented By Dipali V On 21st Jan 2020 For Short Name 
            empShotName = getShortName(EmployeeName);
            if (Projectlist.Priority.toLowerCase() == "high" || Projectlist.Priority.toLowerCase() == "critical") {
                Priority = "critical";
                cssPriority = "high";
            }
            else if (Projectlist.Priority.toLowerCase() == "medium") {
                cssPriority = "medium";
                Priority = "medium";

            }
            else if (Projectlist.Priority.toLowerCase() == "low" || Projectlist.Priority.toLowerCase() == "minor") {
                cssPriority = "low";

            }
            // Added by Dipali V On 23rd Jan 2020 For priority Issues
            else if (Projectlist.Priority.toLowerCase() == "") {
                cssPriority = "NotSet";
                Projectlist.Priority = "Priority Not Set";

            }
            else {
                cssPriority = "NotSet";
                Projectlist.Priority = Projectlist.Priority;
            }
            //End of Commented by Dipali V On 23rd Jan 2020 For priority Issues
            //Commented by Dipali V On 23rd Jan 2020 For priority Issues

            if (Projectlist.IsActive == "False") {
                cssInactive = " style='background-color: #cccccc;'";
                IsDisabled = "Disabled";
                IsvoidTask = "YesvoidTask";//Added By Dipali V On 24th Jan 2020 Void Task Should not get Dragged


            } else {

            }


            if (Projectlist.IsTaskComplete == "True" || Projectlist.IsTaskComplete == "1") {
                IsDisabled = "Disabled";

            }

            if (m_EditAccess == "False") {
                editIconStyle = "style=display:none"
            }

            // //Added BY Dipali V On 12th Feb 2020 For Flag Color change
            //var TaskFlagCss = "";
            //var Enddate = EndDate.toShortFormat();
            //var today = today.toShortFormat();
            //if (Date.parse(Enddate) < Date.parse(today)) {
            //    TaskFlagCss = "FlagColor_Red";
            //} else {
            //    TaskFlagCss = "FlagColor_Green";

            //}
            // //End of Added BY Dipali V On 12th Feb 2020 For Flag Color change



            var myvar = '<div class="taskcardbox taskcardbox_completed gist taskcardboxActive ' + YesvoidTask + '" id="' + Projectlist.TaskID + '"> <input type="hidden" value=' + Projectlist.StageID + ' id=hdnStageId' + Projectlist.TaskID + '> <input type="hidden" value=' + Projectlist.TaskID + ' id= hdnTaskId' + Projectlist.TaskID + '>' +
                '                            <div class="card gist-data"' + cssInactive + '>' +
                '                                <div class="card-body">' +
                //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21828
                //'                                    <div class="card-heading">' + Projectlist.SubTaskTypes + '' +
                '                                    <div class="card-heading">' +
                //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21828
                '                                        <!-- <label class="rank float-end mb-0">3.1.3</label> -->' +
                '                                        <div class="clearfix"></div>' +
                '                                        <span class="prioritylabel prioritylabel' + cssPriority + '">' + Projectlist.Priority + '</span>' +
                '                                    </div>' +
                '                                    <h4 class="card-title">' + Projectlist.TaskName + '</h4>' +
                '                                    <div class="mb-10 cardtask_duration">' +
            '                                        <span><%= MyBase.GetResourceString("C_StartDate") %> :  ' + Projectlist.StartDate + ' </span>' +
            '                                       <b><a href=""> <span class="float-end"  data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_PlanningHours") %>" style=color:black>' + Projectlist.WorkInHours + '</span></a> </b>' +
                '                                    </div>' +
                '                                   <div class="cardtask_duration">' +
            '                                        <span><%= MyBase.GetResourceString("C_EndDate") %> : ' + Projectlist.EndDate + '</span>' +
                '                                        <span class="float-end">' + Projectlist.DaysRemaining + ' Day(s)</span>' +
                '                                    </div>' +
                '                                </div>' +
                '                                <div class="cardfooter">' +
                '                                    <div class="cardresource float-start">' +
                '                                        <a href=""><span data-bs-toggle="tooltip" data-title="' + empShotName + '" class="usernameshort circle-bggreen usernamecirclesmall" data-bs-original-title="' + Projectlist.EmployeeName + '" title="">' + empShotName + '</span></a>' +
                '' +
                '                                    </div>' +
                '                                    <ul class="cardresource_actionbuttons">' +
                '                                        <li><a href="">' +
                '                                            <!-- <img data-bs-toggle="tooltip" data-bs-placement="top" title="Flag" src="dist/img/flag.svg" width="18" alt=""> -->' +
                '                                          <!--  <img data-bs-toggle="tooltip" data-bs-placement="top" title="Priority" src="dist/img/priority.svg" width="16" alt=""></a></li>-->' +
                '                                        <li class="flagdetailpoover dropdown keep-inside-clicks-open">' +
                '                                            <a href="" class="Tskflag dropdown-toggle" data-bs-toggle="dropdown" data-original-title="" data-bs-auto-close="false" title="" aria-expanded="true" id="flagdetails"><i data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_FlagView") %>" class="far fa-flag" id="Flagid_' + Projectlist.TaskID + '" onclick="GetFlagDetails(' + Projectlist.TaskID + ')" ></i><i class="fas fa-flag" id="FlagidNw_' + Projectlist.TaskID + '"></i></a>' +
                '' +
                '                                            <ul id="ul_' + Projectlist.TaskID + '" class="dropdown-menu flagdetailswrap">' +
                '                                                <div class="form-group">' +
                '                                                    <select id="wbsfdselect1" class=" form-select form-control">' +
                '                                                        <option>Review</option>' +
                '                                                        <option>Follow Up</option>' +
                '                                                    </select>' +
                '                                                </div>' +
                '' +
                '                                                <div class="form-group">' +
                '' +
                '                                                    <div class="input-group datefielddiv">' +
                //Commented And Added By Usha Pandit On 27.08.2020 For preventing to enter text in date picker
                //<input id="duedate_' + Projectlist.TaskID + '" type="text" class="form-control" autocomplete="off">' +
                '                                                        <input id="duedate_' + Projectlist.TaskID + '" readonly type="text" class="form-control" autocomplete="off">' +
                //End Of Added By Usha Pandit On 27.08.2020 For preventing to enter text in date picker
                '                                                        <input id="TaskFlagID_' + Projectlist.TaskID + '" type="hidden" class="form-control">' +
                '                                                        <span class="input-group-btn">' +
                '                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>' +
                '                                                        </span>' +
                '                                                    </div>' +
                '                                                </div>' +
                '' +
                '                                                <div class="form-group text-center">' +
                //Commented and Addded by Chetan M on 12th Feb 2020 for IssueID = 21838
                //'                                                    <button class="btn btnyellow" data-bs-dismiss="popover" id="BtnUnflag_' + Projectlist.TaskID + '" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',0)">Unflag</button>' +
                //'                                                   ' +
                //'                                                    <button class="btn btnyellow" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',1)">Save</button>' +
                '                                                    <button class="btn btnyellow unFlagSetAccessClass  ' + IsDisabled + '"  data-bs-dismiss="popover" id="BtnUnflag_' + Projectlist.TaskID + '" onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',0,&quot;' + Projectlist.EndDate + '&quot;,&quot;' + Projectlist.startDate + '&quot;)" >Unflag</button>' +
                '                                                   ' +
                '                                                    <button class="btn btnyellow setAccessClass  ' + IsDisabled + '"  id="saveBtnUnflag_' + Projectlist.TaskID + '"  onclick="SaveTaskCardFlag(' + Projectlist.TaskID + ',1,&quot;' + Projectlist.EndDate + '&quot;,&quot;' + Projectlist.startDate + '&quot;)" >Save</button>' +
                //End of Commented and Addded by Chetan M on 12th Feb 2020 for IssueID = 21838
                '                                                </div>' +
                '                                            </ul>' +
                '' +
                '                                        </li>' +
                '                                         <li class="flagdetailpoover dropdown keep-inside-clicks-open">' +
            '                                            <a href="" class="Tskflag dropdown-toggle" data-bs-toggle="dropdown" data-original-title="" title="" data-bs-auto-close="false" aria-expanded="true" id="wbstasknote"><i data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_Note") %>" class="far fa-list-alt"></i> </a>' +
                '' +
                '                                            <ul id="" class="dropdown-menu flagdetailswrap">' +
                '                                            <div id = "popover-content-wbstasknote" Class="form-group">' +
            '                                        <strong><%= MyBase.GetResourceString("C_Note") %> : </strong>' + Projectlist.TaskNotes +
                '                                            </div>' +
                '                                            </ul>' +
                '' +
                '                                        </li>' +
                // Added by Vishal Mahajan 08-01-2020
                //'                                        <li><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#taskeditor">' +
                '                                        <li  class="editTask"><a href="" data-bs-toggle="modal" onclick="editTask(' + Projectlist.TaskID + ')">' +
            '                                            <img data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_Edit") %>" src="../../../Whizible2.0-new/dist/img/edit.svg" width="18" alt=""></a></li>' +
                '                                    </ul>' +
                '                                    <div class="clearfix"></div>' +
                '                                </div>' +
                '                            </div>' +
                '' +
                '                        </div>';
            //Added By Dipali V on 10th Feb 2020 For Duplidate Task display issues
            $('#Stage' + Projectlist.StageID + '').append("");
            //End of Added By Dipali V on 10th Feb 2020 For Duplidate Task display issues
            $('#Stage' + Projectlist.StageID + '').append(myvar);
            //debugger;
            if (IsvoidTask == "YesvoidTask") {
                // $('#saveBtnUnflag_' + Projectlist.TaskID + '').prop("disabled", true)
                //  $('#BtnUnflag_' + Projectlist.TaskID + '').prop("disabled", true)
            }
            //} else {
            //    $(".flagdetailswrap > div.form-group.text-center > button").prop("disabled", false)
            //}
            // $("#ul_" + selectedDivID).css("display", "none");
            CustomDueDatePicker(Projectlist.TaskID);//added by Dipali v On 25th Jan 2020 For CustomdatePicker
            //GetFlagDetails(Projectlist.TaskID)//Added By Dipali V On 25th Jan 2020 for Flag Details
            //#endregion
        }
        //#endregion


        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will get all the active tasks.
         * Author           :   Chandrashekhar Salagar.
         * */
        //#region getActive/All Tasks
        function GetActiveTasks() {
            var WhichTask;
            var getClassName = $('#tabWhizibleTasks').attr('class');
            if (getClassName == "tab-slider--trigger active") {
                WhichTask = "";
            }
            else {
                WhichTask = "M";
            }
            GetDefaultStages($("#CboProject").val(), 1, WhichTask);

            //Added By Dipali v On 14th Feb 2020 For Note for mpp disabled
            if (WhichTask == "M") {
                $("ul.cardresource_actionbuttons>li:nth-child(3)>a").removeAttr("data-bs-toggle");
                $("ul.cardresource_actionbuttons>li:nth-child(3)>a").css("cursor", "no-drop");
            } else {

                $("ul.cardresource_actionbuttons>li:nth-child(3)").removeClass("disabledNote");
                $("ul.cardresource_actionbuttons>li:nth-child(3)>a").attr("data-bs-toggle");
                $("ul.cardresource_actionbuttons>li:nth-child(3)>a").css("cursor", "pointer");
            }
            //End of Added By Dipali v On 14th Feb 2020 For Note for mpp disabled

            $(".flagdetailswrap .Disabled").each(function () {
                var ID = this.id;
                $("#" + ID).prop("disabled", true);

            });
            //debugger;
            clearTooltip();

        }

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will get all task.
         * Author           :   Chandrashekhar Salagar.  
         * */
        function GetAllTasks() {
            var WhichTask;
            var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
            var getClassName = $('#tabWhizibleTasks').attr('class');
            if (getClassName == "tab-slider--trigger active") {
                WhichTask = "";
            }
            else {
                WhichTask = "M";
            }
            GetDefaultStages($("#CboProject").val(), 0, WhichTask);
            //Added By Dipali v On 14th Feb 2020 For Note for mpp disabled
            if (WhichTask == "M") {
                $("ul.cardresource_actionbuttons>li:nth-child(3)>a").removeAttr("data-bs-toggle");
                $("ul.cardresource_actionbuttons>li:nth-child(3)>a").css("cursor", "no-drop");
            } else {

                $("ul.cardresource_actionbuttons>li:nth-child(3)").removeClass("disabledNote");
                $("ul.cardresource_actionbuttons>li:nth-child(3)>a").attr("data-bs-toggle");
                $("ul.cardresource_actionbuttons>li:nth-child(3)>a").css("cursor", "pointer");
            }

            //debugger;
            $(".flagdetailswrap .Disabled").each(function () {
                var ID = this.id;
                $("#" + ID).prop("disabled", true);

            });

            clearTooltip();

            //IsProjectOver = CheckProjectOver();
            //if (IsProjectOver == 1) {
            //    $(".setAccessClass").hide();
            //    $(".unFlagSetAccessClass").hide();
            //    $("#btnAddTasks").prop("disabled", true);
            //    $("#btnMainDelete").prop("disabled", true);
            //    $("#btnSaveStage").prop("disabled", true);
            //    $("#btnimport").prop("disabled", true);
            //}

            // ///*Added  By Dipali V On 17th Feb 2020 For Restrict Void task Deletion*/
            // $("#wbswhizibletab .YesvoidTask").each(function () {
            //    var ID = this.id;
            //    $("#" + ID).addClass("disabledDiv");

            //});
            ///*End of Added  By Dipali V On 17th Feb 2020 For Restrict Void task Deletion*/
            //var classSelectedDiv = 'selectedDiv';
            ///*Added  By Dipali V On 17th Feb 2020 For Restrict Void task Deletion*/
            //var classdisabledDiv = 'disabledDiv';
            //var $thumbs = $('body').on('onload', 'div.taskcardbox', function () {

            //    $('.taskcardbox').each(function () {
            //        $('.taskcardbox').removeClass(classSelectedDiv);
            //    });
            //    $thumbs.removeClass(classSelectedDiv);
            //    /*Added  By Dipali V On 17th Feb 2020 For Restrict Void task Deletion*/
            //    if ($(this).hasClass("YesvoidTask")) {
            //        $(this).addClass(classdisabledDiv);
            //    } else {
            //        $(this).addClass(classSelectedDiv);
            //    }

            //    //End of Added By Dipali v On 14th Feb 2020 For Note for mpp disabled
            //});
        }
        //#endregion

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will get Whizile Tasks.
         * Author           :   Chandrashekhar Salagar.
         * */
        //#region getWhizibleTasks
        var IsWhizibleTask = 0;
        var IsMPPTask = 0;
        function GetWhizibleTask() {
            var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
            if (ActiveTab == "tabActive") {
                IsActiveTasks = "1";
            }
            else if (ActiveTab == "tabAll") {
                IsActiveTasks = "0";
            }
            IsWhizibleTask = 1;
            IsMPPTask = 0;

            //Comment added by imran on 23-02-2022
            //GetDefaultStages($("#CboProject").val(), IsActiveTasks, "");
            //End Of comment by imran on 23-02-2022

            //Added by Dipali V On 23rd Jan 2020 For Whizible task Selection we can not add task Or Delete Task
            $("#btnAddTasks").prop("disabled", false);
            $("#btnMainDelete").prop("disabled", false);
            $("ul.cardresource_actionbuttons>li:nth-child(3)").removeClass("disabledNote");
            //Added By Dipali V On 10th Feb 2020 For Display Purpose
            $("ul.cardresource_actionbuttons>li:nth-child(3)>a").attr("data-bs-toggle");
            $("ul.cardresource_actionbuttons>li:nth-child(3)>a").css("cursor", "pointer");
            $(".flagdetailswrap .Disabled").each(function () {
                var ID = this.id;
                $("#" + ID).css("display", "none");

            });
            clearTooltip();
            //IsProjectOver = CheckProjectOver();
            //if (IsProjectOver == 1) {
            //    $(".setAccessClass").hide();
            //    $(".unFlagSetAccessClass").hide();
            //    $("#btnAddTasks").prop("disabled", true);
            //    $("#btnMainDelete").prop("disabled", true);
            //    $("#btnSaveStage").prop("disabled", true);
            //    $("#btnimport").prop("disabled", true);
            //}
            //End of Added By Dipali V On 10th Feb 2020 For Display Purpose
            //End of Added by Dipali V On 23rd Jan 2020 For Whizible task Selection we can not add task Or Delete Task
        }
        //#endregion


        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will get Whizile Tasks.
         * Author           :   Chandrashekhar Salagar.
         * */
        //#region getWhizibleTasks
        function GetMPPTasks() {
            var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
            if (ActiveTab == "tabActive") {
                IsActiveTasks = "1";
            }
            else if (ActiveTab == "tabAll") {
                IsActiveTasks = "0";
            }
            IsWhizibleTask = 0;
            IsMPPTask = 1;
            // debugger;
            GetDefaultStages($("#CboProject").val(), IsActiveTasks, "M");
            //Added by Dipali V On 23rd Jan 2020 For MPP Selection we can not add task Or Delete Task
            $("#btnAddTasks").prop("disabled", true);
            $("#btnMainDelete").removeClass("disabledbutton");
            $("#btnMainDelete").prop("disabled", true);
            //$(".flagdetailswrap > div.form-group.text-center > button").prop("disabled", true);
            $("#btnTaskSave").prop("disabled", true);
            //$("ul.cardresource_actionbuttons>li:nth-child(3)").addClass("disabledNote");
            //Added By Dipali V On 10th Feb 2020 For MPP Task restirctions
            $("ul.cardresource_actionbuttons>li:nth-child(3)>a").removeAttr("data-bs-toggle");
            $("ul.cardresource_actionbuttons>li:nth-child(3)>a").css("cursor", "no-drop");
            //End of Added By Dipali V On 10th Feb 2020 For MPP Task restirctions
            //$('#flagdetailswrap').prop('onclick',null).off('click');
            $(".flagdetailswrap .Disabled").each(function () {
                var ID = this.id;
                $("#" + ID).css("display", "none");

            });

            clearTooltip();
            //IsProjectOver = CheckProjectOver();
            //if (IsProjectOver == 1) {
            //    $(".setAccessClass").hide();
            //    $(".unFlagSetAccessClass").hide();
            //    $("#btnAddTasks").prop("disabled", true);
            //    $("#btnMainDelete").prop("disabled", true);
            //    $("#btnSaveStage").prop("disabled", true);
            //    $("#btnimport").prop("disabled", true);
            //}
            //End of Added by Dipali V On 23rd Jan 2020 For MPP Selection we can not add task Or Delete Task
        }
        //#endregion

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will draw all the stage for selecte project.
         * Author           :   Chandrashekhar Salagar.
         * @param ProjectId
         * @param IsActive
         * @param WhichTask
         */
        //#region GetDefaultStage
        function GetDefaultStages(ProjectId, IsActive, WhichTask) {
            //var ProjectId = document.getElementById("CboProject").value;
            //var ProjectId = "2207";
            var pm_wbs_cardparameter = {
                ProjectID: encodeURI(ProjectId)
            }
            //StartLoader("#bodywbs");
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/getDefaultStages',
                type: "POST",
                data: JSON.stringify(pm_wbs_cardparameter),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (pm_wbs_cardparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(pm_wbs_cardparameter) ? pm_wbs_cardparameter : JSON.stringify(pm_wbs_cardparameter)));
                    }
                },
                async: false,
                success: function (scrumestages) {
                    $('#draggable-menu').html('');
                    //console.log(scrumestages);
                    var getSplitstring = '';
                    var EditStageNameAccess = '';
                    if (m_EditAccess == "False") {
                        EditStageNameAccess = "readonly";
                    }

                    // Add stages dynamically
                    for (var i = 0; i < scrumestages.length; i++) {
                        ///debugger;
                        //if (scrumestages[i].StageName == "To-Do List" || scrumestages[i].MasterStageID == 1) {
                        if (scrumestages[i].MasterStageID == "1") {
                            //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21830
                            //var appendString = ' <div id="Stage' + (scrumestages[i].StageID) + '" class="draggablemenu" style="width:425px;height:100%" ><div class="tskcardBox"><div class="wbstaskpanel_heading" style=""><input type="text" ' + EditStageNameAccess + ' id="txt' + scrumestages[i].StageID + '" onchange="UpdateStageName(' + scrumestages[i].StageID + ')" maxlength="50" style="background: rgba(0,0,0,0);border: none; text-align: center;" value="' + scrumestages[i].StageName + '" autocomplete="off"></input><input type="hidden" value=' + scrumestages[i].StageID + ' id=hdnStageId' + scrumestages[i].StageID + '></div></div></div>'; //<div class="taskcardbox ui-sortable-placeholder"  ></div>
                            var appendString = ' <div id="Stage' + (scrumestages[i].StageID) + '" class="draggablemenu" style="width:425px;height:100%" ><div class="tskcardBox"><div class="wbstaskpanel_heading" style=""><input type="text" ' + EditStageNameAccess + ' id="txt' + scrumestages[i].StageID + '" onchange="UpdateStageName(' + scrumestages[i].StageID + ')" maxlength="50" style="background: rgba(0,0,0,0);border: none; text-align: center;" value="' + scrumestages[i].StageName + '" autocomplete="off" disabled="disabled"></input><input type="hidden" value=' + scrumestages[i].StageID + ' id=hdnStageId' + scrumestages[i].StageID + '></div></div></div>'; //<div class="taskcardbox ui-sortable-placeholder"  ></div>
                            //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21830
                            getSplitstring = "#Stage" + (scrumestages[i].StageID);
                            $('#draggable-menu').append(appendString);
                        }
                        //else if (scrumestages[i].StageName == "In Progress" || scrumestages[i].MasterStageID == 2) {
                        else if (scrumestages[i].MasterStageID == "2") {
                            var AddStageButton = '';
                            var style = '';
                            //debugger;
                            //Added & Commented By Dipali V On 13th Feb 2020 For Filter
                            // if (AddRole == "True" )
                            if (AddRole == "True" && $("#TaskClearAllFilter").css("display") == "none") {
                                AddStageButton = '<button  class="btn-block nostylebtn addwbstaskbtn" onclick="SetHiddenStage(' + scrumestages[i].StageID + ',' + scrumestages[i].OrderNO + ')"  data-bs-toggle="modal" data-bs-target="#divAddStage"><i class="fas fa-plus"></i><%= MyBase.GetResourceString("C_AddStageButton") %></button>';
                            }
                            else {
                                style = 'style=""';
                            }
                            //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21830
                            //var appendString = '  <div id="Stage' + (scrumestages[i].StageID) + '" class="CustomeStage draggablemenu" style="width:425px;height:100%" ><div class="tskcardBox"><div class="wbstaskpanel_heading"  ' + style + ' ><input type="text" ' + EditStageNameAccess + ' id="txt' + scrumestages[i].StageID + '" onchange="UpdateStageName(' + scrumestages[i].StageID + ')" maxlength="50" style="background: rgba(0,0,0,0);border: none;text-align: center;"  value="' + scrumestages[i].StageName + '"  autocomplete="off" ></input></div><input type="hidden" value=' + scrumestages[i].StageID + ' id=hdnStageId' + scrumestages[i].StageID + '>' + AddStageButton + '</div></div></div>'; //<div class="taskcardbox ui-sortable-placeholder"  ></div>
                            var appendString = '  <div id="Stage' + (scrumestages[i].StageID) + '" class="CustomeStage draggablemenu" style="width:425px;height:100%" ><div class="tskcardBox"><div class="wbstaskpanel_heading"  ' + style + ' ><input type="text" ' + EditStageNameAccess + ' id="txt' + scrumestages[i].StageID + '" onchange="UpdateStageName(' + scrumestages[i].StageID + ')" maxlength="50" style="background: rgba(0,0,0,0);border: none;text-align: center;"  value="' + scrumestages[i].StageName + '"  autocomplete="off" disabled="disabled"></input></div><input type="hidden" value=' + scrumestages[i].StageID + ' id=hdnStageId' + scrumestages[i].StageID + '>' + AddStageButton + '</div></div></div>'; //<div class="taskcardbox ui-sortable-placeholder"  ></div>
                            //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21830
                            $('#draggable-menu').append(appendString);
                            getSplitstring = getSplitstring + ',' + "#Stage" + (scrumestages[i].StageID);
                        }
                        //else if (scrumestages[i].StageName == "Completed" || scrumestages[i].MasterStageID == 3) {
                        else if (scrumestages[i].MasterStageID == "3") {
                            //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21830
                            //var appendString = ' <div id="Stage' + (scrumestages[i].StageID) + '" class="draggablemenu" style="width:425px;height:100%" ><div class="tskcardBox"><div class="wbstaskpanel_heading" style="" ><input type="text" ' + EditStageNameAccess + ' id="txt' + scrumestages[i].StageID + '" onchange="UpdateStageName(' + scrumestages[i].StageID + ')" maxlength="50" style="background: rgba(0,0,0,0);border: none; text-align: center;" value="' + scrumestages[i].StageName + '"  autocomplete="off" ></input><input type="hidden" value=' + scrumestages[i].StageID + ' id=hdnStageId' + scrumestages[i].StageID + '></div></div></div>'; //<div class="taskcardbox ui-sortable-placeholder" ></div>
                            var appendString = ' <div id="Stage' + (scrumestages[i].StageID) + '" class="draggablemenu" style="width:425px;height:100%" ><div class="tskcardBox"><div class="wbstaskpanel_heading" style="" ><input type="text" ' + EditStageNameAccess + ' id="txt' + scrumestages[i].StageID + '" onchange="UpdateStageName(' + scrumestages[i].StageID + ')" maxlength="50" style="background: rgba(0,0,0,0);border: none; text-align: center;" value="' + scrumestages[i].StageName + '"  autocomplete="off" disabled="disabled"></input><input type="hidden" value=' + scrumestages[i].StageID + ' id=hdnStageId' + scrumestages[i].StageID + '></div></div></div>'; //<div class="taskcardbox ui-sortable-placeholder" ></div>
                            //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21830
                            $('#draggable-menu').append(appendString);
                            getSplitstring = getSplitstring + ',' + "#Stage" + (scrumestages[i].StageID);
                        }
                        else {
                            //debugger;
                            var AddStageButton = '';
                            //Added & Commented By Dipali V On 13th Feb 2020 For Filter
                            // if (AddRole == "True" )
                            if (AddRole == "True" && $("#TaskClearAllFilter").css("display") == "none") {
                                AddStageButton = '<button  class="btn-block nostylebtn addwbstaskbtn" onclick="SetHiddenStage(' + scrumestages[i].StageID + ',' + scrumestages[i].OrderNO + ')"  data-bs-toggle="modal" data-bs-target="#divAddStage"><i class="fas fa-plus"></i><%= MyBase.GetResourceString("C_AddStageButton") %></button>';
                            }
                            else {
                                style = 'style=""';
                            }
                            //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21830
                            //var appendString = '  <div id="Stage' + (scrumestages[i].StageID) + '" class="CustomeStage draggablemenu"  style="width:425px;height:100%" ><div class="tskcardBox"><div  onmouseover="ShowButton(this)" onmouseout="HideButton(this)" class="wbstaskpanel_heading" ' + style + ' ><input type="text" ' + EditStageNameAccess + ' autocomplete="off"  id="txt' + scrumestages[i].StageID + '" onchange="UpdateStageName(' + scrumestages[i].StageID + ')" maxlength="50" style="background: rgba(0,0,0,0);border: none;text-align: center;" value="' + scrumestages[i].StageName + '" > ' + (scrumestages[i].StageName != "To-Do-List" ? ' <a javascript:; id="btnDeleteStage" class="btn nostylebtn"></input><img src="../../../Whizible2.0-new/dist/img/trash.svg"  onclick="DeleteStage(' + scrumestages[i].StageID + ')" height="20" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Delete"></a>' : "") + '</div><input type="hidden" value=' + scrumestages[i].StageID + ' id=hdnStageId' + scrumestages[i].StageID + '>' + AddStageButton + '</div></div></div>'; //<div class="taskcardbox ui-sortable-placeholder"></div>
                            var appendString = '  <div id="Stage' + (scrumestages[i].StageID) + '" class="CustomeStage draggablemenu"  style="width:425px;height:100%" ><div class="tskcardBox"><div  onmouseover="ShowButton(this)" onmouseout="HideButton(this)" class="wbstaskpanel_heading" ' + style + ' ><input type="text" ' + EditStageNameAccess + ' autocomplete="off"  id="txt' + scrumestages[i].StageID + '" onchange="UpdateStageName(' + scrumestages[i].StageID + ')" maxlength="50" style="background: rgba(0,0,0,0);border: none;text-align: center;" value="' + scrumestages[i].StageName + '" disabled="disabled"> ' + (scrumestages[i].StageName != "To-Do-List" ? ' <a  id="btnDeleteStage" class="btn nostylebtn"></input><img src="../../../Whizible2.0-new/dist/img/trash.svg"  onclick="DeleteStage(' + scrumestages[i].StageID + ')" height="20" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Delete"></a>' : "") + '</div><input type="hidden" value=' + scrumestages[i].StageID + ' id=hdnStageId' + scrumestages[i].StageID + '>' + AddStageButton + '</div></div></div>'; //<div class="taskcardbox ui-sortable-placeholder"></div>
                            //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21830
                            $('#AddNewStage').append('<input type="hidden" id="hdnDynamicStage" value=' + scrumestages[i].StageID + '/>');


                            $('#draggable-menu').append(appendString);
                            getSplitstring = getSplitstring + ',' + "#Stage" + (scrumestages[i].StageID);
                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $('[data-bs-toggle="popover"]').popover();
                    }

                    MakeSortable();
                    var totalWidth = $('#wbswhizibletab').width();
                    var stageWidth = (totalWidth - 5) / 3;
                    //alert("Total width= " + totalWidth + " and stage width= " + stageWidth);

                    //alert(getSplitstring.split(','));
                    var arryofId = getSplitstring.split(',')
                    //Split(arryofId, {
                    //    minSize: [0, 50, 0],
                    //    elementStyle: (dimension, size, gutterSize) => ({
                    //        'width': stageWidth + 'px',
                    //        //'flex-basis': `calc(33.3333% - 10px)`,
                    //    }),
                    //    gutterStyle: (dimension, gutterSize) => ({
                    //        'flex-basis': `${gutterSize}px`,
                    //    }),
                    //});

                    //var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                    //if (ActiveTab == "tabActive") {
                    //

                    //Added & Commented By Dipali V On 10th Feb 2020 Filter Should be Remain same even after Add new Task
                    //GetProjectTasks(IsActive, WhichTask, '<%=m_roleLevel%>', '', '', '', '');
                    var employeeid = $("#cboEmployeeIDFilter").val();
                    var tasktypeid = $("#cboTaskTypeFilter").val();
                    var startdate = $("#txtStartDateFilter").val();
                    var enddate = $("#txtEndDateFilter").val();


                    GetProjectTasks(IsActive, WhichTask, '<%=m_roleLevel%>', employeeid, tasktypeid, startdate, enddate);

                    clearTooltip();
                    //End of Added By Dipali V On 10th Feb 2020 Filter Should be Remain same even after Add new Task
                    DefaultPositions();
                    MakeAllDivSameSize();
                    //debugger;
                    //IsProjectOver = CheckProjectOver();
                    if (IsProjectOver == 1) {
                        $(".setAccessClass").hide();
                        $(".unFlagSetAccessClass").hide();
                        $("#btnAddTasks").prop("disabled", true);
                        $("#btnMainDelete").prop("disabled", true);
                        $("#btnSaveStage").prop("disabled", true);
                        $("#btnimport").prop("disabled", true);
                    }
                    //}
                    //else if (ActiveTab == "tabAll") {
                    //    GetProjectTasks(0);
                    //}
                    //StopAjaxLoader("#bodywbs");

                },
                error: function (result) {
                    //StopAjaxLoader("#bodywbs");
                    //
                    //console.log(result);
                }
            })
        }
        //#endregion

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   Show button
         * Author           :   Chandrashekhar Salagar
         * @param div
         */
        function ShowButton(div) {
            if (DeleteRole == "True") {
                var button = $(div).find('button');
                $(button).show();
                $(button).addClass('displaybutton');
                $('[data-bs-toggle="tooltip"]').tooltip();
                $('[data-bs-toggle="popover"]').popover();
            }
        }

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   hide button
         * Author           :   Chandrashekhar Salagar
         * @param div
         */
        function HideButton(div) {
            var button = $(div).find('button');
            //console.log(button);
            $('[data-bs-toggle="tooltip"], .tooltip').tooltip();
        }

        // Set hidden field attribute to maintain order number for newly created stage
        function SetHiddenStage(id, Ordrer) {
            //var getHiddenStage = $('#hdnStageId' + id).val();
            $('#hdnModalStage').val(id);
            $('#hdnModalOrder').val(Ordrer);
            //added by Vishal M 13-01-2020
            document.getElementById('txtStageName').value = '';
            $("#txtStageName").focus();
        }

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will update stage name which are custome stages.
         * Author           :   Chandrashekhar Salagar.
         * @param StageId
         */
        ////Update Stage Name
        function UpdateStageName(StageId) {
            //debugger;
            var getStageName = $('#txt' + StageId).val().trim();
            var UserName = '<%= Session("intUserID") %>';
            var ProjectId = document.getElementById("CboProject").value;
            //Added By Dipali V On 22nd Jan 2020 For Stage Name mandatory
            if (getStageName == "") {
                showAlert("'Stage Name' should not be blank", 'alert-danger');
                $('#txt' + StageId).focus();
                return;
            }
            //End of Added By Dipali V On 22nd Jan 2020 For Stage Name mandatory
            //alert(getStageName);
            var updateStageName = {
                StageID: encodeURI(StageId),
                StageName: Trim(encodeURI(replaceAllChar(getStageName))),
                EmployeeName: encodeURI(UserName)
            };
            //Commented by Chetan M on 10th Feb 2020
            <%--$.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/UpdateStageName',
                type: "POST",
                data: JSON.stringify(updateStageName),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (updateStageName) {
	                    xhr.setRequestHeader("Params", encryptString(isJson(updateStageName) ? updateStageName : JSON.stringify(updateStageName)));
                    }
                },
                async: false,
                success: function (scrumestages) {
                    showAlert('<%= MyBase.GetResourceString("C_StageNameUpdated") %>', 'alert-success');
                    //document.getElementById('txtStageName').value = '';
                    $('#txt' + StageId).val("");
                    //Added By Dipali V On 24th Jan 2020 for filter Issues
                    if (IsMPPTask == 1) {
                        WhichTask = "M";
                    } else {
                        WhichTask = "";

                    }
                    var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                    if (ActiveTab == "tabActive") {
                        IsActiveTasks = "1";
                    }
                    else if (ActiveTab == "tabAll") {
                        IsActiveTasks = "0";
                    }
                    //End of Added By Dipali V On 24th Jan 2020 for filter Issues
                    GetDefaultStages(ProjectId, IsActiveTasks, WhichTask)
                    //Added & Commented By Dipali V On 22nd Jan 2020 For IssueID 21220
                    if (IsWhizibleTask == 1) {
                        GetWhizibleTask();
                    } else if (IsMPPTask == 1) {

                        GetMPPTasks();
                    }
                    //End of Added & Commented By Dipali V On 22nd Jan 2020 For IssueID 21220
                },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    //alert(err.Message);

                    if (xhr.responseText.includes("Violation of UNIQUE KEY constraint")) {
                        //showAlert('<%= MyBase.GetResourceString("C_StartDate") %>', 'alert-danger');
                        //document.getElementById('txtStageName').value = '';
                        $('#txt' + StageId).val("");
                        //Added By Dipali V On 24th Jan 2020 for filter Issues
                        if (IsMPPTask == 1) {
                            WhichTask = "M";
                        } else {
                            WhichTask = "";

                        }
                        var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                        if (ActiveTab == "tabActive") {
                            IsActiveTasks = "1";
                        }
                        else if (ActiveTab == "tabAll") {
                            IsActiveTasks = "0";
                        }
                        //End of Added By Dipali V On 24th Jan 2020 for filter Issues
                        GetDefaultStages(ProjectId, IsActiveTasks, WhichTask);
                    }
                }
                // })
            });--%>
            //End of commented by Chetan M on 10th Feb 2020

        }

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will save new stage in between InProgres and Completed.
         * Author           :   Chandrashekhar Salagar.
         * @param id
         */
        //#region AddNewStage 
        function SaveStage(id) {
            //added by Vishal M 13-01-2020
            var Name = document.getElementById("txtStageName").value.trim();
            if (Name == "") {
                showAlert("'Stage Name' should not be blank", 'alert-danger');
                $("#txtStageName").focus();
                return;
            }
            if (checkSpecialCharacter(Name, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Stage Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtStageName").focus();
                return;
            }
            UpdateAllOrders();
            var StageID = $('#hdnModalStage').val();
            var OrderNumber = $('#hdnModalOrder').val();
            var UserName = '<%= Session("strUserName") %>';
            var StageName = document.getElementById("txtStageName").value;
            var OrderNumber = parseInt(OrderNumber) + 1;
            var ProjectId = document.getElementById("CboProject").value;
            var IsCustomeStage = "1";
            var ColorID = "1";
            var CreatedBy = UserName;
            //added by Vishal M 13-01-2020
            var scrumeStagesParameter = {
                StageName: encodeURI(Trim(replaceAllChar($("#txtStageName").val()))),
                OrderNo: encodeURI(OrderNumber),
                IsCustom: encodeURI(IsCustomeStage),
                ProjectID: encodeURI(ProjectId),
                ColorID: encodeURI(ColorID),
                CreatedBy: encodeURI(CreatedBy),
                MasterStageID: 4
            }

            //console.log(scrumeStagesParameter);
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/SaveStage',
                type: "POST",
                data: JSON.stringify(scrumeStagesParameter),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (scrumeStagesParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(scrumeStagesParameter) ? scrumeStagesParameter : JSON.stringify(scrumeStagesParameter)));
                    }
                },
                async: false,
                success: function (scrumestages) {
                    // debugger;
                    //Added By Dipali V On 23rd Jan 2020 For Focus should go after adding stage
                    var scrumestages = scrumestages.split("||");
                    //End of Added By Dipali V On 23rd Jan 2020 For Focus should go after adding stage
                    //added by Vishal M 13-01-2020
                    if (scrumestages[0] == "1") {
                        $("#divAddStage").modal("hide");
                        document.getElementById('txtStageName').value = '';
                        //Added By Dipali V On 24th Jan 2020 for filter Issues
                        if (IsMPPTask == 1) {
                            WhichTask = "M";
                        } else {
                            WhichTask = "";

                        }
                        var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                        if (ActiveTab == "tabActive") {
                            IsActiveTasks = "1";
                        }
                        else if (ActiveTab == "tabAll") {
                            IsActiveTasks = "0";
                        }
                        //End of Added By Dipali V On 24th Jan 2020 for filter Issues
                        GetDefaultStages(ProjectId, IsActiveTasks, WhichTask)
                        showAlert('<%= MyBase.GetResourceString("C_NewStageCreatedSuccessfully") %>', 'alert-success');
                    } else {
                        showAlert('<%= MyBase.GetResourceString("C_StageNameAlreadyExits") %>', 'alert-danger');
                        $("#txtStageName").focus();
                    }
                    //Added & Commented By Dipali V On 22nd Jan 2020 For IssueID 21220
                    if (IsWhizibleTask == 1) {
                        GetWhizibleTask();
                    } else if (IsMPPTask == 1) {

                        GetMPPTasks();
                    }
                    $("select option").removeAttr("title");//Remove Placeholder
                    //Added By Dipali V On 23rd Jan 2020 For Focus should go after adding stage
                    $("#txt" + scrumestages[1]).focus();
                    //End of Added By Dipali V On 23rd Jan 2020 For Focus should go after adding stage
                    //End of Added & Commented By Dipali V On 22nd Jan 2020 For IssueID 21220
                },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    //alert(err.Message);
                    //console.log(xhr.responseText);
                    if (xhr.responseText.includes("Violation of UNIQUE KEY constraint")) {
                        showAlert('<%= MyBase.GetResourceString("C_StageNameAlreadyExits") %>', 'alert-danger');
                        document.getElementById('txtStageName').value = '';
                    }
                }
            })
        }
        //#endregion

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will delete the stage which is custom.
         * Author           :   Chandrashekhar Salagar.
         * @param id
         * 
         */
        function DeleteStage(StageID) {
            //debugger;
            //alert();
            //added by omkar 29/01/2020
            var divid = "#Stage" + StageID + " .taskcardbox ";
            if ($(divid).length > 0) {
                showAlert('This Stage can not be deleted.', 'alert-danger');
            } else {
                //end of added by omkar 29/01/2020
                var ProjectId = document.getElementById("CboProject").value;
                var deleteStage = {
                    StageID: encodeURI(StageID)
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_wbs_card/DeleteStage',
                    type: "POST",
                    data: JSON.stringify(deleteStage),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (deleteStage) {
                            xhr.setRequestHeader("Params", encryptString(isJson(deleteStage) ? deleteStage : JSON.stringify(deleteStage)));
                        }
                    },
                    async: false,
                    success: function (Message) {
                        //debugger;
                        //Added By dipali V On 24th Jan 2020 For Filter Isuses
                        var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                        if (ActiveTab == "tabActive") {
                            IsActiveTasks = "1";
                        }
                        else if (ActiveTab == "tabAll") {
                            IsActiveTasks = "0";
                        }
                        if (IsMPPTask == 1) {
                            WhichTask = "M";
                        } else {
                            WhichTask = "";

                        }
                        //End of Added By dipali V On 24th Jan 2020 For Filter Isuses
                        GetDefaultStages(ProjectId, IsActiveTasks, WhichTask)

                        //Commented And Added By Reshma Chavan on 5th Nov 2020 for deletion ofStage for JD-28068
                        //if (Message == "1") {
                        if (Message == "Stage Deleted Successfully") {
                            //end of Commented And Added By Reshma Chavan on 5th Nov 2020 for deletion ofStage for JD-28068
                            showAlert('<%= MyBase.GetResourceString("C_StageDeletedSuccessfully") %>', 'alert-success');
                        }
                        else {
                        //Commented and added by Chetan M on 27 Aug 2020 for Issue ID = 26667
                        //showAlert('<%= MyBase.GetResourceString("C_TaskArePresentForThisStage") %>', 'alert-danger');
                            setTimeout(function () {
                                showAlert('<%= MyBase.GetResourceString("C_TaskArePresentForThisStage") %>', 'alert-danger');
                            }, 3500);
                            //End of Commented and added by Chetan M on 27 Aug 2020 for Issue ID = 26667
                        }
                        //Added & Commented By Dipali V On 22nd Jan 2020 For IssueID 21220
                        if (IsWhizibleTask == 1) {
                            GetWhizibleTask();
                        } else if (IsMPPTask == 1) {

                            GetMPPTasks();
                        }
                        $("select option").removeAttr("title");//Remove Placeholder
                        //  //Added By Dipali V On 23rd Jan 2020 For Focus should go after adding stage
                        // $("#txt" + scrumestages[1]).focus();
                        ////End of Added By Dipali V On 23rd Jan 2020 For Focus should go after adding stage
                        //End of Added & Commented By Dipali V On 22nd Jan 2020 For IssueID 21220
                    },
                    error: function (xhr, status, error) {

                    }
                })
                //added by omkar 29/01/2020
            }
            //end of added by omkar 29/01/2020
        }

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   function will update order of task vertically.
         * Author           :   Chandrashekhar Salagar.
         * @param id
         * */
        //#region updateAll ordres
        function UpdateAllOrders() {
            var StageID = $('#hdnModalStage').val();
            var UserName = '<%= Session("strUserName") %>';
            var divs = "";

            $('#Stage' + StageID).nextAll('.CustomeStage').each(function (index) {
                var Id = this.id.substring(5);
                divs = divs + Id + ',';
            });

            divs = divs.substring(0, divs.length - 1);
            if (divs) {
                var updateStage = {
                    StageName: divs,
                    EmployeeName: encodeURI(UserName),
                }
                //console.log(updateStage);

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_wbs_card/UpdateAllStageOrders',
                    type: "POST",
                    data: JSON.stringify(updateStage),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (updateStage) {
                            xhr.setRequestHeader("Params", encryptString(isJson(updateStage) ? updateStage : JSON.stringify(updateStage)));
                        }
                    },
                    async: false,
                    success: function (Message) {
                    },
                    error: function (xhr, status, error) {

                    }
                })
            }
        }
        //#endregion


        /**
         * Created Date     :   22 Aug 2019
         * Purpose          :   DownloadReport
         * Author           :   Chanrashekhar Salagar.       
         //* @param ReportFormat
         */
        function DownloadReport(ReportFormat) {
            // alert(ReportFormat);
            var reportformat = ReportFormat;
            var WhichTask;
            var IsActiveTasks = "";
            var projectID = $("#CboProject option:selected").val();
            var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
            var getClassName = $('#tabWhizibleTasks').attr('class');

            if (ActiveTab == "tabActive") {//Get active tasks for report.
                IsActiveTasks = "1";
            }
            else if (ActiveTab == "tabAll") {//Get inactive tasks for report.
                IsActiveTasks = "0";
            }

            if (getClassName == "tab-slider--trigger active") {//Get whizible or mpp tasks
                WhichTask = "";
            }
            else {
                WhichTask = "M";
            }
            //add and change by omkar 30/01/2020
            var pm_Wbs_Card = {
                //end of add and change by omkar 30/01/2020
                ProjectID: encodeURI(projectID),
                IsActive: encodeURI(IsActiveTasks),
                LoginID: encodeURI(LoginId),
                WhichTask: encodeURI(WhichTask),
                ReportFormat: encodeURI(reportformat),
                RoleAccess: encodeURI('<%=m_roleLevel%>')
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/ExportDocument',
                type: "POST",
                //add and change by omkar 30/01/2020
                data: JSON.stringify(pm_Wbs_Card),
                //end of add and change by omkar 30/01/2020
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (pm_Wbs_Card) {
                        xhr.setRequestHeader("Params", encryptString(isJson(pm_Wbs_Card) ? pm_Wbs_Card : JSON.stringify(pm_Wbs_Card)));
                    }
                },
                success: function (data) {


                    //alert("Success");
                    if (data == "") {
                        showAlert('<%= MyBase.GetResourceString("C_Records_are_not_available to_download_report") %>', 'alert-danger');
                        // alert("NOT");
                    }
                    else {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");
                    }


                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        function ChangeView() {
            var viewName = $('#CboTaskView').find(":selected").text();
            if (viewName.toUpperCase() == "Gantt View".toUpperCase()) {
                var projectID = $("#CboProject option:selected").val();
                window.location.href = "wbs.aspx?ProjectID=" + projectID;

            }

        }
        //#region Alerts
        function showAlert(Msg, className, id) {
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
        //endregion

        var ProjectOnHold = "";
        var ProjectOnHoldMsg = "";
        var BaselineNumber = "";
        var BaseLineMessage = "";
        var ProjectBillable = "";
        var SelectedCurrentdate = "";
        var IsProjectOver = 0;
        var selectedDivID = "";
        $(document).ready(function () {
            //debugger
            //Added By Riddhesh Patil on 9 May 2023 for dropdown not closing Issue

            $("body").on("click", "[data-bs-toggle='dropdown']", function () {
                $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
                $(this).closest(".dropdown']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

            });

            $('body').on('click', function (e) {
                $('[data-bs-toggle="dropdown"]').each(function (e) {
                    // hide any open popovers when the anywhere else in the body is clicked
                    if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.dropdown .dropdown-menu').has(e.target).length === 0) {
                        $(".dropdown-menu").removeClass('show');
                    }
                });
            });
            //End of Added By Riddhesh Patil on 9 May 2023 for dropdown not closing Issue

            IsProjectOver = CheckProjectOver();
            ////by vishal m 15-01-2020
            clearTooltip();//Added by Dipali V On 21st Jan 2020 For Remove ToolTip
            enableDisabledControls();
            $("select option").removeAttr("title");//Remove Placeholder
            $('select[name=CboProject] > option:first-child').text('Select Project');
            GetSessionProject();

            $('.dropdown-menu.flagdetailswrap').on('click', function (event) {
                event.stopPropagation();
            });

            //Commented By Riddhesh Patil on 11 May 2023
            //$('.selectpicker').selectpicker({
            //    container: 'body'
            //});
            //End of Commented By Riddhesh Patil on 11 May 2023
            //below script use for for working option selectipicker in dropdown menu.
            $('body').on('click', function (event) {
                var target = $(event.target);
                if (target.parents('.bootstrap-select').length) {
                    event.stopPropagation();
                    $('.bootstrap-select.open').removeClass('open');
                }
            });

            $('[data-bs-toggle="tooltip"]').tooltip();

            $(document).on('click.bs.dropdown.data-api', '.dropdown.keep-inside-clicks-open, .ui-datepicker', function (e) {
                e.stopPropagation();
            });

            //Added By Riddhesh Patil on 11 May 2023 
            $('.ui-datepicker').click(function (e) {
                e.stopPropagation();
            });
            //End of Added By Riddhesh Patil on 11 May 2023 

            $('.dropdown-menu.flagdetailswrap').click(function (e) {
                e.stopPropagation();
            });

            /*$('.flagdetailswrap .selectpicker').selectpicker({
                container: 'body'
            });*/

            /*
             $('.selectpicker').on('change', function () {
                 $('.selectpicker').selectpicker('refresh');
             });
     
            $(".selectpicker").selectpicker('refresh').empty().append(output).selectpicker('refresh').trigger('change');*/

            //Added By Dipali V On 12th Feb 2020 For Currentdate
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
            //End of Added By Dipali V On 12th Feb 2020 For Currentdate

            //added by Vishal Mahajan 09-01-2020
            //$('#txtStartDate, #txtStartDateFilter, #txtEndDate, #txtEndDateFilter').datepicker({
            //    autoclose: true,
            //    changeMonth: true,
            //    changeYear: true,
            //    //dateFormat: 'dd M yy'
            //});
         
            //datepicker
            //$('#duedate, #duedate1, #duedate2, #duedate3, #duedate4, #duedate5, #duedate6, #duedate7, #duedate8, #duedate9, #duedate10, #statuschangedate1, #TskinfoModalSD, #TskinfoModalED, #statuschangedate1').datepicker({
            //    autoclose: true,
            //    changeMonth: true,
            //    changeYear: true,
            //  //  dateFormat: 'dd MM yy'
            //});

            //start bootstrap datepicker css

            //Commented by Riddhesh Patil for file upload issue on 27 Sep 2024
            //$(document).on('click', '.browse', function () {
            //    var file = $(this).parent().parent().parent().find('.file');
            //    file.trigger('click');
            //});
            //End of Commented by Riddhesh Patil for file upload issue on 27 Sep 2024
            $(document).on('change', '.file', function () {
                $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
            });

            //$(".modal").scroll(function () {
            //    $('#ui-datepicker-div').hide();
            //});

            //Multiselect
            $(function () {
                $('.multiselectdropdown').multiselect({
                    includeSelectAllOption: true,
                    countSelectedText: false,
                    nSelectedText: false,
                    allSelectedText: false,
                    selectAllJustVisible: false,
                    numberDisplayed: 999999999999,

                    nonSelectedText: ' ',
                    delimiterText: '/ '
                });



            });

            //Attachments start
            //this is for file attache and drop script

            $('form input').change(function () {
                $('form p').text(this.files.length + " file(s) selected");
            });

            //add attachment
            var counter = 0;

            var i = "1";
            var j = "1";
            var k = "1";
            $("#addattachnebtrow").on("click", function () {
                var newRow = $("<tr>");
                var cols = "";
                cols += '<td><textarea id="Adescription' + i + '" class="form-control" name="name' + counter + '"/><textarea</td>';
                cols += '<td><input id="Afilname' + j + '" type="file" name="img[]" class="file">                                            <div class="input-group col-xs-12 fileup"><span class="input-group-btn"><button class="browse browsebtn" type="button"><i class="fas fa-paperclip"></i></button></span><input type="text" class="form-control" disabled="" placeholder="Upload Image"></td>'
                cols += '<td><input id="Adate' + k + '" placeholder="00/00/0000" type="text" class="form-control attachdate" name="phone' + counter + '"/></td>';

                cols += '<td><button class="ibtnDel nostylebtn" title=""><i class="far fa-trash-alt" value="Delete"></i></button></td>';
                newRow.append(cols);
                $("table.order_attchmentlist").append(newRow);
                $('table.order_attchmentlist').find('.attachdate').datepicker();
                i++;
                j++;
                k++;
                counter++;
            });


            $("#saveskill").click(function () {
                $("table.order_attchmentlist tbody tr:nth-last-child(1)").css('display', 'none');
                for (var i = 1; i <= counter; i++) {
                    var Adescription = $("#Adescription" + i).val();
                    var Afilname = $("#Afilname" + i).val();
                    var Adate = $("#Adate" + i).val();
                    var markup = "<tr><td>" + Adescription + "</td><td>" + Afilname + "</td><td>" + Adate + "</td></tr>";
                    $("table.order_attchmentlist tbody").append(markup);
                }
            });


            $("table.order_attchmentlist").on("click", ".ibtnDel", function (event) {
                $(this).closest("tr").remove();
                counter -= 1
            });

            //start bootstrap datepicker css  
            $('#mnthfield1').datepicker({
                autoclose: true,
            });

            // Delete row on delete button click
            $(document).on("click", ".delattachbtn", function () {
                $(this).parents("tr").remove();
                //$(".add-new").removeAttr("disabled");
            });

            //Attachments end
            //date range picker in task editor
            //$('#date-range23').dateRangePicker(
            //    {
            //        singleMonth: true,
            //        showShortcuts: false,
            //        showTopbar: false,
            //        format: 'Do MMM, YYYY'  //more formats at http://momentjs.com/docs/#/displaying/format/
            //    });
            //full-height
            //$('#wbswhizibletab').css('height', $(window).height()+'px');
            //Commented by Vaijat K
            //$('#wbswhizibletab').css('height', 'calc(100vh - 195px)');

            $(".flagdetailswrap .form-group .btn.btnyellow").click(function () {
                $(".flagdetailpoover.dropdown").removeClass("open");
            });

            $('body').on('click', function (event) {
                var target = $(event.target);
                if (target.parents('.flagdetailswrap .bootstrap-select').length) {
                    event.stopPropagation();
                    $('.flagdetailswrap .bootstrap-select.open').removeClass('open');
                }
            });

            //Search task list
            $("#wbssearchinputtasklist").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $(".dropdown-menu li").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
                //debugger;
                var numOfVisibleli = $('#divSearchBar ul li').text();
                if (numOfVisibleli == "No data available in table") {
                    $('#divSearchBar ul').hide();
                }
            });

        });



        //for fill flag
        /*$(".Tskflag").click(function(){
        $(this).toggleClass("Tskflagactive");
        });*/

        //script for pophover
        $("[data-bs-toggle=popover]").each(function (i, obj) {
            $(this).popover({
                html: true,
                trigger: 'click',
                content: function () {
                    var id = $(this).attr('id');
                    return $('#popover-content-' + id).html();
                    //alert();
                }
            });
        });

        $('body').on('click', function (e) {
            $('[data-bs-toggle="popover"]').each(function () {
                //the 'is' for buttons that trigger popups
                //the 'has' for icons within a button that triggers a popup
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
                    $(this).popover('hide');
                }
            });
        });

    //end script for popover
    </script>


    <script type="text/javascript">
        //this is for file attache and drop script

        //$('form input').change(function () {
        //    $('form p').text(this.files.length + " file(s) selected");
        //});


        //Used for Active and All task tab slide
        $(".WBSactivnall .tab-slider--nav li").click(function () {

            $(".tab-slider--body1").hide();
            var activeTab = $(this).attr("rel");
            $("#" + activeTab).fadeIn();
            if ($(this).attr("rel") == "wbsalltasktab") {
                $('.WBSactivnall .tab-slider--tabs').addClass('slide');
                $(".taskcardbox").show();
                $(".taskcardboxActive").show();

            } else {
                $('.WBSactivnall .tab-slider--tabs').removeClass('slide');
                //$(".taskcardbox").hide();
                $(".taskcardboxActive").show();
            }
            $(".WBSactivnall .tab-slider--nav li").removeClass("active");
            $(this).addClass("active");


        });

        if ($(".WBSactivnall .tab-slider--nav li").hasClass("active")) {
            $(".taskcardbox").hide();
            $(".taskcardboxActive").show();
        }

        //Used for Whizible and MPP task tab slide
        $(".WBSwhizndmpptask .tab-slider--nav li").click(function () {
            $(".tab-slider--body2").hide();
            var activeTab2 = $(this).attr("rel");
            $("#" + activeTab2).fadeIn();
            if ($(this).attr("rel") == "wbsmpptab") {
                $('.WBSwhizndmpptask .tab-slider--tabs').addClass('slide');
                $('#wbswhizibletab').show();
                $(".taskcardbox").show();
                $(".taskcardboxActive").show();
            } else {
                $('.WBSwhizndmpptask .tab-slider--tabs').removeClass('slide');
                $(".taskcardboxActive").show();
            }
            $(".WBSwhizndmpptask .tab-slider--nav li").removeClass("active");
            $(this).addClass("active");
        });

        if ($(".WBSwhizndmpptask .tab-slider--nav li").hasClass("active")) {
            $(".taskcardbox").hide();
            $(".taskcardboxActive").show();
        }

    </script>

    <script>
        //check and uncheck checkbox
        // Check or Uncheck All checkboxes

        //checkall_filter_section
        $(".filterpanelwrap .chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(this).closest(".col-sm-2").find("ul .chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(this).closest(".col-sm-2").find("ul .chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".filterpanelwrap .chcktbl").click(function () {
            if ($(this).closest(".col-sm-2").find("ul .chcktbl").length == $(this).closest(".col-sm-2").find(".chcktbl:checked").length) {
                $(this).closest(".col-sm-2").find(".chckHead").prop("checked", true);
            } else {
                $(this).closest(".col-sm-2").find("ul .chckHead").removeAttr("checked");
            }

        });

        //checkall for table
        $(".corporateroles table .chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".corporateroles table .chcktbl").each(function () {
                    $(this).prop("checked", true);

                });
            } else {
                $(".corporateroles table .chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".corporateroles .chcktbl").click(function () {

            if ($(".corporateroles table .chcktbl").length == $(".corporateroles table .chcktbl:checked").length) {
                $(".corporateroles table .chckHead").prop("checked", true);
            } else {
                $(".corporateroles table .chckHead").removeAttr("checked");
            }
        });

        //auto search for corporate roles
        $("#searchCR").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#CRTable tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });

    </script>


    <script>   
        /**
         * Created Date     :   04 Sept 2019
         * Purpose          :   Maintain history of changed task card for undo 
         * Author           :   Chanrdashekhar Salagar.
         * @param startDivId
         */
        function ChangedPosition(taskNo, StageID) {
            var listItem = {
                StageId: StageID,
                TaskCard: taskNo,
            }
            list.push(listItem);
        }

        var startDivId;
        var currentMovedDiv = "";
        var ProjectID = $("#CboProject").val();

        function MakeAllDivSameSize() {
            var test_elements = document.getElementsByClassName("draggablemenu");
            var max_height = 0;
            for (var i = 0; i < test_elements.length; i++) {
                var test_elements_width = $(test_elements[i]).height();
                max_height = Math.max(max_height, test_elements_width);
            }
            $('.draggablemenu').css("height", max_height + 'px');
            $('.gutter').css("height", max_height + 'px');
            /*Added by Omkar T on 14-01-20*/
            $("#sectionMain").height(window.innerHeight - 135);
            //$('.dropdown-menu').on('click', function (e) {
            //    e.stopPropagation();
            //});
            //$("#sectionMain").scroll(function () {
            //    $(".wbstaskpanel_heading").css("position", "relative");
            //    $(".wbstaskpanel_heading").css("top", $("#sectionMain").scrollTop() + 'px');
            //    //Added by Omkar T on 14-01-2020
            //    $(".wbstaskpanel_heading").css("z-index", "9");
            //    $(".addwbstaskbtn").css("position", "relative");
            //    $(".addwbstaskbtn").css("top", $("#sectionMain").scrollTop() + 'px');
            //    //Added by Omkar T on 14-01-2020
            //    $(".addwbstaskbtn").css("z-index", "9");
            //    $(".addwbstaskbtn").css("z-index", "9");

            //})

            //Added script by pradip on 15-01-2020
            //$("#sectionMain").scroll(function () {
            //    $(".tskcardBox").css("top", $("#sectionMain").scrollTop() + 'px');

            //});


        }

        //Added by Chetan M on 30th Jan 2020
        var GlobalCount = 0;
        var GlobalWorkHours;
        //End of added by Chetan M on 30th Jan 2020
        function MakeSortable() {
            $('.draggablemenu').sortable(
                {
                    cancel: '.YesvoidTask,.remove, .flagdetailswrap, .Tskflag',//added by Pradip 
                    items: '.taskcardbox',
                    connectWith: '.draggablemenu',
                    start: function (event, ui) {
                        var id = ui.item.attr("id");
                        currentMovedDiv = id;

                        //Commented And Added By Usha Pandit On 02.09.2020 For javascript error while moving task from one stage to another
                        //startDivId = $('#' + id).parent().closest('div').attr('id').split(' ');
                        if ($('#' + id).parent().closest('div').attr('id') != undefined && $('#' + id).parent().closest('div').attr('id') != null && $('#' + id).parent().closest('div').attr('id') != "") {
                            startDivId = $('#' + id).parent().closest('div').attr('id').split(' ');
                        }
                        //End Of Added By Usha Pandit On 02.09.2020 For javascript error while moving task from one stage to another
                    },
                    update: function (event, ui) {
                        // debugger;
                        var FirstStage = $("#draggable-menu").children(":first").attr("id");
                        var divs = '';
                        var id = ui.item.attr("id");
                        //Commented And Added By Usha Pandit On 02.09.2020 For javascript error while moving task from one stage to another
                        //var getStagediv = $('#' + id).parent().closest('div').attr('id').split(' ');                        
                        if ($('#' + id).parent().closest('div').attr('id') != undefined && $('#' + id).parent().closest('div').attr('id') != null && $('#' + id).parent().closest('div').attr('id') != "") {
                            var getStagediv = $('#' + id).parent().closest('div').attr('id').split(' ');
                        }
                        //End Of Added By Usha Pandit On 02.09.2020 For javascript error while moving task from one stage to another
                        //currentMovedDiv = getStagediv;
                        var hiddenStagId = $('#' + getStagediv).find('input[type=hidden]:first').val();// If dropped stage is 1 or TO DO LIST then prevent dropping non that stage.//
                        CheckForDailyActivty(id)


                        if (FirstStage == getStagediv || m_EditAccess == "False" || parseInt(DailyTask) == 0) {
                            var hiddenStagId = $('#' + currentMovedDiv).find('input[type=hidden]:first').val();
                            ChangedPosition(id, hiddenStagId);
                            var alertMessage;
                            if (FirstStage == getStagediv || startDivId[0] == getStagediv) {
                                // debugger;
                                if (startDivId[0] == getStagediv[0]) {

                                    $('#' + getStagediv + ' > div').map(function () {
                                        if (this.id.length > 1 && this.id.length != undefined) {
                                            divs = divs + this.id + ',';
                                        }
                                    });
                                    divs = divs.substring(0, divs.length - 1);
                                    var TaskOrderArray = divs;
                                    UpdateTaskCardOrder(TaskOrderArray, $("#CboProject").val(), hiddenStagId);
                                    //alert(id);
                                    var impactedID = impactedID = $('#' + id).next().attr('id');
                                    if (impactedID == undefined) {
                                        impactedID = $('#' + id).prev().attr('id');
                                    }
                                    if (impactedID != undefined) {
                                        UpdatedImpactedTask(id, impactedID, UserName);

                                    }

                                    return;

                                }
                                else {
                                    alertMessage = "Task cannot be moved to this stage.";
                                }
                            }

                            else if (m_EditAccess == "False") {
                                alertMessage = "You don't have access to edit the task";
                            }

                            else if ((parseInt(DailyTask) == 0)) {
                                //Added By Dipali V On 18th Feb 2020 For If Task Move From To-Do to Completed then Task Should be make as void
                                if (FirstStage == "Stage1" && getStagediv == "Stage3") {
                                    //debugger;
                                    $('#' + getStagediv + ' > div').map(function () {
                                        if (this.id.length > 1 && this.id.length != undefined) {
                                            divs = divs + this.id + ',';
                                        }
                                    });

                                    divs = divs.substring(0, divs.length - 1);
                                    var TaskOrderArray = divs;
                                    var DragDivId = startDivId[0];
                                    var DropDivId = getStagediv[0];
                                    if (DragDivId != DropDivId) {

                                        DragDivId = DropDivId.substring(5);
                                        UpdateTaskStage(hiddenStagId, id, DragDivId);
                                        //Added by Chetan M on 30th Jan 2020 for IssueID = 21556
                                        GlobalCount = 1;
                                        UpdateTaskStage(hiddenStagId, id, DragDivId);
                                        //End of Added by Chetan M on 30th Jan 2020 for IssueID = 21556
                                        ChangedPosition(id, DragDivId);
                                        //var impactedID = impactedID = $('#' + id).next().attr('id');
                                        // alert(getStagediv);

                                        var $scroller = $('.horizanalscroll');
                                        var scrollTo = $('#' + getStagediv)
                                            // change its bg

                                            // retrieve its position relative to its parent
                                            .position().left;

                                        // simply update the scroll of the scroller
                                        // $('.scroller').scrollLeft(scrollTo); 
                                        // use an animation to scroll to the destination
                                        $scroller
                                            .animate({ 'scrollLeft': scrollTo }, 500);
                                    }
                                    else {

                                        var hiddenStagId = $('#' + DragDivId).find('input[type=hidden]:first').val();
                                        ChangedPosition(divs, hiddenStagId);
                                    }
                                    UpdateTaskCardOrder(TaskOrderArray, $("#CboProject").val(), hiddenStagId);
                                    var impactedID = impactedID = $('#' + id).next().attr('id');
                                    if (impactedID == undefined) {
                                        impactedID = $('#' + id).prev().attr('id');
                                    }
                                    if (impactedID != undefined) {
                                        UpdatedImpactedTask(id, impactedID, UserName);

                                    }
                                    DeleteTaskcard(id, "Void");

                                    //End of Added By Dipali V On 18th Feb 2020 For If Task Move From To-Do to Completed then Task Should be make as void
                                }
                                else {
                                    alertMessage = "There is no daily activity for this task";
                                }
                            }
                            else {
                                alertMessage = "There is no daily activity for this task";
                            }


                            var WhichTask;
                            var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                            var getClassName = $('#tabWhizibleTasks').attr('class');
                            if (getClassName == "tab-slider--trigger active") {
                                WhichTask = "";
                            }
                            else {
                                WhichTask = "M";
                            }

                            //debugger;
                            if (ActiveTab == "tabActive") {
                                GetDefaultStages($("#CboProject").val(), 1, WhichTask);
                                //alert(getClassName);
                            }
                            else if (ActiveTab == "tabAll") {
                                GetDefaultStages($("#CboProject").val(), 0, WhichTask);
                            }
                            //Added By Dipali V On 27th Feb 2020 For To Do To Completed & To Do - In Progress
                            if (FirstStage != "Stage1" && getStagediv != "Stage3") {

                                showAlert(alertMessage, 'alert-danger');
                            } else if (getStagediv != "Stage3") {
                                showAlert(alertMessage, 'alert-danger');
                            }
                            //End of Added By Dipali V On 27th Feb 2020 For To Do To Completed & To Do - In Progress
                        }
                        else {
                            $('#' + getStagediv + ' > div').map(function () {
                                if (this.id.length > 1 && this.id.length != undefined) {
                                    divs = divs + this.id + ',';
                                }
                            });

                            divs = divs.substring(0, divs.length - 1);
                            var TaskOrderArray = divs;
                            var DragDivId = startDivId[0];
                            var DropDivId = getStagediv[0];
                            if (DragDivId != DropDivId) {

                                DragDivId = DragDivId.substring(5);
                                UpdateTaskStage(hiddenStagId, id, DragDivId);
                                //Added by Chetan M on 30th Jan 2020 for IssueID = 21556
                                GlobalCount = 1;
                                UpdateTaskStage(hiddenStagId, id, DragDivId);
                                //End of Added by Chetan M on 30th Jan 2020 for IssueID = 21556
                                ChangedPosition(id, DragDivId);
                                //var impactedID = impactedID = $('#' + id).next().attr('id');
                                // alert(getStagediv);

                                var $scroller = $('.horizanalscroll');
                                var scrollTo = $('#' + getStagediv)
                                    // change its bg

                                    // retrieve its position relative to its parent
                                    .position().left;

                                // simply update the scroll of the scroller
                                // $('.scroller').scrollLeft(scrollTo); 
                                // use an animation to scroll to the destination
                                $scroller
                                    .animate({ 'scrollLeft': scrollTo }, 500);
                            }
                            else {

                                var hiddenStagId = $('#' + DragDivId).find('input[type=hidden]:first').val();
                                ChangedPosition(divs, hiddenStagId);
                            }
                            UpdateTaskCardOrder(TaskOrderArray, $("#CboProject").val(), hiddenStagId);
                            var impactedID = impactedID = $('#' + id).next().attr('id');
                            if (impactedID == undefined) {
                                impactedID = $('#' + id).prev().attr('id');
                            }
                            if (impactedID != undefined) {
                                UpdatedImpactedTask(id, impactedID, UserName);

                            }
                        }


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

        $('.taskcardbox .remove').on('click', function () {

            $(this).closest('.taskcardbox').remove();
        });

        /**
         * Created Date     :   16 Aug 2019
         * Purpose          :   Update task from one stage to another.
         * Author           :   Chandrashekhar Salagar.
         * @param StageID
         * @param TaskID
         * @param DragDivId
         */

        function UpdateTaskStage(StageID, TaskID, DragDivId) {
            var UserName = '<%= Session("strUserName") %>';
            var ProjectId = document.getElementById("CboProject").value;
            var updateStage = {
                TaskID: encodeURI(TaskID),
                StageID: encodeURI(StageID),
                EmployeeName: encodeURI(UserName),
                ProjectID: encodeURI(ProjectId),
                DragStageID: encodeURI(DragDivId)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/UpdateStage',
                type: "POST",
                data: JSON.stringify(updateStage),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (updateStage) {
                        xhr.setRequestHeader("Params", encryptString(isJson(updateStage) ? updateStage : JSON.stringify(updateStage)));
                    }
                },
                async: false,
                success: function (Message) {
                    //Commented and added by Chetan M on 30th Jan 2020 for IssueID =21556
                    <%--showAlert('<%= MyBase.GetResourceString("C_TaskStageUpdatedSuccessfully") %>', 'alert-success');--%>
                    setTimeout(function () {
                        if (GlobalCount == 1) {
                            showAlert('<%= MyBase.GetResourceString("C_TaskStageUpdatedSuccessfully") %>', 'alert-success');
                            GlobalCount = 0;
                        }
                    }, 3500);
                    //End of Commented and added by Chetan M on 30th Jan 2020 for IssueID =21556

                    document.getElementById('txtStageName').value = '';

                    var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                    //Added By Dipali V On 24th Jan 2020 for filter Issues
                    if (IsMPPTask == 1) {
                        WhichTask = "M";
                    } else {
                        WhichTask = "";

                    }



                    //End of Added By Dipali V On 24th Jan 2020 for filter Issues
                    if (ActiveTab == "tabActive") {
                        GetDefaultStages(ProjectId, 1, WhichTask)
                    }
                    else if (ActiveTab == "tabAll") {
                        $('#tabActive').css('tab-slider-trigger,.active');
                        GetDefaultStages(SessionProjectId, 0, WhichTask);
                    }
                },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    //alert(err.Message);
                    //alert(xhr.responseText);
                }
            })
        }

        /**
         * Created Date     :   16 Aug 2019.
         * Purpose          :   Update task card order.
         * Author           :   Chandrashekhar Salagar.
         * @param tasks
         */
        function UpdateTaskCardOrder(tasks, ProjectID, StageId) {


            var updateStage = {
                OrderNoString: tasks,
                ProjectID: encodeURI(ProjectID),
                StageID: encodeURI(StageId)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/UpdateTaskCardOrder',
                type: "POST",
                data: JSON.stringify(updateStage),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (updateStage) {
                        xhr.setRequestHeader("Params", encryptString(isJson(updateStage) ? updateStage : JSON.stringify(updateStage)));
                    }
                },
                async: false,
                success: function (TaskOrderArray) {
                    //Added By Dipali V On 24th Jan 2020 for filter Issues
                    if (IsMPPTask == 1) {
                        WhichTask = "M";
                    } else {
                        WhichTask = "";

                    }
                    if (ActiveTab == "tabActive") {
                        IsActiveTasks = "1";
                    }
                    else if (ActiveTab == "tabAll") {
                        IsActiveTasks = "0";
                    }
                    GetDefaultStages($("#CboProject").val(), IsActiveTasks, WhichTask);
                    //End of Added By Dipali V On 24th Jan 2020 for filter Issues
                },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    //alert(err.Message);
                }
            })

        }

        /**
         * Created Date     :   16 Aug 2019.
         * Purpose          :   Check if there is daily activity for selected task.
         * Author           :   Chandrashekhar Salagar.
         * @param tasks
         */
        function CheckForDailyActivty(TaskId) {

            var Task = {
                TaskID: encodeURI(TaskId)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/CheckDailyActivity',
                type: "POST",
                data: JSON.stringify(Task),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Task) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Task) ? Task : JSON.stringify(Task)));
                    }
                },
                async: false,
                success: function (Message) {

                    DailyTask = Message;

                },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    //alert(err.Message);
                    //alert(xhr.responseText);
                }
            })
        }

        /**
         * Created Date     :   16 Aug 2019.
         * Purpose          :   function will update impated stage id.
         * Author           :   Chandrashekhar Salagar.
         * @param taskId
         * @param impactedTask
         * @param UserName
         */
        /*Function for update impacted stage id*/
        function UpdatedImpactedTask(taskId, impactedTask, UserName) {
            var impactedTask = {
                TaskID: encodeURI(taskId),
                ImpactedStageID: encodeURI(impactedTask),
                EmployeeName: encodeURI(UserName)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/UpdateImpactedTask',
                type: "POST",
                data: JSON.stringify(impactedTask),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (impactedTask) {
                        xhr.setRequestHeader("Params", encryptString(isJson(impactedTask) ? impactedTask : JSON.stringify(impactedTask)));
                    }
                },
                async: false,
                success: function (Message) {

                },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                }
            })
        }


        /*
         * Created Date     :   20 Aug 2019.
         * Purpose          :   Validate step one.
         * Author           :   Chandrashekhar Salagar.
         */
        $("#btnStepOne").click(function () {
            //debugger

            var getProject = $("#CboProject").val();

            if (getProject.length) {
                if ($("#taskFile").val()) {
                    //var files
                    var fileUpload = $("#taskFile")[0];

                    //Commented And Added By Usha Pandit On 31.08.2020 For identifying/getting correct extension
                    //var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.xlsx|.xls)$/;
                    var regex = /^([a-zA-Z0-9\s_\\.\-:()])+(.xlsx|.xls)$/;
                    //End Of Added By Usha Pandit On 31.08.2020 For identifying/getting correct extension

                    /*Checks whether the file is a valid excel file*/
                    if (regex.test(fileUpload.value.toLowerCase())) {
                        var xlsxflag = false; /*Flag for checking whether excel is .xls format or .xlsx format*/
                        if (fileUpload.value.toLowerCase().indexOf(".xls") > 0) {
                            xlsxflag = true;
                        }
                        if (xlsxflag) {
                            $("#PBEUstep1").removeClass("active");
                            $("#PBEUstep2").addClass("active");
                            //$("#tabStep1").addClass("disabled");
                            $("#tabStep1").removeClass("active");
                            $("#tabStep2").removeClass("disabled");
                            $("#tabStep2").addClass("active");
                            $("#tabStep1").bind("click", function () {
                                $('#btnBackToStepOne').click();
                            });
                        }



                        //$('.ExcelColumn').map(function () {
                        //    $($(this)).val("--Select--");
                        //    $("select option").removeAttr("title");//Remove Placeholder
                        //});


                    }
                    else {
                        //added & Commented By Dipali V On 24th Jan 2020 For alert issues
                         <%-- showAlert('<%= MyBase.GetResourceString("intPostID") %>', 'alert-danger');--%>
                        showAlert('<%= MyBase.GetResourceString("C_PleaseSelectFileFirst") %>', 'alert-danger');
                        //added & Commented By Dipali V On 24th Jan 2020 For alert issues
                    }
                }
                else {
                    //added & Commented By Dipali V On 24th Jan 2020 For alert issues
                   <%-- showAlert('<%= MyBase.GetResourceString("intPostID") %>', 'alert-danger');--%>
                    showAlert('<%= MyBase.GetResourceString("C_PleaseSelectFileFirst") %>', 'alert-danger');
                    //End of added & Commented By Dipali V On 24th Jan 2020 For alert issues
                }
            }
            else {
                 //added & Commented By Dipali V On 24th Jan 2020 For alert issues
              <%-- // showAlert('<%= MyBase.GetResourceString("intUserID") %>', 'alert-danger');--%>
                //commented and add by omkar 04/02/2020
                //showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
                showAlert('Please Select Excel File', 'alert-danger');
                //end of commented and add by omkar 04/02/2020
                //End of added & Commented By Dipali V On 24th Jan 2020 For alert issues

            }
            $("select option").removeAttr("title");//Remove Placeholder
        });


        /*
         * Created Date     :   20 Aug 2019.
         * Purpose          :   Validate step two.
         * Author           :   Chandrashekhar Salagar. 
         */
        var MandatoryFileds = "";
        $("#btnStepTwo").click(function (e) {
            $("select option").removeAttr("title");//Remove Placeholder
            GetProjectConfiguration($("#CboProject").val());
            /*
             *  Validate the excel file for columns and values. This would be a sanity check if the excel file
             *  is valid for upload. If valid the wizard pro
             *  vides an option to click next else a message 'Not a valid file for upload'.
             */
            //debugger
            var isSelectedMandatoryFields = true;
            var selectedcolumn = "";
            //var seqcolumnname = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V"];

            $('.ExcelColumn').map(function () {

                if (($(this).val()) != "--Select--")
                    selectedcolumn = selectedcolumn + "," + $(this).val();



            });

            // debugger;
            var SelectedExcelOptions = selectedcolumn.split(',');//Get selected column values.
            SelectedOptionsForUpload = SelectedExcelOptions;
            var RemoveFirstItem = SelectedExcelOptions.shift();

            //====================CHeck if mandatory field is selected or not========================//
            //debugger;
            //var FileSize = $('#taskFile').get(0).size;
            // alert(FileSize);
            //return;

            for (var i = 0; i < MandatoryFields.length; i++) {
                //debugger;
                if (isSelectedMandatoryFields == true) {
                    var field = MandatoryFields[i];
                    if (MandatoryFileds != "") {
                        MandatoryFileds = field;

                    } else {
                        MandatoryFileds = field;
                    }

                    //Added By Dipali v On 25th Jan 2020 For IE Support Alert
                    var isSelected = "";
                    //var isSelected = SelectedExcelOptions.includes(field)
                    if (SelectedExcelOptions.indexOf(field) != -1) {
                        isSelected = true;
                    } else {
                        isSelected = false;
                    }
                    //End of Added By Dipali v On 25th Jan 2020 For IE Support Alert

                    if (isSelected) {

                        var indexOfItem = MandatoryFieldsError.indexOf(field);
                        if (indexOfItem != -1) {
                            MandatoryFieldsError.splice(indexOfItem, 1);
                        } else {  //Added By Dipali V On 25th Jan 2020 For IssueID 21635
                            continue;
                        }
                        //MandatoryFieldsError = MandatoryFields;
                    }  //Added By Dipali V On 25th Jan 2020 For IssueID 21635
                    else {
                        isSelectedMandatoryFields = false;
                    }  //End of Added By Dipali V On 25th Jan 2020 For IssueID 21635
                } else {
                    MandatoryFieldsError = MandatoryFileds;

                }
                //Added By Dipali V On 25th Jan 2020 For IssueID 21635
                if (MandatoryFileds != "" && isSelectedMandatoryFields == false) {
                    break;
                }
                //End of Added By Dipali V On 25th Jan 2020 For IssueID 21635
            }
            // debugger;
            UploadTasks();
            //if (IsDATA == "1") {
            if (isSelectedMandatoryFields) {

                //UploadTasks();
                if (IsDATA == "1") {
                    if (_checFlagIsExcelFileEmpty == true) {
                        return false;
                    } else {

                        // debugger;
                        $("#PBEUstep1").removeClass("active");
                        $("#PBEUstep2").removeClass("active");
                        $("#PBEUstep3").addClass("active");
                        //var table = $('#tblUploadedExcel').DataTable();

                        // table.destroy();

                        //$('#tblUploadedExcel tbody').html('');
                        //$('#tblUploadedExcel thead').html('');
                        //$("#tabStep2").addClass("disabled");
                        $("#tabStep1").removeClass("active");
                        $("#tabStep2").removeClass("active");

                        $("#tabStep3").removeClass("disabled");
                        $("#tabStep3").addClass("active");
                        $("#tabStep2").bind("click", function () {
                            $('#btnBackToStepTwo').click();
                            isSelectedMandatoryFields = true;
                        });
                        //=========Read xls or xlsx file and make it as table=======//

                        data = UploadedExcelContent;


                    }
                } else {
                    //Added By Usha Pandit On 10.12.2020 For getting correct validation alert
                    if (_checFlagIsExcelFileEmpty == true) {
                        return false;
                    }
                    //End Of Added By Usha Pandit On 10.12.2020 For getting correct validation alert
                    showAlert('Uploaded Excel File is Blank/Please Check Excel Column Configuration.', 'alert-danger');
                    return false;
                }
            }

            else {
                //Added By Dipali V On 25th Jan 2020 For IssueID 21635
                if (MandatoryFileds != "") {
                    showAlert("Please Select " + MandatoryFileds.toString(), "alert-danger");
                } else {
                    showAlert("Please Select " + MandatoryFieldsError.toString(), "alert-danger");
                }
                isSelectedMandatoryFields = true;
                MandatoryFileds = "";
                MandatoryFieldsError = "";
                //End of Added By Dipali V On 25th Jan 2020 For IssueID 21635
            }
            $("select option").removeAttr("title");//Remove Placeholder
            // } //else {
            //showAlert('Uploaded Excel File is Blank/Please Check Excel Column Configuration.', 'alert-danger');
            //return false;
            //}
        });


        $(".ExcelColumn").change(function () {
            //debugger
            // Get the selected value
            var selected = $("option:selected", $(this)).val();
            // Get the ID of this element
            var thisID = $(this).prop("id");
            // Reset so all values are showing:
            $('.ExcelColumn').map(function () {
                if (thisID != $(this).prop("id")) {
                    if ((selected != "--Select--") && ($(this).val()) == selected) {
                        var MatchedId = $(this).prop("id");
                        showAlert("Column field " + $(this).val() + " already selected", "alert-danger");
                        $('#' + thisID).val("--Select--");
                    }
                }
            });
            $("select option").removeAttr("title");//Remove Placeholder
        });



        function BindExcelTable(data) {
            //debugger;
            var columns = addAllColumnHeaders(data, '#tblUploadedExcel');

            for (var i = 0; i < data.length; i++) {
                // debugger
                var row$ = $('<tr>');
                for (var colIndex = 0; colIndex < columns.length; colIndex++) {
                    var cellValue = data[i][columns[colIndex]];
                    if (cellValue == null) {
                        cellValue = "";

                    }
                    row$.append($('<td/>').html(cellValue));
                }
                //$('#tblUploadedExcel').append("<tbody>");
                $('#tblUploadedExcel').append(row$);

            }
            SetColor();
            $("select option").removeAttr("title");//Remove Placeholder
        }

        function SetColor() {
            //var errorCount = 0;
            //var validCount = 0;
            $('#tblUploadedExcel tr').each(function () {
                var col_val = $(this).find("td:eq(20)").text();
                if (col_val != "") {
                    $(this).addClass("InvalidRows");
                }
                else {

                }
            });

            $('#tblUploadedExcel').on('page.dt', function () {
                SetColor();
            });


            //alert(col_val);

        }
        function addAllColumnHeaders(myList, selector) {
            var columnSet = [];
            var headerTr$ = $('<tr/>');

            for (var i = 0; i < myList.length; i++) {
                var rowHash = myList[i];
                for (var key in rowHash) {
                    if ($.inArray(key, columnSet) == -1) {
                        columnSet.push(key);
                        headerTr$.append($('<th/>').html(key));
                    }
                }
            }
            $(selector).append(headerTr$);
            $("select option").removeAttr("title");//Remove Placeholder

            return columnSet;
        }



        /*
         * Created Date     :   20 Aug 2019.
         * Purpose          :   back to step 1
         * Author           :   Chandrashekhar Salagar.
         * **/
        $("#btnBackToStepOne").click(function (e) {
            //debugger;
            //Added By Dipali V On 23rd Jan 2020 for Active Tab Issues
            //  var table = $('#tblUploadedExcel').DataTable();
            //table.destroy().draw();
            try {
                //alert($("#tblUploadedExcel").find('tr')[0]);
                if ($("#tblUploadedExcel").find('tr')[0] != undefined) {
                    $('#tblUploadedExcel tr').each(function () {
                        $(this).remove();
                    });
                    var table = $('#tblUploadedExcel').DataTable();
                    table.destroy().draw();
                }
            }
            catch (ex) {
                //alert(ex.message);
            }
            $("#tabStep1").addClass("active");
            $("#tabStep2").removeClass("active");
            $("#tabStep3").removeClass("active");
            //End of Added By Dipali V On 23rd Jan 2020 for Active Tab Issues
            $("#PBEUstep1").addClass("active");
            $("#PBEUstep2").removeClass("active");
            $("#PBEUstep3").removeClass("active");
            //$("#tabStep2").addClass("disabled");
            $("#tabStep1").removeClass("disabled");
            $('#tblUploadedExcel').html('');
            $("#tabStep2").bind("click", function () {
                $('#btnStepOne').click();
            });
            $("select option").removeAttr("title");//Remove Placeholder
        });


        /*
         * Created Date     :   20 Aug 2019.
         * Purpose          :   back to step 2
         * Author           :   Chandrashekhar Salagar.
         */
        $("#btnBackToStepTwo").click(function (e) {


            try {
                if ($("#tblUploadedExcel").find('tr')[0] != undefined) {
                    $('#tblUploadedExcel tr').each(function () {
                        $(this).remove();
                    });
                    var table = $('#tblUploadedExcel').DataTable();
                    table.destroy().draw();
                }
            }
            catch (ex) {
                //alert(ex.message);
            }
            //Added By Dipali V On 23rd Jan 2020 for Active Tab Issues
            $("#tabStep1").removeClass("active");
            $("#tabStep2").addClass("active");
            $("#tabStep3").removeClass("active");
            //End of Added By Dipali V On 23rd Jan 2020 for Active Tab Issues
            $("#PBEUstep1").removeClass("active");
            $("#PBEUstep2").addClass("active");
            $("#PBEUstep3").removeClass("active");
            $('#tblUploadedExcel').html('');
            $("#tabStep3").bind("click", function () {
                $('#btnStepTwo').click();
            });
            $("select option").removeAttr("title");//Remove Placeholder

            ValidCount = 0;
            InvalidCount = 0;

        });

        /*
         * Created Date     :   20 Aug 2019.
         * Purpose          :   Check file extension.
         * Author           :   Chandrashekhar salagar.
         * **/
        $('#taskFile').change(function () {
            //debugger;
            if (isValidTypeExeCheck == false) {
                //Added By Usha Pandit On 24.08.2020 For javascript error
                if (this.value != "" && this.value != null && this.value != undefined) {
                    //End Of Added By Usha Pandit On 24.08.2020 For javascript error
                    //Commented And Added By Usha Pandit On 31.08.2020 For identifying/getting correct extension
                    //var ext = this.value.match(/\.(.+)$/)[1];
                    var ext = this.value.substr(this.value.lastIndexOf('.') + 1);
                    //End Of Added By Usha Pandit On 31.08.2020 For identifying/getting correct extension
                    if (ext != "xls" && ext != "xlsx") {
                        //add and commented by omkar 04/02/2020
	                <%--showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');--%>
                        showAlert('Please Select Excel File.', 'alert-danger');
                        //end of add and commented by omkar 04/02/2020
                        $('#taskFile').val("");
                        //$('form p').text(this.files.length + " file(s) selected");
                        $('form p').text("Click here to upload");
                    }
                    else {


                        var filename = this.files[0].name;
                        //var filecount = this.files.length + " file(s) selected";
                        //$('form p').text(this.files.length + " file(s) selected");
                        $('form p').text(filename);
                    }
                    $("select option").removeAttr("title");//Remove Placeholder
                    $('.ExcelColumn').map(function () {
                        $($(this)).val("--Select--");
                        $("select option").removeAttr("title");//Remove Placeholder
                    });
                }
            }
        });
        //Added By Usha Pandit On 02.09.2020 For uplodaing same file with modifications
        $('#taskFile').click(function () {
            if (this.value != "" && this.value != null && this.value != undefined) {
                this.value = "";
                //this.wrap('<form>').closest('form').get(0).reset();
                //this.unwrap();
            }
        });
        //End Of Added By Usha Pandit On 02.09.2020 For uplodaing same file with modifications
        //add by omkar 29/01/2020
        var _checFlagIsExcelFileEmpty = false;
        var IsDATA = 0;
        //end of add by omkar 29/01/2020
        var my_columns = [];


        var ValidCount = 0;
        var InvalidCount = 0;

        function UploadTasks() {

            //add by omkar 29/01/2020
            _checFlagIsExcelFileEmpty = false;

            //end of add by omkar 29/01/2020
            $("select option").removeAttr("title");//Remove Placeholder
            var assigntaskinbulk = new Array();
            assigntaskinbulk = [];
            $('.ExcelColumn').map(function (index) {
                if (($(this).val()) != "--Select--") {
                    var ExcelCol = $(this).attr('id');
                    var item = {
                        ExcelFeildName: ExcelCol.substring(14),
                        WBSFieldName: $(this).val(),
                        projectId: $("#CboProject").val()
                    };
                    assigntaskinbulk.push(item);
                }

            });

            $("#CboExcelColumnA > option").each(function () {
                if (($(this).val()) != "--Select--") {
                    var val = $(this).val();

                }
            })

            var formData = new FormData();
            //var files = $("#fileUpload").get(0).files;
            my_columns = [];
            var file = $('#taskFile').get(0).files;
            if (file.length > 0) {
                formData.append("UploadedImage", file[0]);
                formData.append("assigntaskinbulk", JSON.stringify(assigntaskinbulk));
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/AssignTaskInBulk',
                type: "POST",
                data: formData,
                dataType: "json",
                contentType: false,
                processData: false,
                //contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                async: false,
                success: function (result) {
                    if (result.length != 0) {
                        var ExcelColumn = result[0]['ExcelNoColumn'];
                    }
                    //alert(ExcelColumn);
                    //$(".dataTables_scrollBody").html('');
                    //added by omkar 29/01/2020
                    if (result.length == 0) {
                        IsDATA = 0;
                        _checFlagIsExcelFileEmpty = true;
                        showAlert('Uploaded Excel File is Blank.', 'alert-danger');
                    }
                    else if (result.length > 100) {
                        IsDATA = 0;
                        _checFlagIsExcelFileEmpty = true;
                        showAlert('You can upload 100 tasks only.', 'alert-danger');
                    }
                    else if (ExcelColumn != SelectedOptionsForUpload.length) {
                        _checFlagIsExcelFileEmpty = true;
                        IsDATA = 0;
                        showAlert('Please Check Excel Column Configuration.', 'alert-danger');
                    }
                    else {
                        //end of added by omkar 29/01/2020
                        IsDATA = 1;
                        SelectedOptionsForUpload.push('Error Message');
                        SelectedOptionsForUpload.push('Select');
                        var lastCount = SelectedOptionsForUpload.length;



                        //added and commented by omkar 31/01/2020
                        //var result = result[0] - 1;
                        // $.each( result[0], function (key, value) {
                        //     for (var i = 0; i < SelectedOptionsForUpload.length; i++) {
                        //         if (SelectedOptionsForUpload[i] == key) {
                        //             var my_item = {};
                        //             my_item.data = key;
                        //             my_item.title = key;
                        //             my_columns.push(my_item);
                        //         }
                        //     }
                        //});

                        for (var i = 0; i < assigntaskinbulk.length; i++) {

                            var my_item = {};
                            my_item.data = assigntaskinbulk[i].WBSFieldName;
                            my_item.title = assigntaskinbulk[i].WBSFieldName;
                            my_columns.push(my_item);

                        }
                        //debugger
                        //$('#tblUploadedExcel thead').dataTable().fnDestroy();
                        var my_item = {};
                        my_item.data = 'Error Message';
                        my_item.title = 'Error Message';
                        //Commented and added by Chetan M on 14th Feb 2020 for remove extra error msg column
                        //my_columns.push(my_item);
                        if (my_columns.indexOf("Error Message") == -1) {
                            my_columns.push(my_item);
                        }
                        //End of Commented and added by Chetan M on 14th Feb 2020 for remove extra error msg column
                        var my_item = {};
                        my_item.data = 'Select';
                        my_item.title = 'Select';

                        //Commented and added by Chetan M on 14th Feb 2020 for remove extra error msg column
                        //my_columns.push(my_item);
                        if (my_columns[my_columns.length - 1].data.indexOf("Select") == -1) {
                            my_columns.push(my_item);
                        } else {


                        }
                        //End of Commented and added by Chetan M on 14th Feb 2020 for remove extra error msg column



                        $('#uploadedFilName').html('');
                        var filename = $('input[type=file]').val().split('\\').pop();
                        //Added & Commentd By Dipali V On 24th Jan 2020 for Caption Change
                        //var fileNamestr = ' <a id="" href="#">Uploaded Data :-</a> ' + filename + '</p>';
                        var fileNamestr = ' <a id="" href="#">Uploaded File :-</a> ' + filename + '</p>';
                        //End of Added & Commentd By Dipali V On 24th Jan 2020 for Caption Change
                        $('#uploadedFilName').html(fileNamestr);
                        $("select option").removeAttr("title");//Remove Placeholder

                        // datatable(result,my_columns,lastCount);
                        //end of added and commented by omkar 31/01/2020
                        //Added by Chetan M on 14th Feb 2020 for clear datatable
                        $('#tblUploadedExcel thead').dataTable().fnDestroy();

                        //End of Added by Chetan M on 14th Feb 2020 for clear datatable
                        //$('#tblUploadedExcel tbody').empty();
                        //$('#tblUploadedExcel thead').html();
                        //$('#tblUploadedExcel').DataTable();

                        //alert(result);
                        $('#tblUploadedExcel').DataTable({

                            data: result,
                            "columns": my_columns,
                            'columnDefs': [{
                                'targets': [lastCount - 1],
                                'searchable': false,
                                'orderable': false,
                                //"pageLength": "10",
                                "paging": false,
                                'className': 'dt-body-center',
                                'render': function (result, type, full, meta) {
                                    var erromessageval = full['Error Message'];
                                    ;
                                    if (erromessageval == "") {
                                        // ValidCount++;
                                        return '<input type="checkbox" checked name="Resources[]" value="'
                                            + $('<div/>').text(result).html() + '">';
                                    }
                                    else {
                                        //InvalidCount++;
                                        return '<input type="checkbox" disabled name="Resources[]" value="'
                                            + $('<div/>').text(result).html() + '">';
                                    }
                                }
                            }],

                            //Commented By dipali v on 11th Feb 2020 For Proccessing caption hide
                            //"bProcessing": true,
                            //End of Commented By dipali v on 11th Feb 2020 For Proccessing caption hide
                            'destroy': true,
                            //aLengthMenu: [
                            //    [5, 10, 15, -1],
                            //    [5, 10, 15, "All"]
                            //],
                            iDisplayLength: -1,
                            //"sPaginationType": "full_numbers",
                            "ordering": false,
                            "scrollY": "30vh",//Added By Pradip P on 11th Feb 2020 For Table Header freezed 
                            "responsive": true,
                            "bFilter": true,
                            "scrollX": true,
                            "retrieve": true,
                            //"scrollY": "500px",

                            "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                                // debugger;
                                $(nRow).children().each(function (index, td) {
                                    //debugger;
                                    if ($(td).html() != "") {
                                        var Message = aData['Error Message'];
                                        if (Message) {
                                            $(nRow).addClass('InvalidRows');
                                            //InvalidCount++;
                                        }
                                        else {
                                            $(nRow).addClass('ValidRows');
                                            //ValidCount++;
                                        }
                                    }
                                });

                            },

                            //"initComplete": function () {
                            //    debugger;
                            //    var api = this.api();
                            //    if (api.$('td').html() != "") {
                            //        var Message = result['Error Message'];
                            //        if (Message) {
                            //            api.$('tr').addClass('InvalidRows');
                            //            InvalidCount++;
                            //        }
                            //        else {
                            //            api.$('tr').addClass('ValidRows');
                            //            ValidCount++;
                            //        }
                            //    }


                            //}
                        });
                        //debugger;
                        setTimeout(function () {
                            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                        }, 350); //Added By Pradip P on 11th Feb 2020  

                        //var table = $('#tblUploadedExcel').DataTable();
                        //table.destroy();

                        //$('#tblUploadedExcel').DataTable();

                        $('#uploadedFilName').html('');
                        //debugger;

                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify("Invalid Records:   " + InvalidCount, 'error', 10);
                        //alertify.notify("Valid Records: " + ValidCount, 'success', 10);
                        var filename = $('input[type=file]').val().split('\\').pop();
                        //Added & Commentd By Dipali V On 24th Jan 2020 for Caption Change
                        //var fileNamestr = ' <a id="" href="#">Uploaded Data :-</a> ' + filename + '</p>';
                        var fileNamestr = ' <a id="" href="#">Uploaded File :-</a> ' + filename + '</p>';
                        //End of Added & Commentd By Dipali V On 24th Jan 2020 for Caption Change
                        $('#uploadedFilName').html(fileNamestr);
                        $("select option").removeAttr("title");//Remove Placeholder
                        // my_columns = [];
                        //Added By Dipali v On 2nd March 2020 For Display Valid/Invalid Rows
                        InvalidCount = $('.InvalidRows').length;
                        ValidCount = $('.ValidRows').length;
                        $("#InvalidateRecords").text(" - " + InvalidCount);
                        $("#validateRecords").text(" - " + ValidCount);
                        //End of Added By Dipali v On 2nd March 2020 For Display Valid/Invalid Rows
                        //showAlert("Invalid Records:   " + InvalidCount, 'alert-danger');
                        //showAlert("Valid Records:   " + ValidCount, 'alert-success');
                        //add by omkar 29/01/2020
                    }
                    //en
                },
                error: function (xhr, status, error) {

                    var err = eval("(" + xhr.responseText + ")");
                    var err = xhr.responseText;
                    console.log(err);
                }
            });
        }



        //function decorateRow(row,result) {
        //    $(row).children().each(function (index, td) {
        //        if ($(td).html() != "")
        //        {
        //            var Message = result['Error Message'];
        //            if (Message) {
        //                $(nRow).addClass('InvalidRows');
        //                InvalidCount++;
        //            }
        //            else {
        //                $(nRow).addClass('ValidRows');
        //                ValidCount++;
        //            }
        //        }

        //    });











        //Heighlight a div on clicking of mouse//
        var classSelectedDiv = 'selectedDiv';

        /*Added  By Dipali V On 17th Feb 2020 For Restrict Void task Deletion*/
        var classdisabledDiv = 'disabledDiv';
        var $thumbs = $('body').on('click', 'div.taskcardbox', function () {
            var GetID = "";
            $('.taskcardbox').each(function () {
                $('.taskcardbox').removeClass(classSelectedDiv);
            });
            $thumbs.removeClass(classSelectedDiv);
            /*Added  By Dipali V On 17th Feb 2020 For Restrict Void task Deletion*/
            if ($(this).hasClass("YesvoidTask")) {
                $(this).addClass(classdisabledDiv);
            } else {
                $(this).addClass(classSelectedDiv);
            }
            //Added by Dipali V On 27th Feb 2020 For only open selected Flag Div
            if (selectedDivID != this.id) {
                //Commented by Chetan M on 13 May 2021 to open selected flag div
                //$("#ul_" + selectedDivID).css("display", "none");
                //End of Commented by Chetan M on 13 May 2021 to open selected flag div
            }
            //End of Added by Dipali V On 27th Feb 2020 For only open selected Flag Div
            selectedDivID = this.id

            /*End of Added  By Dipali V On 17th Feb 2020 For Restrict Void task Deletion*/

        });

        //Get the all task card position in array//
        function DefaultPositions() {
            var divOriginalPositions = "";
            $('.taskcardbox').each(function () {
                if ($(this).attr('id') != undefined) {
                    divOriginalPositions = divOriginalPositions + ',' + $(this).attr('id');
                }
            });

            divOldPosition = divOriginalPositions;
        }

        /*Undo Functionality*/
        /*
         * Created Date     :   03 Sept 2019
         * Purpose          :   When user clicks undo button task will place to its original position
         * Author           :   Chanrdashekhar Salagar
         * **/
        $('#btnUndo').on('click', function () {


            var undoCount = 0;

            if (list.length > 0) {
                //var newarray = list.reverse();
                var getLastOrder = list[list.length - 1];
                var taskOrders = getLastOrder.TaskCard;
                //Create redo list //
                var TaskCard = getLastOrder.TaskCard;
                var StageID = $('#' + TaskCard).parent().closest('div').attr('id').split(' ');
                var hiddenStagId = $('#' + StageID).find('input[type=hidden]:first').val();

                var listItem = {
                    StageId: hiddenStagId,
                    TaskCard: TaskCard,
                }
                listRedo.push(listItem);
                var Stage = getLastOrder.StageId;
                var hiddenStagId = $('#' + Stage).find('input[type=hidden]:first').val();// If dropped stage is 1 or TO DO LIST then prevent dropping non that stage.//

                UpdateTaskCardOrder(taskOrders, $("#CboProject").val(), Stage)
                var WhichTask;
                var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                var getClassName = $('#tabWhizibleTasks').attr('class');
                if (getClassName == "tab-slider--trigger active") {
                    WhichTask = "";
                }
                else {
                    WhichTask = "M";
                }
                if (ActiveTab == "tabActive") {
                    GetDefaultStages($("#CboProject").val(), 1, WhichTask);
                    //alert(getClassName);
                }
                else if (ActiveTab == "tabAll") {
                    GetDefaultStages($("#CboProject").val(), 0, WhichTask);
                }
                list.splice(list.length - 1, 1);
                undoCount++;
                //listRedo.splice(listRedo.length - 1, 1);
            }
            else {
                showAlert('<%= MyBase.GetResourceString("iew") %>', 'alert-danger');
            }
            $("select option").removeAttr("title");//Remove Placeholder

        });


        /*Redo Functionality*/
        /*
         * Created Date     :   04 Sept 2019
         * Purpose          :   When user clicks undo button task will place to its original position
         * Author           :   Chanrdashekhar Salagar
         * **/
        $('#btnRedo').on('click', function () {


            if (listRedo.length > 0) {
                //var newarray = list.reverse();
                var getLastOrder = listRedo[listRedo.length - 1];
                var taskOrders = getLastOrder.TaskCard;
                var Stage = getLastOrder.StageId;
                //Create redo list //
                var TaskCard = getLastOrder.TaskCard;
                var StageID = $('#' + TaskCard).parent().closest('div').attr('id').split(' ');
                var hiddenStagId = $('#' + StageID).find('input[type=hidden]:first').val();

                var listItem = {
                    StageId: hiddenStagId,
                    TaskCard: TaskCard,
                }
                list.push(listItem);




                UpdateTaskCardOrder(taskOrders, $("#CboProject").val(), Stage)
                var WhichTask;
                var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                var getClassName = $('#tabWhizibleTasks').attr('class');
                if (getClassName == "tab-slider--trigger active") {
                    WhichTask = "";
                }
                else {
                    WhichTask = "M";
                }
                if (ActiveTab == "tabActive") {
                    GetDefaultStages($("#CboProject").val(), 1, WhichTask);
                    //alert(getClassName);
                }
                else if (ActiveTab == "tabAll") {
                    GetDefaultStages($("#CboProject").val(), 0, WhichTask);
                }
                listRedo.splice(listRedo.length - 1, 1);
                //listRedo.splice(listRedo.length - 1, 1);
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
            }
            $("select option").removeAttr("title");//Remove Placeholder
        });

        $('#btnUpward').on('click', function () {
            var divs = "";
            var userSelectedDiv = "";
            $('.taskcardbox').each(function () {
                if (this.id != "" && this.id != undefined) {
                    if ($("#" + this.id).is(".selectedDiv")) {
                        userSelectedDiv = this.id;
                    }
                }
            });

            //alert("User selected div= " + userSelectedDiv);
            var PreviousTask = $('#' + userSelectedDiv).prev().attr('id');
            //alert("Previous div= " + PreviousTask);
            $('#' + userSelectedDiv).insertBefore($('#' + PreviousTask));
            $('#' + userSelectedDiv).focus();

            //Update to new orders to database//
            var StageID = $('#' + userSelectedDiv).parent().closest('div').attr('id').split(' ');
            var hiddenStagId = $('#' + StageID).find('input[type=hidden]:first').val();

            $('#' + StageID + ' > div').map(function () {
                if (this.id.length > 1 && this.id.length != undefined) {
                    divs = divs + this.id + ',';
                }
            });
            divs = divs.substring(0, divs.length - 1);

            UpdateTaskCardOrder(divs, $("#CboProject").val(), hiddenStagId)
            $("select option").removeAttr("title");//Remove Placeholder
        });

        $('#btnDownward').on('click', function () {
            var divs = "";
            var userSelectedDiv = "";
            $('.taskcardbox').each(function () {
                if (this.id != "" && this.id != undefined) {
                    if ($("#" + this.id).is(".selectedDiv")) {
                        userSelectedDiv = this.id;
                    }
                }
            });

            //alert("User selected div= " + userSelectedDiv);
            var PreviousTask = $('#' + userSelectedDiv).next().attr('id');
            //alert("Previous div= " + PreviousTask);
            $('#' + userSelectedDiv).insertAfter($('#' + PreviousTask));
            $('#' + userSelectedDiv).focus();

            //Update to new orders to database//
            var StageID = $('#' + userSelectedDiv).parent().closest('div').attr('id').split(' ');
            var hiddenStagId = $('#' + StageID).find('input[type=hidden]:first').val();

            $('#' + StageID + ' > div').map(function () {
                if (this.id.length > 1 && this.id.length != undefined) {
                    divs = divs + this.id + ',';
                }
            });
            divs = divs.substring(0, divs.length - 1);

            UpdateTaskCardOrder(divs, $("#CboProject").val(), hiddenStagId)
            $("select option").removeAttr("title");//Remove Placeholder
        });

        /*
         *  Author       :   Chandrashekhar Salagar
         *  Date         :   13 Sept 2019
         *  Purpose      :   Upload valid tasks.
         * **/
        $('#btnUploadExcel').on('click', function () {
            ;
            var listTasks = new Array();

            var heads = [];
            $("#tblUploadedExcel").find("th").each(function () {
                heads.push($(this).text().trim());
            });
            var rows = [];
            $("#tblUploadedExcel tbody tr").each(function () {

                var checkbox = $(this).find('input[type=checkbox]');
                var className = $(this).attr('Class');
                var ValidRows = 'ValidRows';
                cur = {};
                if (className.indexOf(ValidRows) != -1) {

                    if ($(checkbox).prop('checked') == true) {
                        $(this).find("td").each(function (i, v) {
                            encodeURI(cur[heads[i]] = $(this).text().trim());
                        });
                        rows.push(cur);
                    }
                }
                cur = {};
            });


            if (rows.length > 0) {
                listTasks = rows;
                ExcelTasks(listTasks);

            }
            $("select option").removeAttr("title");//Remove Placeholder
        });

        /**
         * Created Date     :   17 Sept-2019
         * Purpose          :   ExcelTasks
         * Author           :   Chandrashekhar Salagar
         * @param listTasks
         */
        function ExcelTasks(listTasks) {
            var TaskCount = listTasks.length;
            var taskuploadviewmodel = {
                lisFileUploadParameters: listTasks,
                ProjectID: encodeURI($("#CboProject").val()),
                CreatedBy: encodeURI(UserName)
            };
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/UploadTasks',
                type: "POST",
                data: JSON.stringify(taskuploadviewmodel),
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    //if (taskuploadviewmodel) {
                      //  xhr.setRequestHeader("Params", encryptString(isJson(taskuploadviewmodel) ? taskuploadviewmodel : JSON.stringify(taskuploadviewmodel)));
                    //}
                },
                async: false,
                success: function (Token) {
                    $('#exceluploadsteps').modal('hide');

                    //Added By Dipali V On 24th Jan 2020 for filter Issues
                    if (IsMPPTask == 1) {
                        WhichTask = "M";
                    } else {
                        WhichTask = "";

                    }

                    //add by omkar 31/01/2020
                    ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                    //end of add by omkar 31/01/2020
                    if (ActiveTab == "tabActive") {
                        IsActiveTasks = "1";
                    }
                    else if (ActiveTab == "tabAll") {
                        IsActiveTasks = "0";
                    }
                    //End of Added By Dipali V On 24th Jan 2020 for filter Issues
                    GetDefaultStages($("#CboProject").val(), IsActiveTasks, WhichTask);
                    //Added & Commneted By Dipali V On 4th march 2020 to remove count
                    //showAlert(TaskCount + " Task(s) Created Successfully", "alert-success");
                    showAlert("Task(s) Created Successfully", "alert-success");
                    //End of Added & Commneted By Dipali V On 4th march 2020 to remove count
                    $("select option").removeAttr("title");//Remove Placeholder
                    var table = $('#tblUploadedExcel').DataTable();
                    table.destroy().draw();

                },
                error: function (xhr, status, error) {

                    var err = eval("(" + xhr.responseText + ")");
                    //alert(err.Message);
                }
            })
        }

        /**
         * Created Date     :   17 Sept-2019
         * Purpose          :   TasksForSearch
         * Author           :   Chandrashekhar S
         * @param listTasks
         */
        function TasksForSearch(listTasks) {

            var ulElements = $("#divSearchBar").find('ul');
            if (ulElements.length) {
                $(ulElements).html('');
            }
            if (listTasks.length > 0) {
                var strAppend = ' <ul class="dropdown-menu">';
                for (var i = 0; i < listTasks.length; i++) {
                    // Added by Vishal Mahajan 08-01-2020
                    //strAppend = strAppend + '<li data-value=' + listTasks[i].TaskID + '><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#taskeditor"><i class="fas fa-tasks"></i>' + listTasks[i].TaskName + '</a></li>';
                    strAppend = strAppend + '<li data-value=' + listTasks[i].TaskID + '  class="editTask"><a href="" data-bs-toggle="modal"  onclick="editTask(' + listTasks[i].TaskID + ')"><i class="fas fa-tasks"></i>' + listTasks[i].TaskName + '</a></li>';
                }
                strAppend = strAppend + '</ul>'
                //  $("#divSearchBar").append(strAppend);
            } else {

                strAppend = '<ul class="dropdown-menu"><li>No data available in table</li></ul>'
            }

            $("#divSearchBar").append(strAppend);
            $("select option").removeAttr("title");//Remove Placeholder
        }

        //$('#wbssearchinputtasklist').change(function(){
        //    ;
        //    var value = $(this);
        //});
        $('#divSearchBar').on('click', 'li', function () {

        });

        $(".modal").on("hidden.bs.modal", function () {

            ClearModalExcelUploadData();
        });

        /** 
         *  
         * 
         * **/
        function ClearModalExcelUploadData() {
            //debugger
            $('.ExcelColumn').map(function () {

                $($(this)).val("--Select--");
            });
            $("#PBEUstep1").addClass("active");
            $("#PBEUstep2").removeClass("active");
            $("#PBEUstep3").removeClass("active");

            $("#tabStep3").addClass("disabled");
            $("#tabStep3").removeClass("active");

            $("#tabStep2").addClass("disabled");
            $("#tabStep2").removeClass("active");

            $("#tabStep1").addClass("active");
            $("#tabStep1").removeClass("disabled");

            //$("#PBEUstep2").removeClass("active");
            //$("#PBEUstep3").removeClass("active");
            //$("#tabStep3").removeClass("disabled");
            //$("#tabStep2").removeClass("disabled");
            $('#tblUploadedExcel').html('');
            $('form p').text("Click here to upload");
            $('#taskFile').val("");
            if (window.fileInputForm != undefined)
                window.fileInputForm.reset();
            clearTooltip();

        }

        /**
         * Created Date     :   21 Sept 2019
         * Purpose          :   Get project configuration from selected project.
         * Author           :   Chandrashekhar Salagar.
         * @param ProjectID
         */
        function GetProjectConfiguration(ProjectID) {
            //
            projectsettings = {
                projectID: encodeURI(ProjectID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetProjectConfiguration',
                type: "POST",
                data: JSON.stringify(projectsettings),
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (projectsettings) {
                        xhr.setRequestHeader("Params", encryptString(isJson(projectsettings) ? projectsettings : JSON.stringify(projectsettings)));
                    }
                },
                async: false,
                success: function (objprojectsettings) {
                    // debugger;
                    storeArray(objprojectsettings);

                },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    //alert(err.Message);
                }
            })

        }

        /**
         * Created Date     :       20 Sept 2019
         * Purpose          :       Get project settings
         * Author           :       Chandrashekhar Salagar
         * @param objprojectsettings
         */
        function storeArray(objprojectsettings) {
            var fields = "";
            var isExistingField = false;
            if (objprojectsettings.isAgileProject == true) {
                var fields = "User Story";
                isExistingField = MandatoryFields.includes(fields)
                if (!isExistingField) {
                    MandatoryFields.push(fields);
                }
                var isExistingError = MandatoryFieldsError.includes(fields);
                if (!(isExistingError)) {
                    MandatoryFieldsError.push(fields);
                }
            }
            if ((objprojectsettings.ShowPhaseInAt == true) && (objprojectsettings.PhaseMandatoryinAT)) {
                var fields = "Phase";
                if (!isExistingField) {
                    MandatoryFields.push(fields);
                }
                var isExistingError = MandatoryFieldsError.includes(fields);
                if (!(isExistingError)) {
                    MandatoryFieldsError.push(fields);
                }
            }
            if ((objprojectsettings.ShowModuleInAt == true) && (objprojectsettings.ModuleMandatoryinAT)) {
                var fields = "Module";
                if (!isExistingField) {
                    MandatoryFields.push(fields);
                }
                var isExistingError = MandatoryFieldsError.includes(fields);
                if (!(isExistingError)) {
                    MandatoryFieldsError.push(fields);
                }
            }
            if ((objprojectsettings.ShowSubProjectInAT == true) && (objprojectsettings.SubProjectMandatoryInAT)) {
                var fields = "Sub Project";
                if (!isExistingField) {
                    MandatoryFields.push(fields);
                }
                var isExistingError = MandatoryFieldsError.includes(fields);
                if (!(isExistingError)) {
                    MandatoryFieldsError.push(fields);
                }
            }
            if ((objprojectsettings.ShowMilestoneInAT == true) && (objprojectsettings.MilestoneMandatoryInAT)) {
                var fields = "Milestone";
                if (!isExistingField) {
                    MandatoryFields.push(fields);
                }
                var isExistingError = MandatoryFieldsError.includes(fields);
                if (!(isExistingError)) {
                    MandatoryFieldsError.push(fields);
                }
            }

            if ((objprojectsettings.ShowChangeRequestInAT == true) && (objprojectsettings.ChangeRequestMandatoryInAT)) {
                var fields = "Change Request";
                if (!isExistingField) {
                    MandatoryFields.push(fields);
                }
                var isExistingError = MandatoryFieldsError.includes(fields);
                if (!(isExistingError)) {
                    MandatoryFieldsError.push(fields);
                }
            }
            if ((objprojectsettings.ShowFeatureInAT == true) && (objprojectsettings.FeatureMandatoryInAT)) {
                var fields = "Feature";
                if (!isExistingField) {
                    MandatoryFields.push(fields);
                }
                var isExistingError = MandatoryFieldsError.includes(fields);
                if (!(isExistingError)) {
                    MandatoryFieldsError.push(fields);
                }
            }
            if ((objprojectsettings.ShowEstimationTypeInAT == true) && (objprojectsettings.EstimationTypeMandatoryInAT)) {
                var fields = "Estimation Type";
                if (!isExistingField) {
                    MandatoryFields.push(fields);
                }
                var isExistingError = MandatoryFieldsError.includes(fields);
                if (!(isExistingError)) {
                    MandatoryFieldsError.push(fields);
                }
            }

        }

        /*
         * Created Date     :   23 Sept 2019
         * Purose           :   Delete selected card(this will task (card) inactive)
         * Author           :   Chandrashekhar Salagar
         * **/
        $('#btnMainDelete').on('click', function () {
            var txt;
            //debugger;
            var userSelectedDiv = "";
            $('.taskcardbox').each(function () {
                if (this.id != "" && this.id != undefined) {
                    if ($("#" + this.id).is(".selectedDiv")) {

                        userSelectedDiv = this.id;
                        var StageID = $('#' + userSelectedDiv).parent().closest('div').attr('id').split(' ');
                        var hiddenStagId = $('#' + StageID).find('input[type=hidden]:first').val();
                    }
                }
            });

            //Added by Dipali V On 22nd Jan 2020 For Project was on hold then not able to delete 
            if (ProjectOnHold == 1) {
                showAlert(ProjectOnHoldMsg, 'alert-danger');
                return;
            }
            //End of Added by Dipali V On 22nd Jan 2020 For Project was on hold then not able to delete 


            if (userSelectedDiv.length == 0) {
                showAlert("Please Select at least one task card to delete", "alert-danger");
                return;
            }



            SetDeleteTask();
            ////if (confirm("Are you sure you want to delete task")) {
            ////    var divs = "";
            ////    if (userSelectedDiv.length > 0) {
            ////        DeleteTaskcard(userSelectedDiv)
            ////    }
            ////    else {
            ////         showAlert("Please Select at least one task card to delete", "alert-danger");
            ////    }
            ////}
        });

        /**
         * Created Date     :       23 Sept 2019
         * Purpose          :       Delete task which is selected(this will make task inactive).
         * Author           :       Chandrashekhar Salagar
         * @param TaskID
         */
        function DeleteTaskcard(TaskID, flag) {
            if (GlobalTaskEmployeeID == 0) {
                GlobalTaskEmployeeID = $('#hdnEmployeeID' + TaskID).val()
            } else {
                GlobalTaskEmployeeID = GlobalTaskEmployeeID;
            }

            var deleteTask = {
                TaskID: encodeURI(TaskID),
                EmployeeName: encodeURI(UserName),
                //Commented and added by Chetan M on 7th Feb 2020 for IssueID = 21651
                //EmployeeID: encodeURI(UserID)
                EmployeeID: encodeURI(GlobalTaskEmployeeID),
                IsVoid: flag
                //End of Commented and added by Chetan M on 7th Feb 2020 for IssueID = 21651
            };
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/DeleteTask',
                type: "POST",
                data: JSON.stringify(deleteTask),
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (deleteTask) {
                        xhr.setRequestHeader("Params", encryptString(isJson(deleteTask) ? deleteTask : JSON.stringify(deleteTask)));
                    }
                },
                async: false,
                success: function (Message) {
                    if (Message != "") {
                        setTimeout(function () {
                            showAlert(Message, "alert-success");
                        }, 3500);

                        CancelDeleteTask();
                        //Added By Dipali V On 24th Jan 2020 for filter Issues
                        if (IsMPPTask == 1) {
                            WhichTask = "M";
                        } else {
                            WhichTask = "";
                        }
                        //Added by Chetan M on 7th Feb 2020 for IssueID = 21651
                        var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                        var IsActiveTasks = "";
                        //End of Added by Chetan M on 7th Feb 2020 for IssueID = 21651
                        if (ActiveTab == "tabActive") {
                            IsActiveTasks = "1";
                        }
                        else if (ActiveTab == "tabAll") {
                            IsActiveTasks = "0";
                        }

                        //End of Added By Dipali V On 24th Jan 2020 for filter Issues
                        //Commented by imran on 23-02-2022
                        //GetDefaultStages($("#CboProject").val(), IsActiveTasks, WhichTask);
                        //End of comment by imran on 23-02-2022

                        //Added By Dipali V On 10th Feb 2020 Filter Should be Remain same even after Add new Task
                        var employeeid = $("#cboEmployeeIDFilter").val();
                        var tasktypeid = $("#cboTaskTypeFilter").val();
                        var startdate = $("#txtStartDateFilter").val();
                        var enddate = $("#txtEndDateFilter").val();
                        //$(".draggablemenu").html('');
                        GetProjectTasks(IsActiveTasks, WhichTask, '<%=m_roleLevel%>', employeeid, tasktypeid, startdate, enddate);
                        clearTooltip();
                        GetDefaultStages($("#CboProject").val(), IsActiveTasks, WhichTask);
                        //End of Added By Dipali V On 10th Feb 2020 Filter Should be Remain same even after Add new Task
                    }
                    else {
                        showAlert("Error in deleting task", "alert-danger");
                    }
                },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    //alert(err.Message);
                }
            })

        }

        function ViewResources() {
            window.location.href = "AddNewResource.aspx";
        }

        //added by Vishal Mahajan 08-01-2020
        function GetPriorities() {
            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetPriorities',// Path
                type: "POST",
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                async: false,
                success: function (result) {
                    $("#cboPriority").empty().append('<option value="">Select Priority</option>');
                    $.each(result, function () {
                        $("#cboPriority").append($("<option></option>").val(this['Priority']).html(this['Priority']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function GetTaskTypes(Flag) {


            var projectID = $("#CboProject :selected").val();
            var cboTaskType = $("#cboTaskType :selected").val();
            if (Flag == "LOAD") {
                if (projectID == '0' || projectID == '') {
                    $("#cboTaskType,#cboTaskTypeFilter").empty().append('<option value="">Select Task Type</option>');
                    return;
                }
            } else {
                if (projectID == '0' || projectID == '') {
                    $("#cboTaskType").empty().append('<option value="">Select Task Type</option>');
                    return;
                }

            }

            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetTaskTypes',// Path
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

                    if (Flag == "LOAD") {
                        $("#cboTaskType").empty().append('<option value="">Select Task Type</option>');
                        //Added & Commented By Dipali V On 22nd Jan 2020 For Placeholder issues
                        //$("#cboTaskTypeFilter").empty().append('<option value="">Select All</option>');
                        $("#cboTaskTypeFilter").empty().append('<option value="">Select Task Type</option>');
                    } else {
                        $("#cboTaskType").empty().append('<option value="">Select Task Type</option>');
                    }
                    //End of Added & Commented By Dipali V On 22nd Jan 2020 For Placeholder issues
                    $.each(result, function () {
                        if (Flag == "LOAD") {
                            $("#cboTaskType,#cboTaskTypeFilter").append($("<option></option>").val(this['TaskTypeID']).html(this['TaskType']));
                        } else {
                            $("#cboTaskType").append($("<option></option>").val(this['TaskTypeID']).html(this['TaskType']));

                        }
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            //alert(cboTaskType);
            //if (cboTaskType != "" && cboTaskType != undefined)
            //{

            //    $("#cboTaskType").val(cboTaskType);
            //}
        }

        //Added by Chetan M on 27th Aug 2020 for get the default task type selected.
        function GetDefaultTaskType() {
            var ProjectID = ParseInt($("#CboProject :selected").val());
            var flag=1;
            var data = {
                ProjectId: ProjectID,
                Data: flag
            };
            $.ajax({
                url: strUrl + '/api/IB_IssueDetails/GetTaskTypes',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(data),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (data) {
                        xhr.setRequestHeader("Params", encryptString(isJson(data) ? data : JSON.stringify(data)));
                    }
                },
                async: false,
                success: function (result) {
                    if (result.length > 0) {
                        $("#cboTaskType").val(result[0].TaskTypeID);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        //End of Added by Chetan M on 27th Aug 2020 for get the default task type selected.
        function GetProjectPhases() {

            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboPhase").empty().append('<option value="">Select Phase</option>');
                return;
            }
            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetProjectPhases',// Path
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
                    $("#cboPhase").empty().append('<option value="">Select Phase</option>');
                    $.each(result, function () {
                        $("#cboPhase").append($("<option></option>").val(this['ProjectPhaseID']).html(this['Phase']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function GetProjectDeliverables() {

            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboDeliverable").empty().append('<option value="">Select Deliverable</option>');
                return;
            }
            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetProjectDeliverables',// Path
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
                    $("#cboDeliverable").empty().append('<option value="">Select Deliverable</option>');
                    $.each(result, function () {
                        $("#cboDeliverable").append($("<option></option>").val(this['ScheduleID']).html(this['Title']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        //Commented And Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
        //function GetUserStories() {
        function GetUserStories(TaskId) {
            //End Of Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
            //Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
            var currentTaskId = '';
            if (TaskId != null && TaskId != undefined) {
                currentTaskId = TaskId;
            }
            //End Of Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboUserStory").empty().append('<option value="">Select User Story</option>');
                return;
            }
            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
                //Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
                TaskID: currentTaskId
                //End Of Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetUserStories',// Path
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
                    $("#cboUserStory").empty().append('<option value="">Select User Story</option>');
                    $.each(result, function () {
                        $("#cboUserStory").append($("<option></option>").val(this['UserStoryID']).html(this['UserStoryName']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function GetChangeRequest() {

            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboChangeRequest").empty().append('<option value="">Select Change Request</option>');
                return;
            }

            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetChangeRequestDetails',// Path
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
                    $("#cboChangeRequest").empty().append('<option value="">Select Change Request</option>');
                    $.each(result, function () {
                        $("#cboChangeRequest").append($("<option></option>").val(this['ChangeRequestID']).html(this['ChangeRequestSummary']));
                    });
                    if (result[0].EmployeeID != '0') {
                        $("#cboChangeRequest").val(result[0].EmployeeID);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        var resourcesList;
        function GetResources(taskId) {

            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboResource").empty().append('<option value="">Select Resource</option>');
                return;
            }
            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
                TaskID: encodeURI(taskId),
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetResources',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                async: false,
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    resourcesList = result;
                    $("#cboResource").empty().append('<option value="">Select Resource</option>');
                    $.each(result, function () {
                        $("#cboResource").append($("<option></option>").val(this['EmployeeId']).html(this['EmployeeName']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function GetMilestones(taskId) {

            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboMilestone").empty().append('<option value="">Select Milestone</option>');
                return;
            }
            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
                TaskID: encodeURI(taskId),
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetMilestones',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                async: false,
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    $("#cboMilestone").empty().append('<option value="">Select Milestone</option>');
                    $.each(result, function () {
                        $("#cboMilestone").append($("<option></option>").val(this['MilestoneID']).html(this['Milestone']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function GetProjectModules(taskId) {

            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboModule").empty().append('<option value="">Select Module</option>');
                return;
            }
            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
                TaskID: encodeURI(taskId),
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetProjectModules',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                async: false,
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    $("#cboModule").empty().append('<option value="">Select Module</option>');
                    $.each(result, function () {
                        $("#cboModule").append($("<option></option>").val(this['ModuleID']).html(this['ModuleName']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function GetSubProjects(taskId) {

            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboSubProject").empty().append('<option value="">Select Sub Project</option>');
                return;
            }
            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
                TaskID: encodeURI(taskId),
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetSubProjects',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                async: false,
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    $("#cboSubProject").empty().append('<option value="">Select Sub Project</option>');
                    $.each(result, function () {
                        $("#cboSubProject").append($("<option></option>").val(this['SubProjectID']).html(this['SubProjectName']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function GetFeatures() {
            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboFeature").empty().append('<option value="">Select Feature</option>');
                return;
            }
            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetFeatures',
                type: "POST",
                dataType: "json",
                data: JSON.stringify(projectID),
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (projectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(projectID) ? projectID : JSON.stringify(projectID)));
                    }
                },
                success: function (result) {
                    $("#cboFeature").empty().append('<option value="">Select Feature</option>');
                    $.each(result, function () {
                        $("#cboFeature").append($("<option></option>").val(this['ProjectFeatureID']).html(this['FeatureName']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function GetEstimationTypes() {
            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboEstimationType").empty().append('<option value="">Select Estimation Type</option>');
                return;
            }
            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetEstimationTypes',
                type: "POST",
                dataType: "json",
                data: JSON.stringify(projectID),
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (projectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(projectID) ? projectID : JSON.stringify(projectID)));
                    }
                },
                success: function (result) {
                    $("#cboEstimationType").empty().append('<option value="">Select Estimation Type</option>');
                    $.each(result, function () {
                        $("#cboEstimationType").append($("<option></option>").val(this['ProjectEstimationTypeID']).html(this['EstimationTypeName']));
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function editTask(taskId) {
            //Added & Commented By Dipali V On 21st Jan 2020 For Change Caption
            $("#TaskHeading").text("");
            $("#TaskHeading").text("Edit Task");
            $("#taskmapping").removeClass("in");//Added By Dipali V on 23rd Jan 2020 to Hide Task Attribute
            CheckProjectOnHold()//Added By Dipali V On 21st Jan 2020 For To check Project Billabale ,onhold
            //End of Added & Commented By Dipali V On 21st Jan 2020 For Change Caption        
            getProjectDetails();
            GetPriorities();
            GetTaskTypes("EDIT");
            GetProjectPhases();
            GetProjectDeliverables();
            //Commented And Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
            //GetUserStories();
            GetUserStories(taskId);
            //End Of Added By Usha Pandit On 12.12.2020 For passing Task Id for getting correct user stories
            GetChangeRequest();
            GetFeatures();
            GetEstimationTypes();
            if (isAgileMethodused == 1) {
                $(".AgileDiv").css("display", "inline-block");
            } else {
                $(".AgileDiv").css("display", "none");
            }
            $(".addtaskduration").css("display", "inline-block");
            $(".popupboxtabs>li.active").removeClass("active");
            $(".popupboxtabs>li:first").addClass("active");
            $("#wbsbasic").removeClass("active");
            $("#wbsbasic").addClass("active");
            $("#CDallattachments").removeClass("active");
            $("#liCDallattachments").show();

            GetResources(taskId);
            GetMilestones(taskId);
            GetProjectModules(taskId);
            GetSubProjects(taskId);
            GetDocumentsList(taskId);
            var editTask = {
                TaskID: encodeURI(taskId),
                ProjectID: encodeURI($("#CboProject").val())
            };
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetTaskAssignmentDetails',
                type: "POST",
                data: JSON.stringify(editTask),
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (editTask) {
                        xhr.setRequestHeader("Params", encryptString(isJson(editTask) ? editTask : JSON.stringify(editTask)));
                    }
                },
                async: false,
                success: function (data) {
                    //debugger;
                    if (data != null) {
                        bindWbsTaksData(data);
                        $("#taskeditor").modal("show");
                        //Added by Dipali V On 22nd Jan 2020 For for Compeleted task we can not task action
                        //Task Was was Complete
                        //if (data.IsTaskComplete == true || data.IsTaskComplete == "1") {
                        //    $("#btnTaskSave").prop("disabled", true);
                        //    $("#PRaddattachnebtrow").prop("disabled", true);
                        //} else {
                        //    $("#btnTaskSave").prop("disabled", false);
                        //    $("#PRaddattachnebtrow").prop("disabled", false);

                        //}

                        //Task Was not Active
                        //if (data.IsActive == false || data.IsActive == "0") {
                        //    $("#btnTaskSave").prop("disabled", true);
                        //    $("#PRaddattachnebtrow").prop("disabled", true);
                        //} else {
                        //    $("#btnTaskSave").prop("disabled", false);
                        //    $("#PRaddattachnebtrow").prop("disabled", false);

                        //}


                        //debugger;
                        //Project Billable
                        IsProjectOver = CheckProjectOver();

                        // End of Added by Dipali V On 22nd Jan 2020 For for Compeleted task we can not task action
                        //Added by Dipali V On 22nd Jan 2020 For Project was on hold then not able to delete 
                        //Project On hold
                        //alert(IsMPPTask);
                        if (ProjectOnHold == 1) {
                            $("#btnTaskSave").prop("disabled", true);
                            $("#PRaddattachnebtrow").prop("disabled", true);
                        }

                        else if (IsMPPTask == 1) {
                            $("#btnTaskSave").prop("disabled", true);
                            $("#PRaddattachnebtrow").prop("disabled", true);
                        }
                        else if (data.IsActive == false || data.IsActive == "False" || data.IsActive == "0") {
                            $("#btnTaskSave").prop("disabled", true);


                            $("#PRaddattachnebtrow").prop("disabled", true);
                        } else if (data.IsTaskComplete == true || data.IsTaskComplete == "True" || data.IsTaskComplete == "1") {
                            $("#btnTaskSave").prop("disabled", true);


                            $("#PRaddattachnebtrow").prop("disabled", true);
                        }
                        //Added by Chetan M on 10th Feb 2020 for IssueID = 21816

                        else if (IsProjectOver == 1) {
                            $("#btnTaskSave").prop("disabled", true);
                            $("#PRaddattachnebtrow").prop("disabled", true);
                            $("#btnSaveStage").prop("disabled", true);
                            $("#btnimport").prop("disabled", true);
                        }
                        //else {
                        //    $("#btnTaskSave").prop("disabled", false);
                        //    $("#PRaddattachnebtrow").prop("disabled", false);
                        //}
                        //End of Added by Chetan M on 10th Feb 2020 for IssueID = 21816
                        else {
                            $("#btnTaskSave").prop("disabled", false);
                            $("#PRaddattachnebtrow").prop("disabled", false);

                        }

                        //End of Added by Dipali V On 22nd Jan 2020 For Project was on hold then not able to delete 


                        //Added by Chetan M on 10th Feb 2020 for IssueID = 21827
                        //debugger;
                        if (data.BillableYN == true) {
                            $("#chkBillable").prop("checked", true);
                        }
                        else if (ProjectBillable == 1 && data.BillableYN == true) {
                            $("#chkBillable").prop("checked", true);
                        }
                        //else if (data.BillableYN == false) {
                        //    $("#chkBillable").prop("checked", true);
                        //} 
                        else {
                            $("#chkBillable").prop("checked", false);
                        }
                        //End of Added by Chetan M on 10th Feb 2020 for IssueID = 21827


                        //if (ProjectBillable == 1) {
                        //    $("#chkBillable").prop("checked", true);
                        //} else {
                        //    $("#chkBillable").prop("checked", false);
                        //}
                    }
                },
                error: function (xhr, status, error) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });
        }

        var hiddenTaskID = 0;
        var hdnRestrictByMinHours = false;
        var ProjectStartDate, ProjectEndDate;
        var PreviousStartDate, PreviousEndDate;
        var HaveSubTaskTypes = false, ApplyEffortDistribution = false;
        var HoursPerDay, WeekDays;
        var TotalAllocatedTaskLCE, TotalLCE;
        var ResourceStartDate, ResourceEndDate;
        var intResourceValidation = 0;
        var strStartingDay = 1; //"<= CommonFunctions.Application.StartDayOfWeek %>";
        var WhichTask, OtherTaskID, MitigationPlanID, TrainingResourceID, TrainingID, Void, DeliverableStageID;
        var ParentTaskID;

        function bindWbsTaksData(data) {

            ValidationMessageFieldName = new Array();
            ValidationMessageFiled = new Array();
            ValidationMessage = new Array();
            ValidationValidateID = new Array();
            ValidationValidateExtID = new Array();
            ValidationFieldsName = new Array();
            ValidationFieldID = new Array();
            ValidationRules = new Array();
            CustomFieldsNames = new Array();
            //var isCustomField = getCustomFieldsMaxRowColCount();
            //if (isCustomField == true) {
            //    PloatCustomFields();
            //}
            //debugger;

            //Added by Chetan M on 3rd Feb 2020 for Issue ID 21615
            GlobalWorkHours = data.WorkInHours;
            //End of Added by Chetan M on 3rd Feb 2020 for Issue ID 21615
            //debugger;
            ParentTaskID = data.ParentTaskID;
            WhichTask = data.WhichTask;
            OtherTaskID = data.OtherTaskID;
            MitigationPlanID = data.MitigationPlanID;
            TrainingResourceID = data.TrainingResourceID;
            TrainingID = data.TrainingID;
            Void = data.Void;
            DeliverableStageID = data.DeliverableStageID;
            intResourceValidation = data.ResourceValidation;
            ResourceStartDate = data.ResourceStartDate;
            ResourceEndDate = data.ResourceEndDate;
            TotalAllocatedTaskLCE = data.TotalAllocatedTaskLCE;
            TotalLCE = data.TotalLCE;
            HoursPerDay = data.HoursPerDay;
            WeekDays = data.WeekDays;
            hdnRestrictByMinHours = data.RestrictByMinHours;
            ProjectStartDate = data.ProjectStartDate;
            ProjectEndDate = data.ProjectEndDate;
            PreviousStartDate = data.StartDate;
            PreviousEndDate = data.EndDate;
            HaveSubTaskTypes = data.HaveSubTaskTypes;
            ApplyEffortDistribution = data.ApplyEffortDistribution;
            $("#hdnTaskID").val(data.TaskID);
            $("#hdn_txtActualWork").val(data.ActualWork);
            $("#hdn_txtPlannedWork").val(data.PlannedWork);
            $("#txthdnCurrentWork").val(data.WorkInHours);
            $("#hdn_txtTaskEndDate").val(data.TaskEndDate);
            $("#hdn_txtTaskStartDate").val(data.TaskStartDate);
            $("#hdn_txtActualStartDate").val(data.ActualStartDate);
            $("#hdn_txtActualEndDate").val(data.ActualEndDate);
            $("#txthdnMilestone").val(data.Milestone);
            $("#txthdnSubProject").val(data.SubProject);
            $("#txthdnModule").val(data.Module);
            $("#txthdnPhase").val(data.Phase);
            hiddenTaskID = data.TaskID;
            $("#txtTaskName").val(data.TaskName);
            $("#txtStartDate").val(data.StartDate);
            $("#txtEndDate").val(data.EndDate);
            $("#txtDuration").val(data.Duration.replace('.', ':'));
            //Commented And Added By Usha Pandit On 20.10.2020 For getting correct work hours
            //$("#txtWorks").val(data.WorkInHours.replace('.', ':'));
            $("#txtWorks").val(data.WorkHourMinute);
            //End Of Added By Usha Pandit On 20.10.2020 For getting correct work hours
            $("#cboPriority").val(data.Priority);
            if ($("#cboPriority").val() == '' || $("#cboPriority").val() == '0' || $("#cboPriority").val() == undefined) {
                $("#cboPriority").val('');
            }

            $("#chkBillable").prop("checked", data.BillableYN);
            //Added By Dipali V On 28th Feb 2020 For On hold Task 

            $("#chkOnHold").prop("checked", data.TaskOnHold);

            //End of Added By Dipali V On 28th Feb 2020 For On hold Task 
            $("#txtTaskNotes").val(data.TaskNotes);
            $("#cboTaskType").val(data.TaskTypeID);
            $("#cboUserStory").val('');
            //debugger;
            if (isAgileMethodused == 1) {
                //$("#cboUserStory").val(data.)

                if (data.UserStoryID != "") {
                    //Added By Dipali V On 10th Feb 2020 For US Of Task
                    $("#cboUserStory").val(data.UserStoryID)
                    //End of Added By Dipali V On 10th Feb 2020 For US Of Task
                } else {
                    if ($("#cboUserStory").val() == '' || $("#cboUserStory").val() == '0' || $("#cboUserStory").val() == undefined) {
                        $("#cboUserStory option:selected").text('Select User Story');
                    }

                }
            }

            if ($("#cboTaskType").val() == '' || $("#cboTaskType").val() == '0' || $("#cboTaskType").val() == undefined) {
                $("#cboTaskType").val('');
            }
            $("#cboResource").val(data.EmployeeID);
            if ($("#cboResource").val() == '' || $("#cboResource").val() == '0' || $("#cboResource").val() == undefined) {
                $("#cboResource").val('');
                $("#cboResource").prop("disabled", false);
            } else {
                $("#cboResource").prop("disabled", true);
            }
            $("#cboPhase").val(data.PhaseID);
            if ($("#cboPhase").val() == '' || $("#cboPhase").val() == '0' || $("#cboPhase").val() == undefined) {
                $("#cboPhase").val('');
            }
            //Commented & added By Dipali V On 24th Jan 2020 For Agile Project Releas & Sprint should get selected
            if (isAgileMethodused == 1) {
                // $("#txtSprint").val(data.SprintID);
                if ($("#txtSprint").val() == '' || $("#txtSprint").val() == '0' || $("#txtSprint").val() == undefined) {
                    $("#txtSprint").val('');
                }

                //$("#txtRelease").val(data.ReleaseID);
                if ($("#txtRelease").val() == '' || $("#txtRelease").val() == '0' || $("#txtRelease").val() == undefined) {
                    $("#txtRelease").val('');
                }

                GetSprintRelease(data.UserStoryID);
            }
            //$("#txtRelease").val('');
            //$("#txtSprint").val('');
            //End of Commented & added By Dipali V On 24th Jan 2020 For Agile Project Releas & Sprint should get selected
            $("#cboChangeRequest").val(data.ChangeRequestID);
            if ($("#cboChangeRequest").val() == '' || $("#cboChangeRequest").val() == '0' || $("#cboChangeRequest").val() == undefined) {
                $("#cboChangeRequest").val('');
            }
            $("#cboMilestone").val(data.MilestoneID)
            if ($("#cboMilestone").val() == '' || $("#cboMilestone").val() == '0' || $("#cboMilestone").val() == undefined) {
                $("#cboMilestone").val('');
            }
            $("#cboDeliverable").val(data.DeliverableID)
            if ($("#cboDeliverable").val() == '' || $("#cboDeliverable").val() == '0' || $("#cboDeliverable").val() == undefined) {
                $("#cboDeliverable").val('');
            }
            $("#cboModule").val(data.ModuleID)
            if ($("#cboModule").val() == '' || $("#cboModule").val() == '0' || $("#cboModule").val() == undefined) {
                $("#cboModule").val('');
            }
            $("#cboSubProject").val(data.SubProjectID)
            if ($("#cboSubProject").val() == '' || $("#cboSubProject").val() == '0' || $("#cboSubProject").val() == undefined) {
                $("#cboSubProject").val('');
            }
            $("#cboSubProject").val(data.SubProjectID)
            if ($("#cboSubProject").val() == '' || $("#cboSubProject").val() == '0' || $("#cboSubProject").val() == undefined) {
                $("#cboSubProject").val('');
            }
            //Commented & Added By Dipali V On 24th Jan 2020 For Data Binding issues
            //$("#cboEstimationType").val('');
            //$("#cboFeature").val('');

            $("#cboEstimationType").val(data.ProjectEstimationTypeID)
            if ($("#cboEstimationType").val() == '' || $("#cboEstimationType").val() == '0' || $("#cboEstimationType").val() == undefined) {
                $("#cboEstimationType").val('');
            }
            $("#cboFeature").val(data.ProjectFeatureID)
            if ($("#cboFeature").val() == '' || $("#cboFeature").val() == '0' || $("#cboFeature").val() == undefined) {
                $("#cboFeature").val('');
            }
            //End of Commented & Added By Dipali V On 24th Jan 2020 For Data Binding issues
            if (isAgileMethodused == 1) {

                //Added By Dipali v On 11th Feb 2020 For Bind Story Points value
                $("#txtStoryPoint").val("");
                $("#txtStoryPoint").val(data.StoryPoint);
                //End of Added By Dipali v On 11th Feb 2020 For Bind Story Points value
            }


        }
        var isAgileMethodused = 0;
        function isAgileMethodFollowed() {
            var ProjectID = $("#CboProject :selected").val();
            if (ProjectID == "" || ProjectID == "0") {
                isAgileMethodused = 0;
            } else {
                $.ajax({
                    url: strUrl + '/api/PM_wbs_card/IsAgileMethodFollowed',
                    type: "POST",
                    dataType: "json",
                    data: JSON.stringify(ProjectID),
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                        }
                    },
                    success: function (result) {

                        isAgileMethodused = result;
                        if (isAgileMethodused == 1) {
                            $(".AgileDiv").css("display", "inline-block");
                            $("#isAgilelabel").addClass("required");//Added by Dipali V On 24th Jan 2020 For Agile Project US Manatory
                            // $('#lbstorypoints').addClass("required");
                        } else {
                            $(".AgileDiv").css("display", "none");
                            $("#isAgilelabel").removeClass("required");//Added by Dipali V On 24th Jan 2020 For Agile Project US Manatory
                            //$('#lbstorypoints').removeClass("required");
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }

        }

        var projectDetails;
        //Commented And Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
        //function getProjectDetails() {
        function getProjectDetails(flag) {
            //End Of Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
            var ProjectID = $("#CboProject :selected").val();
            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetProjectDetails',
                type: "POST",
                dataType: "json",
                data: JSON.stringify(ProjectID),
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    }
                },
                success: function (result) {
                    projectDetails = result;
                    if (result.length >= 1) {
                        //debugger;
                        //Commented And Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
                        //plotingHtml(result);
                        plotingHtml(result, flag);
                        //End Of Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        //Added by Dipali V On 23rd Jan 2020 For Check Project On hold or not


        function CheckProjectOnHold() {
            var ProjectID = $("#CboProject option:selected").val();
            $.ajax({
                url: strUrl + '/api/PM_Resources/CheckProjectOnHold',
                type: "POST",
                dataType: "json",
                data: JSON.stringify(ProjectID),
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    }
                },
                success: function (strResult) {
                    for (var i = 0; i < strResult.length; i++) {

                        ProjectOnHold = strResult[i]["ProjectOnHold"];
                        ProjectOnHoldMsg = strResult[i]["ProjectOnHoldMsg"];
                        BaselineNumber = strResult[i]["BaselineNumber"];
                        BaseLineMessage = strResult[i]["BaseLineMessage"];
                        ProjectBillable = strResult[i]["Billable"];
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        //End of Added by Dipali V On 23rd Jan 2020 For Check Project On hold or not

        //Added by Chetan M on 10th Feb 2020 for IssueID = 21816
        function CheckProjectOver() {
            var projectID = $("#CboProject :selected").val();
            var ExperianceAttribute = {
                ProjectID: encodeURI(projectID)
            };
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/CheckProjectOver',
                type: 'POST',
                data: JSON.stringify(ExperianceAttribute),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ExperianceAttribute) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                    }
                },
                success: function (result) {
                    IsProjectOver = result;
                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });
            return IsProjectOver;
        }
        //End of Added by Chetan M on 10th Feb 2020 for IssueID = 21816

        //Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
        var blnIsProjectCreationWorkflowReqd = false;
        var strBaselineMessage = "";
        //End Of Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow

        //Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
        //function plotingHtml(data) {
        function plotingHtml(data, flag) {
            //End Of Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow

            $(".ShowPhaseInAT").toggle(data[0].ShowPhaseInAT);
            $(".ShowModuleInAT").toggle(data[0].ShowModuleInAT);
            $(".ShowSubProjectInAT").toggle(data[0].ShowSubProjectInAT);
            $(".ShowMilestoneInAT").toggle(data[0].ShowMilestoneInAT);
            $(".ShowChangeRequestInAT").toggle(data[0].ShowChangeRequestInAT);
            $(".ShowFeatureInAT").toggle(data[0].ShowFeatureInAT);
            $(".ShowEstimationTypeInAT").toggle(data[0].ShowEstimationTypeInAT);


            //if (data[0].ShowPhaseInAT == false) {

            //    $(".ShowPhaseInAT").css("display", "none");
            //} else {
            //    $(".ShowPhaseInAT").css("display", "block");
            //}

            //if (data[0].ShowModuleInAT == false) {

            //    $(".ShowModuleInAT").css("display", "none");
            //} else {
            //    $(".ShowModuleInAT").css("display", "block");
            //}


            //if (data[0].ShowSubProjectInAT == false) {
            //    $(".ShowSubProjectInAT").css("display", "none");
            //} else {
            //    $(".ShowSubProjectInAT").css("display", "block");
            //}


            // if (data[0].ShowMilestoneInAT == false) {
            //    $(".ShowMilestoneInAT").css("display", "none");
            //} else {
            //    $(".ShowMilestoneInAT").css("display", "block");
            //}

            //  if (data[0].ShowChangeRequestInAT == false) {
            //    $(".ShowChangeRequestInAT").css("display", "none");
            //} else {
            //    $(".ShowChangeRequestInAT").css("display", "block");
            //}

            //   if (data[0].ShowChangeRequestInAT == false) {
            //    $(".ShowChangeRequestInAT").css("display", "none");
            //} else {
            //    $(".ShowChangeRequestInAT").css("display", "block");
            //}

            //   if (data[0].ShowChangeRequestInAT == false) {
            //    $(".ShowChangeRequestInAT").css("display", "none");
            //} else {
            //    $(".ShowChangeRequestInAT").css("display", "block");
            //}



            if (data[0].PhaseMandatoryInAT) {
                $(".PhaseMandatoryInAT").addClass("required");
            } else {
                $(".PhaseMandatoryInAT").removeClass("required");
            }
            if (data[0].ModuleMandatoryInAT) {
                $(".ModuleMandatoryInAT").addClass("required");
            } else {
                $(".ModuleMandatoryInAT").removeClass("required");
            }
            if (data[0].SubProjectMandatoryInAT) {
                $(".SubProjectMandatoryInAT").addClass("required");
            } else {
                $(".SubProjectMandatoryInAT").removeClass("required");
            }
            if (data[0].MilestoneMandatoryInAT) {
                $(".MilestoneMandatoryInAT").addClass("required");
            } else {
                $(".MilestoneMandatoryInAT").removeClass("required");
            }
            if (data[0].ChangeRequestMandatoryInAT) {
                $(".ChangeRequestMandatoryInAT").addClass("required");
            } else {
                $(".ChangeRequestMandatoryInAT").removeClass("required");
            }
            if (data[0].FeatureMandatoryInAT) {
                $(".FeatureMandatoryInAT").addClass("required");
            } else {
                $(".FeatureMandatoryInAT").removeClass("required");
            }
            if (data[0].EstimationTypeMandatoryInAT) {
                $(".EstimationTypeMandatoryInAT").addClass("required");
            } else {
                $(".EstimationTypeMandatoryInAT").removeClass("required");
            }
            //Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
            if (data[0].IsProjectCreationWorkflowReqd == 1 || data[0].IsProjectCreationWorkflowReqd == true) {
                blnIsProjectCreationWorkflowReqd = true;
            } else {
                blnIsProjectCreationWorkflowReqd = false;
            }
            //End Of Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
            //if (data[0].IsProjectCreationWorkflowReqd: null
            //if (data[0].IsProductExecutionProject) {
            if (data[0].IsAgileMethodFollowed) {
                isAgileMethodused = 1;
                $(".AgileDiv").css("display", "inline-block");
                $("#isAgilelabel").addClass("required");//Added by Dipali V On 24th Jan 2020 For Agile Project US Manatory
                // $('#lbstorypoints').addClass("required");
            } else {
                isAgileMethodused = 0;
                $(".AgileDiv").css("display", "none");
                $("#isAgilelabel").removeClass("required");//Added by Dipali V On 24th Jan 2020 For Agile Project US Manatory
                // $('#lbstorypoints').removeClass("required");
            }
            //Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
            strBaselineMessage = "";
            if (flag == "addtask") {
                if (blnIsProjectCreationWorkflowReqd == true) {
                    var result = AJAXCallWithAuthorizeResult('/api/PM_wbs_card/GetProjetBaselineStatus', JSON.stringify({ ProjectID: $("#CboProject :selected").val() }), false);
                    if (result != undefined) {
                        if (result != "") {
                            for (var i = 0; i < result.length; i++) {
                                strBaselineMessage = result[i]["BaseLineMessage"];
                            }
                            if (strBaselineMessage != "") {
                                showAlert(strBaselineMessage, 'alert-danger');
                            }
                        }
                    }
                }
            }
            //End Of Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow            
        }


        //Attachment code start
        //Get Documents List
        var TagID = 1038;
        function GetDocumentsList(taskId) {
            var ProjectID = $("#CboProject :selected").val();
            $('[data-bs-toggle="tooltip"]').tooltip();
            var PMParameters = {
                UniqueID: taskId,
                TagID: encodeURI(TagID),
                RoleID: encodeURI('<%= Session("intPostID") %>')
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetDocumentsList',
                method: 'Post',
                data: JSON.stringify(PMParameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMParameters) ? PMParameters : JSON.stringify(PMParameters)));
                    }
                },
                success: function (result) {
                    //StartLoader("#body");
                    var category = new Array();
                    var IsData = 0;
                    $("#PRattachmentBody").html("");

                    var strHTML = "";
                    for (var i = 0; i < result.length; i++) {
                        var data = result[i];
                        category.push(data.Category);
                    }
                    category = category.filter(
                        function (a) { if (!this[a]) { this[a] = 1; return a; } },
                        {}
                    );
                    for (var j = 0; j < category.length; j++) {
                        //    alert(category.length);
                        IsData = 1;
                        strHTML += '<tr><td>' + category[j] + '</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>'
                        for (var i = 0; i < result.length; i++) {
                            var data = result[i];
                            if (category[j] == data.Category) {
                                var data = result[i];
                                strHTML += '<tr>'
                                strHTML += '<td> </td>'
                                if (data.SubCategory != null) {
                                    strHTML += '<td> ' + data.SubCategory + '</td>'
                                } else {
                                    strHTML += '<td> </td>'
                                }
                                strHTML += '<td> <a  href="" onclick="downloadfile(' + data.DocumentID + ',' + ProjectID + ',2191)">' + data.FileName + '</a> </td>'
                                if (data.Description.length < 20) {
                                    strHTML += '<td data-bs-toggle="tooltip"  data-bs-container="body" title="' + data.Description + '"> ' + data.Description + '</td>'
                                }
                                else {
                                    var str = data.Description.substring(0, 20);
                                    strHTML += '<td data-bs-toggle="tooltip"  data-bs-container="body" title="' + data.Description + '"> ' + str + '....</td>'

                                }
                                strHTML += '<td> ' + data.FileSize.toFixed(2) + '</td>'
                                strHTML += '<td> ' + data.UploadedDate + '</td>'
                                if (m_DeleteAccess == "True") {
                                    strHTML += '<td> ' + '<button class="nostylebtn delattachbtn" title="" onclick="DeletedAttachment(' + data.DocumentID + ')"><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Delete" class="far fa-trash-alt"></i></button></td>'
                                } else {
                                    strHTML += '<td> </td>'
                                }
                                strHTML += '</tr>'

                            }
                        }

                    }
                    // 
                    if (IsData == 0) {
                        $("#PRUpload").prop("disabled", true);
                    }
                    $("#PRattachmentBody").append(strHTML);
                    //StopAjaxLoader("#body");
                    category = [];



                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        //Added By Dipali V On 21st Jan 2020 For Delete Document

        function DeletedAttachment(DocumentId) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/DeleteDocument',
                method: 'Post',
                data: JSON.stringify(encodeURI(DocumentId)),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (DocumentId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(DocumentId) ? DocumentId : JSON.stringify(DocumentId)));
                    }
                },
                success: function (strResult) {
                    if (strResult != "") {
                        // debugger;
                        showAlert("Document Deleted Suceessfully", 'alert-success');
                        GetDocumentsList(hiddenTaskID);
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $('[data-bs-toggle="tooltip"]').click(function () {
                            $('[data-bs-toggle="tooltip"]').tooltip("hide");

                        });
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        //End of Added By Dipali V On 21st Jan 2020 For Delete Document

        function downloadfile(DocumentID, ProjectID, MasterTagID) {
            var strTemp = '../../PM/PM_ViewDocument.aspx?FromWhere=PM&MasterTagID=' + MasterTagID + '&DocumentID=' + DocumentID + '&ProjectID=' + ProjectID + '';
            window.open(strTemp);
        }

        var isValidTypeExeCheck;
        //Added by Parth.G
        async function Vdfileexe(file) {
            
            var objFile = file;
            if (!objFile) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("File is valid and ready to upload.");
                return
            }
            

            
            var fileName = objFile.value;

            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

            isValidTypeExeCheck = false;


            //const CheckForExcel = ["xlsx","xls"];
            //var ExcelFlag = CheckForExcel.includes(extension);
            //if (!ExcelFlag) {
            //    showAlert('Please Select Excel File', 'alert-danger');
            //    return;
            //}
            

            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
            isValidTypeExeCheck = ValidExtsExe.includes(extension);
            //alert(isValidTypeExeCheck);
            if (isValidTypeExeCheck) {
                const file = objFile.files[0];
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("File is valid and ready to upload.");
                        //alert("File is valid and ready to upload.");
                    })
                    .catch(error => {
                        //Added by Ajit L on 21/11/2024
                        var fileInput = objFile;
                        var fileNameInput = $(fileInput).closest('td').find('[id^="FileName"]');
                        // Before clearing:
                        console.log("Selected files before clearing:", fileInput.files);
                        $(fileInput).val(""); // Clear the file input
                        fileNameInput.val(""); // Clear the file name text input
                        // Clear the file input
                        $(objFile).val("");
                        //End of Added by Ajit L on 21/11/2024


                        console.log(error);
                        $(".file_attach form p").text("Click here to upload");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        isValidTypeExeCheck = false;

                        return;
                    });
                if (!isValidTypeExeCheck) {
                    return;
                }
            }

        }


        async function Vdfileexe1(file) {

            var objFile = file;
            if (!objFile) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("File is valid and ready to upload.");
                return
            }



            var fileName = objFile.value;

            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

            isValidTypeExeCheck = false;


            const CheckForExcel = ["xlsx", "xls"];
            var ExcelFlag = CheckForExcel.includes(extension);
            if (!ExcelFlag) {
                showAlert('Please Select Excel File', 'alert-danger');
                return;
            }


            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
            isValidTypeExeCheck = ValidExtsExe.includes(extension);
            //alert(isValidTypeExeCheck);
            if (isValidTypeExeCheck) {
                const file = objFile.files[0];
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("File is valid and ready to upload.");
                        //alert("File is valid and ready to upload.");
                    })
                    .catch(error => {
                        //Added by Ajit L on 21/11/2024
                        var fileInput = objFile;
                        var fileNameInput = $(fileInput).closest('td').find('[id^="FileName"]');
                        // Before clearing:
                        console.log("Selected files before clearing:", fileInput.files);
                        $(fileInput).val(""); // Clear the file input
                        fileNameInput.val(""); // Clear the file name text input
                        // Clear the file input
                        $(objFile).val("");
                        //End of Added by Ajit L on 21/11/2024


                        console.log(error);
                        $(".file_attach form p").text("Click here to upload");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        isValidTypeExeCheck = false;

                        return;
                    });
                if (!isValidTypeExeCheck) {
                    return;
                }
            }

        }

        //add attachment
        var i = "1";
        var j = "1";
        var k = "1";
        var l = "1";
        var counter = 0;
        var PRCounter = 0;
        $("#PRaddattachnebtrow").on("click", function () {

            var newRow = $("<tr class='attachments'>");
            var cols = "";
            cols = '<td><select  style="width: 90%;" id="PRasdCat' + PRCounter + '" class="form-control form-select" onchange="PRCategoryOnChange(this.id,this);"><option></option></select><span style="color:red;float: right;margin-top: -25px;">*</span></td>';
            cols += '<td><select id="PRasdsubCat' + PRCounter + '" class="form-control form-select"><option value="0">Select Sub Category</option></select></td>';
            //Added by Parth.G For onchange
           // cols += '<td><input id="PRAfilname' + PRCounter + '" type="file" name="img[]" class="file" onchange="Vdfileexe(this)"> <div class="input-group col-xs-12 fileup"><span class="input-group-btn"><button class="browse browsebtn" type="button"><i class="fas fa-paperclip" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Select File"></i></button></span><input type="text" class="form-control" disabled="" placeholder="Upload Files" style="width:105px"></td>'
            cols += '<td><input id="PRAfilname' + PRCounter + '" type="file" name="img[]" class="file" onchange="Vdfileexe(this)"> <div class="input-group col-xs-12 fileup"><span class="input-group-btn"><button class="browse browsebtn" type="button"><i class="fas fa-paperclip" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Select File"></i></button></span><input id="FileName' + PRCounter + '" type="text" class="form-control" disabled="" placeholder="Upload Files" style="width:105px"></td>' //Id Added by Ajit L on 22/11/2024
            //Added by Parth.G For onchange
            //Added & Commented by Dipali v On 21st Jan 2020 For Width of Textarea
            //cols += '<td><textarea rows="4" cols="50" id="PRadescription' + PRCounter + '" class="form-control" maxlength="100" placeholder=""></textarea></td>';
            cols += '<td><textarea rows="4" cols="50" id="PRadescription' + PRCounter + '" class="form-control" maxlength="100" placeholder="" style="width:120px"></textarea></td>';
            //End of Added & Commented by Dipali v On 21st Jan 2020 For Width of Textarea
            cols += '<td></td>';
            cols += '<td></td><td><button class="ibtnDel nostylebtn" title="Remove" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Delete"><i class="fa fa-times" value="Delete" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Remove"></i></button></td>';
            newRow.append(cols);
            //  $("#PRadescription" + PRCounter).text("");
            $("table.order_attchmentlist").append(newRow);
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('table.order_attchmentlist').find('.attachdate').datepicker();
            //  
            GetDocumnetCategoryList("#PRattachmentBody > tr > td:nth-child(1)>select#PRasdCat" + PRCounter);

            i++;
            j++;
            k++;
            l++;
            counter++;
            PRCounter++;
            //$(".delattachbtn").prop('disabled', true);
            // $(".delattachbtn").css("cursor", "not-allowed");
            clearTooltip();//Added by Dipali V On 21st Jan 2020 For Remove ToolTip
            $("#PRUpload").prop('disabled', false);
        });
        // var IsRemove = 0;
        $("table.order_attchmentlist").on("click", ".ibtnDel", function (event) {

            $(this).closest("tr").remove();
            clearTooltip();
            counter = counter - 1;
            PRCounter = PRCounter - 1;
            if ($(".attachments").find(".ibtnDel").length == 0) {
                $(".delattachbtn").prop('disabled', false);
                $(".delattachbtn").css("cursor", "pointer");
                $("#PRUpload").prop('disabled', true);
            } else {
                //$(".delattachbtn").prop('disabled', true);
                //$(".delattachbtn").css("cursor", "not-allowed");
                $("#PRUpload").prop('disabled', false);
            }
        });


        //Added By Dipali V On 21st Jan 2020 For Clear Tooltip
        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
        }
        //End of Added By Dipali V On 21st Jan 2020 For Clear Tooltip
        //get Document Category List
        function GetDocumnetCategoryList(cboId) {
            var ProjectID = $("#CboProject :selected").val();
            var PMParameters = {
                ProjectID: encodeURI(ProjectID),
                RoleID: encodeURI('<%= Session("intPostID") %>')
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetDocumnetCategoryList',
                method: 'Post',
                data: JSON.stringify(PMParameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMParameters) ? PMParameters : JSON.stringify(PMParameters)));
                    }
                },
                success: function (strResult) {
                    //   alert(strResult.length);
                    $(cboId).empty();
                    //  
                    if (strResult != undefined) {
                        var selHTML = "";
                        selHTML += "<option  value=0 > Select Category </option>";
                        for (var i = 0; i < strResult.length; i++) {
                            var d = strResult[i];
                            var CategoryID = d.CategoryID;
                            var Category = d.Category;
                            selHTML += "<option  value='" + CategoryID + "' >" + Category + "</option>";
                        }


                        $(cboId).html(selHTML);
                        $('[data-bs-toggle="tooltip"]').tooltip();

                    }


                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        //category onchange
        function PRCategoryOnChange(id, val) {

            var subcategoryid = id;
            var addstr = "sub";
            var position = 5;
            subcategoryid = [subcategoryid.slice(0, position), addstr, subcategoryid.slice(position)].join('');
            var category = val.value;
            GetPRDocumnetSubCategoryList(subcategoryid, category, null);
        }

        //get Document sub Category List
        function GetPRDocumnetSubCategoryList(SubCategoryId, Category, SubCategory) {
            var ProjectID = $("#CboProject :selected").val();
            var AttachmentDocuments = {
                Category: encodeURI(Category),
                SubCategory: encodeURI(SubCategory),
                ProjectID: encodeURI(ProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetDocumnetSubCategoryList',
                method: 'Post',
                data: JSON.stringify(AttachmentDocuments),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (AttachmentDocuments) {
                        xhr.setRequestHeader("Params", encryptString(isJson(AttachmentDocuments) ? AttachmentDocuments : JSON.stringify(AttachmentDocuments)));
                    }

                },
                success: function (strResult) {
                    $("#PRattachmentBody > tr > td:nth-child(2)>select#" + SubCategoryId).empty();
                    if (strResult != undefined) {
                        var selHTML = "";
                        selHTML += "<option  value=0 > Select Sub Category </option>";
                        for (var i = 0; i < strResult.length; i++) {
                            var d = strResult[i];
                            var SubCategoryID = d.SubCategoryID;
                            var SubCategory = d.SubCategory;
                            selHTML += "<option  value='" + SubCategoryID + "' >" + SubCategory + "</option>";
                        }
                        $("#PRattachmentBody > tr > td:nth-child(2)>select#" + SubCategoryId).html(selHTML);
                        $('[data-bs-toggle="tooltip"]').tooltip();


                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        $(document).on('click', '.browse', function () {
            //Commented and added by Chetan M on 30th Jan 2020 for Issue ID =21640
            //Commented & Added By Dipali V On 11th April 2023 For unable to select file
            var file = $(this).parent().parent().parent().find('.file');
            //var file = $(this).parent().find('.file');
            //End of Commented and added by Chetan M on 30th Jan 2020 for Issue ID =21640
            //End of Commented & Added By Dipali V On 11th April 2023 For unable to select file
            file.trigger('click');
        });

        $(document).on('change', '.file', function () {

            $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
        });


        //$("#PRUpload").click(function () {
        $(document).on('click', "#PRUpload", function () {

            var ProjectID = $("#CboProject :selected").val();
            var chkCategory;
            Flag = true;
            var formdata = new FormData();
            var LoginType = '<%= Session("LoginType") %>';
            var UserName = '<%= Session("strUserName") %>';
            var AttachedFileData = new Array();
            var Files = new Array();
            var d = new Date();
            var month = d.getMonth() + 1;
            var day = d.getDate();
            var CategoryName;
            var SubCategoryName;
            var Category;
            var SubCategory;
            var Parameters = {
                UserID: UserID,
                LoginType: LoginType,
                ProjectID: ProjectID,
                RoleID: '<%= Session("intpostID") %>',
                TagID: TagID,
                UniqueID: hiddenTaskID,
            };
            $('#PRattachmentBody > tr.attachments').each(function (index, value) {

                var Description = "";
                var File;
                var Date = "";
                var allColumns = $(this).find('td');
                $(allColumns).each(function (i, v) {
                    if (i == 0) {
                        if (Flag == true) {

                            var id = $(this).find('*[id*=PRasdCat]').attr("id");
                            var curCatIndex = 0;
                            curCatIndex = id.replace(/PRasdCat/g, "");

                            CategoryName = $("#PRattachmentBody > tr > td:nth-child(1)>select#PRasdCat" + (curCatIndex) + " option:selected").text();
                            Category = $("#PRattachmentBody > tr > td:nth-child(1)>select#PRasdCat" + (curCatIndex)).val();
                            if (Flag == true) {
                                if (Category == 0) {
                                    showAlert("Please Select Category ", "alert-danger");
                                    $("#PRattachmentBody > tr > td:nth-child(1)>select#PRasdCat" + (curCatIndex)).focus();
                                    Flag = false;

                                }
                            }
                        }
                    }
                    if (i == 1) {
                        var id = $(this).find('*[id*=PRasdsubCat]').attr("id");
                        var curCatIndex = 0;
                        curCatIndex = id.replace(/PRasdsubCat/g, "");
                        SubCategoryName = $("#PRattachmentBody > tr > td:nth-child(2)>select#PRasdsubCat" + (curCatIndex) + " option:selected").text();
                        SubCategory = $("#PRattachmentBody > tr > td:nth-child(2)>select#PRasdsubCat" + (curCatIndex)).val();
                    }

                    if (Flag == true) {
                        if (i == 2) {
                            var id = $(this).find('*[id*=PRAfilname]').attr("id");
                            var curCatIndex = 0;
                            curCatIndex = id.replace(/PRAfilname/g, "");
                            var id = $('#PRattachmentBody > tr > td:nth-child(3)>#PRAfilname' + (curCatIndex));
                            var getfileName = id[0].files[0];
                            Flag = PRValidateAttachment('PRAfilname' + (curCatIndex), id);
                            formdata.append("file" + curCatIndex, getfileName);

                        }

                        if (i == 3) {
                            Description = $(this).find('textarea').val().trim();
                            //Added By Rehan C To add Validator for Special characters on 08th Nov 2022
                            if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                                $("#PRadescription0").focus();
                                Flag = false;
                            }//End of comment

                        }
                    }
                });

                var item = {
                    Description: Description,
                    CategoryName: CategoryName,
                    Category: Category,
                    SubCategoryName: SubCategoryName,
                    SubCategory: SubCategory,
                    Parameters: Parameters,
                    UniqueID: hiddenTaskID,
                }
                AttachedFileData.push(item);
            });
            formdata.append("AttachedFileData", JSON.stringify(AttachedFileData));
            //StartLoader("#body");
            if (Flag == true) {
                $.ajax({
                    url: strUrl + '/api/PM_wbs_card/InsertDocumnetAttachment',
                    type: "POST",
                    dataType: "json",
                    data: formdata,
                    contentType: false,
                    processData: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (result) {
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        if (result == 'File Uploaded Successfully') {
                            showAlert(result, 'alert-success');
                            $('#PRattachmentBody > tr.attachments').each(function (index, value) {
                                $(this).remove();
                            });
                            counterFORattachment = 0;
                            counter = 0;
                            PRCounter = 0;
                            i = "1";
                            j = "1";
                            k = "1";
                            l = "1";
                            $("#PRattachmentBody").empty();
                            GetDocumentsList(hiddenTaskID);
                            $('[data-bs-toggle="tooltip"]').tooltip();
                        }
                        else {
                            $(".Stakeholdertbl").find("tr").removeClass("tropen");
                            $("#stakedetailpanel .main_graybgtbs li:nth-child(2) a, #stakedetailpanel .main_graybgtbs li:nth-child(3n) a").css("cursor", "pointer");
                            $("#stakedetailpanel").hide('fast');
                            $("#hidestaklist").show('fast');
                            showAlert(result, "alert-danger");
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            //StopAjaxLoader("#body");
        });

        function PRValidateAttachment(fileid, filePath) {
            var ValidateAttachmentFlag = true;
            var objFileName = document.getElementById(fileid);
            if (filePath.get(0).files['0'] != undefined) {
                if (objFileName != null && objFileName != undefined) {
                    if (disallowSpecialCharacters(objFileName, 'Special character # is not allowed', true, '#')) { ValidateAttachmentFlag = false; return false; }

                    if (disallowSpecialCharacters(objFileName, 'Single quotation mark is not allowed in file name', true, "'")) { ValidateAttachmentFlag = false; return false; }

                    var countOfDot, FileNameCharCount;
                    var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
                    var intActualFileSize = (filePath.get(0).files['0'].size);


                    if (filePath.get(0).files['0'].name != '')
                        var countOfDot = filePath.get(0).files['0'].name.split(".").length - 1;

                    if (countOfDot > 1) {
                        showAlert('File with two or more extensions is not allowed!', "alert-danger");
                        ValidateAttachmentFlag = false;
                        return false;
                    }

                    if (filePath.get(0).files['0'].name != '')
                        FileNameCharCount = filePath.get(0).files['0'].name.split(".")[0].length;

                    if (FileNameCharCount > 120) {

                        showAlert('File name should not exceed 120 characters!', "alert-danger");
                        ValidateAttachmentFlag = false;
                        return false;
                    }

                    if (intActualFileSize < intMinFileSize) {
                        showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', "alert-danger");
                        ValidateAttachmentFlag = false;
                        return false;
                    }
                }
            }
            else {
                showAlert('Please Select  File', "alert-danger");
                return false;
            }

            return ValidateAttachmentFlag;
        }

        //replace 
        function replaceAllChar(text, replacechar, replacewith) {
            if (text == null || text == undefined) {
                return text;
            }
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

        function isWork(obj) {

            if (isBlank(getInputValue(obj))) { return false; }

            var msg = (arguments.length > 1) ? arguments[1] : "";
            var dofocus = (arguments.length > 2) ? arguments[2] : true;
            var sSep = (arguments.length > 3) ? arguments[3] : ":";
            var minHr = (arguments.length > 4) ? arguments[4] : 0;
            var maxHr = (arguments.length > 5) ? arguments[5] : 2147483647;
            var minMin = (arguments.length > 6) ? arguments[6] : 0;
            var maxMin = (arguments.length > 7) ? arguments[7] : 59;
            msg = replaceSubstring(msg, "&#39;", "'");

            if (isWork_Main(obj, sSep, minHr, maxHr, minMin, maxMin)) {
                return true;
            }
            else {
                setFocus(obj);
                return false;
            }
        }

        function isWork_Main(objTime) {
            var sSep = (arguments.length > 1) ? arguments[1] : ":";
            var minHr = (arguments.length > 2) ? arguments[2] : 0;
            var maxHr = (arguments.length > 3) ? arguments[3] : 2147483647;
            var minMin = (arguments.length > 4) ? arguments[4] : 0;
            var maxMin = (arguments.length > 5) ? arguments[5] : 59;

            var time = objTime.value; var index; index = time.indexOf(sSep);
            //If sSep not entered or hour is more than 10 digit then return false.
            if (index <= 0 || index > 10) { return false; }
            else {
                //If minute is not entered return false.
                if (index == time.length - 1 || index + 2 != time.length - 1) { return false; }
                else {
                    var hour, minute, minPart1;
                    try { hour = parseInt(time.substring(0, index), 10); if (isNaN(hour)) { return false; } }
                    catch (e) { return false; }

                    if (hour < minHr || hour > maxHr) { return false; }

                    try { minute = parseInt(time.substring(index + 1, time.length), 10); if (isNaN(minute)) { return false; } }
                    catch (e) { return false; }

                    if (minute < minMin || minute > maxMin) { return false; }

                }
            }
            return true;
        }

        var flag = false;
        function Save_OnClick() {
            try {

                flag = false;
                //endded by Nilesh on 8/1/2015 for loader add on save link    
                var objCurrentWork, objCurrentStartDate, objCurrentEndDate;

                //Added by swapnil aswale on 17th Nov 2015 for special character validation
                var objTaskName;
                ////objTaskName = GetObjectReference('frmTaskAssignment', 'txtTaskName');
                objTaskName = document.getElementById("txtTaskName");

                objCurrentStartDate = document.getElementById("txtStartDate");
                objCurrentEndDate = document.getElementById("txtEndDate");
                objEmployee = document.getElementById("cboResource");


                objActualWork = document.getElementById('hdn_txtActualWork');
                objPlannedWork = document.getElementById('hdn_txtPlannedWork');
                objCurrentWork = document.getElementById('txtWorks');

                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                objtxthidCurrentWork = document.getElementById('txthdnCurrentWork');

                //Added by Usha Pandit on 01-Apr-2019 Purpose::Whizible 2 Work field change
                if (objtxthidCurrentWork != null && objtxthidCurrentWork != undefined)
                    objtxthidCurrentWork.value = objCurrentWork.value;
                //End of Added by Usha Pandit on 01-Apr-2019 Purpose::Whizible 2 Work field change


                var objDeliverableID = document.getElementById('cboDeliverable');
                var objModuleID = document.getElementById('cboModule');
                var objSubProjectID = document.getElementById('cboSubProject');
                var objMilestoneID = document.getElementById('cboMilestone');
                var objCurrentWork = document.getElementById('txtWorks');
                var objTaskStartDate = document.getElementById('txtStartDate');
                var objTaskEndDate = document.getElementById('txtEndDate');
                var strUrl;
                var objEmployee = document.getElementById('cboResource');

                //Added by Shraddha M on 24,Jun 2009 for PMLifeLine
                //JS Error while adding task.Module,Sub Project milestone are configurable.If one of these is not on page 
                //then object is null.
                var ModuleID;
                var SubProjectID;
                var MilestoneID;
                var DeliverableID;
                //Modified by purvaj on 10 Aug 2009. else codition added. value was not getting set to the variable if the object contains value.
                if (objModuleID == null)
                    ModuleID = '';
                else
                    ModuleID = objModuleID.value;

                if (objSubProjectID == null)
                    SubProjectID = '';
                else
                    SubProjectID = objSubProjectID.value;

                if (objMilestoneID == null)
                    MilestoneID = '';
                else
                    MilestoneID = objMilestoneID.value;

                if (objDeliverableID == null)
                    DeliverableID = '';
                else
                    DeliverableID = objDeliverableID.value;

                if (objEmployee != null) {
                    var counter;
                    counter = 0;

                    for (var i = 0; i < objEmployee.length; i++) {
                        if (objEmployee[i].selected)
                            counter++;
                    }
                    var str;
                    str = "<%=CommonFunctions.Application.DistributeWorkInAT%>"
                    if (str == "True")
                        dblLCEHrs = parseFloat(objCurrentWork.value);
                    else
                        dblLCEHrs = parseFloat(objCurrentWork.value) * counter;
                }
                else
                    dblLCEHrs = parseFloat(objCurrentWork.value);

                //Commented and Added by Shraddha M on 24,Jun 2009 for PMLifeLine
                var stringUrl = "../../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId=" + hiddenTaskID + "&StartDate=" + encodeURIComponent(objTaskStartDate.value.replace(" ", "-").replace(" ", "-")) + "&EndDate=" + encodeURIComponent(objTaskEndDate.value.replace(" ", "-").replace(" ", "-")) + "&DeliverableID=" + DeliverableID + "&ModuleID=" + ModuleID + "&SubProjectID=" + SubProjectID + "&MilestoneID=" + MilestoneID + "&Work=" + String(dblLCEHrs);
                //End of comment and addition by Shraddha M

                if (objtxthidCurrentWork != null && objActualWork != null && parseFloat(objtxthidCurrentWork.value) < parseFloat(objActualWork.value)) {
                    showAlert('Planned Work hours should be greater than Actual work hours(' + objActualWork.value + ').', 'alert-danger');
                    objCurrentWork.focus();
                    objCurrentWork.select();
                    return;
                }

                //if (objCurrentWork!=null && objPlannedWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objPlannedWork.value))
                if (objtxthidCurrentWork != null && objPlannedWork != null && parseFloat(objtxthidCurrentWork.value) < parseFloat(objPlannedWork.value)) {
                    showAlert('Planned Work hours should be greater than Planned work hours of child tasks (' + objPlannedWork.value + ').', 'alert-danger');
                    objCurrentWork.focus();
                    objCurrentWork.select();
                    return;
                }

                obCurrentDate = document.getElementById('txtEndDate');
                objCurrentStartDt = document.getElementById('txtStartDate');
                objPlannedendDate = document.getElementById('hdn_txtTaskEndDate');
                objPlannedStartDate = document.getElementById('hdn_txtTaskStartDate');
                objActualStartDate = document.getElementById('hdn_txtActualStartDate');
                dtCurrentDate = getDate(obCurrentDate.value.replace(" ", "-").replace(" ", "-"));
                dtCurrentStartDt = getDate(objCurrentStartDt.value.replace(" ", "-").replace(" ", "-"));
                dtPlannedendDat = getDate(objPlannedendDate.value.replace(" ", "-").replace(" ", "-"));
                dtPlannedStartDate = getDate(objPlannedStartDate.value.replace(" ", "-").replace(" ", "-"));
                dtActualStartDate = getDate(objActualStartDate.value.replace(" ", "-").replace(" ", "-"));

                objActualEndDate = document.getElementById('hdn_txtActualEndDate');
                if (objActualEndDate) {
                    dtActualEndDate = getDate(objActualEndDate.value.replace(" ", "-").replace(" ", "-"));
                }

                if (objPlannedendDate.value != '' && dtCurrentDate < dtPlannedendDat) {
                    showAlert('Planned End Date should not be less than Planned End Date of child tasks (' + objPlannedendDate.value + ').', 'alert-danger');
                    return;
                }

                if (objPlannedStartDate.value != '' && dtCurrentStartDt > dtPlannedStartDate) {
                    showAlert('Planned Start Date should not be greater than  start Date of child tasks (' + objPlannedStartDate.value + ').', 'alert-danger');
                    return;
                }

                if (objCurrentStartDt != null && objActualWork != null && objActualStartDate.value != '' && dtCurrentStartDt > dtActualStartDate && objActualStartDate.value != '0') {
                    showAlert('Planned Start Date should not be greater than Actual start Date (' + objActualStartDate.value + ').', 'alert-danger');
                    return;
                }

                if (objActualEndDate) {
                    if (obCurrentDate != null && objActualWork != null && objActualEndDate.value != '' && dtCurrentDate < dtActualEndDate && objActualEndDate.value != '0') {
                        showAlert('Planned End Date should not be less than Actual End Date (' + objActualEndDate.value + ').', 'alert-danger');
                        return;
                    }
                }

                if (ValidateControls() == false)
                    return;

                stringUrl = stringUrl + "&FromPage=AssignTaskEditMode";

                ValidateTask_Baseline(stringUrl);

                if (strResult != null && strResult != "") {
                    var objEmployeeCombo = document.getElementById('cboResource');
                    if (objEmployeeCombo != null) {
                        objEmployeeCombo.disabled = true;
                    }
                    showAlert(strResult, 'alert-danger');
                    return;
                }

                var intCounter;
                var strEmployeeList;
                strEmployeeList = '';
                if (objEmployee != null) {
                    for (intCounter = 0; intCounter < objEmployee.options.length; intCounter++) {
                        if (objEmployee.options[intCounter].selected == true) {
                            strEmployeeList += objEmployee.options[intCounter].value + ','
                        }
                    }
                }
                stringUrl = new String();
                //stringUrl = "../../General/XMLHttp.aspx?TagID=1038&TaskId="+hiddenTaskID+"&PROJECT_SETTINGS=m_strProjectSetting&FromDate=" + encodeURIComponent(objCurrentStartDate.value) + "&ToDate=" + encodeURIComponent(objCurrentEndDate.value) + "&EmployeeIDs=" + strEmployeeList;


                //if (strResult == "")
                //    generateRequest(strUrl);
                flag = true;
            }
            catch (ex) {
            }
        }

        $(document).on('click', '#btnTaskSave', function () {
            var jsStartDate = $('#txtStartDate').datepicker('getDate');
            var jsEndDate = $('#txtEndDate').datepicker('getDate');
            var StartDate = new Date(jsStartDate);
            var EndDate = new Date(jsEndDate);

            var objCurrentWork = document.getElementById('txtWorks');
            var isworkFormatWrong = false;
            var isworkFormatnonnumeric = false;
            var isnottwodecimal = false;
            var isminutesnotbetween = false;
            if (objCurrentWork.value.indexOf(".") != -1) {
                //showAlert("Please enter Work in H:M format.", 'alert-danger');
                setFocus(objCurrentWork);
                isworkFormatWrong = true;
            }
            // debugger;
            var Work = objCurrentWork.value.replace(":", ".");
            var isdigit = isNumeric(Work);
            if (isdigit == false) {
                isworkFormatnonnumeric = true;
            }

            if ($("#txtWorks").val().indexOf('-') !== -1) {
                isworkFormatnonnumeric = true;
            }


            var precision = '';
            if (objCurrentWork.value.indexOf(":") != -1) {
                precision = objCurrentWork.value.split(":")[1];
            }

            if (precision.length > 2) {
                isnottwodecimal = true;
            }

            if (precision != "" && precision != undefined) {
                if (precision > 59 || precision < 0) {
                    isminutesnotbetween = true;
                }
            }
            //Added By Usha Pandit On 28.08.2020 For getting hours and minutes
            var hrs, mins;
            var TaskName = $("#txtTaskName").val();
            var Desc = $("#txtTaskNotes").val();
            if ($('#txtWorks').val() != "") {
                var idxColon = $('#txtWorks').val().indexOf(':');

                hrs = $('#txtWorks').val().substring(0, idxColon);

                mins = $('#txtWorks').val().substring(idxColon + 1, $('#txtWorks').val().length);
            }
            //Added By Rehan C To add Validator for Special characters on 15th Nov 2022          
            if (checkSpecialCharacter(TaskName, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Task Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                /*$(ControlValidationFieldID[i]).focus()*/
                $("#txtTaskName").focus();
                return;
            }
            //End of commment By Rehan C To add Validator for Special characters on 15th Nov 2022

            //Added By Rehan C To add Validator for Special characters on 15th Nov 2022          
            if (checkSpecialCharacter(Desc, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                /*$(ControlValidationFieldID[i]).focus()*/
                $("#txtTaskNotes").focus();
                return;
            }
            //End of commment By Rehan C To add Validator for Special characters on 15th Nov 2022

            //End Of Added By Usha Pandit On 28.08.2020 For getting hours and minutes
            if (isBlank(Trim($("#txtTaskName").val()))) {
                showAlert('<%= MyBase.GetResourceString("C_Name_Mandatory_Text") %>', 'alert-danger');
                $("#txtTaskName").focus();
                return;
            }

            else if (disallowSpecialCharacters(document.getElementById('txtTaskName'))) {
                showAlert('<%= MyBase.GetResourceString("C_Name_SpecialCharactorsNotAllowed") %>', 'alert-danger');
                $("#txtTaskName").focus();
                return;
            }
            else if (isBlank($("#cboResource :selected").val()) || $("#cboResource :selected").val() == '0' || $("#cboResource :selected").val() == null) {
                showAlert('<%= MyBase.GetResourceString("C_SelectResource") %>', 'alert-danger');
                $("#cboResource").focus();
                return false;
            }
            else if ($('#txtStartDate').val().trim().length == 0) {
                showAlert('<%= MyBase.GetResourceString("C_StartDate_Blank") %>', "alert-danger");
                $('#txtStartDate').focus();
                return;
            }
            else if ($('#txtEndDate').val().trim().length == 0) {
                showAlert('<%= MyBase.GetResourceString("C_EndDate_Blank") %>', "alert-danger");
                $('#txtEndDate').focus();
                return;
            }
            //Commented And Added By Usha Pandit On 30.08.2020 For getting manadatory alert for user story
            //else if (isAgileMethodused == 1 && $("#cboUserStory").val() == "") {
            else if (isAgileMethodused == 1 && ($("#cboUserStory").val() == "" || $("#cboUserStory").val() == "0" || $("#cboUserStory").val() == null || $("#cboUserStory").val() == undefined)) {
                //End Of Added By Usha Pandit On 30.08.2020 For getting manadatory alert for user story
                showAlert('User Story should not be left blank', "alert-danger");
                $('#cboUserStory').focus();
                return;
            }
            else if (StartDate > EndDate) {
                $('#txtEndDate').focus();
                showAlert('<%= MyBase.GetResourceString("C_StartDate_Greater") %>', "alert-danger");
                return;
            }

            else if ($('#txtWorks').val().trim().length == 0) {
                showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
                $('#txtWorks').focus();
                return;
            }
            //added by dipali Vekhande on 21st Jan 2020 For Work Hours should be greater than zero
            else if (parseFloat($('#txtWorks').val()) == parseFloat(0) && mins == parseFloat(0)) { //Added By Usha Pandit On 28.08.2020 For getting hours and minutes              
                showAlert('<%= MyBase.GetResourceString("C_Work_zero") %>', "alert-danger");
                $('#txtWorks').focus();
                return;
            }
            //End of added by dipali Vekhande on 21st Jan 2020 For Work Hours should be greater than zero
            else if (isworkFormatWrong) {
                showAlert("Please enter Work in H:M format.", 'alert-danger');
                $('#txtWorks').focus();
                return;
            }
            else if (isworkFormatnonnumeric) {
                showAlert("Please Enter only positive numeric value For Work in H:M format.", 'alert-danger');
                $('#txtWorks').focus();
                return;
            }
            else if (isnottwodecimal) {
                showAlert("Please enter minutes in two decimal and less than 60.", 'alert-danger');
                $('#txtWorks').focus();
                return;
            }
            else if (isminutesnotbetween) {
                showAlert('Please enter minutes between (0-59) range.', 'alert-danger');
                $('#txtWorks').focus();
                return;
            }
            else if (isBlank($("#cboPriority :selected").val()) || $("#cboPriority :selected").val() == '0' || $("#cboPriority :selected").val() == null) {
                showAlert('<%= MyBase.GetResourceString("C_Priority_Blank") %>', 'alert-danger');
                $('#cboPriority').focus();//Added By Dipali V On 23rd Jan 2020 For Focus Priority
                return;
            }
            else if (isBlank($("#cboTaskType :selected").val()) || $("#cboTaskType :selected").val() == '0' || $("#cboTaskType :selected").val() == null || $("#cboTaskType :selected").val() == "") {
                showAlert('<%= MyBase.GetResourceString("C_TaskType_Blank") %>', 'alert-danger');
                $("#taskmapping").addClass('in');//added by Dipali Vekhande on 21st jan 2020 for after focus to controll,div should be open 
                $('#cboTaskType').focus();

                return;
            }
            //Added By Dipali V on 11th Feb 2020 For Story point validation with US
            if (isAgileMethodused == 1) {
                //Added By Usha Pandit On 28.08.2020 For validating start-end date with sprint start-end date
                if ($('#txtStartDate').val().trim() != '' && $('#txtEndDate').val().trim() != '') {

                    var result = AJAXCallWithAuthorizeResult('/api/PM_wbs_card/CheckIterationDates', JSON.stringify({ UserStoryID: $('#cboUserStory').val(), StartDate: $('#txtStartDate').val().trim(), EndDate: $('#txtEndDate').val().trim() }), false);
                    //alert(result);
                    if (result != undefined) {
                        if (result != "") {
                            var strMsg = String(result).split("_");
                            showAlert(strMsg[1], 'alert-danger');
                            return;
                        }
                    }
                }
                //End Of Added By Usha Pandit On 28.08.2020 For validating start-end date with sprint start-end date

                //Added By Usha Pandit On 28.08.2020 For validating task work hours with sprint work hours
                if ($('#txtWorks').val().trim() != '' && $('#txtWorks').val().trim() != '0') {
                    var result = AJAXCallWithAuthorizeResult('/api/PM_wbs_card/CheckIterationEfforts', JSON.stringify({ UserStoryID: $('#cboUserStory').val(), WorkInHours: $('#txtWorks').val().trim(), TaskID: hiddenTaskID }), false);
                    //alert(result);
                    if (result != undefined) {
                        if (result != "") {
                            showAlert(result, 'alert-danger');
                            return;
                        }
                    }
                }
                //End Of Added By Usha Pandit On 28.08.2020 For validating task work hours with sprint work hours

                if ($("#cboUserStory").val() != "") {
                    //Added By Usha Pandit On 28.08.2020 For Story point validation for decimal check
                    var n = $("#txtStoryPoint").val();
                    var result = (n - Math.floor(n)) !== 0;

                    if (result) {
                        showAlert('Please enter Story Points without decimal', 'alert-danger');
                        $("#txtStoryPoint").focus();
                        return;
                    }
                    //End Of Added By Usha Pandit On 28.08.2020 For Story point validation for decimal check
                    var Remaining = 0;
                    if ((parseInt($("#txtStoryPoint").val() - 0)) > (parseInt($("#hdnstorypoints").val() - 0))) {
                        //debugger;
                        //if ($("#hdnstorypoints").val() < $("#txtStoryPoint").val()) {
                        //    Remaining = 0;
                        //} else {

                        Remaining = $("#hdnstorypoints").val();
                        //}
                        showAlert('Story Point should not exceed User story remaining story point ' + Remaining, 'alert-danger');
                        $('#txtStoryPoint').focus();
                        return;
                    }

                }

            }
            //End of Added By Dipali V on 11th Feb 2020 For Story point validation with US
            if (projectDetails.length >= 0) {
                if (projectDetails[0].PhaseMandatoryInAT) {
                    if ($('#cboPhase').val() == "" || $('#cboPhase').val() == "0" || $('#cboPhase').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_Phase") %>', "alert-danger");
                        $("#taskmapping").addClass('in');//added by Dipali Vekhande on 21st jan 2020 for after focus to controll,div should be open 
                        $('#cboPhase').focus();

                        return;
                    }
                }
                if (projectDetails[0].MilestoneMandatoryInAT) {
                    if ($('#cboMilestone').val() == "" || $('#cboMilestone').val() == "0" || $('#cboMilestone').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_Milestone") %>', "alert-danger");
                        $("#taskmapping").addClass('in');//added by Dipali Vekhande on 21st jan 2020 for after focus to controll,div should be open 
                        $('#cboMilestone').focus();

                        return;
                    }
                }
                if (projectDetails[0].ModuleMandatoryInAT) {
                    if ($('#cboModule').val() == "" || $('#cboModule').val() == "0" || $('#cboModule').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_Module") %>', "alert-danger");
                        $("#taskmapping").addClass('in');//added by Dipali Vekhande on 21st jan 2020 for after focus to controll,div should be open 
                        $('#cboModule').focus();

                        return;
                    }
                }
                if (projectDetails[0].SubProjectMandatoryInAT) {
                    if ($('#cboSubProject').val() == "" || $('#cboSubProject').val() == "0" || $('#cboSubProject').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_SubProject") %>', "alert-danger");
                        $("#taskmapping").addClass('in');//added by Dipali Vekhande on 21st jan 2020 for after focus to controll,div should be open 
                        $('#cboSubProject').focus();

                        return;
                    }
                }
                if (projectDetails[0].ChangeRequestMandatoryInAT) {
                    if ($('#cboChangeRequest').val() == "" || $('#cboChangeRequest').val() == "0" || $('#cboChangeRequest').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_ChangeRequest") %>', "alert-danger");
                        $("#taskmapping").addClass('in');//added by Dipali Vekhande on 21st jan 2020 for after focus to controll,div should be open 
                        $('#cboChangeRequest').focus();

                        return;
                    }
                }
                if (projectDetails[0].FeatureMandatoryInAT) {
                    if ($('#cboFeature').val() == "" || $('#cboFeature').val() == "0" || $('#cboFeature').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_Feature") %>', "alert-danger");
                        $("#taskmapping").addClass('in');//added by Dipali Vekhande on 21st jan 2020 for after focus to controll,div should be open 
                        $('#cboFeature').focus();

                        return;
                    }
                }
                if (projectDetails[0].EstimationTypeMandatoryInAT) {
                    if ($('#cboEstimationType').val() == "" || $('#cboEstimationType').val() == "0" || $('#cboEstimationType').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_EstimationType") %>', "alert-danger");
                        $("#taskmapping").addClass('in');//added by Dipali Vekhande on 21st jan 2020 for after focus to controll,div should be open 
                        $('#cboEstimationType').focus();

                        return;
                    }
                }
               <%-- if (isAgileMethodused == 1)
                {

                    if ($("#txtStoryPoint").val() == "") {
                        showAlert('<%= MyBase.GetResourceString("C_Please_StoryPoint") %>', "alert-danger");
                        $("#taskmapping").addClass('in');//added by Dipali Vekhande on 21st jan 2020 for after focus to controll,div should be open 
                        $('#txtStoryPoint').focus();
                        //$('#lbstorypoints').addClass("required");
                       
                        return;

                    }

                }--%>
            }
            Save_OnClick();

            //return false;
            if (flag) {
                //debugger;
                $("#btnTaskSave").prop("disabled", true);//Added by Dipali V On 12th June 2020 For restict double click
                $("#btnTaskSave").hide();

                //Added by imran on 14-09-2022
                if ($("#cboChangeRequest").val() == "") {
                    var ChangeRequestID = 0;
                }

                if ($("#cboDeliverable").val() == "") {
                    var DeliverableID = 0;
                }

                if ($("#cboMilestone").val() == "") {
                    var MileStoneId = 0;
                }

                if ($("#cboModule").val() == "") {
                    var ModuleId = 0;
                }

                if ($("#cboPhase").val() == "") {
                    var PhaseID = 0;
                }

                if ($("#cboSubProject").val() == "") {
                    var SubProjectID = 0;
                }

                if ($("#cboUserStory").val() == "") {
                    var UserStoryID = 0;
                }

                if ($("#cboEstimationType").val() == "") {
                    var ProjectEstimationTypeID = 0;
                }

                if ($("#cboFeature").val() == "") {
                    var ProjectFeatureID = 0;
                }

                if ($("#txtStoryPoint").val() == "") {
                    var StoryPoints = 0;
                }

                if (DeliverableStageID == null || DeliverableStageID == "") {
                    var DeliverableStageID = 0;
                }
                //End of comment by imran on 14-09-2022

                var PM_wbs_cardParameter = {
                    ParentTaskID: ParentTaskID,
                    EmployeeID: $("#cboResource :selected").val(),
                    TaskID: hiddenTaskID,
                    ProjectID: $("#CboProject :selected").val(),
                    TaskName: $("#txtTaskName").val(),
                    StartDate: Trim(replaceAllChar($("#txtStartDate").val())),
                    EndDate: Trim(replaceAllChar($("#txtEndDate").val())),
                    WorkInHours: Trim(replaceAllChar($("#txtWorks").val())),
                    WhichTask: WhichTask, //WhichTask
                    IsTaskBillable: $("#chkBillable").is(':checked') == true ? 1 : 0,
                    TaskNotes: Trim(replaceAllChar($("#txtTaskNotes").val())),
                    TaskTypeName: ($("#cboTaskType").prop('selectedIndex') > 0 ? $("#cboTaskType :selected").text() : ""),
                    Priority: Trim(replaceAllChar($("#cboPriority").val())),
                    //PhaseID: Trim(replaceAllChar($("#cboPhase").val())),
                    PhaseID: PhaseID,
                    Phase: Trim(replaceAllChar($("#cboPhase").prop('selectedIndex') > 0 ? $("#cboPhase :selected").text() : "")),
                    //ModuleId: Trim(replaceAllChar($("#cboModule").val())),
                    ModuleId: ModuleId,
                    Module: Trim(replaceAllChar($("#cboModule").prop('selectedIndex') > 0 ? $("#cboModule :selected").text() : "")),
                    //SubProjectID: Trim(replaceAllChar($("#cboSubProject").val())),
                    SubProjectID: SubProjectID,
                    SubProject: Trim(replaceAllChar($("#cboSubProject").prop('selectedIndex') > 0 ? $("#cboSubProject :selected").text() : "")),
                    //MileStoneId: Trim(replaceAllChar($("#cboMilestone").val())),
                    MileStoneId: MileStoneId,
                    MileStone: Trim(replaceAllChar($("#cboMilestone").prop('selectedIndex') > 0 ? $("#cboMilestone :selected").text() : "")),
                    OtherTaskID: OtherTaskID, //OtherTaskID
                    //ChangeRequestID: Trim(replaceAllChar($("#cboChangeRequest").val())),
                    ChangeRequestID: ChangeRequestID,
                    //ProjectFeatureID: Trim(replaceAllChar($("#cboFeature").val())),
                    ProjectFeatureID: ProjectFeatureID,
                    //ProjectEstimationTypeID: Trim(replaceAllChar($("#cboEstimationType").val())),
                    ProjectEstimationTypeID: ProjectEstimationTypeID,
                    //DeliverableID: Trim(replaceAllChar($("#cboDeliverable").val())),
                    DeliverableID: DeliverableID,
                    MitigationPlanID: MitigationPlanID, //MitigationPlanID
                    TrainingResourceID: TrainingResourceID, //TrainingResourceID
                    TrainingID: TrainingID, //TrainingID
                    Void: Void, //Void
                    OnHold: $("#chkOnHold").is(':checked') == true ? 1 : 0,
                    CreatedBy: '<%= Session("strUserName") %>',
                    ModifiedBy: '<%= Session("strUserName") %>',
                    IsUserStoryTask: isAgileMethodused,
                    //UserStoryID: Trim(replaceAllChar($("#cboUserStory").val())),
                    UserStoryID: UserStoryID,
                    //StoryPoints: Trim(replaceAllChar($("#txtStoryPoint").val())),
                    StoryPoints: StoryPoints,
                    DeliverableStageID: DeliverableStageID //DeliverableStageID
                    //$("#txtSprint").val())),
                }
                $.ajax({
                    url: strUrl + '/api/PM_wbs_card/SaveProjectAsignTask',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(PM_wbs_cardParameter),       // Parameters
                    dataType: "json",                                   //Return Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PM_wbs_cardParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PM_wbs_cardParameter) ? PM_wbs_cardParameter : JSON.stringify(PM_wbs_cardParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        //debugger;
                        if (result > 0) {
                            if (hiddenTaskID == "0") {
                                //Added & Commented By Dipali v On 21st Jan 2020 For Alert Should display
                               // showAlert('<%= MyBase.GetResourceString("C_Task_SaveSuccessfully") %>', "alert-success");
                                setTimeout(function () {
                                    showAlert('<%= MyBase.GetResourceString("C_Task_SaveSuccessfully") %>', "alert-success");
                                }, 2000);
                            } else {
                                //Added & Commented By Dipali v On 21st Jan 2020 For Alert Should display
                                setTimeout(function () {
                                    showAlert('<%= MyBase.GetResourceString("C_Task_UpdateSuccessfully") %>', "alert-success");
                                }, 2000);
                            }
                            //Added By Dipali V On 22nd Jan 2020 For Clear Flag
                            Isaction = 0;
                            isFlag = 0;
                            //End of Added By Dipali V On 22nd Jan 2020 For Clear Flag
                            $("#taskeditor").modal("hide");
                            $("#btnTaskSave").show();
                            CboProject_OnChange();
                            //Added By Dipali V On 10th Feb 2020 Filter Should be Remain same even after Add new Task
                            var IsActive, WhichTask;
                            var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
                            var getClassName = $('#tabWhizibleTasks').attr('class');
                            if (getClassName == "tab-slider--trigger active") {
                                WhichTask = "";
                            }
                            else {
                                WhichTask = "M";
                            }
                            if (ActiveTab == "tabActive") {
                                IsActive = 1;
                            }
                            else if (ActiveTab == "tabAll") {
                                IsActive = 0;
                            }
                            var employeeid = $("#cboEmployeeIDFilter").val();
                            var tasktypeid = $("#cboTaskTypeFilter").val();
                            var startdate = $("#txtStartDateFilter").val();
                            var enddate = $("#txtEndDateFilter").val();
                            $(".draggablemenu").html('');


                            GetProjectTasks(IsActive, WhichTask, '<%=m_roleLevel%>', employeeid, tasktypeid, startdate, enddate);
                            GetDefaultStages($("#CboProject").val(), IsActive, WhichTask);

                            clearTooltip();
                            //End of Added By Dipali V On 10th Feb 2020 Filter Should be Remain same even after Add new Task
                        }
                        else {
                            showAlert('<%= MyBase.GetResourceString("C_Task_UpdateFailed") %>', "alert-danger");
                        }
                    },
                    error: function (xhr, status, error) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                    }
                });
            }
        });

        var isFlag = 0;
        var Flag = 0;
        function Action(Flag) {
            //debugger;
            isFlag = Flag;
            $("#ul_" + selectedDivID).css("display", "");
            $("#ul_" + selectedDivID).css("display", "block");
            return isFlag;


        }


        /*end added by harshk on 22/08/2005 for sp4 IssueID 120,121 */
        function ValidateControls() {
            //
            var intCompanyHrsPerDay, intCompanyWeekDays, intHolidays, intCount, intCnt, intDays;
            var strMsg, bitHoliday, dtCurrentStartDate, dtCurrentEndDate, dtCurrentDate, dtHoliday;
            var dblAvgHoursPerDay, intResourceCount, dblTotalWork, dblTotalDuration, strHolidayList;
            var objTaskName, objTaskNotes, objEmployee, objCurrentWork, objCurrentStartDate, objCurrentEndDate;
            var objPriority, objPhaseId, objPhase, objModuleId, objModule, objSubProjectId;
            var objSubProject, objMilestoneId, objMilestone, objProjectEstimationTypeId;
            var dblLCEHrs, dtmActStartDate, CWork;
            var dtProjectStartDate, dtProjectEndDate;
            dblLCEHrs = document.getElementById('txtWorks');
            if ((dblLCEHrs == null) || (dblLCEHrs == ""))
                dblLCEHrs = "0";


            objTaskName = document.getElementById('txtTaskName');

            objTaskNotes = document.getElementById('txtTaskNotes');
            //if (disallowMaxlengthViolation(objTaskNotes, 2000, "<=MyBase.GetResourceString(MAXLENGTH_OF_TASKNOTES)%>", true))
            //    return false;

            objEmployee = document.getElementById('cboResource');
            objCurrentWork = document.getElementById('txtWorks');
            var objcurworkval = objCurrentWork.value;
            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
            objtxthidCurrentWork = document.getElementById('txthdnCurrentWork');

            //Added by Usha Pandit on 01-Apr-2019 Purpose::Whizible 2 Work field change
            if (objtxthidCurrentWork != null && objtxthidCurrentWork != undefined)
                objtxthidCurrentWork.value = objCurrentWork.value;
            //End of Added by Usha Pandit on 01-Apr-2019 Purpose::Whizible 2 Work field change

            //Commented By Dipali V On 25th Jan 2020 For javascript Alert 
            //if (disallowBlank(objCurrentWork, "'Work (H:M)' should not be left blank.", true)) {
            //    //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
            //    objCurrentWork.value = objCurrentWork.value.split('.').join(':');

            //    objCurrentWork.value = objcurworkval
            //    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

            //    return false;
            //}
            //
            //End of Commented By Dipali V On 25th Jan 2020 For javascript Alert 

            if (objCurrentWork.value.indexOf(".") != -1) {
                objCurrentWork.value = objcurworkval;
                showAlert("Please enter Work (hrs) in H:M format.", 'alert-danger');
                setFocus(objCurrentWork);
                return false;
            }


            objCurrentWork.value = objCurrentWork.value.replace(":", ".");
            var isdigit = isNumeric(objCurrentWork.value);
            objCurrentWork.value = objcurworkval;
            if (isdigit == false) {
                showAlert("Please Enter only positive numeric value For Work (hrs) in H:M format.", 'alert-danger');
                setFocus(objCurrentWork);
                return false;
            }



            if (objCurrentWork.value.indexOf(":") != -1) {
                //
                objCurrentWork.value = objCurrentWork.value.replace(":", ".");
            }
            var blnResult = disallowNonNumeric(objCurrentWork, "Please enter Work (hrs) in H:M format.");

            if (blnResult == true) {
                objCurrentWork.value = objcurworkval;
                setFocus(objCurrentWork);
                return false;
            }

            var minutePart = objcurworkval.split(":")[1];
            objCurrentWork.value = objCurrentWork.value.replace(/:/g, ".");

            var precision = '';
            if (objCurrentWork.value.indexOf(".") != -1) {
                precision = objCurrentWork.value.split(".")[1];
            }

            if (precision.length > 2) {
                objCurrentWork.value = objcurworkval;
                showAlert("Please enter minutes in two decimal and less than 60.", 'alert-danger');
                setFocus(objCurrentWork);
                return false;
            }

            if (precision != "" && precision != undefined) {
                if (precision > 59 || precision < 0) {
                    showAlert('Please enter minutes between (0-59) range.', 'alert-danger');
                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    setFocus(objCurrentWork);
                    return false;
                }
            }

            //End of Added by Usha Pandit on 16.04.2019 for Work field alert issue for minutes length

            if (precision == 60) {
                objCurrentWork.value = (objCurrentWork.value.split(".")[0] - 0) + 1;
            }
            var pattern = /^\d+(\.\d{1,2})?$/;
            if (pattern.test(objCurrentWork.value)) {
            }
            else {
                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            }

            //if (disallowMinValueViolation(objCurrentWork, 0.00001, '<=MyBase.GetResourceString("PROPER_WORK_HRS")%>', true)) {
            //    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //    objCurrentWork.value = objcurworkval
            //    return false;
            //}

            if (objEmployee != null) {
                var counter;
                counter = 0;

                for (var i = 0; i < objEmployee.length; i++) {
                    if (objEmployee[i].selected)
                        counter++;
                }
                var str = "<%=CommonFunctions.Application.DistributeWorkInAT%>"
                if (str == "True")
                    dblLCEHrs = parseFloat(objCurrentWork.value) / counter;
                else
                    dblLCEHrs = parseFloat(objCurrentWork.value) * counter;

            }
            else
                dblLCEHrs = parseFloat(objCurrentWork.value);

            var objTotalAllocatedTaskLCE;
            CWork = parseFloat(objCurrentWork.value)
            objTotalAllocatedTaskLCE = parseFloat(TotalAllocatedTaskLCE);
            // debugger
            //added By Dipali v On 23rd Jan 2020 For Work Hours Valide with Project Work Hous
            //Added by Chetan M on 3rd Feb 2020 for IssueID = 21615
            var dblBalancedHrs = TotalLCE - objTotalAllocatedTaskLCE
            //dblBalancedHrs = dblBalancedHrs.toString().replace("-", "");
            // if (dblBalancedHrs.toString().indexOf("-") != -1) {
            //  dblBalancedHrs = dblBalancedHrs + parseFloat(GlobalWorkHours);
            // } else {
            var TaskWorkHours = parseFloat(GlobalWorkHours);
            dblBalancedHrs = parseFloat(dblBalancedHrs) + parseFloat(TaskWorkHours);
            //}
            //End of Added by Chetan M on 3rd Feb 2020 for IssueID = 21615
            //debugger;
            if (hiddenTaskID != "0") { //In Edit Mode
                //Commented and Added by Chetan M on 3rd Feb 2020 for IssueID = 21615
                //if (CWork > parseFloat(TotalLCE)) {
                if (CWork > parseFloat(dblBalancedHrs)) {
                    //var dblBalancedHrs = TotalLCE - CWork
                    //dblBalancedHrs = dblBalancedHrs.toString().replace("-", "");
                    //End of Commented and Added by Chetan M on 3rd Feb 2020 for IssueID = 21615           
                    showAlert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are " + dblBalancedHrs, 'alert-danger');

                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    $("#txtWorks").focus();//Added by Dipali V On 23rd Jan 2020 For Focus to control
                    return false;
                }


                if (dblLCEHrs > parseFloat(TotalLCE)) {
                    var dblBalancedHrs;
                    dblBalancedHrs = TotalLCE - dblLCEHrs;
                    //dblBalancedHrs = dblBalancedHrs.toString().replace("-", "");
                    showAlert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are " + dblBalancedHrs, 'alert-danger');

                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    $("#txtWorks").focus();//Added by Dipali V On 23rd Jan 2020 For Focus to control
                    return false;
                }
                //End of added By Dipali v On 23rd Jan 2020 For Work Hours Valide with Project Work Hous
            }
            else {
                //In edit Mode
                //debugger;
                //added By Dipali v On 23rd Jan 2020 For Work Hours Valide with Project Work Hous
                if (CWork + objTotalAllocatedTaskLCE > parseFloat(TotalLCE)) {
                    var dblBalancedHrs = TotalLCE - objTotalAllocatedTaskLCE
                    //dblBalancedHrs = dblBalancedHrs.toString().replace("-", "");
                    showAlert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are " + dblBalancedHrs, 'alert-danger');

                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    $("#txtWorks").focus();//Added by Dipali V On 23rd Jan 2020 For Focus to control
                    return false;
                }

                //Check whether the Total work hours assigned to the Tasks are more then the work hours for Project
                if (dblLCEHrs + parseFloat(TotalAllocatedTaskLCE) > parseFloat(TotalLCE)) {
                    var dblBalancedHrs;
                    dblBalancedHrs = TotalLCE - TotalAllocatedTaskLCE;
                    dblBalancedHrs = dblBalancedHrs.toString().replace("-", "");
                    showAlert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are " + dblBalancedHrs, 'alert-danger');

                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    $("#txtWorks").focus();//Added by Dipali V On 23rd Jan 2020 For Focus to control
                    return false;
                }
                //End of added By Dipali v On 23rd Jan 2020 For Work Hours Valide with Project Work Hous
            }
            objCurrentStartDate = document.getElementById('txtStartDate');
            dtCurrentStartDate = getDate(objCurrentStartDate.value.replace(" ", "-").replace(" ", "-"));

            objCurrentEndDate = document.getElementById('txtEndDate');
            dtCurrentEndDate = getDate(objCurrentEndDate.value.replace(" ", "-").replace(" ", "-"));


            var dtProjectStartDate = getDate(ProjectStartDate);
            var dtProjectEndDate = getDate(ProjectEndDate);
            if ((dtProjectStartDate != null) && (dtProjectEndDate != null) && (dtCurrentStartDate != null) && (dtCurrentEndDate != null)) {
                if ((dtCurrentStartDate < dtProjectStartDate) || (dtCurrentEndDate > dtProjectEndDate)) {
                    showAlert("Start date and end date of the task should be between project start date " + ProjectStartDate + " and end date " + ProjectEndDate, 'alert-danger');
                    //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    return false;
                }
            }
            //addedby harshk on 22/08/2005 for sp4 IssueID 120,121 */

            if (intResourceValidation == 1) {
                if (ValidateResourceDate(dtCurrentStartDate, dtCurrentEndDate) == false) {
                    //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    return false;
                }
            }
            //end addition harshk on 22/08/2005 for sp4 IssueID 120,121 
            //Only Used in Edit Mode
            if (hiddenTaskID != "0") {
                //if ("<=m_blnHasResources%>" != "False")
                if (true) {
                    if (document.getElementById('txtWorks') != "") {
                        ////if (disallowMinValueViolation(objCurrentWork, parseFloat(document.getElementById('txtWorks').value)) == true) 
                        //{
                        //    
                        //    if (confirm("Changing work hours can cause incorrect scheduling of tasks already assigned to resources. Do yo want to continue? ") == false) {
                        //        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                        //        objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                        //        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                        //        return false;
                        //    }
                        //}
                    }


                    dtTempDate = getDate(PreviousStartDate.replace(" ", "-").replace(" ", "-"));
                    if (PreviousStartDate != "") {
                        if (DateDiff(dtCurrentStartDate, dtTempDate, "d") != 0) {
                            //Added by Dipali V On 22nd Jan 2020 For Confirmation alert Should be modal pop up
                            //if (confirm("Changing start date can cause incorrect scheduling of tasks already assigned to resources. Do yo want to continue?") == false) {
                            var Isaction = Action(isFlag);
                            if (Isaction != 1) {
                                $("#ConfirmationAlert").modal('show');
                                $("#spnConfirmationAlert").text('');
                                $("#spnConfirmationAlert").text('Changing start date can cause incorrect scheduling of tasks already assigned to resources. Do yo want to continue?');
                            }

                            //if (confirm("Changing end date can cause incorrect scheduling of tasks already assigned to resources. Do yo want to continue?") == false) {
                            if (Isaction != 1) {
                                //End of Added by Dipali V On 22nd Jan 2020 For Confirmation alert Should be modal pop up
                                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                                Isaction = 0;
                                //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                                return false;
                            } else {
                                Isaction = 0;

                            }
                        }
                    }
                    dtTempDate = getDate(PreviousEndDate.replace(" ", "-").replace(" ", "-"));
                    if (PreviousEndDate != "") {
                        if (DateDiff(dtCurrentEndDate, dtTempDate, "d") != 0) {
                            //Added by Dipali V On 22nd Jan 2020 For Confirmation alert Should be modal pop up
                            var Isaction = Action(isFlag);
                            if (Isaction != 1) {
                                $("#ConfirmationAlert").modal('show');
                                $("#spnConfirmationAlert").text('');
                                $("#spnConfirmationAlert").text('Changing end date can cause incorrect scheduling of tasks already assigned to resources. Do yo want to continue?');
                            }

                            //if (confirm("Changing end date can cause incorrect scheduling of tasks already assigned to resources. Do yo want to continue?") == false) {
                            if (Isaction != 1) {
                                //End of Added by Dipali V On 22nd Jan 2020 For Confirmation alert Should be modal pop up
                                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                                Isaction = 0;
                                return false;
                            }
                            else {
                                Isaction = 0;

                            }
                        }
                    }
                }
            }

            objPriority = document.getElementById('cboPriority');


            var intCounter;
            var strEmployeeList;
            strEmployeeList = $("#cboResource").val();
            var EmpName = $("#cboResource :selected").text();
            //debugger;
            var LeaveMssage = GetLeaveDetails(hiddenTaskID, 'normal', document.getElementById('txtStartDate').value, document.getElementById('txtEndDate').value, strEmployeeList);
            if (LeaveMssage != "") {
                var Isaction = Action(isFlag);
                if (Isaction != 1) {

                    //Added By Usha Pandit On 18.12.2020 For getting work hours in HH:MM format
                    objCurrentWork.value = objCurrentWork.value.replace(".", ":");
                    //End Of Added By Usha Pandit On 08.12.2020 For getting work hours in HH:MM format

                    $("#ConfirmationAlert").modal('show');
                    $("#spnConfirmationAlert").text('');
                    $("#spnConfirmationAlert").text(LeaveMssage);
                }
                if (Isaction != 1) {
                    Isaction = 0;
                    return false;
                }
                else {
                    Isaction = 0;

                }
            }

            //debugger;
            intCompanyHrsPerDay = HoursPerDay;
            intCompanyWeekDays = WeekDays;
            bitHoliday = false;
            intHolidays = 0;
            //Added by Dipali V On 10th Feb 2020 For Holiday alert
            var strHolidays = GetholidayDetails(document.getElementById('CboProject').value);
            if (strHolidays != "") {
                strMsg = "The dates\n";
                strHolidayList = strHolidays.split(',');
                for (intCount = 0; intCount < strHolidayList.length - 1; intCount++) {
                    intDays = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d");
                    for (intCnt = 0; intCnt <= intDays; intCnt++) {
                        dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
                        // If the holiday does not fall in the week end, then...
                        if (DatePart("w", dtCurrentDate, 2) <= intCompanyWeekDays)		//Need to do
                        {
                            dtHoliday = getDate(strHolidayList[intCount]);
                            //if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()))

                            //Integrated by MrugajaB on 30th APr 2005 for PMLifeLine SP3
                            /*Added Year Checking by Prajakta on 8th Feb 2005 (Issue ID 7090 of Jopasna Hot Fix 4.0.107-BF-UR)*/
                            if ((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()) && (dtCurrentDate.getYear() == dtHoliday.getYear()))
						//if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()))
						/*End of Addition Year Checking by Prajakta on 8th Feb 2005 (Issue ID 7090 of Jopasna Hot Fix 4.0.107-BF-UR)*/ {
                                bitHoliday = true;
                                //Need the month string
                                strMsg = strMsg + dtHoliday.getDate() + "-" + MonthName(dtHoliday.getMonth().toString());
                                //Commented And Added By Chakshuta H on 19th-Nov-2015
                                //strMsg = strMsg + "-" + dtCurrentDate.getYear() + "\n";
                                strMsg = strMsg + "-" + dtCurrentDate.getFullYear() + "\n";
                                //End Of Commented And Added By Chakshuta H on 19th-Nov-2015
                                intHolidays = intHolidays + 1;
                            }
                        }
                    }
                }
            }

            //End of Added by Dipali V On 10th Feb 2020 For Holiday alert
            //Added by Dipali V On 10th Feb 2020 For Holiday alert
            if (bitHoliday == true)//Remove Comments after added the function DatePart
            {
                var Isaction = Action(isFlag);
                if (Isaction != 1) {
                    //Added By Usha Pandit On 08.12.2020 For getting work hours in HH:MM format
                    objCurrentWork.value = objCurrentWork.value.replace(".", ":");
                    //End Of Added By Usha Pandit On 08.12.2020 For getting work hours in HH:MM format
                    $("#ConfirmationAlert").modal('show');
                    $("#spnConfirmationAlert").text('');
                    $("#spnConfirmationAlert").text(strMsg + "falling between the start date and end date for this task are holidays.\nDo you want to maintain the start and end date.\n Yes = Save the selected dates.\nCancel = Go back to the previous screen without saving.");
                    //setFocus(objCurrentStartDate);
                }
                if (Isaction != 1) {
                    Isaction = 0;
                    return false;
                }
                else {
                    Isaction = 0;

                }
            }
            //End of Added by Dipali V On 10th Feb 2020 For Holiday alert

            //Added by Dipali V On 22nd Jan 2020 For Leaves & Holidays Validations
            dblTotalDuration = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d") + 1;
            var strStartingDay ="<%=m_strStartingDayOfWeek%>";
            for (intCnt = 0; intCnt <= DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d"); intCnt++) {
                dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
                //Modified by SiddharthS on 17 Feb 2005 for Issue Id 16002
                //Purpose:To give alert for weekend based on Staring day of week set at carporate level. 
                switch (strStartingDay) {
                    case "1":
                        if (DatePart("w", dtCurrentDate, 2) > intCompanyWeekDays)		// Need to do
                            intHolidays = intHolidays + 1;
                        break
                    case "2":
                        if (DatePart("w", dtCurrentDate, 3) > intCompanyWeekDays)
                            intHolidays = intHolidays + 1;
                        break
                    case "3":
                        if (DatePart("w", dtCurrentDate, 4) > intCompanyWeekDays)
                            intHolidays = intHolidays + 1;
                        break
                    case "4":
                        if (DatePart("w", dtCurrentDate, 5) > intCompanyWeekDays)
                            intHolidays = intHolidays + 1;
                        break
                    case "5":
                        if (DatePart("w", dtCurrentDate, 6) > intCompanyWeekDays)
                            intHolidays = intHolidays + 1;
                        break
                    case "6":
                        if (DatePart("w", dtCurrentDate, 7) > intCompanyWeekDays)
                            intHolidays = intHolidays + 1;
                        break
                    case "7":
                        if (DatePart("w", dtCurrentDate, 1) > intCompanyWeekDays)
                            intHolidays = intHolidays + 1;
                        break
                }
                //End modification.
            }



            //End of Added by Dipali V On 22nd Jan 2020 For Leaves & Holidays Validations

            if (objcurworkval.indexOf(".") != -1) {
                showAlert("Please enter Work (hrs) in H:M format.", 'alert-danger');
                setFocus(objCurrentWork);
                return false;
            }



            //debugger;
            dblAvgHoursPerDay = 0;
            if (hiddenTaskID == "0" && ApplyEffortDistribution == false && HaveSubTaskTypes == false && "<%=CommonFunctions.Application.DistributeWorkInAT%>" == "True" && "<%= CommonFunctions.Application.DistributeWorkInAT %>" == "False")
                dblLCEHrs = parseFloat(objCurrentWork.value) / counter;
            else
                dblLCEHrs = parseFloat(objCurrentWork.value);

            dblTotalWork = dblLCEHrs;

            var MinDAENtryDisplay = "";
            var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry %>";
            if (MinDAEntry == 0.25) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:15"
            }
            else if (MinDAEntry == 0.50) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:30"
            }
            else if (MinDAEntry == 0.75) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:45"
            }

            dblTotalWork = objCurrentWork.value;

            if (hdnRestrictByMinHours) {
                if (MinDAEntry == 0.016) {
                }
                else {
                    var minutes = dblTotalWork.toString().split('.');
                    var p = minutes[0];
                    var dec = minutes[1];

                    if (dec != undefined) { //Added By Usha Pandit On 28.08.2020 For multiple of min alert
                        //Added By Usha Pandit On 28.08.2020 For multiple of min alert
                        if (dec.length > 2) {
                            dec = dec.substring(0, 2);
                        }
                        if (dec.length == 1) {
                            dec = dec + "0";
                        }
                        //End Of Added By Usha Pandit On 28.08.2020 For multiple of min alert
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);

                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            showAlert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min", 'alert-danger');
                            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                            return false;
                        }
                    }
                }
            }

            objCurrentWork.value = objCurrentWork.value.split('.').join(':');

            if (objCurrentWork.value.indexOf(':') == -1) {
                objCurrentWork.value = objCurrentWork.value + ":00";
            }

            dblTotalDuration = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d") + 1;
            if (dblTotalDuration - intHolidays != 0) {
                if (str == "True") {
                    if (hiddenTaskID != "0")
                        dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                    else {
                        dblAvgHoursPerDay = dblTotalWork / counter;
                        dblAvgHoursPerDay = dblAvgHoursPerDay / dblTotalDuration;
                    }
                }
                else {
                    dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                }
            }
            else {
                // debugger;
                // if (!confirm("All the days in the specified date range are holidays/weekends. Do you wish to continue?")) {
                //Added by Dipali V On 22nd Jan 2020 For Leaves & Holidays Validations
                var Isaction = Action(isFlag);
                if (Isaction != 1) {
                    $("#ConfirmationAlert").modal('show');
                    $("#spnConfirmationAlert").text('');
                    $("#spnConfirmationAlert").text('<%=MyBase.GetResourceString("DAYS_ARE_HOLIDAYS")%>');
                }

                if (Isaction != 1) {
                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    Isaction = 0;
                    return false;
                    //End of Added by Dipali V On 22nd Jan 2020 For Leaves & Holidays Validations
                } else {
                    Isaction = 0;
                    dblTotalDuration = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d") + 1;
                    if (str == "True") {
                        if (hiddenTaskID != "0")
                            dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                        else {
                            dblAvgHoursPerDay = dblTotalWork / counter;
                            dblAvgHoursPerDay = dblAvgHoursPerDay / dblTotalDuration;
                        }
                    }
                    else {
                        dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                    }

                }
            }


            if (isAgileMethodused == 1) {


            }
            //debugger;
            if (objEmployee != null) {
                if (objEmployee.value != "") {
                    if (dblAvgHoursPerDay > 24) {
                        showAlert("You cannot assign more than 24 hours work per day", 'alert-danger');
                        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                        objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

                        setFocus(objCurrentWork);
                        return false;
                    }
                    //else
                    if (dblAvgHoursPerDay > intCompanyHrsPerDay) {
                        var strMsg = "You are assigning " + dblAvgHoursPerDay.toFixed(2).toString() + " hours work per day. \n(OU working hours per day are " + intCompanyHrsPerDay.toString() + " hours.) \nDo you wish to continue?";
                        //Added & Commented By Dipali V On 22nd Jan 2020 For Remove Old pop up
                        //if (confirm("Changing start date can cause incorrect scheduling of tasks already assigned to resources. Do yo want to continue?") == false) {
                        var Isaction = Action(isFlag);
                        if (Isaction != 1) {
                            $("#ConfirmationAlert").modal('show');
                            $("#spnConfirmationAlert").text('');
                            $("#spnConfirmationAlert").text(strMsg);
                        }

                        //if (confirm("Changing end date can cause incorrect scheduling of tasks already assigned to resources. Do yo want to continue?") == false) {
                        if (Isaction != 1) {
                            //End of Added & Commented By Dipali V On 22nd Jan 2020 For Remove Old pop up
                            // if (!confirm(strMsg)) {
                            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                            setFocus(objCurrentWork);
                            Isaction = 0;
                            return false;
                        } else {

                            Isaction = 0;
                        }
                    }
                }
                ////objEmployee.disabled = false;
            }

            objPhaseId = document.getElementById('cboPhase');
            if (objPhaseId != null) {
                objPhase = document.getElementById('txthdnPhase');
                if (objPhaseId.selectedIndex != -1) {
                    //Modified By VidyaJ - Browser Issue - IssueID - 809 
                    //Modified by RajashriK for netsape implementation on 18.3.2005
                    if (navigator.appName == 'Netscape')
                        objPhase.value = objPhaseId.options[objPhaseId.selectedIndex].innerHTML;
                    else
                        objPhase.value = objPhaseId.options(objPhaseId.selectedIndex).innerText;
                    //End Of Code modification By RajashriK
                    //End Of Code modification By VidyaJ - Browser Issue - IssueID - 809 
                }
                else
                    objPhase.value = "";
            }

            //Modified By AmrutaJ For DSS IssueId 3297
            //Module Name of the Task is not shown in Task Mapping

            objModuleId = document.getElementById('cboModule');
            if (objModuleId != null) {
                objModule = document.getElementById('txthdnModule');
                if (objModuleId != null) {
                    if (objModuleId.selectedIndex != -1) {
                        if (navigator.appName == 'Netscape')
                            objModule.value = objModuleId.options[objModuleId.selectedIndex].innerHTML;
                        else
                            objModule.value = objModuleId.options(objModuleId.selectedIndex).innerText;
                    }
                }
                //end of addition by harshada d for PMLifeLine on 31 March 2006
                else
                    objModule.value = "";
            }
            //End Of Modifications By AmrutaJ
            objSubProjectId = document.getElementById('cboSubProject');
            if (objSubProjectId != null) {
                objSubProject = document.getElementById('txthdnSubProject');
                if (objSubProjectId.selectedIndex != -1) {
                    if (navigator.appName == 'Netscape')
                        objSubProject.value = objSubProjectId.options[objSubProjectId.selectedIndex].innerHTML;
                    else
                        objSubProject.value = objSubProjectId.options(objSubProjectId.selectedIndex).innerText;

                }
                else
                    objSubProject.value = "";
            }
            objMilestoneId = document.getElementById('cboMilestone');
            if (objMilestoneId != null) {
                objMilestone = document.getElementById('txthdnMilestone');
                if (objMilestoneId.selectedIndex != -1) {
                    if (navigator.appName == 'Netscape')
                        objMilestone.value = objMilestoneId.options[objMilestoneId.selectedIndex].innerHTML;
                    else
                        objMilestone.value = objMilestoneId.options(objMilestoneId.selectedIndex).innerText;
                }
                else
                    objMilestone.value = "";
            }
            objProjectEstimationTypeId = document.getElementById('cboEstimationType');
            if (objProjectEstimationTypeId != null)
                objProjectEstimationTypeId.disabled = false;

            //Added By Aniruddh Gujar on 08-Jun-2018 Purpose::To validate Task Efforts with Sprint
            if (document.getElementById('cboUserStory') != null) {
                var NewTaskID = hiddenTaskID;

                try {
                    if (isAgileMethodused == 1) {
                        //Commented And Added By Usha Pandit On 31.08.2020 For compilation error
                        //var result = AJAXCallWithResult('../../PM/PM_TaskAssignment.aspx/CheckIterationEfforts', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strEfforts: document.getElementById('txtWorks').value, strTaskID: NewTaskID }), false);
                        //if (result != undefined) {
                        //    if (result.d != "") {
                        //        showAlert(result.d, 'alert-danger');
                        //        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                        //        objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                        //        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                        //        return false;
                        //    }
                        //}
                        var result = AJAXCallWithAuthorizeResult('/api/PM_wbs_card/CheckIterationEfforts', JSON.stringify({ UserStoryID: $('#cboUserStory').val(), WorkInHours: $('#txtWorks').val().trim(), TaskID: hiddenTaskID }), false);

                        if (result != undefined) {
                            if (result != "") {
                                showAlert(result, 'alert-danger');
                                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                                //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                                return false;
                            }
                        }
                        //End Of Added By Usha Pandit On 31.08.2020 For compilation error
                        //var result = AJAXCallWithResult('../../PM/PM_TaskAssignment.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strStartDate: dtCurrentStartDate, strEndDate: dtCurrentEndDate }), false);

                        //Commented And Added By Usha Pandit On 31.08.2020 For compilation error
                        //var result = AJAXCallWithResult('../../PM/PM_TaskAssignment.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strStartDate: document.getElementById('txtStartDate').value, strEndDate: document.getElementById('txtEndDate').value }), false);
                        //if (result != undefined) {
                        //    if (result.d != "") {
                        //        var strMsg = String(result.d).split("_");
                        //        if (strMsg.length >= 2) {
                        //            if (strMsg[0] == "1") {
                        //                showAlert(strMsg[1], 'alert-danger');
                        //                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                        //                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                        //                //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                        //                return false;
                        //            }
                        //            else {
                        //                showAlert(strMsg[1], 'alert-danger');
                        //                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                        //                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                        //                //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                        //                return false;
                        //            }
                        //        }
                        //    }
                        //}

                        var result = AJAXCallWithAuthorizeResult('/api/PM_wbs_card/CheckIterationDates', JSON.stringify({ UserStoryID: $('#cboUserStory').val(), StartDate: $('#txtStartDate').val().trim(), EndDate: $('#txtEndDate').val().trim() }), false);
                        if (result != undefined) {
                            if (result != "") {
                                var strMsg = String(result).split("_");
                                if (strMsg.length >= 2) {
                                    if (strMsg[0] == "1") {
                                        showAlert(strMsg[1], 'alert-danger');
                                        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                                        objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                                        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                                        return false;
                                    }
                                    else {
                                        showAlert(strMsg[1], 'alert-danger');
                                        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                                        objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                                        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                                        return false;
                                    }
                                }
                            }
                        }
                        //End Of Added By Usha Pandit On 31.08.2020 For compilation error
                    }
                }
                catch (ex) {
                    //alert(ex);
                }
            }

            return true;
        }
        //Added By Dipali V On 23rd Jan 2020 For Get leave Details
        function GetLeaveDetails(TaskID, Flag, StartDate, EndDate, UserID) {
            //debugger;
            var WBSParameters = {
                TaskID: encodeURI(TaskID),
                StartDate: StartDate,
                strEntityName: Flag,
                EndDate: EndDate,
                UserID: encodeURI(UserID),

            }
            //var url = strUrl + '/api/PM_wbs_card/GetLeaveDetails';


            var param = JSON.stringify(WBSParameters);
            var leavemsg = AJAXCallWithAuthorizeResult("/api/PM_wbs_card/GetLeaveDetails", param, false);
            // debugger;
            return leavemsg;

        }
        //End of Added By Dipali V On 23rd Jan 2020 For Get leave Details



        //Added By Dipali V On 23rd Jan 2020 For Get HOLIDAY Details
        function GetholidayDetails(ProjectID) {
            //debugger;
            var WBSParameters = {
                ProjectID: encodeURI(ProjectID),

            }
            //var url = strUrl + '/api/PM_wbs_card/GetLeaveDetails';


            var param = JSON.stringify(WBSParameters);
            var leavemsg = AJAXCallWithAuthorizeResult("/api/PM_wbs_card/GetHolidayDetails", param, false);
            //debugger;
            return leavemsg;

        }
        //End of Added By Dipali V On 23rd Jan 2020 For Get HOLIDAY Details
        var AjaxResult;
        function AJAXCallWithResult(url, data, async) {
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                //timeout: 180000,
                async: async,
                success: function (result) {
                    AjaxResult = result;
                    //$(".loadingoverlay", parent.document).css("display", "none");
                },
                error: function (xhr, status, error) {
                    //$(".loadingoverlay", parent.document).css("display", "none");
                    console.log(xhr.responseText);
                    //Commented And Added By Usha Pandit On 31.08.2020 For redirecting to correct path
                    //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                    //End Of Added By Usha Pandit On 31.08.2020 For redirecting to correct path
                }
            });

            return AjaxResult;
        }

        var ajaxResult;
        function AJAXCallWithAuthorizeResult(url, param, async) {
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
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    console.log(err);
                }
            });
            return ajaxResult;
        }

        var g_objXHttp;
        function ValidateTask_Baseline(stringUrl) {

            // TO SEE IF WE ARE RUNNING IN IE 
            var strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();
            var browser = WhichBrowser();
            if (strNavigator == 'MICROSOFT INTERNET EXPLORER') {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", stringUrl, false);
                //finally send the call
                g_objXHttp.send();
            }

            else if (browser == 'IE') {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", stringUrl, false);
                //finally send the call
                g_objXHttp.send();
            }

            else {
                // Mozilla - based browser , Netscape
                g_objXHttp = new XMLHttpRequest();
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", stringUrl, false);
                //finally send the call
                g_objXHttp.send(null);

                if (g_objXHttp.responseText != null) {
                    xmlDoc = document.implementation.createDocument("", "", null);
                    xmlDoc.async = false;
                    strResult = g_objXHttp.responseText;
                }

            }
            return strResult;
        }

        function TaskValidation_state_change() {

            var browser = WhichBrowser();  // Added By Vaijat K on 20/11/2015
            if (g_objXHttp.readyState == 4) {
                // Make sure request came back OK 
                if (g_objXHttp.status == 200) {
                    if (window.ActiveXObject || "ActiveXObject" in window) {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async = false;
                        xmlDoc.loadXML(g_objXHttp.responseText);

                    }
                    // code for Mozilla, etc.
                    else if (document.implementation && document.implementation.createDocument) {
                        xmlDoc = document.implementation.createDocument("", "", null);
                        xmlDoc.async = false;
                    }
                    strResult = g_objXHttp.responseText;

                }

            }


        }

        function WhichBrowser() {

            var brwser = '';
            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                //return 'IE '+(tem[1] || '');
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
            //return M.join(' ');
            return brwser;
        }

        function ValidateResourceDate(objSDt, objEDt) {

            var dtResourceStartDate, dtResourceEndDate
            var intIndex = 0;
            var strMsg;
            var EmpName = $("#cboResource :selected").text();
            var resourceData = getResourceData($("#cboResource :selected").val());
            if (resourceData != '') {
                ResourceStartDate = resourceData.ResourcesExpectedDates.ExpectedStartDate;
                ResourceEndDate = resourceData.ResourcesExpectedDates.ExpectedEndDate;
            } else {
                ResourceStartDate = '';
                ResourceEndDate = '';
            }

            var dtResourceStartDate = getDate(ResourceStartDate.replace(" ", "-").replace(" ", "-"));
            var dtResourceEndDate = getDate(ResourceEndDate.replace(" ", "-").replace(" ", "-"));
            if (DateDiff(objSDt, dtResourceStartDate, "d") > 0) {
                strMsg = 'Start Date should be between Resource (<=>)  Start Date (<==> )  and End Date (<===>) on Project';
                strMsg = replaceSubstring(strMsg, '<=>', EmpName);
                strMsg = replaceSubstring(strMsg, '<==>', ResourceStartDate);
                strMsg = replaceSubstring(strMsg, '<===>', ResourceEndDate);
                //Added By Dipali V On 10th Aug 2020 For Resc Alert n IE to close early
                setTimeout(function () {
                    showAlert(strMsg, 'alert-danger');
                }, 350);
                //End of Added By Dipali V On 10th Aug 2020 For Resc Alert n IE to close early

                return false;
            }
            if (DateDiff(dtResourceEndDate, objEDt, "d") > 0) {
                strMsg = 'End Date should be between Resource (<=>)  Start Date (<==> )  and End Date (<===>) on Project';
                strMsg = replaceSubstring(strMsg, '<=>', EmpName);
                strMsg = replaceSubstring(strMsg, '<==>', ResourceStartDate);
                strMsg = replaceSubstring(strMsg, '<===>', ResourceEndDate);
                //showAlert(strMsg, 'alert-danger');
                //Added By Dipali V On 10th Aug 2020 For Resc Alert n IE to close early
                setTimeout(function () {
                    showAlert(strMsg, 'alert-danger');
                }, 350);
                //End of Added By Dipali V On 10th Aug 2020 For Resc Alert n IE to close early
                return false;
            }
            return true;
        }

        //custum field code start
        function getCustomFieldsMaxRowColCount() {

            var ret = false;
            //var ProjectID = parseInt(projectId);
            var StrEntityName = "Task";
            var LoginType = '<%= Session("strUserName") %>';
            var WBSParameters = {
                ProjectID: encodeURI($("#CboProject").val()),
                Type: encodeURI(9),
                strEntityName: encodeURI(StrEntityName),
                IsActive: encodeURI(1),
                UserID: encodeURI(UserID),
                LoginType: encodeURI(LoginType)
            }
            var param = JSON.stringify(WBSParameters);

            var result = AJAXCallWithAuthorizeResult("/api/PM_wbs_card/GetCustomFieldMasterRowNumber", param, false);

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
                    strtablebind += "<div class='col-md-4'" + "id=" + "custr" + i + "c" + j + "> </div>";
                }
                strtablebind += "</div>";
            }
            $("#divCustomFields").html(strtablebind);
        }



        var ValidationFieldsName = new Array();
        var ValidationFieldID = new Array();
        var ValidationRules = new Array();
        var CustomFieldsNames = new Array();
        ////this function used for ploating custom fields like  Department,Date etc
        function PloatCustomFields() {

            var strHTML = "";
            var StrEntityName = "Task";
            var LoginType = '<%= Session("C_Name_Mandatory_Text")%>';
            var SessionRoleId = '<%= Session("strUserName") %>';
            var WBSParameters = {
                ProjectID: encodeURI($("#CboProject").val()),
                RoleID: encodeURI(SessionRoleId),
                UserID: encodeURI(UserID),
                strEntityName: encodeURI(StrEntityName),
                LoginType: encodeURI(LoginType),
                Type: encodeURI(41),
                IsActive: encodeURI(1)
            }
            var param = JSON.stringify(WBSParameters);
            var result = AJAXCallWithAuthorizeResult("/api/PM_wbs_card/PloatCustomFields", param, false);


            if (result != undefined) {

                if (result.length == 0) {
                    strHTML = "";
                    strHTML += "<label class='control-label'> No custom fields have been defined for this project.  </label>";
                    $("#divSubProjectCustomFields").append(strHTML);
                    $("#divSubProjectCustomFields").css("text-align", "center");
                }

                for (var i = 0; i < result.length; i++) {

                    var CustomFiledObj = result[i];
                    var DatabaseFieldName = CustomFiledObj.DatabaseFieldName;
                    CustomFieldsNames.push(DatabaseFieldName);
                    var custCon = "#custr" + (i + 1) + "c" + CustomFiledObj.ColumnNumber;

                    if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldText") !== -1) {
                        strHTML = "";
                        strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                            "<label class='control-label'id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + "  </label>";
                        //+ "</br>";

                        if (CustomFiledObj.IsCustomFieldAssigned == "1") {
                            if (CustomFiledObj.ControlHeight != "" && CustomFiledObj.ControlWidth != "") {
                                strHTML += "<input type='text' class='form-control' id='txt" + CustomFiledObj.DatabaseFieldName + "'style='height:" + CustomFiledObj.ControlHeight + "px; width:" + CustomFiledObj.ControlWidth + "px' "
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else if (CustomFiledObj.ControlHeight != "" && CustomFiledObj.ControlWidth == "") {
                                strHTML += "<input type='text' class='form-control' id='txt" + CustomFiledObj.DatabaseFieldName + "'style='height:" + CustomFiledObj.ControlHeight + "px'"
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else if (CustomFiledObj.ControlWidth != "" && CustomFiledObj.ControlHeight == "") {
                                strHTML += "<input type='text' class='form-control' id='txt" + CustomFiledObj.DatabaseFieldName + "'style='width:" + CustomFiledObj.ControlWidth + "px'"
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else {
                                strHTML += "<input type='text' class='form-control' id='txt" + CustomFiledObj.DatabaseFieldName + "'" //" style='width:200px' "
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                        }
                        else {
                            strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><%--<%= MyBase.GetResourceString("C_Not_Applicable") %>--%> N/A</span>";
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
                        if (CustomFiledObj.ValidationRules != 0) {
                            //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                            var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                            ValidationFieldsName.push(UserGivenCaption);
                            ValidationFieldID.push(fieldid);
                            ValidationRules.push(ValidationRulesnew);
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

                    if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldNumeric") !== -1) {
                        strHTML = "";
                        strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                            "<label class='control-label'id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + "  </label>";

                        if (CustomFiledObj.IsCustomFieldAssigned == "1") {

                            if (CustomFiledObj.ControlHeight != "" && CustomFiledObj.ControlWidth != "") {
                                strHTML += "<input type='text' class='form-control' id='txt" + CustomFiledObj.DatabaseFieldName + "'style='height:" + CustomFiledObj.ControlHeight + "px; width:" + CustomFiledObj.ControlWidth + "px' "
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else if (CustomFiledObj.ControlHeight != "" && CustomFiledObj.ControlWidth == "") {
                                strHTML += "<input type='text' class='form-control' id='txt" + CustomFiledObj.DatabaseFieldName + "'style='height:" + CustomFiledObj.ControlHeight + "px'"
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else if (CustomFiledObj.ControlWidth != "" && CustomFiledObj.ControlHeight == "") {
                                strHTML += "<input type='text' class='form-control' id='txt" + CustomFiledObj.DatabaseFieldName + "'style='width:" + CustomFiledObj.ControlWidth + "px'"
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else {
                                strHTML += "<input type='text' class='form-control' id='txt" + CustomFiledObj.DatabaseFieldName + "'" //" style='width:200px' "
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }

                        }
                        else {
                            strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><%--<%= MyBase.GetResourceString("C_Not_Applicable") %>--%> N/A</span>";
                        }
                        strHTML += "</div>";
                        $(custCon).html(strHTML);

                        var fieldid = "#txt" + CustomFiledObj.DatabaseFieldName;
                        //To set the default value to the TextArea and TextBox
                        if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                            //$(fieldid).html(CustomFiledObj.DefaultValue);
                            $(fieldid).val(CustomFiledObj.DefaultValue);
                        }

                        var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                        if (CustomFiledObj.ValidationRules != 0) {

                            //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                            var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                            ValidationFieldsName.push(UserGivenCaption);
                            ValidationFieldID.push(fieldid);
                            ValidationRules.push(ValidationRulesnew);
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
                            "<label class='control-label'id='lbl" + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + "  </label>";
                        if (CustomFiledObj.IsCustomFieldAssigned == "1") {
                            strHTML += "<div class='input-group datefielddiv'>"
                            strHTML += "<input type='text' autocomplete='off' class='form-control' id='dt" + CustomFiledObj.DatabaseFieldName + "'" //" style='width:200px' "
                                + " value=" + CustomFiledObj.DefaultValue + ">";
                            strHTML += " <span class='input-group-btn'><button class='btn btncalendar' type='button'><i class='fas fa-calendar-alt'></i></button></span>"
                            strHTML += "</div>"
                        }
                        else {
                            strHTML += "<span id='res_" + CustomFiledObj.DatabaseFieldName + "'><%--<%= MyBase.GetResourceString("C_Not_Applicable") %>--%> N/A</span>";
                        }
                        strHTML += "</div>";
                        //$("#CustomFieldsControl").append(strHTML);
                        $(custCon).html(strHTML);

                        var fieldid = "#dtext" + CustomFiledObj.DatabaseFieldName;
                        if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                            $(fieldid).val(CustomFiledObj.DefaultValue);
                        }

                        var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                        if (CustomFiledObj.ValidationRules != 0) {
                            //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                            var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                            ValidationFieldsName.push(UserGivenCaption);
                            ValidationFieldID.push(fieldid);
                            ValidationRules.push(ValidationRulesnew);
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


                    if (CustomFiledObj.DatabaseFieldName.indexOf("CustomFieldCombo") !== -1) {
                        strHTML = "";
                        strHTML += "<div class='form-group' id='div" + CustomFiledObj.DatabaseFieldName + "'>" +
                            "<label class='control-label'id='lbl" + + CustomFiledObj.DatabaseFieldName + "'>" + CustomFiledObj.UserGivenCaption + " </label>";
                        if (CustomFiledObj.IsCustomFieldAssigned == "1") {

                            if (CustomFiledObj.ControlHeight != "" && CustomFiledObj.ControlWidth != "") {
                                strHTML += "<select class='form-control form-select' id='cbo" + CustomFiledObj.DatabaseFieldName + "' style='height:" + CustomFiledObj.ControlHeight + "px; width:" + CustomFiledObj.ControlWidth + "px' "
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else if (CustomFiledObj.ControlHeight != "" && CustomFiledObj.ControlWidth == "") {
                                strHTML += "<select class='form-control form-select' id='cbo" + CustomFiledObj.DatabaseFieldName + "' style='height:" + CustomFiledObj.ControlHeight + "px'"
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else if (CustomFiledObj.ControlWidth != "" && CustomFiledObj.ControlHeight == "") {
                                strHTML += "<select class='form-control form-select' id='cbo" + CustomFiledObj.DatabaseFieldName + "' style='width:" + CustomFiledObj.ControlWidth + "px'"
                                    + " value=" + CustomFiledObj.DefaultValue + ">";
                            }
                            else {
                                strHTML += "<select class='form-control form-select' id='cbo" + CustomFiledObj.DatabaseFieldName + "'>" +
                                    + " value=" + CustomFiledObj.DefaultValue + "></select>";
                            }
                            //strHTML += "<div class='col-sm-8'><select class='form-control ' id='cbo" + CustomFiledObj.DatabaseFieldName + "' style='width:160px' >" +
                            //    "</select> </div>";
                        }
                        else {
                            strHTML += "<span id='res" + CustomFiledObj.DatabaseFieldName + "'><%--<%= MyBase.GetResourceString("C_Not_Applicable") %>--%> N/A</span>";
                        }
                        strHTML += "</div>";
                        $(custCon).html(strHTML);

                        var fieldid = "#cbo" + CustomFiledObj.DatabaseFieldName;
                        if (CustomFiledObj.DefaultValue != null && CustomFiledObj.DefaultType == 'S') {
                            $("select" + fieldid + "option:contains(" + CustomFiledObj.DefaultValue + ")").attr('selected', 'selected');
                        }
                        var UserGivenCaption = CustomFiledObj.UserGivenCaption;
                        if (CustomFiledObj.ValidationRules != 0) {
                            var ValidationRulesnew = CustomFiledObj.ValidationRules.split(",");
                            ValidationFieldsName.push(UserGivenCaption);
                            ValidationFieldID.push(fieldid);
                            ValidationRules.push(ValidationRulesnew);
                            //SetValidationToCustomFileds(CustomFiledObj.ValidationRules, UserGivenCaption, fieldid);
                        }

                        var lblId = "#lbl" + CustomFiledObj.DatabaseFieldName;
                        var Mandatory = CustomFiledObj.ValidationRules;

                        if (Mandatory.indexOf("1,") > -1) {
                            var requeridId = "Mandatory" + CustomFiledObj.DatabaseFieldName;
                            var mandatoryid = "#" + requeridId;
                            if ($(mandatoryid).length > 0) {

                            } else {
                                var lblval = "&nbsp;<span id=" + requeridId + "  style='color:red;'>*</span>";
                                $(lblId).append(lblval);
                            }
                        }
                        //GetExtendedCustomFieldComboboxValues(CustomFiledObj.DatabaseFieldName, $("#CboProject :selected").val());
                        continue;
                    }
                }
            }
            SetValidationToCustomFields();
        }


        var ValidationMessageFieldName = new Array();
        var ValidationMessageFiled = new Array();
        var ValidationMessage = new Array();
        var ValidationValidateID = new Array();
        var ValidationValidateExtID = new Array();
        function SetValidationToCustomFields() {

            for (var i = 0; i < ValidationFieldsName.length; i++) {
                var customField = { FieldID: ValidationFieldID[i], CustomFieldName: ValidationFieldsName[i], CustomValidation: ValidationRules[i] };
                var param = JSON.stringify(customField);
                var result = AJAXCallWithAuthorizeResult("/api/PM_wbs_card/GetValidationForCustomFields", param, false);

                if (result != undefined) {

                    for (var j = 0; j < result.length; j++) {
                        var ValidationObj = result[j];
                        if (ValidationMessage != "") {
                        }
                        ValidationMessage.push(ValidationObj.ValidationMessage);
                        ValidationValidateID.push(ValidationObj.ValidationID);
                        ValidationMessageFiled.push(ValidationObj.FieldID);
                        ValidationMessageFieldName.push(ValidationObj.FieldName);
                    }
                }

            }
        }


        //To check the validation for the custom fields       
        function CustomFieldValidation() {

            var checkval = 0;
            //Added By Rutuja D. for Numeric CustomField Validation
            for (var j = 0; j < CustomFieldsNames.length; j++) {
                if (CustomFieldsNames[j].indexOf("CustomFieldNumeric") > -1) {
                    var CustomFieldId = "#txt" + CustomFieldsNames[j];
                    var CustomFieldValue = $(CustomFieldId).val();
                    if (CustomFieldValue != undefined && CustomFieldValue != null && CustomFieldValue != '') {


                        if (!jQuery.isNumeric(CustomFieldValue)) {

                            checkval = 1;
                            alertify.error("Please enter only  numeric values !!!");
                            $(CustomFieldId).focus()
                            return checkval;
                            break;
                        }
                    }
                }

            }

            for (var i = 0; i < ValidationMessageFieldName.length; i++) {
                switch (ValidationValidateID[i]) {

                    case "1":
                        //For Blank
                        if (ValidationMessage[i].indexOf("blank") != -1) {
                            if ($(ValidationMessageFiled[i]).val() == "" && $(ValidationMessageFiled[i]).val() != undefined) {
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
                            if ($(ValidationMessageFiled[i]).val() != "" && $(ValidationMessageFiled[i]).val() != undefined) {
                                if (!isDate($(ValidationMessageFiled[i]))) {
                                    checkval = 1;
                                    alertify.error("The date you have entered is invalid" + " For " + ValidationMessageFieldName[i]);
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;

                    //For  Number
                    case "3":
                        if (ValidationMessage[i].indexOf("numeric") != -1) {

                            if ($(ValidationMessageFiled[i]).val() != "" && $(ValidationMessageFiled[i]).val() != undefined) {
                                if (!jQuery.isNumeric($(ValidationMessageFiled[i]).val())) {

                                    checkval = 1;
                                    alertify.error(ValidationMessageFieldName[i] + " Please enter only numeric values. ");
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
                            if (Condition != "") {
                                var pattern = /^[a-zA-Z]+$/;
                                if (!pattern.test(Condition)) {
                                    checkval = 1;
                                    alertify.error(ValidationMessageFieldName[i] + " Please enter only Alphabets.");
                                    $(ValidationMessageFiled[i]).focus()
                                    return checkval;
                                }
                            }
                        };
                        break;
                    case "12": //For Maxlength 
                        if (ValidationMessage[i].indexOf("Max") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "") {
                                if ($(ValidationMessageFiled[i]).attr("maxlength")) {
                                    if ($(ValidationMessageFiled[i]).val().length > $(ValidationMessageFiled[i]).attr("maxlength")) {

                                        checkval = 1;
                                        alertify.error(ValidationMessage[i] + "" + ValidationMessageFieldName[i]);
                                        $(ValidationMessageFiled[i]).focus()
                                        return checkval;
                                        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                    }

                                }
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

                                var value = $(ValidationMessageFiled[i]).val();
                                if (checkSpecialCharacter(value) == true) {
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
                                if ($(ValidationMessageFiled[i]).attr("MinValue")) {
                                    if ($(ValidationMessageFiled[i]).val() < $(ValidationMessageFiled[i]).attr("MinValue") && $(ValidationMessageFiled[i]).val() != $(ValidationMessageFiled[i]).attr("MinValue")) {

                                        checkval = 1;
                                        alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i] + " " + $(ValidationMessageFiled[i]).attr("MinValue"));
                                        $(ValidationMessageFiled[i]).focus()
                                        return checkval;
                                        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                    }

                                }
                            }
                        };
                        break;
                    case "17"://For  Maximum Value Check
                        if (ValidationMessage[i].indexOf("greater") != -1) {
                            if ($(ValidationMessageFiled[i]).val() != "") {
                                if ($(ValidationMessageFiled[i]).attr("MaxValue")) {
                                    if ($(ValidationMessageFiled[i]).val() >= $(ValidationMessageFiled[i]).attr("MaxValue") && $(ValidationMessageFiled[i]).val() != $(ValidationMessageFiled[i]).attr("MaxValue")) {

                                        checkval = 1;
                                        alertify.error(ValidationMessageFieldName[i] + " " + ValidationMessage[i] + " " + $(ValidationMessageFiled[i]).attr("MaxValue"));
                                        $(ValidationMessageFiled[i]).focus()
                                        return checkval;
                                        //Max Length of <ID> is <LENGTH> characters.\r\nYou have entered <L> characters.
                                    }

                                }
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

        //Function for to get the date picker on click of the textbox
        function CustomfiledDatePicker(customfileddateid) {
            var filedid = "#dt" + customfileddateid;
            $(filedid).datepicker({
                //autoclose: true
                changeMonth: true,
                changeYear: true,
                dateFormat: 'd M yy'
            });
        }


        function delCustomfiledDatePicker(customfileddateid) {
            var filedid = "#" + customfileddateid;
            $(filedid).datepicker({
                //autoclose: true
                changeMonth: true,
                changeYear: true,
                dateFormat: 'd M yy'
            });
        }

        //This function gets the values  for  the all the extended custom field dropdowns and binds to it.
        function GetExtendedCustomFieldComboboxValues(DatabaseFieldName, ProjectID) {
            var commonProp = { ProjectId: parseInt(ProjectID) };

            var customFiled = { commonProperty: commonProp, DatabaseFieldName: DatabaseFieldName };

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetExtendedCustomFieldComboboxValues',
                method: 'Post',
                data: JSON.stringify(customFiled),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));

                },
                success: function (result) {

                    for (var i = 0; i < result.length; i++) {

                        var list = result[i];

                        var s = ('<option value=' + list.UniqueID + ' >' + list.FieldName + '</option>');

                        var cboName = "#cbo" + DatabaseFieldName;

                        $(cboName).append(s);

                    }

                    var ExtenededCustomFieldName = "" + DatabaseFieldName;
                    AppendOptioncbo(ExtenededCustomFieldName, "");

                },
                error: function (xhr, errorThrown) {
                    // alert("error ");
                }
            });
        }

        function AppendOptioncbo(FieldName, CaptionName) {
            var id;
            if (FieldName.indexOf("CustomFieldCombo") > -1) {


                id = "cbo" + FieldName //.substr(0, FieldName.indexOf(","));
                FieldName = CaptionName;
            }
            else {
                id = "cbo" + FieldName;
                FieldName = CaptionName;
            }
            //var s = "Type";
            if (FieldName == "DeliverableID") {
                FieldName = "Deliverables";
            } else if (FieldName == "ReleaseID") {
                FieldName = "Release";

            } else if (FieldName == "RootCauseID") {
                FieldName = "Root Cause";

            } else if (FieldName == "ModuleName") {
                FieldName = "Module Name";

            } else if (FieldName == "ChangeRequestID") {
                FieldName = "Change Request Name";

            } else if (FieldName == "CodedBy") {
                FieldName = "Coded By";

            } else if (FieldName == "ReportedInVersion") {
                FieldName = "Reported In Version";

            } else if (FieldName == "CorrectedInVersion") {
                FieldName = "Corrected In Version";

            } else if (FieldName == "FoundInPhase") {
                FieldName = "Found In Phase";

            } else if (FieldName == "FixedInPhase") {
                FieldName = "Fixed In Phase";

            } else if (FieldName == "AssignTo") {
                FieldName = "Responsible Person";

            } else if (FieldName == "IterationID") {
                FieldName = "Sprint";

            } else if (FieldName == "UserStoryID") {
                FieldName = "User Story";

            } else if (FieldName.indexOf("CustomFieldCombo") > -1) {
                FieldName = FieldName //.substr(FieldName.indexOf(",") + 1, FieldName.length);

            }
            else if (FieldName == "Phase") {
                FieldName = " Source Phase";
            }

            else if (FieldName == "Filter") {
                FieldName = "Filter";
            }

            else if (FieldName == "ReportedBy") {
                FieldName = "Reported By";
            }


            var textval = "Select " + FieldName + "";
            if (document.getElementById(id) != null) {
                document.getElementById(id).insertBefore(new Option(textval, '0'), document.getElementById(id).firstChild);

                $("#" + id + " option[value=0]").prop('selected', true);
            }
        }


        function getProjectTaskConfigureDetails() {
            var getProjectTaskConfigure = {
                ProjectID: encodeURI($("#CboProject").val())
            };
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetProjectTaskConfigureDetails',
                type: "POST",
                data: JSON.stringify(getProjectTaskConfigure),
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (getProjectTaskConfigure) {
                        xhr.setRequestHeader("Params", encryptString(isJson(getProjectTaskConfigure) ? getProjectTaskConfigure : JSON.stringify(getProjectTaskConfigure)));
                    }
                },
                async: false,
                success: function (data) {
                    if (data != null && data != '') {
                        intResourceValidation = data.ResourceValidation;
                        TotalAllocatedTaskLCE = data.TotalAllocatedTaskLCE;
                        TotalLCE = data.TotalLCE;
                        HoursPerDay = data.HoursPerDay;
                        WeekDays = data.WeekDays;
                        hdnRestrictByMinHours = data.RestrictByMinHours;
                        ProjectStartDate = data.ProjectStartDate;
                        ProjectEndDate = data.ProjectEndDate;
                        HaveSubTaskTypes = data.HaveSubTaskTypes;
                        ApplyEffortDistribution = data.ApplyEffortDistribution;
                    }
                },
                error: function (xhr, status, error) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });
        }

        $(document).on('click', '#btnAddTasks', function () {
          
            //Added & Commented By Dipali V On 21st Jan 2020 For Change Caption
            $("#TaskHeading").text("");
            $("#TaskHeading").text("Create Task");


            //End of Added & Commented By Dipali V On 21st Jan 2020 For Change Caption
            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
                return;
            }
            // debugger;
            //Added By Dipali V On 2nd jan 2020 For Project Onhold then it should not allow to add Task 
            if (ProjectOnHold == 1) {
                showAlert(ProjectOnHoldMsg, 'alert-danger');
                return;
            }
            //End of Added By Dipali V On 2nd jan 2020 For Project Onhold then it should not allow to add Task 
            //Commented And Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
            //getProjectDetails();
            getProjectDetails("addtask");
            if (strBaselineMessage != "") {
                return;
            }
            //End Of Added By Usha Pandit On 28.08.2020 For validating Project Creation Workflow
            GetPriorities();
            GetTaskTypes("EDIT");
            GetProjectPhases();
            GetProjectDeliverables();
            GetUserStories();
            GetChangeRequest();
            GetFeatures();
            GetEstimationTypes();
            if (isAgileMethodused == 1) {
                $(".AgileDiv").css("display", "inline-block");
                $("#isAgilelabel").addClass("required");//Added by Dipali V On 24th Jan 2020 For Agile Project US Manatory
                // $('#lbstorypoints').addClass("required");
            } else {
                $(".AgileDiv").css("display", "none");
                $("#isAgilelabel").removeClass("required");//Added by Dipali V On 24th Jan 2020 For Agile Project US Manatory
                // $('#lbstorypoints').removeClass("required");
            }
            $(".addtaskduration").css("display", "none");
            var taskId = '0';
            GetResources(taskId);
            GetMilestones(taskId);
            GetProjectModules(taskId);
            GetSubProjects(taskId);
            ValidationMessageFieldName = new Array();
            ValidationMessageFiled = new Array();
            ValidationMessage = new Array();
            ValidationValidateID = new Array();
            ValidationValidateExtID = new Array();
            ValidationFieldsName = new Array();
            ValidationFieldID = new Array();
            ValidationRules = new Array();
            CustomFieldsNames = new Array();
            //var isCustomField = getCustomFieldsMaxRowColCount();
            //if (isCustomField == true) {
            //    PloatCustomFields();
            //}
            getProjectTaskConfigureDetails();
            $(".popupboxtabs>li.active").removeClass("active");
            $(".popupboxtabs>li:first").addClass("active");
            $("#wbsbasic").removeClass("active");
            $("#wbsbasic").addClass("active");
            $("#CDallattachments").removeClass("active");
            $("#liCDallattachments").hide();
            $("#taskeditor").modal("show");

            $("#hdnTaskID").val('0');
            hiddenTaskID = "0";
            ParentTaskID = '0';
            WhichTask = "O";
            OtherTaskID = 0;
            MitigationPlanID = 0;
            TrainingResourceID = 0;
            TrainingID = 0;
            Void = 1;
            DeliverableStageID = null;

            $("#hdn_txtActualWork").val('0');
            $("#hdn_txtPlannedWork").val('0');
            $("#txthdnCurrentWork").val('0');

            //need to discuss
            PreviousStartDate = '';
            PreviousEndDate = '';
            $("#hdn_txtTaskEndDate").val('');
            $("#hdn_txtTaskStartDate").val('');
            $("#hdn_txtActualStartDate").val('');
            $("#hdn_txtActualEndDate").val('');

            $("#txthdnMilestone").val('');
            $("#txthdnSubProject").val('');
            $("#txthdnModule").val('');
            $("#txthdnPhase").val('');
            clearTaskData();
            $("#cboResource").prop("disabled", false);
            CheckProjectOnHold(); //Added by Dipali V On 23rd Jan 2020 For Check PRoject On hold or not
            //Added By Dipali V On 23rd Jan 2020 For Billable Project check box should be check

            if (ProjectBillable == 1) {
                $("#chkBillable").prop("checked", true);
            } else {
                $("#chkBillable").prop("checked", false);
            }


            if (ProjectOnHold == 1) {
                $("#btnTaskSave").prop("disabled", true);
                $("#PRaddattachnebtrow").prop("disabled", true);
            } else {
                $("#btnTaskSave").prop("disabled", false);
                $("#PRaddattachnebtrow").prop("disabled", false);

            }
            //End of  Added By Dipali V On 23rd Jan 2020 For Billable Project check box should be check
            //debugger;
            //Commented By Dipali V On 18th Feb 2020 for billable checkbox should be checked
            //Added by Chetan M on 11th Feb 2020
            // $("#chkBillable").prop("checked", false);
            //End of Added by Chetan M on 11th Feb 2020
            //End of Commented By Dipali V On 18th Feb 2020 for billable checkbox should be checked
            //Added by Chetan M on 27th Aug 2020 for get the default task type selected.
            GetDefaultTaskType();
            //End of Added by Chetan M on 27th Aug 2020 for get the default task type selected.
        });

        function clearTaskData() {
            $("#taskmapping").removeClass('in')//Added By Dipali V On 21st Jan 2020 For Close div after cancel task details
            $("#taskeditor").find("input[type=text],input[type=Textbox], textarea").val("");
            $("#taskeditor").find('input:checkbox').removeAttr('checked');
            $("#taskeditor").find("select").each(function (obj) {
                var cbo = this.id;
                //if (cbo != 'txtPMRWCRFilterReviewedBy' && cbo != 'txtPMRWCRFilterReviewee') {
                $("#" + cbo + " option:first").prop('selected', 'selected');
                //}
            });
            //Added by Dipali V On 23rd Jan 2020 For Clear Check box of billable
            $("#chkBillable").prop("checked", false);
            ProjectBillable = "";
            //End of Added by Dipali V On 23rd Jan 2020 For Clear Check box of billable
        }

        function getResourceData(employeeId) {
            if (resourcesList != '' && resourcesList.length > 0) {
                var i = 0;
                var length = resourcesList.length;
                while (i < length) {
                    if (parseInt(resourcesList[i].EmployeeId) == parseInt(employeeId)) {
                        return resourcesList[i];
                    }
                    i++;
                }
            }
            return '';
        }

        function GetEmployees() {
            $("#txtStartDateFilter").val('');
            $("#txtEndDateFilter").val('');
            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                $("#cboEmployeeIDFilter").empty().append('<option value="">Select Employee</option>');
                return;
            }
            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
            }

            $.ajax({
                url: strUrl + '/api/PM_wbs_card/GetResources',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                async: false,
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                    // alert(result);
                    resourcesList = result;
                    //Added & Commented By dipali V On 22nd jan 2020 for Placeholder issues
                    //$("#cboEmployeeIDFilter").empty().append('<option value="">Select All</option>');
                    $("#cboEmployeeIDFilter").empty().append('<option value="">Select Employee</option>');
                    //End of Added & Commented By dipali V On 22nd jan 2020 for Placeholder issues
                    $.each(result, function () {
                        $("#cboEmployeeIDFilter").append($("<option></option>").val(this['EmployeeId']).html(this['EmployeeName']));
                    });
                    //isEmployeeRoleAllowToFilter();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }




        var isRoleAllowToFilter = 0;
        function isEmployeeRoleAllowToFilter() {
            var ProjectID = $("#CboProject :selected").val();
            var SessionRoleId = '<%= Session("intPostID") %>';
            var defaultFilterParameters = {
                ProjectID: encodeURI($("#CboProject :selected").val()),
                RoleID: encodeURI(SessionRoleId),
            }
            if (ProjectID == "" || ProjectID == "0") {
                isEmployeeRoleAllowToFilter = 0;
            } else {
                $.ajax({
                    url: strUrl + '/api/PM_wbs_card/IsEmployeeRoleAllowToFilter',
                    type: "POST",
                    dataType: "json",
                    data: JSON.stringify(defaultFilterParameters),
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (defaultFilterParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                        }
                    },
                    success: function (result) {
                        isRoleAllowToFilter = result;
                        $("#cboEmployeeIDFilter").val(UserID);
                        if (isRoleAllowToFilter == 1) {
                            $("#cboEmployeeIDFilter").prop("disabled", false);
                            if ($("#cboEmployeeIDFilter").val() == '' || $("#cboEmployeeIDFilter").val() == null || $("#cboEmployeeIDFilter").val() == '0') {
                                $("#cboEmployeeIDFilter").val('');
                            }
                        } else {
                            //commented By Dipali V On 23rd Jan 2020 For employee filter should not be get disbaled
                            //$("#cboEmployeeIDFilter").prop("disabled", true);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }

        }

        $(document).on("click", "#btnFilter", function () {
            var projectID = $("#CboProject :selected").val();
            if (projectID == '0' || projectID == '') {
                showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
                return;
            }
            var IsActive, WhichTask;
            var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
            var getClassName = $('#tabWhizibleTasks').attr('class');
            if (getClassName == "tab-slider--trigger active") {
                WhichTask = "";
            }
            else {
                WhichTask = "M";
            }
            if (ActiveTab == "tabActive") {
                IsActive = 1;
            }
            else if (ActiveTab == "tabAll") {
                IsActive = 0;
            }
            var employeeid = $("#cboEmployeeIDFilter").val();
            var tasktypeid = $("#cboTaskTypeFilter").val();
            var startdate = $("#txtStartDateFilter").val();
            var enddate = $("#txtEndDateFilter").val();
            if (isRoleAllowToFilter == 0) {
                //if (employeeid == null || employeeid == '' || employeeid == '0') {
                //    //showAlert('Login user is not configure to this project', 'alert-danger');
                //    return;
                //}
            }

            //debugger;
            if (isRoleAllowToFilter == 0) {
                if (employeeid == "" && $('#txtEndDateFilter').val() == "" && $('#txtStartDateFilter').val() == "" && $('#cboTaskTypeFilter').val() == "") {
                    //showAlert('Login user is not configure to this project', 'alert-danger');
                    showAlert('Please Select at least one Filter Field.', 'alert-danger');
                    return;
                }
            }

            if ($('#txtStartDateFilter').val() != '' && $('#txtEndDateFilter').val() != '') {
                var jsStartDate = $('#txtStartDateFilter').datepicker('getDate');
                var jsEndDate = $('#txtEndDateFilter').datepicker('getDate');
                var StartDate = new Date(jsStartDate);
                var EndDate = new Date(jsEndDate);
                if (StartDate > EndDate) {
                    $('#txtEndDateFilter').focus();
                    showAlert('<%= MyBase.GetResourceString("C_StartDate_Greater") %>', "alert-danger");
                    return;
                }
            }
            $(".draggablemenu").html('');
            $("#TaskClearAllFilter").css("display", "block");
            GetProjectTasks(IsActive, WhichTask, '<%=m_roleLevel%>', employeeid, tasktypeid, startdate, enddate);
            $("#AdvanceFilterIcon").addClass("filteractive");
            clearTooltip();
        });

        //Added  By Dipali V On 22nd Jan 2020 For Filter Clear Function
        function GetDeafultFilter() {

            var WhichTask;
            var ActiveTab = $('.tab-slider-trigger,.active').attr('id');
            var getClassName = $('#tabWhizibleTasks').attr('class');
            if (getClassName == "tab-slider--trigger active") {
                WhichTask = "";
            }
            else {
                WhichTask = "M";
            }
            //commented by imran on 23-02-2022
            //if (ActiveTab == "tabActive") {
            //    GetDefaultStages($("#CboProject").val(), 1, WhichTask);
            //    //alert(getClassName);
            //}
            //else if (ActiveTab == "tabAll") {
            //    GetDefaultStages($("#CboProject").val(), 0, WhichTask);
            //}


            $("#TaskClearAllFilter").css("display", "none");
            $("#filterpanel").removeClass("in");
            $("#AdvanceFilterIcon").removeClass("filteractive");

            $("select #CboProject").change(CboProject_OnChange());

            //window.location.reload();
            clearTooltip();
        }

        //End of Added  By Dipali V On 22nd Jan 2020 For Filter Clear Function

        //Added By Dipali V On 25th Jan 2020 For userStory On change Get Release & Sprint
        function GetSprintRelease(UserStoryID) {
            //debugger;
            if (UserStoryID != "") {
                UserStoryID = $("#cboUserStory").val();


                var WBSParameters = {
                    UserStoryID: encodeURI(UserStoryID),
                    ProjectID: $("#CboProject").val(),
                    TaskID: $("#hdnTaskID").val()
                }
                var IterationName, ReleaseName, InitialEstimate, StoryPoints;
                var param = JSON.stringify(WBSParameters);
                var Result = AJAXCallWithAuthorizeResult("/api/PM_wbs_card/GetSprintRelease", param, false);

                for (i = 0; i <= Result.length - 1; i++) {
                    // debugger;
                    IterationName = Result[i].IterationName
                    ReleaseName = Result[i].ReleaseName
                    //Added By Dipali V on 11th Feb 2020 For Story point validation with US
                    StoryPoints = Result[i].StoryPoints
                    InitialEstimate = Result[i].InitialEstimate
                    //End of Added By Dipali V on 11th Feb 2020 For Story point validation with US
                    $("#txtSprint").val(IterationName);
                    $("#txtRelease").val(ReleaseName);
                    //Added By Dipali V on 11th Feb 2020 For Story point validation with US
                    if ($("#hdnTaskID").val() == 0) {
                        $("#txtStoryPoint").val(InitialEstimate);
                        $("#hdnstorypoints").val(InitialEstimate);
                    }
                    else {
                        $("#txtStoryPoint").val(StoryPoints);
                        $("#hdnstorypoints").val(InitialEstimate);
                    }
                    //End of Added By Dipali V on 11th Feb 2020 For Story point validation with US

                }



            } else {
                $("#txtSprint").val("");
                $("#txtRelease").val("");
                $("#txtStoryPoint").val("");

            }
        }

        //End of Added By Dipali V On 25th Jan 2020 For userStory On change Get Release & Sprint


        //Added By Dipali V On 25th Jan 2020 for Flag Insertion
        function SaveTaskCardFlag(TaskID, IsActive, TaskEnddate, TaskStartdate) {
            //debugger;

            var Isaction = 0;
            // var isFlag = 0;
            if ($("#duedate_" + TaskID).val() == "") {
                showAlert("Due Date Should not be left blank.", 'alert-danger');
                $("#ul_" + TaskID).css("display", "block"); //Added by Chetan M on 25 May 2021 for popup is getting closed
                $("#duedate_" + TaskID).focus();
                return false;
            }
            //Added By Dipali V On 26th Feb 2020 for due date should be less than task start date
            var DueDate = $("#duedate_" + TaskID).val();
            if (Date.parse(DueDate) < Date.parse(TaskStartdate)) {
                showAlert("Due Date Should be greater than task start date.", 'alert-danger');
                $("#ul_" + TaskID).css("display", "block"); //Added by Chetan M on 25 May 2021 for popup is getting closed
                $("#duedate_" + TaskID).focus();
                return false;
            }
            //Added By Dipali V On 27th Feb 2020 For Due Date should be Today to Greater than Today
            else if (Date.parse(DueDate) < Date.parse(SelectedCurrentdate.toShortFormat())) {
                showAlert("Due Date Should be today or greater than today.", 'alert-danger');
                $("#ul_" + TaskID).css("display", "block"); //Added by Chetan M on 25 May 2021 for popup is getting closed
                $("#duedate_" + TaskID).focus();
                return false;
            }
            //End Added By Dipali V On 26th Feb 2020 for due date should be less than task start date

            //debugger;
            if (IsActive == 1) {
                var DueDate = $("#duedate_" + TaskID).val();
                if (Date.parse(DueDate) > Date.parse(TaskEnddate)) {
                    Isaction = Action(isFlag);
                    if (Isaction == 0) {
                        $("#ConfirmationAlert").modal('show');
                        $("#spnConfirmationAlert").text('');
                        $("#spnConfirmationAlert").text('Due date is greater than task end date. Do yo want to continue?');
                        //$("#duedate_" + TaskID).focus();

                    }
                }
                else {
                    Isaction = 1;
                }

            } else {
                Isaction = 1;
            }

            if (Isaction == 1) {
                if ($("#TaskFlagID_" + TaskID).val() != "") {
                    TaskFlagID = $("#TaskFlagID_" + TaskID).val();
                } else {
                    TaskFlagID = 0;
                }
                var Duedate = $("#duedate_" + TaskID).val();
                var WBSParameters =
                {
                    FlagDate: Duedate,
                    ProjectID: $("#CboProject").val(),
                    TaskFlagID: TaskFlagID,
                    TaskID: TaskID,
                    IsActive: IsActive,
                    UserID: UserID,
                    EmployeeName: UserName
                }

                var param = JSON.stringify(WBSParameters);
                var Result = AJAXCallWithAuthorizeResult("/api/PM_wbs_card/SaveTaskCardFlag", param, false);
                //debugger;
                if (Result != "") {
                    if (IsActive == 1) {
                        if (Result == $("#TaskFlagID_" + TaskID).val()) {
                            showAlert("Due Date Updated Successfully.", 'alert-success');
                            $("#ul_" + TaskID).css("display", "");
                            Isaction = 0;
                        }
                        else {
                            showAlert("Due Date Saved Successfully.", 'alert-success');
                            $("#ul_" + TaskID).css("display", "");

                            Isaction = 0;
                        }

                        GetFlagDetails(TaskID);
                    }
                    else {
                        showAlert("Unflag Updated Successfully.", 'alert-success');
                        Isaction = 0;
                        GetFlagDetails(TaskID);
                        $("#duedate_" + TaskID).val("");
                        $("#BtnUnflag_" + TaskID).css("display", "none");
                        $("#FlagidNw_" + TaskID).removeClass('FlagColor_Red');
                        $("#Flagid_" + TaskID).removeClass('FlagColor_Red');

                    }
                    $(".dropdown-menu").removeClass('show');
                    Isaction = 0;
                    isFlag = 0;
                }
            }

        }


        //End of Added By Dipali V On 25th Jan 2020 for Flag Insertion

        //Added By Dipali V On 25th Jan 2020 for Get Flag Details
        function GetFlagDetails(TaskID) {
            var WBSParameters =
            {
                TaskID: encodeURI(TaskID),
                ProjectID: $("#CboProject").val(),
            }
            var IterationName, ReleaseName;
            var param = JSON.stringify(WBSParameters);
            var Result = AJAXCallWithAuthorizeResult("/api/PM_wbs_card/GetFlagDetails", param, false);
            for (i = 0; i <= Result.length - 1; i++) {
                $("#duedate_" + TaskID).val(Result[i].FlagDate);
                $("#TaskFlagID_" + TaskID).val(Result[i].TaskFlagID);
            }

            // debugger;
            if ($("#duedate_" + TaskID).val() != "") {

                $("#BtnUnflag_" + TaskID).css("display", "inline-block");
                //Added BY Dipali V On 12th Feb 2020 For Flag Color change
                $("#Flagid_" + TaskID).addClass('FlagColor_Red');
                $("#FlagidNw_" + TaskID).addClass('FlagColor_Red');

                //End of Added BY Dipali V On 12th Feb 2020 For Flag Color change
            } else {
                $("#BtnUnflag_" + TaskID).css("display", "none");
                //Added BY Dipali V On 12th Feb 2020 For Flag Color change
                $("#FlagidNw_" + TaskID).removeClass('FlagColor_Red');
                $("#Flagid_" + TaskID).removeClass('FlagColor_Red');

                //End of Added BY Dipali V On 12th Feb 2020 For Flag Color change
            }




        }
        //End of Added By Dipali V On 25th Jan 2020 for Get Flag Details

        function enableDisabledControls() {

            var id = $("#CboProject :selected").val();
            if (id == '' || id == '0' || id == null) {
                $(".addwbstaskbtn").addClass("disabledbutton");
                //$(".headertodisable").addClass("disabledbutton");             
                $.each($("#bodywbs").find("li,input[type=text],select,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });

            } else {
                $(".addwbstaskbtn").removeClass("disabledbutton");
                //$(".headertodisable").removeClass("disabledbutton");
                $.each($("#bodywbs").find("li,input[type=text],select,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
            }
            $("#btnCloseableAlert").removeClass("disabledbutton");
            $("#CboProject").removeClass("disabledbutton");
        }

        function SetDeleteTask() {
            $("#deletetaskmodal").modal("show");
        }

        function CancelDeleteTask() {
            $("#deletetaskmodal").modal("hide");
        }
        /*Added By Dipali V On 11th April 2023 For Tab Functionality */
        $("#liCDallattachments").on("click", function () {
            $("#liwbsbasic").removeClass('active');
            $("#wbsbasic").removeClass('show');
            $("#wbsbasic").removeClass('active');
            $("#liCDallattachments").addClass('active');
            $("#CDallattachments").addClass('active');
        });

        $("#liwbsbasic").on("click", function () {
            $("#liCDallattachments").removeClass('active');
            $("#CDallattachments").removeClass('show');
            $("#CDallattachments").removeClass('active');
            $("#liwbsbasic").addClass('active');
        });
        /*End of Added By Dipali V On 11th April 2023 For Tab Functionality */
        function DeleteTask() {
            var userSelectedDiv = "";
            $('.taskcardbox').each(function () {
                if (this.id != "" && this.id != undefined) {
                    if ($("#" + this.id).is(".selectedDiv")) {
                        userSelectedDiv = this.id;
                        var StageID = $('#' + userSelectedDiv).parent().closest('div').attr('id').split(' ');
                        var hiddenStagId = $('#' + StageID).find('input[type=hidden]:first').val();
                        //Added by Chetan M on 7th Feb 2020 for IssueID = 21651
                        GlobalTaskEmployeeID = $('#hdnEmployeeID' + userSelectedDiv).val();
                        //End of Added by Chetan M on 7th Feb 2020 for IssueID = 21651
                    }
                }
            });
            if (userSelectedDiv.length == 0) {
                showAlert("Please Select at least one task card to delete", "alert-danger");
                return;
            } else {
                DeleteTaskcard(userSelectedDiv, "")
            }
        }
        //add by omkar 28/01/2020
        function fillprojectname() {
            var parameters = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                ProjectID: encodeURI('<%= Session("intProjectID") %>')
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetProjectDropDown',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(parameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(parameters) ? parameters : JSON.stringify(parameters)));
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
        //end of add by omkar 28/01/2020



        //add by omkar 03/02/2020
        function MouseClick() {
            var len = $("#draggable-menu>div > div > div>input:not([type='hidden'])").length;
            $("#draggable-menu>div > div > div>input:not([type='hidden'])").each(function (index, value) {
                var id = "#draggable-menu>div > div > div>input#" + this.id;
                var getStageName = $(id).val().trim();

                if (getStageName == "") {
                    if ($(id).is(":focus")) {

                    } else {
                        var value = $(id).attr('value');
                        $(id).val(value);
                        return;
                    }
                }
            });
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
        //end of add by omkar 03/02/2020

        //Added by imran on 10-01-2022
        function Doimport() {
            var ExcelColumn = ["CboExcelColumnA", "CboExcelColumnB", "CboExcelColumnC", "CboExcelColumnD", "CboExcelColumnE", "CboExcelColumnF", "CboExcelColumnG", "CboExcelColumnH", "CboExcelColumnI", "CboExcelColumnJ", "CboExcelColumnK", "CboExcelColumnL", "CboExcelColumnM", "CboExcelColumnN", "CboExcelColumnO", "CboExcelColumnP", "CboExcelColumnQ", "CboExcelColumnR", "CboExcelColumnS", "CboExcelColumnT", "CboExcelColumnU", "CboExcelColumnV"];
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_wbs_card/GetDropDownValue',
                type: "POST",
                data: '',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                async: false,
                success: function (strResult) {
                    if (strResult != undefined) {
                        var selHTML = "";
                        for (var i = 0; i < strResult.length; i++) {
                            selHTML += "<option  value='" + strResult[i].WBS_FieldName + "' >" + strResult[i].WBS_FieldName + "</option>";
                        }

                        for (k = 0; k < ExcelColumn.length; k++) {
                            $("#" + ExcelColumn[k]).html(selHTML);
                        }
                    }
                },
                error: function (xhr, status, error) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            })

        }
        //End by imran on 10-01-2022

        $('#txtStartDate, #txtStartDateFilter, #txtEndDate, #txtEndDateFilter').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'
        });

        //datepicker
        $('#duedate, #duedate1, #duedate2, #duedate3, #duedate4, #duedate5, #duedate6, #duedate7, #duedate8, #duedate9, #duedate10, #statuschangedate1, #TskinfoModalSD, #TskinfoModalED, #statuschangedate1').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
             dateFormat: 'dd MM yy'
        });

        $('#taskeditor,#filterpanel').on('change', '.form-control', function () {

            $('.btn').tooltip({ trigger: 'hover' });
            $('span').tooltip({ trigger: 'hover' });
            $('.ui-datepicker-calendar th span').tooltip('hide');
            $('.tooltip-inner').tooltip('hide');
        });

        



    </script>

    <div id="ConfirmationAlert" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>
                <div class="modal-body">
                    <p align="center"><span id="spnConfirmationAlert"></span></p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="Action('0')">Cancel</button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" onclick="Action('1')" data-bs-dismiss="modal">Yes</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</body>
</html>
