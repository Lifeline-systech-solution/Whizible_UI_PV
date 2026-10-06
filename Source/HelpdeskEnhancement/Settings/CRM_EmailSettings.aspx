<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_EmailSettings.aspx.vb" Inherits="PbNIT.CRM_EmailSettings" %>

    <!DOCTYPE html>

    <html lang="en">

    <%CommonFunctions.General.PlotPageHeadTag("Setting")%>
    <head>
         <%--<meta charset="utf-8">--%>
         <meta name="description" content="">
         <meta name="author" content="">
         <title>Setting</title>
            <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Email Settings")%>--%>

    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/timepicker.min.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
        
    </head>
        
        <style>
                /*Added By Yasmin on 25th july 2018*/
            .fa-pencil-square-o {
                        cursor:pointer!important;                                                                  
            }
           .table {
                margin-bottom:0px!important;                                                                          
             }
  .ui-tooltip {
	        padding: 5px!important;
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
            .paginate_button  {
                 display: inline-block;
                 padding-left: 0;
                 margin: 0px 0;
                 border-radius: 0px;
            }

            .btn {
                display: inline-block;
                padding: 6px 12px;
                margin-bottom: 0;
                font-size: 12px;
                font-weight: 400;
                line-height: 1.42857143;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
                -ms-touch-action: manipulation;
                touch-action: manipulation;
                cursor: pointer;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
                background-image: none;
                border: 1px solid transparent;
                border-radius: 4px;
                height: 20pt;
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
                /*TOP: 32%;*/
            }

            .top-bar {
                border-right: none;
            }

            .top-bar ul li {
                padding: 0px 0px;
                float: left;
                font-size: 12px;
                font-weight: 600;
            }

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

            .histry-src, .type-top-bar {
                padding: 0px 17px !important;
            }

            .h-tabs div#headingOne {
                height: 25px;
                border-style: solid;
                border-color: #e3e2e2;
                border-width: 1px 0 1px 0;
                background-color: #cbddfa;
                padding-top: 0px !important;
            }

            div#headingOne {
                height: 25px !IMPORTANT;
                margin-top : 2px !IMPORTANT;
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
                     margin-top: -23px;
                    margin-left: 635%;
                    BORDER-RIGHT: none !important;
                }
            }

            .form-horizontal .control-label {
                font-size: 12px !important;
                font-weight : 100;
            }

            #DivList .dataTables_length{
                display: none !IMPORTANT;
            }

            div.dataTables_wrapper div.dataTables_info {
                padding-top: 0.85em;
                white-space: nowrap;
                font-size: 14px;
            }
            /*Changed By Yasmin on 25th july 2018*/

            .dataTables_paginate {
            margin-top: -2.5% !IMPORTANT;
             float: right;
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

            hr {
                margin-top: 0px !IMPORTANT;
                margin-bottom: 0px !IMPORTANT;
                border-top: 1px solid #eee;
            }

            .tab {
                padding: 0px;
                margin-bottom: 0px !IMPORTANT;
            }

            .table > tbody > tr > td:nth-child(2)
            {
                /*text-align: left !IMPORTANT;*/
            }

            .setting-src {
                padding: 0px 18px;
            }

            .form-horizontal {
                margin-top: 0%;
            }

            div.dataTables_scrollBody table tbody tr td {
                border-top: none !important;
                border-bottom: none !important;
            }

            .table > tbody > tr > td, 
            .table > tbody > tr > th, 
            .table > tfoot > tr > td, 
            .table > tfoot > tr > th, 
            .table > thead > tr > td 
            ,.table > thead > tr > th
             {
                padding: 4px;
                line-height: 1.42857143;
                vertical-align: top;
                border-top: 1px solid #ddd;
                text-align: center !IMPORTANT;
            }


            .table > thead > tr > th:nth-child(2) {
                 padding: 4px;
                 line-height: 1.42857143;
                 vertical-align: top;
                 border-top: 1px solid #ddd;
                 text-align: left !IMPORTANT;
            }

            .dataTables_scroll {
                border-bottom: 1.5px solid lightgrey;
                width: 100%;
                 /*margin-top: -1% !important;*/
            }

            .historybtn {
                /*margin-top: -17px;*/
               
                /*MARGIN-RIGHT: -16.8pt;*/
                text-decoration: underline;
            }

            .right .btn-default {
                background: WHITE;
                color: BLACK;
            }

            .alertify-notifier {
                font-family: "Open Sans",sans-serif!important;
                font-size: 12px !important;
            }

            #DivList .dataTables_scroll table th:first-child,
            #DivList .dataTables_scrollBody table tr td:first-child {
                width: 10%;
                
            }

             #DivList .dataTables_scroll table th:nth-child(2){
                 width: 35.1%;
             }

            #DivList .dataTables_scrollBody table tr td:nth-child(2) {
                width: 35.1%;
                font-size: 12px;
            }


            
            #DivList .dataTables_scroll table th:nth-child(5),
            #DivList .dataTables_scroll table th:nth-child(6) {
                width: 2.5%;
            }

            #DivList .dataTables_scrollBody table tr td:nth-child(5),
            #DivList .dataTables_scrollBody table tr td:nth-child(6)
             {
                width: 7%;
            }


            #DivList .dataTables_scroll table th:nth-child(3),
            #DivList .dataTables_scrollBody table tr td:nth-child(3){
                width: 10%;
            }

         
            #DivList .dataTables_scroll table th:nth-child(4){
                width: 12%;
            }
            #DivList .dataTables_scrollBody table tr td:nth-child(4) {
                width: 12%;
            }

           
            .clsGridTable .clsTRColumnHeader th, .clsGridTable td {
                width: 25%;
            }

            .modal-content {
                background-color: #fefefe;
                margin: 5% auto 15% auto;
                border: 1px solid #888;
                width: 560px;
                height: 40%;
            }

            .modal {
                position: fixed;
                top: -11%;
                right: 0;
                bottom: 0;
                left: 0;
                z-index: 1050;
                display: none;
                overflow: hidden;
                -webkit-overflow-scrolling: touch;
                outline: 0;
            }

            /*#headingOne {
                width: 104%;
                margin-left: -2%;
                margin-top: 1.5%;
            }*/

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

            #txttblsrch:focus, #myInput:focus, button:focus {
                outline: none;
            }

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
            /*Commented By Yasmin on 18th july 2018*/
            .col-md-7{
                /*margin-left: 42%/*60%*/ !IMPORTANT;*/
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

            /*#ShowHistoryGrid{
                width:102%;
            }*/

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

            .close {
                position: absolute!important;
                right: 9px!important;
                top: 5px!important;
                color: #fff !important;
                font-size: 20px!important;
                font-weight: bold!important;
                opacity: 1!important;
            }

            #historybutton{
                background-color: inherit;
                color: white;
                
            }

            .form-group{
                display : inline-flex !Important;
                border-bottom : none !IMPORTANT;
                padding-left: 21%;
            }

            .col, .col-1, .col-10, .col-11, .col-12, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-auto, .col-lg, .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-auto, .col-md, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-auto, .col-sm, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-auto, .col-xl, .col-xl-1, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-auto {
                position: UNSET;
                width: 100%;
                min-height: 1px;
                padding-right: 15px;
                padding-left: 15px;
            }

            #cboModifiedField, #cboModifiedBy{
                height: 23px !Important;
            }

            #purpose, #body, #subject, #comment {
                  border-radius : 3px !Important;
                  BORDER: 1PX SOLID #BBB;
                  color:black !important;
            }

            label {
                display: inline-block;
                margin-bottom: .5rem;
                width: 12em;
            }

            #mesageidlbl{
               
            }

            #id14 label, #id13 label {
                font-size: 12px !Important;
            }

            .bottom-bar{
                 margin-top: 1%;
            }

            #EmailSettings{
                /*overflow: auto;*/
                width:100%;
            }

           .fa-sort{
                 display:none;
    
            }

    #subject{
       height:56px
    
    }

     #body{
       height:56px
    
    }

     #comment{
       height:56px
    
    }

      #ShowHistoryGrid {
	        overflow-x: hidden !Important;
	        overflow-y: auto !Important;
	        padding-right: -1%!important;
	        width: 105%!important;
	        height: 197px!important;
	        padding-right: 2%!important;
	    }

	    #modalbody {
            overflow:hidden!important;
            height:201px!important;
	    }

        .form-horizontal{
            width:100%!important;
}
        #isSaveandAdd{
        float: right;
        margin-top: 5px;
        margin-left: 5px;
        display:block;
        background-color:white!important;
        color:white;
    }

      #ShowHistoryGrid .pagination {
    margin: -19px 2px !important;
}
            #ShowHistoryGrid .dataTables_scrollBody {

                background-color:white!important;
            }

     #ShowHistoryGrid .dataTables_length{
        display:none;
    
    }
            #DivList table.dataTable {
                border-collapse:collapse!important;
            }
     /*#ShowHistoryGrid  .dataTables_scrollHeadInner tr  th:nth-child(2){
       width: 19px!important;
    
    }*/

            /*#DivList table tr th {
                height:18px!important;
            }*/

     .alertify-notifier {

           font-size:14px!important;
           
	    }
            #ShowHistoryGrid {
                background-color:white!important;
            }

            #ShowHistoryGrid .odd
             {
               /* background-color:white!important;*/
            }

            #ShowHistoryGrid .table > thead > tr > td:nth-child(2) {
                width:25%!important;
           
            }

             #ShowHistoryGrid .table > thead > tr > th:nth-child(1) {
                width:16%!important;
           
            }

              #ShowHistoryGrid .table > thead > tr > th:nth-child(2) {
                width:14%!important;
           
            }


               #ShowHistoryGrid .table > thead > tr > th:nth-child(3) {
                width:9%!important;
           
            }

                 #ShowHistoryGrid .table > thead > tr > th:nth-child(4) {
                width:18%!important;
           
            }

                 .right {
                    float: right;
                    margin-top: 54%;
                    }


            .control-label {
                font-weight:100;
                margin-top:1.5%;
            }

            .RemoveBold {
                 font-weight:100;
            }

              #DivList {
            overflow-x:hidden!important;
        }

               #DivList {
    width: 102%;
    padding-right: 2%;
    /* overflow: auto; */
    /*height: 346px;*/
    overflow-x: hidden!important;
    overflow-y: auto!important;
}
       #DivList .dataTables_scrollBody .clsTRColumnHeader{
           height:0PX!important;
        }
        
       #EmailSettings {
    width: 102%;
    padding-right: 2%;
    /* overflow: auto; */
    /*height: 346px;*/
    overflow-x: hidden!important;
    overflow-y: auto!important;
}

            #headingOne a:hover {
                font-size:11px!important;
            }

             #headingOne a {
                font-size:11px!important;
            }

            #historybutton {
                cursor:pointer!important;
            }
             /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
          color: #bbb!important;
        }
        /*Added by Kashish on 27th June 2018 For Ui Change*/
            #divfilter {
                padding-bottom: 15px !important;
            }

            #page-top{padding:15px}
            .form-group .col-sm-3{width:auto}
            .control-label.col-sm-3{width:150px}
            .saveButton{margin-right:-53%!important}
            
        </style>

    <body class="" id="page-top">
         <form id="frmEmailMeassages" name="frmEmailMeassages" method="post"  enctype="multipart/form-data">
        <%PageInit()%>

        <%-- *************************************************** Modal Plotting **************************************************************** --%>
       <div id="id13" class="modal">

            <form class="modal-content animate" action="/action_page.php" style="width: 828px;" >
                <div class="imgcontainer">
                    <span class="appro-title">Show History</span>
                    <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close ">&times;</span>
                </div>
                <div class="container-fluid">
                   <%-- <div class="form-group">
                        <label class="control-label col-sm-3" for="request type">Modified Field</label>
                        <div class="col-sm-9">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 26", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="request type code">Modified By</label>
                        <div class="col-sm-9">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 26", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>
                    </div>--%>
                     <div class="form-group">
                        <label class="control-label col-sm-2 clslabel" for="request type">Modified Field</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 456", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                         <label class="control-label col-sm-2 clslabel" for="request type code">Modified By</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 456", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                    </div>
                    <div class="container-fluid" id="modalbody" style="overflow:auto;height: 160px;">
                    </div>
                </div>
            </form>
        </div>
           </form>
    </body>
       <!-- Bootstrap core JavaScript -->

        
        <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
        <script src="../../../Whizible2.0-new/dist/js/New_CommonFunctions.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/editor.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/timepicker.min.js"></script>
        <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
        <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>        
        <%--<script src="../../General/CommonFunctions.js"></script>
       <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>


    </html>
     <!--------------------------------------------------------------------------PAGE PLOTTING COMPLETE------------------------------------------------------------->
       
