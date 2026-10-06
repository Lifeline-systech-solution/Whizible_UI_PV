<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_CompanyInformation.aspx.vb" Inherits="PbNIT.CRM_CompanyInformation" %>

<!DOCTYPE html>

<html lang="en">
    <%CommonFunctions.General.PlotPageHeadTag("")%>
<head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="">

    <%'Whizible.clsCommonFunctions.PlotPageHeadTag("Company Information")%>

    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" type="text/css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css">
   <%-- <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

</head>
    
    <style>
          /*Added By Yasmin on 27th july 2018*/

   .ui-tooltip {
      
    padding: 0;
    left:10px!important;
  
	        position: absolute;
	        z-index: 9999;
	        max-width: 300px;
            background: #000 !important;
            color: #fff !important;
	        -webkit-box-shadow: 0!important;
	        box-shadow: 0 !important;
            border:none!important;
            font-size:11.5px!important;
}
.ui-tooltip-content {
    position: relative;
    padding: 0.3em;
}
.ui-tooltip-content::after, .ui-tooltip-content::before {
    content: "";
    position: absolute;
    border-style: solid;
    display: block;
    left: 40px;
}
.bottom .ui-tooltip-content::before {
    bottom: -10px;
    border-color: #000 transparent;
    border-width: 10px 10px 0;
}
.bottom .ui-tooltip-content::after {
    bottom: -7px;
    border-color: #000 transparent;
    border-width: 10px 10px 0;
}
.top .ui-tooltip-content::before {
    top: -10px;
    border-color: #000 transparent;
    border-width: 0 10px 10px;
}
.top .ui-tooltip-content::after {
    top: -7px;
    border-color: #000 transparent;
    border-width: 0 10px 10px;
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
            color: #4caac0 !important;
            border: none !important;
            text-decoration: underline !important;
        }

        .content-wrapper {
            margin-left: 0px !important;
            padding-left: 0px !important;
        }

        #collapseOne .panel-body {
            OVERFLOW: auto;
            HEIGHT: 246PX;
        }

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

        .clsTRColumnHeader th:nth-child(4) {
            text-align: center;
        }

        .clsTRColumnHeader th:nth-child(5) {
            text-align: center;
        }


        .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }


        .table-responsive {
            overflow: hidden;
        }

        .control-label {
            font-weight: normal !important;
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

        .pagination > .active > span:hover {
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
        }

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

        #divSubRequestType .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        #divSubRequestType .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            /*font-weight: 300;*/
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
            /*font-weight: 300;*/
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

        .fa-pencil-square-o {
            color: #4caac0 !important;
        }

        #DivHelpDeskSLA .dataTables_scroll {
            width: 100% !important;
        }

        #DivHelpDeskSLA .dataTables_scrollBody {
            overflow: auto !important;
            width: 102% !important;
            height: 300px;
            padding-right: 2% !important;
        }

        #idPanelBody {
            overflow: auto;
            height: 175px;
            width: 103%;
            padding-right: 2%;
        }

        #divSubRequestType .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divSubRequestType .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        #divGridSubRequestType .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divGridSubRequestType .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        #DivList table tr td:nth-child(1) {
            width: 25% !important;
        }

        #DivList table tr td:nth-child(2) {
            width: 25% !important;
        }

        #DivList table tr td:nth-child(3) {
            width: 40% !important;
        }

        #divGridSubRequestType .dataTables_scrollHeadInner table .clsTRColumnHeader tr th:nth-child(4) {
            text-align: center;
        }

        #divGridSubRequestType .container-fluid {
            min-height: 0px !important;
        }

        #divStatus .container-fluid {
            min-height: 0px !important;
        }

        #collapseOne2 {
            overflow: hidden;
        }

            #collapseOne2 .panel-body {
                overflow: auto;
                /*height: 150px;*/
                width: 103%;
                padding-right: 2%;
            }

        #collapseOne3 {
            overflow: hidden;
        }

            #collapseOne3 .panel-body {
                overflow: auto;
                /*height: 150px;*/
                width: 103%;
                padding-right: 2%;
            }

        .dataTables_scrollBody .table tbody .even {
            background-color: #e8edf6;
        }

        #divStatus .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divStatus .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        .form-control {
            font-weight: 100;
        }

        #divStatus .dataTables_scrollHeadInner table .clsTRColumnHeader tr th:nth-child(4) {
            text-align: left;
        }

        #divPriority .container-fluid {
            min-height: 0px !important;
        }

        #collapseOne4 {
            overflow: hidden;
        }

            #collapseOne4 .panel-body {
                overflow: auto;
                /*height: 150px;*/
                width: 103%;
                padding-right: 2%;
            }

        #divPriority .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divPriority .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        #divSeverity .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divSeverity .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        #divSeverity .container-fluid {
            min-height: 0px !important;
        }

        #collapseOne5 {
            overflow: hidden;
        }

            #collapseOne5 .panel-body {
                overflow: auto;
                /*height: 150px;*/
                width: 103%;
                padding-right: 2%;
            }

        .form-horizontal {
            width: 50%;
            line-height: 0 !Important;
        }

        #accordion4 .form-group {
            border-bottom: none;
        }

        #tblTypeSLADetails .clsTxtControls {
            width: 43px !important;
        }

        #tblTypeSLADetails .clscboControls {
            width: 79px !important;
            margin-left: 4PX;
        }

        #tblTypeSLADetails .col-sm-4 {
            padding-right: 30PX;
        }

        #tblTypeSLADetails .form-group {
            float: none;
        }

        .container-fluid {
            min-height: 0px !important;
        }

        #CboType {
            width: 75px;
        }

        #idSearchHistory {
            position: absolute;
            margin-top: 14px;
            margin-left: 10px;
        }

        .panel-group {
            margin-bottom: 0px !important;
        }

        .setting-src {
            padding: 0px !important;
        }

        .selected_user {
            background: #cbddfa;
        }

        td {
            font-family: Verdana !important;
            font-size: 12px !important;
        }

        .bottom-bar input {
            height: 23px;
            padding: 0;
            font-size: 11px;
            border-radius: 3px !important;
            padding-left: 10px;
            border-color: #BBB;
            border-width: 1px;
        }


        @media screen(min-width: 762px) {
            .bxs {
                text-align: left;
            }
        }


        /*************************************CSS ADDED BY VARSHA JORWEKAR************************************************/

        .form-group {
            border-bottom: none !IMPORTANT;
            DISPLAY: INLINE-FLEX;
        }

        .bottom-bar {
            float: left;
            width: 140%;
        }

        /*bootstrap.min.css:6*/
        @media (min-width: 768px) {
            .col-md-6 {
                -ms-flex: 0 0 100%;
                flex: 0 0 100%;
                max-width: 50%!important;
            }
        }

        .captionlbl {
            font-size: 12px;
            padding-top: 0px;
            text-align: left;
            padding-left: 0px;
            /*font-weight: 600 !important;*/
        }

        .container-fluid {
            width: 100%;
            margin-right: auto;
            margin-left: auto;
            padding-right: 15px;
            padding-left: 15px;
            width: 100%;
            padding-bottom: 200px !important;
        }

        /*#cboOutputDateFormat, #cboInputDateFormat {
            height: 23px !important;
            font-size: 11px !important;
            padding: 2px;
            padding-left: 4px;
            border-color: #BBB;
            COLOR: BLACK;
        }*/

        .type-top-bar, .top-bar {
            padding: 0px !important;
        }
        .type-top-bar{margin-top:20px}

        #addressbox {
            font-size: 11px !important;
        }

        #frmTagNavigation {
            border: 0px !important;
            width: 103% !important;
        }

        ::-webkit-scrollbar {
            display: none !important;
        }

        .container-fluid {
            width: 103% !important;
        }

        #UploadImage, .col-xs-1 {
            BORDER-BOTTOM: NONE;
        }

        .file {
            display: none;
        }

        .selectedfilecls {
            border: 1px solid #ddd;
            text-align: center;
            font-weight: normal;
            font-size: 11px !important;
            width: 75px;
            height: 75px;
            border-radius: 35px;
            MARGIN-LEFT: 14PX;
            cursor:pointer
        }

        .v-tabs .h-tabs div.tab button {
            background-color: inherit;
            float: left;
            width: 100px;
            color: #000;
        }

            .v-tabs .h-tabs div.tab button.tablinks1 {
                margin-right: 50px;
                padding-left: 0px;
                WIDTH: 10%;
            }

        /*bootstrap.min.css:6*/
        @media all and (min-width:576px) {
            .col-sm-3 {
                -ms-flex: 0 0 65% !important;
                flex: 0 0 67% !important;
                max-width: 90% !important;
            }
        }

        /*bootstrap.min.css:6*/
        @media (min-width: 768px) {
            .col-md-7 {
                -ms-flex: 0 0 70.333333%;
                flex: 0 0 70.333333%;
                max-width: 90%;
            }
        }

        .bottom-bar textarea {
            border-color: #BBB;
            border-radius: 3px !important;
            COLOR: BLACK;
        }

        /*Stylesheet_Whiz_Laptop.css:78*/
        @media only screen and (max-width: 1240px) and (min-width: 992px) {
            input:not([type=button]) {
                background-color: #fff;
                border-color: transparent;
                box-sizing: border-box;
                padding: 4px;
                border: 1px solid #bbb;
                border-radius: 3px;
                color: #000;
                margin-bottom: 0px;
                margin-top: 0px !important;
                PADDING-LEFT: 8PX;
            }
        }

        /*Stylesheet_Whiz_Laptop.css:96*/
        @media only screen and (max-width: 1240px) and (min-width: 992px) {
            select {
                background-color: #fff;
                border-color: transparent;
                box-sizing: border-box;
                padding: 4px;
                border: 1px solid #bbb;
                border-radius: 3px;
                color: #000;
                margin-bottom: 0px !important;
                margin-top: 0px !important;
                background-image: -webkit-linear-gradient(top,#fff 20%,#f6f6f6 50%,#eee 52%,#f4f4f4 100%);
            }
        }

        /*Stylesheet_Whiz_Laptop.css:113*/
        @media only screen and (max-width: 1240px) and (min-width: 992px) {
            textarea {
                background-color: #fff;
                border-color: transparent;
                box-sizing: border-box;
                padding: 4px;
                border: 1px solid #bbb;
                border-radius: 3px;
                color: #000;
                margin-bottom: 0px !important;
                margin-top: 0px !important;
                border-radius: 3px;
                border: 1px solid #bbb;
                PADDING: 4px 8px !Important;
            }
        }

        .labelControlCaption {
            text-align: right;
            font-size: 12px;
            padding-top: 2%;
        }

        .tablinks.active, .tablinks1.active, .h-tabs div.tab button.tablinks1.active, .h-tabs div.tab button.tablinks2.active, .h-tabs div.tab button.tablinks3.active {
            WIDTH: 10% !important;
            color: #4caac0 !important;
            border: none !important;
            text-decoration: underline !important;
        }

        .tablinks.active, .tablinks1.active, .h-tabs div.tab button.tablinks1.active, .h-tabs div.tab button.tablinks2.active, .h-tabs div.tab button.tablinks3.active {
            WIDTH: 10% !important;
            border: none !important;
            text-decoration: underline !important;
        }

        .container {
            margin-right: auto;
            margin-left: 18% !important;
            padding-right: 15px;
            padding-left: 15px;
            width: 100%;
        }

        /*Added by Usha Pandit on 18.12.2017 for alignment*/
        #companynamebox, #addressbox {
            margin-top: 0px
        }
        select {
            margin-top: 6px !important;
        }
        .alertify-notifier {
            font-family: "Open Sans",sans-serif!important;
            font-size: 14px !important;
        }


        input.form-control:not([type=button]) {
            background-color: #fff;
            border-color: transparent;
            box-sizing: border-box;
            padding: 4px;
            border: 1px solid #bbb;
            border-radius: 3px;
            color: #000;
            margin-bottom: 0px;
            margin-top: 6px;
            font-size: 12px!important;
            font-weight: 100!important;
            width: 200px!important;
        }


        input.form-control, input.form-control {
            height: 28px;
        }

        select.form-control {
           height:30px!important;
           width:200px!important;
        }

        #addressbox {
              height:56px!important;
           width:200px!important;

        }
        /*  End of addition*/

        #idyearend {
              margin-right:5%!important;
             margin-top:-11%!important;
        }

            .right {
            margin-right:5%;
            
        }
        .form-horizontal .control-label {
            margin-top:4%;
            font-weight:100!important;
        }
           .modal-content {
     /*background-color: #fefefe;*/
        margin: 0px;
        border: 1px solid #888;
        width: 100%;
        height: 232px !important;
}


        #btnConfirm {
            width:15%;
            height:29px;
             line-height:1%;
             font-size:12px!important;
        }

           #btnNo {
            width:15%;
            height:29px;
            line-height:1%;
             font-size:12px!important;
        }
        #myConfirmYearProcess label {
            font-size:14px!important;
            font-family:"Open Sans",sans-serif!important;
        }
        /*Added by Usha Pandit on 07 Aug 2018 for setting height of OutputDateFormat field*/
        #cboOutputDateFormat {
            height: 32px!important;
        }
        /*End of Added by Usha Pandit on 07 Aug 2018 for setting height of OutputDateFormat field*/
        .fa-pencil-alt{font-size:14px!important}
    </style>
