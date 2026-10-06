<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_UnCategorizedRequestList.aspx.vb" Inherits="PbNIT.CRM_UnCategorizedRequestList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" /> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />-->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" /> 
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
   
</head>

<style>
    .fadownLoad {
        transform: rotate(270deg);
        color: #2e90e6 !important;
        font-size: 16px;
        margin-left:0px!important;
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
        padding: 3px;
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
        height: 300px;
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
        content: "\f002";
        font-family: FontAwesome;
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
        width: 510px;
        height: 370px;
    }

    #id03 .container {
        width: 450px;
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
        padding: 10px 8px !important;
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

    .panel-title a {
        font-size: 15px;
        padding-top: 3px !important;
    }

    .panel-heading h3 {
        font-size: 15px;
        padding-top: 3px !important;
    }

    div#headingOne {
        height: 40px;
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
        }

        #PageList .badge {
            float: right;
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
        background-color: grey!important;
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
        float: right !important;
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
        background-color: #fefefe;
        margin: 5% auto 15% auto;
        border: 1px solid #888;
        width: 618px !important;
        height: 257px !important;
    }


    .imgFeedback {
        /* background-color:#364660!important;*/
        color: white !important;
    }

    #divfeedback {
        width: 94% !important;
    }

    .tblfeedback {
        width: 94% !important;
    }

        .tblfeedback tr td {
            width: 22% !important;
            border-left: none;
            text-align: left;
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
        display: none;
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
        margin: auto;
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

    .multi-action {
        padding-left: 50px;
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
        overflow: hidden;
    }

    #divApproveRejectValidationMsg, #divPickupLabelAndGrid {
        overflow: auto;
        width: 109% !important;
        padding-right: 5%;
    }

        #divApproveRejectValidationMsg:hover, #divPickupLabelAndGrid:hover {
            /*overflow: auto !important;*/
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
        width: 495px !important;
        margin-left: -8% !important;
    }


    button.btn.btn-default.download {
        margin-right: -6%;
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

    .modal {
        top: -100px;
    }

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

    .modal {
        top: -125px;
    }

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
        border-left: 1px solid #ddd;
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
        width: 488px !important;
        height: 340px !important;
    }

        #id02 .modal-content .container {
            width: 100%;
        }

            #id02 .modal-content .container .col-xs-6 {
                text-align: center;
            }

                #id02 .modal-content .container .col-xs-6 button {
                    margin-left: 65px;
                }

    .un-flag .col-xs-4 {
        width: 66%;
    }

    .un-flag .col-xs-8 {
        width: 33%;
    }

    #cbFlagTo {
        width: 230px !important;
    }

    .multi-action .btn-group.drp .btn {
        margin-left: 0px;
    }

    #ulAction {
        width: 150px !important;
        min-width: auto !important;
    }

        #ulAction li {
            padding-left: 10px;
            /*text-align:center;*/
        }

    /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
    .form-control:-ms-input-placeholder { /* IE 10+ */
        color: #bbb !important;
    }
    .imgcontainer2 {
    height:auto!important;
    }

      /*Added by Usha Pandit on 16.01.2019 for large tooltip display issue*/
     .large.tooltip-inner {
        max-width: 400px !important;
        width: 400px !important;
        max-height: 320px !important;
        height: auto !important;
        margin-top: 30px !important;
        word-break: break-all !important;
    }

      ::-webkit-scrollbar {
        display: none;
    }

        #divGrid, #MainDiv{
        -ms-scrollbar-arrow-color: white !important;
        -ms-scrollbar-base-color: white !important;
        -ms-scrollbar-shadow-color: white !important;
    }
      /*End of Added by Usha Pandit on 16.01.2019 for large tooltip display issue*/

      .panel-default{border-color:#fff}
      .panel-body {padding: 0px;}
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
                    <div id="subMainDiv" class="clsSubMainDiv">
                        <br />
                        <div class="form-info">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="multi-btn">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="multi-drop">
                                        <%If m_blnHRM = True Then%>

                                        <div class="btn-group drp">
                                        </div>
                                        <%End If%>
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
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="panel panel-default">

                                        <div class="panel-body">
                                            <div class="table-responsive">

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
                                                        <li data-toggle="collapse" data-target="#dem1" class="accordion-toggle collapsed">
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
                                                                <button onclick="document.getElementById('id02').style.display='block'" type="button" class="btn btn-default" data-toggle="tooltip" title="Flag"><i class="fa fa-flag-o" aria-hidden="true"></i></button>
                                                            </li>
                                                            <li style="padding-right: 12px;">
                                                                <button type="button" class="btn btn-default" data-toggle="tooltip" title="Discussion"><i class="fa fa-comments-o" aria-hidden="true"><span>4</span></i></button></li>
                                                            <li style="padding-right: 7px;">
                                                                <button onclick="document.getElementById('id03').style.display='block'" type="button" class="btn btn-default" data-toggle="tooltip" title="Attachment">
                                                                    <i class="fa fa-paperclip" aria-hidden="true"></i>
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






            <!-- Bootstrap core JavaScript -->
            <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
            <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
            <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script> -->
            <script src="../../../Whizible2.0-new/dist/js/sb-admin.js"></script>            
            <!-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
            <script src="../../General/CommonFunctions.js"></script>
           <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>  -->

            <script>
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
                })
            </script>
        </div>
    </form>
    <%-- Main From closed frmRequestListNew --%>

    <!-- ----- Approve button---------------------------->
    <div id="id01" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Approve / Reject</span>
                <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close">&times;</span>
            </div>

            <div class="container">
                <div class="appro-form">
                    <span>Approver Comment</span><i class="fa fa-comments-o" aria-hidden="true"></i>
                     <%-- --Added & Commeted By Dipali V On 11th May 2020 For IssueID 24338--%>
                   <%-- <textarea class="form-control" rows="2" id="comment"></textarea>--%>
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

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer2">
                <span class="appro-title">Tracking Details</span>
                <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close">&times;</span>
            </div>

            <div class="container">
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
                    <div class="un-flag">
                        <div class="row">
                            <div class="col-xs-4">

                                <% CommonFunctions.HTMLControls.DrawComboBox("cbFlagTo", "usp_FlagTo_ComboFill", 120, , "class='form-control' ", True, , , , , , 1)%>
                                <%--onblur=""javascript:cbFlagTo_OnBlur()""--%>
                            </div>
                            <div class="col-xs-8" style="padding-right: 0px;">
                                <input type="text" class="form-control" id="dtDueDate" placeholder="Due Date">
                                <i class="fa fa-calendar" onclick="$('#dtDueDate').datepicker();$('#dtDueDate').datepicker('show');"></i>
                                <label style="position: relative; top: -33px; right: -104px;">*</label>
                            </div>


                        </div>
                    </div>
                    <div class="checkbox">
                        <div class="row">
                            <input type="hidden" id="hdnRequestID" name="hdnRequestID" />
                            <input type="hidden" id="hdnFlagUniqueID" name="hdnFlagUniqueID" />
                            <div class="col-xs-3">
                                <input type="checkbox" id="chkComplete" value=""><label>Complete</label>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default" id="btnClearFlag" onclick="ClearFlag();">UnFlag</button>
                            </div>
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-default" onclick="SaveFlag();">Save</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <!--------------------- end Flag icon------------------->

    <!------ Attachment Icon---------------------->
    <div id="id03" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer2">
                <span class="appro-title">Attachments</span>
                <span onclick="document.getElementById('id03').style.display='none'" class="close" title="Close">&times;</span>
            </div>

            <div class="container">
                <div class="attachment">
                    <div class="row">
                        <div class="col-sm-12">
                            <label id="lblRequestIDAttachments">Request ID : </label>
                            <button type="button" id="btnDownloadZip" queryid="001" class="btn btn-default save download" onclick="DownloadZip(this);" title="Download All (Zip)"><i class="fa fa-download" aria-hidden="true"></i>Download All (Zip)</button>
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
                                            <td><i class="fa fa-file-pdf-o" aria-hidden="true"></i></td>
                                            <td>ABD.Txt<i class="fa fa-download" aria-hidden="true"></i></td>
                                            <td>Raj Kumar</td>
                                            <td>30t Aug 2016</td>
                                        </tr>

                                        <tr>
                                            <td><i class="fa fa-file-pdf-o" aria-hidden="true"></i></td>
                                            <td>ABD.Txt<i class="fa fa-download" aria-hidden="true"></i></td>
                                            <td>Raj Kumar</td>
                                            <td>30t Aug 2016</td>
                                        </tr>
                                        <tr>
                                            <td><i class="fa fa-file-pdf-o" aria-hidden="true"></i></td>
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
    <!--End Attachment Icon -->
    <div id="id05" class="modal">

        <form class="modal-content animate" action="/action_page.php" enctype="multipart/form-data" method="post" accept-charset="utf-8">
            <div class="imgcontainer">
                <span class="appro-title">Import (Bulk Request Creation)</span>
                <span onclick="Import_Close();" class="close" title="Close">&times;</span>
            </div>

            <div class="container" id="divImportContainer">
                <div class="import">
                    <div class="row">
                        <div class="col-md-10" id="divDetails">
                            <div class="row">
                                <div id="divFileUploaedBy" class="col-md-12">
                                    <div class="col-md-2" style="margin-right: -32px">
                                        <label id="lblUploadedBy">Uploaded By: </label>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="avatar">
                                            <img id="imgUploaded" class="img-circle" src="<%= strEmployeeImage%>" />
                                            <label id="lblUploadedByName"><%=HttpContext.Current.Session("strUserName")%></label>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div id="divFileUploaed" class="col-md-12">
                                    <div class="col-md-2" style="margin-right: -32px">
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
                                    <input type="file" id="file" name="img[]" class="file" accept=".xls,.xlsx,.XLS,.XLSX" />
                                    <button type="button" id="btnSelectFile" data-toggle="tooltip" title="Upload only .xls,.xlsx File " filecount="0" onclick="SelectFile();" class="btn btn-default save">Upload File</button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <div class="color-box">
                                <div class="shadow">
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
                <span onclick="document.getElementById('id16').style.display='none'" class="close" title="Close">&times;</span>
            </div>
            <div class="container">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="request type">Filter Name</label>
                    <div class="col-sm-8">
                        <%=CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control", , ToBeInserted:="", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                    </div>
                </div>
                <div class="form-group">
                    <div class="right" style="margin-top: 12px;">
                        <button type="button" class="btn btn-default save" id="btnFilterSaveApply" style="" filtermode="Save" onclick="SaveFilter();">Save</button>
                        <button type="button" class="btn btn-default save" style="" onclick="document.getElementById('id16').style.display='none'">Cancel</button>
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
                <span onclick="document.getElementById('id17').style.display='none'" class="close" title="Close">&times;</span>
            </div>
            <div class="container">
                <div class="form-group">
                    <div class="right" style="margin-top: 12px;">
                        <button type="button" class="btn btn-default" style="background-color: #343660; color: #fff;">Save</button>
                        <button type="button" class="btn btn-default" style="background-color: #fff; color: #343660;">Cancel</button>
                    </div>
                </div>
                <div class="form-group">
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
                </div>
            </div>
        </form>
    </div>

    <!-- -----Filter in  Save As button popup---------------------------->
    <div id="id18" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Pickup</span>
                <span onclick="document.getElementById('id18').style.display='none'" class="close" title="Close">&times;</span>
            </div>
            <div class="container" id="divPickupLabelAndGridParent">
                <label class="control-label col-lg12" for="request type" id="pickupValidationMsg">This request will get assigned to you. To proceed click OK. </label>

                <div class="form-group" id="divPickupLabelAndGrid">
                </div>
                <div class="form-group">
                    <div class="right" style="margin-top: 12px;">
                        <button type="button" class="btn btn-default btnAssignPickupRequest" style="background-color: #343660; color: #fff;" onclick="AssignRequestToSelf();">Assign To Me</button>
                        <button type="button" class="btn btn-default" style="background-color: #fff; color: #343660;" onclick="document.getElementById('id18').style.display = 'none'">Cancel</button>
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
                <span onclick="document.getElementById('divRequestor').style.display='none'" class="close" title="Close">&times;</span>
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
                    <span onclick="document.getElementById('divAssignedTo').style.display='none'" class="close" title="Close">&times;</span>
                </div>
                <div id="div4">
                </div>
            </div>
        </form>
    </div>

    <!-- -----FeedBack Parameter Div---------------------------->


    <div id="Feedback" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgFeedback">
                <span><i class='fa fa-thumbs-o-up' aria-hidden='true' style="margin-top: 1.7%; margin-left: 1%"></i></span><span class="appro-title" style="margin-left: 15px!important">FeedBack</span>
                <span onclick="CancelFeedback();" class="close" title="Close">&times;</span>
            </div>

            <div class="container" id="Feedbackdata">
                <%ShowHelpDeskFeedbackDiv()%>
            </div>
        </form>
    </div>
    <!-- -----End of FeedBack Parameter Div---------------------------->

