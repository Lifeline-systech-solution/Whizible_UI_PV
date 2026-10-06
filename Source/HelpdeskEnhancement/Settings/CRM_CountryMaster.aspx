<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_CountryMaster.aspx.vb" Inherits="PbNIT.CRM_CountryMaster" %>

    <!DOCTYPE html>

    <html lang="en">

        <%CommonFunctions.General.PlotPageHeadTag("Setting")%>
    <head>
         <meta charset="utf-8">
         <meta name="description" content="">
         <meta name="author" content="">
         <title>Setting</title>
            <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Country")%>--%>

         <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
        <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" type="text/css" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css">
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css">
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css">
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css">
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min" />
        <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

    </head>
         <style>

            .paginate_button  {
                 display: inline-block;
                 padding-left: 0;
                 margin: 0px 0;
                 border-radius: 0px;
            }

            .search-bar input {
                border: 1px solid #c8c6c6;
                border-radius: 50px;
                float: left;
                font-size: 11px;
                font-weight: 600;
                height: 25px;
                padding: 5px 114px 5px 30px;
                width: 230px;
                margin-bottom: 0;
            }
            /*Stylesheet_Whiz_Laptop.css:78*/
            @media only screen and (max-width: 1240px) and (min-width: 992px) {
                #txttblsrch, #myInput {
                    background-color: #fff;
                    border-color: transparent;
                    box-sizing: border-box;
                    padding: 4px;
                    border: 1px solid #bbb;
                    border-radius: 23px !IMPORTANT;
                    color: #000;
                    margin-bottom: 0px;
                    margin-top: 6px;
                    padding: 5px 114px 5px 30px;
                }
            }

            .footertextbox {
                background-color: #fff;
                border-color: transparent;
                box-sizing: border-box;
                padding: 4px;
                border: 1px solid #bbb;
                border-radius: 3px !IMPORTANT;
                color: #000;
                margin-bottom: 0px;
                margin-top: 6px;
                /* vertical-align: bottom; */
            }

            .search-bar button {
                color: black;
                font-size: 15px;
                height: 0px;
                position: absolute;
                left: 0;
                width: 30px;
                border-radius: 50% 0 0 50%;
                background: #fff;
                border: 1px solid #c8c6c6;
                border-right: none;
                TOP: 32%;
            }

            .top-bar {
                border-right: none;
            }

            /*.top-bar ul li {
                padding: 0px 0px;
                float: left;
                font-size: 12px;
                font-weight: 600;
            }*/

            .right {
                float: right;
            }

            #Email .tab button {
                width: 104px;
            }

            .v-tabs .h-tabs div.tab button {
                background-color: inherit;
                float: left;
                /* width: 69px; */
                color: #000;
            }

            .table-responsive, .histry-src, .activ-top-bar, .attch-top-bar, .setting-src, .top-bar {
                float: left !IMPORTANT;
                width: 100%;
            }

            .v-tabs .h-tabs div.tab {
                width: 150%;
                height: 24pt !Important;
                background: none;
                border: none;
                margin-bottom: 0;
                padding-left: 19px;
                border-top: 1px solid #e3e2e2 !IMPORTANT;
                border-bottom: 1px solid #e3e2e2 !IMPORTANT;
            }
            .panel-heading h3 {
                width: 25%;
                float: left;
                margin: 0;
                color: black;
                font-size: 13px;
                font-weight: 600;
            }

            /*bootstrap3.3.5.min.css:5*/
            @media (min-width: 768px) {
                .form-horizontal .control-label {
                    padding-top: 6px !important;
                    margin-bottom: 0;
                    text-align: right;
                }

                .historybtn{
                     margin-top: -17px;
                    margin-left: 795%;
                    BORDER-RIGHT: 1PX SOLID WHITE;
                }
            }

            #DivList .dataTables_length, #DivList .dataTables_info {
                display: none !IMPORTANT;
            }

            .dataTables_paginate {
                margin-top: 1.5% !IMPORTANT;
            }

            #DivList > label {
                display: none;
            }

            tbody {
                font-size: 13px;
            }

            thead {
                background-color: #cbddfa;
                font-size: 14px;
            }


            .tab {
                padding: 0px;
                margin-bottom: 0px !IMPORTANT;
            }

 
            .form-horizontal {
                margin-top: 0%;
            }

            div.dataTables_scrollBody table tbody tr td {
                border-top: none !important;
                border-bottom: none !important;
            }

            .dataTables_scroll {
                border-bottom: 1.5px solid lightgrey;
                width: 102%;
                 /*margin-top: -1% !important;*/
            }

          
            .right .btn-default {
                background: WHITE;
                color: BLACK;
            }

            #DivList .dataTables_scroll table th:first-child,
            #DivList .dataTables_scrollBody table tr td:first-child {
               text-align : left !important;
                
            }

          
            .dataTables_filter {
                display: none !important;
            }

            .h-tabs input[type=checkbox] {
                outline: 0px solid #c7d3e5;
                width: 15px;
            }

            .h-tabs {
                padding: 0 0 0px 0px !important;
            }

            /*#txttblsrch:focus, #myInput:focus, button:focus {
                outline: none;
            }*/

            .panel {
                padding-top: 0px;
                margin-top: 0%;
            }

            .dataTables_scrollHeadInner {
                width: 100% !important;
            }

            .table, .dataTable, .no-footer {
                width: 100% !important;
            }

            .paginate_button:hover {
                text-decoration: none !important;
                font-size: 12px !important;
                -webkit-transition: none !important;
            }

            .form-control {
                display: block;
                width: 100%;
                height: 28px;
                padding: 2px 12px;
                font-size: 12px;
                line-height: 1.42857143;
                color: #555;
                background-color: #fff;
                background-image: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
                -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
                transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            }

            .col-sm-9 {
                margin-top: -2%;
                margin-bottom: 2%;
            }

            .col-md-7{
                margin-left: 42%/*60%*/ !IMPORTANT;
            }

            .col-md-12 {
               
            }

            .row {
               display: block;
               /* display: flex; */
               -ms-flex-wrap: wrap;
               flex-wrap: wrap;
               margin-right: -15px;
               margin-left: -15px;
            }

            .container-fluid {
                min-height: 5%;
                /*overflow: auto;
                height: 476px;
                width: 102%;*/
            }
            
            ::-webkit-scrollbar { 
                display: none; 
            }

            .dataTables_scrollBody, #modalbody {
                 -ms-overflow-style: none;
            }
            
            .btn:focus{
                outline: none;

            }

            .tablinks.active, .tablinks1.active, 
            .h-tabs div.tab button.tablinks1.active, 
            .h-tabs div.tab button.tablinks2.active, 
            .h-tabs div.tab button.tablinks3.active {
                color: #4caac0 !IMPORTANT;
                border: none !important;
                text-decoration: underline;
            }

            .h3, h3 {
                font-size: 16px;
            }

            #ShowHistoryGrid{
                width:102%;
            }

            table.dataTable thead .sorting::before, 
            table.dataTable thead .sorting::after, 
            table.dataTable thead .sorting_asc::before, 
            table.dataTable thead .sorting_asc::after, 
            table.dataTable thead .sorting_desc::before, 
            table.dataTable thead .sorting_desc::after, 
            table.dataTable thead .sorting_asc_disabled::before, 
            table.dataTable thead .sorting_asc_disabled::after, 
            table.dataTable thead .sorting_desc_disabled::before, 
            table.dataTable thead .sorting_desc_disabled::after {
                position: absolute;
                bottom: 0.9em;
                display: none !IMPORTANT;
                opacity: 0.3;
            }

            table.dataTable thead > tr > th.sorting_asc, table.dataTable thead > tr > th.sorting_desc, table.dataTable thead > tr > th.sorting, table.dataTable thead > tr > td.sorting_asc, table.dataTable thead > tr > td.sorting_desc, table.dataTable thead > tr > td.sorting {
                padding-right: 0px; 
            }

            .form-horizontal{
                width: 100%;
            }

            .search-bt{
                BORDER: NONE !IMPORTANT;
                height: 0px;
            }


            .panel-body{
                padding-top: 6px !IMPORTANT;
                height: 0px !IMPORTANT;
            }

            .form-group{
                display: inline-flex !IMPORTANT;
            }

            .col, .col-1, .col-10, .col-11, .col-12, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-auto, .col-lg, .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-auto, .col-md, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-auto, .col-sm, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-auto, .col-xl, .col-xl-1, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-auto {
                position: UNSET;
                width: 100%;
                min-height: 1px;
                padding-right: 15px;
                padding-left: 15px;
            }

            TR.clsTREvenRow {
                BORDER-RIGHT: thin;
                PADDING-RIGHT: 2pt;
                BORDER-TOP: thin;
                PADDING-LEFT: 2pt;
                FONT-SIZE: 10pt !IMPORTANT;
                PADDING-BOTTOM: 2pt;
                MARGIN: 2pt;
                BORDER-LEFT: thin;
                COLOR: black;
                PADDING-TOP: 2pt;
                FONT-FAMILY: Verdana, Arial;
                HEIGHT: 18px;
                BACKGROUND-COLOR: white;
            }



           #DivList div.dataTables_wrapper div.dataTables_paginate ul.pagination {
               margin-left:14rem;margin-bottom:10px
                }
           /*Commented by Kashish for ui change*/
            /*#divgrid {
               padding-top:5%;
            }*/

            /*#divTypeTab {
                margin-top:1%;
            }*/

               #EmailSettings {
            width: 102%;
            padding-right: 2%;
            /* overflow: auto; */
            /*height: 346px;*/
            overflow-x: hidden!important;
            overflow-y: auto!important;
}

                /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
          color: #bbb!important;
        }
        /*Added by Kashish for ui change*/
            #divTypeTab {
                margin-top: -15px!important;
                padding-bottom: 15px !important;
            }

            ol, ul {padding-left: 0rem;}
            .search-bar .fa-search{margin-top: 12px!important;right: 20px!important;}
            .row.dt-row{padding:15px}
        </style>

    <body class="" id="page-top">
        <%PageInit()%>
    </body>
                
    </html>
     <!--------------------------------------------------------------------------PAGE PLOTTING COMPLETE------------------------------------------------------------->
       
  
        <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
        <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script> 

