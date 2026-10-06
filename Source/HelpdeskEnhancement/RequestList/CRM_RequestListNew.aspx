<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_RequestListNew.aspx.vb" Inherits="Whizible.CRM_RequestListNew" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <%CommonFunctions.General.PlotPageHeadTag("Request List New")%>
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
   
    <%--<title>Request List New</title>--%>
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Request List New")%>--%>
    <%--<%CommonFunctions.General.PlotPageHeadTag("Request List New")%>--%>
    <!-- Bootstrap core CSS -->
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />-->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" /> 
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
</head>

<style>
    .dropdown-item {
        /*Modified By Madhuri.K on 26-03-2026*/
        font-size: 12px;
    }
    .dropdown-menu.show {
        display: block!important;
    }
     .un-flag input {
        width: 154px!important;
    }
    .un-flag .fa.fa-calendar {
        position: relative;
        top: -25px;
        right: -134px;
    }
    #clsFilterLinks {
        position: relative;
        z-index: 1;
        background-color: white;
        padding: 21px 21px 10px;
        margin-top: 0px;
        margin-bottom: 0px;
    }

    .alertify-notifier li {
        word-break: normal !important;
        white-space: normal !important;
    }

    td label {
        font-weight: normal;
        /*word-break:break-all!important;/*Added By Dipali V On 14th July 2020 For Issue ID 25833*/
    }

    .help-desk {
        position: relative;
    }

    .affix {
        top: 49px;
        width: 100%;
        <!-- position: fixed; -->
    }

        .affix .row {
            background: #edf3f9;
        }

    .help-desk {
        float: left;
        width: 100%;
        z-index: 100;
    }

    .dropdown-menu {
        transform: translate3d(0px, 0px, 0px) !important;
        top: 100% !important;
    }

    .form-info span.glyphicon {
        background: #0bc813;
        border-radius: 50%;
        color: #fff;
        padding: 1px 4px;
    }

        .form-info span.glyphicon.glyphicon-minus {
            background: red;
        }

    td.hiddenRow tr td span {
        padding-left: 24px;
    }

    .table-responsive td.hiddenRow tr td {
        padding-top: 0 !important;
    }

    .table-responsive tr {
        width: 100%;
    }

    .glyphicon.glyphicon-minus {
        display: none;
    }

    .accordion-toggle.collapsed .glyphicon.glyphicon-plus {
        display: block;
    }

    .accordion-toggle .glyphicon.glyphicon-minus {
        display: block;
    }

    .accordion-toggle.collapsed .glyphicon.glyphicon-minus {
        display: none;
    }

    .accordion-toggle .glyphicon.glyphicon-plus {
        display: none;
    }

    /**------responsive 767 view---------------**/

    .table2 .panel1 {
        float: left;
        width: 100%;
        border: 1px solid #cfe9f5;
    }

        .table2 .panel1 .iner-bag {
            background-color: #eeeeee;
            float: left;
            width: 100%;
        }

    .table2 .head-panel, .table2 .head-desc, .table2 .assign-by {
        float: left;
        width: 100%;
        margin-bottom: 0;
    }

    .table2 ul.head-panel li, .table2 ul.head-desc li {
        float: left;
        padding-left: 14px;
        font-size: 11px;
        font-weight: 600;
        padding-bottom: 0;
        padding-top: 1px;
    }

    .table2 ul.head-desc, .table2 .assign-by {
        padding-left: 75px;
    }

        .table2 ul.head-desc li {
            padding-left: 0;
            padding-right: 22px;
        }

    .table2 ul li i {
        font-size: 15px;
    }

    .icons {
        float: left;
    }

    .table2 .assign-by li {
        padding-left: 0;
        font-size: 9px;
        font-weight: 600;
        float: left;
        border-top: 1px solid #e6e6e6;
        padding-right: 21px;
    }

    .table2 .hiddenRow input {
        width: 65px;
        padding-top: 3px;
    }

    .table2 .hiddenRow .head-desc button {
        border: 1px solid #d6d0d0;
        padding-top: 0;
        font-size: 11px;
    }

    .content-wrapper {
        margin-left: auto !important;
        padding-left: 0px !important;
    }

    @media only screen and (max-width:767px) {
        .icons {
            float: left;
            width: 100%;
        }
    }

    /****************************Added By Bharat T on 5th-Oct-2017**********************************/
    .clsTopNav li a.Active {
        border-bottom: 4px solid #f3565d;
    }

        .clsTopNav li a.Active:hover {
            border-bottom: 4px solid #f3565d;
        }

    .clsTopNav li a:not(.Active):hover {
        border-bottom: 4px solid #f7c1c3;
    }

    #divKnowledge, #divDashboard {
        display: none;
    }

    /*input.form-control,select.form-control,.dropdown-menu,#filterSpan,#clsSerachControl .form-control {
        font-size:12px !important;
    }*/

    .addedrow .field-section .form-control {
        margin-left: 22px;
        margin-right: 24px;
        font-size: 12px !important;
    }

    #spnFilterControl .form-control {
        width: 200px;
    }

    input.form-control, select.form-control {
        height: 30px !important;
    }

    .clsLoadFilterList {
     /*   height: 300px;*/
        overflow: auto;
    }

        .clsLoadFilterList a:not(:first-child):before {
            content: "\f0b0";
            font-family: FontAwesome;
            font-size: 14px;
            padding-right: 0.5em;
            top: 1px;
            left: 0;
            display: inline-block;
        }

    #seachValueList a:not(:first-child):before {
        content: "\f002"!important;
        font-family: 'Font Awesome 5 Free';
        font-size: 14px;
        padding-right: 0.5em;
        top: 1px;
        left: 0;
        display: inline-block;
    }
    /*.dropdown-menu a.dropdown-item {
        border-bottom: 1px solid #ddd;
    }*/

    /*#id16 .container {
        padding: 16px;
        width: 298px;
    }*/
    /*Reference from style.css*/
    ul.search-btn li input, .clsSerachControl .form-control {
        height: 30px !important;
    }
    /*End of Reference From style.css*/

    .clsControlHeight {
        height: 30px !important;
    }
    /*Reference from style.css*/
    .search-btn {
        width: auto;
    }

    .navPagination ul li {
        padding-left: 0px !important;
    }
    /*End of Reference From style.css*/
    /*Reference from style.css*/
    .action-btn {
        width: 850px;
    }

    #id03 .modal-content {
        /*width: 510px;*/
        height: 370px;
    }

    #id03 .container {
        /*width: 450px;*/
    }

    /*End of Reference From style.css*/

    #subMainDiv .table1 .panel:first-child {
        margin-bottom: 0px;
    }

    .new-req ul li:first-child {
        margin-left: 0px;
    }

    /*Reference From style.css*/
    .container-fluid {
        min-height: initial;
    }

    #id18 .modal-content {
        width: 350px !important;
        height: auto !important;
        max-height: 430px;
    }

    .form-info .table-responsive thead tr th {
        padding: 8px 8px !important;
        vertical-align: middle;
    }

    #id18 .modal-content {
        height: auto !important;
        max-height: 430px;
        width: 400px !important;
    }

    #id18 .container {
        width: 400px;
    }
    .apply_filter_btn{
         background: #e0e8f6;
        text-align: center;
        padding: 7px 12px;
        border-radius:8px;
    }
    .apply_filter_btn:hover{
         background: #e0e8f6;
        text-align: center;
        padding: 7px 12px;
        border-radius:8px;
    }

    .panel-title a {
        font-size: 15px;
        padding-top: 3px !important;
    }

    .panel-heading h3 {
        font-size: 15px;
        padding-top: 3px !important;
    }

    /*div#headingOne {
       padding: 3px 0px 27px 9px;
       height: auto!important;
    }*/
    div#headingOne {
        height: 43px!important;
    }
    #AppliedFilterDiv {
    padding-left:15px;
    }
    #collapseOne .fa-times {
        padding: 2px 4px;
    }
    /*End of Reference From style.css*/

    .clsHighlightBorder {
        border-color: red;
        outline: 0;
        -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(100,100,100,.6);
        box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(100,100,100,.6);
    }

    #preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 50%;
        left: 50%;
        padding: 30px 15px 0px;
        border: 3px solid #ababab;
        box-shadow: 1px 1px 10px #ababab;
        border-radius: 20px;
        background-color: white;
        background: url("../../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
        width: 90px;
        height: 90px;
        /*z-index: 99;
        height: 100%;*/
        background-repeat: no-repeat;
        background-position: center;
        margin: -100px 0 0 -100px;
        z-index: 1002;
        text-align: center;
    }

    #fillDiv {
        opacity: 0.4;
        background-color: ghostwhite;
        /*DISPLAY: none;*/
        Z-INDEX: 100;
        LEFT: 0px;
        VISIBILITY: visible;
        WIDTH: 100%;
        POSITION: absolute;
        TOP: 0px;
        HEIGHT: 100%;
        float: right;
    }

    .clsAssignToList, .clsRequestStatusList {
        height: 300px;
        overflow: auto;
    }




    #divRequestor .modal-content {
        width: 700px !important;
        height: 300px !important;
        overflow: hidden;
        font-size: 12px !important;
    }


    #divStatReq {
        width: 717px !important;
        height: 300px !important;
        overflow: auto;
        font-size: 12px !important;
    }

    /*#divStatistic th {
        background-color: #33c0df !important;
        color: white;
    }*/

    #divStatistic .table td, .table th {
        border-top: none !important;
    }

    #divStatistic {
        padding: 0px !important;
    }

    #divrequestorTable {
        padding: 0px !important;
    }

    #divRequestor > tr:nth-of-type(2n+1) {
        background-color: #f9f9f9 !important;
        border-top: none !important;
    }

    #divRequestor .animate.modal-content {
        /*background-color:transparent !important;*/
    }
    #MainDiv {
    width:100%;
    }
    .draggable { width: 90%; height: auto; padding: 0.5em; float: left; margin: 0 10px 10px 0; }

    /*#divrequestorTable th {
        background-color: #33c0df !important;
        color: white;
    }*/

    /*.imgcontainer {
    height:auto !important;
    }

    #divImportContainer {
    width:900px !important;
    }
    #id05 .modal-content {
    width:950px !important;
    }
    #id05 .modal-content {
    height:474px !important;
    }
    .modal {
    top:-100px;
    }
    #RequestColumsMapp {
    height:222px;
    overflow:auto;
    }*/

    #PageList {
        height: 330px;
        overflow: auto;
        width: 290px;
    }

        #PageList li {
            margin-left: 0px !important;
            width: 100%;
            display:inline-flex
        }

        #PageList .badge {
             /*Commented by Usha Pandit on 14.01.2019 for Default request alignment*/
            /*float: right;*/
            /*End of Commented by Usha Pandit on 14.01.2019 for Default request alignment*/
        }

        #PageList > li > a {
            padding: 0px;
            display: inline-block;
            width: 74%;
        }

    .clsUserSavedFilter li a {
        color: #262626 !important;
        display: inline-block;
        width: 95%;
    }

    .badge {
        background-color: #0275d8;
        min-width: 45px;
    }

    .clsFilterDefault {
        background-color: cadetblue;
    }

        .clsFilterDefault a {
            color: white;
        }

    #PageList li:not(#liSavedFilter):not(.clsFilterExpCol):hover, .clsUserSavedFilter li:hover {
        background-color: #a2d4d6;
    }

    .clsUserSavedFilter a:hover, #PageList li a:hover {
        background: none !important;
    }

    .sortingApplied {
        background-color: grey;
        color: white;
    }

    #id18 label {
        font-weight: normal;
    }

    #id01 .modal-content {
        height: auto;
        max-height: 480px;
        width: 450px;
    }

    #divFeedbackModal .form-group {
        float: left;
    }

    #divFeedbackModal form {
        background-color: white;
        width: 400px;
    }

    #divGrid > table thead.clsTRColumnHeader th {
        text-align: center;
        background-color: #e9ecef;
    }




    .clsFilterExpCol a {
        background-color: white !important;
    }

        .clsFilterExpCol a i {
            padding: 0px 0px 0px 15px !important;
        }

    input:not([type=button]), .form-control {
        font-size: 12px;
        margin-top: 0px !important;
    }

    td.hiddenRow table td {
        vertical-align: middle;
    }

    /*Feedback div css*/
    .checked1 {
        color: orange;
    }

    .checked {
        color: orange;
        font-size: 20px;
    }

    #SpnRatingMsg {
        font-size: 12px;
        text-align: center;
        margin-left: -15%;
    }

    .clslabel {
        font-size: 12px !important;
        font-weight: normal !important;
    }

    #btngroupcnlsave {
        /*float: right !important;*/
    }

    #lblfeedback {
        margin-left: -4% !important;
        font-size: 12px !important;
    }

    #btnsave {
        background-color: #364660 !important;
        color: white;
    }

    #btncancel {
        background-color: #364660 !important;
        color: white;
    }

    #Feedbackdata {
        width: 100% !important;
    }

    #Feedback .modal-content {
        width:auto!important;
        height:auto!important;
        background-color: #fefefe;
        /*margin: 5% auto 15% auto;*/
        border: 1px solid #888;
        /*width: 735px !important;
        height: 282px !important;*/
    }


    .imgFeedback {
        /* background-color:#364660!important;*/
        color: white !important;
    }

    #divfeedback {
        width: 100% !important;
    }

    .tblfeedback {
        width: 100% !important;
    }

  

        /*.tblfeedback tr td {
            width: 22% !important;
            border-left: none;
            text-align: left;
        }*/
        .tblfeedback tr td {
             width: 19% !important;
              text-align: left!important;
        }

        .tblfeedback tr {
            height: 30px !important;
        }

    th.divGrid {
        position: relative;
    }

    #tblRequestList thead tr {
        position: relative;
    }
    /*end of feedback div css*/

    #header-fixed {
        position: fixed;
        top: 0px;
        display: none!important;
        background-color: white;
    }

        #header-fixed th {
            text-align: center;
            padding: 5px 8px !important;
            border: 1px solid white;
        }

    .down-info table:last-child {
        background-color: transparent;
    }

    .alertify-notifier .ajs-message {
        width: 300px;
        word-break: break-word;
    }
    /*.btnClearFilter span{
    background: #343660;
    padding: 1px;
    color: #fff !important;
    border-radius: 50%;
    margin-left:5px;
    }*/
    /*LoadFilterQueryText css*/
    .tag {
        font-size: 12px;
        padding: .3em .4em .4em;
        /*margin: 0 .1em;*/
        /*display:table;*/
       /* margin: auto;*/
       MARGIN-LEFT: 303PX;
        /*margin-top:10px;*/
    }

        .tag a {
            color: #bbb;
            cursor: pointer;
            opacity: 0.6;
        }

            .tag a:hover {
                opacity: 1.0;
            }

        .tag .remove {
            vertical-align: bottom;
            top: 0;
        }

        .tag a {
            margin: 0 0 0 .3em;
        }

            .tag a .glyphicon-white {
                color: #fff;
                /*margin-bottom: 2px;*/
            }
    /*ENd of LoadFilterQueryText css*/

    #id01 .container {
        width: 450px;
    }

    /*.multi-action {
        padding-left: 50px;
    }*/
    .btnClearFilter span {
        padding: 3px;
    font-size: 13px!important;
    }
    .apply-btn {
        display: block;
    }

    #addFilter {
        margin-left: 0px;
    }
    /*Reference From style.css*/
    .diff-action {
        width: 70%;
        margin: 19px 0px 0px 0px;
    }
    /*End of Reference From style.css*/

    .read-more-state {
        display: none;
    }

    .read-more-target {
        opacity: 0;
        max-height: 0;
        font-size: 0;
        transition: .25s ease;
    }

    .read-more-state:checked ~ .read-more-wrap .read-more-target {
        opacity: 1;
        font-size: inherit;
        max-height: 999em;
    }

    .read-more-state ~ .read-more-trigger:before {
        content: 'Show more';
    }

    .read-more-state:checked ~ .read-more-trigger:before {
        content: 'Show less';
    }

    .read-more-trigger {
        cursor: pointer;
        display: inline-block;
        text-decoration: underline;
        padding: 0 .5em;
        color: #666;
        font-size: .7em;
        line-height: 2;
        border: 1px solid #ddd;
        border-radius: .25em;
    }
    #divPickupLabelAndGridParent {
        overflow:hidden;
    }
    #divApproveRejectValidationMsg, #divPickupLabelAndGrid {
        overflow: auto;
        width: 109%!important;
        padding-right: 5%;
    }

        #divApproveRejectValidationMsg:hover, #divPickupLabelAndGrid:hover {
            /*overflow: auto !important;*/
        }

    .imgcontainer:hover {
        text-align: center !important;
        position: relative;
        background: #364660 !important;
        color: #fff !important;
    }

    .table-responsive thead {
        background: #eeeeee !important;
    }

    .card {
        display: block;
        background: none !important;
        border: 0px;
    }

    .card-body p {
        margin-bottom: 0px;
    }

    #divPickupLabelAndGrid, #divApproveRejectValidationMsg {
        border-bottom: 1px solid #ddd;
        font-size: 12px;
    }

    .card-body {
        padding: 0px;
    }

    #divAttachment {
        /*width: 495px !important;
        margin-left: -8% !important;*/
    }

    #id03 .modal-content {
    width:auto!important;
    }
    button.btn.btn-default.download {
        margin-right: -6%;
            margin-top: -6px;
    }

    #subMainDiv .multi-drop {
        float: right !important;
        margin-right: 119px !important;
    }

    /****************************End of Added By Bharat T on 5th-Oct-2017**********************************/

    /***************************Added By Vidya J on 6- Nov-2017 For Import Functionality CSS**********************************/
    .liRequestByST select {
        MARGIN-TOP: 0PX !IMPORTANT;
    }

    .imgcontainer {
        height: auto !important;
    }

    #divImportContainer {
        width: 900px !important;
    }

    .imgcontainer {
        height: auto !important;
    }

    #divImportContainer {
        width: 900px !important;
    }

    #id05 .modal-content {
        width: 950px !important;
    }

    #id05 .modal-content {
        height: 495px !important;
    }

     /*commented by Ankush T on 26-dec-2018 */
    /*.modal {
        top: -100px;
    }*/
    /*End of commented by Ankush T on 26-dec-2018*/ 
    #RequestColumsMapp {
        height: 232px;
        overflow: hidden;
        width: 100%;
        margin-top: 30PX;
    }

    #RequestColumsMappScroll {
        height: 232px;
        overflow: auto;
        /*padding-right:2%;*/
        width: 106%;
    }

     /*commented by Ankush T on 26-dec-2018*/
    /*.modal {
        top: -125px;
    }*/
     /*End of commented by Ankush T on 26-dec-2018*/
    #file {
        display: none;
    }

    #tblFileDetails {
        overflow: hidden;
        /*height: 210px;*/
        height: 232px;
        width: 100%;
    }

    .preview-table {
        /*height:298px;*/
        height: 285px;
        /*overflow: auto;
        overflow-x:hidden;*/
    }

        .preview-table .table {
            /*height:298px;*/
            height: 285px;
            margin: 14px;
            width: 94%;
            /*overflow: auto;
            overflow-x:hidden;*/
        }

    .clsErrorDesc {
        color: red;
    }

    #btnSave {
        background-color: #364660;
        margin-left: 13px;
        color: white;
    }

    ul.clsErrorDesc {
        width: 100%;
        padding-left: 20px;
        margin-right: 14px;
    }

        ul.clsErrorDesc li {
            white-space: nowrap;
        }

    .clsInValidRow {
        color: red;
    }

    .clsValidRow {
        color: green;
    }

    #tblFileDetails .table td, th {
        border-color: #ddd;
    }

    #tblFileDetails .table {
        border: 0.5px solid #ddd;
        border-spacing: 7px 6px 5px 13px;
        margin: 0px;
    }

    #lblAttachmentName {
        font-weight: normal;
    }

    #lblUploadedByName {
        font-weight: normal;
        margin-left: 5px;
    }

    #RequestColumsMapp {
        border: 1px solid #ddd;
        margin-right: 8px;
        margin-left: -15px;
    }

    .clslabelColumns {
        font-size: 13px !important;
        font-weight: normal !important;
        /*margin-left:15px !important;*/
    }

    #RequestColumsMapp .row {
        border-bottom: 1px solid #ddd;
        margin-right: 0px !important;
        margin-left: 0px !important;
    }

    #tblFileDetails .table {
        text-align: center;
    }

    .clsvalidRowIndication {
        text-align: center;
    }

    #divDetails {
        padding-left: 0px !important;
    }

    #tblFileDetails .table th, td {
        /*border-left: 1px solid #ddd;*/
        text-align: center;
    }

    #tblFileDetails table td {
        font-weight: normal;
    }

    #tblFileDetails .table tr {
        border-bottom: 1px solid #ddd;
    }

    .col-table .form-control {
        font-size: 13px;
    }

    .FixedTD {
        /*background-color:#F0D1A1;/*#e6ffff*/
        padding: 5px !important;
        position: relative;
        background-clip: padding-box;
        border: 1px solid white;
    }

    #tblFileDetails .table thead > tr > th {
        position: relative;
        left: 0px;
        padding: 5px;
        z-index: 99999;
    }

    #idDivExcelDetails .preview-table thead tr {
        background-color: transparent !important;
    }

    #idDivExcelDetails .preview-table thead th {
        background-color: rgb(238, 241, 246) !important;
    }

    #idDivExcelDetails .col-table {
        margin-top: 0px !important;
    }

    #id05 label {
        font-weight: normal;
        font-size: 13PX;
    }

    #imgUploaded {
        height: 25px;
        width: 25px;
    }

    .preview-table h4 {
        padding: 6px 0;
    }

    .tableHeader {
        MARGIN-TOP: 6PX;
    }

        .tableHeader td {
            MARGIN-TOP: 9PX;
            border-left: none;
        }

    #btnSelectFile {
        /*BACKGROUND-COLOR: #364660;
        COLOR: WHITE;*/
        FONT-SIZE: 13PX;
        FONT-WEIGHT: NORMAL;
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

    #id05 .pre-title {
        font-weight: normal !important;
        padding-left: 17px;
    }

    #id05 .close {
        color: white;
        font-size: 24px;
        font-weight: normal;
        opacity: 5;
        margin-top: 6px;
    }

    .tableHeader {
        float: right;
        margin-right: 9px;
    }

    .preview-table h4 {
        padding: 6px 0;
    }
    /*label{    
        position: absolute;
        top: 1px;
        right: 5%;
        color: #00a65a;
        display: inline-block;
        max-width: 100%;
        margin-bottom: 5px;
        font-weight: bold;
    }*/
    .color-box {
        /*margin-top: 20px;
        padding-left: 17px;*/
        MARGIN-BOTTOM: 10px;
    }

    .shadow {
        /*background: #F7F8F9;*/
        background-color: #eef1f6;
        padding: 3px;
        margin: 10px 0;
    }

    .color-box .shadow {
        margin: 0;
        PADDING: 0PX;
    }

    .note-icon {
        background-position: 0 0;
        COLOR: #364660;
        FONT-SIZE: 18PX;
    }

    

    .info-tab {
        width: 36px;
        height: 50px;
        float: left;
        margin-left: -21px;
        position: relative;
        /*top: 6px;*/
        background: url(/lib/images/sprite.png) no-repeat;
    }

    .note-box, .warning-box, .tip-box {
        /*padding: 0 15px 15px 25px;*/
        padding: 0 0px 0px 0px;
    }

        .note-box label {
            margin-bottom: 0px;
            color: red;
        }

    .color-box span {
        /*padding-top: 12px;*/
        font-size: 10px !important;
        font-weight: normal;
    }

    .color-box label {
        font-size: 10px !important;
        font-weight: normal;
    }

    #tblFileDetails {
        margin: 0px;
        padding: 0px;
        margin-left: 13PX;
    }

    .bros-btn {
        float: right;
        margin: 0px -16px 0px 7px;
    }

    #id05 .appro-title {
        line-height: 36px;
    }

    .fa-lightbulb-o {
        COLOR: rgb(220, 213, 13);
        FONT-SIZE: 24PX;
        FONT-WEIGHT: 500;
    }

    #RequestColumsMappScroll .row {
        padding-bottom: 4px;
        padding-top: 4px;
    }

    .alertify-notifier .ajs-message {
        width: 300px;
        word-break: break-word;
    }

    .bros-btn .btn-default {
        font-size: 13px;
    }
    /****************************End of Added By Vidya J on 6- Nov-2017**********************************/
    /*Added by yogesh Jalamkar on 17-NOV-2017 Purpose: Column should have border*/
    #divGrid > table td {
        border-right: 1px white solid !important;
    }

    /*Added By Usha Pandit On 07.09.2020 For text wrap issue*/
    #tblRequestList tbody tr td:nth-child(6) label {
            width:100px; word-wrap:break-word;
        }
    /*End Of Added By Usha Pandit On 07.09.2020 For text wrap issue*/

    /*#divGrid {
    overflow-x:hidden!important;
    }*/ /*Commented by pradip on 23-2-2021*/

    .form-info.table1 tr td {
        border-top: none !important;
    }

    td.hiddenRow {
        border-bottom: 1px solid black !important;
    }
    /*End of addition by YOgesh Jalamkar*/
    .clsMandatoryCol {
        color: red;
    }

    #tblFileDetails table td {
        font-weight: normal;
    }

    #id05 {
        z-index: 1;
    }

    #tblValidateFile {
        overflow: auto;
        width: 103%;
        padding-right: 6px;
        height: 232px;
    }

    #lblRequestIDAttachments {
        margin-left: -5%;
    }

    .dropdown-menu li {
        cursor: pointer;
        width: 100%;
    }

    .panel-body {
        padding-top: 5px;
    }

    .panel-group {
        margin-bottom: 5px;
    }

    #divStatistic table td:first-child {
        text-align: left !important;
    }

    #divStatistic table th {
        text-align: center !important;
    }

        #divStatistic table th:nth-child(1) {
            text-align: left !important;
        }

    #divrequestorTable table thead th {
        text-align: left !important;
    }

    #divrequestorTable table tbody td {
        text-align: left !important;
    }

    #ulAction li {
        margin: 0px;
    }

    .bs-tooltip-bottom {
        display: none !important;
    }

    .bs-tooltip-top {
        display: none !important;
    }

    .bs-tooltip-right {
        display: none !important;
    }

    #id02 .modal-content {
        width: 100% !important;
        height:100%  !important;
    }

        #id02 .modal-content .container {
            width: 100%;
        }

            #id02 .modal-content .container .col-sm-6 {
                text-align: center;
            }

                #id02 .modal-content .container .col-sm-6 button {
                    margin-left: 65px;
                }

    .un-flag .col-sm-4 {
        width: 66%;
    }

    .un-flag .col-sm-8 {
        width: 33%;
    }

    #cbFlagTo {
        width: 100% !important;
    }
    input[type=checkbox], input[type=radio] {
        margin: 4px 0 0!important;
    }
    .multi-action .btn-group.drp .btn {
        margin-left: 0px;
    }
    #ulAction {
        width:150px!important;
        min-width:auto!important;
    }
    #ulAction li {
        padding-left: 10px;
        /*text-align:center;*/

    }

     /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
    .form-control:-ms-input-placeholder { /* IE 10+ */
      color: #bbb!important;
    }

     /*Added by Usha Pandit on 09 JAN 2018 for Close button Alignment in Filter*/
    .removethis, .removelast {
        /*margin-left: 67px;*/  
        /*margin-left: 140px;*/        /*Added by Usha on 10 JAN 2018 for Filter alignment*/
        margin-top: 8px;        /*Added by Usha on 10 JAN 2018 for Filter alignment*/
    }
     /*End of Added by Usha Pandit on 09 JAN 2018 for Close button Alignment in Filter*/

      #divfeedback tblfeedback {
        width:100%!important;
    }

     #divfeedback tblfeedback tr td{
        width:20%!important;
    }

    #Feedbackdata {
        margin-top:2%!important;
        margin-bottom: 15px;
    }
    #divfeedback table tr td {
        border:none!important;
          border-left:none!important;
    }
      .alertify-notifier {
            font-family: "Open Sans",sans-serif!important;
            font-size: 14px !important;
            display:inline-block;
            word-break:normal;
            white-space:pre-wrap;
        }
      .apply-btn {
        margin: 23px 15px 10px !important;
    }
    #tblfeedback td {
    text-align:left!important;
    }
    #btngroupcnlsave1 .btn-default {
        padding: 2px 10px;
    }
    /*Added By Yasmin S on 20-11-18 for alignment of pagination*/
    #frmRequestListNew .top-pagination {
        margin: 5px 15px 1px!important;
    }
    .field-section .value {
        width: 100%!important;
        float: left;
    }


    /*Added By Dipali V On 4th Dec 2020 For Import pop Get Scorll*/
    RequestColumsMappScroll {
        height: 232px;
        overflow: auto;
        padding-right: 4%!important;
        width: 100%!important;
    }


    .trac-detail {
        width: 89% !important;
        margin-left: 20px;
    }

    .Clscontrol {
        z-index:1;
    }

    /*Added & Commented By Dipali V On 18th Jan 2020 For Aligment Issue*/
    .form-info .table-responsive .btn.btn-default span img {
        display: none;
    }
    .panel-title a i img {
        display: none;
    }
     /*End of Added & Commented By Dipali V On 18th Jan 2020 For Aligment Issue*/

     /*Added style by Pradip 23-02-2021*/
 
    .gridtblheight{ overflow-y: auto; }
        .gridtblheight > div#divGrid thead th {
            position: sticky;
            top: -1px;
        }            
    .form-info span.glyphicon { position:static;}
    /*End Added by Pradip on 23-02-2021*/
    .btn_modal{
        color: #fff;
        background-color: #364660;
        height: 31px;
        border-radius: 8px!important;

    }
    .btn_modal:hover{
        color: #fff;
        background-color: #364660;
        height: 31px;
        border-radius: 8px!important;

    }
    #addFilter{
        box-shadow: 1px 1px 1px grey!important;
    }
    body .new-req ul li {  
        margin-left: 5px;
    }
    #tblRequestList td {
        white-space: nowrap;
    }
    .tooltip{z-index:999999;}
    #EditFilter,#DeleteFilter{
        opacity:2;
        color:cornflowerblue!important;
        background-color:none !important;
        text-decoration:underline;
    }

    .glyphicon-minus:before {
        content: "\2212";
    }

    .fa-flag{color: #f88394 !important;font-size: 14px;}
    .fa-comments{color: #33c0df !important;font-size: 16px;position: relative;}
    .form-info .fa-edit {color: #2e90e6 !important;font-size: 14px;}
    .fa-paperclip{color:#888;font-size:14px}
    .fa-comments span {position: absolute;top: -8px;font-size: 11px !important;background: #ff1744;color: #fff;padding: 1px 4px;left: 14px;}
    .new-req .fa-sync-alt {padding: 4px;border: 1px solid #c0c5ce;text-align: center;}
    .field-section.field-sec1{display:inline-flex}
    .dropdown-toggle::after {
        display: inline-block!important;
        margin-left: 0.255em!important;
        vertical-align: 0.255em!important;
        content: ""!important;
        border-top: 0.3em solid!important;
        border-right: 0.3em solid transparent!important;
        border-bottom: 0!important;
        border-left: 0.3em solid transparent!important;
    }
    .dropdown-menu .divider {
        height: 1px;
        margin: 9px 0;
        overflow: hidden;
        background-color: #e5e5e5;
    }
    .clsGridTable  tr th, .clsGridTable  tr td{border:1px solid #ddd}
    .table-bordered>thead>tr>td, .table-bordered>thead>tr>th {border-bottom-width: 2px;}
    .search-btn li:first-child{display:none}
    #divFileUploaedBy{display:flex}
    #RequestColumsMappScroll.row{display:flex}
    .bros-btn.importbtn3 .btn{margin: 10px 0px;}

    /*'Commented & added by dipali v on 21st march 2023 button issue*/
            .clsfeedback {
                border:1px solid lightgrey;
            }
    /*'End of Commented & added by dipali v on 21st march 2023 button issue*/

    /*Added By Dipali V On 27th March 2023 For UI Issue*/
    .field-section{display: inline-flex;}
    /*End of Added By Dipali V On 27th March 2023 For UI Issue*/

    #CnfDeleteFilter .modal-content {
        height: auto !important;
        width: auto !important
    }

    #CnfDeleteFilter .modal-header {
        background: #364660;
        color: #fff;
    }
    /* Added by Gauri on 24th Sep 2024 for Description Icon Issue */
    .glyphicon-plus:before {
        content: "\2b";
    }
    .modal {
        background: rgba(0,0,0,0);
    }
    /* End of Added by Gauri on 24th Sep 2024 for Description Icon Issue */
</style>

<body class="">
    <%-- Hidden Fileds for page wise by bharat t --%>
    <input type="hidden" id="hdnMode" name="hdnMode" value="DefaultSR" />
    <input type="hidden" id="hdnFilterQuery" name="hdnFilterQuery" value="" />
    <input type="hidden" id="hdnLoadFilterID" name="hdnLoadFilterID" value="" />

    <input type="hidden" id="hdnNewFilterID" name="hdnNewFilterID" value="" />
    <%-- End of Hidden Fileds for page wise by bharat t --%>

    <form id="frmRequestListNew" enctype="multipart/form-data" method="post">
        <div id="MainDiv" style="overflow: auto;">

            <div class="content-wrapper">

                <div class="container-fluid">
                    <!---- HelpDesk---------------------->
                    <%--	<div class="help-desk" data-spy="affix" data-offset-top="100">
							<div class="row">						
									<div class="req-dsk-kn new-req-head">									
									<div class="col-md-12">
									<ul class="clsTopNav">										                                       
										<li><a href="#" class="Active" Mode="All">Requests</a></li>  
										<li><a href="#" Mode="Dashboard">Dashboard</a></li> 
										<li><a href="#" Mode="KM">Knowledge</a></li>
                                        
										<li class="new-r-btn"><button type="button" onclick="AddNew_OnClick()" class="btn btn-default">New Request<i class="fa fa-plus" aria-hidden="true"></i></button></li>
                                        <li style="float: right;padding-right: 0;" class="setting-btn"><button type="button" class="btn " style="border: none;padding: 0;" title="Setting"><i class="fa fa-cog" aria-hidden="true"></i></button></li>
									</ul>
									</div>
									</div>
									
							</div>
			</div>--%>

                    <div id="subMainDiv" class="clsSubMainDiv">
                        <div class="new-req" id="clsFilterLinks">
                            <div class="new-req-btn">
                                <div class="row">
                                    <div class="col-md-6 Clscontrol" id="Clscontrol" style="padding-left: 0px !important;">
                                        <ul class="action-btn" style="padding-left: 1rem;">
                                            <li><%--style="margin-top: -6px;"--%>

                                                <div class="btn-group">
                                                    <div style="display: inline-block; float: left">
                                                        <button type="button" class="btn dropdown-toggle-split clsControlHeight" data-toggle="tooltip" title='More Actions' data-bs-placement='bottom' data-bs-toggle="dropdown" aria-haspopup="true" style="margin-right: 5px;" aria-expanded="false">
                                                            <span class="fa fa-bars" style="padding: 0px"></span>
                                                        </button>

                                                        <ul class="dropdown-menu" role="menu" id="ulAction">
                                                            <%If m_blnHRM = True Then%>
                                                            <li>

                                                                <div class="btn-group drp clsAssgnToSection" style="display: none;">
                                                                    <span id="spnAssignToName" style="border-bottom: 4PX SOLID #f9a5a5;"></span>
                                                                    <span id=""><a href="#" style="font-size: 12px;" onclick="document.getElementById('divAssignedTo').style.display='block'">AssignTo </a></span>
                                                                    <span id=""><i class="fa fa-clock-o" onclick="document.getElementById('divAssignedTo').style.display='block'"></i></span>

                                                                    <input type="hidden" id="hdnAssignToId" name="hdnAssignToId" />
                                                                </div>

                                                            </li>
                                                            <%End If%>
                                                            <li style="z-index: 1;" onclick="ShowImportDetails(this)" data-toggle="tooltip" data-bs-placement="right" title="Upload Requests in Bulk XLS or XLSX formats">
                                                                <i class="far fa-file-import"></i>
                                                                Import
                                                            </li>
                                                            <%If HttpContext.Current.Session("LoginType") <> "C" Then%>
                                                            <li data-toggle="tooltip" title="Assign Request to yourself" data-bs-placement="right" onclick="Pickup_OnClick();">
                                                                <i class="fa fa-shopping-cart"></i>
                                                                Pickup
                                                              
                                                           
                                                            </li>
                                                            <%End If%>
                                                            <%If m_bitApproveAccess = True Then%>
                                                            <li onclick="ApproveRejectClick();" data-toggle="tooltip" data-bs-placement="right" title="Approve or Reject the Request">
                                                                <i class="fa fa-check"></i>
                                                                Approve / Reject
                                                            
                                                            </li>
                                                            <%End If%>
                                                            <%If HttpContext.Current.Session("LoginType") <> "C" Then%>
                                                            <%End If%>
                                                        </ul>
                                                    </div>
                                                    <%If HttpContext.Current.Session("LoginType") = "E" Then%>
                                                    <button type="button" class="btn clsControlHeight"><span class="clsPageName">Submitted Requests</span></button>
                                                    <%Else%>
                                                    <button type="button" class="btn clsControlHeight"><span class="clsPageName">Submitted Requests</span></button>
                                                    <%End If%>
                                                    <div style="display: inline-block!important;">
                                                        <button type="button" class="btn dropdown-toggle dropdown-toggle-split clsControlHeight" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <span class="sr-only">Toggle Dropdown</span>
                                                        </button>

                                                        <ul class="dropdown-menu" id="PageList" role="menu">
                                                            <%If HttpContext.Current.Session("LoginType") = "E" Then%>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" id="chkAll" data-toggle="tooltip" data-bs-placement="right" title="Set As Default" onclick="SetDefault_SavedFilter('All')" />&nbsp;<a href="#" mode="All"> All Requests </a><span id="spnAll" class="badge"></span></li>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" id="chkDefaultSR" data-toggle="tooltip" data-bs-placement="right" title="Set As Default" onclick="SetDefault_SavedFilter('DefaultSR')" />&nbsp;<a href="#" mode="DefaultSR"> Submitted Requests </a><span id="spnSR" class="badge"></span></li>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" id="chkMR" data-toggle="tooltip" title="Set As Default" data-bs-placement="right" onclick="SetDefault_SavedFilter('MR')" />&nbsp;<a href="#" mode="MR"> My Requests </a><span id="spnMR" class="badge"></span></li>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" id="chkFR" data-toggle="tooltip" title="Set As Default" data-bs-placement="right" onclick="SetDefault_SavedFilter('FR')" />&nbsp;<a href="#" mode="FR"> Flagged Requests </a><span id="spnFR" class="badge"></span></li>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" id="chkRFA" data-toggle="tooltip" title="Set As Default" data-bs-placement="right" onclick="SetDefault_SavedFilter('RFA')" />&nbsp;<a href="#" mode="RFA"> Request for Approval </a><span id="spnRFA" class="badge"></span></li>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" id="chkRAR" data-toggle="tooltip" title="Set As Default" data-bs-placement="right" onclick="SetDefault_SavedFilter('RAR')" />&nbsp;<a href="#" mode="RAR"> Request Accepted & Rejected</a> <span id="spnRAR" class="badge"></span></li>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" disabled="disabled" style="visibility: hidden;" />&nbsp;<a href="#" mode="RBS"> Request by Status </a></li>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" disabled="disabled" style="visibility: hidden;" />&nbsp;<a href="#" mode="RBT"> Request By Time</a></li>
                                                            <li class="divider"></li>
                                                            <li class="clsFilterExpCol">
                                                                <a href="#" id="ancToggle" onclick="ToggleList();">
                                                                    <i class="fa fa-plus"></i>
                                                                    Saved Filters </a></li>
                                                            <li class="" id="liSavedFilter" style="display: none;">
                                                                <ul class="clsUserSavedFilter"></ul>
                                                            </li>
                                                            <%Else%>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" id="chkDefaultSR" data-toggle="tooltip" data-bs-placement="top" title="Set As Default" onclick="SetDefault_SavedFilter('DefaultSR')" />&nbsp;<a href="#" mode="DefaultSR">Submitted Requests </a><span id="spnSR" class="badge"></span></li>
                                                            <%--<li class="dropdown-item" ><input type="checkbox" name="clsFilter" id="chkFR" data-toggle="tooltip" title="Flagged Requests" onclick="SetDefault_SavedFilter('FR')"  />&nbsp;<a href="#" Mode="FR">Flagged Requests </a><span id="spnFR" class="badge">11</span></li>--%>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" disabled="disabled" style="visibility: hidden;" />&nbsp;<a href="#" mode="RBS">Request by Status</a></li>
                                                            <li class="dropdown-item">
                                                                <input type="checkbox" name="clsFilter" disabled="disabled" style="visibility: hidden;" />&nbsp;<a href="#" mode="RBT">Request By Time</a></li>
                                                            <li class="divider"></li>
                                                            <li class="clsFilterExpCol">
                                                                <a href="#" id="ancToggle" onclick="ToggleList();">
                                                                    <i class="fa fa-plus"></i>
                                                                    Saved Filters </a></li>
                                                            <li class="" id="liSavedFilter" style="display: none;">
                                                                <ul class="clsUserSavedFilter"></ul>
                                                            </li>
                                                            <%End If%>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </li>
                                            <%-- Added By Bharat T on 10th-Oct-2017 for nextgen product enhancment change --%>
                                            <li class="liRequestByST" style="display: none;">
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboFilter", "usp_NG2_CRM_FilterListForCombo " & m_lngEmployeeID, 120, m_lngFilterID.ToString, "class='form-control clsHighlightBorder' Onchange=javascript:cboFilter_OnChange()", False)%>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("cboDateFilter", "usp_NG2_SEL_tbl_CRM_DateFilter", 200, m_DateFilter, "class='form-control clsHighlightBorder' onchange=javascript:cboDateFilter_OnChange()", False, False)%>
                                            </li>
                                            <%-- End of Added By Bharat T on 10th-Oct-2017 for nextgen product enhancment change --%>


                                            <li>
                                                <button type="button" class="btn btnRefresh clsControlHeight" style="border: none; padding: 0;" data-toggle="tooltip" data-bs-placement="right" title="Refresh"><i class="fas fa-sync-alt" aria-hidden="true"></i></button>
                                            </li>
                                            <%-- <li>
                                                <button style="z-index: 1;" onclick="ShowImportDetails(this)" type="button" class="btn btn-default clsControlHeight" data-toggle="tooltip" title="Upload Requests in Bulk XLS or XLSX formats">Import</button></li>--%>
                                            <li>
                                                <div class="btn-group" style="z-index: 1;">
                                                    <button type="button" class="btn clsControlHeight" data-toggle="tooltip" data-bs-placement="right" title="Show Report" data-bs-container="body"><span>Export</span><i class="far fa-file-pdf" aria-hidden="true"></i></button>
                                                    <button type="button" class="btn dropdown-toggle dropdown-toggle-split clsControlHeight" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                    </button>
                                                    <div class="dropdown-menu">
                                                        <a class="dropdown-item" href="#" onclick="Export_OnClick('PDF')">PDF</a>
                                                        <a class="dropdown-item" href="#" onclick="Export_OnClick('HTML')">HTML</a>
                                                        <a class="dropdown-item" href="#" onclick="Export_OnClick('RTF')">RTF</a>
                                                        <a class="dropdown-item" href="#" onclick="Export_OnClick('EXCEL')">Excel</a>
                                                        <a class="dropdown-item" href="#" onclick="Export_OnClick('CSV')">CSV</a>
                                                        <a class="dropdown-item" href="#" onclick="Export_OnClick('TEXT')">Text</a>
                                                        <a class="dropdown-item" href="#" onclick="Export_OnClick('XML')">XML</a>
                                                        <%--<div class="dropdown-divider"></div>--%>
                                                        <%--<a class="dropdown-item" href="#">Separated link</a>--%>
                                                    </div>
                                                </div>
                                            </li>
                                            <%If m_blnHRM = True Then%>
                                            <li>
                                                <div class="btn-group drp">
                                                    <button class="btn btn-default clsControlHeight" type="button">
                                                        <i class="fa fa-search"></i>
                                                    </button>
                                                    <button type="button " class="btn clsControlHeight" style="width: 85px;">Assign to</button>
                                                    <button type="button" class="btn dropdown-toggle dropdown-toggle-split clsControlHeight" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                    </button>

                                                    <div class="dropdown-menu clsAssignToList">
                                                        <%AssignToResourceList()%>
                                                    </div>
                                                </div>
                                            </li>
                                            <%End If%>
                                        </ul>
                                    </div>
                                    <div class="col-md-6" style="padding-right: 0px !important;">
                                        <ul class="search-btn">
                                            <li>
                                                <select class="selectpicker" data-style="btn-primary" style="display: none;">
                                                    <option data-icon="glyphicon glyphicon-music">Mustard
									  <option data-icon="glyphicon glyphicon-star">Ketchup
									  <option data-icon="glyphicon glyphicon-heart">
                                                    Relish
                                                </select>


                                            </li>
                                            <li>
                                                <div class="btn-group clsFilterName" filtername="">
                                                    <button type="button" class="btn clsControlHeight" style="padding: 0 4px;"><i class="fa fa-search" aria-hidden="true" data-toggle="tooltip" data-bs-placement="right" data-bs-container='body' title="Select filter to search in grid"></i></button>
                                                    <button type="button" class="btn dropdown-toggle dropdown-toggle-split clsControlHeight" data-bs-toggle="dropdown"  aria-haspopup="true" aria-expanded="false" style="z-index: 1035;">
                                                        <span id="filterSpan" style="font-size: 12px !important;"  ></span>&nbsp;
										<span class="sr-only">Toggle Dropdown</span>
                                                    </button>
                                                    <div class="dropdown-menu" id="seachValueList">
                                                        <a class="dropdown-item" href="#">Action</a>
                                                        <a class="dropdown-item" href="#">Another action</a>
                                                        <a class="dropdown-item" href="#">Something else here</a>
                                                        <div class="dropdown-divider"></div>
                                                        <a class="dropdown-item" href="#">Separated link</a>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="clsSerachControl">
                                                <input type="text" class="form-control clsSearchAllBox clsControlHeight" placeholder="Action"></li>
                                            <li>
                                                <button type="button" class="btn clsGo clsControlHeight" style="font-size: 12px !important;">Go</button></li>

                                            <%--<button type="button" class="btn clsControlHeight" style="padding: 0 4px;" onclick="ClearAdvanceFilter();">Clear <span class="fa fa-times" aria-hidden="true" data-toggle="tooltip" title="Clear Filter"></span></button>--%>
                                            <li>
                                                <button type="button" class="btn btn-default clsControlHeight btnClearFilter" data-toggle="tooltip" data-bs-placement="bottom" title="Clear Filter" id="Button1" onclick="ClearAdvanceFilter();">
                                                    Clear 
										  <span class="fa fa-times" aria-hidden="true"></span>
                                                </button>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <section>
                             <div class="pannel-section">

                                <div class="col-md-12 col-sm-12">

                                    <div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
                                        <div class="panel">
                                            <div class="panel-heading" role="tab" id="headingOne">

                                                <h4 class="panel-title">
                                                    <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne" onclick="setTop();" style="float: left;">
                                                        <i class="fa fa-plus"><img src="../../../img/down-white.svg" width="14px" alt="" title=""></i>
                                                        <i class="fa fa-minus"><img src="../../../img/up-white.svg" width="14px" alt="" title=""></i>
                                                    </a>
                                                </h4>
                                                <h3 style="padding: 5px;">Filter</h3>

                                                <%-- Applied Filter Section --%>
                                                <div>
                                                    <%-- <ul>
                    <li> Bank Of Maharashtra </li>
                </ul>--%>
                                                </div>
                                                <%-- End of Applied Filter Section --%>
                                            </div>
                                            <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                                                <div class="panel-body">
                                                    <div class="multi-action">
                                                        <div class="row" style="margin: 0px; ">
                                                            <div class="col-md-12">
                                                                <div class="diff-action">


                                                                    <button type="button" class="btn btn-default" id="addFilter" data-toggle="tooltip" title="Add New Filter">
                                                                        Add Filter
										  <i class="fa fa-plus" aria-hidden="true"></i>
                                                                    </button>


                                                                    <div class="btn-group drp">
                                                                        <button type="button" class="btn lod btnLoadFilter" data-toggle="tooltip" title="Load Saved Filter" data-bs-container="body">Load Filter</button>
                                                                        <button type="button" class="btn dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                            <span class="sr-only">Toggle Dropdown</span>
                                                                        </button>
                                                                        <div class="dropdown-menu clsLoadFilterList">
                                                                            <a class="dropdown-item" href="#">Action</a>
                                                                            <a class="dropdown-item" href="#">Another action</a>
                                                                            <a class="dropdown-item" href="#">Something else here</a>
                                                                            <div class="dropdown-divider"></div>
                                                                            <a class="dropdown-item" href="#">Separated link</a>
                                                                        </div>
                                                                    </div>

                                                                    <%--<button type="button" class="btn btn-default" onclick="document.getElementById('DivSaveFilterAs').style.display='block'">Save Filter As</button>--%>
                                                                    <button onclick="SaveFilterAsClick();" style="display: none" type="button" class="btn btn-default" data-toggle="tooltip" title="Save Filter As">Save Filter As</button>

                                                                    <button type="button" class="btn btn-default" data-toggle="tooltip" title="Clear All" id="clearall">
                                                                        Clear All
										  <i class="fa fa-times" aria-hidden="true"></i>
                                                                    </button>
                                                                </div>
                                                            </div>


                                                        </div>

                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <%--style="padding-top:15px;text-align:center;font-size:12px;color:green;"--%>
                                                                <div class="input-group input-group-btn" id="AppliedFilterDiv" style="display: none; padding-top: 20px;">
                                                                    <span class="tag label label-info" data-toggle="tooltip" aria-hidden='true' style="">
                                                                        <span>Applied Filter >> </span>
                                                                    </span>

                                                                    <span class="tag label label-info" data-toggle="tooltip" aria-hidden='true' style="margin-left: 10px;">
                                                                        <span id="LoadFilterQueryText">Example Tag</span>
                                                                        <a><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a>
                                                                    </span>
                                                                     <span class="tag label" data-toggle="tooltip" aria-hidden='true' style="margin-left: 10px;">
                                                                        <a id="EditFilter">Edit</a>
                                                                     </span>
                                                                    <span class="tag label" data-toggle="tooltip" aria-hidden='true' style="margin-left: 10px;">
                                                                        <a id="DeleteFilter">Delete</a>
                                                                     </span>
                                                                     <%--<a id="EditFilter">Edit</a>--%>
                                                                    <input type="hidden" id="hdnLoadFilterQueryText" name="hdnLoadFilterQueryText" value="" />
                                                                    <input type="hidden" id="hdnEditQuery" name="hdnEditQuery" value="" />
                                                                     <input type="hidden" id="hdndivCounter" name="hdndivCounter" value="0" />
                                                                    <input type="hidden" id="hdnFilterID" name="hdnFilterID" value="" />
                                                                </div>
                                                                <%--<label for="danger" class="btn btn-info" id="LoadFilterQueryText"> <span class="badge"><span class="fa fa-times"></span></span></label>--%>
                                                            </div>
                                                        </div>

                                                        <div class="custom-class"></div>

                                                        <div class="row">
                                                            <div class="col-md-8">
                                                                <div class="apply-btn">
                                                                    <button type="button" class="btn btn-default" id="saveapplybutton" onclick="SaveFilterAndApply();" style="margin-right: 10px;" >Save & Apply</button>
                                                                    <button type="button" class="btn btn-default" id="applybutton" data-toggle="tooltip" title="Apply Without Saving">Apply</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- end of panel -->





                                    </div>
                                    <!-- end of #accordion -->

                                </div>
                                <!-- end of wrap -->

                            </div>
                        <%--    <div class="pannel-section">

                                <div class="col-md-12 col-sm-12">

                                    <div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
                                        <div class="panel">
                                            <div class="panel-heading" role="tab" id="headingOne">

                                                <h4 class="panel-title">
                                                    <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne" onclick="setTop();" style="float: left;">
                                                        <i class="fa fa-plus"><img src="../../../img/down-white.svg" width="14px" alt="" title=""></i>
                                                        <i class="fa fa-minus"><img src="../../../img/up-white.svg" width="14px" alt="" title=""></i>
                                                    </a>
                                                </h4>
                                                <h3 style="padding: 5px;">Filter</h3>

                                               
                                            </div>
                                            <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                                                <div class="panel-body">
                                                    <div class="multi-action">
                                                        <div class="row" style="margin: 0px;">
                                                            <div class="col-md-12">
                                                                <div class="diff-action">


                                                                    <button type="button" class="btn btn-default" id="addFilter" data-toggle="tooltip" title="Add New Filter">
                                                                        Add Filter
										  <i class="fa fa-plus" aria-hidden="true"></i>
                                                                    </button>


                                                                    <div class="btn-group drp">
                                                                        <button type="button" class="btn lod btnLoadFilter" data-toggle="tooltip" title="Load Saved Filter" data-bs-container="body">Load Filter</button>
                                                                        <button type="button" class="btn dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                            <span class="sr-only">Toggle Dropdown</span>
                                                                        </button>
                                                                        <div class="dropdown-menu clsLoadFilterList">
                                                                            <a class="dropdown-item" href="#">Action</a>
                                                                            <a class="dropdown-item" href="#">Another action</a>
                                                                            <a class="dropdown-item" href="#">Something else here</a>
                                                                            <div class="dropdown-divider"></div>
                                                                            <a class="dropdown-item" href="#">Separated link</a>
                                                                        </div>
                                                                    </div>

                                                                   
                                                                    <button onclick="SaveFilterAsClick();" style="display: none" type="button" class="btn btn-default" data-toggle="tooltip" title="Save Filter As">Save Filter As</button>

                                                                    <button type="button" class="btn btn-default" data-toggle="tooltip" title="Clear All" id="clearall">
                                                                        Clear All
										  <i class="fa fa-times" aria-hidden="true"></i>
                                                                    </button>
                                                                </div>
                                                            </div>


                                                        </div>

                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <div class="input-group input-group-btn" id="AppliedFilterDiv" style="display: none; padding-top: 20px;">
                                                                    <span class="tag label label-info" data-toggle="tooltip" aria-hidden='true' style="">
                                                                        <span>Applied Filter >> </span>
                                                                    </span>

                                                                    <span class="tag label label-info" data-toggle="tooltip" aria-hidden='true' style="margin-left: 10px;">
                                                                        <span id="LoadFilterQueryText">Example Tag</span>
                                                                        <a><i class="remove glyphicon glyphicon-remove-sign glyphicon-white"></i></a>
                                                                    </span>

                                                                    <input type="hidden" id="hdnLoadFilterQueryText" name="hdnLoadFilterQueryText" value="" />
                                                                </div>
                                                              </div>
                                                        </div>

                                                        <div class="custom-class"></div>

                                                        <div class="row">
                                                            <div class="col-md-8">
                                                                <div class="apply-btn">
                                                                    <button type="button" class="btn btn-default" id="saveapplybutton" onclick="SaveFilterAndApply();" style="margin-right: 10px;" >Save & Apply</button>
                                                                    <button type="button" class="btn btn-default" id="applybutton" data-toggle="tooltip" title="Apply Without Saving">Apply</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- end of panel -->





                                    </div>
                                    <!-- end of #accordion -->

                                </div>
                                <!-- end of wrap -->

                            </div>--%>
                        </section>

                        <div class="form-info">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="multi-btn">
                                        <%-- <%If HttpContext.Current.Session("LoginType") <> "C" Then%>
                                        <button type="button" class="btn btn-default" data-toggle="tooltip" title="Assign Request to yourself" onclick="Pickup_OnClick();">Pickup</button>
                                        <%End If%>

                                        <%If m_bitApproveAccess = True Then%>
                                        <button onclick="ApproveRejectClick();" type="button" class="btn btn-default" data-toggle="tooltip" title="Approve or Reject the Request">Approve / Reject</button>
                                        <%End If%>
                                        <%If HttpContext.Current.Session("LoginType") <> "C" Then%>--%>
                                        <%--<button type="button" class="btn btn-default">Link</button>--%>
                                        <%--<%End If%>--%>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="multi-drop">
                                        <%If m_blnHRM = True Then%>

                                        <div class="btn-group drp">
                                            <%-- <button class="btn btn-default" type="button">
                                                <i class="fa fa-search"></i>
                                            </button>
                                            <button type="button" class="btn" style="width: 85px;">Assign to</button>
                                            <button type="button" class="btn dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <span class="sr-only">Toggle Dropdown</span>
                                            </button>

                                            <div class="dropdown-menu clsAssignToList">--%>
                                            <%--<a class="dropdown-item" href="#">Action</a>
										<a class="dropdown-item" href="#">Another action</a>
										<a class="dropdown-item" href="#">Something else here</a>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item" href="#">Separated link</a>--%>
                                            <%--    <%AssignToResourceList()%>
                                            </div>--%>
                                            <%--  <div class="btn-group drp clsAssgnToSection" style="display: none;">
                                                <span id="spnAssignToName" style="border-bottom: 4PX SOLID #f9a5a5;"></span>
                                                <span id=""><a href="#" style="font-size: 12px;" onclick="document.getElementById('divAssignedTo').style.display='block'">AssignTo </a></span>
                                                <span id=""><i class="fa fa-clock-o" onclick="document.getElementById('divAssignedTo').style.display='block'"></i></span>

                                                <input type="hidden" id="hdnAssignToId" name="hdnAssignToId" />
                                            </div>--%>
                                        </div>
                                        <%End If%>

                                        <%--				<div class="btn-group drp">
									  <button type="button" class="btn" style="width: 115px;">Status</button>
									  <button type="button" class="btn dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<span class="sr-only">Toggle Dropdown</span>
									  </button>
									  <div class="dropdown-menu clsRequestStatusList">									
                                            <%StatusList()%>
									  </div>
									</div>--%>
                                        <%--		<div class="btn-group drp">
									  <button type="button" class="btn" onclick="document.getElementById('id17').style.display='block'">Customize View</button>
									  <button type="button" class="btn dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<span class="sr-only">Toggle Dropdown</span>
									  </button>
									  <div class="dropdown-menu">
										<a class="dropdown-item" href="#">Action</a>
										<a class="dropdown-item" href="#">Another action</a>
										<a class="dropdown-item" href="#">Something else here</a>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item" href="#">Separated link</a>
									  </div>
									</div>--%>
                                    </div>
                                </div>

                                <div class="col-md-5">
                                    <div class="top-pagination navPagination">
                                        <%WritePaging(m_intPageNumber, "")%>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <div class="form-info table1">
                            <div class="row" style="margin-right:0px">
                                <div class="col-md-12">
                                    <div class="panel panel-default">

                                        <div class="panel-body">
                                            <%--New class gridtblheight added By Pradip on 23-2-2021--%> 
                                            <div class="table-responsive gridtblheight">

                                                <%-- Demo Grid Table --%>
                                                <%DrawPageGrid("")%>
                                                <div class="clearfix"></div>

                                            </div>
                                            <table id="header-fixed"></table>
                                        </div>
                                    </div>
                                </div>

                            </div>




                            <div class="bottom-paginaton">
                                <div class="row">
                                    <div class="col-md-12" style="padding-right: 15px;">
                                        <div class="top-pagination navPagination">
                                            <%WritePaging(m_intPageNumber, "")%>
                                            <%--<ul class="pagination"> 
												 <li class="page-item" style="border-left:1px solid #e4e4e8";> 
												   <a class="page-link" href="#" aria-label="Previous"> 
													 <span aria-hidden="true">&laquo;</span> 
													 <span class="sr-only">Previous</span> 
												   </a> 
												 </li> 
												 <li class="page-item"><a class="page-link" href="#">1-20 of 80</a></li>												 
												 <li class="page-item"style="border-right:1px solid #e4e4e8";> 
												   <a class="page-link" href="#" aria-label="Next"> 
													 <span aria-hidden="true">&raquo;</span> 
													 <span class="sr-only">Next</span> 
												   </a> 
												 </li> 
											   </ul> --%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-info table2">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="panel panel-default" style="margin-bottom: 0px;">

                                        <div class="panel-body">
                                            <div class="panel1">
                                                <div class="iner-bag">
                                                    <ul class="head-panel">
                                                        <li data-bs-toggle="collapse" data-bs-target="#dem1" class="accordion-toggle collapsed">
                                                            <button class="btn btn-default btn-xs"><span class="glyphicon glyphicon-plus"></span><span class="glyphicon glyphicon-minus"></span></button>
                                                        </li>
                                                        <li>
                                                            <input type="checkbox" class="checkthis"></li>
                                                        <li style="font-size: 13px;">Can We See View?</li>
                                                    </ul>
                                                    <ul class="head-desc">
                                                        <li><span class="author-name">By Saranya</span></li>
                                                        <li><span>18 Augast 2017</span></li>
                                                        <li>
                                                            <p>Last Message about 5 Hours ago</p>
                                                        </li>
                                                        <ul class="icons">
                                                            <li style="padding-right: 7px;">
                                                                <button onclick="document.getElementById('id02').style.display='block'" type="button" class="btn btn-default" data-toggle="tooltip" title="Flag"><i class="far fa-flag" aria-hidden="true"></i></button>
                                                            </li>
                                                            <li style="padding-right: 12px;">
                                                                <button type="button" class="btn btn-default" data-toggle="tooltip" title="Discussion"><i class="far fa-comments" aria-hidden="true"><span>4</span></i></button></li>
                                                            <li style="padding-right: 7px;">
                                                                <button onclick="document.getElementById('id03').style.display='block'" type="button" class="btn btn-default" data-toggle="tooltip" title="Attachment" data-bs-placement='top' data-bs-container='body'>
                                                                    <i class="fa fa-paperclip" aria-hidden="true"></i></button>
                                                            </li>
                                                            <li>
                                                                <button type="button" class="btn btn-default" data-toggle="tooltip" title="Edit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                            </li>
                                                        </ul>
                                                    </ul>
                                                    <ul class="assign-by">
                                                        <li style="width: 100%; font-size: 12px;">Assigned To :<span>Paul G.</span></li>
                                                    </ul>
                                                </div>
                                                <div class="hiddenRow">
                                                    <div class="accordian-body collapse" id="dem1">
                                                        <ul class="head-desc" style="padding-bottom: 10px; padding-top: 10px;">
                                                            <li>
                                                                <select class="form-control" id="Select14" style="width: 110px;">
                                                                    <option>Change Status</option>
                                                                    <option>2</option>
                                                                    <option>3</option>
                                                                    <option>4</option>
                                                                </select>
                                                            </li>
                                                            <li>
                                                                <label style="padding-right: 7px;">Time Spent(min)</label><input type="text" name="timespen" /></li>
                                                            <li><i class="fa fa-hourglass-end" aria-hidden="true" style="font-size: 10px;"></i></li>
                                                            <li>
                                                                <select class="form-control" id="Select15" style="width: 110px;">
                                                                    <option>Activity</option>
                                                                    <option>2</option>
                                                                    <option>3</option>
                                                                    <option>4</option>
                                                                </select>
                                                            </li>
                                                            <li>
                                                                <button type="button" class="btn btn-default">Save</button></li>

                                                        </ul>

                                                        <ul class="assign-by">
                                                            <li style="width: 100%;">Last Discussion</li>
                                                            <li style="padding-left: 9px;">By Saranya</li>
                                                            <li>Description</li>
                                                            <li>
                                                                <p>
                                                                    The carousel component is generally not compliant with accessibility standards.<br />
                                                                    If you need to be compliant, please consider other options for presenting your content. ”
                                                                </p>
                                                            </li>
                                                        </ul>

                                                        <ul class="assign-by">
                                                            <li style="width: 100%;">Description</li>
                                                            <li>
                                                                <p>
                                                                    The carousel component is generally not compliant with accessibility standards.<br />
                                                                    If you need to be compliant, please consider other options for presenting your content. ”
                                                                </p>
                                                            </li>
                                                        </ul>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="top-pagination navPagination">
                                        <%WritePaging(1, "")%>
                                        <%-- <ul class="pagination">
												<li class="page-item" style="border-left:1px solid #e4e4e8;">
												  <a class="page-link" href="#" aria-label="Previous">													
													<span aria-hidden="true">&laquo;</span>
													<span aria-hidden="true">&#8249;</span>
													<span class="sr-only">Previous</span>
												  </a>
												</li>
												<li class="page-item"><a class="page-link" href="#">1-20 of 80</a></li>												
												<li class="page-item" style="border-right:1px solid #e4e4e8;">
												  <a class="page-link" href="#" aria-label="Next">
												  <span aria-hidden="true">&#8250;</span>
													<span aria-hidden="true">&raquo;</span>
													<span class="sr-only">Next</span>
												  </a>
												</li>
											  </ul>--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <%-- Dashboard div --%>
                    <div id="divDashboard" class="clsDivDashboard">
                        <h3>Dashboard Page In Progress.</h3>
                    </div>
                    <%-- End of Dashboard Div --%>

                    <%-- Knowledge div --%>
                    <div id="divKnowledge" class="clsDivKnowledge">
                        <h3>Knowledge Page In Progress.</h3>
                    </div>
                    <%-- End of Knowledge Div --%>

                    <%-- container --%>
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- /.content-wrapper -->
                                    
            <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
            <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
            <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
            <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
            <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script> -->
            <script src="../../../Whizible2.0-new/dist/js/sb-admin.js"></script>
            <!-- <script src="../../General/CommonFunctions.js"></script>
            <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> -->


             
    
            <script>
                //added by nilam rawool on 12/28/2018 for issue default filter(submitted request )
                $(function() {
                  
                    var chk= $(".clsPageName").text().toString().trim();
                 
                  
                    //if(chk == 'Submitted Requests' )
                    //{
                    var chk= $(".clsPageName").text().toString().trim();                  
                  
                    //if(chk == 'Submitted Requests' )
                    //{
                    if(chk.match("/^Submitted Requests/") || chk == "Submitted Requests") 
                    {  
                        $("#chkDefaultSR").attr('checked', true);
                        //$('.clsPageName').addClass('checked',true);   
                        //$("input[id=chkDefaultSR]").prop("checked", true);
                    }
                    else{
                        $('#chkDefaultSR').attr('checked', false);                          
                    }
                 
                 
                });
                //ende by nilam rawool on 12/28/2018

                //Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
                function selectsubmittedrequest() {
                    var chk= $(".clsPageName").text().toString().trim();                  
                    
                    if(chk.match("/^Submitted Requests/") || chk == "Submitted Requests") 
                    {  
                        $("#chkDefaultSR").attr('checked', true);
                    }
                    else{
                        $('#chkDefaultSR').attr('checked', false);                          
                    }
                }
                 //End Of Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
                $(document).ready(function () {
                    var bodyHeight
                    if ($(window).width() < 788) {
                        bodyHeight = window.innerHeight - 125;
                    }
                    else {
                        bodyHeight = window.innerHeight - $('#MainDiv').offset().top;
                    }
                    $('#MainDiv').css('height', bodyHeight - 10 + 'px');
                });

                $(window).resize(function () {
                    var bodyHeight
                    if ($(window).width() < 788) {
                        bodyHeight = window.innerHeight - 125;
                    }
                    else {
                        bodyHeight = window.innerHeight - $('#MainDiv').offset().top;
                    }
                    $('#MainDiv').css('height', bodyHeight - 10 + 'px');
                    setTimeout(function () { setWidth(); }, 500);
                });

                $(document).click(function () {
                    $(".tooltip").removeClass("show");
                    $(".tooltip").removeClass("in");
                });
                $(".clsControlHeight").tooltip();
                $('.clsControlHeight').click(function () {
                    $('.tooltip').fadeOut('fast', function () {
                        $('.tooltip').remove();
                    });
                });
                $('[data-toggle="tooltip"]').click(function () {
                    $('.tooltip').fadeOut('fast', function () {
                        $('.tooltip').remove();
                    });
                });
            </script>
        </div>
    </form>
    <%-- Main From closed frmRequestListNew --%>

    <!-- ----- Approve button---------------------------->
    <div id="id01" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Approve / Reject</span>
                <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right'>&times;</span>
            </div>

            <div class="container">
                <div class="appro-form">
                    <span>Approver Comment</span><i class="far fa-comments" aria-hidden="true"></i>
                   <%-- --Added & Commeted By Dipali V On 11th May 2020 For IssueID 24338--%>
                  <%--  <textarea class="form-control" rows="2" id="comment"></textarea>--%>
                      <textarea class="form-control" rows="2" id="comment" maxlength="4000"></textarea>
                    <%-- -End of -Added & Commeted By Dipali V On 11th May 2020 For IssueID 24338--%>
                </div>

                <label id="ApproveRejectValidationMsg" style="font-weight: normal;"></label>

                <div id="divApproveRejectValidationMsg">
                </div>
                <div class="acc-btn">
                    <i class="fa fa-eye" aria-hidden="true"></i>

                    <button type="button" class="btn btn-default btnAcceptDeclineRequests save" mode="A">Accept</button>
                    <button type="button" class="btn btn-default dec-btn btnAcceptDeclineRequests save" mode="R">Decline</button>
                    <button type="button" class="btn btn-default dec-btn save" onclick="document.getElementById('id01').style.display='none'">Cancel</button>
                </div>
            </div>
        </form>
    </div>
    <!-- ----- End Approve button---------------------------->

    <!---------- Flag icon---------->
    <div id="id02" class="modal">
          <div class="modal-dialog modal-md">
        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer2">
                <span class="appro-title">Tracking Details</span>
                <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right'>&times;</span>
            </div>

            <div class="">
                <div class="trac-detail">
                    <div class="row">
                        <div class="col-md-12">
                            <p class="flag-info">
                                Flagging marks an item to remind you that it needs to be followed up.
							After it has been followed up, you can mark it complete.
                            </p>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="help-que">
                                <p class="help"><span>Request ID :-   </span><span style="font-weight: 300;" id="spnRequestID"></span></p>
                                <p class="que" title="Subject" style="font-weight: 100!important">Can I View By Columns and Rows?</p>
                            </div>
                        </div>
                    </div>
                    <div class="un-flag col-lg-12 col-md-12 col-sm-12 col-sm-12">
                        <div class="row">
                            <div class="col-md-12" style="display:inline-flex">
                           <div class="col-sm-6">

                                <% CommonFunctions.HTMLControls.DrawComboBox("cbFlagTo", "usp_FlagTo_ComboFill", 120, , "class='form-control' ", True, , , , , , 1)%>
                                <%--onblur=""javascript:cbFlagTo_OnBlur()""--%>
                            </div>
                            <div class="col-sm-3 col-sm-offset-1" style="padding-right:0px;">
                                <input type="text" class="form-control" id="dtDueDate" placeholder="Due Date" autocomplete="off"/>

                                   <%-- Added by Ankush T on 18.12.2018 for wrong alert issue for Due Date --%>
                              <%--  <i class="fa fa-calendar" onclick="$('#dtDueDate').datepicker();$('#dtDueDate').datepicker('show');"></i>--%>
                                  <i class="fa fa-calendar" id='clscalender' onclick="$('#dtDueDate').datepicker();$('#dtDueDate').datepicker('show');"></i>
                          <%-- End of Added by Ankush T on 18.12.2018 for wrong alert issue for Due Date --%>
                               <label style="position: relative;top: -33px; right: -40px;float: right;">*</label>
                            </div>
                             </div>

                        </div>
                    </div>
                    
                    <div class="checkbox col-lg-12 col-md-12 col-sm-12 col-sm-12" style="margin-bottom: 15px;margin-top: 0px!important;">
                        <div class="row">
                            <input type="hidden" id="hdnRequestID" name="hdnRequestID" />
                            <input type="hidden" id="hdnFlagUniqueID" name="hdnFlagUniqueID" />
                           <div class="col-sm-2" style="display:inline-flex;align-items:baseline">		
                               
                                <%-- Added by Ankush T on 18.12.2018 for wrong alert issue for Due Date --%>						
						     <%-- <input type="checkbox" id="chkComplete" value=""/><label>Complete</label>--%>
                                 <input type="checkbox" id="chkComplete" value="" onclick="DisableDateControl()"/><label>Complete</label>
                        <%-- End of Added by Ankush T on 18.12.2018 for wrong alert issue for Due Date --%>
					        </div>
                            <div class="col-sm-8" style="text-align: right;">	
                           
                                <button type="button" class="btn btn-default" id="btnClearFlag" onclick="ClearFlag();" data-toggle='tooltip' data-bs-placement='top' data-bs-container='body' title="UnFlag">UnFlag</button>
                           
                           
                                <button type="button" class="btn btn-default" onclick="SaveFlag();" data-toggle='tooltip' data-bs-placement='top' data-bs-container='body' title="Save">Save</button>
                            </div>
                       
                    </div>
                       </div>     
                </div>
            </div>
        </form>
              </div>
    </div>
    <!--------------------- end Flag icon------------------->

    <!------ Attachment Icon---------------------->
    <div id="id03" class="modal" role="dialog">
        <div class="modal-dialog modal-md" id="attachmentdialog">
        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer2">
                <span class="appro-title">Attachments</span>
                <span onclick="document.getElementById('id03').style.display='none'" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right'>&times;</span>
            </div>

            <div class="container">
                <div class="attachment">
                    <div class="row">
                        <div class="col-sm-12">
                            <label id="lblRequestIDAttachments">Request ID : </label>
                            <button type="button" id="btnDownloadZip" queryid="001" class="btn btn-default save download" onclick="DownloadZip(this);" ><i class="fa fa-download" aria-hidden="true"></i>Download All (Zip)</button>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="down-info" id="attachmentMainDiv">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Firstname</th>
                                            <th>Uploaded By</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><i class="far fa-file-pdf" aria-hidden="true"></i></td>
                                            <td>ABD.Txt<i class="fa fa-download" aria-hidden="true"></i></td>
                                            <td>Raj Kumar</td>
                                            <td>30t Aug 2016</td>
                                        </tr>

                                        <tr>
                                            <td><i class="far fa-file-pdf" aria-hidden="true"></i></td>
                                            <td>ABD.Txt<i class="fa fa-download" aria-hidden="true"></i></td>
                                            <td>Raj Kumar</td>
                                            <td>30t Aug 2016</td>
                                        </tr>
                                        <tr>
                                            <td><i class="far fa-file-pdf" aria-hidden="true"></i></td>
                                            <td>ABD.Txt<i class="fa fa-download" aria-hidden="true"></i></td>
                                            <td>Raj Kumar</td>
                                            <td>30t Aug 2016</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
            </div>
    </div>
    <!--End Attachment Icon -->


    <!-- Import Button -->
    <!-- <div id="id04" class="modal"> -->

    <!-- <form class="modal-content animate" action="/action_page.php"> -->
    <!-- <div class="imgcontainer2"> -->
    <!-- <span class="appro-title">Import</span> -->
    <!-- <span onclick="document.getElementById('id04').style.display='none'" class="close" title="Close">&times;</span> -->
    <!-- </div> -->

    <!-- <div class="container"> -->
    <!-- <div class="import"> -->
    <!-- <div class="row"> -->
    <!-- <div class="col-md-12"> -->
    <!-- <div class="bros-btn"> -->
    <!-- <div class="btn-group drp"> -->
    <!-- <button type="button" class="btn src">Browse</button> -->
    <!-- <button type="button" class="btn dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
    <!-- <span class="sr-only">Toggle Dropdown</span> -->
    <!-- </button> -->
    <!-- <div class="dropdown-menu"> -->
    <!-- <a class="dropdown-item" href="#">Action</a> -->
    <!-- <a class="dropdown-item" href="#">Another action</a> -->
    <!-- <a class="dropdown-item" href="#">Something else here</a> -->
    <!-- <div class="dropdown-divider"></div> -->
    <!-- <a class="dropdown-item" href="#">Separated link</a> -->
    <!-- </div> -->


    <!-- </div>	 -->
    <!-- <button onclick="document.getElementById('id05').style.display='block'" type="button" class="btn btn-default">Import</button> -->
    <!-- </div> -->
    <!-- </div> -->
    <!-- </div> -->





    <!-- </div> -->
    <!-- </div> -->



    <!-- </form> -->
    <!-- </div> -->

    <div id="id05" class="modal">

        <form class="modal-content animate" action="/action_page.php" enctype="multipart/form-data" method="post" accept-charset="utf-8">
            <div class="imgcontainer">
                <span class="appro-title">Import (Bulk Request Creation)</span>
                <span onclick="Import_Close();" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right' data-bs-container='body'>&times;</span>
            </div>

            <div class="container" id="divImportContainer">
                <div class="import">
                    <div class="row">
                        <div class="col-md-10" id="divDetails">
                            <div class="row mb-2">
                                <div id="divFileUploaedBy" class="col-md-12">
                                    <div class="col-md-2 float-start">
                                        <label id="lblUploadedBy">Uploaded By: </label>
                                    </div>
                                    <div class="col-md-10 float-start">
                                        <div class="avatar">
                                            <img id="imgUploaded" class="img-circle" src="<%= strEmployeeImage%>" />
                                            <label id="lblUploadedByName"><%=HttpContext.Current.Session("strUserName")%></label>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="clearfix">
                                <div id="divFileUploaed" class="row">
                                    <div class="col-md-2 float-start">
                                        <label id="lblFilename">Uploaded File: </label>
                                    </div>
                                    <div class="col-md-10">
                                        <label id="lblAttachmentName"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="bros-btn" style="margin-top: -4px;">

                                <div>
                                    <%--<input type="file" id="file" onchange="validateForExe(this)" name="img[]" class="file" accept=".xls,.xlsx,.XLS,.XLSX" />--%>
                                    <input type="file" id="file" name="img[]" class="file" accept=".xls,.xlsx,.XLS,.XLSX" />
                                    <%--    <div id="FileControlUploadDiv">
                         <%=CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addFileinGrid()' style='display:none !important;' class='clsFileControl'", False,True)%>
                                 </div>--%>
                                    <button type="button" id="btnSelectFile" data-toggle="tooltip" data-bs-placement='bottom' title="Upload only .xls,.xlsx File " filecount="0" onclick="SelectFile();" class="btn btn-default save" >Upload File</button>
                                    <%--  <label id="lblFileExt">(.xls,.xlsx)</label>--%>
                                    <%-- <button type="button" class="btn dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
                                    <%--<span class="sr-only">Toggle Dropdown</span>--%>
                                    <%--	  </button>--%>
                                    <%--  <div class="dropdown-menu">
										<a class="dropdown-item" href="#">Action</a>
										<a class="dropdown-item" href="#">Another action</a>
										<a class="dropdown-item" href="#">Something else here</a>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item" href="#">Separated link</a>
									  </div>--%>
                                </div>
                                <%--   <button type='button' class='btn updtae-btn' id='btnSave'  onclick='SaveExcelConfiguration()'>Save</button>--%>
                                <!-- <button onclick="document.getElementById('id05').style.display='block'" type="button" class="btn btn-default">Import</button> -->
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <div class="color-box">
                                <div class="shadow">
                                    <%--  fa fa-sticky-note-o--%>
                                    <%-- <div title="Steps to Import Requests"><i class="fa fa-lightbulb-o" aria-hidden="true"></i>&nbsp;</div>--%>
                                    <div class="note-box">
                                        <span><i title="Steps to Import Requests" class="fa fa-lightbulb-o" aria-hidden="true"></i>&nbsp;</span>
                                        <span>
                                            <label>Step 1:</label>
                                            Upload only .xls,.xlsx file. </span>
                                        <span>
                                            <label>Step 2:</label>
                                            Map mandatory columns corresponding to excel columns. </span>
                                        <span>
                                            <label>Step 3:</label>
                                            Validate record. </span>
                                        <span>
                                            <label>Step 4:</label>
                                            Import requests.</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="row" id="idDivExcelDetails"></div>
            </div>
        </form>
    </div>



    <!--*********************************Added By Bharat T on 12th-Oct-2017 for new request list changes************************************************-->

    <!--*********************************End of Added By Bharat T on 12th-Oct-2017 for new request list changes************************************************-->

    <%-- Code from 1510 html file solution --%>

    <!-- -----Filter in  Save As button popup---------------------------->
    <div id="id16" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Save Filter As</span>

                  <!-- Added  by nilam rawool for clear filter issues>-->
                <%--<span onclick="document.getElementById('id16').style.display='none'" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right' data-bs-container='body'>&times;</span>--%>
                 <span onclick="clearfilter()" class="close" title="" data-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="Close">×</span>
                 <!-- -----Ended by nilam rawool--------------->
            </div>
            <div class="container">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="request type">Filter Name</label>
                    <div class="col-sm-8">
                        <%=CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control", , ToBeInserted:="", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                    </div>
                </div>
                <div class="form-group">
                     <%-- Added By Nikhil Adkar for Edit filter--%>
                    
                            
                   
                    <%--End of Added By Nikhil Adkar --%>
                    <div class="right" style="margin-top: 12px;">
                         <p style="color:red; width:236px;" class="left">Note: If filter name is changed then it will be saved as new filter.</p>
                        <button type="button" class="btn btn-default save apply_filter_btn" id="btnFilterSaveApply" style="" filtermode="Save" onclick="SaveFilter();">Save</button>
                       
                         <!-- ----Commented and added by nilam rawool on 25 dec 2018 ---->   
                        <%--<button type="button" class="btn btn-default save" style="" onclick="document.getElementById('id16').style.display='none'">Cancel</button>--%>
                         <button type="button" class="btn btn-default save apply_filter_btn" style="" onclick="clearfilter()">Cancel</button>
                         <!-- ----End of Commented and added by nilam rawool on 25 dec 2018 ---->    
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- -----Customize button popup---------------------------->
    <div id="id17" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Customize View</span>
                <span onclick="document.getElementById('id17').style.display='none'" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right' data-bs-container='body'>&times;</span>
            </div>
            <div class="container">
                <div class="form-group">
                    <div class="right" style="margin-top: 12px;">
                        <button type="button" class="btn btn-default" style="background-color: #343660; color: #fff;">Save</button>
                        <button type="button" class="btn btn-default" style="background-color: #fff; color: #343660;">Cancel</button>
                    </div>
                </div>
            <%--    <div class="form-group">
                    <div class="col-sm-2">
                        <input type="checkbox" class="checkthis" />
                    </div>
                    <label class="control-label col-sm-10" for="request type">Select/Clear All</label>

                    <div class="col-sm-2">
                        <input type="checkbox" class="checkthis" />
                    </div>
                    <label class="control-label col-sm-10" for="request type">Request Id</label>

                    <div class="col-sm-2">
                        <input type="checkbox" class="checkthis" />
                    </div>
                    <label class="control-label col-sm-10" for="request type">Flag</label>

                    <div class="col-sm-2">
                        <input type="checkbox" class="checkthis" />
                    </div>
                    <label class="control-label col-sm-10" for="request type">Attachment</label>

                    <div class="col-sm-2">
                        <input type="checkbox" class="checkthis" />
                    </div>
                    <label class="control-label col-sm-10" for="request type">Discussion</label>

                    <div class="col-sm-2">
                        <input type="checkbox" class="checkthis" />
                    </div>
                    <label class="control-label col-sm-10" for="request type">Subject</label>

                    <div class="col-sm-2">
                        <input type="checkbox" class="checkthis" />
                    </div>
                    <label class="control-label col-sm-10" for="request type">Request Type</label>

                    <div class="col-sm-2">
                        <input type="checkbox" class="checkthis" />
                    </div>
                    <label class="control-label col-sm-10" for="request type">Sub Request Type</label>

                    <div class="col-sm-2">
                        <input type="checkbox" class="checkthis" />
                    </div>
                    <label class="control-label col-sm-10" for="request type">Priority</label>
                </div>--%>
            </div>
        </form>
    </div>

    <!-- -----Filter in  Save As button popup---------------------------->
    <div id="id18" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Pickup</span>
                <span onclick="document.getElementById('id18').style.display='none'" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right' >&times;</span>
            </div>
            <div class="container" id="divPickupLabelAndGridParent">
                <label class="control-label col-lg12" for="request type" id="pickupValidationMsg">This request will get assigned to you. To proceed click OK. </label>

                <div class="form-group" id="divPickupLabelAndGrid">
                </div>
                <div class="form-group">
                    <div class="right" style="margin-top: 12px;">
                        <%--Commented and Added by Usha Pandit on 11 JAN 2018 for showing theme color on button--%>
                       <%-- <button type="button" class="btn btn-default btnAssignPickupRequest" style="background-color: #343660; color: #fff;" onclick="AssignRequestToSelf();">Assign To Me</button>
                        <button type="button" class="btn btn-default" style="background-color: #fff; color: #343660;" onclick="document.getElementById('id18').style.display = 'none'">Cancel</button>--%>

                         <button type="button" class="btn btn-default save btnAssignPickupRequest" style="background-color: #343660; color: #fff;" onclick="AssignRequestToSelf();">Assign To Me</button>
                        <button type="button" class="btn btn-default save" style="background-color: #fff; color: #343660;" onclick="document.getElementById('id18').style.display = 'none'">Cancel</button>
                          <%--End of Added by Usha Pandit on 11 JAN 2018 for showing theme color on button--%>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <%-- ----------------------------------------------------- --%>
    <div id="divRequestor" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Requestor / Statistics</span>
                <span onclick="document.getElementById('divRequestor').style.display='none'" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right' data-bs-container='body'>&times;</span>
            </div>
            <div id="divStatReq" class="container">
                <div id="divcontainer">
                </div>
            </div>
        </form>
    </div>
    <%-- Code from 1510 html file solution --%>

    <div id="divAssignedTo" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div id="div3">
                <div class="imgcontainer">
                    <span class="appro-title">Assign To</span>
                    <span onclick="document.getElementById('divAssignedTo').style.display='none'" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right' data-bs-container='body'>&times;</span>
                </div>
                <div id="div4">
                </div>
            </div>
        </form>
    </div>

    <!-- -----FeedBack Parameter Div---------------------------->


    <div id="Feedback" class="modal">
        <div class="modal-dialog modal-md">
        <form class="modal-content animate" action="/action_page.php">
            <div class="imgFeedback">
                <span><i class='fa fa-thumbs-o-up' aria-hidden='true' style="margin-top: 1.7%; margin-left: 1%"></i></span><span class="appro-title" style="margin-left: 15px!important">FeedBack</span>
                <span onclick="CancelFeedback();" class="close" title="Close" data-toggle='tooltip' data-bs-placement='right' >&times;</span>
            </div>
            <%--<div class="swit">								
						<div class="check_box_one"> <div class="radio"> <label><input type="radio" name="radio" checked=""><i></i>Very Good</label> </div></div>
                        <div class="check_box"> <div class="radio"> <label><input type="radio" name="radio"><i></i>Good</label> </div></div>
						<div class="check_box"> <div class="radio"> <label><input type="radio" name="radio"><i></i>Fair</label> </div></div>
						<div class="check_box"> <div class="radio"> <label><input type="radio" name="radio"><i></i>Poor</label> </div></div>
						<div class="clear"></div>
					</div>--%>
            <div class="container" id="Feedbackdata">
                <%ShowHelpDeskFeedbackDiv()%>
            </div>
        </form>
            </div>
    </div>
    <!-- -----End of FeedBack Parameter Div---------------------------->
    <!--Delete filter Confirm model-->
    <div id="CnfDeleteFilter" class="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Delete Filter</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="background-color:white!important"></button>
      </div>
      <div class="modal-body">
        <p>Are you sure,you want to delete this filter?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background-color:#343660!important;color:white!important">No</button>
        <button type="button" class="btn btn-primary" onclick="DeleteFilter()" style="background-color:#343660!important;color:white!important">Yes</button>
      </div>
    </div>
  </div>
</div>

    <!--End of Delete Confirm model-->

</body>



<script>
    $(function () {
        $("#dtDueDate").datepicker();
    });
</script>
<script>
    var strSelectedRequestsList = new Array();


    //document.getElementById("MainDiv").onscroll = function () {



    //    //$("#tblRequestList").find("thead").find("tr").css("top", document.getElementById("MainDiv").top - 1);
    //    //$(".FixedTD").css("top", $("#tblFileDetails").scrollTop() - 1);
    //}
    //Added By Rehan C To add Validator for Special characters on 27th Dec 2022
    var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
    //End Of Comment By Rehan C
    var addorButton = false;
    var str = "";
    var count = 0;

    /**********************************Modified By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
    $("#addFilter").click(function () {
        //alert("add filter");
        count = $(".multi-action div.custom-class div.addedrow").length;
        if (divcnt > 0) {
            count = count + divcnt;
        }
        $('#hdndivCounter').val(count);
        if (addorButton) {

            str = '<div class="row addedrow"><div class="col-md-12"><div class="field-section">';
            
            str += '<div class="col-md-1.5">'; //Added by Usha on 10 JAN 2018 for Filter alignment

            //AND OR control
            //str += '<select onchange="changeA(' + count + ', this.value)" class="form-control selct" id="sel1"><option value="AND">AND</option><option value="OR">OR</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboQueryJoinOperator_filterRowCount", "SELECT 'AND' UNION SELECT 'OR' ", , , "onchange=""changeA(filterRowCount, this.value);"" class='form-control selct'", ReturnAsHTML:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);

            str += '</div>'; //Added by Usha on 10 JAN 2018 for Filter alignment
            str += '<div class="col-md-3">'; //Added by Usha on 10 JAN 2018 for Filter alignment

            //Field Control
            //str += '<select  onchange="changeB(' + count + ', this.value)" class="form-control selct" id="sel1"><option value="Select Field">Select Field</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboField_filterRowCount", "usp_CRM_Fields_ForCombo '" & m_strLoginType & "'," & m_lngEmployeeID & "", 200, , "onchange=""javascript:changeB(filterRowCount, this.value);"" class='form-control selct'", True, True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);

            str += '</div>'; //Added by Usha on 10 JAN 2018 for Filter alignment
            str += '<div class="col-md-2">'; //Added by Usha on 10 JAN 2018 for Filter alignment

            //Operator Control
            //str += '<select onchange="changeC(' + count + ', this.value)" class="form-control equal" id="sel1"><option value="=">=</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboOperator_filterRowCount", "usp_CRM_Operators_ForCombo", 100, , "onchange=""changeC(filterRowCount, this.value);"" class='form-control equal'", ReturnAsHTML:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);

            str += '</div>'; //Added by Usha on 10 JAN 2018 for Filter alignment
            str += '<div class="col-md-3">'; //Added by Usha on 10 JAN 2018 for Filter alignment


            //Field Value control
            str += '<span id="spnFilterControl_' + count + '">'
            //str += '<select onchange="changeD(' + count + ', this.value)" class="form-control value" id="sel1"><option value="Value">Value</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawTextBox("FilterControl_filterRowCount", "FilterControl_filterRowCount", "form-control value", 100, ToBeInserted:="onchange=""changeD(filterRowCount, this.value)""", returnHTML:=True, EnableHTMLEncode:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);
            str += '</span>'

            str += '</div>';                      //Added by Usha on 10 JAN 2018 for Filter alignment
            str += '<div class="col-md-1">'; //Added by Usha on 10 JAN 2018 for Filter alignment

            str += '<i class="fa fa-times removethis" aria-hidden="true"></i>'


            str += '<input type="hidden" name="a' + count + '" id="a' + count + '" value="AND">';
            str += '<input type="hidden" name="b' + count + '" id="b' + count + '" value="">';
            str += '<input type="hidden" name="c' + count + '" id="c' + count + '" value="=">';
            str += '<input type="hidden" name="d' + count + '" id="d' + count + '" value="">';

            str += '</div>';    //Added by Usha on 10 JAN 2018 for Filter alignment

            str += '</div></div></div>'



        } else {

            str = '<div class="row addedrow"> <div class="col-md-12"><div class="field-section field-sec1">';

            str += '<div class="col-md-3">'; //Added by Usha on 10 JAN 2018 for Filter alignment

            //Field Control
            //str += '<select  onchange="changeB(' + count + ', this.value)" class="form-control selct" id="sel1"><option value="Select Field">Select Field</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboField_filterRowCount", "usp_CRM_Fields_ForCombo '" & m_strLoginType & "'," & m_lngEmployeeID & "", 200, , "onchange=""changeB(filterRowCount, this.value);"" class='form-control selct'", True, True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);

            str += '</div>'; //Added by Usha on 10 JAN 2018 for Filter alignment
            str += '<div class="col-md-2">'; //Added by Usha on 10 JAN 2018 for Filter alignment


            //Operator Control
            //str += '<select onchange="changeC(' + count + ', this.value)" class="form-control equal" id="sel1"><option value="=">=</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboOperator_filterRowCount", "usp_CRM_Operators_ForCombo", 100, , "onchange=""changeC(filterRowCount, this.value);"" class='form-control equal'", ReturnAsHTML:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);

            str += '</div>'; //Added by Usha on 10 JAN 2018 for Filter alignment
            str += '<div class="col-md-3">'; //Added by Usha on 10 JAN 2018 for Filter alignment


            //Filed Value control
            str += '<span id="spnFilterControl_' + count + '">'
            //str += '<select onchange="changeD(' + count + ', this.value)" class="form-control value" id="sel1"><option value="Value">Value</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'

            str += '<%=CommonFunctions.HTMLControls.DrawTextBox("FilterControl_filterRowCount", "FilterControl_filterRowCount", "form-control value", 100, ToBeInserted:=" onchange=""changeD(filterRowCount, this.value)""", returnHTML:=True, EnableHTMLEncode:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);
            str += '</span>'

            str += '</div>'; //Added by Usha on 10 JAN 2018 for Filter alignment
            str += '<div class="col-md-2">'; //Added by Usha on 10 JAN 2018 for Filter alignment

            //str += '<i class="fa fa-times removelast" aria-hidden="true" style="cursor:pointer;margin-left:60px;"></i>'    //Commented by usha 10 JAN  for Filter alignment         
            str += '<i class="fa fa-times removelast" aria-hidden="true" style="cursor:pointer;"></i>'      //Added by usha 10 JAN  for Filter alignment



            str += '<input type="hidden" name="b' + count + '" id="b' + count + '" value="">';
            str += '<input type="hidden" name="c' + count + '" id="c' + count + '" value="=">';
            str += '<input type="hidden" name="d' + count + '" id="d' + count + '" value="">';

            str += '</div>';    //Added by Usha on 10 JAN 2018 for Filter alignment

            str += '</div></div></div>'



            addorButton = true;

        }

        $("div.multi-action div.custom-class").append(str);


    });
    /**********************************End of Modified By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
    /*************************Added By Nikhil Adkar***************************************/
    
    $("#DeleteFilter").click(function () {
      
        $("#CnfDeleteFilter").modal('show');

       // $('#clearall').click();
    });
    function closeDel() {
        //document.getElementById('CnfDeleteFilter').style.display = "none";
        $("#CnfDeleteFilter").modal('hide');
    }
    function DeleteFilter() {
       
        var strResult, data;
        data = JSON.stringify({ FilterID: $("#hdnLoadFilterID").val() });
        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/DeleteFilter", data, false);
        if (strResult.d == "1") {
            
            $('#clearall').click();
            $("#CnfDeleteFilter").modal('hide');
            alertify.set('notifier', 'position', 'top-right');
            alertify.success("Filter deleted successfully.");
        }
        else {
            $("#CnfDeleteFilter").modal('hide');
            alertify.set('notifier', 'position', 'top-right');
            alertify.error("Filter not deleted successfully.",'error');
        }
       
    }
    var FilterID = 0;
    var Inc = 0;
    function fillfilterDetails(strQuery) {

       
        var divcnt = $(".multi-action div.custom-class div.addedrow").length;
        if (divcnt == 0) {
           
            var check = 0;
            var arrItem = new Array();
            var arrsymbols = new Array();
            var arrAndOr = new Array();
            var arrValue = new Array();
            addorButton = true;

           
            if ($("#hdnLoadFilterID").val() != '') {
                FilterID = $("#hdnLoadFilterID").val()
            }
            else {
                FilterID = 0;
            }
            //str = '<div class="row addedrow"> <div class="col-md-12"><div class="field-section field-sec1">';
            var arrQuery = strQuery.split(',');
            var stroperator = '=,<>,<,>,<=,>=,NOT LIKE,LIKE';
            var arrOperator = stroperator.split(',');
            var data = "";
            var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetFieldsForCombo", data, false);
           
            if (strResult.d.length > 0) {
                var arrFieldscombo = strResult.d.split(',');
            }
            if (arrQuery.length > 0) {

                for (i = 0; i <= arrQuery.length - 1; i++) {
                    if (check == 0) {
                        for (j = 0; j <= arrOperator.length - 1; j++) {
                            if (arrQuery[i] != "") {
                                if (arrQuery[i] == arrOperator[j]) {
                                    check = 1;
                                    //if (i != 0) {
                                    //    str = '<div class="row addedrow"> <div class="col-md-12"><div class="field-section field-sec1">';
                                    //}
                                    arrsymbols.push(arrQuery[i]);
                                    str += '<div class="col-md-2">';
                                    str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboOperator_filterRowCount", "usp_CRM_Operators_ForCombo", 100, , "onchange=""changeC(filterRowCount, this.value);"" class='form-control equal'", ReturnAsHTML:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, Inc);
                                str += '</div>';
                                str += '<div class="col-md-2">';
                                    str += '<span id="spnFilterControl_' + Inc + '">'
                                str += '</span>'
                                    str += '</div>';
                                    if (Inc > 0) {
                                        str += '<div class="col-md-1">';
                                        str += '<i class="fa fa-times removethis" aria-hidden="true" style="cursor:pointer;float:right" ></i>'
                                        str += '</div>';
                                    }
                               
                                str += '</div></div></div>'
                            }
                        }
                    }

                }
                if (check == 0) {
                    for (k = 0; k <= arrFieldscombo.length - 1; k++) {
                        if (arrQuery[i] != "") {
                            if (arrQuery[i] == arrFieldscombo[k]) {
                                arrItem.push(arrQuery[i]);
                                check = 1;
                                if (i == 0) {
                                   
                                    str = '<div class="row addedrow"> <div class="col-md-12"><div class="field-section field-sec1">';
                                   
                                }
                                str += '<div class="col-md-3">';
                                str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboField_filterRowCount", "usp_CRM_Fields_ForCombo '" & m_strLoginType & "'," & m_lngEmployeeID & "", 200, , "onchange=""changeB(filterRowCount, this.value);"" class='form-control selct'", True, True).Replace("'", "\'")%>'.replace(/filterRowCount/g, Inc);
                            str += '</div>';
                           
                         }
                    }
                   
                    }
                }
                if (check == 0) {
                if (arrQuery[i] !="") {
                    if (arrQuery[i] == 'AND' || arrQuery[i] == 'OR') {
                        Inc = Inc + 1;
                        check = 1;
                        $('#hdndivCounter').val(Inc);
                        arrAndOr.push(arrQuery[i]);
                        if (i != 0) {
                                    str += '<div class="row addedrow"> <div class="col-md-12"><div class="field-section">';
                                }
                    str += '<div class="col-md-1.5">';
                        str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboQueryJoinOperator_filterRowCount", "SELECT 'AND' UNION SELECT 'OR' ", , , "onchange=""changeA(filterRowCount, this.value);"" class='form-control selct'", ReturnAsHTML:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, Inc);
                                str += '</div>';
                            }
                        }
                    }
                    if (check == 0) {
                        if (arrQuery[i] != "") {
                            arrValue.push(arrQuery[i]);
                        }
                    }
                    check = 0;

                }
                // alert(arrItem[0]);


            }
            $("div.multi-action div.custom-class").append(str);
            for (i = 0; i <= arrItem.length - 1; i++) {

                $('#cboField_' + i).val(arrItem[i]);
                var strResult, data;
                data = JSON.stringify({ ControlName: arrItem[i], count: i, value: arrValue[i] });
                strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetFilterControl", data, false);

                if (strResult.d != "") {
                    $("#spnFilterControl_" + i).html(strResult.d);
                }
            }

            for (i = 0; i <= arrsymbols.length - 1; i++) {

                $("#cboOperator_" + i).val(arrsymbols[i]);
            }

            for (i = 0; i <= arrAndOr.length - 1; i++) {

                var cnt = i + 1;

                $("#cboQueryJoinOperator_" + cnt).val(arrAndOr[i]);
            }
        }
        
    }
    
    /*************************End Of Added By Nikhil AdkAR***************************************/
    var divcnt = 0;
    $('div.custom-class').on('click', 'i.removethis', function (e) {
        divcnt = divcnt + 1;
        $(this).closest('div.addedrow').remove();

        count = $(".multi-action div.custom-class div.addedrow").length;
        if (count == 0) { addorButton = false; }
    });

    $('div.custom-class').on('click', 'i.removelast', function (e) {
        $('div.addedrow').last().remove();

        count = $(".multi-action div.custom-class div.addedrow").length;
        if (count == 0) { addorButton = false; }
    });

    $("#clearall , .remove.glyphicon-remove-sign").click(function () {
        $('div.addedrow').remove();
        addorButton = false;
        $("#LoadFilterQueryText").html("");
        $("#hdnLoadFilterQueryText").val("");
        $("#AppliedFilterDiv").hide();
        //Added By Bharat T for Clear the applied load filter filter			       
        $(".btnLoadFilter").text("Load Filter");

        $("#hdnLoadFilterID").val("");

        $("#hdnFilterQuery").val("");
       	var chkCurrent = '';
        /*Added by Usha Pandit on 14.01.2019 for Default request selection*/
        try
        {
            var listItems = $("#PageList li");
            //alert(listItems);
            listItems.each(function() {
                var chk = '';
                var product = $(this).attr("onclick");
                if($(this).hasClass("clsFilterDefault") == true)
                {
                    chk=$(this).find("[name=clsFilter]").attr("id");
                    if(chk != undefined)
                    {
                        chk = chk.replace("chk","");
                        //alert(chk);
                    }
                    else
                    {
                        chk = $(this).find("a").attr("id");
                        chk = chk.replace("savedID_","");
                        chk = "DefaultSR";
                        //alert(chk);                        
                    }
                    chkCurrent = chk;
                }
                //alert($(this).find("[name=clsFilter]").attr("id"));
                var isChecked =$(this).find("[name=clsFilter]").attr("checked");              
               
                // and the rest of your code
            }); 
        }
        catch(ex)
        {
            //alert(ex.message);
        }
        /*End of Added by Usha Pandit on 14.01.2019 for Default request selection*/

        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();

        if (chkCurrent != undefined && chkCurrent != null) {//Added bY dipali v ON 2ND JUNE 2020 FOR JAVASCRIPT 
            /*Commented and Added by Usha Pandit on 14.01.2019 for Default request selection*/
            //var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/RemoveFilter", JSON.stringify({ strFilterID: "1" }), false);
            var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/RemoveFilter", JSON.stringify({ strFilterID: chkCurrent }), false);
            /*End of Commented by Usha Pandit on 14.01.2019 for Default request selection*/
        }
        //RefreshGrid(strMode, PageNumber, "LoadFilter");
        window.location.href = "CRM_RequestListNew.aspx?Mode=SR";
        //Added By Bharat T for Clear the applied load filter filter
    });

    /**********************************Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
    var FilterApplyWithoutSaveFlag = false;
    $("#applybutton").click(function () {
        //Commneted nad Modofied by Nikhil Adkar for Edit Filter 
        count = $('#hdndivCounter').val();
        //count = $(".multi-action div.custom-class div.addedrow").length;
        //End of Commented and Added By Nikhil Adkar  for Edit Filter 
        var output = "";
        var a = "", b = "", c = "", d = "";

        for (var i = 0; i <= count; i++) {
            b = $("#cboField_" + i).val();
            c = $("#cboOperator_" + i).val();
            d = $("#FilterControl_" + i).val();
            a = $("#cboQueryJoinOperator_" + i).val();


            if (a != '' && a != null && a != undefined) {
                output += a + ' ';
            }
            if (b != '' && b != null && b != undefined) {
                if (b == 'Status')
                    output += 'Master.Status';
                else
                    output += b;
            }
            if (c != '' && c != null && c != undefined) {

                output += " " + c + " ";
            }
            if (d != '' && d != null && d != undefined) {
                if (c == 'LIKE' || c == 'NOT LIKE')
                    output += " ''%" + d + "%'' ";
                else
                    output += " ''" + d + "'' ";
            }

        }
        //Commented and Added by Usha Pandit on 12 JAN 2018
        //if (d != '' && d != null && d != undefined) {
        if ((d != '' && d != null && d != undefined && b != '' && b != null && b != undefined) || (d == undefined && b == undefined)) {
            //End of Added by Usha Pandit on 12 JAN 2018
            //alert(output);

            var strLoadFilterQueryText = $("#hdnLoadFilterQueryText").val();

            //if (strLoadFilterQueryText != "") {
            //    output += " And (" + strLoadFilterQueryText + ") "
            //}

            $("#hdnFilterQuery").val(output);
            var PageNumber = document.getElementById("hdnCurrentPage").value;
            var strMode = $("#hdnMode").val();
            Inc = 0;
            FilterApplyWithoutSaveFlag = true;
            RefreshGrid(strMode, PageNumber, "ApplyWithoutSave");
        } else {

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please form a query.', 'error');
        }

    });

    //added by nilam rawool on 6 dec 2018 for clear filter issues
    function clearfilter() {
      
        document.getElementById('id16').style.display='none'
        $('#txtFilterName').val('');
        
    }
    //Ended by nilam rawool on 6 dec 2018

    function SaveFilterAsClick() {
        //Commneted nad Modofied by Nikhil Adkar for Edit Filter 
        count = $('#hdndivCounter').val();
        //count = $(".multi-action div.custom-class div.addedrow").length;
        //End of Commented and Added By Nikhil Adkar  for Edit Filter 
        var output = "";
        var a = "", b = "", c = "", d = "";


        for (var i = 0; i <= count; i++) {
            b = $("#cboField_" + i).val();
            c = $("#cboOperator_" + i).val();
            d = $("#FilterControl_" + i).val();
           
           
            //Commented & Added by Sagar N on 31-Dec-2018 for Issue Rows has undefined or null reference
            // a = $("#cboQueryJoinOperator_" + i).val();
           
            if (i > 0) {
                a = $("#cboQueryJoinOperator_" + i).val();
            }
            //Commented & Added by Sagar N on 31-Dec-2018

            if (a != '' && a != null && a != undefined) {
                output += a + ' ';
            }
            if (b != '' && b != null && b != undefined) {
                if (b == 'Status')
                    output += 'Master.Status';
                else
                    output += b;
            }
            if (c != '' && c != null && c != undefined) {

                output += " " + c + " ";
            }
            if (d != '' && d != null && d != undefined) {
                if (c == 'LIKE' || c == 'NOT LIKE')
                    output += " ''%" + d + "%'' ";
                else
                    output += " ''" + d + "'' ";
            }

        }
        if ((d != '' && d != null && d != undefined && b != '' && b != null && b != undefined) || (d == undefined && b == undefined)) {
            document.getElementById('id16').style.display = 'block';
            $('#btnFilterSaveApply').attr('FilterMode', 'SAVE');
        } else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please form a query.', 'error');
        }

    }

    function SaveFilter() {

        //Commneted nad Modofied by Nikhil Adkar for Edit Filter 
        count = $('#hdndivCounter').val();
        //count = $(".multi-action div.custom-class div.addedrow").length;
        //End of Commented and Added By Nikhil Adkar  for Edit Filter 
        var output = "";
        var outputwithcoma = "";
        var a = "", b = "", c = "", d = "";
        var FilterName = $("#txtFilterName").val();
        //Added By Rehan C To add Validator for Special characters validation on 27th Dec 2022
        if (checkSpecialCharacter(FilterName, WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#txtFilterName").focus();
            return false;
        }//End of Comment By Rehan C
        //Added by nilam rawool on 6 dec 2018 for saving blank filter
        //if(FilterName!=''){
        if (/\S/.test(FilterName)) {
            //ende by nilam rawool on 6 dec 2018

            var savedFilterID = 0;
            var SaveFlag = $("#btnFilterSaveApply").attr("FilterMode");

            for (var i = 0; i <= count; i++) {
                b = $("#cboField_" + i).val();
                c = $("#cboOperator_" + i).val();
                d = $("#FilterControl_" + i).val();
                a = $("#cboQueryJoinOperator_" + i).val();


                if (a != '' && a != null && a != undefined) {
                    if (i > 0) {
                        output += a + ' ';
                        outputwithcoma += a + ',';
                    }

                }
                if (b != '' && b != null && b != undefined) {
                    if (b == 'Status') {
                        output += 'Master.Status';
                        outputwithcoma += 'Status,';
                    }
                    else {
                        output += b;
                        outputwithcoma += b + ',';
                    }

                }
                if (c != '' && c != null && c != undefined) {
                    output += " " + c + " ";
                    outputwithcoma += "" + c + ",";
                }
                if (d != '' && d != null && d != undefined) {
                    if (c == 'LIKE' || c == 'NOT LIKE') {
                        output += " ''%" + d + "%'' ";
                        outputwithcoma += d + ',';
                    }
                    else {
                        output += " ''" + d + "'' ";
                        outputwithcoma += d + ',';

                    }
                }

            }
            if ((d != '' && d != null && d != undefined && b != '' && b != null && b != undefined) || (d == undefined && b == undefined)) {
                var strResult, data;
                var strLoadFilterQueryText = $("#hdnLoadFilterQueryText").val();

                //if (strLoadFilterQueryText != "") {
                //    output += " And (" + strLoadFilterQueryText + ") "
                //}

                data = JSON.stringify({ FilterQuery: output, FilterName: FilterName, FilterQuerywithComa: outputwithcoma, FilterID: FilterID });
                strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/SaveFilter", data, false);

                if (strResult.d != '') {
                    var arrResult = strResult.d.split("##");

                    if (arrResult[0] == "error") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(arrResult[1], 'error');
                        return;
                    }
                    else {
                        Inc = 0;
                        savedFilterID = arrResult[1];
                    }

                    $("#txtFilterName").val("");
                }
                //console.log(strResult);

                var strResult1 = AJAXCallWithResult("CRM_RequestListNew.aspx/GetLoadFilterValues", JSON.stringify({}), false);

                if (strResult1.d != '') {
                    var arrstrResult1 = strResult1.d.split("####");

                    $(".clsLoadFilterList").html(arrstrResult1[0]);

                    $(".clsUserSavedFilter").html(arrstrResult1[1]);

                    if (SaveFlag == "SAVEANDAPPLY") {
                        $("div.multi-action div.custom-class").html("");
                        addorButton = false;

                        $(".clsLoadFilterList").find("#" + savedFilterID).click();
                        document.getElementById('id16').style.display = 'none';
                    }
                }
            }
        }
        //Added by nilam rawool on 6 dec 2018 for saving blank filter
        else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('please enter the name of filter', 'error');
        }
    }

        //End of Added by nilam rawool on 6 dec 2018 for saving blank filter
    

    function SaveFilterAndApply() {
        
        //Commneted nad Modofied by Nikhil Adkar for Edit Filter 
        count = $('#hdndivCounter').val();
        //count = $(".multi-action div.custom-class div.addedrow").length;
        //End of Commented and Added By Nikhil Adkar  for Edit Filter 
        var output = "";
        var a = "", b = "", c = "", d = "";


        for (var i = 0; i <= count; i++) {
            b = $("#cboField_" + i).val();
            c = $("#cboOperator_" + i).val();
            d = $("#FilterControl_" + i).val();
            

            //Commented & Added by Sagar N on 31-Dec-2018 for Issue Rows has undefined or null reference
            //a = $("#cboQueryJoinOperator_" + i).val();
           
            if (i > 0) {
                a = $("#cboQueryJoinOperator_" + i).val();
            }
            //Commented & Added by Sagar N on 31-Dec-2018

            if (a != '' && a != null && a != undefined) {
                output += a + ' ';
            }
            if (b != '' && b != null && b != undefined) {
                if (b == 'Status')
                    output += 'Master.Status';
                else
                    output += b;
            }
            if (c != '' && c != null && c != undefined) {

                output += " " + c + " ";
            }
            if (d != '' && d != null && d != undefined) {
                if (c == 'LIKE' || c == 'NOT LIKE')
                    output += " ''%" + d + "%'' ";
                else
                    output += " ''" + d + "'' ";
            }

        }
        
        if ((d != '' && d != null && d != undefined && b != '' && b != null && b != undefined) || (d == undefined && b == undefined)) {
            document.getElementById('id16').style.display = 'block';
            
            if ($("#LoadFilterQueryText").text() != "" && $("#LoadFilterQueryText").text() != 'Example Tag') {
                $("#txtFilterName").val($("#LoadFilterQueryText").text());
            }
            $("#btnFilterSaveApply").attr("FilterMode", "SAVEANDAPPLY");
        } else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please form a query.', 'error');
        }

    }
    /**********************************End of Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/

    function changeA(count, val) {
        $("#a" + count).val(val);
    }

    function changeB(count, val) {
        $("#b" + count).val(val);
       
        var strResult, data;
        data = JSON.stringify({ ControlName: val, count: count, value: "" });
        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetFilterControl", data, false);

        if (strResult.d != "") {
            $("#spnFilterControl_" + count).html(strResult.d);
        }

    }

    function changeC(count, val) {
        $("#c" + count).val(val);
    }

    function changeD(count, val) {
        $("#d" + count).val(val);
    }
    /**********************************Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
    //Added By Bharat T on 5th-Oct-2017
    $(".clsTopNav li a").click(function () {
        $(".clsTopNav li a").removeClass("Active");
        $(this).addClass("Active");

        var strMode = $(this).attr("Mode");
        $("#hdnMode").val(strMode);

        if (strMode == 'Dashboard') {
            $("#divDashboard").show();
            $("#divKnowledge").hide();
            $("#subMainDiv").hide();

        }
        else if (strMode == 'KM') {
            $("#divKnowledge").show();
            $("#divDashboard").hide();
            $("#subMainDiv").hide();
        }
        else if (strMode == 'All') {
            $("#divKnowledge").hide();
            $("#divDashboard").hide();
            $("#subMainDiv").show();
        }

    });
    //Added & Commented By Dipali V On 18th Feb 2021 For Refresh Issue
    //$(".dropdown-menu:not(#PageList) li a").click(function () {
    $(".dropdown-menu:not(#PageList) li a").on("click",function () {
        var selText = $(this).text();
        $(this).parents('.btn-group').find('.dropdown-toggle').html(selText + ' <span class="caret"></span>');
    });
    //End of Added & Commented By Dipali V On 18th Feb 2021 For Refresh Issue

    //Added & Commented By Dipali V On 18th Feb 2021 For Refresh Issue
    //$("#PageList li.dropdown-item a").click(function () {
    $("#PageList li.dropdown-item a").on("click", function () {
  //End of Added & Commented By Dipali V On 18th Feb 2021 For Refresh Issue
        var strMode = $(this).attr("Mode");

        //$("#hdnLoadFilterID").val("");			           

        if (strMode != 'RBS' && strMode != 'RBT') {

            var hdnLoadFilterID = $("#hdnLoadFilterID").val();
            $(".btnLoadFilter").parent().css("pointer-events", "");

            var strResult, data, strFilterID;

            if ((strMode == "RFA" || strMode == "RAR") && hdnLoadFilterID != "" && hdnLoadFilterID != "0") {
                data = JSON.stringify({ FilterID: hdnLoadFilterID, PageMode: strMode });
                strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetFilterQuery", data, false);

                if (strResult.d == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please clear loaded filter query, it may have ambiguous column name error!', 'error');
                    return;
                }
            }
            $("#hdnMode").val(strMode);

            $(".liRequestByST").hide();
            $("#cboFilter").val("0");
            $("#cboDateFilter").val("0");

            $(".clsPageName").text($(this).text());

            selectsubmittedrequest();
            var PageNumber = document.getElementById("hdnCurrentPage").value;
            //Added by Chetan M on 13 May 2021 for filterring data

            IsDefaultFilter = "False";
            //End of Added by Chetan M on 13 May 2021 for filterring data
            RefreshGrid(strMode, PageNumber, "");
            //Commented by Chetan M on 13 May 2021 for filterring data
            //IsDefaultFilter = "False";
            //End of Commented by Chetan M on 13 May 2021 for filterring data
        }
        else {
            $(".liRequestByST").show();
            $(".clsPageName").text($(this).text());
            //Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
            selectsubmittedrequest();
            //End Of Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue

            if (strMode == 'RBS') {

                $(".btnLoadFilter").parent().css("pointer-events", "none");
                $("#cboFilter").addClass("clsHighlightBorder");
                $("#cboFilter").show();
                $("#cboDateFilter").hide();
            }
            else if (strMode == 'RBT') {
                $(".btnLoadFilter").parent().css("pointer-events", "");

                $("#cboDateFilter").addClass("clsHighlightBorder");
                $("#cboDateFilter").show();
                $("#cboFilter").hide();
            }
        }


    });

    function SerachFilterList_Click(FieldType) {
        if (FieldType != "") {
            $("#filterSpan").text(FieldType);
            //debugger;
            //Added By Dipali V On 29th Dec 2020 For Deirection Upgarde
            $("#clsFilterLinks #Clscontrol").removeClass("Clscontrol");
              //End of Added By Dipali V On 29th Dec 2020 For Deirection Upgarde
            var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetSerachFilterControl", JSON.stringify({ FieldType: FieldType }), false);
           
            $(".clsFilterName").attr("FilterName", FieldType);
           
            if (strResult.d != "") {
                //debugger;
                $("li.clsSerachControl").html(strResult.d);
                //Added By Dipali V On 24th March 2023 For Predefine filter should close
                $("#seachValueList").removeClass('show');
                  //End of Added By Dipali V On 24th March 2023 For Predefine filter should close
                $(".clsSerachControl .form-control").on("keypress", function (event) {

                    if (event.which == 13) {
                        $(".clsGo").click();

                        event.preventDefault();
                        event.stopPropagation();

                    }

                });
            }
        }
        else {
           
            $("#filterSpan").text("");
            $(".clsFilterName").attr("FilterName", "");
            $("li.clsSerachControl").html("<input type='text' class='form-control clsSearchAllBox' placeholder='Search for...'>");
        }

    }


    //$(".clsSerachControl .form-control").on("keypress", function () {
    //   // debugger;
    //    $("#Clscontrol").css("z-index", "auto!important");

    //});

    //Added by Usha Pandit on 12 JAN 2018 for preventing characters 
    var specialKeys = new Array();
    specialKeys.push(8); //Backspace
    function validateRequestID(e) {
        var keyCode = e.which ? e.which : e.keyCode
       
        var flag = 0;
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
        {
            if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                //alertify.set('notifier', 'position', 'top-right');
                //alertify.notify('- Please enter only positive numeric value for "Contact".', 'error');
            }
        }
        return ret;
    }
    //End of added by Usha Pandit on 12 JAN 2018 for preventing characters 

    function LoadFilterClick(object, LoadFilterFlag) {

        var strResult, data, strFilterID;

        if (object.id.indexOf("savedID_") >= 0) {

            /*Added by Usha Pandit on 14.01.2019 for Default request selection*/
            $(".clsPageName").text($(object).text());
            //Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
            selectsubmittedrequest();
            //End Of Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
            /*End of Added by Usha Pandit on 14.01.2019 for Default request selection*/

            strFilterID = object.id.split("savedID_")[1];
        }
        else {
            strFilterID = object.id;
        }

        data = JSON.stringify({ FilterID: strFilterID, PageMode: $("#hdnMode").val() });
        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetFilterQuery", data, false);

        if (strFilterID == "") {
            $("#LoadFilterQueryText").html("");
            $("#hdnLoadFilterQueryText").val("");
            $("#AppliedFilterDiv").hide();
        }
        else {

            if (strResult.d != "") {
                $("div.multi-action div.custom-class").html("");
                var arrstrQuery = strResult.d.split('||');
                $("#LoadFilterQueryText").text($(object).text());
                $("#LoadFilterQueryText").parent().attr("data-toggle", "tooltip");
                //$("#LoadFilterQueryText").parent().attr("data-original-title", strResult.d);
                $("#LoadFilterQueryText").parent().attr("data-original-title", arrstrQuery[0]);
                $("#hdnLoadFilterQueryText").val(arrstrQuery[0]);
                $("#AppliedFilterDiv").show();
                //Added By Nikhil Adkar for edit Filter
                $("#EditFilterDiv").show();
                $("#hdnEditQuery").val(arrstrQuery[1]);
                $('#addFilter').prop("disabled", true);
                if (Inc > 0) {
                    Inc = 0;
                }
                //End of added by Nikhil Adkar for Edit Filter

                //$('[data-toggle="tooltip"]').tooltip();
                //fillfilterDetails(arrstrQuery[1]);

            }
            else if (strResult.d == "" && ($("#hdnMode").val() == "RFA" || $("#hdnMode").val() == "RAR")) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please select another query this query may have ambiguous column error.', 'error');
                return;
            }
        }

        if ($(object).text().trim() == "") {
            $(".btnLoadFilter").text("Load Filter");
        }
        else {
            $(".btnLoadFilter").text($(object).text());
        }

        $("#hdnLoadFilterID").val(strFilterID);

        if (LoadFilterFlag != "SavedLoadFilter2" && LoadFilterFlag != "RequestListPageBack")
            $("#hdnMode").val("All");

        $("#hdnFilterQuery").val("");
        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();

        if (LoadFilterFlag != "LoadSavedFilter" && LoadFilterFlag != "RequestListPageBack")
            RefreshGrid(strMode, PageNumber, "LoadFilter");
        IsDefaultFilter = "False";

        /*Added by Usha Pandit on 14.01.2019 for Default request selection*/
        var chk = '';
        try
        {
           
            var listItems = $("#PageList li");
           
            listItems.each(function() {
                var product = $(this).attr("onclick");

                
                if($(this).hasClass("clsFilterDefault") == true)
                {
                    chk=$(this).find("[name=clsFilter]").attr("id");
                    if(chk != undefined)
                    {
                        chk = chk.replace("chk","");                       
                    }
                    else
                    {
                        chk = '';
                    }
                }             
               
            });
        }
        catch(ex)
        {
            //alert(ex.message);
        } 
        
        if(chk == '')
        {
            $(".clsPageName").text($(object).text());
            //Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
            selectsubmittedrequest();
            //End Of Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
        }
        
        /*End of Added by Usha Pandit on 14.01.2019 for Default request selection*/

    }
    //Added By Nikhil Adkar for edit filters
    $("#EditFilter").click(function () {
        var strQuery = $("#hdnEditQuery").val();
        $("#header-fixed").css("display", "none");

        $('#addFilter').prop("disabled", false);
        //alert(strQuery);
        fillfilterDetails(strQuery);
    });
    //End of Added By Nikhil Adkar
    //$('.clsSearchAllBox').on('keyup', function () {
    //    var value = $(this).val();
    //    var patt = new RegExp(value, "i");			       

    //    $('#divGrid table tbody').find('tr').not("tr.hiddenRow").each(function () {
    //        if (!($(this).find('td').text().search(patt) >= 0)) {
    //            $(this).hide();
    //        }

    //        if (($(this).find('td').text().search(patt) >= 0)) {
    //            $(this).show();
    //        }
    //    });

    //});

    function RefreshGrid(PageMode, PageNumber, Flag) {
        //Added By Reshma Chavan on 23 feb 2021 for Add Loader For issueID-29179 takes time to load data
        setFrameLoader();
        //End of Added By Reshma Chavan on 23 feb 2021 for Add Loader For issueID-29179 takes time to load data
        var GridParameter = {};
        var strSearchType;
        var strTextSearch, objectControl;
        var strTextSearch_ForQuery;
        var m_AdvanceFilter = '';
        var objFilterID, objDateFilterID;
        var FilterQuery, hdnLoadFilterID;

        var strNewFilterID = $("#hdnNewFilterID").val();
        strSearchType = $(".clsFilterName").attr("filtername");

        objFilterID = document.getElementById("cboFilter");
        objDateFilterID = document.getElementById("cboDateFilter");
        FilterQuery = $("#hdnFilterQuery").val();
        hdnLoadFilterID = $("#hdnLoadFilterID").val();


        if (hdnLoadFilterID == "")
            hdnLoadFilterID = "0";

        switch (strSearchType) {
              //Commented & added by dipali V june 2019 for DropDown issue
             //Commented and Added by Usha Pandit on 04.04.2019 for Priority/Severity display issue
            case "Priority":
                objectControl = document.getElementById("cboPriority");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " PriorityID = " + objectControl.value;

                break;
            //case "Severity":
            //    objectControl = document.getElementById("cboPriority");

            //    if (objectControl != null && objectControl.value != '')
            //        m_AdvanceFilter = " PriorityID = " + objectControl.value;

            //    break;
            //End of Added by Usha Pandit on 04.04.2019 for Priority/Severity display issue
              //End of Commented & added by dipali V june 2019 for DropDown issue
            case "Assigned To":
                objectControl = document.getElementById("cboAssignedTo");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " AssignToID = " + objectControl.value;
                break;
            case "Customer":

                objectControl = document.getElementById("cboCustomer");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " CustomerId = ''" + objectControl.value + "'' AND LoginType = ''C'' ";
                break;
            case "Employee":

                objectControl = document.getElementById("cboEmployee");


                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " CustomerId = ''" + objectControl.value + "'' AND LoginType = ''E'' ";
                break;
            case "Location":

                objectControl = document.getElementById("cboLocation");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " TargetLocationId = " + objectControl.value;
                break;
            case "Request Type":

                objectControl = document.getElementById("cboRequestType");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " RequestTypeId = " + objectControl.value;
                break;
            case "Sub Request Type":

                objectControl = document.getElementById("cboSubRequestType");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " SubRequestTypeID = " + objectControl.value;
                break;
            case "Subject":

                objectControl = document.getElementById("txtSubject");

                if (objectControl != null && objectControl.value != '') {
                    strTextSearch = objectControl.value;

                    strTextSearch_ForQuery = strTextSearch;

                    strTextSearch_ForQuery = strTextSearch_ForQuery.replace("%", "[%]");
                    strTextSearch_ForQuery = strTextSearch_ForQuery.replace("_", "[_]");

                    m_AdvanceFilter = " Subject Like ''%" + strTextSearch_ForQuery + "%'' ";
                }
                break;
            //Commented & added by dipali V june 2019 for DropDown issue
            //Commented and Added by Usha Pandit on 04.04.2019 for Priority/Severity display issue
              case "Severity":

                objectControl = document.getElementById("cboSeverity");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " SeverityID  = " + objectControl.value;
                break;

                //case "Priority":

                //objectControl = document.getElementById("cboSeverity");

                //if (objectControl != null && objectControl.value != '')
                //    m_AdvanceFilter = " SeverityID  = " + objectControl.value;
                //break;
             //End of Added by Usha Pandit on 04.04.2019 for Priority/Severity display issue
              //End of Commented & added by dipali V june 2019 for DropDown issue
            case "Request ID":

                objectControl = document.getElementById("txtRequestID");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " QueryID  = " + objectControl.value;
                break;
            default:
                strTextSearch = "";
                break;
        }

        GridParameter.StatusID = "0";
        GridParameter.DepartmentID = "0";
        GridParameter.SortBy = "SUBMITTEDDATE";
        GridParameter.SortOrder = "DESC";

        //alert(IsDefaultFilter)

        GridParameter.IsDefaultFilter = IsDefaultFilter;

        if (Flag == 'ApplyWithoutSave') {
            GridParameter.FilterID = "0";
            GridParameter.FilterQuery = FilterQuery;
            FilterApplyWithoutSaveFlag = true;
        }
        else if (Flag == 'LoadFilter') {
            GridParameter.FilterID = hdnLoadFilterID;
            GridParameter.FilterQuery = "";
            FilterApplyWithoutSaveFlag = false;
        }
        else {

            if ($("#hdnLoadFilterID").val() != "") {
                GridParameter.FilterID = $("#hdnLoadFilterID").val();
                GridParameter.FilterQuery = "";
            }
            else {
                if (objFilterID != null && objFilterID.value != "" && objFilterID.value != "0") {
                    GridParameter.FilterID = objFilterID.value;
                    GridParameter.FilterQuery = "";
                }
                else
                    GridParameter.FilterID = "0";
                GridParameter.FilterQuery = FilterQuery;
            }

            FilterApplyWithoutSaveFlag = false;
        }

        GridParameter.NewFilterID = strNewFilterID;

        if (objDateFilterID != null)
            GridParameter.DateFilter = objDateFilterID.value;
        else
            GridParameter.DateFilter = "";

        GridParameter.AdvanceFilter = m_AdvanceFilter;


        if ('<%=HttpContext.Current.Session("LoginType")%>' == 'C') {
            if (PageMode == "")
                PageMode = "MR";
        }
        else {
            if (PageMode == "")
                PageMode = "All";
        }

        GridParameter.PageMode = PageMode;
        GridParameter.PageNumber = PageNumber;

        //console.log(GridParameter)
        //Added By Usha Pandit On 15.10.2020 For clearing applied custom filter if predefined filter is selected
        if (Flag == "") {
            GridParameter.FilterQuery = "";
        }
        //End Of Added By Usha Pandit On 15.10.2020 For clearing applied custom filter if predefined filter is selected
        var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/RefreshGrid", JSON.stringify({ GridParameter: GridParameter }), false);
        if (strResult.d != "") {
            var arrResult = strResult.d.split("#$Paging$#");

            $(".table-responsive").html(arrResult[0]);

            //$(".navPagination").html(arrResult[1]);

            $(".navPagination").map(function () {
                $(this).html(arrResult[1]);
            });

            $("#divGrid > table").attr("id", "tblRequestList");
            $("#divGrid table").addClass("table table-bordred table-striped table-condensed");
            $("#divGrid table").css("border-collapse", "collapse");
            //$("#divList table").css("border-spacing", "0px 10px");
            $("#divGrid table tbody td").css("border-bottom", "1px solid #ddd");
            //setTimeout(function () {
            //    $(".btnRefresh").find("i").removeClass("fa-spin");
            //}, 1000);
            //var tableOffset = $("#divGrid > table").offset().top;
            //var $header = $("#divGrid > table > thead").clone();
            //var $fixedHeader = $("#header-fixed").append($header);

            // Added by nilam rawool on 8 jan 2019 
            //if(flagchk!=1)
            //{
                // End of Added by nilam rawool on 8 jan 2019 

                for (var h = 0; h <= strSelectedRequestsList.length; h++) {
                    //Commented and Added by nilam rawool on 7 dec 2018 for issueid 15751
                    //var objectCheck = document.getElementById("chkSelect_" + strSelectedRequestsList[h]);

                    //if (objectCheck != null) {
                    //    objectCheck.checked = true;
                    //}

                    if($("#chkSelect_"+ strSelectedRequestsList[h]).is('[disabled]') == false)
                    {
                        var objectCheck = document.getElementById("chkSelect_" + strSelectedRequestsList[h]);

                        if (objectCheck != null) {
                            //commented and added by nilam rawool on  12/28/2018
                            //objectCheck.checked = true;
                            $('input[name=chkSelectHeader]:not(:disabled)').prop('checked', true);
                            //End of added by nilam rawool on  12/28/2018
                        }
                    }

                    if (objectCheck != null) {                    
                        objectCheck.checked = true;                 
                    }

                    //End of Added by nilam rawool on 7 dec 2018 for issueid 15751
                }
                // Added by nilam rawool on 8 jan 2019 
            //}
            //else{
            //    if (objectCheck == null) 
            //    {
            //        $("input[name=chkSelect]").prop("checked", false); 
            //        $("input[name=chkSelectHeader]").prop("checked", false);   
            //        //$('input[name=chkSelect]:not(:disabled)').prop('checked', false);
            //        //$('input[name=chkSelectHeader]:not(:disabled)').prop('checked', false);
            //    }
            //}
            // End of Added by nilam rawool on 8 jan 2019 
            $("#divGrid > table thead.clsTRColumnHeader th").map(function (count) {
                var colHeaderText = $(this).text();
                var strShortHeaderName;

                //$(this).attr('data-toggle', 'tooltip');
                //$(this).attr('title', colHeaderText);
                //$(this).attr('data-original-title', colHeaderText);
                //$(this).addClass("bs-tooltip-top");

                if (colHeaderText.length > 18) {
                    strShortHeaderName = colHeaderText.substr(0, 18);


                    $(this).text(strShortHeaderName + "..");
                }

                if ($(this).html().indexOf("fa-flag") > 0 || $(this).html().indexOf("fa-comments-o") > 0 || $(this).html().indexOf("fa-paperclip") > 0 || $(this).html().indexOf("fa-pencil-square-o") > 0 || $(this).html() == "" || $(this).html().indexOf("checkbox") > 0) {

                }
                else {
                    if (typeof $(this).attr("isdatecolumn") != "undefined") {
                        //$(this).attr("onclick", "sortTable('tblRequestList'," + count + ",'DateColumn');");
                        //$(this).attr("onclick", "sortByDate(" + count + ");");

                    }
                    else {
                        $(this).attr("onclick", "sortTable('tblRequestList'," + count + ",'');");
                    }

                }

                //$('body').tooltip({
                //    selector: '.divGrid'
                //});
                $("[data-toggle='tooltip']").tooltip();
                $(".clsControlHeight").tooltip();
            });

            //var $header = $("#divGrid > table > thead").clone();
            //var $fixedHeader = $("#header-fixed").append($header);

            //$("#MainDiv").scroll(function () {
            $("#MainDiv").on("scroll", function () {
                var offset = $(this).scrollTop();
                if ($fixedHeader != undefined) {
                    if (offset >= tableOffset && $fixedHeader.is(":hidden")) {
                        $fixedHeader.show();
                        $("#clsFilterLinks").css("position", "fixed");
                        $("#clsFilterLinks").css("width", "97%");
                        if (WhichBrowser() != 'IE') {
                            $fixedHeader.css("margin-top", "61px");
                            $("#header-fixed").css("display", "none !important");
                        }
                        else {
                            $fixedHeader.css("margin-top", "66px");
                        }
                    }

                    else if (offset < tableOffset) {
                        $("#clsFilterLinks").css("width", "");
                        $("#clsFilterLinks").css("position", "");
                        $("#header-fixed").css("display", "none !important");
                        $fixedHeader.hide();
                    }
                }

                //$("#clsFilterLinks").css("top", offset + 'px');
            });
             //Added By Reshma Chavan Add Loader For issueID-29179 takes time to load data          
            setTimeout(function () { RemoveFrameLoader(); }, 1000);
             //End of Added By Reshma Chavan Add Loader For issueID-29179 takes time to load data
            //Added By Dipali V On 1st March 2021 For Scroll issue
         // $(window).on("load resize scroll", function (e) {
            resizeSection(this);
           
        //}); //End Added script by pradip on 24-2-2021
        
        //End of Added By Dipali V On 1st March 2021 For Scroll issue
        }
    }


//Added script by pradip on 24-2-2021
function resizeSection() {
            var Contentheight = $(window).height();
            $('.gridtblheight>div#divGrid').css({ 'height': Contentheight - 220, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
           
        }); //End Added script by pradip on 24-2-2021


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

    $(".clsSerachControl .form-control").on("keypress", function (event) {

        if (event.which == 13) {
            $(".clsGo").click();

            event.preventDefault();
            event.stopPropagation();

        }
    });


    $(".clsGo").click(function () {

        var strMode = $("#hdnMode").val();
        var PageNumber = document.getElementById("hdnCurrentPage").value;


        var ajaxParameter = {};
        var strSearchType;
        var objectControl;

        strSearchType = $(".clsFilterName").attr("filtername");



        if (strSearchType == "") {
            alertify.set('notifier', 'position', 'top-right'); 
            
            // Commented and Added by Poonam S on 26/12/2018 for issue id-16577
            //alertify.notify('Please select at least one filter from the list', 'error'); 
            alertify.notify('Please select at least one filter from the list', 'error',5);            
            return;
            //Ended by Poonam S on 26/12/2018 for issue id-16577

            //return;
        }

        //setFrameLoader();

        switch (strSearchType) {
            case "Priority":
                objectControl = document.getElementById("cboPriority");
                break;
            case "Assigned To":
                objectControl = document.getElementById("cboAssignedTo");
                break;
            case "Customer":
                objectControl = document.getElementById("cboCustomer");
                break;
            case "Employee":
                objectControl = document.getElementById("cboEmployee");
                break;
            case "Location":
                objectControl = document.getElementById("cboLocation");
                break;
            case "Request Type":
                objectControl = document.getElementById("cboRequestType");
                break;
            case "Sub Request Type":
                objectControl = document.getElementById("cboSubRequestType");
                break;
            case "Subject":
                objectControl = document.getElementById("txtSubject");
                break;
            case "Severity":
                objectControl = document.getElementById("cboSeverity");
                break;
            case "Request ID":
                objectControl = document.getElementById("txtRequestID");

                if (isNumeric(objectControl.value) == false) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please enter only positive integers!', 'error');
                    return;
                }

                break;
            default:
                strTextSearch = "";
                break;
        }

        ajaxParameter.SearchFilterName = strSearchType;

        if (objectControl != null) {
            ajaxParameter.SearchFilterValue = objectControl.value;
        }
        else {
            ajaxParameter.SearchFilterValue = '';
        }

        var data = JSON.stringify({ ajaxParameter: ajaxParameter });
        var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/SaveSearchFilter", data, false);


        RefreshGrid(strMode, PageNumber, "GoClick");

        //setTimeout(function () { RemoveFrameLoader(); }, 1000);

    });

    $(".btnRefresh").click(function () {

        setFrameLoader();
        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();
        window.location.href = "CRM_RequestListNew.aspx?Mode=SR";
        //RefreshGrid(strMode, PageNumber, "LoadFilter");
        //var PageNumber = document.getElementById("hdnCurrentPage").value;
        //var strMode = $("#hdnMode").val();

        //RefreshGrid(strMode, PageNumber, "");

        //setTimeout(function () { RemoveFrameLoader(); }, 1000);


    });

    $(".btnAcceptDeclineRequests").click(function () {
        var strAction = $(this).attr("Mode");
        var strResult, data, strQueryIDList;
        var dataParamter = {};
        var strApproveRejectComment = '';

        strQueryIDList = $("input[name=chkApprovalIDs]:checked").map(function () {
            return this.value;
        }).get().join(",");

        if (strQueryIDList == "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('There is no request for approval!', 'error');
            return;
        }

        if ($("#comment").val().trim() == "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Comment is mandatory for approval!', 'error');
            return;
        }

        if (strAction == "A") {
            strApproveRejectComment = "Approved : " + $("#comment").val();
        }
        else if (strAction == "R") {
            strApproveRejectComment = "Rejected : " + $("#comment").val();
        }

        dataParamter.strQueryIDList = strQueryIDList;
        dataParamter.strApproveRejectComment = strApproveRejectComment;
        dataParamter.strAction = strAction;

        data = JSON.stringify({ dataParamter: dataParamter });

        setFrameLoader();
        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/ApproveRejectRequest", data, false);

        if (strResult.d != "") {
            RemoveFrameLoader();

            if (strAction == "A") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Requests are approved successfully!', 'success');
            }
            else if (strAction == "R") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Requests are rejected successfully!', 'success');
            }

            document.getElementById('id01').style.display = 'none';
        }

        //Added By Dipali V On 2nd June for Refresh grid after approve Req
       // window.location.href = "CRM_RequestListNew.aspx?Mode=SR";
         setTimeout(function () { //Added By Usha Pandit On 18.04.2020 For alert was getting disappear soon due to refresh
           $(".btnRefresh").trigger("click");
        }, 3000);
         //End of Added By Dipali V On 2nd June for Refresh grid after approve Req
        //});

    });
    /**********************************End of Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
    //Added By Bharat T on 10th-Jan-2017 to return result from jquery ajax
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
                console.log(xhr.responseText);
                //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

        return AjaxResult;
    }
    //Endo f Added By Bharat T on 10th-Jan-2017 to return result from jquery ajax
    //End of Added By Bharat T on 5th-Oct-2017

</script>
<script>
    // Get the modal for approve button
    //Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE

    $('.modal').draggable({ delay: 200, iframeFix: true });

    //End of Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE

    var modal = document.getElementById('id01');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>

<script>
    // Get the modal for Flag icon
    //Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE
    $('.modal').draggable({ delay: 200, iframeFix: true });
    //End of Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE

    var modal = document.getElementById('id02');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>

<script>
    // Get the modal for attachment icon
   // $('.modal').draggable({delay: 200, iframeFix: false,containment:'container-fluid',scroll: false });
    //$( "#id03" ).draggable({ containment: "#MainDiv"});
    //$("#id03").modal();
    $('#id03').draggable({
         scroll : false,
         containment: "#MainDiv"
        
    });
    var modal = document.getElementById('id03');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>


<%--Commented By Vidya Jadhav ON 31 Oct 2017--%>
<script>
    // Get the modal import for netx browse button
    //Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE
    $('.modal').draggable({ delay: 200, iframeFix: true });
    //End of Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE
    var modal = document.getElementById('id05');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
<%--End Of Commented By Vidya Jadhav ON 31 Oct 2017--%>
<%-- Code from 1510 html file --%>
<script>
    // Get the modal for Flag icon

    //Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE
    $('.modal').draggable();
    //End of Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE

    var modal = document.getElementById('id016');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
<script>
    // Get the modal for Flag icon

    //Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE
    //$('.modal').draggable();
    //End of Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE

    var modal = document.getElementById('id017');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
<script>
    // Get the modal for Flag icon
    //Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE
    $('.modal').draggable();
    //End of Commented by Usha Pandit on 01.01.2019 for Modal Popup Move with Cursor in IE

    var modal = document.getElementById('id018');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
<%-- Code from 1510 html file --%>

<script>

    var IsDefaultFilter = "False";
    //added by nilam rawool 8 jan 2018
    //var flagchk=0;
    //ende by nilam rawool 8 jan 2018
    $(document).ready(function () {
        $('.collapse.in').prev('.panel-heading').addClass('active');
        $('#accordion, #bs-collapse')
          .on('show.bs.collapse', function (a) {
              $(a.target).prev('.panel-heading').addClass('active');
          })
          .on('hide.bs.collapse', function (a) {
              $(a.target).prev('.panel-heading').removeClass('active');
          });

        /**********************************Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
        var ObjTd = window.frames.parent.document.getElementById('tdTree')
        var ObjImg = window.frames.parent.document.getElementById('ImgShowHide')
        var ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')

        if (ObjTd != null && ObjImg != null) {

            ObjTd.style.display = 'none';
            ObjImg.src = '../../Images/Home/RightMove.gif';
            ObjLeftnavigation.style.display = '';
        }


        //*********************************************Bharat**************************************************************
        var strMode = $("#hdnMode").val();
        var strFilterName = '<%=m_SearchFilterName%>';
        var strSearchFilterValue = '<%=m_SearchFilterValue%>';

        var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetSerachFilterValues", JSON.stringify({ Mode: strMode }), false);

        if (strResult.d != '') {
            $("#seachValueList").html(strResult.d);
        }

        var strResult1 = AJAXCallWithResult("CRM_RequestListNew.aspx/GetLoadFilterValues", JSON.stringify({}), false);


        if (strResult1.d != '') {
            var arrstrResult1 = strResult1.d.split("####");

            $(".clsLoadFilterList").html(arrstrResult1[0]);

            $(".clsUserSavedFilter").html(arrstrResult1[1]);



            var attr = $("#PageList").find(".clsFilterDefault").find("a").attr('mode')

            //alert(attr);
            if (typeof attr !== undefined && attr !== false) {

                $("#hdnMode").val($("#PageList li.clsFilterDefault a").attr("mode"));
                IsDefaultFilter = "True";
            }
            else {
                $("#hdnMode").val("All");
                IsDefaultFilter = "True";
                $("#hdnLoadFilterID").val("<%=m_lngFilterNewID%>");
            }
            //$('[data-toggle="tooltip"]').tooltip();
        }

        $("#divGrid table").addClass("table table-bordred table-striped table-condensed");
        $("#divGrid table").css("border-collapse", "collapse");
        //$("#divList table").css("border-spacing", "0px 10px");
        $("#divGrid table tbody td").css("border-bottom", "1px solid #ddd");

        //*********************************************Bharat**************************************************************

        <%If Request.QueryString("QueryID") IsNot Nothing Then%>
        Query_OnClick(<%=Request.QueryString("QueryID")%>, 'True');
        <%End If%>

       // debugger;
        //alert(strFilterName);
        //Added By Dipali V On 15th Feb 2021 For Filter Clear Issues
        if (strFilterName != "0") {
            $("#filterSpan").text(strFilterName);
            SerachFilterList_Click(strFilterName);
            $(".clsTextBox").val(strSearchFilterValue);
        }
         //End of Added By Dipali V On 15th Feb 2021 For Filter Clear Issues
    });
    var tableOffset;
    var $fixedHeader;
    var $header;

     //Commented & Added By Dipali V on 25th Dec 2020 For Jquery Version Issues
   // $(window).load(function () {
    $(window).on("load", function () {
  //End of Commented & Added By Dipali V on 25th Dec 2020 For Jquery Version Issues
        //To show default saved filter on page
        var strFilterName = '<%=m_SearchFilterName%>';
        var strFilterValue = '<%=m_SearchFilterValue%>';
        var strLoadFilterID = '<%=m_lngFilterID%>';
        var strNewFilterID = '<%=m_lngFilterNewID%>';

        var strMode = '<%=m_strMode%>';
        var strPageNumber = '<%=m_intPageNumber%>';
        var strPageFlag = '<%=m_strPageFlag%>';
        var strStatusFilterID = '<%=m_strStatusFilterID%>';
        var strDateFilterID = '<%=m_strDateFilterID%>';

        var arrPageFlag = ["DefaultSR", "All", "MR", "FR", "RFA", "RAR"];

        if (strFilterName != '' && strFilterName != '0' && strFilterValue != '0')
            document.getElementById(strFilterName).click();

        if (strFilterName.toUpperCase() == "PRIORITY") {
            document.getElementById("cboPriority").value = strFilterValue;
        } else if (strFilterName.toUpperCase() == "ASSIGNED TO") {
            document.getElementById("cboAssignedTo").value = strFilterValue;
        } else if (strFilterName.toUpperCase() == "CUSTOMER") {
            document.getElementById("cboCustomer").value = strFilterValue;
        } else if (strFilterName.toUpperCase() == "EMPLOYEE") {
            document.getElementById("cboEmployee").value = strFilterValue;
        } else if (strFilterName.toUpperCase() == "LOCATION") {
            document.getElementById("cboLocation").value = strFilterValue;
        } else if (strFilterName.toUpperCase() == "REQUEST TYPE") {
            document.getElementById("cboRequestType").value = strFilterValue;
        } else if (strFilterName.toUpperCase() == "SUB REQUEST TYPE") {
            document.getElementById("cboSubRequestType").value = strFilterValue;
        } else if (strFilterName.toUpperCase() == "SUBJECT") {
            document.getElementById("txtSubject").value = strFilterValue;
        } else if (strFilterName.toUpperCase() == "SEVERITY") {
            document.getElementById("cboSeverity").value = strFilterValue;
        } else if (strFilterName.toUpperCase() == "REQUEST ID") {
            document.getElementById("txtRequestID").value = strFilterValue;
        }

        var objLoadFilterAnchor = $(".clsLoadFilterList a#" + strLoadFilterID);

        //if (objLoadFilterAnchor.length > 0) {
        //    if (objLoadFilterAnchor.text().trim() == "") {
        //        $(".btnLoadFilter").text("Load Filter");
        //    }
        //    else {
        //        $(".btnLoadFilter").text(objLoadFilterAnchor.text());
        //    }

        //    $("#hdnLoadFilterID").val(strLoadFilterID);

        //    $("#hdnFilterQuery").val("");
        //}
        var strCountResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetRequestCounts", JSON.stringify({}), false);
        
        if (strCountResult.d != "") {
            var arrstrCountResult = strCountResult.d.split("$$");

            if ($("#spnAll").length > 0)
                $("#spnAll").text(arrstrCountResult[0]);

            if ($("#spnSR").length > 0)
                $("#spnSR").text(arrstrCountResult[1]);

            if ($("#spnMR").length > 0)
                $("#spnMR").text(arrstrCountResult[2]);

            if ($("#spnFR").length > 0)
                $("#spnFR").text(arrstrCountResult[3]);

            if ($("#spnRFA").length > 0)
                $("#spnRFA").text(arrstrCountResult[4]);

            if ($("#spnRAR").length > 0)
                $("#spnRAR").text(arrstrCountResult[5]);
        }


        if (arrPageFlag.indexOf(strNewFilterID) >= 0) {
            $("#chk" + strNewFilterID).prop("checked", true);
            $("#chk" + strNewFilterID).parent().addClass("clsFilterDefault");

            var attr = $("#PageList").find(".clsFilterDefault").find("a").attr('mode')

            if (typeof attr !== "undefined" && attr !== false) {

                $("#hdnMode").val($("#PageList li.clsFilterDefault a").attr("mode"));
                $(".clsPageName").text($("#PageList").find(".clsFilterDefault").find("a").text());
                 //Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
            selectsubmittedrequest();
            //End Of Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
                IsDefaultFilter = "False";
            }
            else {

                $("#hdnMode").val("All");
                $("#hdnLoadFilterID").val("<%=m_lngFilterNewID%>");
                IsDefaultFilter = "True";
            }

        }
        else {
            $("#hdnMode").val("DefaultSR");
            IsDefaultFilter = "False";
        }

        if (strMode == "RequestListPageBack") {

            var object = document.getElementById("savedID_" + strNewFilterID + "");


            if ((strStatusFilterID != "" && strStatusFilterID != "0") || (strDateFilterID != "" && strDateFilterID != "0")) {

                if (strStatusFilterID != "" && strStatusFilterID != "0") {
                    $("#cboFilter").val(strStatusFilterID);
                    $("#PageList li a[Mode=RBS]").click();
                    strPageFlag = "RBS";
                }
                else if (strDateFilterID != "" && strDateFilterID != "0") {
                    $("#cboDateFilter").val(strDateFilterID);
                    $("#PageList li a[Mode=RBT]").click();
                    strPageFlag = "RBT";
                }

                if (object != null)
                    LoadFilterClick(object, strMode);

                $("#hdnCurrentPage").val(strPageNumber);
                $("#hdnMode").val(strPageFlag);
                $("#hdnLoadFilterID").val(strNewFilterID);
                IsDefaultFilter = "False";
            }
            else {
                if (object != null)
                    LoadFilterClick(object, strMode);

                if (arrPageFlag.indexOf(strPageFlag) >= 0) {

                    $("#chk" + strPageFlag).prop("checked", true);
                    $("#chk" + strPageFlag).parent().addClass("clsFilterDefault");

                    var attr = $("#PageList").find(".clsFilterDefault").find("a").attr('mode')

                    if (typeof attr !== "undefined" && attr !== false) {

                        $("#hdnMode").val($("#PageList li.clsFilterDefault a").attr("mode"));
                        $(".clsPageName").text($("#PageList").find(".clsFilterDefault").find("a").text());
                         //Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
                        selectsubmittedrequest();
                        //End Of Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
                        IsDefaultFilter = "False";
                    }
                    else {

                        $("#hdnMode").val("All");
                        $("#hdnLoadFilterID").val("<%=m_lngFilterNewID%>");
                        IsDefaultFilter = "True";
                    }
                }

                $("#hdnCurrentPage").val(strPageNumber);
                $("#hdnMode").val(strPageFlag);
                $("#hdnLoadFilterID").val(strNewFilterID);
                IsDefaultFilter = "False";
            }

            $(".clsPageName").text($("#PageList").find("a[mode=" + strPageFlag + "]").text());
             //Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
            selectsubmittedrequest();
            //End Of Added By Usha Pandit On 09.07.2019 for multiple checkbox check issue
        }


        tableOffset = $("#tblRequestList").offset().top;
        $header = $("#divGrid > table > thead").clone();
        $fixedHeader = $("#header-fixed").append($header);
        $("#header-fixed").css('display', 'none');//19th Aug 2023

       // $("#MainDiv").scroll(function () {
         $("#MainDiv").on("scroll", function () {
            var offset = $(this).scrollTop();

            if (offset >= tableOffset && $fixedHeader.is(":hidden")) {
                $fixedHeader.show();
                $("#clsFilterLinks").css("position", "fixed");
                $("#clsFilterLinks").css("width", "97%");
                $("#header-fixed").css("display", "none !important");
                if (WhichBrowser() != 'IE') {
                    $fixedHeader.css("margin-top", "61px");

                }
                else {
                    
                    $fixedHeader.css("margin-top", "66px");
                }
            }
            else if (offset < tableOffset) {
                $("#header-fixed").css("display", "none !important");
                $("#clsFilterLinks").css("width", "");
                $("#clsFilterLinks").css("position", "");
                $fixedHeader.hide();
            }
            
            //$("#clsFilterLinks").css("top", offset + 'px');
        });

        $("[data-toggle='tooltip']").tooltip();
        $(".clsControlHeight").tooltip();
        //$("[data-toggle='tooltip']").on('click', function () {
        //    $("[data-toggle='tooltip']").removeClass("in");
        //});

        //$('body').tooltip({
        //    selector: "[data-toggle='tooltip']",
        //    trigger: 'hover'
        //});

        setTimeout(function () { setWidth(); }, 500);
        if ('<%=m_LoadFilterID%>' != "") {
            $("#" + '<%=m_LoadFilterID%>').click();
        }
    });
    /**********************************End of Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
</script>

<script>
    $('.btn-toggle').click(function () {
        $(this).find('.btn').toggleClass('active');

        if ($(this).find('.btn-primary').length > 0) {
            $(this).find('.btn').toggleClass('btn-primary');
        }
        if ($(this).find('.btn-danger').length > 0) {
            $(this).find('.btn').toggleClass('btn-danger');
        }
        if ($(this).find('.btn-success').length > 0) {
            $(this).find('.btn').toggleClass('btn-success');
        }
        if ($(this).find('.btn-info').length > 0) {
            $(this).find('.btn').toggleClass('btn-info');
        }

        $(this).find('.btn').toggleClass('btn-default');

    });

    $('form').submit(function () {
        var radioValue = $("input[name='options']:checked").val();
        if (radioValue) {
            alert("You selected - " + radioValue);
        };
        return false;
    });
    /**********************************Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
    function AddNew_OnClick() {
        window.open("../../CRM/CRM_RequestDetail.aspx?Mode=NEW&PageNumber=1&Customer=&Employee=&RTVal=I&ParentTagID=0&FromList=1&FromCL=1&OnBehalfOf=SELF", "_requestdetail", "resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700");
    }

    function Export_OnClick(sFormat) {
        var title = 'e-Dashboard';

        if ('<%=m_strLoginType%>' == 'C') {
            title = 'Submitted Requests';
        }
        else {
            title = 'e-Dashboard';
        }
        //window.open("../CRM/CRM_ShowReport.aspx?Mode=EXPORT&Format=" + sFormat + "&Title=" + title + "", "_blank", "resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700");
        var objForm = document.getElementById("frmRequestListNew");

        objForm.target = "_blank";
        // objForm.action = "../../CRM/CRM_ShowReport.aspx?Mode=EXPORT&Format=" + sFormat + "&Title=" + title;
        objForm.action = "../../HelpdeskEnhancement/RequestList/CRM_ShowReport_Helpdesk.aspx?Mode=EXPORT&Format=" + sFormat + "&Title=" + title;
        objForm.submit();
    }

    //Commented and Added by Poonam S on 11-jan-19 fro masterCard Issue Id-15782
    var requestDate="";
    //function Flag_OnClick(RequestID) {
    function Flag_OnClick(RequestID,submittedDate) {
        requestDate=submittedDate.substring(0,10);
        //End of Added by Poonam S on 11-jan-19 fro masterCard Issue Id-15782

        var strResult, data;

        $("#hdnRequestID").val(RequestID);

        $("#spnRequestID").html(RequestID);

        data = JSON.stringify({ RequestID: RequestID });
        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetFlagDetails", data, false);

        if (strResult.d != "") {
            var arrResult = strResult.d.split("#$#");

            $("#btnClearFlag").show();

            if (arrResult[0] == '0') {
                $("#btnClearFlag").hide();
            }
            $("#hdnFlagUniqueID").val(arrResult[0]);

            if (String(arrResult[1]).toLowerCase() == "true") {
                $("#chkComplete").prop("checked", true);
            }
            else {
                $("#chkComplete").prop("checked", false);
            }

            $("#dtDueDate").val(arrResult[2]);
            $("#cbFlagTo").val(arrResult[3]);

            $(".que").text(arrResult[4]);
        }

        document.getElementById('id02').style.display = 'block'

        //Added by Ankush T on 18 DEC 2018 for due date issue fixing
        DisableDateControl();
        if(document.getElementById('chkComplete').checked==true) {
            $("#chkComplete").prop('disabled', true);
        }
        else{
            $("#chkComplete").prop('disabled', false);

        }
        //End of Added by Ankush T on 18 DEC 2018 for due date issue fixing
    }

    //Added by Ankush T on 18 DEC 2018 for due date issue fixing
    function DisableDateControl()
    {
        //debugger;
        //document.getElementById('dtDueDate').disabled;
        if(document.getElementById('chkComplete').checked==true) {
            $("#dtDueDate").prop('disabled', true);
            $("#clscalender").attr("onclick", "").unbind("click");
            $('#clscalender').prop('disabled', true);
            $('#clscalender').css('cursor', 'no-drop');
        }
        else{
            $("#chkComplete").prop('disabled', false);
            $("#dtDueDate").prop('disabled', false);
            $('#clscalender').prop('disabled', false);
            $("#clscalender").attr("onclick", "$('#dtDueDate').datepicker();$('#dtDueDate').datepicker('show');");
            $('#clscalender').css('cursor', 'pointer');

        }

    }
    //End of Added by Ankush T on 18 DEC 2018 for due date issue fixing

    //function isDate(txtDate)
    //{
    //    var currVal = txtDate;
    //    if(currVal == '')
    //        return false;
  
    //    //Declare Regex  
    //    var rxDatePattern = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/; 
    //    var dtArray = currVal.match(rxDatePattern); // is format OK?

    //    if (dtArray == null)
    //        return false;
 
    //    //Checks for mm/dd/yyyy format.
    //    dtMonth = dtArray[1];
    //    dtDay= dtArray[3];
    //    dtYear = dtArray[5];

    //    if (dtMonth < 1 || dtMonth > 12)
    //        return false;
    //    else if (dtDay < 1 || dtDay> 31)
    //        return false;
    //    else if ((dtMonth==4 || dtMonth==6 || dtMonth==9 || dtMonth==11) && dtDay ==31)
    //        return false;
    //    else if (dtMonth == 2)
    //    {
    //        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
    //        if (dtDay> 29 || (dtDay ==29 && !isleap))
    //            return false;
    //    }
    //    return true;
    //}

    //Added by Poonam S on 11-jan-19 fro masterCard Issue Id-15782
    function CompairDates(obj1, Obj2) {
        //debugger;
        var date1 = new Date(obj1);
        var date2 = new Date(Obj2);
        if (date1 > date2) {
            return 1;
        }
        else if (date1 < date2) {
            return -1;
        }
        else {
            return 0;
        }
    }
    //End of Added by Poonam S on 11-jan-19 fro masterCard Issue Id-15782


    function SaveFlag() {
        var strResult, data, RequestID;
        var FlagParameters = {};
        var objFlagTo, objDueDate, objCheckComplete;

        objFlagTo = $("#cbFlagTo");
        objDueDate = $("#dtDueDate");
        objCheckComplete = $("#chkComplete");
        RequestID = $("#hdnRequestID").val();

        FlagParameters.RequestID = RequestID;
        FlagParameters.FlagTo = objFlagTo.val();
        FlagParameters.DueDate = objDueDate.val();
        FlagParameters.ProjectID = "0";
        var CheckValue = 0;
        var blnValidDueDate =  isDate($("#dtDueDate"));
        if ($("#dtDueDate").val() == "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select due date.', 'error');
            return;
        }
        else if(blnValidDueDate == false)
        {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please enter due date in Valid format.', 'error');
            return;
        }
            //Added By Aniruddh Gujar on 21-Dec-2017 Purpose::To validate the Due date
        else{

            //Commented and Added by Ankush T on 18 DEC 2018 for due date issue fixing

            //var url = 'CRM_RequestListNew.aspx/CheckDueDate';
            //var data = JSON.stringify({  DueDate: $("#dtDueDate").val() });
	           
            //$.ajax({
            //    type: "POST",
            //    url: url,
            //    data: data,
            //    dataType: "json",
            //    contentType: "application/json",
            //    async: false,
            //    timeout: 180000,
            //    success: function (result) {
            //        if (result.d == 1)
            //        {
            //            CheckValue = 1;
            //        }
            //    },
            //});
            //if (CheckValue== 1)
            //{
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Due Date should not be less than Todays Date.', 'error');
            //    return;
            //}	

            if(document.getElementById('chkComplete').checked==false) {
                var url = 'CRM_RequestListNew.aspx/CheckDueDate';
                var data = JSON.stringify({  DueDate: $("#dtDueDate").val() });
	           
                $.ajax({
                    type: "POST",
                    url: url,
                    data: data,
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    timeout: 180000,
                    success: function (result) {
                        if (result.d == 1)
                        {
                            CheckValue = 1;
                        }
                    },
                });
                if (CheckValue== 1)
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Due Date should not be less than Todays Date.', 'error');
                    return;
                }
            }
            //End of Added by Ankush T on 18 DEC 2018 for due date issue fixing

                //Added by Poonam S on 11 Jan 2019 for due date issue fixing
            else
            {
                var duedt=$("#dtDueDate").val();
                // arrreqDate=requestDate.split("-");
                //var reqstDate=arrreqDate[1]+"/"+arrreqDate[0]+"/"+arrreqDate[2];
                if(CompairDates(duedt,requestDate)== -1){
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Due Date should not be less than Requested Date.', 'error');
                    //arrreqDate="";
                    //reqstDate="";
                    return;
                }                   
            }
            //End of Added by Poonam S on 11 Jan 2019 for due date issue fixing
        }
        //End of Added By Aniruddh Gujar on 21-Dec-2017 Purpose::To validate the Due date
        
        //Commented & Added by Sagar N on 12-March-2019 Purpose: Issue ID = 15782

        //if (objCheckComplete.is(':checked'))
        //    FlagParameters.IsComplete = "1";
        //else
        //    FlagParameters.IsComplete = "0";

        if (objCheckComplete.is(':checked')) {
            FlagParameters.IsComplete = "1";

            var dueDate = new Date(objDueDate.val()).setHours(0, 0, 0, 0); 
            var todayDate = new Date().setHours(0, 0, 0, 0);

            if (dueDate < todayDate) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Due Date should not be less than Todays Date.', 'error');
                return;
            }
        }
        else {
            FlagParameters.IsComplete = "0";
        }
        //End of Commented & Added by Sagar N on 12-March-2019 Purpose: Issue ID = 15782

        
        data = JSON.stringify({ FlagParameters: FlagParameters });

        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/SaveRequestFlag", data, false);

        if (strResult.d == "1") {
            document.getElementById('id02').style.display = 'none';

            var PageNumber = document.getElementById("hdnCurrentPage").value;
            var strMode = $("#hdnMode").val();
            //Added by Chetan M on 16 Feb 2021 for refresh the flagged request count
            $(".btnRefresh").trigger("click"); 
            //End of Added by Chetan M on 16 Feb 2021 for refresh the flagged request count
            RefreshGrid(strMode, PageNumber, "");
        }
    }

    function ClearFlag() {
        var strResult, data, RequestID, FlagUniqueID;

        RequestID = $("#hdnRequestID").val();
        FlagUniqueID = $("#hdnFlagUniqueID").val();

        data = JSON.stringify({ FlagUniqueID: FlagUniqueID });

        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/ClearRequestFlag", data, false);

        if (strResult.d == "1") {
            document.getElementById('id02').style.display = 'none';

            var PageNumber = document.getElementById("hdnCurrentPage").value;
            var strMode = $("#hdnMode").val();

            RefreshGrid(strMode, PageNumber, "");
        }
    }

    function Page_OnClick(PageNumber) {
        var strMode = $("#hdnMode").val();

        if (FilterApplyWithoutSaveFlag == true) {
            RefreshGrid(strMode, PageNumber, "ApplyWithoutSave");
        }
        else {
            RefreshGrid(strMode, PageNumber, "");
        }
    }
    function PreviousePage(PageNumber) {

        if (PageNumber < 1) {
            //alert("You are on the First page");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('You are on the First page!', 'error');
        }
        else {
            $("#hdnCurrentPage").val(PageNumber);
            Page_OnClick(PageNumber);
        }

        //Added By Dipali V On 1st March 2021 For Scroll issue
         // $(window).on("load resize scroll", function (e) {
            resizeSection(this);
           
        //}); //End Added script by pradip on 24-2-2021
        
        //End of Added By Dipali V On 1st March 2021 For Scroll issue

    }
    function NextPage(PageNumber) {

        var TotalNoOfPages = $("#hidNoOfPages").val();

        if (PageNumber > TotalNoOfPages) {
            //alert("You are on the last page");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('You are on the last page!', 'error');
        }
        else {
            $("#hdnCurrentPage").val(PageNumber);
            Page_OnClick(PageNumber);
        }

       //Added By Dipali V On 1st March 2021 For Scroll issue
         // $(window).on("load resize scroll", function (e) {
            resizeSection(this);
           
        //}); //End Added script by pradip on 24-2-2021
        
        //End of Added By Dipali V On 1st March 2021 For Scroll issue

    }
    function FirstPage(PageNumber) {
        var TotalNoOfPages = $("#hidNoOfPages").val();


        if (PageNumber == $("#hdnCurrentPage").val()) {
            //alert("You are on the First page");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('You are on the First page!', 'error');
        }
        else {
            $("#hdnCurrentPage").val(PageNumber);
            Page_OnClick(PageNumber);
        }
         //Added By Dipali V On 1st March 2021 For Scroll issue
         // $(window).on("load resize scroll", function (e) {
            resizeSection(this);
           
        //}); //End Added script by pradip on 24-2-2021
        
        //End of Added By Dipali V On 1st March 2021 For Scroll issue

    }
    function LastPage(PageNumber) {
        var TotalNoOfPages = $("#hidNoOfPages").val();

        if (TotalNoOfPages == $("#hdnCurrentPage").val()) {
            //alert("You are on the last page");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('You are on the last page!', 'error');
        }
        else {
            $("#hdnCurrentPage").val(PageNumber);
            Page_OnClick(PageNumber);
        }

        //Added By Dipali V On 1st March 2021 For Scroll issue
         // $(window).on("load resize scroll", function (e) {
            resizeSection(this);
           
        //}); //End Added script by pradip on 24-2-2021
        
        //End of Added By Dipali V On 1st March 2021 For Scroll issue

    }

    function cboFilter_OnChange() {

        $('div.addedrow').remove();
        addorButton = false;
        $("#LoadFilterQueryText").html("");
        $("#hdnLoadFilterQueryText").val("");
        $("#AppliedFilterDiv").hide();
        //Added By Bharat T for Clear the applied load filter filter			       
        $(".btnLoadFilter").text("Load Filter");

        $("#hdnLoadFilterID").val("");

        $("#hdnFilterQuery").val("");


        $(".clsHighlightBorder").removeClass("clsHighlightBorder");
        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();
        IsDefaultFilter = "False";

        if (document.getElementById("cboDateFilter") != null) {
            document.getElementById("cboDateFilter").value = "0";
        }

        RefreshGrid(strMode, PageNumber, "");
    }

    function cboDateFilter_OnChange() {
        $(".clsHighlightBorder").removeClass("clsHighlightBorder");
        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();
        IsDefaultFilter = "False";

        if (document.getElementById("cboFilter") != null) {
            document.getElementById("cboFilter").value = "0";
        }

        RefreshGrid(strMode, PageNumber, "");
    }


    function AssignIssue_OnClick(QueryID, strToken,PreIssueID)
    {
        window.open("../../NewAPI/Issues/IB_AssignIssue.aspx?QueryID=" + QueryID + "&PreIssueID=" + PreIssueID +"&PKToken=" + strToken, "_Assignment", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=800,height=600");

    } 



    var FeedBackQueryID;
    function SaveActivity_OnClick(QueryID) {
        //var ActivityID = GetObjectReference('frmDashboard', 'hidActivityID' + QueryID).value;
        //debugger;
        var ActivityID;
        var Time;
        var TotalTodaysTime;
        FeedBackQueryID = QueryID;
        
        
        
        
        
        if (GetObjectReference('frmRequestListNew', 'txtActivity' + QueryID) != null) {
            ActivityID = GetObjectReference('frmRequestListNew', 'txtActivity' + QueryID).value;
            Time = GetObjectReference('frmRequestListNew', 'txtTime' + QueryID).value;
            TotalTodaysTime = GetObjectReference('frmRequestListNew', 'TimeSpent' + QueryID).getAttribute('TodaysTotalTimeSpent');
        }
        else {
            ActivityID = "0";
            Time = "0";
            TotalTodaysTime = "0";
        }

        // var StatusID = GetObjectReference('frmDashboard', 'hidStatus' + QueryID);
        var StatusID = GetObjectReference('frmRequestListNew', 'txtStatus' + QueryID);
        var objtxtStatus = GetObjectReference('frmRequestListNew', 'txtStatus' + QueryID);
        var OldStatusID = GetObjectReference('frmRequestList', 'hidStatus' + QueryID);

        if (StatusID != null && OldStatusID != null) {
            if (StatusID.disabled == false) {
                 if (OldStatusID.value != StatusID.value && StatusID.value == '2') {
                document.getElementById("Feedback").style.display = "block";
                return;
            }
        }
    }

        var objTime;

        if (parseFloat(Time) < 0 && Time != '') {
            //alert('Please enter positive number');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please enter positive number.', 'error');

            setFocus(GetObjectReference('frmRequestListNew', 'txtTime' + QueryID));
            return;
        }
        if (isNumeric(Time) == false && Time != '') {
            //alert('Please enter numeric value');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please enter numeric value.', 'error');
            setFocus(GetObjectReference('frmRequestListNew', 'txtTime' + QueryID));
            return;
        }
        if (Time != '' && ActivityID == '') {
            //alert('Please select the Activity');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select the Activity.', 'error');
            setFocus(GetObjectReference('frmRequestListNew', 'hidActivityID' + QueryID));
            return;
        }
        if (Time == '' && ActivityID != '') {
            // alert('Please enter Time');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please enter Time.', 'error');
            setFocus(GetObjectReference('frmRequestListNew', 'txtTime' + QueryID));
            return;
        }
        //Added By Usha Pandit On 10.11.2020 For validation to check if Activity is selected or not
        if (GetObjectReference('frmRequestListNew', 'txtActivity' + QueryID) != null) {
            if (GetObjectReference('frmRequestListNew', 'txtActivity' + QueryID).value == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please select the activity.', 'error');
                setFocus(GetObjectReference('frmRequestListNew', 'txtActivity' + QueryID));
                return;
            }
        }   
        //End Of Added By Usha Pandit On 10.11.2020 For validation to check if Activity is selected or not
        if (parseFloat(TotalTodaysTime) + parseFloat(Time) > 24 * 60) {
            //alert('Total minutes in one day should be less than equal to 1440 minutes. \n You can add more ' + (1440 - parseFloat(TotalTodaysTime)) + ' minutes for today.');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Total minutes in one day should be less than equal to 1440 minutes. \n You can add more ' + (1440 - parseFloat(TotalTodaysTime)) + ' minutes for today.', 'error');

            setFocus(GetObjectReference('frmRequestListNew', 'txtTime' + QueryID));
            return;
        }

        //Modified by Nikhil A for removing the dependency on th CRM folder CRM_XMLHttp page moved to RequestList
        //var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID=" + StatusID.value + "&Time=" + Time + "&ActivityID=" + ActivityID + "&QueryID=" + QueryID;
        var url = "CRM_XMLHttp_Helpdesk.aspx?FromXML=1&Action=SaveActivity&statusID=" + StatusID.value + "&Time=" + Time + "&ActivityID=" + ActivityID + "&QueryID=" + QueryID;

        loadXMLDoc(url, '')
        if (Time == '')
            objTime = 0;
        else
            objTime = Time;

        if (GetObjectReference('frmRequestListNew', 'TimeSpent' + QueryID) != null)
            GetObjectReference('frmRequestListNew', 'TimeSpent' + QueryID).setAttribute('TodaysTotalTimeSpent', parseFloat(TotalTodaysTime) + parseFloat(objTime));
            window.location.href=window.location.href;

   }

    function SubmitOK_Onclick() {
        var objFeedBack = GetObjectReference('frmRequestListNew', 'cboFeedback');
        var objFeedBackComments = GetObjectReference('frmRequestListNew', 'txtFeedbackComments');
        var objFeedBackDiv = GetObjectReference('frmRequestListNew', 'cboFeedbackDiv');
        var objFeedBackCommentsDiv = GetObjectReference('frmRequestListNew', 'txtSubmitCommentsDiv');
        var objDiv = GetObjectReference('frmRequestListNew', 'DivFeedBack');

        if ($("#firstrating").hasClass('checked') || $("#Secondrating").hasClass('checked') || $("#Thirdrating").hasClass('checked') || $("#Foruthrating").hasClass('checked') || $("#Fifthrating").hasClass('checked')) {

        }
        else {
            $("#SpnRatingMsg").html("Please Rate Us!!!!");
            $("#SpnRatingMsg").css("color", "red");
            return;

        }

        if (Trim(objFeedBackCommentsDiv.value) == '') {
            //alert('Please Enter Feedback comments');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please Enter Feedback comments.', 'error');
            return;
        }

        //objDiv.style.display = 'none';
        //document.getElementById('fillDiv').style.display = "none";	      

        SaveData(FeedBackQueryID, '1');


        $("#firstrating").removeClass('checked');
        $("#Secondrating").removeClass('checked');
        $("#Thirdrating").removeClass('checked');
        $("#Foruthrating").removeClass('checked');
        $("#txtSubmitCommentsDiv").val("");
        $("#SpnRatingMsg").html("");


        document.getElementById('Feedback').style.display = 'none'

    }


    function SaveData(QueryID, SaveFeedBack) {

        var StatusID = GetObjectReference('frmRequestListNew', 'txtStatus' + QueryID);
        if (SaveFeedBack == '1') {
            var objFeedBackDiv = GetObjectReference('frmRequestListNew', 'cboFeedbackDiv');
            var objFeedBackCommentsDiv = GetObjectReference('frmRequestListNew', 'txtSubmitCommentsDiv');
        }


        if (GetObjectReference('frmRequestListNew', 'txtActivity' + QueryID)) {
            var ActivityID = GetObjectReference('frmRequestListNew', 'txtActivity' + QueryID).value;
            var Time = GetObjectReference('frmRequestListNew', 'txtTime' + QueryID).value;
            var TotalTodaysTime = GetObjectReference('frmRequestListNew', 'TimeSpent' + QueryID).getAttribute('TodaysTotalTimeSpent');

            if (SaveFeedBack == 1) {
                //Modified by Nikhil A for removing the dependency on th CRM folder CRM_XMLHttp page moved to RequestList
                //var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&FeedBackID=" + globalRating + "&FeedBackComment=" + objFeedBackCommentsDiv.value + "&statusID=" + StatusID.value + "&Time=" + Time + "&ActivityID=" + ActivityID + "&QueryID=" + QueryID;
                var url = "CRM_XMLHttp_Helpdesk.aspx?FromXML=1&Action=SaveActivity&FeedBackID=" + globalRating + "&FeedBackComment=" + objFeedBackCommentsDiv.value + "&statusID=" + StatusID.value + "&Time=" + Time + "&ActivityID=" + ActivityID + "&QueryID=" + QueryID;

            }
            else {
                //Modified by Nikhil A for removing the dependency on th CRM folder CRM_XMLHttp page moved to RequestList
                //var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID=" + StatusID.value + "&Time=" + Time + "&ActivityID=" + ActivityID + "&QueryID=" + QueryID;
                var url = "CRM_XMLHttp_Helpdesk.aspx?FromXML=1&Action=SaveActivity&statusID=" + StatusID.value + "&Time=" + Time + "&ActivityID=" + ActivityID + "&QueryID=" + QueryID;

            }
            if (Time == '')
                objTime = 0;
            else
                objTime = Time;
            GetObjectReference('frmRequestListNew', 'TimeSpent' + QueryID).setAttribute('TodaysTotalTimeSpent', parseFloat(TotalTodaysTime) + parseFloat(objTime));
        }
        else {
            if (SaveFeedBack == 1) {
                //Modified by Nikhil A for removing the dependency on th CRM folder CRM_XMLHttp page moved to RequestList
                //var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&FeedBackID=" + globalRating + "&FeedBackComment=" + objFeedBackCommentsDiv.value + "&statusID=" + StatusID.value + "&QueryID=" + QueryID;
                var url = "CRM_XMLHttp_Helpdesk.aspx?FromXML=1&Action=SaveActivity&FeedBackID=" + globalRating + "&FeedBackComment=" + objFeedBackCommentsDiv.value + "&statusID=" + StatusID.value + "&QueryID=" + QueryID;

            }
            else {
                //Modified by Nikhil A for removing the dependency on th CRM folder CRM_XMLHttp page moved to RequestList
                //var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID=" + StatusID.value + "&QueryID=" + QueryID;
                var url = "CRM_XMLHttp_Helpdesk.aspx?FromXML=1&Action=SaveActivity&statusID=" + StatusID.value + "&QueryID=" + QueryID;
            }
        }
        loadXMLDoc(url, '')
        
    }

    function AssignToMe_onClick(QueryID) {
       // debugger;
        //Modified by Nikhil A for removing the dependency on th CRM folder CRM_XMLHttp page moved to RequestList
        //var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=Assign&QueryID=" + QueryID;
        var url = "CRM_XMLHttp_Helpdesk.aspx?FromXML=1&Action=Assign&QueryID=" + QueryID;
        //window.location.href = url;
        loadXMLDoc(url, QueryID)
       

    }
    function loadXMLDoc(url, reqQuery) {
       // debugger
        if (isIE() == 'IE') {
            xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
            if (xmlhttp) {
                xmlhttp.onreadystatechange = state_Change;
                xmlhttp.open('POST', url, false);
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(reqQuery);
            }
        }
        else if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = state_Change;
            if (ns) {
                xmlhttp.open('GET', url, true);
                xmlhttp.send(null);
            }
            else {
                xmlhttp.open('POST', url, false);
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(reqQuery);
            }
        }

         window.location.href = "CRM_RequestListNew.aspx?Mode=SR";
    }

    function state_Change() {

        var FromWhere;
        var QueryID;
        if (parseInt(xmlhttp.readyState) == 4) {
            if (xmlhttp.status == 200) {

                var result = xmlhttp.responseText.split("$_$");
                QueryID = result[1];

                if (result[0] == 'SaveActivity') {
                    var objtxtSavingLable = GetObjectReference('frmRequestListNew', 'txtSavingLable' + QueryID);

                    objtxtSavingLable.style.display = '';

                    var objTotalTime = GetObjectReference('frmRequestListNew', 'TotalTime' + QueryID);

                    if (GetObjectReference('frmRequestListNew', 'TotalTime' + QueryID) != null)
                        var TotalTime = GetObjectReference('frmRequestListNew', 'TotalTime' + QueryID).getAttribute('TotalTime');
                    else
                        var TotalTime = 0;

                    var objActivity = GetObjectReference('frmRequestListNew', 'txtActivity' + QueryID);

                    var objActivityID = GetObjectReference('frmRequestListNew', 'hidActivityID' + QueryID);

                    var objTime = GetObjectReference('frmRequestListNew', 'txtTime' + QueryID);

                    var objStatus = GetObjectReference('frmRequestListNew', 'Status' + QueryID);
                    var objNewStatus = GetObjectReference('frmRequestListNew', 'txtStatus' + QueryID);


                    //To Change status in Grid column 
                    if (objStatus)
                        // objStatus.innerHTML = objNewStatus.value
                        objStatus.innerHTML = objNewStatus.options[objNewStatus.selectedIndex].innerText;

                    var objtxtTime = GetObjectReference('frmRequestListNew', 'txtTime' + QueryID);
                    var objtxtActivity = GetObjectReference('frmRequestListNew', 'txtActivity' + QueryID);
                    var objimgActivity = GetObjectReference('frmRequestListNew', 'imgActivity' + QueryID);
                    var objbtnSave = GetObjectReference('frmRequestListNew', 'btnSave' + QueryID);

                    var objtxtStatus = GetObjectReference('frmRequestListNew', 'txtStatus' + QueryID);
                    var objhidtxtStatus = GetObjectReference('frmRequestListNew', 'hidStatus' + QueryID);


                    if (objhidtxtStatus.value != 2) {

                        if (objtxtActivity != null) {
                            if (objtxtTime != null) {
                                objtxtTime.disabled = false;
                                objtxtActivity.disabled = false;
                            }
                        }

                        //objimgActivity.onClick = "SearchActivity(" + QueryID + ",event)";
                        objbtnSave.disabled = false;
                    }
                    else {
                        if (objtxtTime != null) {
                            objtxtTime.disabled = true;
                            objtxtActivity.disabled = true;
                        }
                        //objimgActivity.onClick = "";
                        objbtnSave.disabled = true;
                    }

                    var NewTotalTime = TotalTime; //TotalTime.substring(start+1,stop);

                    if (objActivity != null) {
                        objActivity.value = '';
                        objActivityID.value = '';
                    }
                    if (objTime != null) {
                        objTime.value = '';

                        if (objTime.value != '') {
                            var ConvertedTime = parseFloat(NewTotalTime) + parseFloat((parseFloat(objTime.value) / 60).toFixed(2));

                            objTotalTime.innerHTML = '<U><B><A onClick=ShowDetailActivity(event,' + QueryID + ') >Total Time Spent </A></U>&nbsp;:&nbsp;' + ConvertedTime + '&nbsp;Hrs</B>&nbsp;&nbsp;'
                            GetObjectReference('frmRequestListNew', 'TotalTime' + QueryID).setAttribute('TotalTime', ConvertedTime);

                        }



                        var code;
                        code = "var objtxtSavingLable = GetObjectReference('frmRequestListNew','txtSavingLable" + QueryID + "'); objtxtSavingLable.style.display = 'none';"
                        setTimeout(code, 400);


                        setFocus(objTime);
                    }
                    else {

                        var code;
                        code = "var objtxtSavingLable = GetObjectReference('frmRequestListNew','txtSavingLable" + QueryID + "'); objtxtSavingLable.style.display = 'none';"
                        setTimeout(code, 400);

                    }

                }
                else if (result[0] == 'Assign') {
                    var objAssignTo = GetObjectReference('', 'AssignTo' + QueryID);

                    objAssignTo.innerHTML = '<B><FONT color=red>Assigned To me</FONT></B>';
                }

                else if (result[0] == '') {
                    document.getElementById('divATT').innerHTML = '';
                    document.getElementById('divATT').style.display = 'none';
                    displayDiv = false;

                }
                    //Added by GaneshD on 31 Aug 2009 for PMLifeLine IssueID-32677
                else if (result[0] == 'NotValidStatus') {
                    displayDiv = false;
                    //alert(result[2]);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(result[2], 'error');
                    return;
                }
                    // End of addition by GaneshD

                else {
                    if (result[1] != '') {
                        if (result[1] == 'ShowView') {
                            var objdivTblX = GetObjectReference('frmRequestListNew', 'divTblX');
                            objdivTblX.innerHTML = result[0];
                            objdivTblX.style.left = mousePosition.x;
                            objdivTblX.style.top = mousePosition.y;
                            //objdivTblX.style.width=200;     
                            objdivTblX.style.display = "";
                            var objdivTblXX = GetObjectReference('frmRequestListNew', 'divTblXX');
                            var objTblXX = GetObjectReference('frmRequestListNew', 'TblXX');

                            var objchkAll = GetObjectReference('frmRequestListNew', 'chkAll');
                            var objchkField = GetObjectReference('frmRequestListNew', 'chkField', true);

                            var Ischeck;

                            for (i = 0; i < objchkField.length; i++) {
                                if (objchkField[i].checked == true) {
                                    Ischeck = true;
                                }
                                else {
                                    Ischeck = false;
                                    break;
                                }
                            }
                            if (Ischeck == true) {
                                objchkAll.checked = true
                            }
                        }
                        else if (result[1] == 'ShowStatistic') {
                            var objdivActivityDtls = document.getElementById('divStatistics')
                            objdivActivityDtls.innerHTML = result[0];
                        }
                        else {
                            document.getElementById('divATT').innerHTML = result[0];
                            document.getElementById('divATT').style.display = "";
                            displayDiv = true;
                        }
                    }
                    else {   //alert(result[0]);

                        var objdivActivityDtls = document.getElementById('divActivityDtls')
                        objdivActivityDtls.innerHTML = result[0];

                    }
                }



            }
        }

    }

    function ShowAttachment(QueryID) {
        var strResult, data;

        data = JSON.stringify({ QueryID: QueryID });
        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GetAttachmentGrid", data, false);

        if (strResult.d != '') {
            $("#btnDownloadZip").attr("QueryID", QueryID);
            $("#attachmentMainDiv").html(strResult.d);

            $("#lblRequestIDAttachments").html("Request ID : " + QueryID);
            document.getElementById('id03').style.display = 'block';

            $("#divAttachment table").addClass("table table-bordered");
            $("#divAttachment table thead th").css("white-space", "nowrap");
        }
    }

    //Download Attachment File
    function Document_OnClick_For_CRM(strSystemFileName, strOriginalFileName) {
        //Note : in Attachment.aspx which gets called while uploading a file from Helpdesk Page the FolderNames are hard coded in PerformAction method. Hence Fromwhere is Hard coded	        
        var strTemp = '../../General/ViewAttachment.aspx?FromWhere=CRM&FileName=' + strOriginalFileName + '&SystemFileName=' + strSystemFileName;
        window.open(strTemp);
    }

    //Download Zip File
    function DownloadZip(object) {
        var strResult, data;
        var QueryID = $(object).attr('QueryID');

        data = JSON.stringify({ QueryID: QueryID });
        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/GenerateZipFile", data, false);

        if (strResult.d != '') {
            var strTemp = '../../General/ViewAttachment.aspx?FromWhere=CRM/ZIPFile&FileName=Request_' + QueryID + '.zip&SystemFileName=Request_' + QueryID + '.zip';
            window.open(strTemp);
        }
    }

    function ApproveRejectClick() {

        if ($("input[name=chkSelect]:checked").length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least one request!', 'error');
        }
        else {

            var strResult, data;
            var strQueryIDList = '';

            strQueryIDList = $("input[name=chkSelect]:checked").map(function () {
                return this.value;
            }).get().join(",");

            //data = JSON.stringify({ strQueryIDList: strQueryIDList, Flag : "APPROVEREJECT" });
            //strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/ValidateSelectedRequestsIDs", data, false);

            data = JSON.stringify({ strQueryIDList: strQueryIDList, Flag: "APPROVEREJECT" });
            strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/ValidateRequestsAndGetDataForApproval", data, false);


            if (strResult.d != '') {

                var arrResuldData = strResult.d.split("#$$#");

                //alert(arrResuldData[1])
                //Code For Grid of valid request Ids for approval
                $("#tblApprovalRequests").remove();

                if (arrResuldData[1] != "") {
                    // CREATE DYNAMIC TABLE.
                    var table = document.createElement('table');

                    // SET THE TABLE ID. 
                    // WE WOULD NEED THE ID TO TRAVERSE AND EXTRACT DATA FROM THE TABLE.
                    table.setAttribute('id', 'tblApprovalRequests');
                    table.setAttribute('border', '0');
                    //table.classList = "table table-condensed";
                    table.setAttribute('class', 'table table-condensed');

                    //var arrHead = new Array();
                    //arrHead = ['Select','Request ID', 'Subject'];

                    //var header = table.createTHead();
                    //header.classList = "clsTRColumnHeader";
                    //var tr = header.insertRow(-1);


                    //for (var h = 0; h < arrHead.length; h++) {
                    //    var th = document.createElement('th');              // TABLE HEADER.
                    //    th.innerHTML = arrHead[h];

                    //    if (arrHead[h].trim() == "Subject")
                    //        th.style.textAlign = "Left";
                    //    else
                    //        th.style.textAlign = "center";

                    //    tr.appendChild(th);
                    //}
                    //alert("")

                    //var tbody = table.createTBody();
                    //alert("")

                    $.each(JSON.parse(arrResuldData[1]), function (id, object) {
                        tr = table.insertRow(-1);
                        var tdSubjectHtml;
                        var subjectLess, subjectMore;


                        var td = document.createElement('td');          // TABLE DEFINITION.
                        td = tr.insertCell(-1);
                        td.innerHTML = "<input type=checkbox id='chkApprovalIDs" + object["QueryID"] + "' name='chkApprovalIDs' value='" + object["QueryID"] + "' checked=true >";

                        td = document.createElement('td');          // TABLE DEFINITION.
                        td = tr.insertCell(-1);
                        td.innerHTML = object["QueryID"];

                        td = document.createElement('td');          // TABLE DEFINITION.
                        td = tr.insertCell(-1);
                        td.style.textAlign = "Left";
                        td.style.width = "300px";

                        if (object["Subject"].length > 60) {
                            subjectLess = object["Subject"].substring(0, 60);
                            subjectMore = object["Subject"].substring(61, object["Subject"].length);

                            tdSubjectHtml = "<div class='card'><div class='card-body'><input type='checkbox' class='read-more-state' id='post-" + id + "' />"
                            tdSubjectHtml += "<p class='read-more-wrap card-text'>" + subjectLess + "";
                            tdSubjectHtml += "<span class='read-more-target'>" + subjectMore + "</span></p>";
                            tdSubjectHtml += " <label for='post-" + id + "' class='read-more-trigger'></label></div></div>"
                        }
                        else {
                            subjectLess = object["Subject"];
                            subjectMore = "";

                            tdSubjectHtml = "<div class='card'><div class='card-body'><input type='checkbox' class='read-more-state' id='post-" + id + "' />"
                            tdSubjectHtml += "<p class='read-more-wrap card-text'>" + subjectLess + "";
                            tdSubjectHtml += "<span class='read-more-target'>" + subjectMore + "</span></p>";
                            tdSubjectHtml += " <label for='post-" + id + "' class=''></label></div></div>"
                        }

                        td.innerHTML = tdSubjectHtml;
                        //td.innerHTML = object["Subject"];


                    });


                    if (JSON.parse(arrResuldData[1]).length > 0) {
                        $("#divApproveRejectValidationMsg").html("");
                        $("#divApproveRejectValidationMsg").css({ 'text-align': 'initial', 'border': '0px' });

                        document.getElementById("divApproveRejectValidationMsg").appendChild(table);
                        $(".btnAcceptDeclineRequests").show();
                    }
                    else {
                        $("#divApproveRejectValidationMsg").html("You can not approve any of the selected requests!");
                        $("#divApproveRejectValidationMsg").css({ 'text-align': 'center', 'border': '1px solid #ddd' });
                        $(".btnAcceptDeclineRequests").hide();
                    }


                    $("#tblApprovalRequests tbody td").css("border", "none");
                }
                else {
                    $("#divApproveRejectValidationMsg").html("You can not approve any of the selected requests!");
                    $("#divApproveRejectValidationMsg").css({ 'text-align': 'center', 'border': '1px solid #ddd' });
                    $(".btnAcceptDeclineRequests").hide();
                }
                //End of Code For Grid of valid request Ids for approval


                var strMsg = 'Requests For Approval :';
                //var blnFlag = false;

                //var originalArray = strQueryIDList.split(",");
                //var arrResult = arrResuldData[0].split(",");

                //var strResultList = $.map(arrResult, function (n) {
                //    return n === "" ? null : n;
                //}).join(",");

                //var diff = $(originalArray).not(arrResult).get().join(",");

                //if (arrResuldData[0] != "") {
                //    blnFlag = true;
                //    strMsg += '- Following requests can not be approved/rejected as they are already approved/rejected/assigned/not belongs to you. <br />-  Request IDs : <span style="color:red;word-break:break-word;">' + strResultList + '</span><br />'
                //}

                //if (blnFlag == true) {
                //    strMsg += '<br />-  And Following requests will get approved/rejected.<br />- Request IDs :<span style="color:green;word-break:break-word;">' + diff + '</span><br /> '
                //}
                //else {
                //    strMsg += '<br />- Following requests will  get approved/rejected.<br />- Request IDs :<span style="color:green;word-break:break-word;">' + diff + '</span><br /> '
                //}	               

                ////if (blnFlag == true) {
                $("#divApproveRejectValidationMsg").css({ 'max-height': '260px', 'width': '100%', 'display': 'inline-block' });
                ////}



                $("#ApproveRejectValidationMsg").html(strMsg);
            }



            document.getElementById('id01').style.display = 'block';
        }
        document.getElementById("comment").value = "";
        document.getElementById("comment").style.setProperty("resize", "none");
        //$('#id01', window.parent.document).modal('show');
        //$('#id01').modal({
        //    appendTo: $(window.parent.document.forms[0].document).find('body'),
        //    overlayCss: { backgroundColor: "#333" }, // Optional overlay style
        //    overlayClose: true,
        //});

    }

    function Pickup_OnClick() {
        //if ($("input[name=chkSelect]:checked").length > 1) {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Only one request can be pickup at a time!', 'error');
        //    return;
        //}

        if ($("input[name=chkSelect]:checked").length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least one request!', 'error');
        }
        else {
            var strResult, data;
            var strQueryIDList = '';

            strQueryIDList = $("input[name=chkSelect]:checked").map(function () {
                return this.value;
            }).get().join(",");

            //data = JSON.stringify({ strQueryIDList: strQueryIDList, Flag : "PICKUP" });
            //strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/ValidateSelectedRequestsIDs", data, false);

            data = JSON.stringify({ strQueryIDList: strQueryIDList, Flag: "PICKUP" });
            strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/ValidateRequestsAndGetPickupData", data, false);

            if (strResult.d != '') {

                var arrResuldData = strResult.d.split("#$$#");

                //Code For Grid of valid request Ids for pickup
                $("#tblPickupRequests").remove();

                if (arrResuldData[1] != "") {
                    // CREATE DYNAMIC TABLE.
                    var table = document.createElement('table');

                    // SET THE TABLE ID. 
                    // WE WOULD NEED THE ID TO TRAVERSE AND EXTRACT DATA FROM THE TABLE.
                    table.setAttribute('id', 'tblPickupRequests');
                    table.setAttribute('border', '0');

                    table.setAttribute('class', 'table table-condensed');
                    //table.classList = "table table-condensed";

                    //var tbody = table.createTBody();
                    $.each(JSON.parse(arrResuldData[1]), function (id, object) {
                        tr = table.insertRow(-1);
                        var tdSubjectHtml;
                        var subjectLess, subjectMore;

                        var td = document.createElement('td');          // TABLE DEFINITION.
                        td = tr.insertCell(-1);
                        td.innerHTML = "<input type=checkbox id='chkPickupIDs" + object["QueryID"] + "' name='chkPickupIDs' value='" + object["QueryID"] + "' checked=true >";

                        td = document.createElement('td');          // TABLE DEFINITION.
                        td = tr.insertCell(-1);
                        td.innerHTML = object["QueryID"];

                        td = document.createElement('td');          // TABLE DEFINITION.
                        td = tr.insertCell(-1);
                        td.style.textAlign = "Left";
                        td.style.width = "300px";

                        if (object["Subject"].length > 60) {
                            subjectLess = object["Subject"].substring(0, 60);
                            subjectMore = object["Subject"].substring(61, object["Subject"].length);

                            tdSubjectHtml = "<div class='card'><div class='card-body'><input type='checkbox' class='read-more-state' id='post1-" + id + "' />"
                            tdSubjectHtml += "<p class='read-more-wrap card-text'>" + subjectLess + "";
                            tdSubjectHtml += "<span class='read-more-target'>" + subjectMore + "</span></p>";
                            tdSubjectHtml += " <label for='post1-" + id + "' class='read-more-trigger'></label></div></div>"
                        }
                        else {
                            subjectLess = object["Subject"];
                            subjectMore = "";

                            tdSubjectHtml = "<div class='card'><div class='card-body'><input type='checkbox' class='read-more-state' id='post1-" + id + "' />"
                            tdSubjectHtml += "<p class='read-more-wrap card-text'>" + subjectLess + "";
                            tdSubjectHtml += "<span class='read-more-target'>" + subjectMore + "</span></p>";
                            tdSubjectHtml += " <label for='post1-" + id + "' class=''></label></div></div>"
                        }

                        td.innerHTML = tdSubjectHtml;
                        //td.innerHTML = object["Subject"];


                    });

                    if (JSON.parse(arrResuldData[1]).length > 0) {
                        $("#divPickupLabelAndGrid").html("");
                        $("#divPickupLabelAndGrid").css({ 'text-align': 'initial', 'border': '0px' });
                        document.getElementById("divPickupLabelAndGrid").appendChild(table);
                        $(".btnAssignPickupRequest").show();
                    }
                    else {
                        $("#divPickupLabelAndGrid").html("You can not pickup any of the selected requests as they might require approval or they are already assigned!");
                        $("#divPickupLabelAndGrid").css({ 'text-align': 'center', 'border': '1px solid #ddd' });

                        $(".btnAssignPickupRequest").hide();
                    }

                    $("#tblPickupRequests tbody td").css("border", "none");
                }
                else {
                    $("#divPickupLabelAndGrid").html("You can not pickup any of the selected requests as they might require approval or they are already assigned!");
                    $("#divPickupLabelAndGrid").css({ 'text-align': 'center', 'border': '1px solid #ddd' });
                    $(".btnAssignPickupRequest").hide();
                }
                //End of Code For Grid of valid request Ids for pickup

                var originalArray = strQueryIDList.split(",");
                var arrResult = strResult.d.split(",");

                //var diff = $(originalArray).not(arrResult).get().join(",");


                //var strResultList = $.map(arrResult, function (n) {
                //    return n === "" ? null : n;
                //}).join(",");

                var strMsg = 'Requests For Pickup :';
                //var blnFlag = false;

                //if (strResult.d != "") {
                //    blnFlag = true;
                //    strMsg += '- Following requests can not be picked up as they are not approved yet/already assigned. <br />-  Request IDs : <span style="color:red;word-break:break-word;">' + strResultList + '</span><br />'
                //}

                //if (blnFlag == true) {
                //    strMsg += '<br />-  And Following requests will assigned to you.<br />- Request IDs :<span style="color:green;word-break:break-word;">' + diff + '</span><br /> '
                //}
                //else {
                //    strMsg += '<br />- Following requests will assigned to you.<br />- Request IDs :<span style="color:green;word-break:break-word;">' + diff + '</span><br /> '
                //}

                //strMsg += '<br />-  To proceed click Yes else click No.';
                $("#divPickupLabelAndGrid").css({ 'max-height': '278px', 'width': '100%', 'display': 'inline-block' });
                $("#pickupValidationMsg").html(strMsg);

            }
            else {
                //var strMsg = '';

                var strMsg = 'Requests For Pickup :';
                //var originalArray = strQueryIDList.split(",");
                //var diff = $(originalArray).get().join(",");

                $("#divPickupLabelAndGrid").html("You can not pickup any of the selected requests as they might require approval or they are already assigned!");

                //strMsg += '- Following requests will assigned to you.<br />- Request IDs :<span style="color:green;word-break:break-word;">' + diff + '</span><br />'
                //strMsg += '<br />- To proceed click Yes else click No.';
                $("#pickupValidationMsg").html(strMsg);
            }

            document.getElementById('id18').style.display = 'block';
        }
    }

    //Assign To Functionality
    function AssignRequestToSelf() {
        var strResult, data;
        var strQueryIDList = '';

        strQueryIDList = $("input[name=chkPickupIDs]:checked").map(function () {
            return this.value;
        }).get().join(",");


        if (strQueryIDList == "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('There is no request for pickup!', 'error');
            return;
        }
        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();

        data = JSON.stringify({ strQueryIDList: strQueryIDList });
        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/AssignToSelf", data, false);

        if (strResult.d == '') {
            $("input[name=chkPickupIDs]:checked").map(function () {
                var objAssignTo = GetObjectReference('', 'AssignTo' + this.value);

                objAssignTo.innerHTML = '<B><FONT color=red>Assigned To me</FONT></B>';

                document.getElementById('id18').style.display = 'none';
            });

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Request assigned successfully!', 'success');
            $("input[name=chkSelect]").prop('checked', false);
            //Added by Usha Pandit on 22.05.2019 for Refresh issue after Request Pickup for Assignment
            window.location.href = "CRM_RequestListNew.aspx?Mode=SR";
            //End of Added by Usha Pandit on 22.05.2019 for Refresh issue after Request Pickup for Assignment
        }
    }

    function AssignIssue_OnClick(QueryID, strToken, PreIssueID) {
        window.open("../../NewAPI/Issues/IB_AssignIssue.aspx?QueryID=" + QueryID + "&PreIssueID=" + PreIssueID + "&PKToken=" + strToken, "_Assignment", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=800,height=600");

    }


    function AssignToListClick(object) {
        $("#spnAssignToName").text(object.name);
        $("#hdnAssignToId").val(object.id);

        var strResult, data;
        var strQueryIDList = '';

        strQueryIDList = $("input[name=chkSelect]:checked").map(function () {
            return this.value;
        }).get().join(",");

        if ($("input[name=chkSelect]:checked").length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least one request!', 'error');
            return;
        }
        else if ($("input[name=chkSelect]:checked").length > 0) {
            strQueryIDList = $("input[name=chkSelect]:checked").map(function () {
                return this.value;
            }).get().join(",");

            data = JSON.stringify({ strQueryIDList: strQueryIDList, EmployeeID: object.id });
            strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/AssignToEmployee", data, false);

            if (strResult.d == '') {
                $("input[name=chkSelect]:checked").map(function () {
                    var objAssignTo = GetObjectReference('', 'AssignTo' + this.value);

                    objAssignTo.innerHTML = '<B><FONT color=red>Assigned To : ' + object.name + '</FONT></B>';

                    document.getElementById('id18').style.display = 'none';
                });

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Requests assigned successfully!', 'success');

            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('One or more requests are not approved, Please unselect invalid requests !', 'error');
                return;
            }
        }

        //$(".clsAssgnToSection").show();
        $(".clsAssgnToSection").css({ 'padding-left': '10px' });
        //Added by Nilesh Pingale on 17th Mar 2020 (Issue ID:23462)
        setTimeout(function () { //Added By Usha Pandit On 18.04.2020 For alert was getting disappear soon due to refresh
           $(".btnRefresh").trigger("click");
        }, 3000);
        //End of Added by Nilesh Pingale on 17th Mar 2020 for (Issue ID:23462) 
    }

    function Query_OnClick(queryid, HasAccess) {
        //debugger;
        if (HasAccess == "True") {
            HasAccess = "1";
        }
        else {
            HasAccess = 0;
        }

        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();
        var LoadFilterID = $("#hdnLoadFilterID").val();
        var strStatusFilterID = $("#cboFilter").val();
        var strDateFilterID = $("#cboDateFilter").val();
        //debugger;
        if ($('#divCustomField div').hasClass('.row')) {
            $('#divCustomField div').removeClass('row');
            console.log( $('#divCustomField div').removeClass('row'));
           
        }
        //  window.open("CRM_RequestDetailsNew.aspx?Mode=EDIT&FromWhere=DB&PageNumber=<%=m_intPageNumber%>&QueryID=" + queryid + "&QueryEditAccess=" + HasAccess, "_requestdetail", "resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700");
        window.location.href = "../Request/CRM_RequestDetailsNew.aspx?Mode=EDIT&FromWhere=DB&PageNumber=" + PageNumber + "&PageFlag=" + strMode + "&LoadFilterID=" + LoadFilterID + "&StatusFilterID=" + strStatusFilterID + "&DateFilterID=" + strDateFilterID + "&QueryID=" + queryid + "&QueryEditAccess=" + HasAccess;
        //debugger;
        if ($('#divCustomField div').hasClass('.row')) {
            $('#divCustomField div').removeClass('row');
            console.log( $('#divCustomField div').removeClass('row'));
           
        }

        $('[data-toggle="tooltip"]').tooltip();
    }


    function SetDefault_SavedFilter(FilterID) {
       // debugger;    
        var strResult, data;
        var dataParameter = {};
        dataParameter.FilterID = FilterID;
        dataParameter.FilterFlag = "DefaultFilter_RequestListNewPage";
        var arrPageFlag = ["DefaultSR", "All", "MR", "FR", "RFA", "RAR"];


        data = JSON.stringify({ dataParameter: dataParameter });
        strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/SetDefaultFilter", data, true);

        if (arrPageFlag.indexOf(FilterID) >= 0) {
            $("#hdnNewFilterID").val("");
            $("#PageList li a[Mode=" + FilterID + "]").click();

            $("#PageList li").removeClass("clsFilterDefault");
            $("ul.clsUserSavedFilter li").removeClass("clsFilterDefault");

            $("#PageList li a[Mode=" + FilterID + "]").parent().addClass("clsFilterDefault");
        }
        else {
            IsDefaultFilter = "True";

            $("#hdnNewFilterID").val(FilterID);

            $("ul.clsUserSavedFilter li a#savedID_" + FilterID).click();

            $("#PageList li").removeClass("clsFilterDefault");
            $("ul.clsUserSavedFilter li").removeClass("clsFilterDefault");

            $("ul.clsUserSavedFilter li a#savedID_" + FilterID).parent().addClass("clsFilterDefault");

        }
    }
    /**********************************End of Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/


    function ShowRequestorDetails(event, QueryID, RequestorType) {
        //   alert();
        var url = "CRM_RequestListNew.aspx/PlotRequestorDetails"
        data = JSON.stringify({ QueryID: QueryID, Requestor: RequestorType });
        var strResult = AJAXCallWithResult(url, data, false);
        if (strResult.d != "") {

            document.getElementById('divcontainer').innerHTML = ""
            document.getElementById('divcontainer').innerHTML = strResult.d;
            document.getElementById('divRequestor').style.display = "block";
        }

    }
    function ShowStatistics(event, QueryID, RequestorType) {
        //   var url = "CRM_XMLHttp.aspx?FromXML=1&Action=ShowStatistics&RequestorType=" + RequestorType + "&QueryID=" + QueryID;
        var url = "CRM_RequestListNew.aspx/PlotRequestorDetails"
        data = JSON.stringify({ QueryID: QueryID, RequestorType: RequestorType });
        var strResult = AJAXCallWithResult(url, data, false);
    }

    //Added By Vidya Jadhav ON 30 Oct 2017 For Import Functionality


    //function ShowImportDetails() {
    //    //   alert();
    //    var url = "CRM_RequestListNew.aspx/GetImportDetails"
    //    data = JSON.stringify({  });
    //    var strResult = AJAXCallWithResult(url, data, false);
    //    if (strResult.d != "") {

    //        document.getElementById('idDivExcelDetails').innerHTML = ""
    //        document.getElementById('idDivExcelDetails').innerHTML = strResult.d;
    //        document.getElementById('id05').style.display = "block";
    //    }

    //}



    function ToggleList() {
        if ($("#liSavedFilter").hasClass("open")) {
            $("#liSavedFilter.open").hide("slow");
            $("#liSavedFilter").removeClass("open");

            $("#ancToggle").find("i").removeClass("fa-minus");
            $("#ancToggle").find("i").addClass("fa-plus");
        }
        else {
            $("#liSavedFilter").addClass("open");

            $("#ancToggle").find("i").addClass("fa-minus");
            $("#ancToggle").find("i").removeClass("fa-plus");

            $("#liSavedFilter.open").show("slow");
        }
    }
    var PrevSortColumn = "";
    var sortOrder = "asc";
    function sortTable(tableid, n, DateColumn) {

        var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
        table = document.getElementById(tableid);
        switching = true;
        var date1;
        var date2;

        //Set the sorting direction to ascending:
        if (PrevSortColumn == "" || PrevSortColumn != n) {
            dir = "asc";
            sortOrder = "asc";
        }
        else {
            if (sortOrder == "asc") {
                dir = "desc";
                sortOrder = "desc";
            }
            else if (sortOrder == "desc") {
                dir = "asc";
                sortOrder = "asc";
            }
        }

        PrevSortColumn = n;


        $("#tblRequestList thead th").removeClass("sortingApplied");
        $("#tblRequestList thead th:nth-child(" + (n + 1) + ")").addClass("sortingApplied");

        /*Make a loop that will continue until
        no switching has been done:*/

        while (switching) {
            //start by saying: no switching is done:
            switching = false;
            rows = document.querySelectorAll("#" + tableid + " > tbody > tr");

            /*Loop through all table rows (except the
            first, which contains table headers):*/
            for (i = 0; i < (rows.length - 2) ; i += 2) {
                //start by saying there should be no switching:
                shouldSwitch = false;
                /*Get the two elements you want to compare,
                one from current row and one from the next:*/


                //x = rows[i].getElementsByTagName("TD")[n];
                //y = rows[i + 1].getElementsByTagName("TD")[n];

                x = rows[i].getElementsByTagName("TD")[n];
                y = rows[i + 2].getElementsByTagName("TD")[n];


                if (DateColumn == "DateColumn") {
                    /*check if the two rows should switch place,
                    based on the direction, asc or desc:*/

                    date1 = formatDate(x.innerText.replace(/[\n\t\r]/g, ""));
                    date2 = formatDate(y.innerText.replace(/[\n\t\r]/g, ""));

                    if (String(date1) == "Invalid Date") {
                        date1 = "0";
                    }
                    if (String(date2) == "Invalid Date") {
                        date2 = "0";
                    }

                    if (dir == "asc") {
                        if (date1 > date2) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (date1 < date2) {
                            //if so, mark as a switch and break the loop:	                              
                            shouldSwitch = true;
                            break;
                        }
                    }


                }
                else {
                    if (dir == "asc") {
                        if (x.innerText.replace(/[\n\t\r]/g, "").toLowerCase() > y.innerText.replace(/[\n\t\r]/g, "").toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerText.replace(/[\n\t\r]/g, "").toLowerCase() < y.innerText.replace(/[\n\t\r]/g, "").toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
            }
            if (shouldSwitch) {
                /*If a switch has been marked, make the switch
                and mark that a switch has been done:*/
                //rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);

                rows[i].parentNode.insertBefore(rows[i + 2], rows[i]);
                rows[i].parentNode.insertBefore(rows[i + 3], rows[i]);
                switching = true;
                //Each time a switch is done, increase this count by 1:
                switchcount++;
            }
            //else {
            //    /*If no switching has been done AND the direction is "asc",
            //    set the direction to "desc" and run the while loop again.*/
            //    if (switchcount == 0 && dir == "asc") {
            //        dir = "desc";
            //        switching = true;
            //    }

            //}

        }


    }
    function convertDate(d) {
        var p = d.split("/");
        return +(p[2] + p[1] + p[0]);
    }

    function formatDate(date) {
        //var date1 = Date.parse(date);

        var arrDate = date.split("/");
        var month = arrDate[1];
        var day = arrDate[0];
        var year = arrDate[2];

        if (typeof month != "undefined" && typeof day != "undefined" && typeof year != "undefined") {
            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            return new Date([month, day, year].join('/')).getTime();
        }
        else {
            return "0";
        }

    }

    function sortByDate(n) {

        var tbody = document.querySelector("#tblRequestList > tbody");

        //// get trs as array for ease of use
        //var rows = Array.prototype.slice.call(document.querySelectorAll("#tblRequestList > tbody > tr"),0);

        //rows.sort(function (a, b) {
        //    return convertDate(a.cells[n].innerHTML) - convertDate(b.cells[n].innerHTML);
        //});

        //rows.forEach(function (v) {
        //    tbody.appendChild(v); // note that .appendChild() *moves* elements
        //});
        var order = 0;
        var tbl = document.getElementById("tblRequestList");
        var rows = Array.prototype.slice.call(document.querySelectorAll("#tblRequestList > tbody > tr"), 1);

        rows = rows.sort(function (a, b, c) {

            var dtA = new Date(a.cells[n].innerHTML);
            var dtB = new Date(c.cells[n].innerHTML);

            return (order == 0) ? dtA > dtB : dtA < dtB;

        });

        for (i = 0; i < rows.length; i++) {
            tbl.appendChild(rows[i]);
        }
    }
</script>
<script>
    $(document).ready(function () {
        $("#divGrid > table thead.clsTRColumnHeader th").map(function (count) {
            var colHeaderText = $(this).text();
            var strShortHeaderName;

            //$(this).attr('data-toggle', 'tooltip');
            //$(this).attr('title', colHeaderText);
            //$(this).attr('data-original-title', colHeaderText);
            //$(this).addClass("bs-tooltip-top");

            $("[data-toggle='tooltip']").tooltip();
            $(".clsControlHeight").tooltip();
            //$('body').tooltip({
            //    selector: '.divGrid'
            //});

            if (colHeaderText.length > 18) {
                strShortHeaderName = colHeaderText.substr(0, 18);


                $(this).text(strShortHeaderName + "..");
            }

            if ($(this).html().indexOf("fa-flag") > 0 || $(this).html().indexOf("fa-comments-o") > 0 || $(this).html().indexOf("fa-paperclip") > 0 || $(this).html().indexOf("fa-pencil-square-o") > 0 || $(this).html() == "" || $(this).html().indexOf("checkbox") > 0) {

            }
            else {
                if (typeof $(this).attr("isdatecolumn") != "undefined") {
                    //$(this).attr("onclick", "sortTable('tblRequestList'," + count + ",'DateColumn');");
                    //$(this).attr("onclick", "sortByDate(" + count + ");");

                }
                else {
                    $(this).attr("onclick", "sortTable('tblRequestList'," + count + ",'');");
                }

            }
        });

        $("#divGrid > table").attr("id", "tblRequestList");
        $('body').on('click', '.clsFilterExpCol', function (e) {
            e.stopPropagation();
            e.preventDefault();
        });

        $('input[name=clsFilter]').on('change', function () {
            if (this.checked == false) {
                $(this).prop('checked', true);
                return;
            }

            $('input[name=clsFilter]').not(this).prop('checked', false);
        });
        /*Added By Yasmin on 18th july 2018*/
        $("[data-toggle='tooltip']").on('click', function () {
            $(".tooltip").removeClass("in");
        });
        $("[data-toggle='tooltip']").tooltip();
        $(".clsControlHeight").tooltip();
        //$('body').tooltip({
        //    selector: "[data-toggle='tooltip']",
        //    trigger: 'hover'
        //});
       
    });



    function AssignIssue_OnClick(QueryID, strToken,PreIssueID)
    {
        window.open("../../NewAPI/Issues/IB_AssignIssue.aspx?QueryID=" + QueryID + "&PreIssueID=" + PreIssueID +"&PKToken=" + strToken, "_Assignment", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=800,height=600");

    } 


    //Added By Vidya Jadhav ON 30 Oct 2017 For Import Functionality


    function ShowImportDetails(obj) {
        //   alert();
        //Added by Yogesh Jalamkar on 28-NOV-2017 Purpose: To hide tooltip on click
        $('.tooltip').fadeOut('fast', function () {
            $('.tooltip').remove();
        });
        //End of addition by Yogesh Jalamkar
        var url = "CRM_RequestListNew.aspx/GetImportDetails"
        data = JSON.stringify({});
        var strResult = AJAXCallWithResult(url, data, false);
        if (strResult.d != "") {

            document.getElementById('idDivExcelDetails').innerHTML = ""
            document.getElementById('idDivExcelDetails').innerHTML = strResult.d;
            document.getElementById('id05').style.display = "block";

            //document.getElementById('divFileUploaed').style.display = 'none';
            //document.getElementById('divFileUploaedBy').style.display = 'none';
            document.getElementById('lblAttachmentName').innerHTML = "";
            //document.getElementById('lblUploadedByName').innerHTML = "";
            //document.getElementById('tblFileDetails').style.display = "none";
            //$('[data-toggle="tooltip"]').tooltip();
            $("[data-toggle='tooltip']").tooltip();
            $(".clsControlHeight").tooltip();
        }

    }
    var ChkSavedFlag = 0;
    function SaveExcelConfiguration() {

        if (typeof fileObject != "undefined") {

            var k;
            var strMsg = "";
            var IsSubjectPresent = 0;
            var IsDescriptionPresent = 0;
            var IsDepartmentPresent = 0;
            var IsRequestTypePresent = 0;
            var IsSubRequestTypePresent = 0;
            var IsOrgUnitPresent = 0;
            var IsExpDateOfResolPresent = 0;
            var IsPriorityPresent = 0;
            var IsUSNamePresent = 0;
            var arrPBFields = [];
            var IsValid = 0;
            var IsValidRow = 0;
            //   var arrExcelFields1 = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];
            var arrExcelFields = [];
            var ColumnLength = document.getElementsByName('hdnColumns').length;
            for (k = 0; k <= ColumnLength  ; k++) {
                var objcboUSField = document.getElementById("cboRequestField_" + k);
                var objCaption = document.getElementById("hdnColumns_" + k);
                if (objcboUSField != null) {
                    if (objcboUSField.value == "Select Column") {
                        objcboUSField.value = "Select Column";
                    }
                    arrPBFields.push(objcboUSField.value);
                    arrExcelFields.push(objCaption.value);


                    if (objCaption.value == "Subject") {
                        if (objcboUSField.value != "Select Column") {
                            IsSubjectPresent = 1;
                        }
                    }

                    if (objCaption.value == "Description") {
                        if (objcboUSField.value != "Select Column") {
                            IsDescriptionPresent = 1;
                        }
                    }

                    if (objCaption.value == "Department") {
                        if (objcboUSField.value != "Select Column") {
                            IsDepartmentPresent = 1;
                        }
                    }

                    if (objCaption.value == "RequestType") {
                        if (objcboUSField.value != "Select Column") {
                            IsRequestTypePresent = 1;
                        }
                    }
                    if (objCaption.value == "SubRequestType") {
                        if (objcboUSField.value != "Select Column") {
                            IsSubRequestTypePresent = 1;
                        }
                    }

                    if (objCaption.value == "Priority") {
                        if (objcboUSField.value != "Select Column") {
                            IsPriorityPresent = 1;
                        }
                    }

                    if ('<%=m_strLoginType%>' == 'E') {
                        if (objCaption.value == "ExpDateOfResolution") {
                            if (objcboUSField.value != "Select Column") {
                                IsExpDateOfResolPresent = 1;
                            }
                        }
                        if (objCaption.value == "OrganizationType") {
                            if (objcboUSField.value != "Select Column") {
                                IsOrgUnitPresent = 1;
                            }
                        }

                    }

                    if (objcboUSField.value == "Select Column") {
                        IsValidRow = IsValidRow + 1;
                    }

                    //if ($.inArray(objcboUSField.value, arrPBFields) == 0) {
                    //    alert();

                    //}


                    //if (arrPBFields.indexOf(objcboUSField.value) > -1)
                    //{
                    //    alert();

                    //}


                    //var index = arrPBFields.indexOf(objcboUSField.value);

                    //if (index === -1)
                    //    document.write("not in array<br/>");
                    //else
                    //    document.write("exists at index " + index + "<br/>");
                }

                for (i = 0; i <= ColumnLength  ; i++) {
                    if (k != i) {

                        var objcboUSField1 = document.getElementById("cboRequestField_" + i);
                        if (objcboUSField1 != null && objcboUSField != null) {
                            //if (objcboUSField.value == "Select Column")
                            //{
                            //    objcboUSField.value = "";

                            //}
                            //if (objcboUSField1.value == "Select Column") {
                            //    objcboUSField1.value = "";

                            //}

                            if (objcboUSField.value != "Select Column" && objcboUSField1.value != "Select Column") {

                                if (objcboUSField.value == objcboUSField1.value) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.notify(objcboUSField.value + "  Column can not be mapped twice", 'error');
                                    return;
                                }
                            }

                        }
                    }
                }

            }



            if (IsSubjectPresent == 0)
                strMsg += "<li>Subject is mandatory for excel column mapping </li>";

            //if (IsDescriptionPresent == 0)
            //    strMsg += "<li>Description is mandatory for excel column mapping </li>";

            if (IsDepartmentPresent == 0)
                strMsg += "<li>Department is mandatory for excel column mapping</li>";

            if (IsRequestTypePresent == 0)
                strMsg += "<li>Request Type is mandatory for excel column mapping</li>";
            if (IsSubRequestTypePresent == 0)
                strMsg += "<li>Sub Request Type is mandatory for excel column mapping</li>";

            if (IsPriorityPresent == 0)
                strMsg += "<li>Priority is mandatory for excel column mapping</li>";
            if ('<%=m_strLoginType%>' == 'E') {
                if (IsExpDateOfResolPresent == 0)
                    strMsg += "<li>Exp. Date Of Resolution is mandatory for excel column mapping</li>";


                if (IsOrgUnitPresent == 0)
                    strMsg += "<li>Organization Unit is mandatory for excel column mapping</li>";

            }

            strMsg = strMsg.substr(0, strMsg.length - 1);

            if (strMsg != "") {
                strMsg += " fields are mandatory."
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("<ul>" + strMsg + "</ul>", 'error');
                IsValid = 1;
                return;
            }


            if (IsValidRow == 8) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please map excel columns.", 'error');
                return;

            }
            else if (IsValidRow == 10) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please map excel columns.", 'error');
                return;

            }

            if (strMsg == "" && IsValid == 0) {
                var data = JSON.stringify({ arrPBFields: arrPBFields, arrExcelFields: arrExcelFields });

                var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/SaveExcelConfiguration", data, false);
                ChkSavedFlag = 1;

            }
            else {
                return;
            }
            //var ColumnLength1 = document.getElementsByName('hdnColumns').length;
            //var k1;
            //for (k1 = 0; k1 <= ColumnLength1  ; k1++) {
            //    var objcboUSField = document.getElementById("cboRequestField_" + k1);
            //    if (objcboUSField.value == "")
            //    {
            //        objcboUSField.value = "Select Column";
            //    }
            //}

        }
        else {
            if (ValidateClicked == 1) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please upload a file to validate.', 'error');
                return;
            }
            else if (ImportClicked == 1) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please upload a file to import.', 'error');
                return;
            }

        }
        return ChkSavedFlag;
    }




    var fileObject;
    $(document).on('change', '.file', async function () {
        try {
          
        //    alert(isValidTypeExeCheckFlag);
            var objtxtFileName = document.getElementById('file');
            var fileflag= await validateForExe(objtxtFileName);
            //alert(fileflag);
            // debugger;
            // $("#file").change(function () {
            //   debugger;
            //$(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
            // fileObjects = fileObject[0];
            //  document.getElementById('lblAttachmentName').innerHTML = $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
            if (fileflag == true) {
                $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
                // fileObjects = fileObject[0];

                // alert(fileflag);
                var fileName = objtxtFileName.value;
                var index = fileName.lastIndexOf("\\");
                if (index == -1)
                    index = fileName.lastIndexOf("/");

                if (index != -1)
                    fileName = fileName.substring(index + 1, fileName.length);

                document.getElementById('divFileUploaed').style.display = 'block';
                document.getElementById('divFileUploaedBy').style.display = 'block';
                document.getElementById('lblAttachmentName').innerHTML = fileName;
                //document.getElementById('lblUploadedByName').innerHTML = '<%=Session("strUserName")%>';
                ValidateClicked = 0;

                fileObject = $("#file")[0].files;
                //Commented and Added by Usha Pandit on 02.05.2019 for issue if upload same excel twice
                //if (typeof fileObject != "undefined") {
                if (typeof fileObject != "undefined" && fileObject[0] != null) {
                    //End of Added by Usha Pandit on 02.05.2019 for issue if upload same excel twice
                    if (fileObject[0].name.indexOf(".xls") > 0 || fileObject[0].name.indexOf(".xlsx") > 0) {
                        if (fileObject.length > 0) {
                            ImportOnclick();
                        }
                    } else {
                        document.getElementById('lblAttachmentName').innerHTML = "";
                        $("#tblFileDetails").html("");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.set('notifier', 'z-index', '999999');
                        alertify.notify('Only excel files are allowed.', 'error');
                        return;
                    }
                }
                // alert(fileObject[0].name)
            } else {
                $('#tblFileDetails').html("");
                // datatableMainPage('tblFileDetails');
                $(".FixedTD").css("top", "0px")
                $("#tblValidateFile").scroll(function () {
                    $(".FixedTD").css("top", $("#tblValidateFile").scrollTop() - 1);
                });
                $(".clslabelColumns").css("margin-left", "10px");
            }
        }
        catch (ex) {
          
        }
    });
    function SelectFile() {
         //Added by Usha Pandit on 02.05.2019 for issue if upload same excel twice
        $("#file").prop("value", "");
         //End of Added by Usha Pandit on 02.05.2019 for issue if upload same excel twice

        var strFileCount = $("#btnSelectFile").attr("FileCount");
        var objCurrentFileControl = $("#file");

        objCurrentFileControl.click();


    }
    function ImportOnclick() {
        //   debugger;
        var strURL = "CRM_RequestListNew.aspx";

        var formData = new FormData();
        formData.append('excelFile', fileObject[0]);
        formData.append('Mode', 'ProcessFile');

        if (typeof fileObject != "undefined") {
            if (fileObject[0].name.indexOf(".xls") > 0 || fileObject[0].name.indexOf(".xlsx") > 0) {
                setFrameLoader();
                $.ajax({
                    url: strURL,  //Server script to process data
                    type: 'POST',
                    data: formData,
                    async: false,
                    success: function (result) {
                        //alert(result);
                        //   document.getElementById('tblFileDetails').style.display = "block";
                        $('#tblFileDetails').html(result);
                        // datatableMainPage('tblFileDetails');
                        $(".FixedTD").css("top", "0px")
                        $("#tblValidateFile").scroll(function () {
                            $(".FixedTD").css("top", $("#tblValidateFile").scrollTop() - 1);
                        });
                        $(".clslabelColumns").css("margin-left", "10px");
                        //var AttachmentID = document.getElementById("hdnAttachmentID").value;

                        //var data = JSON.stringify({ AttachmentID: AttachmentID });
                        //var strResult = AJAXCallWithResult("PM_ProductBacklog.aspx/UploadData", data, false);

                        //if (strResult.d == "1") {
                        //    $("[data-dismiss=modal]").trigger({ type: "click" });
                        //}
                        //  datatables('tblFileDetails');
                        setTimeout(function () { RemoveFrameLoader(); }, 1000);
                    },
                    error: function (xhr, status, error) {
                        setTimeout(function () { RemoveFrameLoader(); }, 1000);
                        console.log(xhr.responseText);
                        //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                    },
                    cache: false,
                    contentType: false,
                    processData: false
                });

            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.set('notifier', 'z-index', '999999');
                alertify.notify('Only excel files are allowed.', 'error');
                return;
                //alert("Only excel files are allowed.");
            }
        }
    }
    //function Import_Onclick() {

    //    SaveExcelConfiguration();
    //    if (ChkSavedFlag == 1) {
    //        var strURL = "CRM_RequestListNew.aspx";

    //        var strAttachmentID = document.getElementById('hdnAttachmentID').value;
    //        var strRequestIds = ""

    //        var RequestCount = "";
    //        if (document.getElementsByName('chkRequest') != null) {
    //            RequestCount = document.getElementsByName('chkRequest');
    //            for (var i = 0; i < RequestCount.length; i++) {
    //                if (strRequestIds == "") {
    //                    strRequestIds += $('#chkRequest_' + [i]).val();
    //                }
    //                else {
    //                    strRequestIds += ',' + $('#chkRequest_' + [i]).val();
    //                }
    //            }

    //        }
    //        var formData = new FormData();
    //        formData.append('excelFile', fileObject[0]);
    //        formData.append('Mode', 'ValidateFile');
    //        formData.append('AttachmentID', strAttachmentID);
    //        formData.append('SelectedRequestIDs', SelectedRequestIDs);
    //        formData.append('strRequestIds', strRequestIds);


    //        if (fileObject !== undefined) {
    //            if (fileObject[0].name.indexOf(".xls") > 0 || fileObject[0].name.indexOf(".xlsx") > 0) {
    //            $.ajax({
    //                url: strURL,  //Server script to process data
    //                type: 'POST',
    //                data: formData,
    //                async: false,
    //                success: function (result) {

    //                    document.getElementById('tblFileDetails').style.display = "block";
    //                    $('#tblFileDetails').html("");
    //                    $('#tblFileDetails').html(result);
    //                    var AttachmentID = document.getElementById("hdnAttachmentID").value;
    //                    $(".FixedTD").css("top", "0px")
    //                    $("#tblFileDetails").scroll(function () {
    //                        $(".FixedTD").css("top", $("#tblFileDetails").scrollTop() - 1);
    //                    });
    //                    $(".clslabelColumns").css("margin-left", "10px");
    //                    SelectedRequestIDs = $('input[name=chkRequest]:checked').map(function () {
    //                        return this.value;
    //                    }).get().join(',');

    //                    if (SelectedRequestIDs.length <= 0) {
    //                        return;
    //                    }
    //                  //  alert(SelectedRequestIDs);

    //                    alert(SelectedRequestIDs);
    //                    if (ValidateClicked == 1)
    //                    {
    //                        var data1 = JSON.stringify({ SelectedRequestIDs: SelectedRequestIDs, AttachmentID: AttachmentID });
    //                        var strResult1 = AJAXCallWithResult("CRM_RequestListNew.aspx/ValidateAndSave", data1, false);
    //                    }
    //                    //alert(AttachmentID);

    //                    var data = JSON.stringify({ AttachmentID: AttachmentID });
    //                    var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/UploadData", data, false);

    //                    if (strResult.d == "1") {

    //                    }
    //                },
    //                cache: false,
    //                contentType: false,
    //                processData: false
    //            });
    //             }
    //              else {
    //                alertify.set('notifier', 'position', 'top-right');
    //                alertify.notify('Only excel files are allowed.', 'error');
    //              }
    //        }
    //    }
    //}
    var SelectedRequestIDs = ""
    var ValidateClicked = 0;
    //function ValidateExcel_Onclick() {
    //    SaveExcelConfiguration();
    //    if (ChkSavedFlag == 1) {

    //        var strURL = "CRM_RequestListNew.aspx";

    //        var strAttachmentID = document.getElementById('hdnAttachmentID').value;
    //        var strRequestIds = ""

    //        var RequestCount = "";
    //        if (document.getElementsByName('chkRequest') != null) {
    //            RequestCount = document.getElementsByName('chkRequest');
    //            for (var i = 0; i < RequestCount.length; i++) {
    //                if (strRequestIds == "") {
    //                    strRequestIds += $('#chkRequest_' + [i]).val();
    //                }
    //                else {
    //                    strRequestIds += ',' + $('#chkRequest_' + [i]).val();
    //                }
    //            }

    //        }
    //        var formData = new FormData();
    //        formData.append('excelFile', fileObject[0]);
    //        formData.append('Mode', 'ValidateExcelToSelect');
    //        formData.append('AttachmentID', strAttachmentID);
    //        formData.append('strRequestIds', strRequestIds);

    //        if (fileObject !== undefined) {
    //            if (fileObject[0].name.indexOf(".xls") > 0 || fileObject[0].name.indexOf(".xlsx") > 0) {
    //                $.ajax({
    //                    url: strURL,  //Server script to process data
    //                    type: 'POST',
    //                    data: formData,
    //                    async: false,
    //                    success: function (result) {
    //                        // debugger;
    //                        document.getElementById('tblFileDetails').style.display = "block";
    //                        $('#tblFileDetails').html("");
    //                        $('#tblFileDetails').html(result);
    //                        $(".FixedTD").css("top", "0px")
    //                        $("#tblFileDetails").scroll(function () {
    //                            $(".FixedTD").css("top", $("#tblFileDetails").scrollTop() - 1);
    //                        });
    //                        $(".clslabelColumns").css("margin-left","10px");
    //                        ValidateClicked = 1;

    //                        //var AttachmentID = document.getElementById("hdnAttachmentID").value;

    //                        //var data = JSON.stringify({ AttachmentID: AttachmentID });

    //                        //var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/UploadData", data, false);

    //                        //if (strResult.d == "1") {

    //                        //}
    //                    },
    //                    cache: false,
    //                    contentType: false,
    //                    processData: false
    //                });
    //            }
    //            else {
    //                alertify.set('notifier', 'position', 'top-right');
    //                alertify.notify('Only excel files are allowed.', 'error');
    //            }
    //        }
    //    }
    //}

    function datatableMainPage(divID) {
        $('#' + divID + ' > table').removeClass("table");
        $('#' + divID + ' table').addClass("table table-striped table-bordered table-hover");
        var table = $('#' + divID + ' table').DataTable();
    }

    function Import_Close() {
        document.getElementById('id05').style.display = 'none';
        //document.getElementById('divFileUploaed').style.display = 'none';
        //document.getElementById('divFileUploaedBy').style.display = 'none';

        //added by nilam rawool on 12/28/2018
        
       
         //Commented and Added by Usha Pandit on 02.05.2019 for clear filter error afer excel upload
        // window.location.reload();
        window.location.href = window.location.href;
        //End of Added by Usha Pandit on 02.05.2019 for clear filter error afer excel upload
        setFrameLoader();
        //ended by nilam rawool on 12/28/2018
    }


    function ValidateExcel_Onclick() {
        ValidateClicked = 1;




        if (SaveExcelConfiguration() == 1) {

            var strURL = "CRM_RequestListNew.aspx";

            //Commented and Added by nilam Rawool on 1 jan 2019
            //var strAttachmentID = document.getElementById('hdnAttachmentID').value;
            var strAttachmentID = $('#hdnAttachmentID').val();

            if(strAttachmentID == undefined)
            {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Invalid excel file .', 'error');
                return;
            }
            //End of Added by nilam Rawool on 1 jan 2019
            var strRequestIds = ""

            var RequestCount = "";
            if (document.getElementsByName('chkRequest') != null) {
                RequestCount = document.getElementsByName('chkRequest');
                for (var i = 0; i < RequestCount.length; i++) {
                    if (strRequestIds == "") {
                        strRequestIds += $('#chkRequest_' + [i]).val();
                    }
                    else {
                        strRequestIds += ',' + $('#chkRequest_' + [i]).val();
                    }
                }

            }
            //var formData = new FormData();
            //formData.append('excelFile', fileObject[0]);
            //formData.append('Mode', 'ValidateExcelToSelect');
            //formData.append('AttachmentID', strAttachmentID);
            //formData.append('strRequestIds', strRequestIds);
            // alert(typeof fileObject);
            //Commented and Added by Usha Pandit on 02.05.2019 for issue if upload same excel twice
            //if (typeof fileObject !== "undefined") {
             if (typeof fileObject != "undefined" && fileObject[0] != null) {
                  //End of Added by Usha Pandit on 02.05.2019 for issue if upload same excel twice
                if (fileObject[0].name.indexOf(".xls") > 0 || fileObject[0].name.indexOf(".xlsx") > 0) {
                    ValidateClicked = 1;
                    setFrameLoader();
                    var url = "CRM_RequestListNew.aspx/ValidateExcelToSelect"
                    data = JSON.stringify({ AttachmentID: strAttachmentID, ValidateClicked: "1" });
                    var strResult = AJAXCallWithResult(url, data, false);
                    if (strResult.d != "") {
                        // debugger;

                        // document.getElementById('tblFileDetails').style.display = "block";
                        $('#tblFileDetails').html("");
                        $('#tblFileDetails').html(strResult.d);
                        $(".FixedTD").css("top", "0px")
                        $("#tblValidateFile").scroll(function () {
                            $(".FixedTD").css("top", $("#tblValidateFile").scrollTop() - 1);
                        });
                        //  $(".clslabelColumns").css("margin-left", "10px");

                        //datatables('tblFileDetails');
                        //var AttachmentID = document.getElementById("hdnAttachmentID").value;

                        //var data = JSON.stringify({ AttachmentID: AttachmentID });

                        //var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/UploadData", data, false);

                        //if (strResult.d == "1") {

                        //}
                        //    datatables('tblFileDetails');

                        var ValidRows = $("#hdnvalidRowCount").val();
                        var InValidRows = $("#hdnInvalidRowCount").val();
                        var strMsg = ""
                        var strMsg1 = ""
                        //Commented and Added by Usha Pandit on 13.12.2018 for wrong alert while importing excel in helpdesk module
                        //if (ValidRows != "" || InValidRows != "") {
                        if (ValidRows != "" && ValidRows != undefined && InValidRows != "" && InValidRows != undefined) {
                            //End of Added by Usha Pandit on 13.12.2018 for wrong alert while importing excel in helpdesk module
                            strMsg += "<li>Valid Requests: " + ValidRows + "</li>"
                            //strMsg += "<li>Invalid Requests: " + InValidRows + "</li>"


                            //alertify.set('notifier', 'position', 'top-right');

                            ////Commented and Added by Usha Pandit on 26.12.2018 for wrong alert colour
                            ////alertify.notify("<ul>" + strMsg + "</ul>", 'error');
                            //alertify.notify("<ul>" + strMsg + "</ul>", 'success');
                            ////End of Added by Usha Pandit on 26.12.2018 for wrong alert colour      

                            strMsg1 += "<li>Invalid Requests: " + InValidRows + "</li>"


                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("<ul>" + strMsg + "</ul>", 'success');
                            alertify.notify("<ul>" + strMsg1 + "</ul>", 'error');
                        }


                        setTimeout(function () { RemoveFrameLoader(); }, 1000);
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Only excel files are allowed.', 'error');
                    }
                }
            }

        }
    }
    var ImportClicked = 0;
    function Import_Onclick() {
        ImportClicked = 1;
        //  SaveExcelConfiguration();
        if (SaveExcelConfiguration() == 1) {
            //  var strURL = "CRM_RequestListNew.aspx";

            //Commented and Added by nilam Rawool on 1 jan 2019
            //var strAttachmentID = document.getElementById('hdnAttachmentID').value;
            var strAttachmentID =$("#hdnAttachmentID").val();
           
            if(strAttachmentID == undefined)
            {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Invalid excel file', 'error');
                return;

            }
            //ended by nilam Rawool on 1 jan 2019
            var strRequestIds = ""

            var RequestCount = "";
            if (document.getElementsByName('chkRequest') != null) {
                RequestCount = document.getElementsByName('chkRequest');
                for (var i = 0; i < RequestCount.length; i++) {
                    if (strRequestIds == "") {
                        strRequestIds += $('#chkRequest_' + [i]).val();
                    }
                    else {
                        strRequestIds += ',' + $('#chkRequest_' + [i]).val();
                    }
                }

            }
            //  alert(typeof fileObject);

            if (typeof fileObject != "undefined") {

                //  alert(fileObject[0])
                if (fileObject[0].name.indexOf(".xls") > 0 || fileObject[0].name.indexOf(".xlsx") > 0) {
                    if (ValidateClicked != 1) {
                        setFrameLoader();
                        var url = "CRM_RequestListNew.aspx/ValidateExcelToImport"
                        //  alert(strAttachmentID)
                        var data = JSON.stringify({ AttachmentID: strAttachmentID, ValidateClicked: ValidateClicked });
                        var strResult = AJAXCallWithResult(url, data, false);

                        if (strResult.d != "") {

                            //  document.getElementById('tblFileDetails').style.display = "block";
                            $('#tblFileDetails').html("");
                            $('#tblFileDetails').html(strResult.d);
                            var AttachmentID = document.getElementById("hdnAttachmentID").value;
                            $(".FixedTD").css("top", "0px")
                            $("#tblValidateFile").scroll(function () {
                                $(".FixedTD").css("top", $("#tblValidateFile").scrollTop() - 1);
                            });
                            $(".clslabelColumns").css("margin-left", "10px");
                            //Added By Usha Pandit On 23.02.2021 For duplicate request insertion issue
                            var ValidRows = $("#hdnvalidRowCount").val();
                            var InValidRows = $("#hdnInvalidRowCount").val();
                            if (ValidRows != "" && InValidRows != "" && ValidRows != undefined  && InValidRows != undefined) {
                            //End Of Added By Usha Pandit On 23.02.2021 For duplicate request insertion issue
                            var data = JSON.stringify({ AttachmentID: AttachmentID });
                            var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/UploadData", data, false);

							//Commented By Usha Pandit On 23.02.2021 For duplicate request insertion issue
                            //var ValidRows = $("#hdnvalidRowCount").val();
                            //var InValidRows = $("#hdnInvalidRowCount").val();
                            //End Of Commented By Usha Pandit On 23.02.2021 For duplicate request insertion issue
                            var strMsg = ""
                            var strMsg1 = ""
                            //Commented and Added by Usha Pandit on 13.12.2018 for wrong alert while importing excel in helpdesk module
                            //if (ValidRows != "" && InValidRows != "") {
							//Commented By Usha Pandit On 23.02.2021 For duplicate request insertion issue
                            //if (ValidRows != "" && InValidRows != "" && ValidRows != undefined  && InValidRows != undefined) {
                            //End Of Commented By Usha Pandit On 23.02.2021 For duplicate request insertion issue
                                //End of Added by Usha Pandit on 13.12.2018 for wrong alert while importing excel in helpdesk module
                                strMsg += "<li>Valid Requests: " + ValidRows + "</li>"
                                //strMsg += "<li>Invalid Requests: " + InValidRows + "</li>"
                                strMsg1 += "<li>Invalid Requests: " + InValidRows + "</li>"
                                // alertify.set('notifier', 'position', 'top-right');
                               
                                strMsg += "<li> Requests are imported successfully </li>";
                                alertify.set('notifier', 'position', 'top-right');
                           
                                //Commented and Added by Usha Pandit on 26.12.2018 for wrong alert colour
                                //alertify.notify("<ul>" + strMsg + "</ul>", 'error');
                                //alertify.notify("<ul>" + strMsg + "</ul>", 'success');

                               
                                alertify.notify("<ul>" + strMsg + "</ul>", 'success');
                                alertify.notify("<ul>" + strMsg1 + "</ul>", 'error');

                                //End of Added by Usha Pandit on 26.12.2018 for wrong alert colour

                                document.getElementById('id05').style.display = 'none';
                                //  window.location.href = "CRM_RequestListNew.aspx?Mode=SR";

                            }
                            else
                            {
                                strMsg += "<li> no records are to be imported</li>";
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.notify("<ul> First you have to validate excel </ul>", 'error');
                                RemoveFrameLoader();
                                return;
                                //document.getElementById('id05').style.display = 'none';
                            }




                            var objForm = document.getElementById("frmRequestListNew");
                            objForm.action = "CRM_RequestListNew.aspx?Mode=SR";
                            objForm.submit();
                            setTimeout(function () { RemoveFrameLoader(); }, 1000);
                            //  alert(SelectedRequestIDs);

                        }
                    }

                    else if (ValidateClicked == 1) {

                        SelectedRequestIDs = $('input[name=chkRequest]:checked').map(function () {
                            return this.value;
                        }).get().join(',');

                        if (SelectedRequestIDs.length <= 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('No records can be imported !', 'error', 10);
                            return;
                        }
                        //   alert(SelectedRequestIDs);
                        var AttachmentID = document.getElementById("hdnAttachmentID").value;
                        var data1 = JSON.stringify({ SelectedRequestIDs: SelectedRequestIDs, AttachmentID: AttachmentID });
                        var strResult1 = AJAXCallWithResult("CRM_RequestListNew.aspx/ValidateAndSave", data1, false);

                        //alert(AttachmentID);

                        var data = JSON.stringify({ AttachmentID: AttachmentID });
                        var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/UploadData", data, false);


                        // datatables('tblFileDetails');
                        var ValidRows = $("#hdnvalidRowCount").val();
                        var InValidRows = $("#hdnInvalidRowCount").val();
                        var strMsg = ""
                        //Commented and Added by Usha Pandit on 13.12.2018 for wrong alert while importing excel in helpdesk module
                        //if (ValidRows != "" && InValidRows != "") {
                        if (ValidRows != "" && ValidRows != undefined && InValidRows != "" && InValidRows != undefined) {
                            //End of Added by Usha Pandit on 13.12.2018 for wrong alert while importing excel in helpdesk module
                            strMsg += " Valid Requests: " + ValidRows
                            strMsg += " Invalid Requests: " + InValidRows
                            // alertify.set('notifier', 'position', 'top-right');


                        }
                        strMsg += "<li>Requests are imported successfully</li>";
                        alertify.set('notifier', 'position', 'top-right');

                        //Commented and Added by Usha Pandit on 26.12.2018 for wrong alert colour
                        //alertify.notify("<ul>" + strMsg + "</ul>", 'error');
                        alertify.notify("<ul>" + strMsg + "</ul>", 'success');
                        //End of Added by Usha Pandit on 26.12.2018 for wrong alert colour

                        document.getElementById('id05').style.display = 'none';
                        //  window.location.href = "CRM_RequestListNew.aspx?Mode=SR";
                        var objForm = document.getElementById("frmRequestListNew");
                        objForm.action = "CRM_RequestListNew.aspx?Mode=SR";
                        objForm.submit();
                        // alertify.set('notifier', 'position', 'top-right');
                        //  alertify.notify(objcboUSField.value + "  Column can not be mapped twice", 'error');

                    }
                }

                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Only excel files are allowed.', 'error');
                }
            }

        }
    }

    function ClearConfiguration_Onclick() {
        //   alert();
        var url = "CRM_RequestListNew.aspx/ClearConfiguration"
        data = JSON.stringify({});
        var strResult = AJAXCallWithResult(url, data, false);
        if (strResult.d != "") {
            var arrExcelFields = [];
            var ColumnLength = document.getElementsByName('hdnColumns').length;
            for (k = 0; k <= ColumnLength  ; k++) {
                var objcboUSField = document.getElementById("cboRequestField_" + k);
                if (objcboUSField != null) {

                    objcboUSField.value = "Select Column";

                }
            }
        }
    }
    function datatables(divID) {
        //$('#' + divID + ' > table').removeClass("clsGridTable");
        //$('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable();
    }

    /*Added By Bharat T on 20th-Nov-2017*/
    //Feedback div functions
    function Putrating(Rating)
    {
        //  alert(Rating);
        
        if(Rating==1)//Satisfactory
        {
            if($("#firstrating").hasClass('checked'))
            {
                $("#firstrating").removeClass('checked')
                $("#Secondrating").removeClass('checked')
                $("#Foruthrating").removeClass('checked')
                $("#Thirdrating").removeClass('checked')
                $("#Fifthrating").removeClass('checked')
                $("#SpnRatingMsg").html("")
                // $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
            }
            else
            {
                $("#firstrating").addClass('checked')
                $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
            }
           
               
            $("#SpnRatingMsg").css("color","red");
            globalRating = $('#Ratingone').val();
        }
        else if(Rating==2)//5Fair
        {
            // $("#SpnRatingMsg").css("color","Green");

            if($("#Secondrating").hasClass('checked'))
            {
                $("#Secondrating").removeClass('checked')
                $("#Foruthrating").removeClass('checked')
                $("#Thirdrating").removeClass('checked')
                $("#Fifthrating").removeClass('checked')
                $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color","red");
            }
            else
            {
                $("#Secondrating").addClass('checked')
                $("#firstrating").addClass('checked')
                $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color","red");
            }
               
               
            globalRating = $('#Ratingtwo').val();
        }
        else if(Rating==3)//8Good
        {
            if($("#Thirdrating").hasClass('checked'))
            {
                     
                //$("#firstrating").removeClass('checked')
                $("#Foruthrating").removeClass('checked')
                $("#Thirdrating").removeClass('checked')
                $("#Fifthrating").removeClass('checked')
                $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color","red");
                
            }
            else
            {
                $("#firstrating").addClass('checked')
                $("#Secondrating").addClass('checked')
                $("#Thirdrating").addClass('checked')
                $("#SpnRatingMsg").html("Thank You ! looking to serve you better")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color","Green");
            }
             
               
            globalRating = $('#Ratingthree').val();
        }

        else if(Rating==4)//10Excellent
        {
            if($("#Foruthrating").hasClass('checked'))
            {   
                   
                //$("#firstrating").removeClass('checked')
                //$("#Secondrating").removeClass('checked')
                // $("#Thirdrating").removeClass('checked')
                $("#Foruthrating").removeClass('checked')
                $("#Fifthrating").removeClass('checked')
                $("#SpnRatingMsg").html("Thank You! looking to serve you better")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color","Green");
            }
            else
            {
                $("#Foruthrating").addClass('checked')
                $("#Thirdrating").addClass('checked')
                $("#Secondrating").addClass('checked')
                $("#firstrating").addClass('checked')
                $("#SpnRatingMsg").html("Thank You! looking to serve you better")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color","Green");
            }
               
               
            globalRating = $('#RatingFour').val();
            //  alert(globalRating);
        }

        else if(Rating==5)//10Excellent
        {
            if($("#Fifthrating").hasClass('checked'))
            {   
                   
                //$("#firstrating").removeClass('checked')
                //$("#Secondrating").removeClass('checked')
                // $("#Thirdrating").removeClass('checked')
                $("#Fifthrating").removeClass('checked')
                $("#SpnRatingMsg").html("Thank You! looking to serve you better")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color","Green");
            }
            else
            {
                $("#Fifthrating").addClass('checked')
                $("#Foruthrating").addClass('checked')
                $("#Thirdrating").addClass('checked')
                $("#Secondrating").addClass('checked')
                $("#firstrating").addClass('checked')
                $("#SpnRatingMsg").html("Thank You! looking to serve you better")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color","Green");
            }
               
               
            //globalRating = $('#RatingFives').val();
            globalRating = $('#RatingFive').val();
            //  alert(globalRating);
        }
        
    }


    function CancelFeedback() {

        $("#firstrating").removeClass('checked');
        $("#Secondrating").removeClass('checked');
        $("#Thirdrating").removeClass('checked');
        $("#Foruthrating").removeClass('checked');
        $("#txtSubmitCommentsDiv").val("");
        $("#SpnRatingMsg").html("");
        document.getElementById('Feedback').style.display = "none";

    }

    function setWidth() {

        var tblDetails = document.getElementById("tblRequestList");
        var tblTotal = document.getElementById("header-fixed");
        //if (WhichBrowser() != 'FF') {

        //console.log(tblDetails)
        if (tblDetails != null) {
            //tblTotal.style.width = tblDetails.offsetWidth - 17 + 'px';
            //width = tblDetails.offsetWidth - 17 + 'px';
            tblTotal.style.width = tblDetails.offsetWidth + 'px';
            width = tblDetails.offsetWidth + 'px';
            //   alert(width);
        }
        // }
        var FooterTableRow = tblTotal.rows[0];
       
        //Commented and added by Poonam S on 28-dec-2018 for MasterCard Issue ID-15791,16579

        //var HeaderRow = tblDetails.rows[0];
        //if (tblTotal.rows.length > 0){
        //for (var i = 0; i < tblTotal.rows[0].cells.length; i++) {
        //    if (FooterTableRow.cells[i] != null)
        //        if (HeaderRow.cells[i] != null) {
        //            FooterTableRow.cells[i].style.width = HeaderRow.cells[i].offsetWidth + 'px';
        //        }
        //    }
        //}

        if (tblDetails!=null)
        {
            var HeaderRow = tblDetails.rows[0];
            if (tblTotal.rows.length > 0){
                for (var i = 0; i < tblTotal.rows[0].cells.length; i++) {
                    if (FooterTableRow.cells[i] != null)
                        if (HeaderRow.cells[i] != null) {
                            FooterTableRow.cells[i].style.width = HeaderRow.cells[i].offsetWidth + 'px';
                        }
                }
            }        
        }

        // End of added by Poonam S on 28-dec-2018 for MasterCard Issue ID-15791,16579
    }

    //Commented and Added by Usha Pandit on 31.12.2018 for select checkbox issue on freeze
    //function SelectAllRequests() {
        function SelectAllRequests(e) { 
            //End of Added by Usha Pandit on 31.12.2018 for select checkbox issue on freeze
       
            //Commented and Added by Usha Pandit on 31.12.2018 for select checkbox issue on freeze
            //if ($("#chkSelectHeader").is(":checked")) {
                if ($(e).is(":checked")) {
                    //End of Added by Usha Pandit on 31.12.2018 for select checkbox issue on freeze

            //Commented and Added by Nilam rawool on 6/12/2018
            //$("input[name=chkSelect]").not(":disabled").prop("checked", true);
            $('input[name=chkSelect]:not(:disabled)').prop('checked', true);
            //End of Added by nilam rawool on 6/12/2018


                    //Added by Usha Pandit on 31.12.2018 for select checkbox issue on freeze

            $('#chkSelectHeader').each(function (index, obj) {

                $(this).prop('checked', true);                
                
            });           

                    //End of Added by Usha Pandit on 31.12.2018 for select checkbox issue on freeze         

                    //Added by Nilam rawool on 31/12/2018

            $header.find('input:checkbox').prop('checked', true);
          
                    //End of Added by nilam rawool on 31/12/2018

            $("input[name=chkSelect]").map(function () {
                if (strSelectedRequestsList.indexOf(this.value) === -1) {
                    strSelectedRequestsList.push(this.value);
                }
            });
        }
        else {
            $("input[name=chkSelect]").prop("checked", false);

            //Added by Usha Pandit on 31.12.2018 for select checkbox issue on freeze
            $('#chkSelectHeader').each(function (index, obj) {              

                $(this).prop('checked', false);                
                
            });

            //End of Added by Usha Pandit on 31.12.2018 for select checkbox issue on freeze

            //Added by Nilam rawool on 31/12/2018
            $header.find('input:checkbox').prop('checked', false);
            //End of Added by nilam rawool on 31/12/2018

            $("input[name=chkSelect]").map(function () {
                if (strSelectedRequestsList.indexOf(this.value) !== -1) {
                    removeArrayElement(strSelectedRequestsList, this.value);
                }
            });
        }
    }

    function ListCheckboxClick(Object) {
        if (Object.checked == true) {
            strSelectedRequestsList.push(Object.value);
        }
        else {
            removeArrayElement(strSelectedRequestsList, Object.value);
        }
        //Added by Nilesh Pingale on 17th Mar 2020 (Issue ID : 23464) for check all not getting selected when all are checked and unchecked.
        if ($('input[name=chkSelect]:not(:disabled)').length == $('input[name=chkSelect]:checked').length) {
            $("input[name=chkSelectHeader]").prop("checked", true);
        }
        else {
            $("input[name=chkSelectHeader]").prop("checked", false);
        }
        //End of Added by Nilesh Pingale on 17th Mar 2020 (Issue ID : 23464) for check all not getting selected when all are checked and unchecked.
    }

    function removeArrayElement(array, element) {
        var index = array.indexOf(element);

        if (index !== -1) {
            array.splice(index, 1);
        }
    }

    function ClearAdvanceFilter() {
        //debugger;
        var ajaxParameter = {};
        var strSearchType;
        var objectControl;

        $(".clsFilterName").attr("filtername", "");

        ajaxParameter.SearchFilterName = "";
        ajaxParameter.SearchFilterValue = "";

        var data = JSON.stringify({ ajaxParameter: ajaxParameter });
        var strResult = AJAXCallWithResult("CRM_RequestListNew.aspx/SaveSearchFilter", data, false);

        setFrameLoader();
        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();

        SerachFilterList_Click('');
        
        ////Added by nilam Rawool on 25 dec 2018
    
        //flagchk=1;
        ////ended by Nilam Rawool on 25 dec 2018

        RefreshGrid(strMode, PageNumber, "");
         //Added By Dipali V On 15th Feb 2021 For Filter Clear Issues
        strFilterName = "";
         //End of Added By Dipali V On 15th Feb 2021 For Filter Clear Issues
       //Added By Dipali V On 29th Dec 2020 For Deirection Upgarde
        $("#clsFilterLinks #Clscontrol").addClass("Clscontrol");
       //End of Added By Dipali V On 29th Dec 2020 For Deirection Upgarde
        //Added by nilam Rawool on 20 jan 2019
        $('#tblRequestList').find('input:checkbox').each(function () {

            $("input[name=chkSelect]").prop("checked", false); 
            $("input[name=chkSelectHeader]").prop("checked", false);  
           
           
        });

         //Commented and Added by Usha Pandit on 02.05.2019 for clear filter error afer excel upload
        //window.location.reload();
        window.location.href = window.location.href;
        //End of Added by Usha Pandit on 02.05.2019 for clear filter error afer excel upload
        setFrameLoader();
        //ended by nilam Rawool on 20 jan 2019

        setTimeout(function () { RemoveFrameLoader(); }, 1000);

        //Added by nilam Rawool on 25 dec 2018
        //$('input[name=chkSelect]:not(:disabled)').prop('checked', false);
        //$('input[name=chkSelectHeader]:not(:disabled)').prop('checked', false);
        
        //ended by Nilam Rawool on 25 dec 2018
    }

    function setTop() {
        setTimeout(function () {
            if ($("#collapseOne").hasClass("show")) {
                tableOffset = $("#tblRequestList").offset().top + ($("#collapseOne").height() - 22);
            }
            else {
                tableOffset = $("#tblRequestList").offset().top;
            }
        }, 200);
    }
    /*End of Added By Bharat T on 20th-Nov-2017*/
    function CheckRequests(obj) {
        if ($("#" + obj.id).hasClass('Checked')) {
            $("#" + obj.id).removeClass('Checked');
        }
        else {

            $("#" + obj.id).addClass('Checked');
        }
    }
    function SelectAllValidRequest() {
        if (document.getElementById('chkRequestAll').checked == true) {
            $("input[name=chkRequest]:not(:disabled)").prop('checked', true);
        }
        else {
            $("input[name=chkRequest]").prop('checked', false);
        }
    }
    function toggleDiv(obj, divID) {
        if ($("" + divID).css("display") == "none") {
            $("" + divID).css("display", "block");
            $(obj).find(".glyphicon-plus").css("display", "none")
            $(obj).find(".glyphicon-minus").css("display", "block")
        }
        else {
            $("" + divID).css("display", "none");
            $(obj).find(".glyphicon-plus").css("display", "block")
            $(obj).find(".glyphicon-minus").css("display", "none")
        }
    }

    $(document).ajaxComplete(function () {

        setTimeout(function () { setWidth(); $("[data-toggle='tooltip']").tooltip(); }, 500);
    })
    //Added By kashish for tooltip issue fixing
    $(".btnClearFilter").on({
        mouseover: function() {
            $('.btnClearFilter').tooltip('show');
        },

        mouseout: function() {
            $('.btnClearFilter').tooltip('hide');
            
        }
    })
    //End of Added By kashish for tooltip issue fixing

    //Added by Poonam for add new discussion window
    function DiscussionView_OnClick(queryid)
    {
      <%--  alert(queryid);
      
        alert("1")--%>
        window.open("CRM_DiscussionView.aspx?QueryID=" + queryid ,"_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=800,height=500" );
    
    }


    function Discussion_OnClick(QueryID,TokenID) {


    }
    //End of Poonam for add new discussion window


    

    window.onclick = function (event) {
        if (!event.target.matches('.dropdown-toggle, .dropdown-toggle-split')) {

            var sharedowns = document.getElementsByClassName("dropdown-menu");
            var i;
            for (i = 0; i < sharedowns.length; i++) {
                var openSharedown = sharedowns[i];
                if (openSharedown.classList.contains('show')) {
                  //  openSharedown.classList.remove('show');
                }
            }
        }
    }
    //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
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
    //End of Comment By Rehan C
    var isValidTypeExeCheckFlag = true;
    var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
    async function validateForExe(file) {
        //debugger;
        if (!file) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error("Please Select File");
            return
        }
        //var fileData =file;
        //console.log(fileData);
        //added by Parth Godshelwar
        var isValidTypeExeCheck;
        var objFile = file;
        var fileName = objFile.files[0].name;
        var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();


        isValidTypeExeCheck = false;
       // const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
        const ValidExtsExe = ValidateFileExtension.split(",");
        isValidTypeExeCheck = ValidExtsExe.includes(extension);

        if (isValidTypeExeCheck) {
            const file = objFile.files[0];
            //await checkFileForExe(file);
            await validateDocFileForExe(file)
                .then(() => {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("File is valid and ready to upload.");
                    isValidTypeExeCheckFlag = true;
                    //alert("File is valid and ready to upload.");
                })
                .catch(error => {
                    console.log(error);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                    //alert("Upload restricted: This file contains an embedded executable (EXE) file.");
                    //alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                    //alert("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                    
                    isValidTypeExeCheck = false;
                    isValidTypeExeCheckFlag = false;
                    console.log($(objFile).val);
                    $(objFile).val("");
                    console.log($(objFile).val);
                    $("#lblAttachmentName").empty();
                    /*$(objFileName).attr("placeholder", "Upload File");*/
                    //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                    //return;
                });



            //if (!isValidTypeExeCheck) {
            //    return;
            //}
        }

        //$(objtxtFileName).val("");
     
        //Ended by Parth Godshelwar
        return isValidTypeExeCheckFlag;
    }



    //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not




</script>

    
</html>