<body class="" id="page-top">

    <%PageInit()%>

</body>
 <div class="modal" id="myConfirmYearProcess" style="overflow-y:hidden;outline:none;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" >
            <div class="modal-content animate" style="overflow:hidden">
              <div class="modal-header">
                  
                   </div>
              <div class="modal-body"style="outline:none; width:103%;margin-top:-2%">        
                  <label>If you click OK, following actions will be performed:</label>
                  <label> 1) Changes the financial year start date and end date.<br /></label> 
                  <label> 2) Carries forward leaves of current financial year to next financial year.</label>
              </div>
             <div class="modal-footer">            
                 <button type="button" id="btnConfirm" class="btn btn-default save" onclick="ConfirmYearProcess(1)" style="background:#f5f5f5">Ok</button>
               <button type="button" id="btnNo" class="btn btn-default save" onclick="ConfirmYearProcess(0)" data-dismiss="modal" style="background:#f5f5f5">Cancel</button>
              </div>
            </div>
       </div>
    </div> 

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<script>
  

    var FILEPATH = "";
    var imgsrc;
    function AJAXCallWithResult(url, data, async) {
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            async: async,
            success: function (data) {
                AjaxResult = data.d;
                $(".loadingoverlay", parent.document).css("display", "none");
            },
            error: function (xhr, status, error) {
                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
            }
        });

        return AjaxResult;
    }


    ///*Added By Yasmin on 18th july 2018*/
    //$('[data-toggle="tooltip"]').tooltip();


    //Added by Dipali on 16th Dec for Close LogOut Pop_up
    $(document).click(function () {
        //alert(window.parent.parent.parent.location);
        $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

    });
    //*Added By Yasmin on 25th july 2018*/
    //$(document).ready(function () {
    //    $('a').tooltip({
    //        position: {
    //            my: 'center bottom+10',
    //            at: 'center top',
    //            of: '#btnSelectFile'
    //        }
    //    });
    //    $('a').tooltip('option', 'tooltipClass', 'top');

    //});

    //$("#btnSelectFile").tooltip({
    //    position: {
    //        my: "center top",
    //        at: "center top-10",
    //        collision: "flip",
    //        using: function (position, feedback) {
    //            $(this).addClass(feedback.vertical)
    //                .css(position);
    //        }
    //    }
    //});

    $("#btnSelectFile").tooltip({
        position: {
            my: 'center top',
            at: 'center bottom+10',
            collision: "flip",
            using: function (position, feedback) {
                $(this).addClass(feedback.vertical)
                    .css(position);
            }
        }
    });
    //End of Added by Dipali on 16th Dec for Close LogOut Pop_up
    //Added by Usha Pandit on 19.12.2017 for setting height
    function setHeight() {
        var intDivGridHeight;

        //if (WhichBrowser() == "IE") {
        //    intDivGridHeight = (window.innerHeight / 2);
        //    //alert(window.innerHeight)
        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //        $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 378;
        //        //alert("ie1 - " + intDivGridHeight)
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //        $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 200;
        //        //alert("ie2 - " + intDivGridHeight)
        //    }
        //    else {
        //        $('.panel-body').css('padding-top', "15px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 150;

        //        //alert("ie3 - " + intDivGridHeight)
        //        //$('#CompanyInfoDiv').css('overflow', "hidden");
        //    }
        //    $('#CompanyInfoDiv').css('height', intDivGridListHeight + 20);
        //    $('#CompanyInfoDiv').css('height', intDivGridListHeight - 230 + "px");
        //    $('#CompanyInfoDiv').css('width', "102% !important");
        //    $('#CompanyInfoDiv').css('-ms-overflow-style', "none");
        //}
        //else {
        //    intDivGridHeight = (window.innerHeight / 2);
        //    //alert(window.innerHeight)
        //    //alert(window.innerWidth)
        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //        $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 250;
        //        //alert("1 - " + intDivGridListHeight)
        //        $('#CompanyInfoDiv').css('overflow', "auto");
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //        $('.panel-body').css('padding-top', "0px");

        //        intDivGridListHeight = parseInt(window.innerHeight) - 410;
        //        //alert("2 - " + intDivGridListHeight)
        //        //$('#CompanyInfoDiv').css('overflow', "auto");
        //    }
        //    else {
        //        $('.panel-body').css('padding-top', "15px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 125;
        //        //alert("3 - " + intDivGridListHeight)
        //        //$('#CompanyInfoDiv').css('overflow', "hidden");
        //        $('.request-details-pg').css('min-height', "450px !IMPORTANT");
        //        $('.tabcontent').css('height', "0px !IMPORTANT");
        //    }

        //    $('#CompanyInfoDiv').css('height', "700px");

        //}

        var intDivGridHeight, intDivGridListHeight
        intDivGridListHeight = parseInt(window.innerHeight);
        if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

            $("#CompanyInfoDiv").css('height', intDivGridListHeight - 280 + "px");
        }

        else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

            $("#CompanyInfoDiv").css('height', intDivGridListHeight - 320 + "px");
        }
        else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

            $("#CompanyInfoDiv").css('height', intDivGridListHeight - 280 + "px");
        }
        else {
            $("#CompanyInfoDiv").css('height', intDivGridListHeight - 280 + "px");
        }


    }
    //End of Added by Usha Pandit on 19.12.2017 for setting height
    $(document).ready(function ()
    {

        imgsrc = $('#imgUser').attr('src');

        setHeight();
        // Commented by Usha Pandit on on 19.12.2017 for setting height
        //var intDivGridHeight

        //if (WhichBrowser() == "IE") {
        //    intDivGridHeight = (window.innerHeight / 2);
        //    //alert(window.innerHeight)
        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //        $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 378;
        //        //alert("ie1 - " + intDivGridHeight)
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //        $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 200;
        //        //alert("ie2 - " + intDivGridHeight)
        //    }
        //    else {
        //        $('.panel-body').css('padding-top', "15px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 150;

        //        //alert("ie3 - " + intDivGridHeight)
        //        $('#CompanyInfoDiv').css('overflow', "hidden");
        //    }
        //    $('#CompanyInfoDiv').css('height', intDivGridListHeight + 20);
        //    $('#CompanyInfoDiv').css('height', intDivGridListHeight - 230 + "px");
        //    $('#CompanyInfoDiv').css('width', "102% !important");
        //    $('#CompanyInfoDiv').css('-ms-overflow-style', "none");
        //}
        //else {
        //    intDivGridHeight = (window.innerHeight / 2);
        //    //alert(window.innerHeight)
        //    //alert(window.innerWidth)
        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //        $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 250;
        //        //alert("1 - " + intDivGridListHeight)
        //        $('#CompanyInfoDiv').css('overflow', "auto");
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //        $('.panel-body').css('padding-top', "0px");

        //        intDivGridListHeight = parseInt(window.innerHeight) - 410;
        //        //alert("2 - " + intDivGridListHeight)
        //        $('#CompanyInfoDiv').css('overflow', "auto");
        //    }
        //    else {
        //        $('.panel-body').css('padding-top', "15px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 125;
        //        //alert("3 - " + intDivGridListHeight)
        //        $('#CompanyInfoDiv').css('overflow', "hidden");
        //        $('.request-details-pg').css('min-height', "450px !IMPORTANT");
        //        $('.tabcontent').css('height', "0px !IMPORTANT");
        //    }
           
        //    $('#CompanyInfoDiv').css('height', intDivGridListHeight - 100 + "px");
           
        //}
        //End of comment by Usha Pandit on 19.12.2017 for setting height
        var dt = ""
        var url = "CRM_CompanyInformation.aspx/GetCompanyInformation"
        var result = AJAXCallWithResult(url, dt, false)

        // Commented by Usha Pandit on on 19.12.2017 for getting logo
        //var jsonData = JSON.parse(result)

        //$.each(jsonData, function (id, obj) {

        //    $("#cboInputDateFormat option").each(function () {
        //        if ($(this).text() == obj.InputDateFormat) {
        //            $("#cboInputDateFormat").val($(this).val());
        //        }
        //    });

        //    $("#cboOutputDateFormat").val(obj.DateFormatID);
        //    $("#companynamebox").val(obj.CompanyName)
        //    $("#companyshortnamebox").val(obj.ShortCompanyName)
        //    $("#addressbox").val(obj.Address)
        //    $("#citybox").val(obj.City)
        //    $("#statebox").val(obj.State)
        //    $("#countrybox").val(obj.Country)
        //    $("#zipbox").val(obj.ZipCode)
        //    $("#emailbox").val(obj.Email)


        //    $("#yearstartlbl").html(obj.FinancialYearStart)
        //    $("#yearendlbl").html(obj.FinancialYearEnd)

        //    $("#usernolbl").html(obj.NoOfUsers)
        //    $("#weekdaysbox").val(obj.WeekDays)
        //    $("#dayhoursbox").val(obj.HoursPerDay)

        //});

        //End of comment by Usha Pandit on 19.12.2017 for getting logo

        //Added by Usha Pandit on 16.12.2017 for image upload validation
        if (result != "") {
            var arrResult = result.split("#$#");

            $("#companynamebox").val(arrResult[0]);
            $("#companyshortnamebox").val(arrResult[1]);
            $("#addressbox").val(arrResult[2]);

            $("#citybox").val(arrResult[3]);
            $("#statebox").val(arrResult[4]);
            $("#countrybox").val(arrResult[5]);

            $("#zipbox").val(arrResult[6]);
            $("#emailbox").val(arrResult[7]);

            $("#cboOutputDateFormat").val(arrResult[8]);

            $("#cboInputDateFormat option").each(function () {
                if ($(this).text() == arrResult[9]) {
                    $("#cboInputDateFormat").val($(this).val());
                }
            });

            $("#yearstartlbl").html(arrResult[10]);
            $("#yearendlbl").html(arrResult[11]);

            $("#usernolbl").html(arrResult[12]);
            $("#weekdaysbox").val(arrResult[13]);
            $("#dayhoursbox").val(arrResult[14]);

            //$("#lssmailbox").text(arrResult[15]);
            $("#phonelbl").text(arrResult[16]);
            $("#productversionlbl").text(arrResult[17]);

            //alert(arrResult[18]);

            $('#imgUser').attr("src", arrResult[18]);
            imgsrc = $('#imgUser').attr('src');

            $('[data-toggle="tooltip"]').tooltip();
            $("#btnSelectFile").tooltip();
        }
        //End of addition by Usha Pandit on 16.12.2017 for getting logo

        /*Added By Yasmin on 18th july 2018*/
        $('[data-toggle="tooltip"]').tooltip();
        $("#btnSelectFile").tooltip();

    });
    window.onload = function () {
        setTimeout(function () {
            if (document.getElementById("CompanyInfoDiv").style.height == "0px") {
                document.getElementById("CompanyInfoDiv").style.height = window.innerHeight - 150 + 'px';
                document.getElementById("CompanyInfoDiv").style.overflow = "auto";
            }
        }, 1000)
        $('[data-toggle="tooltip"]').tooltip();
        $("#btnSelectFile").tooltip();
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

    function SelectFile() {

        var strFileCount = $("#btnSelectFile").attr("FileCount");
        var objCurrentFileControl = $("#file");

        objCurrentFileControl.click();
    }
    function readURL(input) {

        if ($("#file")[0].files && $("#file")[0].files) {
            var reader = new FileReader();

            reader.onload = function (e) {

                $('#imgUser').attr("src", e.target.result);
                //Commented by Usha Pandit on 20.12.2017 for Image alignment
                //$("#imgUser").css('margin-left', '-16px');
                //$("#imgUser").css('margin-top', '-1px');
                //$("#imgUser").css('width', '75px');
                //$("#imgUser").css('height', '75px');
                //$("#imgUser").css('border-radius', '35px');

                //End of Commented by Usha Pandit on 20.12.2017 for Image alignment
            }
            reader.readAsDataURL($("#file")[0].files[0]);

            FILEPATH = ($("#file")[0].files[0].name);
        }
    }
    var fileObject;
    $(document).on('change', '.file', function () {

        var fileNameDisplay;
        //$(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, '..\\..\\..\\Images\\'));

        var objtxtFileName = document.getElementById('file');

        var fileName = objtxtFileName.value;
        fileNameDisplay = fileName;
        var index = fileName.lastIndexOf("\\");
        if (index == -1)
            index = fileName.lastIndexOf("/");

        if (index != -1)
            fileName = fileName.substring(index + 1, fileName.length);

        if (validateUploadedFile(fileName) == false) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please upload files having extensions: .JPEG, .PNG, .BMP, .GIF, .TIF, .JPG only.', 'error');

            $("#imgUser").attr('src', imgsrc);
            return;
        }
        //End of addition
        fileObject = $("#file")[0].files;
        readURL();
    });

    function validateUploadedFile(curFileName) {
        var validFile = false;
        var fileNameExt = curFileName.substr(curFileName.lastIndexOf('.') + 1);
        var validFileExtensions = ["jpg", "jpeg", "bmp", "gif", "png", "TIF"];
        for (var i = 0; i < validFileExtensions.length; i++) {
            var sCurExtension = validFileExtensions[i];
            if (fileNameExt.toLowerCase() == sCurExtension.toLowerCase()) {
                validFile = true;
                break;
            }
        }

        return validFile;
    }
    //Commented by Dipali v on 19th Dec 2017 For Removing link
    function YearEndProcess()
    {
        /*Added by Dipali V On 21st Nov 2017 For Year end Process*/
        document.getElementById('myConfirmYearProcess').style.display = 'block';
        ConfirmYearProcess(Confirm);

        /*End of Added by Dipali V On 21st Nov 2017 For Year end Process*/

    }
    
    /*Added by Dipali V On 21st Nov 2017 For Year end Process*/
    function ConfirmYearProcess(flag)
    {
       
        if (flag == "1")
        {

            var dt = ""
            var url = "CRM_CompanyInformation.aspx/YearEndProcessInformation"

            var result = AJAXCallWithResult(url, dt, false)
            if (result != "")
            {
                document.getElementById('myConfirmYearProcess').style.display = 'none';
                Cancelinformation(1);
            }
        }
        else {

            document.getElementById('myConfirmYearProcess').style.display = 'none';

        }

    }
    /*End of Added by Dipali V On 21st Nov 2017 For Year end Process*/
    
    function SaveCompanyInformation() {

        var companyname = $("#companynamebox").val()
        var companyshortname = $("#companyshortnamebox").val()
        var address = $("#addressbox").val()
        var city = $("#citybox").val()
        var state = $("#statebox").val()
        var country = $("#countrybox").val()
        var zip = $("#zipbox").val()
        var email = $("#emailbox").val()
        //Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format
        var outputdateformat = $("#cboOutputDateFormat").val()
        var inputdateformat = $("#cboInputDateFormat").val()
        //End of Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format


        var weekdays = $("#weekdaysbox").val()
        var dayhours = $("#dayhoursbox").val()
        var originalfile = FILEPATH;

        //Commented and added by Usha Pandit on 18.12.2017 for Save Validate operation

        //if (companyname == "" || companyshortname == "" || weekdays == "" || dayhours == "") {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please Enter all the Information..', 'error');
        //    $("#companynamebox").focus();
        //}
        //else if (companyshortname == "") {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please Enter Company Short Name..', 'error');
        //    $("#companyshortnamebox").focus();
        //}
        //else if (weekdays == "" || weekdays <= 0 || weekdays > 7) {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please Enter valid number of days..', 'error');
        //    $("#weekdaysbox").focus();
        //}
        //else if (dayhours == "" || dayhours < 0 || dayhours > 24) {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please Enter valid number of Work Hours..', 'error');
        //    $("#dayhoursbox").focus();
        //}
        //else {
        if (ValidateCompanyInformation() == 0) {
            //End of addition by Usha Pandit
            var strURL = "CRM_CompanyInformation.aspx";

            var formData = new FormData();
            if (typeof fileObject == "undefined") {
                formData.append('IMAGEFILE', "");
            }
            else {
                formData.append('IMAGEFILE', fileObject[0]);
            }
            //alert(1)
            formData.append('Mode', 'UploadPhoto');
            formData.append('companyname', companyname);
            formData.append('companyshortname', companyshortname);
            formData.append('address', address);
            formData.append('city', city);
            formData.append('state', state);
            formData.append('country', country);
            formData.append('zip', zip);
            formData.append('email', email);

            //Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format
            formData.append('outputdateformat', outputdateformat);
            formData.append('inputdateformat', inputdateformat);
            //End of Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format

            formData.append('dayhours', dayhours);
            formData.append('weekdays', weekdays);

            formData.append('originalfilenm', originalfile);
            //alert(fileObject)
            //alert(2)
           // if (typeof fileObject != "undefined") {            

                $.ajax({
                    url: strURL,  //Server script to process data
                    type: 'POST',
                    data: formData,
                    async: false,
                    success: function (result) {
                        //  document.getElementById('UploadImage').innerHTML="";
                        //$('#UploadImage').html("");
                        //alert("SUCCESS" + result);
                        $('#UploadImage').html(result);
                        //$("#imgUser").css('margin-left', '-16px');
                        //$("#imgUser").css('margin-top', '-1px');
                        $("#imgUser").css('width', '75px');
                        $("#imgUser").css('height', '75px');
                        $("#imgUser").css('border-radius', '35px');

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Company information Updated successfully', 'success');

                    },
                    error: function (xhr, status, error) {
                        console.log(xhr.responseText);
                    },
                    cache: false,
                    contentType: false,
                    processData: false
                });
           // }                                            
            //}
        }
        setHeight();
    }

    function isNormalInteger(str) {
        var n = Math.floor(Number(str));
        return String(n) === str && n >= 0;
    }
    // Added by Usha Pandit on 18.12.2017 for Company Information Validation
    function ValidateCompanyInformation() {
        var chkVal = 0;
        var strmsg = "";
        var errorMsg = "<ul>"

        if ($("#companynamebox").val() == "") {
            strmsg = "- 'Company Name' should not be left blank.";
            errorMsg += "<li>" + strmsg + "</li></n>";
            chkVal = 1;
        }

        if ($("#companyshortnamebox").val() == "") {
            strmsg = "- 'Company Short Name' should not be left blank.";
            errorMsg += "<li>" + strmsg + "</li></n>";
            chkVal = 1;
        }

        if ($("#weekdaysbox").val() == "") {
            strmsg = "- 'Week Days' should not be left blank.";
            errorMsg += "<li>" + strmsg + "</li></n>";
            chkVal = 1;
        }
        if ($("#weekdaysbox").val() != "") {
            var isNumber = isNormalInteger($("#weekdaysbox").val());
            if (isNumber == false) {
                strmsg = "- Please enter only positive numeric value for 'Week Days'.";
                errorMsg += "<li>" + strmsg + "</li></n>";
                chkVal = 1;
            }
            else if (isNumber == true) {
                if ($("#weekdaysbox").val() <= 0 || $("#weekdaysbox").val() > 7) {
                    strmsg = "- The value of 'Week Days' should be in the range of (1-7).";
                    errorMsg += "<li>" + strmsg + "</li></n>";
                    chkVal = 1;
                }
            }
        }
        if ($("#dayhoursbox").val() == "") {
            strmsg = "- 'Hours in a Day' should not be left blank.";
            errorMsg += "<li>" + strmsg + "</li></n>";
            chkVal = 1;
        }

        if ($("#dayhoursbox").val() != "") {
            var isNumber = isNormalInteger($("#dayhoursbox").val());
            if (isNumber == false) {
                strmsg = "- Please enter only positive numeric value for 'Hours in a Day'";
                errorMsg += "<li>" + strmsg + "</li></n>";
                chkVal = 1;
            }
            else if (isNumber == true) {
                if ($("#dayhoursbox").val() <= 0 || $("#dayhoursbox").val() > 24) {
                    strmsg = "- The value of 'Hours in a Day' should be in the range of (1-24).";
                    errorMsg += "<li>" + strmsg + "</li></n>";
                    chkVal = 1;
                }
            }
        }
        errorMsg += "</ul>";
        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error');
        }

        return chkVal;
    }
    //End of addition by Usha Pandit on 18.12.2017 for Company Information Validation


    function Cancelinformation(CompanyID) 
    {

        var dt = ""
        var url = "CRM_CompanyInformation.aspx/GetCompanyInformation"
        var result = AJAXCallWithResult(url, dt, false)

        if (result != "") {
            var arrResult = result.split("#$#");
            //alert(arrResult);
            $("#companynamebox").val(arrResult[0]);
            $("#companyshortnamebox").val(arrResult[1]);
            $("#addressbox").val(arrResult[2]);

            $("#citybox").val(arrResult[3]);
            $("#statebox").val(arrResult[4]);
            $("#countrybox").val(arrResult[5]);

            $("#zipbox").val(arrResult[6]);
            $("#emailbox").val(arrResult[7]);

            $("#cboOutputDateFormat").val(arrResult[8]);

            $("#cboInputDateFormat option").each(function () {
                if ($(this).text() == arrResult[9]) {
                    $("#cboInputDateFormat").val($(this).val());
                }
            });

            $("#yearstartlbl").html(arrResult[10]);
            $("#yearendlbl").html(arrResult[11]);

            $("#usernolbl").html(arrResult[12]);
            $("#weekdaysbox").val(arrResult[13]);
            $("#dayhoursbox").val(arrResult[14]);

            //$("#lssmailbox").text(arrResult[15]);
            $("#phonelbl").text(arrResult[16]);
            $("#productversionlbl").text(arrResult[17]);

            //alert(arrResult[18]);

            $('#imgUser').attr("src", arrResult[18]);
            imgsrc = $('#imgUser').attr('src'); 
        }
       
        
    
    }
    //*Added By Yasmin on 25th july 2018*/
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
    

</script>

</html>