</body>

<script>
    $(function () {
        $("#dtDueDate").datepicker();
    });
</script>
<script>
    var strSelectedRequestsList = new Array();

    var addorButton = false;
    var str = "";
    var count = 0;

    /**********************************Modified By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
    $("#addFilter").click(function () {
        //alert("add filter");
        count = $(".multi-action div.custom-class div.addedrow").length;

        if (addorButton) {

            str = '<div class="row addedrow"><div class="col-md-12"><div class="field-section">';

            //AND OR control
            //str += '<select onchange="changeA(' + count + ', this.value)" class="form-control selct" id="sel1"><option value="AND">AND</option><option value="OR">OR</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboQueryJoinOperator_filterRowCount", "SELECT 'AND' UNION SELECT 'OR' ", , , "onchange=""changeA(filterRowCount, this.value);"" class='form-control selct'", ReturnAsHTML:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);


            //Field Control
            //str += '<select  onchange="changeB(' + count + ', this.value)" class="form-control selct" id="sel1"><option value="Select Field">Select Field</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboField_filterRowCount", "usp_CRM_Fields_ForCombo '" & m_strLoginType & "'," & m_lngEmployeeID & "", 200, , "onchange=""javascript:changeB(filterRowCount, this.value);"" class='form-control selct'", True, True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);

            //Operator Control
            //str += '<select onchange="changeC(' + count + ', this.value)" class="form-control equal" id="sel1"><option value="=">=</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboOperator_filterRowCount", "usp_CRM_Operators_ForCombo", 100, , "onchange=""changeC(filterRowCount, this.value);"" class='form-control equal'", ReturnAsHTML:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);


            //Field Value control
            str += '<span id="spnFilterControl_' + count + '">'
            //str += '<select onchange="changeD(' + count + ', this.value)" class="form-control value" id="sel1"><option value="Value">Value</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawTextBox("FilterControl_filterRowCount", "FilterControl_filterRowCount", "form-control value", 100, ToBeInserted:="onchange=""changeD(filterRowCount, this.value)""", returnHTML:=True, EnableHTMLEncode:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);
            str += '</span>'

            str += '<i class="fa fa-times removethis" aria-hidden="true"></i>'


            str += '<input type="hidden" name="a' + count + '" id="a' + count + '" value="AND">';
            str += '<input type="hidden" name="b' + count + '" id="b' + count + '" value="">';
            str += '<input type="hidden" name="c' + count + '" id="c' + count + '" value="=">';
            str += '<input type="hidden" name="d' + count + '" id="d' + count + '" value="">';

            str += '</div></div></div>'



        } else {

            str = '<div class="row addedrow"> <div class="col-md-12"><div class="field-section field-sec1">';

            //Field Control
            //str += '<select  onchange="changeB(' + count + ', this.value)" class="form-control selct" id="sel1"><option value="Select Field">Select Field</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboField_filterRowCount", "usp_CRM_Fields_ForCombo '" & m_strLoginType & "'," & m_lngEmployeeID & "", 200, , "onchange=""changeB(filterRowCount, this.value);"" class='form-control selct'", True, True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);

            //Operator Control
            //str += '<select onchange="changeC(' + count + ', this.value)" class="form-control equal" id="sel1"><option value="=">=</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'
            str += '<%=CommonFunctions.HTMLControls.DrawComboBox("cboOperator_filterRowCount", "usp_CRM_Operators_ForCombo", 100, , "onchange=""changeC(filterRowCount, this.value);"" class='form-control equal'", ReturnAsHTML:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);

            //Filed Value control
            str += '<span id="spnFilterControl_' + count + '">'
            //str += '<select onchange="changeD(' + count + ', this.value)" class="form-control value" id="sel1"><option value="Value">Value</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>'

            str += '<%=CommonFunctions.HTMLControls.DrawTextBox("FilterControl_filterRowCount", "FilterControl_filterRowCount", "form-control value", 100, ToBeInserted:=" onchange=""changeD(filterRowCount, this.value)""", returnHTML:=True, EnableHTMLEncode:=True).Replace("'", "\'")%>'.replace(/filterRowCount/g, count);
            str += '</span>'

            str += '<i class="fa fa-times removelast" aria-hidden="true" style="cursor:pointer;margin-left:60px;"></i>'

            str += '<input type="hidden" name="b' + count + '" id="b' + count + '" value="">';
            str += '<input type="hidden" name="c' + count + '" id="c' + count + '" value="=">';
            str += '<input type="hidden" name="d' + count + '" id="d' + count + '" value="">';

            str += '</div></div></div>'



            addorButton = true;

        }

        $("div.multi-action div.custom-class").append(str);


    });
    /**********************************End of Modified By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/

    $('div.custom-class').on('click', 'i.removethis', function (e) {
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
        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();
        var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/RemoveFilter", JSON.stringify({ strFilterID: "1" }), false);
        RefreshGrid(strMode, PageNumber, "LoadFilter");
        //Added By Bharat T for Clear the applied load filter filter
    });

    /**********************************Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
    var FilterApplyWithoutSaveFlag = false;
    $("#applybutton").click(function () {
        count = $(".multi-action div.custom-class div.addedrow").length;
        var output = "";
        var a = "", b = "", c = "", d = "";


        for (var i = 0; i < count; i++) {
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
        if (d != '' && d != null && d != undefined) {
            //alert(output);

            var strLoadFilterQueryText = $("#hdnLoadFilterQueryText").val();

            if (strLoadFilterQueryText != "") {
                output += " And (" + strLoadFilterQueryText + ") "
            }

            $("#hdnFilterQuery").val(output);
            var PageNumber = document.getElementById("hdnCurrentPage").value;
            var strMode = $("#hdnMode").val();

            FilterApplyWithoutSaveFlag = true;
            RefreshGrid(strMode, PageNumber, "ApplyWithoutSave");
        } else {

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please form a query.', 'error');
        }

    });
    function SaveFilterAsClick() {
        count = $(".multi-action div.custom-class div.addedrow").length;
        var output = "";
        var a = "", b = "", c = "", d = "";


        for (var i = 0; i < count; i++) {
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
        if (d != '' && d != null && d != undefined) {
            document.getElementById('id16').style.display = 'block';
            $('#btnFilterSaveApply').attr('FilterMode', 'SAVE');
        } else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please form a query.', 'error');
        }

    }

    function SaveFilter() {
        count = $(".multi-action div.custom-class div.addedrow").length;
        var output = "";
        var a = "", b = "", c = "", d = "";
        var FilterName = $("#txtFilterName").val();
        var savedFilterID = 0;
        var SaveFlag = $("#btnFilterSaveApply").attr("FilterMode");

        for (var i = 0; i < count; i++) {
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
        if (d != '' && d != null && d != undefined) {
            var strResult, data;
            var strLoadFilterQueryText = $("#hdnLoadFilterQueryText").val();

            if (strLoadFilterQueryText != "") {
                output += " And (" + strLoadFilterQueryText + ") "
            }

            data = JSON.stringify({ FilterQuery: output, FilterName: FilterName });
            strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/SaveFilter", data, false);

            if (strResult.d != '') {
                var arrResult = strResult.d.split("##");

                if (arrResult[0] == "error") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(arrResult[1], 'error');
                    return;
                }
                else {
                    savedFilterID = arrResult[1];
                }

                $("#txtFilterName").val("");
            }
            //console.log(strResult);

            var strResult1 = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetLoadFilterValues", JSON.stringify({}), false);

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

    function SaveFilterAndApply() {
        count = $(".multi-action div.custom-class div.addedrow").length;
        var output = "";
        var a = "", b = "", c = "", d = "";


        for (var i = 0; i < count; i++) {
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
        if (d != '' && d != null && d != undefined) {
            document.getElementById('id16').style.display = 'block';
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
        data = JSON.stringify({ ControlName: val, count: count });
        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetFilterControl", data, false);

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

    $(".dropdown-menu:not(#PageList) li a").click(function () {
        var selText = $(this).text();
        $(this).parents('.btn-group').find('.dropdown-toggle').html(selText + ' <span class="caret"></span>');
    });

    $("#PageList li.dropdown-item a").click(function () {
        var strMode = $(this).attr("Mode");

        //$("#hdnLoadFilterID").val("");			           

        if (strMode != 'RBS' && strMode != 'RBT') {

            var hdnLoadFilterID = $("#hdnLoadFilterID").val();
            $(".btnLoadFilter").parent().css("pointer-events", "");

            var strResult, data, strFilterID;

            if ((strMode == "RFA" || strMode == "RAR") && hdnLoadFilterID != "" && hdnLoadFilterID != "0") {
                data = JSON.stringify({ FilterID: hdnLoadFilterID, PageMode: strMode });
                strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetFilterQuery", data, false);

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
            var PageNumber = document.getElementById("hdnCurrentPage").value;

            RefreshGrid(strMode, PageNumber, "");

            IsDefaultFilter = "False";
        }
        else {
            $(".liRequestByST").show();
            $(".clsPageName").text($(this).text());

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

            var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetSerachFilterControl", JSON.stringify({ FieldType: FieldType }), false);
            //  console.log(FieldType);

            $(".clsFilterName").attr("FilterName", FieldType);

            if (strResult.d != '') {
                $("li.clsSerachControl").html(strResult.d);

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
            //$("#filterSpan").text("");
            $("#filterSpan").text("");
            $(".clsFilterName").attr("FilterName", "");
            $("li.clsSerachControl").html("<input type='text' class='form-control clsSearchAllBox' placeholder='Search for...'>");
        }
    }

    function LoadFilterClick(object, LoadFilterFlag) {

        var strResult, data, strFilterID;

        if (object.id.indexOf("savedID_") >= 0) {
            strFilterID = object.id.split("savedID_")[1];
        }
        else {
            strFilterID = object.id;
        }

        data = JSON.stringify({ FilterID: strFilterID, PageMode: $("#hdnMode").val() });
        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetFilterQuery", data, false);

        if (strFilterID == "") {
            $("#LoadFilterQueryText").html("");
            $("#hdnLoadFilterQueryText").val("");
            $("#AppliedFilterDiv").hide();
        }
        else {

            if (strResult.d != "") {
                $("#LoadFilterQueryText").text($(object).text());
                $("#LoadFilterQueryText").parent().attr("data-toggle", "tooltip");
                $("#LoadFilterQueryText").parent().attr("title", strResult.d);
                $("#hdnLoadFilterQueryText").val(strResult.d);
                $("#AppliedFilterDiv").show();
                //$('[data-toggle="tooltip"]').tooltip();
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
    }

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
            case "Priority":
                objectControl = document.getElementById("cboPriority");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " PriorityID = " + objectControl.value;

                break;
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
            case "Severity":

                objectControl = document.getElementById("cboSeverity");

                if (objectControl != null && objectControl.value != '')
                    m_AdvanceFilter = " SeverityID  = " + objectControl.value;
                break;
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

        var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/RefreshGrid", JSON.stringify({ GridParameter: GridParameter }), false);
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

            for (var h = 0; h <= strSelectedRequestsList.length; h++) {
                var objectCheck = document.getElementById("chkSelect_" + strSelectedRequestsList[h]);

                if (objectCheck != null) {
                    objectCheck.checked = true;
                }
            }

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

                if ($(this).html().indexOf("fa-flag-o") > 0 || $(this).html().indexOf("fa-comments-o") > 0 || $(this).html().indexOf("fa-paperclip") > 0 || $(this).html().indexOf("fa-pencil-square-o") > 0 || $(this).html() == "" || $(this).html().indexOf("checkbox") > 0) {

                }
                else {
                    if (typeof $(this).attr("isdatecolumn") != "undefined") {
                        $(this).attr("onclick", "sortTable('tblRequestList'," + count + ",'DateColumn');");
                        //$(this).attr("onclick", "sortByDate(" + count + ");");

                    }
                    else {
                        $(this).attr("onclick", "sortTable('tblRequestList'," + count + ",'');");
                    }

                }

                //$('body').tooltip({
                //    selector: '.divGrid'
                //});

                //Commented and Added by Usha Pandit on 16.01.2019 for large tooltip display issue
                //$("[data-toggle='tooltip']").tooltip();

                $('.tt_large').tooltip({
                    template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                });
                //End of Added by Usha Pandit on 16.01.2019 for large tooltip display issue

            });

            //var $header = $("#divGrid > table > thead").clone();
            //var $fixedHeader = $("#header-fixed").append($header);

            $("#MainDiv").scroll(function () {
                var offset = $(this).scrollTop();
                if ($fixedHeader != undefined) {
                    if (offset >= tableOffset && $fixedHeader.is(":hidden")) {
                        $fixedHeader.show();
                        $("#clsFilterLinks").css("position", "fixed");
                        $("#clsFilterLinks").css("width", "97%");
                        //if (WhichBrowser() != 'IE') {
                        //    $fixedHeader.css("margin-top", "61px");
                        //}
                        //else {
                        //    $fixedHeader.css("margin-top", "66px");
                        //}
                    }

                    else if (offset < tableOffset) {
                        $("#clsFilterLinks").css("width", "");
                        $("#clsFilterLinks").css("position", "");
                        $fixedHeader.hide();
                    }
                }
               
                //$("#clsFilterLinks").css("top", offset + 'px');
            });

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
            alertify.notify('Please select at least one filter from the list', 'error');
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
        var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/SaveSearchFilter", data, false);


        RefreshGrid(strMode, PageNumber, "GoClick");

        //setTimeout(function () { RemoveFrameLoader(); }, 1000);

    });

    $(".btnRefresh").click(function () {

        setFrameLoader();
        
        window.location.href = "CRM_UnCategorizedRequestList.aspx?Mode=SR";
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
        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/ApproveRejectRequest", data, false);

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
         //Added By Dipali V On 2nd June for Refresh grid after approve Req
           //window.location.href = "CRM_RequestListNew.aspx?Mode=SR";
            setTimeout(function () {
                $(".btnRefresh").trigger("click");
            }, 3000);
         //End of Added By Dipali V On 2nd June for Refresh grid after approve Req

        }

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
    $('.modal').draggable({ delay: 200, iframeFix: true });
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
    $('.modal').draggable({ delay: 200, iframeFix: true });
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
    $('.modal').draggable({ delay: 200, iframeFix: true });
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
    $('.modal').draggable({ delay: 200, iframeFix: true });
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
    $('.modal').draggable();
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
    $('.modal').draggable();
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
    $('.modal').draggable();
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

        var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetSerachFilterValues", JSON.stringify({ Mode: strMode }), false);

        if (strResult.d != '') {
            $("#seachValueList").html(strResult.d);
        }

        var strResult1 = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetLoadFilterValues", JSON.stringify({}), false);


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
    });
    var tableOffset;
    var $fixedHeader;
    var $header;

    $(window).load(function () {

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

        //if (strFilterName != '' && strFilterName != '0' && strFilterValue != '0'){

        //    //document.getElementById(strFilterName).click();
        //}
        //if (strFilterName.toUpperCase() == "PRIORITY") {
        //    document.getElementById("cboPriority").value = strFilterValue;
        //} else if (strFilterName.toUpperCase() == "ASSIGNED TO") {
        //    document.getElementById("cboAssignedTo").value = strFilterValue;
        //} else if (strFilterName.toUpperCase() == "CUSTOMER") {
        //    document.getElementById("cboCustomer").value = strFilterValue;
        //} else if (strFilterName.toUpperCase() == "EMPLOYEE") {
        //    document.getElementById("cboEmployee").value = strFilterValue;
        //} else if (strFilterName.toUpperCase() == "LOCATION") {
        //    document.getElementById("cboLocation").value = strFilterValue;
        //} else if (strFilterName.toUpperCase() == "REQUEST TYPE") {
        //    document.getElementById("cboRequestType").value = strFilterValue;
        //} else if (strFilterName.toUpperCase() == "SUB REQUEST TYPE") {
        //    document.getElementById("cboSubRequestType").value = strFilterValue;
        //} else if (strFilterName.toUpperCase() == "SUBJECT") {
        //    document.getElementById("txtSubject").value = strFilterValue;
        //} else if (strFilterName.toUpperCase() == "SEVERITY") {
        //    document.getElementById("cboSeverity").value = strFilterValue;
        //} else if (strFilterName.toUpperCase() == "REQUEST ID") {
        //    document.getElementById("txtRequestID").value = strFilterValue;
        //}

        //var objLoadFilterAnchor = $(".clsLoadFilterList a#" + strLoadFilterID);

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
        //var strCountResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetRequestCounts", JSON.stringify({}), false);
        
        //if (strCountResult.d != "") {
        //    var arrstrCountResult = strCountResult.d.split("$$");

        //    if ($("#spnAll").length > 0)
        //        $("#spnAll").text(arrstrCountResult[0]);

        //    if ($("#spnSR").length > 0)
        //        $("#spnSR").text(arrstrCountResult[1]);

        //    if ($("#spnMR").length > 0)
        //        $("#spnMR").text(arrstrCountResult[2]);

        //    if ($("#spnFR").length > 0)
        //        $("#spnFR").text(arrstrCountResult[3]);

        //    if ($("#spnRFA").length > 0)
        //        $("#spnRFA").text(arrstrCountResult[4]);

        //    if ($("#spnRAR").length > 0)
        //        $("#spnRAR").text(arrstrCountResult[5]);
        //}


        if (arrPageFlag.indexOf(strNewFilterID) >= 0) {
            $("#chk" + strNewFilterID).prop("checked", true);
            $("#chk" + strNewFilterID).parent().addClass("clsFilterDefault");

            var attr = $("#PageList").find(".clsFilterDefault").find("a").attr('mode')

            if (typeof attr !== "undefined" && attr !== false) {

                $("#hdnMode").val($("#PageList li.clsFilterDefault a").attr("mode"));
                $(".clsPageName").text($("#PageList").find(".clsFilterDefault").find("a").text());
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

        }


        tableOffset = $("#tblRequestList").offset().top;
        $header = $("#divGrid > table > thead").clone();
        $fixedHeader = $("#header-fixed").append($header);

        $("#MainDiv").scroll(function () {
            var offset = $(this).scrollTop();

            if (offset >= tableOffset && $fixedHeader.is(":hidden")) {
                $fixedHeader.show();
                $("#clsFilterLinks").css("position", "fixed");
                $("#clsFilterLinks").css("width", "97%");
                //if (WhichBrowser() != 'IE') {
                //    $fixedHeader.css("margin-top", "61px");
                //}
                //else {
                    
                //    $fixedHeader.css("margin-top", "66px");
                //}
            }
            else if (offset < tableOffset) {
                $("#clsFilterLinks").css("width", "");
                $("#clsFilterLinks").css("position", "");
                $fixedHeader.hide();
            }
            
            //$("#clsFilterLinks").css("top", offset + 'px');
        });

        $("[data-toggle='tooltip']").tooltip();
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
        objForm.action = "../../CRM/CRM_ShowReport.aspx?Mode=EXPORT&Format=" + sFormat + "&Title=" + title;
        objForm.submit();
    }

    function Flag_OnClick(RequestID) {
        var strResult, data;

        $("#hdnRequestID").val(RequestID);

        $("#spnRequestID").html(RequestID);

        data = JSON.stringify({ RequestID: RequestID });
        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetFlagDetails", data, false);

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
    }

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
        if ($("#dtDueDate").val() == "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select due date.', 'error');
            return;
        }
            //Added By Aniruddh Gujar on 21-Dec-2017 Purpose::To validate the Due date
        else{
            var url = 'CRM_UnCategorizedRequestList.aspx/CheckDueDate';
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
        //End of Added By Aniruddh Gujar on 21-Dec-2017 Purpose::To validate the Due date
        if (objCheckComplete.is(':checked'))
            FlagParameters.IsComplete = "1";
        else
            FlagParameters.IsComplete = "0";

        data = JSON.stringify({ FlagParameters: FlagParameters });

        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/SaveRequestFlag", data, false);

        if (strResult.d == "1") {
            document.getElementById('id02').style.display = 'none';

            var PageNumber = document.getElementById("hdnCurrentPage").value;
            var strMode = $("#hdnMode").val();

            RefreshGrid(strMode, PageNumber, "");
        }
    }

    function ClearFlag() {
        var strResult, data, RequestID, FlagUniqueID;

        RequestID = $("#hdnRequestID").val();
        FlagUniqueID = $("#hdnFlagUniqueID").val();

        data = JSON.stringify({ FlagUniqueID: FlagUniqueID });

        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/ClearRequestFlag", data, false);

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

    var FeedBackQueryID;
    function SaveActivity_OnClick(QueryID) {
        //var ActivityID = GetObjectReference('frmDashboard', 'hidActivityID' + QueryID).value;

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

        if (parseFloat(TotalTodaysTime) + parseFloat(Time) > 24 * 60) {
            //alert('Total minutes in one day should be less than equal to 1440 minutes. \n You can add more ' + (1440 - parseFloat(TotalTodaysTime)) + ' minutes for today.');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Total minutes in one day should be less than equal to 1440 minutes. \n You can add more ' + (1440 - parseFloat(TotalTodaysTime)) + ' minutes for today.', 'error');

            setFocus(GetObjectReference('frmRequestListNew', 'txtTime' + QueryID));
            return;
        }


        var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID=" + StatusID.value + "&Time=" + Time + "&ActivityID=" + ActivityID + "&QueryID=" + QueryID;

        loadXMLDoc(url, '')
        if (Time == '')
            objTime = 0;
        else
            objTime = Time;

        if (GetObjectReference('frmRequestListNew', 'TimeSpent' + QueryID) != null)
            GetObjectReference('frmRequestListNew', 'TimeSpent' + QueryID).setAttribute('TodaysTotalTimeSpent', parseFloat(TotalTodaysTime) + parseFloat(objTime));

    }

    function SubmitOK_Onclick() {
        var objFeedBack = GetObjectReference('frmRequestListNew', 'cboFeedback');
        var objFeedBackComments = GetObjectReference('frmRequestListNew', 'txtFeedbackComments');
        var objFeedBackDiv = GetObjectReference('frmRequestListNew', 'cboFeedbackDiv');
        var objFeedBackCommentsDiv = GetObjectReference('frmRequestListNew', 'txtSubmitCommentsDiv');
        var objDiv = GetObjectReference('frmRequestListNew', 'DivFeedBack');

        if ($("#firstrating").hasClass('checked') || $("#Secondrating").hasClass('checked') || $("#Thirdrating").hasClass('checked') || $("#Foruthrating").hasClass('checked')) {

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
                var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&FeedBackID=" + globalRating + "&FeedBackComment=" + objFeedBackCommentsDiv.value + "&statusID=" + StatusID.value + "&Time=" + Time + "&ActivityID=" + ActivityID + "&QueryID=" + QueryID;

            }
            else {
                var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID=" + StatusID.value + "&Time=" + Time + "&ActivityID=" + ActivityID + "&QueryID=" + QueryID;

            }
            if (Time == '')
                objTime = 0;
            else
                objTime = Time;
            GetObjectReference('frmRequestListNew', 'TimeSpent' + QueryID).setAttribute('TodaysTotalTimeSpent', parseFloat(TotalTodaysTime) + parseFloat(objTime));
        }
        else {
            if (SaveFeedBack == 1) {
                var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&FeedBackID=" + globalRating + "&FeedBackComment=" + objFeedBackCommentsDiv.value + "&statusID=" + StatusID.value + "&QueryID=" + QueryID;

            }
            else {
                var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID=" + StatusID.value + "&QueryID=" + QueryID;
            }
        }
        loadXMLDoc(url, '')
    }

    function AssignToMe_onClick(QueryID) {
       // debugger;
       // var url = "../../CRM/CRM_XMLHttp.aspx?FromXML=1&Action=Assign&QueryID=" + QueryID;
          var url = "CRM_XMLHttp_Helpdesk.aspx?FromXML=1&Action=Assign&QueryID=" + QueryID;
        //window.location.href = url;
        loadXMLDoc(url, QueryID)
           


    }
    function loadXMLDoc(url, reqQuery) {

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

          //Added By Dipali V On 11th May 2020
         window.location.href = "CRM_UnCategorizedRequestList.aspx?Mode=SR";
       
          //End of Added By Dipali V On 11th May 2020
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
        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GetAttachmentGrid", data, false);

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
        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/GenerateZipFile", data, false);

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
            //strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/ValidateSelectedRequestsIDs", data, false);

            data = JSON.stringify({ strQueryIDList: strQueryIDList, Flag: "APPROVEREJECT" });
            strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/ValidateRequestsAndGetDataForApproval", data, false);


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
            //strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/ValidateSelectedRequestsIDs", data, false);

            data = JSON.stringify({ strQueryIDList: strQueryIDList, Flag: "PICKUP" });
            strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/ValidateRequestsAndGetPickupData", data, false);

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

        data = JSON.stringify({ strQueryIDList: strQueryIDList });
        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/AssignToSelf", data, false);

        if (strResult.d == '') {
            $("input[name=chkPickupIDs]:checked").map(function () {
                var objAssignTo = GetObjectReference('', 'AssignTo' + this.value);

                objAssignTo.innerHTML = '<B><FONT color=red>Assigned To me</FONT></B>';

                document.getElementById('id18').style.display = 'none';
            });

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Request assigned successfully!', 'success');
        }
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
            strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/AssignToEmployee", data, false);

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
       // alert();
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

        //  window.open("CRM_RequestDetailsNew.aspx?Mode=EDIT&FromWhere=DB&PageNumber=<%=m_intPageNumber%>&QueryID=" + queryid + "&QueryEditAccess=" + HasAccess, "_requestdetail", "resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700");
        window.location.href = "../Request/CRM_RequestDetails_UnCategorised.aspx?Mode=EDIT&FromWhere=DB&PageNumber=" + PageNumber + "&PageFlag=" + strMode + "&LoadFilterID=" + LoadFilterID + "&StatusFilterID=" + strStatusFilterID + "&DateFilterID=" + strDateFilterID + "&QueryID=" + queryid + "&QueryEditAccess=" + HasAccess;

    }


    function SetDefault_SavedFilter(FilterID) {
        var strResult, data;
        var dataParameter = {};
        dataParameter.FilterID = FilterID;
        dataParameter.FilterFlag = "DefaultFilter_RequestListNewPage";
        var arrPageFlag = ["DefaultSR", "All", "MR", "FR", "RFA", "RAR"];


        data = JSON.stringify({ dataParameter: dataParameter });
        strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/SetDefaultFilter", data, true);

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
        var url = "CRM_UnCategorizedRequestList.aspx/PlotRequestorDetails"
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
        var url = "CRM_UnCategorizedRequestList.aspx/PlotRequestorDetails"
        data = JSON.stringify({ QueryID: QueryID, RequestorType: RequestorType });
        var strResult = AJAXCallWithResult(url, data, false);
    }

    //Added By Vidya Jadhav ON 30 Oct 2017 For Import Functionality


    //function ShowImportDetails() {
    //    //   alert();
    //    var url = "CRM_UnCategorizedRequestList.aspx/GetImportDetails"
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
        if (PrevSortColumn == "" || PrevSortColumn != n + 1) {
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

        PrevSortColumn = n + 1;


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
            for (i = 0; i < (rows.length -1) ; i++) {
                //start by saying there should be no switching:
                shouldSwitch = false;
                /*Get the two elements you want to compare,
                one from current row and one from the next:*/


                //x = rows[i].getElementsByTagName("TD")[n];
                //y = rows[i + 1].getElementsByTagName("TD")[n];

                x = rows[i].getElementsByTagName("TD")[n];
                y = rows[i + 1].getElementsByTagName("TD")[n];


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
                        if (n!=0){
                            if (x.innerText.replace(/[\n\t\r]/g, "").toLowerCase() > y.innerText.replace(/[\n\t\r]/g, "").toLowerCase()) {
                                //if so, mark as a switch and break the loop:
                                shouldSwitch = true;
                                break;
                            }
                        }
                        else
                        {
                            if (parseInt(x.innerText.replace(/[\n\t\r]/g, "").toLowerCase()) > parseInt(y.innerText.replace(/[\n\t\r]/g, "").toLowerCase())) {
                                //if so, mark as a switch and break the loop:
                                shouldSwitch = true;
                                break;
                            }
                        }
                    } else if (dir == "desc") {
                        if (n!=0){
                            if (x.innerText.replace(/[\n\t\r]/g, "").toLowerCase() < y.innerText.replace(/[\n\t\r]/g, "").toLowerCase()) {
                                //if so, mark as a switch and break the loop:
                                shouldSwitch = true;
                                break;
                            }
                        }
                        else{
                            if (parseInt(x.innerText.replace(/[\n\t\r]/g, "").toLowerCase()) < parseInt(y.innerText.replace(/[\n\t\r]/g, "").toLowerCase())) {
                                //if so, mark as a switch and break the loop:
                                shouldSwitch = true;
                                break;
                            }
                        }
                    }
                }
            }
            if (shouldSwitch) {
                /*If a switch has been marked, make the switch
                and mark that a switch has been done:*/
                //rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);

                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
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
            //$('body').tooltip({
            //    selector: '.divGrid'
            //});

            if (colHeaderText.length > 18) {
                strShortHeaderName = colHeaderText.substr(0, 18);


                $(this).text(strShortHeaderName + "..");
            }

            if ($(this).html().indexOf("fa-flag-o") > 0 || $(this).html().indexOf("fa-comments-o") > 0 || $(this).html().indexOf("fa-paperclip") > 0 || $(this).html().indexOf("fa-pencil-square-o") > 0 || $(this).html() == "" || $(this).html().indexOf("checkbox") > 0) {

            }
            else {
                if (typeof $(this).attr("isdatecolumn") != "undefined") {
                    $(this).attr("onclick", "sortTable('tblRequestList'," + count + ",'DateColumn');");
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

        $("[data-toggle='tooltip']").on('click', function () {
            $(".tooltip").removeClass("in");
        });

        //Commented and Added by Usha Pandit on 16.01.2019 for large tooltip display issue
        //$("[data-toggle='tooltip']").tooltip();       
        
        $('.tt_large').tooltip({
            template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
        });
        //End of Added by Usha Pandit on 16.01.2019 for large tooltip display issue


        //$('body').tooltip({
        //    selector: "[data-toggle='tooltip']",
        //    trigger: 'hover'
        //});
    });



    //Added By Vidya Jadhav ON 30 Oct 2017 For Import Functionality


    function ShowImportDetails(obj) {
        //   alert();
        //Added by Yogesh Jalamkar on 28-NOV-2017 Purpose: To hide tooltip on click
        $('.tooltip').fadeOut('fast', function () {
            $('.tooltip').remove();
        });
        //End of addition by Yogesh Jalamkar
        var url = "CRM_UnCategorizedRequestList.aspx/GetImportDetails"
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

                var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/SaveExcelConfiguration", data, false);
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
    $(document).on('change', '.file', function () {
        // debugger;
        // $("#file").change(function () {
        //   debugger;
        //$(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
        // fileObjects = fileObject[0];
        //  document.getElementById('lblAttachmentName').innerHTML = $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
        $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
        // fileObjects = fileObject[0];
        var objtxtFileName = document.getElementById('file');

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
        if (typeof fileObject != "undefined") {
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
    });
    function SelectFile() {
        var strFileCount = $("#btnSelectFile").attr("FileCount");
        var objCurrentFileControl = $("#file");

        objCurrentFileControl.click();


    }
    function ImportOnclick() {
        //   debugger;
        var strURL = "CRM_UnCategorizedRequestList.aspx";

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
    //        var strURL = "CRM_UnCategorizedRequestList.aspx";

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
    //                        var strResult1 = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/ValidateAndSave", data1, false);
    //                    }
    //                    //alert(AttachmentID);

    //                    var data = JSON.stringify({ AttachmentID: AttachmentID });
    //                    var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/UploadData", data, false);

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

    //        var strURL = "CRM_UnCategorizedRequestList.aspx";

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

    //                        //var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/UploadData", data, false);

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
    }


    function ValidateExcel_Onclick() {
        ValidateClicked = 1;




        if (SaveExcelConfiguration() == 1) {

            var strURL = "CRM_UnCategorizedRequestList.aspx";

            var strAttachmentID = document.getElementById('hdnAttachmentID').value;
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
            if (typeof fileObject !== "undefined") {
                if (fileObject[0].name.indexOf(".xls") > 0 || fileObject[0].name.indexOf(".xlsx") > 0) {
                    ValidateClicked = 1;
                    setFrameLoader();
                    var url = "CRM_UnCategorizedRequestList.aspx/ValidateExcelToSelect"
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

                        //var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/UploadData", data, false);

                        //if (strResult.d == "1") {

                        //}
                        //    datatables('tblFileDetails');

                        var ValidRows = $("#hdnvalidRowCount").val();
                        var InValidRows = $("#hdnInvalidRowCount").val();
                        var strMsg = ""
                        if (ValidRows != "" || InValidRows != "") {
                            strMsg += "<li>Valid Requests: " + ValidRows + "</li>"
                            strMsg += "<li>Invalid Requests: " + InValidRows + "</li>"


                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("<ul>" + strMsg + "</ul>", 'error');
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
            //  var strURL = "CRM_UnCategorizedRequestList.aspx";

            var strAttachmentID = document.getElementById('hdnAttachmentID').value;
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
                        var url = "CRM_UnCategorizedRequestList.aspx/ValidateExcelToImport"
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

                            var data = JSON.stringify({ AttachmentID: AttachmentID });
                            var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/UploadData", data, false);


                            var ValidRows = $("#hdnvalidRowCount").val();
                            var InValidRows = $("#hdnInvalidRowCount").val();
                            var strMsg = ""
                            if (ValidRows != "" && InValidRows != "") {
                                strMsg += "<li>Valid Requests: " + ValidRows + "</li>"
                                strMsg += "<li>Invalid Requests: " + InValidRows + "</li>"

                                // alertify.set('notifier', 'position', 'top-right');


                            }
                            strMsg += "<li> Requests are imported successfully </li>";
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("<ul>" + strMsg + "</ul>", 'error');
                            document.getElementById('id05').style.display = 'none';
                            //  window.location.href = "CRM_UnCategorizedRequestList.aspx?Mode=SR";


                            var objForm = document.getElementById("frmRequestListNew");
                            objForm.action = "CRM_UnCategorizedRequestList.aspx?Mode=SR";
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
                        var strResult1 = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/ValidateAndSave", data1, false);

                        //alert(AttachmentID);

                        var data = JSON.stringify({ AttachmentID: AttachmentID });
                        var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/UploadData", data, false);


                        // datatables('tblFileDetails');
                        var ValidRows = $("#hdnvalidRowCount").val();
                        var InValidRows = $("#hdnInvalidRowCount").val();
                        var strMsg = ""
                        if (ValidRows != "" && InValidRows != "") {
                            strMsg += " Valid Requests: " + ValidRows
                            strMsg += " Invalid Requests: " + InValidRows
                            // alertify.set('notifier', 'position', 'top-right');


                        }
                        strMsg += "<li>Requests are imported successfully</li>";
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("<ul>" + strMsg + "</ul>", 'error');
                        document.getElementById('id05').style.display = 'none';
                        //  window.location.href = "CRM_UnCategorizedRequestList.aspx?Mode=SR";
                        var objForm = document.getElementById("frmRequestListNew");
                        objForm.action = "CRM_UnCategorizedRequestList.aspx?Mode=SR";
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
        var url = "CRM_UnCategorizedRequestList.aspx/ClearConfiguration"
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
    function Putrating(Rating) {
        //  alert(Rating);

        if (Rating == 1)//Satisfactory
        {
            if ($("#firstrating").hasClass('checked')) {
                $("#firstrating").removeClass('checked');
                $("#Secondrating").removeClass('checked');
                $("#Foruthrating").removeClass('checked');
                $("#Thirdrating").removeClass('checked');

                $("#SpnRatingMsg").html("")
                //  $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
            }
            else {
                $("#firstrating").addClass('checked')
                $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
            }


            $("#SpnRatingMsg").css("color", "red");
            globalRating = $('#Ratingone').val();
        }
        else if (Rating == 5)//Fair
        {
            // $("#SpnRatingMsg").css("color","Green");

            if ($("#Secondrating").hasClass('checked')) {
                $("#Secondrating").removeClass('checked')
                $("#Foruthrating").removeClass('checked')
                $("#Thirdrating").removeClass('checked')
                $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color", "red");
            }
            else {
                $("#Secondrating").addClass('checked')
                $("#firstrating").addClass('checked')
                $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color", "red");
            }


            globalRating = $('#Ratingtwo').val();
        }
        else if (Rating == 8)//Good
        {
            if ($("#Thirdrating").hasClass('checked')) {

                //$("#firstrating").removeClass('checked')
                $("#Foruthrating").removeClass('checked')
                $("#Thirdrating").removeClass('checked')
                $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color", "red");

            }
            else {
                $("#firstrating").addClass('checked')
                $("#Secondrating").addClass('checked')
                $("#Thirdrating").addClass('checked')
                $("#SpnRatingMsg").html("Thank You ! looking to serve you better")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color", "Green");
            }


            globalRating = $('#Ratingthree').val();
        }

        else if (Rating == 10)//Excellent
        {
            if ($("#Foruthrating").hasClass('checked')) {

                //$("#firstrating").removeClass('checked')
                //$("#Secondrating").removeClass('checked')
                // $("#Thirdrating").removeClass('checked')
                $("#Foruthrating").removeClass('checked')
                $("#SpnRatingMsg").html("Thank You! looking to serve you better")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color", "Green");
            }
            else {
                $("#Foruthrating").addClass('checked')
                $("#Thirdrating").addClass('checked')
                $("#Secondrating").addClass('checked')
                $("#firstrating").addClass('checked')
                $("#SpnRatingMsg").html("Thank You! looking to serve you better")
                $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                $("#SpnRatingMsg").css("color", "Green");
            }


            globalRating = $('#RatingFour').val();
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

    function SelectAllRequests() {
        if ($("#chkSelectHeader").is(":checked")) {
            $("input[name=chkSelect]").not(":disabled").prop("checked", true);

            $("input[name=chkSelect]").map(function () {
                if (strSelectedRequestsList.indexOf(this.value) === -1) {
                    strSelectedRequestsList.push(this.value);
                }
            });
        }
        else {
            $("input[name=chkSelect]").prop("checked", false);

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
    }

    function removeArrayElement(array, element) {
        var index = array.indexOf(element);

        if (index !== -1) {
            array.splice(index, 1);
        }
    }

    function ClearAdvanceFilter() {

        var ajaxParameter = {};
        var strSearchType;
        var objectControl;

        $(".clsFilterName").attr("filtername", "");

        ajaxParameter.SearchFilterName = "";
        ajaxParameter.SearchFilterValue = "";

        var data = JSON.stringify({ ajaxParameter: ajaxParameter });
        var strResult = AJAXCallWithResult("CRM_UnCategorizedRequestList.aspx/SaveSearchFilter", data, false);

        setFrameLoader();
        var PageNumber = document.getElementById("hdnCurrentPage").value;
        var strMode = $("#hdnMode").val();

        SerachFilterList_Click('');

        RefreshGrid(strMode, PageNumber, "");

        setTimeout(function () { RemoveFrameLoader(); }, 1000);
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

        //Commented and Added by Usha Pandit on 16.01.2019 for large tooltip display issue

        //setTimeout(function () { setWidth(); $("[data-toggle='tooltip']").tooltip(); }, 500);       
           
        setTimeout(function () { setWidth();  $('.tt_large').tooltip({
            template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
        }); }, 500);   
       

        //End of Added by Usha Pandit on 16.01.2019 for large tooltip display issue
    })
</script>
</html>
