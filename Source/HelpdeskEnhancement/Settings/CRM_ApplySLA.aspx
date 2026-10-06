<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_ApplySLA.aspx.vb" Inherits="PbNIT.CRM_ApplySLA" %>

<!DOCTYPE html>
<html>

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" /> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/timepicker.min.css" />
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" /> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
</head>
    
    <style>
        /*Added By Yasmin on 25th july 2018*/

        .ui-tooltip {
            padding: 4px !important;
            position: absolute;
            z-index: 9999;
            max-width: 300px;
            background: #000 !important;
            color: #fff !important;
            -webkit-box-shadow: 0 !important;
            box-shadow: 0 !important;
            border: none !important;
            font-size: 11.5px !important;
        }

        .ui-tooltip-content::after, .ui-tooltip-content::before {
            top: 100%;
            border: solid transparent;
            content: " ";
            height: 0;
            width: 0;
            position: absolute;
        }

        .bottom .ui-tooltip-content::after {
            border-color: rgba(118, 118, 118, 0);
            border-top-color: #000;
            border-width: 6px;
            left: 50%;
            margin-left: -6px;
        }

        .bottom .ui-tooltip-content::before {
            border-color: rgba(118, 118, 118, 0);
            border-top-color: #000;
            border-width: 6px;
            left: 50%;
            margin-left: -6px;
        }

        .top .ui-tooltip-content::after {
            top: -6px;
            left: 50%;
            border-bottom-color: #000;
            border-width: 0 6px 6px;
            margin-left: -6px;
        }

        .top .ui-tooltip-content::before {
            border-color: rgba(118, 118, 118, 0);
            border-bottom-color: #000;
            top: -6px;
            left: 50%;
            border-width: 0 6px 6px;
            margin-left: -6px;
        }

        #dtEffectivedate:disabled {
            background-color: #ddd;
        }

        .clstabs {
            cursor: pointer;
        }

        #navApplySLAtabs li {
            cursor: pointer;
        }

        .v-tabs .tabcontent {
            float: left;
            padding: 0;
            border-style: solid;
            border-color: #647ea8;
            border-width: 0px 0px 0px 0px !important;
            width: 100%;
            border-left: none;
            height: 1214px;
        }

        .tablinks.active, .tablinks1.active, .h-tabs div.tab button.tablinks1.active, .h-tabs div.tab button.tablinks2.active, .h-tabs div.tab button.tablinks3.active {
            /*border: none !important;*/
            text-decoration: none !important;
        }

        .nav-tabs {
    border-bottom: 1px solid #ddd!important;
    width:inherit!important
}

        .content-wrapper {
            margin-left: 0px !important;
            padding-left: 0px !important;
        }

        /*#collapseOne .panel-body {
            OVERFLOW: auto;
            HEIGHT: 246PX;
        }*/

        .h-tabs div .panel-heading {
            height: 21px;
            border-style: solid;
            border-color: #e3e2e2;
            border-width: 1px 0 1px 0;
            background: #cbddfa;
        }

        .table-responsive .btn-default.btn {
            padding: 0;
            background: none;
            border: none;
        }

        .table-responsive .fa {
            font-size: 15px;
        }

        .clsTRColumnHeader th {
            text-align: LEFT;
        }


            .clsTRColumnHeader th:nth-child(7) {
                text-align: center !important;
            }
        /*.table-responsive table tbody {
        overflow:auto;
        }*/
        .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }


        .table-responsive {
            overflow: hidden;
        }

        .control-label {
            font-weight: normal !important;
            padding-top: 0% !important;
        }

        .dataTables_paginate {
            float: right !important;
        }

        .pagination {
            margin: 5px 0 !important;
        }

        .dataTables_info {
            margin-top: 8px;
        }

        /*.pagination > .active > span:hover {
            z-index: 2;
            color: #fff;
            cursor: default;
            background-color: #cbddfa;
            border-color: #cbddfa;
        }

        .page-item.active .page-link {
            z-index: 2;
            color: #fff;
            background-color: #cbddfa;
            border-color: #cbddfa;
        }*/

        .edit-bt {
            background: transparent;
            border: none;
            font-size: 22px;
            position: relative;
            top: -3px;
            color: #1e88e5;
        }

        .h-tabs input[type=checkbox] {
            outline: none;
        }

        .h-type .table-responsive table.table thead th :nth-child(4) {
            padding-left: 0px;
        }

        .h-tabs .table-responsive {
            border-bottom: none;
        }

        /*.bottom-bar {
            margin-top: -16px;
        }*/

        #divSubRequestType .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        #divSubRequestType .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
            /* padding-left: 25px; */
            /* padding-top: 10px; */
            position: relative;
        }

        #DivList .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
            /* padding-left: 25px; */
            /* padding-top: 10px; */
            position: relative;
        }

        .dataTables_info {
            font-size: 13px;
        }

        #frmType {
            width: 100%;
        }

        #divSubRequestType .dataTables_wrapper {
            padding-right: 15px;
            padding-left: 0px;
            margin-right: auto;
            margin-left: auto;
        }

        #accordion {
            overflow: hidden;
        }

        .far fa-edit {
            color: #4caac0 !important;
        }

        #collapseOne2 {
            overflow: hidden;
        }


        /*.dataTables_scrollBody .table tbody .even {
        background-color:#e8edf6;
        
        }*/

        .form-control {
            font-weight: 100;
        }

        #divStatus .dataTables_scrollHeadInner table .clsTRColumnHeader tr th:nth-child(4) {
            text-align: left;
        }

        select.form-control:not([size]):not([multiple]) {
            height: calc(1.50rem + 7px);
        }

        #divPriority .container-fluid {
            min-height: 0px !important;
        }


        #DivAuto {
            padding-top: 0% !important;
            padding-left: 1% !important;
        }

        #divAUTOCLOSER .dataTables_paginate {
            float: right !important;
            margin-right: -22% !important;
        }

        #AutoclosePanelDiv {
            padding-right: 3%;
        }



        .clsSettingstabs {
            margin-top: -13px;
        }

        .form-horizontal .form-group {
            line-height: 3;
        }

        .fa-sort {
            margin-left: 4px;
        }

        #divSeverity .clsTRColumnHeader TH:nth-child(3) {
            text-align: center;
        }
        /*.right {
            MARGIN-RIGHT: 10PX;
        }*/
        .clsbuttonLinks {
            margin-left: 2px;
        }

        #Autoclose h3 {
            padding: 0PX !important;
            border: none !important;
        }

        .content-wrapper {
            overflow: hidden !important;
        }

        .tabcontent1 {
            border: none !important;
        }

        #ApplySLA {
            width: 100%;
            overflow: hidden;
        }

        #divScrollApplySLA {
            width: 102%;
            padding-right: 2%;
            overflow: auto;
        }

        .dataTables_scrollBody .clsTRColumnHeader {
            height: 0px !important;
        }

        .type-top-bar {
            padding-right: 5px !important;
        }

            .type-top-bar .right {
                padding: 0px !important;
                margin-left:auto
            }

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
            word-break: break-all;
        }

        #divSubRequestType .clsTRColumnHeader TH:nth-child(2) {
            text-align: center;
        }

        #idSearchHistory {
            position: absolute;
            margin-top: 8px;
            margin-left: 10px;
        }

        div.tab {
            margin-top: 20px;
        }

        .lh {
            line-height: 1px;
            font-size: 16px;
            color: #fff;
            padding-left: 17px;
            height: 64px;
            margin: 0;
        }

        .pan {
            margin-top: 60px;
        }

        .hd {
            width: 100%;
            display: inline-block;
            background-color: #cbddfa;
            color: #000000;
            height: 21px;
            font-weight: 600;
            border: 1px solid #ddd;
        }

        .fs {
            font-size: 12px;
            width: 97%;
            line-height: 1px;
            color: #000;
            color: #000000;
        }

        .table > thead > tr > th {
            vertical-align: middle;
        }

        .v-tabs .h-tabs div.tab button.tablinks1 {
            width: auto;
        }

        .nestedco {
            font-size: 13px;
            font-weight: 600;
            background: none;
            font-weight: 600;
        }

        .tab-content {
            margin-top: 10px;
        }

        #exTab1 .tab-content {
            color: white;
            background-color: #428bca;
            padding: 5px 15px;
        }

        #exTab2 h3 {
            color: white;
            background-color: #428bca;
            padding: 5px 15px;
        }

        #exTab2 {
            font-size: 13px;
            font-weight: Normal;
            border: none;
            background: none;
            margin-right: 38px;
            margin-top: 23px;
        }
        /* remove border radius for the tab */



        /* change border radius for the tab , apply corners on top*/



        #exTab3 .tab-content {
            color: white;
            background-color: #428bca;
            padding: 5px 15px;
        }

        .tab {
            border-bottom: none;
        }

        @media screen and (max-width: 1121px) {
            div.tabz {
                border-bottom: none;
                margin-top: -20px;
            }
        }

        div.tabz {
            border-bottom: none;
        }

        .form-group {
            border-bottom: none;
        }

        option {
            vertical-align: middle;
        }

        select.form-control:not([size]):not([multiple]) {
            height: calc(2.8rem + 3px);
        }

        select {
            border-radius: 2px;
        }


        .form-control {
            border-radius: 2px;
        }

        .btn btn-primary active:hover {
            background-color: #364660;
        }

        .btx {
            border-radius: 1px;
            margin-left: 10px;
            padding: 5px;
            font-size: 12px;
            width: 225px;
            background-color: #647ea8;
        }

        .nav-tabs > li {
            color: #000000;
        }

            .nav-tabs > li.active > a {
                /*color: red !important;*/
                font-size: 13px;
                font-weight: 600;
            }

        /*.nav-tabs>li.active>a:active{
        background-color: #cbddfa;
        
       }*/

        .marg {
            margin-top: -15px;
        }

        .inp {
            height: 23px;
            padding: 0;
            font-size: 11px;
            border-radius: 0;
            padding-left: 10px;
            border-color: #82c4d3;
        }

        @media (min-width: 768px) {
            .wdt {
                width: auto;
            }
        }

        .top-bar i.fcal {
            margin-left: -14px;
        }

        .nav {
            display: inline-block;
        }

        .clsFormControl {
            width: 200px !important;
        }

        /*.left .col-sm-3:nth-child(1) {
            padding-left: 13px !important;
        }*/

        .col-sm-12 {
            font-size: 12px !important;
            font-weight: normal !important;
        }

        #dtExpResdate {
            width: 158px !important;
        }

        tr.clsTREvenRow {
            font-size: 12px !important;
        }

        #idCalender {
            /*Commented And Added By Usha Pandit On 24.06.2019 For Alignment Issue*/
            /*margin-top: 17PX;*/
          margin-top: 5PX!important;
            /*End Of Added By Usha Pandit On 24.06.2019 For Alignment Issue*/
        }

        .clsControl {
            padding-top: 13px;
        }

        .h-type input[type=checkbox] {
            outline: none !important;
            MARGIN-TOP: 6PX !important;
            VERTICAL-ALIGN: sub !important;
        }

        .control-label {
            margin-top: 5px;
        }

        #AlertSection {
            padding: 3px 8px !important;
        }

        #dtEffectivedate {
            width: 153px;
        }

        #divInternal {
            /*Commented And Added By Usha Pandit On 24.06.2019 For Alignment Issue*/
            /*margin-top: 9px;*/
        margin-top: 5PX!important;
        /*End Of Added By Usha Pandit On 24.06.2019 For Alignment Issue*/
        }
        #divInternal > label
        {
            margin-left: 3%!important;
        }
        #idEffeciveDate {
            /*Commented And Added By Usha Pandit On 24.06.2019 For Alignment Issue*/
            /*margin-top: 13px;*/
          margin-top:5px!important;
         /*End Of Added By Usha Pandit On 24.06.2019 For Alignment Issue*/
        }

        #tblTypeSLADetails {
            padding-top: 12PX;
            /*Added By Usha P On 12.05.2021 For SLA Details alignment issue*/
            overflow-x: visible!important;
            /*End Of Added By Usha P On 12.05.2021 For SLA Details alignment issue*/
        }

            #tblTypeSLADetails .form-control {
                font-weight: 100;
            }

        #CboType {
            /*width:75px;
        padding: 4px 5px;*/
            width: 81px;
            padding: 4px 7px;
            font-size: 11px !important;
        }

        select.form-control:not([size]):not([multiple]) {
            height: calc(1.50rem + 6px);
        }

        #tblTypeSLADetails table tbody td {
            vertical-align: middle !important;
            font-weight: Normal !important;
        }

        #tblTypeSLADetails table tbody th {
            vertical-align: middle !important;
            font-weight: Normal !important;
        }

        #tblTypeSLADetails .clsTxtControls {
            width: 43px !important;
            height: 28px !important;
        }

        #tblTypeSLADetails .clscboControls {
            width: 79px !important;
            margin-left: 10px;
        }

        input.form-control:not([type=button]) {
            width: 55px !important;
        }

        .container-fluid {
            min-height: 0px !important;
        }

        .clsCboCotrols {
            PADDING-TOP: 7PX !important;
        }
        /*#DivAlertSettings .form-group .col-sm-3:nth-child(2) {
        PADDING-TOP:7PX!important;
        }*/
        #DivAlertSettings {
            margin-top: 12PX;
        }

        #dtEffectivedate {
            width: 146px !important;
        /*Commented And Added By Usha Pandit On 24.06.2019 For Alignment Issue*/
        margin-top:0px!important;
        /*End Of Added By Usha Pandit On 24.06.2019 For Alignment Issue*/
        }



        /*Added By Vidya JAdhav ON 15 Dec 2017 For Configure User Groups*/

        div.tabz {
            margin-top: 2px !important;
        }

        #EmployeeFilter .nav-tabs {
            padding: 6PX;
        }

        #SearchEmployee {
            width: 191px !important;
            PADDING-LEFT: 31PX;
        }

        #cboDepartment {
            margin-left: 12px;
        }

        .faSettingSearch {
            position: absolute;
            margin-top: 8px !important;
            margin-left: 19px;
        }

        .panel-heading {
            background: #cbddfa;
            color: white;
        }

        .clscolor {
            background-color: white;
            color: black;
        }
        /*#divScrollConfigureGroups .nav-pills > li.active > a {
    color: #fff !important;
    background-color: transparent;
    }
    #divScrollConfigureGroups .nav-pills > li.active {
    color: #fff !important;
    }
    #divScrollConfigureGroups .nav-pills > li.active:hover {
    color: #fff !important;
    }*/
        /*.container-fluid {
    height:0PX !important;
    }*/
        /*.dataTables_scrollHead {
    margin-bottom:-22PX;
    }*/
        .h-type .panel-heading {
            height: 25PX;
        }

        .clsConfigureTabs {
            font-weight: normal !important;
        }

        .list-group-item {
            border: none !important;
        }
        /*.LiclsConfigureTabs ,.active{
    border-top-left-radius: 7px;
    border-top-right-radius: 7px;
    }*/
        .bottom-bar button {
            margin: -7px !important;
        }

        /*#navApplySLAtabs .nav-tabs > li.active > a, .nav-tabs > li.active > a:focus, .nav-tabs > li.active > a:hover {
        border-bottom-color:transparent;
        }     
          #navApplySLAtabs .nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
    
    cursor: default;
    background-color: #ffffff;
    border: 1px solid #ddd;
    border-bottom-color: transparent;
color: #4caac0 !important;  
    text-decoration: underline;
  }*/

        #idSelectedUser {
            margin-left: -28px;
        }

        #divEmployeeList {
            overflow-y: hidden;
            height: 407px;
            float: left !important;
            padding: 10px;
            overflow-x: hidden;
        }

        #divSelectGroupEmpList {
            margin-top: 14px;
        }

        #divSelectGroupEmpList {
            height: 400px;
        }

        #DivAlertSettings .col-sm-9 {
            margin-top: 7px;
        }

        #divScrollConfigureGroups .nav {
            padding-left: 38px;
        }

        #divScrollConfigureGroups .nav-tabs > li > a {
            margin-right: 0px !important;
        }

        #DivEmployeeScroll {
            height: 400px;
            overflow: auto;
            width: 112%;
            padding-right: 8%;
            overflow-x: hidden;
        }

        .dataTables_scrollBody .clsTRColumnHeader {
            height: 0px !important;
        }

        .nav-tabs > li.active > a, .nav-tabs > li.active > a:focus, .nav-tabs > li.active > a:hover {
            color: #555;
            cursor: pointer;
            background-color: #fff;
            border: 1px solid #ddd;
            border-bottom-color: transparent !important;
        }

        #SearchEmployee {
            margin-top: 2px !important;
        }

        #idSelectedUser .search-bar {
            font-weight: 600;
        }

        #divSelectedEmployeeList .dataTables_scrollHead {
            margin-bottom: -22PX;
        }

        #liAddUsers {
            margin-bottom: 12PX;
        }

        .list-group-item {
            cursor: pointer;
            border: 1px solid #ddd !important;
            margin-bottom: 3px;
        }

        .cutom-view-list {
            margin-left: -11px;
        }

        #navConfigureTabs > li.active > a, #navConfigureTabs > li.active > a:focus, #navConfigureTabs > li.active > a:hover {
            color: black !important;
        }

        #tblTypeSLADetails .table > thead tr th {
            font-weight: normal !important;
        }

        .right .btn-default {
            background: white !important;
            color: black !important;
        }

            .right .btn-default:hover {
                background: white !important;
                color: black !important;
            }

        #tblTypeSLADetails input.form-control:not([type=button]) {
            margin-top: 0px !important;
        }

        #idCancel {
            margin-left: 7px;
        }

        .modal-content {
            /*background-color: #fefefe;*/
            margin: 0px;
            border: 1px solid #888;
            width: 100%;
            height: 200PX !important;
        }

        #divSelectedEmployeeList .table-bordered td, .table-bordered th {
            border: 1px solid #ddd;
        }

        #idCalender {
            margin-left: 6PX;
        }

        /*Added By Usha Pandit On 24.06.2019 for Configure User Group Sub Tag Alignment Issue*/
        #navConfigureTabs {
            padding-left: 1px !important;
        }

        #cboDepartment {
            margin-top: 10% !important;
        }

        #SearchEmployee {
            margin-left: 11px !important;
        }

        #divCustomerFilter {
            margin-left: 8px !important;
        }
        #divDepartmentFilter {
            margin-left: 21px !important;
        }
        #divSLATypeFilter {
            margin-left: 21px !important;
        }
        .clsFormControl {
            width: 161px !important;
        }
        /*End of Added By Usha Pandit On 24.06.2019 for Configure User Group Sub Tag Alignment Issue*/
        /*Added By Pradip P On 12.05.2021 For SLA Configure User Group alignment issue*/
        #EmployeeFilter ul li {clear: both;}
        #divSelectedEmployeeList{ overflow:visible!important;}
        /*End Of Added By Pradip P On 12.05.2021 For SLA Configure User Group alignment issue*/
        ol, ul {padding-left: 0rem;}
        /*.type-top-bar{display:inline-flex}*/
        #divApplySLA{padding:0 15px}
        .dataTables_paginate .pagination .page-link{font-size:12px!important}
        #DivAlertSettings .col-sm-12, #DivAlertSettings .form-group{display:inline-flex}
        #divScrollApplySLA .type-top-bar{display:flex}
        .form-select{font-size:12px}
        .form-control {-webkit-appearance: auto;}
        #tblTypeSLADetails .form-group, .cutom-view-list{display:flex}
        #navConfigureTabs{display:inline-block}
        .nav-tabs li a{color:inherit}
        .nav-tabs > li > a.active, .nav-tabs > li.active > a:focus, .nav-tabs > li.active > a:hover {
            color: #1359ac !important;cursor: 
                default;background-color: #fff;
         /* Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
          /*  border: 1px solid #ddd!important;*/
            border-bottom-color: transparent!important;
            /* End of Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/

        }
        .nav>li>a:hover {text-decoration: none;background-color: #eee;}

        table.table{border:1px solid #ddd}
        /* Added by Gauri on 27th Sep 2024 for Alignment Issue */
        .form-control{
            font-weight: 400 !important;
        }
        input.form-control:not([type="button"]), 
        textarea.form-control, 
        textarea.form-control::placeholder,
        input[type="text"]:not(.search-bar){
            font-weight: 500 !important;
        }
        /* End of Added by Gauri on 27th Sep 2024 for Alignment Issue */
    </style>

    <body class="" id="page-top">

        <!-- Navigation -->

        <!----------------------------  Tabs----------------------------->
        <%WriteTabsControls("", "Load", "")%>
        <input type="hidden" id="hdnCustomerFlag" name="hdnCustomerFlag" value="0" />
        <input type="hidden" id="hdnSLADetailsID" name="hdnSLADetailsID" value="0" />
        <input type='hidden' id='hdnSLATemplateID' name='hdnSLATemplateID' value='" & SLATemplateID & "' />
        <input type='hidden' id='hdnSLAAppliedOn' name='hdnSLAAppliedOn' value='" & SLAAppliedOn & "' />



    </body>
    
    </html>
    <div class="modal" id="myOverride" style="overflow-y: hidden; outline: none;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content animate" style="overflow: hidden">
                <div class="modal-header">
                </div>
                <div class="modal-body" style="outline: none; width: 103%" id="OverrideAlert">
                    Do you want to override Template Details?
                </div>
                <div class="modal-footer">
                    <button type="button" id="btnConfirm" class="btn btn-default save" onclick="ConfirmOverride(1)">Yes</button>
                    <button type="button" id="btnNo" class="btn btn-default save" onclick="ConfirmOverride(0)" data-dismiss="modal">No</button>
                    <button type="button" id="btnCLOSE" class="btn btn-default save" style="display:none" onclick="Close_onclick()" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- ----- Request Type inherit status flow button popup---------------------------->


    <!-- -----Department in Working Hours button popup---------------------------->
    <div id="id15" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Working Hours</span>
                <span onclick="document.getElementById('id15').style.display='none'" class="close" title="Close Modal">&times;</span>
            </div>
            <div class="container">
                <div class="h-tabs">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Week Days</th>
                                    <th>Working Day</th>
                                    <th>From Time</th>
                                    <th>To Time</th>
                                    <th>Edit</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1-Monday</td>
                                    <td>
                                        <input type="checkbox" id="Checkbox8"></td>
                                    <td>3:30 AM</td>
                                    <td>4:30 AM</td>
                                    <td><i class="far fa-edit" aria-hidden="true" style="color: #1e88e5;"></i></td>
                                    <td>
                                        <button type="button" class="btn btn-default save" style="background-color: #343660; color: #fff;">Save</button></td>
                                </tr>

                                <tr>
                                    <td>1-Monday</td>
                                    <td>
                                        <input type="checkbox" id="Checkbox9"></td>
                                    <td>3:30 AM</td>
                                    <td>4:30 AM</td>
                                    <td><i class="far fa-edit" aria-hidden="true" style="color: #1e88e5;"></i></td>
                                    <td></td>
                                </tr>

                                <tr>
                                    <td>1-Monday</td>
                                    <td>
                                        <input type="checkbox" id="Checkbox10"></td>
                                    <td>3:30 AM</td>
                                    <td>4:30 AM</td>
                                    <td><i class="far fa-edit" aria-hidden="true" style="color: #1e88e5;"></i></td>
                                    <td></td>
                                </tr>

                                <tr>
                                    <td>2-Friday</td>
                                    <td>
                                        <input type="checkbox" id="Checkbox11"></td>
                                    <td>3:30 AM</td>
                                    <td>4:30 AM</td>
                                    <td><i class="far fa-edit" aria-hidden="true" style="color: #1e88e5;"></i></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- ----- Request Type Mapping button popup---------------------------->
    <div id="id09" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Request Type Mapping</span>
                <span onclick="document.getElementById('id09').style.display='none'" class="close" title="Close Modal">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type">Department</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select13" style="width: 219px;">
                            <option>Department</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type code">Request Type</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select14" style="width: 219px;">
                            <option>Request Type</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="h-tabs">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Request Type</th>
                                    <th>SubRequest Type</th>
                                    <th>Group Email</th>
                                    <th>Approved Required</th>
                                    <th>New Value</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Clarification</td>
                                    <td>Download Reports</td>
                                    <td></td>
                                    <td>
                                        <input type="checkbox" id="Checkbox12"></td>
                                    <td>
                                        <input type="checkbox" id="Checkbox13"></td>
                                </tr>

                                <tr>
                                    <td>Unable to View Data</td>
                                    <td>Database Crash</td>
                                    <td></td>
                                    <td>
                                        <input type="checkbox" id="Checkbox14"></td>
                                    <td>
                                        <input type="checkbox" id="Checkbox15"></td>
                                </tr>

                                <tr>
                                    <td>Unable to Edit</td>
                                    <td>Edit Bar is not Working</td>
                                    <td></td>
                                    <td>
                                        <input type="checkbox" id="Checkbox16"></td>
                                    <td>
                                        <input type="checkbox" id="Checkbox17"></td>
                                </tr>

                                <tr>
                                    <td>System Crashed</td>
                                    <td>Unable to Open</td>
                                    <td></td>
                                    <td>
                                        <input type="checkbox" id="Checkbox18"></td>
                                    <td>
                                        <input type="checkbox" id="Checkbox19"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- ----- Show History in status button popup---------------------------->
    <div id="id10" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Show History</span>
                <span onclick="document.getElementById('id10').style.display='none'" class="close" title="Close Modal">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type">Modified Field</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select15" style="width: 219px;">
                            <option>Department</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type code">Modified By</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select16" style="width: 219px;">
                            <option>Modified By</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="h-tabs">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Modified Field</th>
                                    <th>Modified Date</th>
                                    <th>Value</th>
                                    <th>Modified By</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>T_ACK</td>
                                    <td>25 Augast 2017    3:30 AM</td>
                                    <td>User Escalated</td>
                                    <td>Admin</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </div>


    <!-- ----- Shoe History in Priority button popup---------------------------->
    <div id="id11" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Show History</span>
                <span onclick="document.getElementById('id11').style.display='none'" class="close" title="Close Modal">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type">Modified Field</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select17" style="width: 219px;">
                            <option>Department</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type code">Modified By</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select18" style="width: 219px;">
                            <option>Modified By</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="h-tabs">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Modified Field</th>
                                    <th>Modified Date</th>
                                    <th>Value</th>
                                    <th>Modified By</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>T_ACK</td>
                                    <td>25 Augast 2017    3:30 AM</td>
                                    <td>UREGENT</td>
                                    <td>Admin</td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- ----- Shoe History in Sevirity button popup---------------------------->
    <div id="id12" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Show History</span>
                <span onclick="document.getElementById('id12').style.display='none'" class="close" title="Close Modal">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type">Modified Field</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select19" style="width: 219px;">
                            <option>Department</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type code">Modified By</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select20" style="width: 219px;">
                            <option>Modified By</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="h-tabs">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Modified Field</th>
                                    <th>Modified Date</th>
                                    <th>Value</th>
                                    <th>Modified By</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>T_ACK</td>
                                    <td>25 Augast 2017    3:30 AM</td>
                                    <td>UREGENT</td>
                                    <td>Admin</td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- ----- Show History in Email tab button popup---------------------------->
    <div id="id13" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Show History</span>
                <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close Modal">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type">Modified Field</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select21" style="width: 219px;">
                            <option>Department</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="request type code">Modified By</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="Select22" style="width: 219px;">
                            <option>Modified By</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                    </div>
                </div>
                <div class="h-tabs">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Modified Field</th>
                                    <th>Modified Date</th>
                                    <th>Value</th>
                                    <th>Modified By</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Subject</td>
                                    <td>25 Augast 2017    3:30 AM</td>
                                    <td>IR submitted [Project: PROJECT_NAME IR ID:
                                            <ir_id>
                                        ].</td>
                                    <td>Admin</td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- popup -->
    <!-- Modal -->
    <div class="modal fade filter-popup" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Modal Header</h4>
                </div>
                <div class="modal-body">
                    <p>Some text in the modal.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default save" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
    <!-- Bootstrap core JavaScript -->
    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/editor.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/timepicker.min.js"></script>
    <!-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>    
    <!-- <script src="../../General/CommonFunctions.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>  -->


    <script>
        //Added script by pradip on 18-06-2021
        function resizeSection() {
            var contentheight = $(window).height();
            $('#frmTagNavigation').css({ 'height': contentheight - 436 });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        }); //End Added by pradip

        $(function () {
            $('#timepicker1').timepicker();
            $('#timepicker2').timepicker();
        });

        $(function () {
            $(document).tooltip({
                position: {
                    my: "center bottom-20",
                    at: "center top",
                    using: function (position, feedback) {
                        $(this).css(position);
                        $(this)
                            .addClass(feedback.vertical);
                    }
                }
            });

        });

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

        $("[title]").hover(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });
    </script>

    <!-- End of time picker -->
    <script>
        $(function () {
            $("#datepicker").datepicker();
            $("#datepicker1").datepicker();
            $("#datepicker2").datepicker();
            $("#datepicker3").datepicker();
            $("#datepicker4").datepicker();
            $("#datepicker5").datepicker();
            //  $("#dtEffectivedate").datepicker(); //Commented script by pradip on 18-06-2021


        });
    </script>


    <script>
        var strPageName = "CRM_ApplySLA.aspx";
        $(document).ready(function () {
            $("#txtEditor").Editor();
            $("#txtEditor1").Editor();
            $("#txtEditor2").Editor();
            $("#txtEditor3").Editor();

                <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
                <%End If%>
        });
    </script>

    <script>


        var TabName = "";
        var Flag = "";
        function openCity1(evt, cityName) {
            // debugger;
            TabName = cityName;
            var i, tabcontent1, tablinks1;
            tabcontent1 = document.getElementsByClassName("tabcontent1");
            for (i = 0; i < tabcontent1.length; i++) {
                tabcontent1[i].style.display = "none";
            }
            tablinks1 = document.getElementsByClassName("tablinks1");
            for (i = 0; i < tablinks1.length; i++) {
                tablinks1[i].className = tablinks1[i].className.replace(" active", "");
            }

            document.getElementById(cityName).style.display = "block";

            PlotControls(cityName, Flag);

            evt.currentTarget.className += " active";
        }
        // Get the element with id="defaultOpen" and click on it
        //   document.getElementById("defaultOpen1").click();
        function RefreshGridDetails() {
            //debugger;

            var strResult, data;
            var GridParameter = {};
            var DivId;
            var DivSerach;
            DivId = "divApplySLA";
            DivSerach = "SearchSLA";
            cityName = "ApplySLA";

            var TypeDiv; var accordion;
            var intDivGridHeight;

            var intDivGridHeight, intDivGridListHeight
            intDivGridListHeight = parseInt(window.innerHeight);
            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
                //Commented script by pradip on 18-06-2021
                //$("#divScrollApplySLA").css('height', intDivGridListHeight - 300 + "px");

            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
                //Commented script by pradip on 18-06-2021
                // $("#divScrollApplySLA").css('height', intDivGridListHeight - 440 + "px");

            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                //Commented script by pradip on 18-06-2021
                //$("#divScrollApplySLA").css('height', intDivGridListHeight - 400 + "px");

            }
            else {
                //Commented script by pradip on 18-06-2021
                //$("#divScrollApplySLA").css('height', intDivGridListHeight - 280 + "px");

            }
            //datatables(DivId, DivSerach, intDivGridListHeight);
            if ($("#FilterEmployeeList").val() > 0) {
                datatables(DivId, DivSerach, intDivGridListHeight);
            }

            datatables("divApplySLA", "SearchSLA", 0)
            // setWidthDatatable(DivId);

            //if (document.getElementById("chkInternal").checked == false && document.getElementById('hdnSLADetailsID').value == "" || document.getElementById('hdnSLADetailsID').value == 0) {
            //    Customer_Onchange(document.getElementById("CboCustomer"))
            //}
        }

        function RefreshGrid(cityName, Flag) {
            //debugger
            var strResult, data;
            var GridParameter = {};
            DivId = "divApplySLA";
            DivSerach = "SearchSLA";
            cityName = "ApplySLA";

            GridParameter.cityName = "ApplySLA";

            if (Flag != "") {
                data = JSON.stringify({ GridParameter: GridParameter });

                strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
                var DivId;
                var DivSerach;
                //  alert(strResult.d);
                if (strResult.d != '') {

                    $("#divtblApplySLA").html("");
                    $("#divtblApplySLA").html(strResult.d);

                    $(".table-responsive:first table").addClass("table");


                }

            }
            RefreshGridDetails();
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
        function datatableMainPage(divID, height) {
            // $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' > table').DataTable({
                responsive: true,
                "pageLength": 3,
                // scrollY: height - 80 + 'px',
                //scrollX: true,
                pagingType: "simple_numbers",

            });
            $("#" + divID + " .dataTables_length").parent().css("display", "none");

            $("#" + divID + " .dataTables_scrollHeadInner table th:first-child").css("width", "50%");
            $("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(2)").css("width", "50%");
            $("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(2)").css("text-align", "center");
            $("#" + divID + " .dataTables_scrollHeadInner table").css("width", "98.3%");
            $("#" + divID + " .dataTables_scrollBody table").css("width", "98.3%");
            $("#" + divID + " .dataTables_scrollBody table td:first-child").css("width", "50%");
            $("#" + divID + " .dataTables_scrollBody table td:nth-child(2)").css("width", "50%");

            $('#' + divID).css("visibility", "");

        }

        function datatables(divID, txtBoxID, height) {
            var tableSelector = "";
            var targetTable = null;

            // Case 1: Auto-generated DataTables table (no records)
            if ($("#DataTables_Table_0").length > 0) {
                tableSelector = "#DataTables_Table_0";
                targetTable = $("#DataTables_Table_0");
            }
            // Case 2: Dynamic table under div
            else if ($("#" + divID + " table").length > 0) {
                tableSelector = "#" + divID + " table";
                targetTable = $("#" + divID + " table");
            }
            else {
                console.warn("No table found for divID: " + divID);
                return; // stop here, nothing to bind
            }

            // Check if table has proper structure before initializing DataTables
            if (targetTable.length === 0) {
                console.warn("Target table not found");
                return;
            }

            // Check if table has thead and tbody
            var hasThead = targetTable.find('thead').length > 0;
            var hasTbody = targetTable.find('tbody').length > 0;
            var hasRows = targetTable.find('tbody tr').length > 0;

            // If no proper table structure, don't initialize DataTables
            if (!hasThead) {
                console.warn("Table missing thead, skipping DataTables initialization");
                return;
            }

            // Check column count consistency
            var headerColumns = targetTable.find('thead tr:first th').length;
            var dataColumns = 0;
            if (hasRows) {
                dataColumns = targetTable.find('tbody tr:first td').length;
                if (headerColumns !== dataColumns) {
                    console.warn("Column count mismatch: Header has " + headerColumns + " columns, but data has " + dataColumns + " columns. Skipping DataTables initialization.");
                    return;
                }
            }

            // Destroy existing DataTable instance if already initialized
            if ($.fn.DataTable.isDataTable(tableSelector)) {
                $(tableSelector).DataTable().clear().destroy();
            }

            // Apply styling
            $(tableSelector).removeClass("clsGridTable");
            $(tableSelector).addClass("table table-bordered table-stripped");

            try {
                // Initialize DataTable with error handling
                var table = $(tableSelector).DataTable({
                    "columnDefs": [{
                        "orderable": false,
                    }],
                    responsive: true,
                    pageLength: 3,
                    pagingType: "simple_numbers",
                    // Add empty data message if no rows
                    language: {
                        emptyTable: "There are no items to show in this view."
                    },
                    // Handle empty tables gracefully
                    data: hasRows ? null : []
                });

                $("#" + divID + " .dataTables_length").parent().css("display", "none");

                // Search box binding
                if (txtBoxID && $("#" + txtBoxID).length > 0) {
                    $("#" + txtBoxID).off("keyup change").on("keyup change", function () {
                        table.search($(this).val()).draw();
                    });

                    if ($("#" + txtBoxID).val() != "") {
                        table.search($("#" + txtBoxID).val()).draw();
                    }
                }
            } catch (error) {
                console.error("Error initializing DataTable:", error);
                // If DataTables fails, at least ensure the table is visible
                $(tableSelector).show();
                // Add a simple message if table is empty
                if (!hasRows) {
                    var emptyMessage = '<tr><td colspan="' + headerColumns + '" style="text-align: center; padding: 20px;">There are no items to show in this view.</td></tr>';
                    if (targetTable.find('tbody').length === 0) {
                        targetTable.append('<tbody></tbody>');
                    }
                    targetTable.find('tbody').html(emptyMessage);
                }
            }
        }


        function setWidthDatatable(divID) {

            var tblTotal = document.getElementById(divID).getElementsByClassName('dataTable')[0];
            var tblDetails = document.getElementById(divID).getElementsByClassName('dataTable')[1];
            //if (WhichBrowser() != 'FF') {

            // console.log(tblDetails) //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            if (tblDetails != null) {
                tblTotal.style.width = tblDetails.offsetWidth + 'px';
                width = tblDetails.offsetWidth + 'px';
                //   alert(width);
            }
            // }
            var FooterTableRow = tblTotal.rows[0];
            var HeaderRow = tblDetails.rows[0];
            for (var i = 0; i < tblTotal.rows[0].cells.length; i++) {
                if (FooterTableRow.cells[i] != null)
                    if (HeaderRow.cells[i] != null) {
                        FooterTableRow.cells[i].style.width = HeaderRow.cells[i].offsetWidth + 'px';
                    }
            }
        }
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
                    $(".loadingoverlay", parent.document).css("display", "none");
                    //Stop();
                },
                error: function (xhr, status, error) {
                    //Stop();
                    //StopAjaxLoader("body");
                    $(".loadingoverlay", parent.document).css("display", "none");
                    // console.log(xhr.responseText); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

            return AjaxResult;
        }


        function isBlank(val) {
            if (val == null) { return true; }
            for (var i = 0; i < val.length; i++) {
                if ((val.charAt(i) != ' ') && (val.charAt(i) != "\t") && (val.charAt(i) != "\n") && (val.charAt(i) != "\r")) { return false; }
            }
            return true;
        }
        function isNumeric(val) { return (parseFloat(val, 10) == (val * 1)); }

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

        function ValidateApplySLA() {
            var strmsg = "";
            var errorMsg = "<ul>"
            var checkvalue = 0;
            // alert($("#CboDepartment").val());
            if ($("#CboTemplateMaster").val() == "0") {
                strmsg = '-SLA Template should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;

                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                $("#CboTemplateMaster").focus();
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            }

            if ($("#CboCustomer").val() == "") {
                strmsg = '- Customer should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }

            if ($("#CboDepartment").val() == "Select Department" || $("#CboDepartment").val() == "" || $("#CboDepartment").val() == 0) {
                strmsg = '- Department should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                var hasFocus = $('#CboTemplateMaster').is(':focus');
                if (hasFocus) {
                }
                else {
                    $("#CboDepartment").focus();
                }
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            }

            if ($("#CboRequestType").val() == "Select Request Type" || $("#CboRequestType").val() == "" || $("#CboRequestType").val() == "RequestType" || $("#CboRequestType").val() == 0) {
                strmsg = '- Request Type should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;

                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                if ($('#CboTemplateMaster').is(':focus') == true || $('#CboDepartment').is(':focus') == true) {

                }
                else {
                    $("#CboRequestType").focus();
                }
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            }

            if ($("#CboSubRequestType").val() == "Select Sub Request Type" || $("#CboSubRequestType").val() == "" || $("#CboSubRequestType").val() == "SubRequestType" || $("#CboSubRequestType").val() == 0) {
                strmsg = '- Sub Request Type should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;

                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                if ($('#CboTemplateMaster').is(':focus') == true || $('#CboDepartment').is(':focus') == true || $('#CboRequestType').is(':focus') == true) {

                }
                else {
                    $("#CboSubRequestType").focus();
                }
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            }

            if ($("#CboType").val() != "") {
                if (document.getElementById('hdnSLADetailsID').value == "0") {

                    data = JSON.stringify({ Type: $("#CboType").val(), TemplateID: $("#CboTemplateMaster").val(), SLAID: "0" });
                    var strResult1 = AJAXCallWithResult("CRM_ApplySLA.aspx/IsDuplicateSLAApplied", data, false);
                    //alert(EditRequestTypeID);
                    //alert(strResult1.d);
                    if (strResult1.d == "0") {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify('Request Type is already exists', 'error');
                        //  strmsg = strmsg + 'Request Type already exists';
                        //  strMsg += "<li>- Norm is not defined on Severity Or Priority </li>";
                        strmsg = '- Norm is not defined on Severity Or Priority for Template.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;

                    }
                }
            }


            if ($("#dtEffectivedate").val() != "") {
                var url = 'CRM_ApplySLA.aspx/CheckEffectiveDateValidation';
                //  alert($('#dtEffectivedate').val());
                var data = JSON.stringify({ Effectivedate: $('#dtEffectivedate').val() });

                $.ajax({
                    type: "POST",
                    url: url,
                    data: data,
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    timeout: 180000,
                    success: function (result) {
                        // alert(result.d);
                        if (result.d == 1) {
                            checkvalue = 1;
                        }

                    },

                });
            }




            //var url1 = 'CRM_ApplySLA.aspx/ChkNormValidation';
            ////  alert($('#dtEffectivedate').val());

            //var CboTemplateMaster = $("#CboTemplateMaster").val();
            //var CboTemplateMasterOld = $("#CboTemplateMasterOld").val();
            //var data1 = JSON.stringify({ OldTemplateID: $("#CboTemplateMasterOld").val(), NewTemplateID: CboTemplateMaster });
            //    //  alert($('#dtEffectivedate').val());
            //    $.ajax({
            //        type: "POST",
            //        url: url1,
            //        data: data1,
            //        dataType: "json",
            //        contentType: "application/json",
            //        async: false,
            //        timeout: 180000,
            //        success: function (result1) {


            //            //if ($("#txtSendAlert").val() > result.d)
            //            //{
            //            //    strmsg = '- Please alert Send Alert norm less than or equal to min Norm Defined';
            //            //    errorMsg += "<li>" + strmsg + "</li>";
            //            //    checkvalue = 1;
            //            //}

            //            if ($("#txtSendReminder").val() > result1.d) {
            //                strmsg = '- Please alert Send Reminder norm less than or equal to min Norm Defined';
            //                errorMsg += "<li>" + strmsg + "</li>";
            //                checkvalue = 1;
            //            }

            //            //if ($("#txtEscalateLevel1").val() > result.d) {
            //            //    strmsg = '- Please alert Escalation Level 1 norm less than or equal to min Norm Defined';
            //            //    errorMsg += "<li>" + strmsg + "</li>";
            //            //    checkvalue = 1;
            //            //}

            //            //if ($("#txtEscalateLevel2").val() > result.d) {
            //            //    strmsg = '- Please alert Escalation Level 2 norm less than or equal to min Norm Defined';
            //            //    errorMsg += "<li>" + strmsg + "</li>";
            //            //    checkvalue = 1;
            //            //}

            //            //if ($("#txtEscalateLevel3").val() > result.d) {
            //            //    strmsg = '- Please alert Escalation Level 3 norm less than or equal to min Norm Defined';
            //            //    errorMsg += "<li>" + strmsg + "</li>";
            //            //    checkvalue = 1;
            //            //}


            //        },

            //    });
            //  if ($("#chkSendAlert").is(':checked')) {
            //    IsSendAlert = 1;
            //}
            //else {
            //    IsSendAlert = 0;
            //}

            //if ($("#chkSendReminder").is(':checked')) {
            //    IsSendReminder = 1;
            //}
            //else {
            //    IsSendReminder = 0;
            //}

            //if ($("#ChkEscalateLevel1").is(':checked')) {
            //    IsEscalateLevel1 = 1;
            //}
            //else {
            //    IsEscalateLevel1 = 0;
            //}

            //if ($("#ChkEscalateLevel2").is(':checked')) {
            //    IsEscalateLevel2 = 1;
            //}
            //else {
            //    IsEscalateLevel2 = 0;
            //}


            //if ($("#EscalateLevel3").is(':checked')) {
            //    IsEscalateLevel3 = 1;
            //}
            //else {
            //    IsEscalateLevel3 = 0;
            //}


            //if ($("#EscalateLevel4").is(':checked')) {
            //    IsEscalateLevel4 = 1;
            //}
            //else {
            //    IsEscalateLevel4 = 0;
            //}


            if ($("#dtEffectivedate").val() != "") {
                if (checkvalue == 1) {
                    strmsg = '- Effective Date should be Future Date.'
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }
            }

            if ($("#chkSendReminder").is(':checked')) {
                //Added By Usha Pandit On 11.07.2019 For restricting non numeric values
                if ($("#txtSendReminder").val() != "") {
                    if (RestrictNonNumeric(document.getElementById("txtSendReminder")) == true) {
                        strmsg = '- Please enter only positive numeric value for Send Reminder Norm.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    //End Of Added By Usha Pandit On 11.07.2019 For restricting non numeric values
                    if ($("#txtSendReminder").val() <= 0) {
                        //if (checkvalue == 1)
                        //{
                        strmsg = '- Norm for Send Reminder should be greater than 0.00.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                        // }

                    }
                }
            }
            if ($("#chkSendAlert").is(':checked')) {
                //Added By Usha Pandit On 11.07.2019 For restricting non numeric values
                if ($("#txtSendAlert").val() != "") {
                    if (RestrictNonNumeric(document.getElementById("txtSendAlert")) == true) {
                        strmsg = '- Please enter only positive numeric value for Send Alert Norm.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    //End Of Added By Usha Pandit On 11.07.2019 For restricting non numeric values
                    if ($("#txtSendAlert").val() <= 0) {
                        //if (checkvalue == 1)
                        //{
                        strmsg = '- Norm for Send Alert should be greater than 0.00.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                        //}
                    }
                }
            }

            if ($("#ChkEscalateLevel1").is(':checked')) {
                //Added By Usha Pandit On 11.07.2019 For restricting non numeric values
                if ($("#txtSendAlert").val() != "") {
                    if (RestrictNonNumeric(document.getElementById("txtEscalateLevel1")) == true) {
                        strmsg = '- Please enter only positive numeric value for Escalation Level 1 Norm.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    //End Of Added By Usha Pandit On 11.07.2019 For restricting non numeric values

                    if ($("#txtEscalateLevel1").val() <= 0) {
                        //if (checkvalue == 1)
                        //{
                        strmsg = '- Norm for Escalation Level 1 should be greater than 0.00.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                        //  }
                    }
                }
            }

            if ($("#ChkEscalateLevel2").is(':checked')) {
                //Added By Usha Pandit On 11.07.2019 For restricting non numeric values
                if ($("#txtEscalateLevel2").val() != "") {
                    if (RestrictNonNumeric(document.getElementById("txtEscalateLevel2")) == true) {
                        strmsg = '- Please enter only positive numeric value for Escalation Level 2 Norm.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    //End Of Added By Usha Pandit On 11.07.2019 For restricting non numeric values

                    if ($("#txtEscalateLevel2").val() <= 0) {
                        //if (checkvalue == 1)
                        //{
                        strmsg = '- Norm for Escalation Level 2 should be greater than 0.00.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                        // }
                    }
                }
            }

            if ($("#EscalateLevel3").is(':checked')) {
                //Added By Usha Pandit On 11.07.2019 For restricting non numeric values
                if ($("#txtEscalateLevel3").val() != "") {
                    if (RestrictNonNumeric(document.getElementById("txtEscalateLevel3")) == true) {
                        strmsg = '- Please enter only positive numeric value for Escalation Level 3 Norm.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    //End Of Added By Usha Pandit On 11.07.2019 For restricting non numeric values

                    if ($("#txtEscalateLevel3").val() <= 0) {
                        // if (checkvalue == 1)
                        //{
                        strmsg = '- Norm for Escalation Level 3 should be greater than 0.00.'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                        // }
                    }
                }
            }
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error');
                checkvalue = 1;
            }

            return checkvalue;

        }
        function Type_Onchange(obj) { }
        function CheckInternal(obj) {
            var IsInternal;
            // debugger;
            if ($("#chkInternal").is(':checked')) {
                IsInternal = 1;

            }
            else {
                IsInternal = 0;
                Customer_Onchange();
                //Department_Onchange();

            }
            if (IsInternal == 1) {
                $("#divCboCustomer").css("display", "none");
                CboCustomer = "0";
                document.getElementById('hdnCustomerFlag').value = "1";
                $('#CboRequestType').find('option').remove().end().append('<option value="RequestType">Select Request Type</option>').val('RequestType');
                $('#CboSubRequestType').find('option').remove().end().append('<option value="SubRequestType">Select Sub Request Type</option>').val('SubRequestType');
                // setTimeout(function () { document.getElementById('CboCustomer').onchange(); }, 1000);
                Customer_Onchange();
                $("#CboCustomer").val("0");
                //$('#CboCustomer').find('option').remove().end().append('<option value="Customer">Select Customer</option>').val('Customer');
            }
            else {
                $("#divCboCustomer").css("display", "block");
                //setTimeout(function () { document.getElementById('CboCustomer').onchange(); }, 1000);

                $("#CboDepartment").val("");
                $("#CboRequestType").val("");
                $("#CboSubRequestType").val("");


                //$('#CboCustomer').find('option').remove().end().append('<option value="Customer">Select Customer</option>').val('Customer');
                //$('#CboDepartment').find('option').remove().end().append('<option value="Department">Select Department</option>').val('Department');
                $('#CboRequestType').find('option').remove().end().append('<option value="RequestType">Select Request Type</option>').val('RequestType');
                $('#CboSubRequestType').find('option').remove().end().append('<option value="SubRequestType">Select Sub Request Type</option>').val('SubRequestType');
                Customer_Onchange();

            }

        }

        function ApplySLA() {

            var strResult, data;
            var CboCustomer;
            var SLAID;
            //debugger;
            if (document.getElementById('hdnSLADetailsID') != null) {
                if (document.getElementById('hdnSLADetailsID').value == 0) {
                    SLAID = 0;
                }
                else {
                    SLAID = document.getElementById('hdnSLADetailsID').value;
                }
            }


            if (ValidateApplySLA() == 0) {

                var CboTemplateMaster = $("#CboTemplateMaster").val();
                var CboTemplateMasterOld = $("#CboTemplateMasterOld").val();
                var CboDepartment = $("#CboDepartment").val();
                var CboRequestType = $("#CboRequestType").val();
                var CboSubRequestType = $("#CboSubRequestType").val();
                var dtEffectivedate = $("#dtEffectivedate").val();
                var TimeZone = $("#CboTimeZone").val();
                var Type = $("#CboType").val();

                var IsInternal;
                var IsSendAlert;
                var IsSendReminder;
                var IsEscalateLevel1;
                var IsEscalateLevel2;
                var IsEscalateLevel3;
                var IsEscalateLevel4;
                if ($("#chkInternal").is(':checked')) {
                    IsInternal = 1;
                }
                else {
                    IsInternal = 0;
                }


                if (IsInternal == 1) {
                    // $("#divCboCustomer").css("display", "none");
                    CboCustomer = "0";
                }
                else {

                    CboCustomer = $("#CboCustomer").val();
                }
                // alert($("#CboTemplateMasterOld").val());
                if (CboTemplateMasterOld == "") {
                    CboTemplateMasterOld = "0";
                }
                var Confirm = "0";

                if (CboTemplateMasterOld != "0") {
                    if (CboTemplateMasterOld != CboTemplateMaster) {
                        var url1 = 'CRM_ApplySLA.aspx/CheckTemplateOverride';
                        var data1 = JSON.stringify({ OldTemplateID: CboTemplateMasterOld, NewTemplateID: CboTemplateMaster, CustomerID: CboCustomer, DepartmentID: CboDepartment, RequestTypeID: CboRequestType, SubRequestTypeID: CboSubRequestType, SLAAppliedOn: Type, SLAID: SLAID });
                        //  alert(data1);
                        $.ajax({
                            type: "POST",
                            url: url1,
                            data: data1,
                            dataType: "json",
                            contentType: "application/json",
                            async: false,
                            timeout: 180000,
                            success: function (result1) {
                                //    alert(result1.d);
                                //  debugger;
                                if (result1.d == 0) {
                                    // alert(result1.d);
                                    // $("#myOverride").modal("show");
                                    document.getElementById('myOverride').style.display = 'block';
                                }//Added By Dipali V On 8th July 2019 for override functionality
                                else if (result1.d == 1) {
                                    // alert(result1.d);
                                    // $("#myOverride").modal("show");
                                    document.getElementById('myOverride').style.display = 'block';

                                    $("#OverrideAlert").html("");
                                    $("#OverrideAlert").append("<span>" + " You can not override the template." + "</span>");
                                    $("#btnConfirm").hide();
                                    $("#btnNo").hide();
                                    $("#btnCLOSE").show();


                                    // ConfirmOverride(Confirm);
                                }//End of Added By Dipali V On 8th July 2019 for override functionality
                                else {

                                    if (result1.d == 0) {
                                        ConfirmOverride(Confirm);
                                    }
                                }

                            },


                            error: function (xhr, status, error) {
                                setTimeout(function () { RemoveFrameLoader(); }, 1000);
                                // console.log(xhr.responseText); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            },
                        });
                    }
                    else {
                        //alert('111')
                        ConfirmOverride(Confirm);
                    }
                }
                else {
                    //   alert(Confirm)
                    ConfirmOverride(Confirm);
                }

            }
        }



        function AddApplySLA() {
            // debugger;
            $("#divtblApplySLA").css("display", "none");
            $("#divApplySLATab").css("display", "none");
            // $("#RequestPaging").css("display", "none");
            //  $("#divTypeBottom").css("margin-top", "0px");
            $("#idSLADetailsTab").css("display", "none");
            $("#liConfigureUserTab").css("display", "none");
            $("#CboTemplateMaster").val("");
            $("#CboDepartment").val("");
            $("#CboRequestType").val("");
            $("#CboSubRequestType").val("");
            $("#dtEffectivedate").val("");
            $("#CboTimeZone").val("");
            $("#CboType").val("Priority");

            $("#CboCustomer").val("Select Customer");
            if (document.getElementById('CboTemplateMaster') != null) {
                document.getElementById('CboTemplateMaster').disabled = false;
                document.getElementById('CboDepartment').disabled = false;
                document.getElementById('CboRequestType').disabled = false;
                document.getElementById('CboSubRequestType').disabled = false;
                document.getElementById('dtEffectivedate').disabled = false;
                document.getElementById('CboTimeZone').disabled = false;
                document.getElementById('CboCustomer').disabled = false;
                document.getElementById('CboType').disabled = false;
                document.getElementById('chkInternal').disabled = false;
                $("#chkInternal").prop('checked', false);

                $("#txtSendAlert").val("");
                $("#CboSendAlert").val("Days");
                $("#txtSendReminder").val("");
                $("#CboSendReminder").val("Days");
                $("#txtEscalateLevel1").val("");
                $("#CboEscalateLevel1").val("Days");
                $("#txtEscalateLevel2").val("");
                $("#CboEscalateLevel2").val("Days");
                $("#txtEscalateLevel3").val("");
                $("#CboEscalateLevel3").val("Days");
            }

            strFlag = "ApplySLA";
            SLADetailsID = "0";
            document.getElementById('hdnSLADetailsID').value = "0";
            document.getElementById('hdnSLATemplateID').value = "0";
            document.getElementById('hdnSLAAppliedOn').value = "0";
            SLATemplateID = document.getElementById('hdnSLATemplateID').value;
            SLAAppliedOn = document.getElementById('hdnSLAAppliedOn').value;

            //Added By Usha Pandit On 16.04.2020 For getting SLA Applied On type           
            SLAAppliedOn = globalSLAAppliedOn
            //End Of Added By Usha Pandit On 16.04.2020 For getting SLA Applied On type

            data = JSON.stringify({ SLADetailsID: SLADetailsID, Flag: strFlag, SLATemplateID: SLATemplateID, Type: SLAAppliedOn });
            // alert(data);
            strResult = AJAXCallWithResult(strPageName + "/GetSLADetails", data, false);
            $("#divTabs").html("");
            $("#divTabs").html(strResult.d);
            $("#idSLADetailsTab").css("display", "none");
            $("#liConfigureUserTab").css("display", "none");
            $("#exTab2").css("margin-top", "36px");
            //$("#exTab2 li").removeClass('active');
            //$("#DivHorizontal").addClass('active');
            RefreshGridDetails();

            $("[title]").click(function () {
                $('.ui-tooltip').fadeOut('fast', function () {
                    $('.ui-tooltip').remove();
                });
            });
            $(document).tooltip({
                position: {
                    my: "center bottom-20",
                    at: "center top",
                    using: function (position, feedback) {
                        $(this).css(position);
                        $(this)
                            .addClass(feedback.vertical);
                    }
                }
            });

        }
        function Cancel_ApplySLA() {

            $("#divtblApplySLA").css("display", "block");
            $("#divApplySLATab").css("display", "flex");
            $("#idSLADetailsTab").css("display", "block");
            $("#idSLADetailsTab").css("display", "none");
            $("#liConfigureUserTab").css("display", "none");
            //$("#DivHorizontal").addClass('active');
            document.getElementById('chkSendReminder').checked = false;
            document.getElementById('chkSendAlert').checked = false;
            document.getElementById('ChkEscalateLevel1').checked = false;
            document.getElementById('ChkEscalateLevel2').checked = false;
            document.getElementById('EscalateLevel3').checked = false;
            $("#divCboCustomer").css("display", "");
            $("#CboTemplateMaster").val("0");
            $("#CboCustomer").val("0");
            $("#CboDepartment").html("<option value=0>Select Department</option>")
            $("#CboRequestType").html("<option value=0>Select Request Type</option>")
            $("#CboSubRequestType").html("<option value=0>Select Sub Request Type</option>")
            $("#dtEffectivedate").val("");
            $("#CboTimeZone").val("Select Timezone");
            $("#CboType").val("Priority");
            $(".clscbo").attr("disabled", "disabled");
            document.getElementById('CboTemplateMaster').disabled = false;
            document.getElementById('CboDepartment').disabled = false;
            document.getElementById('CboRequestType').disabled = false;
            document.getElementById('CboSubRequestType').disabled = false;
            document.getElementById('dtEffectivedate').disabled = false;
            document.getElementById('CboTimeZone').disabled = false;
            if (document.getElementById('CboCustomer') != null)
                document.getElementById('CboCustomer').disabled = false;
            document.getElementById('CboType').disabled = false;
            document.getElementById('chkInternal').disabled = false;
            $("#chkInternal").prop('checked', false);

            $("#txtSendAlert").val("");
            $("#CboSendAlert").val("Days");
            $("#txtSendReminder").val("");
            $("#CboSendReminder").val("Days");
            $("#txtEscalateLevel1").val("");
            $("#CboEscalateLevel1").val("Days");
            $("#txtEscalateLevel2").val("");
            $("#CboEscalateLevel2").val("Days");
            $("#txtEscalateLevel3").val("");
            $("#CboEscalateLevel3").val("Days");
            //$("#txtChkEscalateLevel4").val("");
            //$("#CboChkEscalateLevel4").val("");


            RefreshGrid('Type', "Flag");
            $("#divScrollApplySLA").scrollTop("0px");
        }

    </script>
    <script>

        function openCity(evt, cityName) {
            var i, tabcontent3, tablinks3;
            tabcontent3 = document.getElementsByClassName("tabcontent3");
            for (i = 0; i < tabcontent3.length; i++) {
                tabcontent3[i].style.display = "none";
            }
            tablinks3 = document.getElementsByClassName("tablinks3");
            for (i = 0; i < tablinks3.length; i++) {
                tablinks3[i].className = tablinks3[i].className.replace(" active", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";
        }
        // Get the element with id="defaultOpen" and click on it
        //document.getElementById("defaultOpen3").click();
    </script>

    <script>
        // Get the modal for Request Type button popup
        $('.modal').draggable();
        var modal = document.getElementById('id09');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

    <script>
        // Get the modal for Status in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id10');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script>
        // Get the modal for Priority in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id11');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script>
        // Get the modal for Sevirity in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id12');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script>
        // Get the modal for Sevirity in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id13');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script>
        // Get the modal for Sevirity in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id14');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

    <script>
        // Get the modal for Sevirity in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id15');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        $(document).ready(function () {
            // debugger;
           // $('[data-toggle="tooltip"]').tooltip();
            RefreshGridDetails();
        });

        //Commented & Added By Dipali V on 25th Dec 2020 For Jquery Version Issues
   // $(window).load(function () {
        $(window).on("load", function () {
            //End of Commented & Added By Dipali V on 25th Dec 2020 For Jquery Version Issues

            RemoveFrameLoader();
        });

    </script>
    <script type="text/javascript">

        $(".answer").hide();
        $(".clcd").click(function () {
            if ($(this).is(":checked")) {
                $(".answer").show();
            } else {
                $(".answer").hide();
            }
        });


        function Customer_Onchange(obj) {
           // debugger;
            if ($("#chkInternal").is(':checked')) {
                // $("#CboCustomer").val("");
                //Commented And Added By Usha Pandit On 15.02.2021 For passing/checking correct customer id
                //$("#CboCustomer").val(1);
                $("#CboCustomer").val(0);
                //End Of Added By Usha Pandit On 15.02.2021 For passing/checking correct customer id
            }
            //else {
            //   // var CustomerID = $("#CboCustomer").val();
            //    //$("#CboCustomer").val(CustomerID);
            //}

          
            //Commented And Added By Usha Pandit On 15.02.2021 For passing/checking correct customer id
            //if ($("#CboCustomer").val() == "1" || $("#CboCustomer").val() == undefined) {
            //    CustomerID = "0";
            //}
            if ($("#CboCustomer").val() == "0" || $("#CboCustomer").val() == undefined || $("#CboCustomer").val() == null) {
                CustomerID = "0";
            }
            //End Of Added By Usha Pandit On 15.02.2021 For passing/checking correct customer id
            else {

                CustomerID = $("#CboCustomer").val();
            }
            var url = "CRM_ApplySLA.aspx/GetDepartment"
            data = JSON.stringify({ CustomerID: CustomerID });

            CustomAJAXCall(url, data, BindDropDownDepartment);

        }

        function Department_Onchange(obj) {
            // ClearSpan('DcboDepartmentSQL', 'spanDepartment')
            var url = "CRM_ApplySLA.aspx/GetRequestType"
            DepartmentID = obj.value;
            if (DepartmentID != 0) {//Added By Dipali V On 3rd July 2019 for Dropdown filter issue
                if (document.getElementById("chkInternal").checked == false) {
                    if (CustomerID == "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please select customer.", 'error');
                        return;
                    }
                }
                //CustomerID = document.getElementById('hdnCustomerID').value;
                //EmployeeID = document.getElementById('hdnEmployeeID').value;
                //alert(CustomerID);
                data = JSON.stringify({ TypeID: DepartmentID, WhichList: 'RequestType', RequestTypeID: '', CustomerID: CustomerID, SLAAppliedON: "" });
                //alert(data);
                CustomAJAXCall(url, data, BindDropDownRequestType);
            } else {
                //alert();
                ////Added By Dipali V On 3rd July 2019 for Dropdown filter issue
                   var objCbo = document.getElementById("CboSubRequestType");
                objCbo.innerHTML = "<option value=0>Select Sub Request Type</option>";

                   var objCbo1 = document.getElementById("CboRequestType");
                  objCbo1.innerHTML = "<option value=0>Select Request Type</option>";
                ////End of Added By Dipali V On 3rd July 2019 for Dropdown filter issue

            }
        }

        function BindDropDownDepartment(result) {

            var strArray = String(result.d).split("|")

            var objDepartmentID = document.getElementById('CboDepartment');
            var i = 0;

            //document.getElementById('frmRequest').innerHTML = ""
            //document.getElementById('frmRequest').innerHTML = strArray[2];


            // alert(objCbo.value);

            var objCbo = document.getElementById("CboDepartment");
            objCbo.innerHTML = "<option value=0>Select Department</option>";
            $.each(JSON.parse(strArray[0]), function (id, obj) {
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.Department;
                objOption.value = obj.DepartmentID;
            });

            //   alert(objCbo.options.length)
            $("#CboRequestType").val("");
            $("#CboSubRequestType").val("");
            $('#CboRequestType').find('option').remove().end().append('<option value="RequestType">Select Request Type</option>').val('RequestType');
            $('#CboSubRequestType').find('option').remove().end().append('<option value="SubRequestType">Select Sub Request Type</option>').val('SubRequestType');
        }
        function BindDropDownRequestType(result) {

            var strArray = String(result.d).split("|")

            var objDepartmentID = document.getElementById('CboRequestType');
            var i = 0;

            //document.getElementById('frmRequest').innerHTML = ""
            //document.getElementById('frmRequest').innerHTML = strArray[2];


            // alert(objCbo.value);

            var objCbo = document.getElementById("CboRequestType");
            objCbo.innerHTML = "<option value=0>Select Request Type</option>";
            $.each(JSON.parse(strArray[0]), function (id, obj) {
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.RequestType;
                objOption.value = obj.RequestTypeID;
            });
            //Added by Usha Pandit On 19.07.2019 As Old Sub Request Types getting displayed even if request type is not selected
            $('#CboSubRequestType').find('option').remove().end().append('<option value="SubRequestType">Select Sub Request Type</option>').val('SubRequestType');
            //End Of Added by Usha Pandit On 19.07.2019 For  Sub Request Type not getting refreshed even if request type is not selected

            //   alert(objCbo.options.length)

        }
        function insBlankOpt(objCbo) {
            objOption = new Option();

            objOption.text = "";
            objOption.value = "";

            if (WhichBrowser() == 'IE')
                objCbo.add(objOption);
            else
                objCbo.add(objOption, null);
        }

        function RequestType_Onchange(obj) {

            var url = "CRM_ApplySLA.aspx/GetRequestType"
            RequestTypeID = obj.value;
            //     alert(RequestTypeID);
            if ($("#CboDepartment").val() != 0 && RequestTypeID != 0) {
                //CustomerID = document.getElementById('hdnCustomerID').value;
                //EmployeeID = document.getElementById('hdnEmployeeID').value;
                var CboType = $("#CboType").val();
                data = JSON.stringify({ TypeID: DepartmentID, WhichList: 'SubRequestType', RequestTypeID: RequestTypeID, CustomerID: CustomerID, SLAAppliedON: CboType });
                CustomAJAXCall(url, data, BindDropdownSubRequestType);
            }
            else {
                ////Added By Dipali V On 3rd July 2019 for Dropdown filter issue
                
            var objCbo = document.getElementById("CboSubRequestType");
            objCbo.innerHTML = "<option value=0>Select Sub Request Type</option>";
                ////End of Added By Dipali V On 3rd July 2019 for Dropdown filter issue

            }
        }

        function BindDropdownSubRequestType(result) {

            // alert(result.d);
            var strArray = String(result.d).split("|")
            var objCbo = document.getElementById("CboSubRequestType");
            var i = 0;
            objCbo.innerHTML = "";



            var objCbo = document.getElementById("CboSubRequestType");
            objCbo.innerHTML = "<option value=0>Select Sub Request Type</option>";

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.SubRequestType
                objOption.value = obj.SubRequestTypeID;;

            });
        }



        function CustomAJAXCall(url, data, method) {
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                timeout: 180000,
                async: false,
                success: function (result) {
                    method(result);
                    //  Stop();
                },
                error: function (xhr, status, error) {
                    // Stop();
                    //  StopAjaxLoader("body");
                    // console.log(xhr.responseText); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

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
        function SubRequestType_Onchange() {
        }

        function Template_Onchange() { }

        function OpenTabs(evt, cityName) {

            var i, tabcontent4, tablinks4;

            if (cityName == "ApplySLA") {
                PlotSubtab1("ApplySLA");

            }
            else if (cityName == "ConfigureGropus") {
                PlotSubtab1("ConfigureGropus");

            }
            else if (cityName == "SLADetails") {
                PlotSubtab1("SLADetails");

            }


        }


        function ShowHideHorizontalDiv() {
            if ($("#DivHorizontal").hasClass("clsShowHorizontalDiv")) {
                $("#DivHorizontal").removeClass("clsShowHorizontalDiv");

            }
            $("#DivHorizontal").addClass("clsHideHorizontalDiv");
        }

        var strFlag = "";
        var SLADetailsID = 0;
        function PlotSubtab1(Flag) {

            //debugger;
            var strResult1, data1;
            strFlag = Flag;
            // alert(SLAAppliedOn);
            // alert(document.getElementById('hdnSLADetailsID').value);
            SLADetailsID = document.getElementById('hdnSLADetailsID').value;
            //SLATemplateID = document.getElementById('hdnSLATemplateID').value;
            SLAAppliedOn = document.getElementById('hdnSLAAppliedOn').value;

            if ($("#CboTemplateMaster").val() != undefined) {
                SLATemplateID = $("#CboTemplateMaster").val();
            }
             //alert(SLATemplateID);
            //if (document.getElementById('hdnSLATemplateID') != null) {
            //    SLATemplateID = document.getElementById('hdnSLATemplateID').value;
            //}
            //else {
            //    SLATemplateID = "0";
            //}
            //if (SLAAppliedOn == "") {
            //    if (document.getElementById('hdnSLAAppliedOn') != null) {
            //        SLAAppliedOn = document.getElementById('hdnSLAAppliedOn').value;
            //    }
            //}
            //else {
            //    SLAAppliedOn = "0";
            //}

            //Added By Usha Pandit On 16.04.2020 For getting SLA Applied On type
            SLAAppliedOn = globalSLAAppliedOn
            //End Of Added By Usha Pandit On 16.04.2020 For getting SLA Applied On type
            
            data1 = JSON.stringify({ SLADetailsID: SLADetailsID, Flag: Flag, SLATemplateID: SLATemplateID, Type: SLAAppliedOn });
            strResult1 = AJAXCallWithResult(strPageName + "/GetSLADetails", data1, false);
            //alert(strResult1.d);
            $("#divTabs").html("");
            $("#divTabs").html(strResult1.d);


            //  $(".clsConfigureTabs").css("background", "");
            if (strGroupID == "") {
                $("#navConfigureTabs").css("border", "none");
                $(".clsConfigureTabs").css("border", "none");
                $("#navConfigureTabs").css("border-bottom", "1px solid #398439");
                $("#1").css("border", "1px solid #398439");
                $("#1").css("border-bottom", "none");
                strGroupID = "1";
                objTab = "1";
            }
            $(".clstabs ").mouseover(
                function () {
                    var GroupTabID = "";
                    var $this = $(this);
                    GroupTabID = $(this).attr("data-value");
                    // alert(GroupTabID);

                    //if (GroupTabID == 1) {

                    //    $(this).css("background-color", "white");
                    //}
                    //if (GroupTabID == 2) {

                    //    $(this).css("background-color", "white");
                    //}
                    //else if (GroupTabID == 3) {

                    //    $(this).css("background-color", "white");
                    //    // $(this).addClass("btn-info");
                    //}
                    //else if (GroupTabID == 4) {

                    //    $(this).css("background-color", "white");
                    //}
                    //else if (GroupTabID == 5) {
                    //    //  $(".clsConfigureTabs").css("bacground", "");
                    //    $(this).css("background-color", "white");
                    //}
                    // $(".clsActiveTabs").addClass("btn-success");
                    $(".LiclsConfigureTabs  ").css("background-color", "white");
                    $(".clsConfigureTabs  ").css("background-color", "white");
                    $(".clstabs").css("background-color", "transparent");
                },
                function () {
                    //debugger;
                    var GroupTabID = "";
                    var $this = $(this);
                    GroupTabID = $(this).attr("data-value");

                    // TabColor = $(this).getAttribute("TabColor");
                    //$("#navConfigureTabs").css("border", "none");
                    //$(".LiclsConfigureTabs").css("border", "none");
                    //$(".clsConfigureTabs").css("border", "none");
                    //$(".clstabs").css("border", "none");
                    $(".clstabs").css("background-color", "transparent");
                    $(".LiclsConfigureTabs").css("background-color", "transparent");
                    $(".clsConfigureTabs").css("background-color", "transparent");
                    $(this).css("border-bottom", "none");
                    if (GroupTabID == 1) {
                        //$("#navConfigureTabs").css("border-bottom", "1px solid #398439");
                        //$(this).css("border", "1px solid #398439");
                        $(this).css("border-bottom", "none");
                        $(this).css("background-color", "#398439");
                    }
                    if (GroupTabID == 2) {

                        //$("#navConfigureTabs").css("border-bottom", "1px solid rgb(235, 235, 0)");
                        //$(this).css("border", "1px solid rgb(235, 235, 0)");
                        $(this).css("background-color", "rgb(235, 235, 0)");
                    }
                    else if (GroupTabID == 3) {

                        //$("#navConfigureTabs").css("border-bottom", "1px solid #269abc");
                        //$(this).css("border", "1px solid #269abc");
                        $(".clsConfigureTabs").css("background-color", "none");
                        $(this).css("background-color", "#269abc");
                        // $(this).addClass("btn-info");
                    }
                    else if (GroupTabID == 4) {

                        //$("#navConfigureTabs").css("border-bottom", "1px solid #d58512");
                        //$(this).css("border", "1px solid #d58512");
                        $(this).css("background-color", "#d58512");
                    }
                    else if (GroupTabID == 5) {
                        //$("#navConfigureTabs").css("border-bottom", "1px solid #ac2925");
                        //$(this).css("border", "1px solid #ac2925");
                        $(this).css("background-color", "#ac2925");
                    }
                });
            //Added By Dipali V On 24th Jun 2019 for Tab Highlight issue
            $(".clstabs ").mouseout(
                function () {
                    $(".clsConfigureTabs").css("background-color", "none");
                    $(this).css("background-color", "white");

                });

            //End of Added By Dipali V On 24th Jun 2019 for Tab Highlight issue
             //Added By Dipali V On 31th March 2023 For Datatable Issue
            if ($("#FilterEmployeeList").val() > 0) {
                datatables("divSelectedEmployeeList");
            }
             //End of Added By Dipali V On 31th March 2023 For Datatable Issue
            //var TypeDiv; var accordion;
            //var intDivGridHeight;
            // DivId = "divApplySLA";
            //DivSerach = "SearchSLA";
            //var intDivGridHeight, intDivGridListHeight
            //intDivGridListHeight = parseInt(window.innerHeight);
            //if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
            //    $("#divScrollApplySLA").css('height', intDivGridListHeight - 300 + "px");

            //}

            //else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
            //    $("#divScrollApplySLA").css('height', intDivGridListHeight - 440 + "px");

            //}
            //else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
            //    $("#divScrollApplySLA").css('height', intDivGridListHeight - 400 + "px");

            //}
            //else {
            //    $("#divScrollApplySLA").css('height', intDivGridListHeight - 280 + "px");

            //}
            //datatables(DivId, DivSerach, intDivGridListHeight);
            $("[title]").click(function () {
                $('.ui-tooltip').fadeOut('fast', function () {
                    $('.ui-tooltip').remove();
                });
            });
            $(document).tooltip({
                position: {
                    my: "center bottom-20",
                    at: "center top",
                    using: function (position, feedback) {
                        $(this).css(position);
                        $(this)
                            .addClass(feedback.vertical);
                    }
                }
            });
        }
        var SLATemplateID = "";
        var DepartmentID = "", CustomerID = "";
        var RequestTypeID = "";
        var SLAAppliedOn = "";
		//2020
        var globalSLAAppliedOn = "";
        //2020
        function EditApplySLADetails(obj, SLADetailsID, SLATemplateID1, SLAAppliedOn1) {
            //debugger;
            var strResult, data;
            //  var SLAAppliedOn = "";

            if (SLAAppliedOn1 == "1") {
                SLAAppliedOn1 = 'Priority';
            }
            else if (SLAAppliedOn1 == "2") {
                SLAAppliedOn1 = 'Severity';
            }

            SLAAppliedOn = "";
            strFlag = "";
            if (strFlag == "") {
                strFlag = "ApplySLA";
            }

            //  alert(data);
            document.getElementById('hdnSLADetailsID').value = SLADetailsID;

            //if (document.getElementById('hdnSLATemplateID') != null) {
            document.getElementById('hdnSLATemplateID').value = SLATemplateID1;
            document.getElementById('hdnSLAAppliedOn').value = SLAAppliedOn1;
            SLATemplateID = document.getElementById('hdnSLATemplateID').value;
            SLAAppliedOn = document.getElementById('hdnSLAAppliedOn').value;


            //}
            //else
            //{
            //    SLATemplateID = "0";
            //}
            //if (document.getElementById('hdnSLAAppliedOn') != null) {

            //}
            //else {
            //    SLAAppliedOn = "0";
            //}

            //2020
            if ($("#CboType").val() == "1") {
                globalSLAAppliedOn = "Priority";
            }
            if ($("#CboType").val() == "2") {
                globalSLAAppliedOn = "Severity";
            }
            SLAAppliedOn1 = globalSLAAppliedOn
            //2020

            data = JSON.stringify({ SLADetailsID: SLADetailsID, Flag: strFlag, SLATemplateID: SLATemplateID1, Type: SLAAppliedOn1 });

            strResult = AJAXCallWithResult(strPageName + "/GetSLADetails", data, false);
            $("#divTabs").html("");
            $("#divTabs").html(strResult.d);
            $("#idSLADetailsTab").css("display", "inline");
            $("#liConfigureUserTab").css("display", "inline");
            $("a").removeClass('active');
            //$("#DivHorizontal").addClass('active');
            RefreshGridDetails();

            //$(".xxx").addClass('active');
            $("[title]").click(function () {
                $('.ui-tooltip').fadeOut('fast', function () {
                    $('.ui-tooltip').remove();
                });
            });
            $(document).tooltip({
                position: {
                    my: "center bottom-20",
                    at: "center top",
                    using: function (position, feedback) {
                        $(this).css(position);
                        $(this)
                            .addClass(feedback.vertical);
                    }
                }
            });

        }


        function ValidateSLA() {
            var checkvalue = 0;

            var Flag1 = 0;
            var Flag2 = 0;
            var Flag3 = 0;
            var Flag4 = 0;

            var Unit1 = 0;
            var Unit2 = 0;
            var Unit3 = 0;
            var Unit4 = 0;
            var ValidRow = 0;
            var ValidDetails = 0;
            var checkValid = 0;
            var checkSpecialChar = 0;
            //Added By Usha Pandit On 22.07.2019 For Norm Validation
            var checkZeroValue = 0;
            //End Of Added By Usha Pandit On 22.07.2019 For Norm Validation
            var strmsg = "";
            var errorMsg = "<ul>";
            var Type;
            if (SLAAppliedOn == "Priority") {
                Type = "1";

            }
            else {
                Type = "2";
            }
            //  var Type = $("#CboType").val();
            //  debugger;
            var hdnCountTypeDetails = document.getElementsByName("hdnCountType");
            for (var i = 0; i < hdnCountTypeDetails.length; i++) {

                if (hdnCountTypeDetails[i] != null) {
                    Flag1 = 0;
                    Flag2 = 0;
                    Flag3 = 0;
                    Flag4 = 0;

                    Unit1 = 0;
                    Unit2 = 0;
                    Unit3 = 0;
                    Unit4 = 0;
                    //  debugger;

                    $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "");
                    $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "");
                    $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "");
                    $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "");


                    if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (RestrictNonNumeric(document.getElementById('txtAkNorm_' + Type + "_" + hdnCountTypeDetails[i].value)) == true) {
                            //strmsg = '- Please enter only positive numeric value for Acknowledge Norm';
                            //errorMsg += "<li>" + strmsg + "</li>";
                            $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                            checkvalue = 1;
                            checkValid = 1;

                        }
                    }

                    if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (RestrictNonNumeric(document.getElementById('txtResolveNorm_' + Type + "_" + hdnCountTypeDetails[i].value)) == true) {
                            //strmsg = '- Please enter only positive numeric value for Resolve Norm';
                            $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                            //errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;
                            checkValid = 1;
                        }
                    }

                    if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (RestrictNonNumeric(document.getElementById('txtResNorm_' + Type + "_" + hdnCountTypeDetails[i].value)) == true) {
                            //strmsg = '- Please enter only positive numeric value for Response Norm';
                            //errorMsg += "<li>" + strmsg + "</li>";
                            $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                            checkvalue = 1;
                            checkValid = 1;
                        }
                    }

                    if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (RestrictNonNumeric(document.getElementById('txtcloseNorm_' + Type + "_" + hdnCountTypeDetails[i].value)) == true) {
                            //strmsg = '- Please enter only positive numeric value for close Norm';
                            //errorMsg += "<li>" + strmsg + "</li>";
                            $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                            checkvalue = 1;
                            checkValid = 1;
                        }
                    }


                    //Added By Usha Pandit On 22.07.2019 For Norm Validation
                     if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() <= 0) {
                            $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                            checkvalue = 1;
                            checkZeroValue = 1;
                        }
                    }

                    if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {                       
                        if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() <= 0) {
                            $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                            checkvalue = 1;
                            checkZeroValue = 1;
                        }                        
                    }

                    if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {                        
                        if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() <= 0) {
                            $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                            checkvalue = 1;
                            checkZeroValue = 1;
                        }
                    }

                    if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {                        
                        if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() <= 0) {
                            $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                            checkvalue = 1;
                            checkZeroValue = 1;
                        }
                    }

                    //End Of Added By Usha Pandit On 22.07.2019 For Norm Validation

                    /////////////////////////////////////////

                    if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (checkSpecialCharacter($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val()) == true) {
                            checkvalue = 1;
                            checkSpecialChar = 1;
                            $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                        }                       
                    }

                    if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (checkSpecialCharacter($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val()) == true) {
                            checkvalue = 1;
                            checkSpecialChar = 1;
                            $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                        }                      
                    }

                    if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (checkSpecialCharacter($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val()) == true) {
                            checkvalue = 1;
                            checkSpecialChar = 1;
                            $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                        }                       
                    }

                    if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (checkSpecialCharacter($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val()) == true) {
                            checkvalue = 1;
                            checkSpecialChar = 1;
                            $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 1)");
                        }                       
                    }



                    if ($("#CboAkUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        Unit1 = 0;
                    }
                    else {
                        Unit1 = 1;
                    }

                    if ($("#CboResolveUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        Unit2 = 0;
                    }
                    else {
                        Unit2 = 1;
                    }

                    if ($("#CboResUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        Unit3 = 0;
                    }
                    else {
                        Unit3 = 1;
                    }

                    if ($("#CbocloseUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        Unit4 = 0;
                    }
                    else {
                        Unit4 = 1;
                    }


                    if ((Unit1 == 0 && Unit2 == 0 && Unit3 == 0 && Unit4 == 0)) {
                        strmsg = '- Unit is mandatory';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }

                }
            }
            //  debugger;


            if (ValidDetails == 1 && (Flag1 == 0 && Flag2 == 0 && Flag3 == 0 && Flag4 == 0)) {
                strmsg = '- Norm is mandatory';
                errorMsg += "<li>" + strmsg + "</li>";
            }

            if (checkValid == 1) {
                strmsg = '- Please enter only positive numeric value for Norms';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }


            if (checkSpecialChar == 1) {
                strmsg = '- Norm cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }
            //Added By Usha Pandit On 22.07.2019 For Norm Validation
            if (checkZeroValue == 1) {
                strmsg = '- Norm should be greater than 0.00.';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            } 
            //End Of Added By Usha Pandit On 22.07.2019 For Norm Validation

            //  alert(strmsg);
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error');
                checkvalue = 1;
            }

           
            return checkvalue;

        }

        function SaveHelpDeskSLA() {


            if (ValidateSLA() == 0) {
                var Type = "";


                var SaveSLADetialsData = [];
                var Priority = 0, Severity = 0;

                var hdnCountType = document.getElementById('hdnCountType');
                if (Type == "1") {
                    //Priority = "1"

                }
                else if (Type == "2") {
                    // Severity = "1"
                }

                if (SLAAppliedOn == "Priority") {
                    Type = "1";

                }
                else {
                    Type = "2";
                }
                if (hdnCountType != null) {
                    var strAcknowledgeWithinNorm = "";
                    var strAcknowledgeWithinUnit = "";

                    var strResolveWithinNorm = "";
                    var strResolveWithinUnit = "";

                    var strRespondWithinNorm = "";
                    var strRespondWithinUnit = "";

                    var strCloseeWithinNorm = "";
                    var strCloseeWithinUnit = "";

                    var ExcalationEmail = "";
                    var ConsiderWorkHrs = "";
                    var ExcludeHoldPeriod = "";
                    var IsExcalationEmail = "";
                    var IsConsiderWorkHrs = "";
                    var IsExcludeHoldPeriod = "";
                    var strDetailsID = "";
                    var strCustomCommentIDsRelease = "";
                    var hdnCountTypeDetails = document.getElementsByName("hdnCountType");
                    for (var i = 0; i < hdnCountTypeDetails.length; i++) {

                        if (hdnCountTypeDetails[i] != null) {

                            if ($("#hdnDetailsID" + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                if (strDetailsID == "") {
                                    strDetailsID = $("#hdnDetailsID" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                                else {
                                    strDetailsID += ',' + $("#hdnDetailsID" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }
                            else {
                                if (strDetailsID == "") {
                                    strDetailsID = "0";
                                }
                                else {
                                    strDetailsID += ',' + "0";
                                }

                            }



                            if (Type == "1") {
                                if (Priority == 0) {
                                    Priority = $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                                else {
                                    Priority += ',' + $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }

                            // alert(Priority);

                            if (Type == "2") {
                                if (Severity == 0) {
                                    Severity = $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                                else {
                                    Severity += ',' + $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }

                            //Acknowledge Within

                            if (strAcknowledgeWithinNorm == "") {
                                strAcknowledgeWithinNorm = $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                if (strAcknowledgeWithinNorm == "") {
                                    strAcknowledgeWithinNorm = "0"
                                }
                            }
                            else {
                                if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                                    strAcknowledgeWithinNorm += ',' + "0";
                                }
                                else {
                                    strAcknowledgeWithinNorm += ',' + $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }

                            //Acknowledge Unit
                            if (strAcknowledgeWithinUnit == "") {
                                strAcknowledgeWithinUnit = $("#CboAkUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }
                            else {
                                strAcknowledgeWithinUnit += ',' + $("#CboAkUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }

                            //Resolve Within
                            if (strResolveWithinNorm == "") {
                                strResolveWithinNorm = $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                if (strResolveWithinNorm == "") {
                                    strResolveWithinNorm = "0"
                                }
                            }
                            else {
                                if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                                    strResolveWithinNorm += ',' + "0";
                                }
                                else {
                                    strResolveWithinNorm += ',' + $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }

                            }
                            //Resolve Unit
                            if (strResolveWithinUnit == "") {
                                strResolveWithinUnit = $("#CboResolveUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }
                            else {
                                strResolveWithinUnit += ',' + $("#CboResolveUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }



                            //Response Within
                            if (strRespondWithinNorm == "") {
                                strRespondWithinNorm = $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                if (strRespondWithinNorm == "") {
                                    strRespondWithinNorm = "0";
                                }

                            }
                            else {
                                if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                                    strRespondWithinNorm += ',' + "0";
                                }
                                else {
                                    strRespondWithinNorm += ',' + $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }
                            //Response Unit
                            if (strRespondWithinUnit == "") {
                                strRespondWithinUnit = $("#CboResUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }
                            else {
                                strRespondWithinUnit += ',' + $("#CboResUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }




                            //Response Within
                            if (strCloseeWithinNorm == "") {

                                strCloseeWithinNorm = $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                if (strCloseeWithinNorm == "") {
                                    strCloseeWithinNorm = "0";
                                }
                            }
                            else {
                                if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                                    strCloseeWithinNorm += ',' + "0";
                                }
                                else {
                                    strCloseeWithinNorm += ',' + $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }
                            //Response Unit
                            if (strCloseeWithinUnit == "") {
                                strCloseeWithinUnit = $("#CbocloseUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }
                            else {
                                strCloseeWithinUnit += ',' + $("#CbocloseUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }

                            //ExcalationEmail 

                            var IsExcalationEmail = "";
                            var IsConsiderWorkHrs = "";
                            var IsExcludeHoldPeriod = "";

                            var ExcalationEmailValue;
                            if (ExcalationEmail == "") {
                                ExcalationEmailValue = $("#chkEsc_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsExcalationEmail = "1"
                                    }
                                    else {
                                        IsExcalationEmail = "0"
                                    }
                                }
                                else {

                                    IsExcalationEmail = "0"
                                }
                                ExcalationEmail = IsExcalationEmail;
                            }
                            else {
                                ExcalationEmailValue = $("#chkEsc_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsExcalationEmail = "1"
                                    }
                                    else {
                                        IsExcalationEmail = "0"
                                    }
                                }
                                else {

                                    IsExcalationEmail = "0"
                                }

                                ExcalationEmail += ',' + IsExcalationEmail;
                            }
                            // ConsiderWorkHrs  
                            var ConsiderWorkHrsValue;
                            if (ConsiderWorkHrs == "") {
                                ConsiderWorkHrsValue = $("#chkWrkhrs_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsConsiderWorkHrs = "1"
                                    }
                                    else {
                                        IsConsiderWorkHrs = "0"
                                    }
                                } else {
                                    IsConsiderWorkHrs = "0"
                                }
                                ConsiderWorkHrs = IsConsiderWorkHrs;
                            }
                            else {
                                ConsiderWorkHrsValue = $("#chkWrkhrs_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsConsiderWorkHrs = "1"
                                    }
                                    else {
                                        IsConsiderWorkHrs = "0"
                                    }
                                } else {
                                    IsConsiderWorkHrs = "0"
                                }
                                ConsiderWorkHrs += ',' + IsConsiderWorkHrs;
                            }

                            // ExcludeHoldPeriod
                            var ExcludeHoldPeriodValue;
                            if (ExcludeHoldPeriod == "") {
                                ExcludeHoldPeriodValue = $("#chkEHoldP_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsExcludeHoldPeriod = "1"
                                    }
                                    else {
                                        IsExcludeHoldPeriod = "0"
                                    }
                                } else {

                                    IsExcludeHoldPeriod = "0"
                                }
                                ExcludeHoldPeriod = IsExcludeHoldPeriod;
                            }
                            else {
                                ExcludeHoldPeriodValue = $("#chkEHoldP_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsExcludeHoldPeriod = "1"
                                    }
                                    else {
                                        IsExcludeHoldPeriod = "0"
                                    }
                                }
                                else {

                                    IsExcludeHoldPeriod = "0"
                                }
                                ExcludeHoldPeriod += ',' + IsExcludeHoldPeriod;
                            }

                        }
                    }

                }
                //var SLADetailsID = "0";
                //var SLATemplateID = "0";
                //SLADetailsID= document.getElementById('hdnSLADetailsID').value ;
                //if (document.getElementById('hdnSLATemplateID') != null) {
                //    SLATemplateID = document.getElementById('hdnSLATemplateID').value;
                //}
                //else {
                //    SLATemplateID = "0";
                //}
                SLATemplateID = document.getElementById('hdnSLATemplateID').value;
                SLAAppliedOn = document.getElementById('hdnSLAAppliedOn').value;



                SaveSLADetialsData.push({
                    SLATemplateID: SLATemplateID, strAcknowledgeWithinNorm: strAcknowledgeWithinNorm, strAcknowledgeWithinUnit: strAcknowledgeWithinUnit,
                    strResolveWithinNorm: strResolveWithinNorm, strResolveWithinUnit: strResolveWithinUnit, strRespondWithinNorm: strRespondWithinNorm, strRespondWithinUnit: strRespondWithinUnit, strCloseeWithinNorm: strCloseeWithinNorm, strCloseeWithinUnit: strCloseeWithinUnit,
                    ExcalationEmail: ExcalationEmail, ConsiderWorkHrs: ConsiderWorkHrs, ExcludeHoldPeriod: ExcludeHoldPeriod, Priority: Priority, Severity: Severity, Type: Type, SLADetailsID: SLADetailsID
                });

                data = JSON.stringify({ SaveSLADetialsData: SaveSLADetialsData });


                //   alert(data);
                //data = JSON.stringify({ Subject: Subject, Description: Description, Department: Department, RequestType: RequestType, SubRequestType: SubRequestType, Priority: Priority, Product: Product, ModuleComponent: ModuleComponent, Location: Location, TimeZone: TimeZone, Status: "", Project: "", AssignTo: "", objCustomField: m_strCustomFieldList, CustomFieldValue: CustomFieldValue, ExpResoulDate: ExpResoulDate, CC: CC, CustomerID: CustomerID, EmployeeID: EmployeeID });
                //  alert(data);
                strResult = AJAXCallWithResult("CRM_ApplySLA.aspx/SaveHelpDeskSLATemplate", data, false);
                var Result = String(strResult.d).split("||");
                if (strResult != null) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("SLA details saved successfully", 'success');
                    RefreshGrid("ApplySLA", "Refresh");
                     //Added By Usha Pandit On 25.06.2019 For disabled checkbox issue
                    //PlotSubtab1("SLADetails");
                    //End Of Added By Usha Pandit On 25.06.2019 For disabled checkbox issue
                }
            }
        }

        //Added By Usha Pandit On 03.07.2019 For enabling Escalation Email chkbox on Norm set
         function EnableControls(obj, SLATypeID, Counter) {
            
            Flag2 = 0;
            Flag3 = 0;
            Flag4 = 0;
            var hdnCountTypeDetails = document.getElementsByName("hdnCountType");
                          
            if ($("#txtAkNorm_" + SLATypeID + "_" + Counter).val() == "" && $("#txtResolveNorm_" + SLATypeID + "_" + Counter).val() == "" && $("#txtResNorm_" + SLATypeID + "_" + Counter).val() == "" && $("#txtcloseNorm_" + SLATypeID + "_" + Counter).val() == "") {
                document.getElementById('chkEsc_' + SLATypeID + "_" + Counter).disabled = true;
                document.getElementById('chkWrkhrs_' + SLATypeID + "_" + Counter).disabled = true;
                document.getElementById('chkEHoldP_' + SLATypeID + "_" + Counter).disabled = true;
                document.getElementById('chkEsc_' + SLATypeID + "_" + Counter).checked = false;
                document.getElementById('chkWrkhrs_' + SLATypeID + "_" + Counter).checked = false;
                document.getElementById('chkEHoldP_' + SLATypeID + "_" + Counter).checked = false;
            }
            else {
                document.getElementById('chkEsc_' + SLATypeID + "_" + Counter).disabled = false;
                document.getElementById('chkWrkhrs_' + SLATypeID + "_" + Counter).disabled = false;
                document.getElementById('chkEHoldP_' + SLATypeID + "_" + Counter).disabled = false;
            }
        }
        //End Of Added By Usha Pandit On 03.07.2019 For enabling Escalation Email chkbox on Norm set

        //Added By Vidya Jadhav ON 15 De 2017 For Configure User Groups Functionality
        var strGroupID = "";
        var objTab = "";
        var TabColor = "#398439";
        function ConfigureGroupsTab_Click(GroupID, obj) {

            var i, tabcontent4, tablinks4;
            var strGroupID = GroupID;
            objTab = obj;
            PlotConfigureUserSubtab(GroupID);
            TabColor = document.getElementById(GroupID).getAttribute("TabColor");
            // alert(TabColor);
            // alert(strGroupID);
            if (GroupID == 1) {
                //debugger;
                //  $(".clsConfigureTabs").css("background", "");
                $("#navConfigureTabs").css("border", "none");
                $(".clsConfigureTabs").css("border", "none");
                $(obj).css("background-color", "white !important");
                $(".active").css("background-color", "white !important");
                $("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                $(obj).css("border", "1px solid " + TabColor + "");
                $(obj).css("border-bottom", "none");
                $(".clstabs").css("border", "none");
                $(".LiclsConfigureTabs ").css("background-color", "white");

                $(".clsConfigureTabs").css("background-color", "white");
                $(obj).css("border-bottom", "none");

            }
            if (GroupID == 2) {
                // $(".clsConfigureTabs").css("background", "");
                $("#1").css("border", "none");
                $("#1").css("border-bottom", "none");
                $("#navConfigureTabs").css("border", "none");
                $(".clsConfigureTabs").css("border", "none");
                $(obj).css("background-color", "white !important");
                $(".active").css("background-color", "white !important");
                $("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                $(obj).css("border", "1px solid " + TabColor + "");
                $(obj).css("border-bottom", "none");
                //  $(obj).css("background-color", "transparent");
                $(".clstabs").css("border", "none");
                $(".LiclsConfigureTabs ").css("background-color", "white");
                $(".clsConfigureTabs").css("background-color", "white");
                $(obj).css("border-bottom", "none");
            }
            else if (GroupID == 3) {
                //debugger;
                // $(".clsConfigureTabs").css("background", "");
                $("#1").css("border", "none");
                $("#1").css("border-bottom", "none");
                $("#navConfigureTabs").css("border", "none");
                $(".clsConfigureTabs").css("border", "none");
                $(obj).css("background-color", "white !important");
                $(".active").css("background-color", "white !important");
                // $(".clsConfigureTabs").css("border-bottom", "1px solid #269abc");
                $("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                $(obj).css("border", "1px solid " + TabColor + "");
                $(obj).css("border-bottom", "none");
                //  $(obj).css("background-color", "transparent");
                $(".clstabs").css("border", "none");
                $(".LiclsConfigureTabs ").css("background-color", "white");
                $(".clsConfigureTabs").css("background-color", "white");
                $(obj).css("border-bottom", "none");
            }
            else if (GroupID == 4) {
                // $(".clsConfigureTabs").css("background", "");
                $("#1").css("border", "none");
                $("#1").css("border-bottom", "none");
                $("#navConfigureTabs").css("border", "none");
                $(".clsConfigureTabs").css("border", "none");
                $(obj).css("background-color", "white !important");
                $(".active").css("background-color", "white !important");
                $("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                $(obj).css("border", "1px solid " + TabColor + "");

                //  $(obj).css("background-color", "transparent");
                $(".clstabs").css("border", "none");
                $(".LiclsConfigureTabs ").css("background-color", "white");
                $(".clsConfigureTabs").css("background-color", "white");
                $(obj).css("border-bottom", "none");
            }
            else if (GroupID == 5) {
                //  $(".clsConfigureTabs").css("bacground", "");
                $("#1").css("border", "none");
                $("#1").css("border-bottom", "none");
                $("#navConfigureTabs").css("border", "none");
                $(".clsConfigureTabs").css("border", "none");
                $(obj).css("background-color", "white !important");
                $(".active").css("background-color", "white !important");
                $("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                $(obj).css("border", "1px solid " + TabColor + "");

                //   $(obj).css("background-color", "transparent");
                $(".clstabs").css("border", "none");
                $(".LiclsConfigureTabs ").css("background-color", "white");
                $(".clsConfigureTabs").css("background-color", "white");
                $(obj).css("border-bottom", "none");
            }

             //Added By Dipali V On 31th March 2023 For Datatable Issue
            if ($("#FilterEmployeeList").val() > 0) {
                datatables("divSelectedEmployeeList");
            }
             //End of Added By Dipali V On 31th March 2023 For Datatable Issue
            $("#liConfigureUserTab").addClass("active");
        }

        var strFlag = "";

        function PlotConfigureUserSubtab(GroupID) {

            var strResult1, data1;
            strFlag = GroupID;
            strGroupID = GroupID;
            data1 = JSON.stringify({ GroupID: GroupID, SLAID: SLADetailsID });
            strResult1 = AJAXCallWithResult(strPageName + "/PlotTabConfigureUserDetails", data1, false);

            $("#divUsersTabs").html("");
            $("#divUsersTabs").html(strResult1.d);
            EmployeeList = "";
            $('.nav-tabs li a').removeClass('active');

            //Added By Dipali V On 31th March 2023 For Datatable Issue
            if ($("#FilterEmployeeList").val() > 0) {
                datatables("divSelectedEmployeeList");
            }
            //End of Added By Dipali V On 31th March 2023 For Datatable Issue
            $("[title]").click(function () {
                $('.ui-tooltip').fadeOut('fast', function () {
                    $('.ui-tooltip').remove();
                });
            });

        }
        var SLATemplateID = "";

        var strGroupID = "";
        function DepartMentFilter_OnChange(Object) {

            var strResult, data;
            var GridParameter = {};
            var Department = $("#cboDepartment").val();

            if (Department == "0" || Department == "") {
                Department = ""
            }

            data = JSON.stringify({ GroupID: strGroupID, DepartmentID: Department, SLAID: SLADetailsID });
            strResult = AJAXCallWithResult("CRM_ApplySLA.aspx/RefreshEmployeeList", data, false);

            if (strResult.d != "") {
                $("#divEmployeeList").html("");
                $("#divEmployeeList").html(strResult.d);
                 //Added By Dipali V On 31th March 2023 For Datatable Issue
                if ($("#FilterEmployeeList").val() > 0) {
                    datatables("divSelectedEmployeeList");
                }
                 //End of Added By Dipali V On 31th March 2023 For Datatable Issue
                // setWidthEmployee();

            }
            // RefreshConfigureTabs(strGroupID);
        }
        function EmployeeSearch(FlagFilter) {
            // debugger;
            Flag = FlagFilter
            var input, filter, ul, li, i, Flag;
            var noRecords = 0;
            input = document.getElementById("SearchEmployee");
            filter = input.value.toUpperCase();
            table = document.getElementById("ulConfigureEmployee");

            tr = table.getElementsByTagName("li");
            for (i = 0; i < tr.length; i++) {
                td = tr[i];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.setProperty("display", "block", "important");
                        //  tr[i].hover("color", "red");
                        noRecords = 1;
                    }
                    else {
                        tr[i].style.setProperty("display", "none", "important");
                        //tr[i].hover("color", "red");
                    }

                }
            }

            if (noRecords == 0) {
                $("#ulNoData").css("display", "block");
                $("#add").css("visibility", 'hidden');
            }
            else {
                $("#add").css("visibility", '');
                $("#ulNoData").css("display", "none");
            }
             //Added By Dipali V On 31th March 2023 For Datatable Issue
            if ($("#FilterEmployeeList").val() > 0) {
                datatables("divSelectedEmployeeList");
            }
             //End of Added By Dipali V On 31th March 2023 For Datatable Issue
        }


    </script>


    <script>



        var EmployeeList = "";
        var EmployeeListArry = [];
        function SelectEmployee(obj, EmployeeID) {
            var whiteColor = "rgb(232, 232, 232)";
            //debugger;
            $(".iSettingsTab").css("height", "50px");
            if ($(obj).hasClass("iSettingsTab")) {
                $(obj).removeClass("iSettingsTab");
                EmployeeListArry.splice(EmployeeListArry.indexOf(EmployeeID), 1);
                //Added By Dipali V On 24th June 2019 For Selected Employee Background Color
                if ($("#" + EmployeeID).css("background-color") == whiteColor) {
                    //  $("#" + EmployeeID).removeAttr("background-color");
                    $("#" + EmployeeID).css("background-color", "white");

                } else {
                    $("#" + EmployeeID).css("background-color", "#E8E8E8");
                }
                //End of Added By Dipali V On 24th June 2019 For Selected Employee Background Color
            }
            else {

                $(obj).addClass("iSettingsTab");
                $(obj).attr("EmployeeID");

                EmployeeListArry.push(EmployeeID);
                // EmployeeListArry.push(EmployeeList);
                $(".iSettingsTab").css("height", "50px");
                $(".iSettingsTab").css("padding", " 8px 15px !important");
                //Added By Dipali V On 24th June 2019 For Selected Employee Background Color
                if ($("#" + EmployeeID).css("background-color") == whiteColor) {
                    //  $("#" + EmployeeID).removeAttr("background-color");
                    $("#" + EmployeeID).css("background-color", "white");

                } else {
                    $("#" + EmployeeID).css("background-color", "#E8E8E8");
                }
                //End of Added By Dipali V On 24th June 2019 For Selected Employee Background Color
            }
            // console.log(EmployeeListArry); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
        }


        // $('#ulConfigureEmployee > .list-group-item').live("mouseover", function() { alert("you rolled over") });
        var ClearList = "0";
        function AddConfigureUserGroups() {
            // alert(EmployeeList);
            var selected_users = "";
            c = document.getElementsByClassName("panel-heading");
            //for (var i = 0; i < c.length; i++) {
            //    selected_users += '<button type="button" class=" btn  btn-primary " style="margin-left:20px; margin-top:10px;" ><span id="test" onclick="this.parentNode.parentNode.removeChild(this.parentNode);">' + c[i].innerText + '&#10006;</span></button>';
            //}
            var SLAID = document.getElementById('hdnSLADetailsID').value;
            EmployeeList = EmployeeListArry.toString();

            if (EmployeeList != "" || EmployeeList != 0) {
                data = JSON.stringify({ GroupID: strGroupID, EmployeeID: EmployeeList, strAction: "INSERT", SLAID: SLAID });
                // alert(data);
                strResult = AJAXCallWithResult("CRM_ApplySLA.aspx/AddOrDeleteUsers", data, false);

                ClearList = "1";
                EmployeeListArry = [];
                //debugger;
                //var Result = String(strResult.d).split("||");
                //$(".right_section").html(selected_users);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('User(s) added successfully', 'success');
                RefreshConfigureTabs(strGroupID);
                //Added By Dipali V On 31th March 2023 For Datatable Issue
                if ($("#FilterEmployeeList").val() > 0) {
                    datatables("divSelectedEmployeeList");
                }
                //End of Added By Dipali V On 31th March 2023 For Datatable Issue
            }
            else {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please select User(s).', 'error');
            }
        }

        function DeleteConfigureUserGroups() {

            var strEmployeeeIDs;
            strEmployeeeIDs = $('input[name=chkUserDelete]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (strEmployeeeIDs.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please select User(s).', 'error');
                return;
            }
            var SLAID = document.getElementById('hdnSLADetailsID').value;
            if (strEmployeeeIDs != "" || strEmployeeeIDs != "0") {
                data = JSON.stringify({ GroupID: strGroupID, EmployeeID: strEmployeeeIDs, strAction: "DELETE", SLAID: SLAID });
                // alert(strEmployeeeIDs);
                strResult = AJAXCallWithResult(strPageName + "/AddOrDeleteUsers", data, false);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('User(s) removed successfully', 'success');
                RefreshConfigureTabs(strGroupID);
                //Added By Dipali V On 31th March 2023 For Datatable Issue
                if ($("#FilterEmployeeList").val() > 0) {
                    datatables("divSelectedEmployeeList");
                }
                //End of Added By Dipali V On 31th March 2023 For Datatable Issue
            }
        }
        function DeleteMultipleConfigureUserGruoups() {
            if (document.getElementById('chkUserDelete').checked == true) {
                $("input[name=chkUserDelete]:not(:disabled)").prop('checked', true);
            }
            else {
                $("input[name=chkUserDelete]").prop('checked', false);
            }
        }
        function RefreshConfigureTabs(GroupID) {

            var strResult1, data1;
            strFlag = GroupID;
            strGroupID = GroupID;
            data1 = JSON.stringify({ GroupID: GroupID, SLAID: SLADetailsID });
            strResult1 = AJAXCallWithResult(strPageName + "/PlotTabConfigureUserDetails", data1, false);

            $("#divUsersTabs").html("");
            $("#divUsersTabs").html(strResult1.d);
            EmployeeList = "";
            $('#navConfigureTabs li a').addClass('active');
            //Added By Dipali V On 31th March 2023 For Datatable Issue
            if ($("#FilterEmployeeList").val() > 0) {
                datatables("divSelectedEmployeeList");
            }
            //End of Added By Dipali V On 31th March 2023 For Datatable Issue


            //  $('.nav-tabs li').removeClass('active');
            //  alert(GroupID, TabColor);
            if (GroupID == 1) {
                //  $(".clsConfigureTabs").css("background", "");
                //$("#navConfigureTabs").css("border", "none");
                //$(".clsConfigureTabs").css("border", "none");
                //$("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                //$(objTab).css("border", "1px solid " + TabColor + "");
                //$(objTab).css("border-bottom", "none");
                /* Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
                $("#navConfigureTabs").prop("border", "none");
                $(".clsConfigureTabs").prop("border", "none");
                $("#navConfigureTabs").prop("border-bottom", "1px solid " + TabColor + "");
                $(objTab).prop("border", "1px solid " + TabColor + "");
                $(objTab).prop("border-bottom", "none");

                $(".clsActiveTabs").prop("border - top", "1px solid rgb(57, 132, 57)!important");
                $(".clsActiveTabs").prop("border - right", "1px solid rgb(57, 132, 57)!important");
                $(".clsActiveTabs").prop("border - left", "1px solid rgb(57, 132, 57)!important");
                $(".clsActiveTabs").prop("border - bottom", "none!important");
                $(".clsActiveTabs").prop("background - color", "transparent!important");
                /* End of Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
            }
            if (GroupID == 2) {
                // $(".clsConfigureTabs").css("background", "");
                //$("#navConfigureTabs").css("border", "none");
                //$(".clsConfigureTabs").css("border", "none");
                //$("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                //$(objTab).css("border", "1px solid " + TabColor + "");
                //$(objTab).css("border-bottom", "none");
                //$(objTab).css("background-color", "rgb(235, 235, 0);");
                /* Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
                $("#navConfigureTabs").prop("border", "none");
                $(".clsConfigureTabs").prop("border", "none");
                $("#navConfigureTabs").prop("border-bottom", "1px solid " + TabColor + "");
                $(objTab).prop("border", "1px solid " + TabColor + "");
                $(objTab).prop("border-bottom", "none");
                $(objTab).prop("background-color", "rgb(235, 235, 0);");

                $(".clsActiveTabs").prop("border - top", "1px solid rgb(235, 235, 0)!important");
                $(".clsActiveTabs").prop("border - right", "1px solid rgb(235, 235, 0)!important");
                $(".clsActiveTabs").prop("border - left", "1px solid rgb(235, 235, 0)!important");
                $(".clsActiveTabs").prop("border - bottom", "none!important");
                $(".clsActiveTabs").prop("background - color", "transparent!important");
                /* End of Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
            }
            else if (GroupID == 3) {
                /* Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
                // $(".clsConfigureTabs").css("background", "");
                //$("#navConfigureTabs").css("border", "none");
                //$(".clsConfigureTabs").css("border", "none");
                //// $(".clsConfigureTabs").css("border-bottom", "1px solid #269abc");
                //$("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                //$(objTab).css("border", "1px solid " + TabColor + "");
                //$(objTab).css("border-bottom", "none");

                $("#navConfigureTabs").prop("border", "none");
                $(".clsConfigureTabs").prop("border", "none");
                // $(".clsConfigureTabs").css("border-bottom", "1px solid #269abc");
                $("#navConfigureTabs").prop("border-bottom", "1px solid " + TabColor + "");
                $(objTab).prop("border", "1px solid " + TabColor + "");
                $(objTab).prop("border-bottom", "none");

                $(".clsActiveTabs").prop("border - top", "1px solid  rgb(38, 154, 188)!important");
                $(".clsActiveTabs").prop("border - right", "1px solid rgb(38, 154, 188)!important");
                $(".clsActiveTabs").prop("border - left", "1px solid  rgb(38, 154, 188)!important");
                $(".clsActiveTabs").prop("border - bottom", "none!important");
                $(".clsActiveTabs").prop("background - color", "transparent!important");

                /* End of Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
            }
            else if (GroupID == 4) {
                /* Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
                // $(".clsConfigureTabs").css("background", "");
                //$("#navConfigureTabs").css("border", "none");
                //$(".clsConfigureTabs").css("border", "none");
                //$("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                //$(objTab).css("border", "1px solid " + TabColor + "");
                //$(objTab).css("border-bottom", "none");

                $("#navConfigureTabs").prop("border", "none");
                $(".clsConfigureTabs").prop("border", "none");
                $("#navConfigureTabs").prop("border-bottom", "1px solid " + TabColor + "");
                $(objTab).prop("border", "1px solid " + TabColor + "");
                $(objTab).prop("border-bottom", "none");

                $(".clsActiveTabs").prop("border - top", "1px solid  rgb(213, 133, 18)!important");
                $(".clsActiveTabs").prop("border - right", "1px solid rgb(213, 133, 18)!important");
                $(".clsActiveTabs").prop("border - left", "1px solid  rgb(213, 133, 18)!important");
                $(".clsActiveTabs").prop("border - bottom", "none!important");
                $(".clsActiveTabs").prop("background - color", "transparent!important");
                /*End of  Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
            }
            else if (GroupID == 5) {
                /* Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
                //  $(".clsConfigureTabs").css("bacground", "");
                //$("#navConfigureTabs").css("border", "none");
                //$(".clsConfigureTabs").css("border", "none");
                //$("#navConfigureTabs").css("border-bottom", "1px solid " + TabColor + "");
                //$(objTab).css("border", "1px solid " + TabColor + "");
                //$(objTab).css("border-bottom", "none");

                $("#navConfigureTabs").prop("border", "none");
                $(".clsConfigureTabs").prop("border", "none");
                $("#navConfigureTabs").prop("border-bottom", "1px solid " + TabColor + "");
                $(objTab).prop("border", "1px solid " + TabColor + "");
                $(objTab).prop("border-bottom", "none");

                $(".clsActiveTabs").prop("border - top", "1px solid  rgb(172, 41, 37)!important");
                $(".clsActiveTabs").prop("border - right", "1px solid rgb(172, 41, 37)!important");
                $(".clsActiveTabs").prop("border - left", "1px solid  rgb(172, 41, 37)!important");
                $(".clsActiveTabs").prop("border - bottom", "none!important");
                $(".clsActiveTabs").prop("background - color", "transparent!important");
                /*End of  Commented & Added By Dipali V On 6th April 2023 For Focus Issue*/
            }




            //if (GroupID == 1) {
            //    $("#" + GroupID).addClass("btn-success");
            //    $("#" + GroupID).addClass('active');
            //    $("#2").css("background-color", "transparent");
            //    $("#2").css("color", "black");
            //    $("#3").removeClass("btn-info");
            //    $("#4").removeClass("btn-warning");
            //    $("#5").removeClass("btn-danger");
            //}
            //if (GroupID == 2) {
            //    $("#" + GroupID).css("background-color", "#EBEB00");
            //    $("#" + GroupID).addClass('active');
            //    $("#" + GroupID).css("color", "white");
            //    $("#1").removeClass("btn-success");
            //    $("#3").removeClass("btn-info");
            //    $("#4").removeClass("btn-warning");
            //    $("#5").removeClass("btn-danger");
            //}
            //else if (GroupID == 3) {
            //    $("#" + GroupID).addClass("btn-info");
            //    $("#" + GroupID).addClass('active');
            //    $("#1").removeClass("btn-success");
            //    //$("#2").removeClass("btn-success");
            //    $("#2").css("background-color", "transparent");
            //    $("#2").css("color", "black");
            //    $("#4").removeClass("btn-warning");
            //    $("#5").removeClass("btn-danger");
            //}
            //else if (GroupID == 4) {
            //    $("#" + GroupID).addClass("btn-warning");
            //    $("#" + GroupID).addClass('active');
            //    $("#1").removeClass("btn-success");
            //    $("#2").css("background-color", "transparent");
            //    $("#2").css("color", "black");
            //    $("#3").removeClass("btn-info");
            //    $("#5").removeClass("btn-danger");
            //}
            //else if (GroupID == 5) {
            //    $("#" + GroupID).addClass("btn-danger");
            //    $("#" + GroupID).addClass('active');
            //    $("#1").removeClass("btn-success");
            //    $("#2").css("background-color", "transparent");
            //    $("#2").css("color", "black");
            //    $("#3").removeClass("btn-info");
            //    $("#4").removeClass("btn-warning");
            //}


            //Added By Dipali V On 31th March 2023 For Datatable Issue
            if ($("#FilterEmployeeList").val() > 0) {
                datatables("divSelectedEmployeeList");
            }
            //End of Added By Dipali V On 31th March 2023 For Datatable Issue
        }
        var ConfirmYes = "";
        function ConfirmOverride(ConfirmYesNo) {
            // $("#myOverride").modal("hide");
            //debugger;
            document.getElementById('myOverride').style.display = 'none';
            if (ConfirmYesNo == "") {
                ConfirmYesNo = "0";

            }


            var strResult, data;
            var CboCustomer;
            var SLAID;

            if (document.getElementById('hdnSLADetailsID') != null) {
                if (document.getElementById('hdnSLADetailsID').value == 0) {
                    SLAID = 0;
                }
                else {
                    SLAID = document.getElementById('hdnSLADetailsID').value;
                }
            }
            //debugger;
            var CboTemplateMaster = $("#CboTemplateMaster").val();
            var CboTemplateMasterOld = $("#CboTemplateMasterOld").val();
            var CboDepartment = $("#CboDepartment").val();
            var CboRequestType = $("#CboRequestType").val();
            var CboSubRequestType = $("#CboSubRequestType").val();
            var dtEffectivedate = $("#dtEffectivedate").val();
            var TimeZone = $("#CboTimeZone").val();
            var Type = $("#CboType").val();

            var IsInternal;
            var IsSendAlert;
            var IsSendReminder;
            var IsEscalateLevel1;
            var IsEscalateLevel2;
            var IsEscalateLevel3;
            var IsEscalateLevel4;
            if ($("#chkInternal").is(':checked')) {
                IsInternal = 1;
            }
            else {
                IsInternal = 0;
            }


            if (IsInternal == 1) {
                // $("#divCboCustomer").css("display", "none");
                CboCustomer = "0";
            }
            else {

                CboCustomer = $("#CboCustomer").val();
            }
            // alert($("#CboTemplateMasterOld").val());
            if (CboTemplateMasterOld == "") {
                CboTemplateMasterOld = "0";
            }

            var SendAlertNorm = $("#txtSendAlert").val();
            var SendAlertUnit = $("#CboSendAlert").val();
            var SendReminderNorm = $("#txtSendReminder").val();

            var SendReminderUnit = $("#CboSendReminder").val();
            var EscalateLevel1Norm = $("#txtEscalateLevel1").val();
            var EscalateLevel1Unit = $("#CboEscalateLevel1").val();
            var EscalateLevel2Norm = $("#txtEscalateLevel2").val();
            var EscalateLevel2Unit = $("#CboEscalateLevel2").val();
            var EscalateLevel3Norm = $("#txtEscalateLevel3").val();
            var EscalateLevel3Unit = $("#CboEscalateLevel3").val();
            var EscalateLevel4Norm = $("#txtChkEscalateLevel4").val();
            var EscalateLevel4Unit = $("#CboChkEscalateLevel4").val();


            if ($("#chkSendAlert").is(':checked')) {
                IsSendAlert = 1;
            }
            else {
                IsSendAlert = 0;
            }

            if ($("#chkSendReminder").is(':checked')) {
                IsSendReminder = 1;
            }
            else {
                IsSendReminder = 0;
            }

            if ($("#ChkEscalateLevel1").is(':checked')) {
                IsEscalateLevel1 = 1;
            }
            else {
                IsEscalateLevel1 = 0;
            }

            if ($("#ChkEscalateLevel2").is(':checked')) {
                IsEscalateLevel2 = 1;
            }
            else {
                IsEscalateLevel2 = 0;
            }


            if ($("#EscalateLevel3").is(':checked')) {
                IsEscalateLevel3 = 1;
            }
            else {
                IsEscalateLevel3 = 0;
            }


            if ($("#EscalateLevel4").is(':checked')) {
                IsEscalateLevel4 = 1;
            }
            else {
                IsEscalateLevel4 = 0;
            }


            var ApplySLAData = [];
            // data = JSON.stringify({
            ApplySLAData.push({
                CboTemplateMaster: CboTemplateMaster, CboCustomer: CboCustomer, CboDepartment: CboDepartment, CboRequestType: CboRequestType, CboSubRequestType: CboSubRequestType, dtEffectivedate: dtEffectivedate, IsInternal: IsInternal, Type: Type,
                IsSendAlert: IsSendAlert, SendAlertNorm: SendAlertNorm, SendAlertUnit: SendAlertUnit,
                IsSendReminder: IsSendReminder, SendReminderNorm: SendReminderNorm, SendReminderUnit: SendReminderUnit,
                IsEscalateLevel1: IsEscalateLevel1, EscalateLevel1Norm: EscalateLevel1Norm, EscalateLevel1Unit: EscalateLevel1Unit,
                IsEscalateLevel2: IsEscalateLevel2, EscalateLevel2Norm: EscalateLevel2Norm, EscalateLevel2Unit: EscalateLevel2Unit,
                IsEscalateLevel3: IsEscalateLevel3, EscalateLevel3Norm: EscalateLevel3Norm, EscalateLevel3Unit: EscalateLevel3Unit, IsEscalateLevel4: IsEscalateLevel4, EscalateLevel4Norm: EscalateLevel4Norm, EscalateLevel4Unit: EscalateLevel4Unit, TimeZone: TimeZone, SLAID: SLAID, Confirm: ConfirmYesNo, OldTempalteID: CboTemplateMasterOld
            });
            data = JSON.stringify({ ApplySLAData: ApplySLAData });
            //  alert(data);

            var strResultSLA = AJAXCallWithResult("CRM_ApplySLA.aspx/SaveApplySLA", data, false);
            //  alert(strResult.d);
            //if (document.getElementById('hdnSLADetailsID').value == "0")
            //{ 
            //}
            if (strResultSLA.d != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('SLA applied successfully', 'success', 5);

                document.getElementById('hdnSLADetailsID').value = strResultSLA.d;
                //alert(strResult.d);
                //alert(CboTemplateMaster);
                //alert(Type);
                EditApplySLADetails("", strResultSLA.d, CboTemplateMasterOld, Type);

                RefreshGrid("ApplySLA", "Refresh");
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
        function CheckAlert(obj, Flag) {
            if (Flag == "SendAlert") {
                if (obj.checked == true) {
                    document.getElementById('txtSendAlert').disabled = false;
                    document.getElementById('CboSendAlert').disabled = false;
                    $("#txtSendAlert").prop('readonly', false);
                }
                else {

                    document.getElementById('txtSendAlert').disabled = true;
                    document.getElementById('CboSendAlert').disabled = true;
                    $("#txtSendAlert").val("");
                    $("#txtSendAlert").prop('readonly', true);
                }

            }
            if (Flag == "Escalation1") {
                if (obj.checked == true) {
                    document.getElementById('txtEscalateLevel1').disabled = false;
                    document.getElementById('CboEscalateLevel1').disabled = false;
                    $("#txtEscalateLevel1").prop('readonly', false);
                }
                else {

                    document.getElementById('txtEscalateLevel1').disabled = true;
                    document.getElementById('CboEscalateLevel1').disabled = true;
                    $("#txtEscalateLevel1").val("");
                    $("#txtEscalateLevel1").prop('readonly', true);
                }
            }
            if (Flag == "Escalation2") {
                if (obj.checked == true) {
                    document.getElementById('txtEscalateLevel2').disabled = false;
                    document.getElementById('CboEscalateLevel2').disabled = false;
                    $("#txtEscalateLevel2").prop('readonly', false);
                }
                else {
                    document.getElementById('txtEscalateLevel2').disabled = true;
                    document.getElementById('CboEscalateLevel2').disabled = true;
                    $("#txtEscalateLevel2").val("");
                    $("#txtEscalateLevel2").prop('readonly', true);
                }

            }
            if (Flag == "Escalation3") {
                if (obj.checked == true) {
                    document.getElementById('txtEscalateLevel3').disabled = false;
                    document.getElementById('CboEscalateLevel3').disabled = false;
                    $("#txtEscalateLevel3").prop('readonly', false);
                }
                else {
                    document.getElementById('txtEscalateLevel3').disabled = true;
                    document.getElementById('CboEscalateLevel3').disabled = true;
                    $("#txtEscalateLevel3").val("");
                    $("#txtEscalateLevel3").prop('readonly', true);
                }
            }
            if (Flag == "SendReminder") {
                if (obj.checked == true) {
                    document.getElementById('txtSendReminder').disabled = false;
                    document.getElementById('CboSendReminder').disabled = false;
                    $("#txtSendReminder").prop('readonly', false);
                }
                else {
                    document.getElementById('txtSendReminder').disabled = true;
                    document.getElementById('CboSendReminder').disabled = true;
                    $("#txtSendReminder").val("");
                    $("#txtSendReminder").prop('readonly', true);
                }
            }





        }

        function GetDepartment() {
            var CustomerID = $("#CboCustomerFilter").val();
            var url = "CRM_ApplySLA.aspx/GetDepartmentCustomer"
            var data = JSON.stringify({ strCustomerID: CustomerID })
            var strResultDepartment = AJAXCallWithResult(url, data, false);
            $("#divDepartmentFilter").html(strResultDepartment.d);
            GetFilterList();
        }

        function GetFilterList() {
            var CustomerID = $("#CboCustomerFilter").val();
            var DepartmentID = $("#CboDepartmentFilter").val();
            var slaAppliedOn = $("#CboTypeFilter").val();
            if (CustomerID == "0") {
                CustomerID = "";
            }
            if (DepartmentID == "0") {
                DepartmentID = "";
            }
            if (slaAppliedOn == "0") {
                slaAppliedOn = "";
            }
            var url = "CRM_ApplySLA.aspx/GetFilterData";
            var data = JSON.stringify({ strCustomerID: CustomerID, strDepartmentID: DepartmentID, strSLAAppliedOn: slaAppliedOn })
            var strResultDepartment = AJAXCallWithResult(url, data, false);
            document.getElementById("divtblApplySLA").innerHTML = "";
            document.getElementById("divtblApplySLA").innerHTML = strResultDepartment.d;
            //Added By Dipali V On 31th March 2023 For Datatable Issue
            if ($("#FilterApplySLA").val() > 0) {
                datatables("divApplySLA", "SearchSLA", 0)
            }
            //End of Added By Dipali V On 31th March 2023 For Datatable Issue
            //Added by Dipali V On 24th June 2019 For unable to select Dept on IE
            $("#CboDepartmentFilter").removeAttr("title");
            //End of Added by Dipali V On 24th June 2019 For unable to select Dept on IE
        }

        function Cancel_HelpDeskSLA() {



        }
        //End of Added By Vidya Jadhav ON 15 De 2017 For Configure User Groups Functionality
        //Added By Dipali V On 8th July 2019 for override functionality
        function Close_onclick() {

            $("#myOverride").hide();
        }
        //end of Added By Dipali V On 8th July 2019 for override functionality
    </script>