<script>

        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
    disableRightClick();
		    <%End If%>
    var Msgid;
    var AjaxResult;

    $(document).ready(function () {
        var intDivGridHeight
           
        //if (WhichBrowser() == "IE") {
        //    intDivGridHeight = (window.innerHeight / 2);

        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //          $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 378;
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //          $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 200;

        //    }
        //    else {
        //          $('.panel-body').css('padding-top', "15px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 150;
        //    }

        //    $('.panel-body').css('height', intDivGridListHeight + "px");
        //    $('#DivList').css('height', intDivGridListHeight + 20);
        //    $('#DivList').css('height', intDivGridListHeight - 530 + "px");


        //}
        //else {
        //    intDivGridHeight = (window.innerHeight / 2);
            
        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //          $('.panel-body').css('padding-top', "0px");
        //          intDivGridListHeight = parseInt(window.innerHeight);
        //          //alert(32)
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //            $('.panel-body').css('padding-top', "0px");
        //            $('#EmailSettings').css('height', "450px");
              
        //            intDivGridListHeight = parseInt(window.innerHeight);

        //    }
        //    else {

        //        //alert(3)
        //         $('.panel-body').css('padding-top', "15px");
        //         intDivGridListHeight = parseInt(window.innerHeight);
        //         $('#EmailSettings').css('height', "700px");
        //    }

        //     //  $('#accordion').css('height', intDivGridListHeight + "px");
        //    //   $('#DivList').css('height', intDivGridListHeight);
        //    $('.panel-body').css('height', intDivGridListHeight + "px");
        //    $('#EmailSettings').css('overflow', "auto");
        //   // $('#DivList').css('height', intDivGridListHeight + "px");
        //}
        var intDivGridHeight, intDivGridListHeight
        intDivGridListHeight = parseInt(window.innerHeight);
        if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

            $("#EmailSettings").css('height', intDivGridListHeight - 280 + "px");
        }

        else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

            $("#EmailSettings").css('height', intDivGridListHeight - 320 + "px");
        }
        else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

            $("#EmailSettings").css('height', intDivGridListHeight - 280 + "px");
        }
        else {
            $("#EmailSettings").css('height', intDivGridListHeight - 280 + "px");
        }
        $('#EmailSettings').css('overflow', "auto");
        datatables("DivList", "SearchRquestType");
    });

    $(window).load(function () {

    });

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

    function datatables(divID, txtBoxID) {
        $('#' + divID + ' table').removeClass("clsGridTable");
        $('#' + divID + ' table tbody tr').removeClass("clsTROdd");
        $('#' + divID + ' table tbody tr').removeClass("odd");

        $('#' + divID + ' table').addClass("table");
        var table = $('#' + divID + ' table').DataTable({
            responsive: true,
            pageLength: 10,
           // scrollY: '450px',
            scrollX: false,
            autoWidth: false,
            //ordering: false,
            pagingType: "simple_numbers",
           
        });

        $("#" + divID + " .dataTables_scroll table th:nth-child(3)").css("text-align", "left");
        $("#" + divID + " .dataTables_scrollBody table tr:nth-child(3)").css("text-align", "left");

        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }
  
</script>