<script>
    var Msgid;
    var AjaxResult;

    $(document).ready(function () {
        var intDivGridHeight
           
        //if (WhichBrowser() == "IE") {
        //    intDivGridHeight = (window.innerHeight / 2);
        //    //alert(window.innerHeight)
        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //          $('.panel-body').css('padding-top', "0px");
        //          intDivGridListHeight = parseInt(window.innerHeight) - 378;
        //          //alert("1 -" + intDivGridListHeight)
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //          $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 200;
        //        //alert("2 -" + intDivGridListHeight)
        //    }
        //    else {
        //          $('.panel-body').css('padding-top', "15px");
        //          intDivGridListHeight = parseInt(window.innerHeight) - 10;
        //        //alert("3 -" + intDivGridListHeight)
                  
        //    }

        //    $('.panel-body').css('height', intDivGridListHeight + "px");
        //    $('#EmailSettings').css('height', intDivGridListHeight + 20);
        //    $('#EmailSettings').css('height', intDivGridListHeight - 400 + "px");


        //}
        //else {
        //    intDivGridHeight = (window.innerHeight / 2);
        
        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //          $('.panel-body').css('padding-top', "0px");
        //          intDivGridListHeight = parseInt(window.innerHeight) - 200;
                 
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //            $('.panel-body').css('padding-top', "0px");
                 
        //        intDivGridListHeight = parseInt(window.innerHeight) - 310;
        //        $('#EmailSettings').css('height', "490px");
        //    }
        //    else
        //    {
        //         $('.panel-body').css('padding-top', "15px");
        //         intDivGridListHeight = parseInt(window.innerHeight) - 325;
        //         $('#EmailSettings').css('height', "700px");
        //         $('#EmailSettings').css('overflow', "hidden");
        //    }
        //    intDivGridListHeight = parseInt(window.innerHeight);
        //   // $('#EmailSettings').css('height', intDivGridListHeight + 20);
        //    $('.panel-body').css('height', intDivGridListHeight - 280 + "px");
        //   // $('#EmailSettings').css('height', intDivGridListHeight + "px");
        //    $('#EmailSettings').css('overflow', "auto");
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
        datatables("DivList", "txttblsrch");


        document.getElementById("purpose").disabled = true;
        document.getElementById("subject").disabled = true;
        document.getElementById("body").disabled = true;
        document.getElementById("sendmailchkbox").disabled = true;
        document.getElementById("popupchkbox").disabled = true;
        document.getElementById("comment").disabled = true;
        $("#purpose").css("cursor", "none");
        $("#subject").css("cursor", "none");
        $("#body").css("cursor", "none");
        $("#comment").css("cursor", "none");
        $("#sendmailchkbox").css("cursor", "none");
        $("#popupchkbox").css("cursor", "none");

    });

    $(window).load(function () {

    });

    function Refresh() {

        var intDivGridHeight
           
        //if (WhichBrowser() == "IE") {
        //    intDivGridHeight = (window.innerHeight / 2);
        //    //alert(window.innerHeight)
        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //          $('.panel-body').css('padding-top', "0px");
        //          intDivGridListHeight = parseInt(window.innerHeight) - 378;
        //          //alert("1 -" + intDivGridListHeight)
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //          $('.panel-body').css('padding-top', "0px");
        //        intDivGridListHeight = parseInt(window.innerHeight) - 200;
        //        //alert("2 -" + intDivGridListHeight)
        //    }
        //    else {
        //          $('.panel-body').css('padding-top', "15px");
        //          intDivGridListHeight = parseInt(window.innerHeight) - 10;
        //        //alert("3 -" + intDivGridListHeight)
                  
        //    }

        //    $('.panel-body').css('height', intDivGridListHeight + "px");
        //    $('#EmailSettings').css('height', intDivGridListHeight + 20);
        //    $('#EmailSettings').css('height', intDivGridListHeight - 400 + "px");


        //}
        //else {
        //    intDivGridHeight = (window.innerHeight / 2);
        
        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //          $('.panel-body').css('padding-top', "0px");
        //          intDivGridListHeight = parseInt(window.innerHeight) - 200;
                 
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //            $('.panel-body').css('padding-top', "0px");
                 
        //        intDivGridListHeight = parseInt(window.innerHeight) - 310;
        //        $('#EmailSettings').css('height', "490px");
        //    }
        //    else
        //    {
        //         $('.panel-body').css('padding-top', "15px");
        //         intDivGridListHeight = parseInt(window.innerHeight) - 325;
        //         $('#EmailSettings').css('height', "700px");
        //         $('#EmailSettings').css('overflow', "hidden");
        //    }
        //    intDivGridListHeight = parseInt(window.innerHeight);
        //   // $('#EmailSettings').css('height', intDivGridListHeight + 20);
        //    $('.panel-body').css('height', intDivGridListHeight - 280 + "px");
        //   // $('#EmailSettings').css('height', intDivGridListHeight + "px");
        //    $('#EmailSettings').css('overflow', "auto");
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
        datatables("DivList", "txttblsrch");


        document.getElementById("purpose").disabled = true;
        document.getElementById("subject").disabled = true;
        document.getElementById("body").disabled = true;
        document.getElementById("sendmailchkbox").disabled = true;
        document.getElementById("popupchkbox").disabled = true;
        document.getElementById("comment").disabled = true;
        $("#purpose").css("cursor", "none");
        $("#subject").css("cursor", "none");
        $("#body").css("cursor", "none");
        $("#comment").css("cursor", "none");
        $("#sendmailchkbox").css("cursor", "none");
        $("#popupchkbox").css("cursor", "none");

   


    }

    function EnabledControl() {

        document.getElementById("purpose").disabled = false;
        document.getElementById("subject").disabled = false;
        document.getElementById("body").disabled = false;
        document.getElementById("sendmailchkbox").disabled = false;
        document.getElementById("popupchkbox").disabled = false;
        document.getElementById("comment").disabled = false;
        $("#purpose").css("cursor", "");
        $("#subject").css("cursor", "");
        $("#body").css("cursor", "");
        $("#comment").css("cursor", "");
        $("#sendmailchkbox").css("cursor", "");
        $("#popupchkbox").css("cursor", "");

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


    //function datatables(divID, txtBoxID) {
    //    $('#' + divID + ' table').removeClass("clsGridTable");
    //    $('#' + divID + ' table tbody tr').removeClass("clsTROdd");
    //    $('#' + divID + ' table tbody tr').removeClass("odd");

    //    $('#' + divID + ' table').addClass("table");
    //    var table = $('#' + divID + ' table').DataTable({
    //        responsive: true,
    //        pageLength: 3,
    //        scrollY: '130px',
    //        scrollX: false,
    //        autoWidth: false,
    //        //ordering: false,
    //        pagingType: "simple_numbers",
           
    //    });

    //    $("#" + divID + " .dataTables_scroll table th:nth-child(3)").css("text-align", "left");
    //    $("#" + divID + " .dataTables_scrollBody table tr:nth-child(3)").css("text-align", "left");

    //    if (txtBoxID != "") {
    //        $('#' + txtBoxID).on('keyup change', function () {
    //            table.search($(this).val()).draw();
    //        })
    //    }
    //}

    function datatables(divID, txtBoxID) {

        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");

        var table = $('#' + divID + ' > table').DataTable({
            //"ajax": {url: "{{ route('datatables') }}",
            ordering: false,
            responsive: true, "pageLength": 3,
            //scrollY: '165px',                                 //Commented by Usha Pandit on 18.12.2017 for Grid height
            scrollY: '115px',                                   //Added by Usha Pandit on 18.12.2017 for Grid height
            pagingType: "simple_numbers",
            scrollX: true,
            //url:"route('datatables')",
            language: {
                //paginate: {
                //    first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
                //    next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
                //    previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
                //    last: '<i class="fa fa-angle-right" title="Last"></i>'
                //}
            },
        });
        // debugger;
        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
            //Added by Usha on 18.12.2017 for showing only records containing keywords in searchbox
            if ($('#' + txtBoxID).val() != "") {
                table.search($('#' + txtBoxID).val()).draw();
                //table.refresh();
            }
            //End of addition
        }
    }

    function ModifiedFieldFilter_Change() {

        var ModifiedField = $('#cboModifiedField :selected').text();
        var ModifiedBy = $('#cboModifiedBy :selected').text();

        var obj = { "newModifiedField": ModifiedField, "MessageID": Msgid, "newModifiedBy": ModifiedBy };
        var myJSON = JSON.stringify(obj);

        var url = "CRM_EmailSettings.aspx/FilteredHistory"
        var result = AJAXCallWithResult(url, myJSON, false)
        $("#id13 #modalbody").html(result);
        document.getElementById('id13').style.display = 'block';
        datatables("ShowHistoryGrid", "");

    }

    function HideFooterPanel() {
        var isHidden = document.getElementById("footerpanelbody").style.visibility == "hidden";
        if (isHidden) {
            $("#footerpanelbody").css("visibility", "visible");
            $("#plus").css("display", "none");
            $("#minus").css("display", "block");
        }
        else {
            $("#footerpanelbody").css("visibility", "hidden");
            $("#plus").css("display", "block");
            $("#minus").css("display", "none");
        }

    }

    function UpdateEmailSettings() {
        if (Msgid == undefined) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please Edit atleast one entry for Updation..', 'error');
        }
        else {
            var sendmail = false;
            var mailpopup = false;

            var sbjct = $("#subject").val();
            var purpose = $("#purpose").val();
            var mailbody = $("#body").val();
            var cmnt = $("#comment").val();

            if (sbjct == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Enter the Subject..', 'error');
            }

            else {
                if (document.getElementById("sendmailchkbox").checked == true) {
                    sendmail = true;
                }
                if (document.getElementById("popupchkbox").checked == true) {
                    mailpopup = true;
                }

                var obj = { "Messageid": Msgid, "mailSubject": sbjct, "mailpurpose": purpose, "emailbody": mailbody, "mailcomment": cmnt, "sendmailbit": sendmail, "mailpopupbit": mailpopup };
                var myJSON = JSON.stringify(obj);

                $.ajax({
                    type: "POST",
                    url: 'CRM_EmailSettings.aspx/UpdateEmailSettingsDetails',
                    data: myJSON,
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    success: function (data) {
                        
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Message details updated Successfully', 'success');

                        var obj = { "flag": 1 };
                        var myJSON = JSON.stringify(obj);
                        $.ajax({
                            type: "POST",
                            url: 'CRM_EmailSettings.aspx/RefreshGrid',
                            //data: myJSON,
                            dataType: "json",
                            contentType: "application/json",
                            async: false,
                            success: function (data) {
                                $("#divgrid").html(data.d);
                                datatables("DivList", "txttblsrch")
                                ShowEntry(Msgid);
                               
                               
                            },
                            error: function (error) {
                                alert(error.responseText);
                            }
                        });

                    },
                    error: function (error) {
                        alert(error.responseText);
                    }
                });
            }
        }
    }

    function ShowEntry(messageid) {
        Msgid = messageid;
        EnabledControl();
        var obj = { "Messageid": messageid };
        var myJSON = JSON.stringify(obj);
        var url = "CRM_EmailSettings.aspx/GetEmailSettingsDetails"

        var result = AJAXCallWithResult(url, myJSON, false)

        var jsonData = JSON.parse(result)

        $.each(jsonData, function (id, obj)
        {


            $("#footerpanelbody").css("visibility", "visible");
            $("#plus").css("display", "none");
            $("#minus").css("display", "block");
            $("#divgrid").css("display", "none");
            $("#divfilter").css("display", "none");
            

            $("#mesageidlbl").html(messageid)
            $("#subject").val(obj.Subject)
            $("#purpose").val(obj.Purpose)
            $("#body").val(obj.Body)
            $("#comment").val(obj.Comments)
            if (obj.SendMail == true) {
                $("#sendmailchkbox").prop("checked", true);
            }
            else {
                $("#sendmailchkbox").prop("checked", false);
            }
            if (obj.ShowPopup == true) {
                $("#popupchkbox").prop("checked", true);
            }
            else {
                $("#popupchkbox").prop("checked", false);
            }
        });

    }

    //function DeleteMailSettings() {
    //    var stremailsettingIDs;
    //    var deleteflag;

    //    stremailsettingIDs = $('input[name=chkmailsettingDelete]:checked').map(function () {
    //        return this.value;
    //    }).get().join(',');


    //    if (stremailsettingIDs.length <= 0) {
    //        alertify.set('notifier', 'position', 'top-right');
    //        alertify.notify('Please select atleast one entry for deletion..', 'error');
    //    }
    //    else {
    //        if (stremailsettingIDs.length > 1) {
    //            deleteflag = 1;
    //        }
    //        else {
    //            deleteflag = 2;
    //        }

    //        alertify.confirm('', 'Are you sure, you want to delete the selected records?', function () {    
    //            if (deleteflag == 1) {
    //                var myJSON = JSON.stringify({ Messageid: stremailsettingIDs });
    //                var url = "CRM_EmailSettings.aspx/DeleteMultipleEmailSettingsDetails"
    //                var result = AJAXCallWithResult(url, myJSON, false)
    //            }
    //            else {
    //                var myJSON = JSON.stringify({ Messageid: stremailsettingIDs });
    //                var url = "CRM_EmailSettings.aspx/DeleteEmailSettingsDetails"
    //                var result = AJAXCallWithResult(url, myJSON, false)
    //            }

    //            if (result == 1) {
    //                alertify.set('notifier', 'position', 'top-right');
    //                alertify.notify('Message Deleted..', 'success');
    //                var url = "CRM_EmailSettings.aspx/RefreshGrid"
    //                var data = ""
    //                var result = AJAXCallWithResult(url, data, false)
    //                $("#divgrid").html(result);
    //                datatables("DivList", "txttblsrch")
    //                ClearFields()
    //            }
    //            else {
    //                alertify.set('notifier', 'position', 'top-right');
    //                alertify.notify('Error in deletion..', 'error');
    //            }
    //        }
    //        , function () {
    //            //return false;
    //        });

            
    //    }
    //}

    //function ClearMultipleSelecttion() {
    //    if ($("input[name=chkmailsettingDelete]:not(:disabled)").prop('checked', true)) {
    //        $("input[name=chkmailsettingDelete]:not(:disabled)").prop('checked', false);
    //    }
    //    if (document.getElementById('chkAllDeleteSeverity').checked == true) {
    //        $("input[name=chkAllDeleteSeverity]:not(:disabled)").prop('checked', false);
    //    }
    //}

    //function DeleteMultiple() {

    //    if (document.getElementById('chkAllDeleteSeverity').checked == true) {
    //        $("input[name=chkmailsettingDelete]:not(:disabled)").prop('checked', true);
    //    }
    //    else {
    //        $("input[name=chkmailsettingDelete]").prop('checked', false);
    //    }
    //}

    function ShowHistory_OnClick() {
        var obj = { "UniqueID": Msgid };
        var myJSON = JSON.stringify(obj);
        var url = "CRM_EmailSettings.aspx/ShowMailHistoryDetails"

        var result = AJAXCallWithResult(url, myJSON, false)

        if (Msgid == undefined) {       
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please Edit atleast one entry for showing history..', 'error');
        }
        else {
           // $("#ShowHistoryGrid table").addClass("table-stripped")
            $("#id13 #modalbody").html(result);
            
            document.getElementById('id13').style.display = 'block';
        }
        datatables("ShowHistoryGrid", "");
    }
    

    function ClearFields() {
        $("#mesageidlbl").html("")
        $("#subject").val("")
        $("#purpose").val("")
        $("#body").val("")
        $("#comment").val("")
        $("#sendmailchkbox").prop("checked", false);
        $("#popupchkbox").prop("checked", false);
    }


    function opentextdialog(frmName, txtObject, title, IsDisable, path) {
        //Function modified for Hotfix ID 2.0.37-SP4-WAF by UmeshJ 08-Sep-2006
        //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
        //var path=(arguments.length>4)?arguments[4]:'null'; 

        //objText = document.getElementById("subject");
      //  debugger;
        var RowIndex = (arguments.length > 5) ? arguments[5] : "0";
        var objText;
        if (RowIndex == "0")
            objText = GetObjectReference(frmName, txtObject);
        else
            objText = GetObjectReference(frmName, txtObject, true)[parseInt(RowIndex) - 1];
        RowIndex = '&RowIndex=' + RowIndex;
        //End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007
        var maxLength = (arguments.length > 6) ? arguments[6] : 1500;	//Modified By Ninad on 16 Jan 2008 IssueID-26590, pass maxlength ahead

        //Issue ID 28888
        title = replaceSubstring(replaceSubstring(replaceSubstring(title, "&", "%26"), "#", "%23"), "+", "%2b");

        var strDescription;
        if (title == null)
            title = "";
        if (path == null || path == '') {
            //Issue ID 28888
            if (window.showModalDialog) {
                strDescription = window.showModalDialog("../../General/TextDialogBox.aspx?Title=" + title + "&Disable=" + IsDisable + RowIndex + "&MaxLength=" + maxLength, objText, "dialogWidth:545px;dialogHeight:530px");
            } else {
                var strAddress;
                strAddress = "../../General/TextDialogBox.aspx?Title=" + title + "&Disable=" + IsDisable + "&ParentFormName=" + frmName + "&TextAreaName=" + txtObject + "&TextAreaValue=" + objText.value + RowIndex + "&MaxLength=" + maxLength;
                ShowWindow(strAddress, objText.value);
            }
        } else {
            //Issue ID 28888
            if (window.showModalDialog) {
                strDescription = window.showModalDialog(path + '?Title=' + title + "&Disable=" + IsDisable + RowIndex + "&MaxLength=" + maxLength, objText, "dialogWidth:545px;dialogHeight:530px");
            } else {
                var strAddress;
                strAddress = path + '?Title=' + title + "&Disable=" + IsDisable + "&ParentFormName=" + frmName + "&TextAreaName=" + txtObject + "&TextAreaValue=" + objText.value + RowIndex + "&MaxLength=" + maxLength;
                ShowWindow(strAddress, objText.value);
            }
        }

        if ((IsDisable == "False") && (window.showModalDialog)) {
            objText.value = strDescription;
        }
    }

</script>

<script>
    function openCity2(evt, cityName) {
        var i, tabcontent2, tablinks2;
        tabcontent2 = document.getElementsByClassName("tabcontent2");

        for (i = 0; i < tabcontent2.length; i++) {
            tabcontent2[i].style.display = "none";
        }
        tablinks2 = document.getElementsByClassName("tablinks2");
        for (i = 0; i < tablinks2.length; i++) {
            tablinks2[i].className = tablinks2[i].className.replace(" active", "");
        }
        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.className += " active";
    }
    // Get the element with id="defaultOpen" and click on it
    // document.getElementById("defaultOpen2").click();

    function Cancel() {

        $("#divgrid").css("display", "block");
        $("#divfilter").css("display", "block");
        ClearFields();
        document.getElementById("purpose").disabled = true;
        document.getElementById("subject").disabled = true;
        document.getElementById("body").disabled = true;
        document.getElementById("sendmailchkbox").disabled = true;
        document.getElementById("popupchkbox").disabled = true;
        document.getElementById("comment").disabled = true;
        $("#purpose").css("cursor", "none");
        $("#subject").css("cursor", "none");
        $("#body").css("cursor", "none");
        $("#comment").css("cursor", "none");
        $("#sendmailchkbox").css("cursor", "none");
        $("#popupchkbox").css("cursor", "none");
        Refresh();
    }
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

<%--<script>
    // Get the modal for Sevirity in show history button popup
    $('.modal').draggable();
    var modal = document.getElementById('id13');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>--%>
