<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Holiday_calender.aspx.vb" Inherits="PbNIT.Holiday_calender" %>

<!DOCTYPE html>
<html lang="en">

    <%CommonFunctions.General.PlotPageHeadTag("Setting")%>
  <head>
    <%--<meta charset="utf-8" />--%>
    <meta name="description" content="" />
    <meta name="author" content="" />
       <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>--%>
    <%--<title>Setting</title>--%>
      
<HEAD>
<!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
<%--<TITLE>Setting</TITLE>--%>
<meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
<meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
<meta name='vs_defaultClientScript' content='JavaScript'>
<meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache">
<link rel='stylesheet' type='text/css' href='../General/StyleSheetChanakya_Purple.css'/>
<link id='lnkWhizStyleSheetImgDir' type='text/plain' href=' images/purple/'/>
    
 <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
  
    <link href="../../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/OnlineFiles/css/Jquery.ui.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />

 <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
  
</HEAD>

   
      <link href=" slacss.css" rel="stylesheet" />


	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

<!-- time picker -->
<script>
    //$('.timepicker').pickatime()
</script>

  </head>

	<style>
     /*Added By Yasmin on 25th july 2018*/
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
        .v-tabs .tabcontent {
            float: left;
            padding: 0;
            border-style: solid;
            border-color: #647ea8;
            border-width: 0px 0px 0px 0px!important;
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
        font-size:13px;
        }
        #frmType {
        width:100%;
        }
       #divSubRequestType .dataTables_wrapper {
           padding-right:15px;
        padding-left: 0px;
        margin-right: auto;
        margin-left: auto;
         }
        #accordion {
        overflow:hidden;
        }
        .fa-pencil-square-o {
    color: #4caac0 !important;
}

        #DivHelpDeskSLA .dataTables_scroll {
  
    width: 100%!important;
}
        #DivHelpDeskSLA .dataTables_scrollBody {
    overflow: auto!important;
    width: 102%!important;
    height: 300px;
    padding-right: 2%!important;
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
            width:25%!important
        }
            #DivList table tr td:nth-child(2) {
            width:25%!important
        }
                #DivList table tr td:nth-child(3) {
            width:40%!important
        }

        /*#divGridSubRequestType table tr td:nth-child(1) {
            width:25%!important
        }
        #divGridSubRequestType table tr td:nth-child(2) {
            width:25%!important
        }
        #divGridSubRequestType table tr td:nth-child(3) {
            width:40%!important
        }*/
         #divGridSubRequestType .dataTables_scrollHeadInner table  .clsTRColumnHeader tr th:nth-child(4) {
            text-align:center;
        }
        #divGridSubRequestType .container-fluid {
     min-height: 0px !important; 
}

          #divStatus .container-fluid {
     min-height: 0px !important; 
}
        #collapseOne2 {
        overflow:hidden;
        }
         #collapseOne2 .panel-body {
           /*'/*commented by Kashish for ui change*/
           /*overflow: auto;*/
        /*height: 150px;*/
        width: 103%;
        padding-right: 2%;
        }
           #collapseOne3 {
        overflow:hidden;
        }
         #collapseOne3 .panel-body {
           overflow: auto;
        /*height: 150px;*/
        width: 103%;
        padding-right: 2%;
        }

        /*.dataTables_scrollBody .table tbody .even {
        background-color:#e8edf6;
        
        }*/

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
        font-weight:100;
        }
          #divStatus .dataTables_scrollHeadInner table  .clsTRColumnHeader tr th:nth-child(4) {
            text-align:left;
        }
          /*select.form-control:not([size]):not([multiple]) {
    height: calc(2.25rem + 7px);
        }*/
        #divPriority .container-fluid {
            min-height: 0px !important; 
        }
        
        #collapseOne4 {
            overflow:hidden;
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
            overflow:hidden;
        }
        #collapseOne5 .panel-body {
            overflow: auto;
            /*height: 150px;*/
            width: 103%;
            padding-right: 2%;
        }
        .form-horizontal{
    width: 100%;
    line-height: 2;
}
        #accordion4 .form-group {
        border-bottom:none;
        }

        #tblTypeSLADetails .clsTxtControls {
        width: 43px !important;
        } 
        #tblTypeSLADetails .clscboControls {
        width:79px !important;
        margin-left:4PX;
        }
       #tblTypeSLADetails .col-sm-4 {
        padding-right:30PX;
        }
       #tblTypeSLADetails .form-group {
       float:none;
       
        }
       #divEmpLogin .container-fluid {
        min-height:0px !important;
        }
        #CboType {
        width:75px;
        }

        #idSearchHistory {
    position: absolute;
    margin-top: 14px;
    margin-left: 10px;
}
        .panel-group {
        margin-bottom:0px !important;
        }
        #page-top {
       
        }
        .setting-src {
        padding:0px !important;
        }
    .selected_user
{
background: #cbddfa;
}
td{
      font-family: Verdana !important;
    font-size: 12px !important;
}
.bottom-bar input{
    height: 23px;
    padding: 0;
    font-size: 11px;
    border-radius: 3px;
    padding-left: 10px;
    border-color: #bbb;
    border-width: 1px;  
}
.form-group{

      border-bottom: 1px solid #ebedf2;
}
/*Chakshuta*/
 /*#Type {
       overflow: auto;
        height: 385px;
      }
 ::-webkit-scrollbar { 
    display: none; 
}*/
 .form-control {
    /* display: block; */
    width: 71%;
    height: 26px !important;
    padding: 6px 12px;
    font-size: 12px;
    /* line-height: 1.42857143; */
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
  #divScroll {
        width:102%;
        padding-right:2%;
        overflow:auto;
      }
  #divEmpLogin .collapseOne2 {
            overflow:hidden!important;
            width:100%!important;
        }
 /*#divEmpLogin {
        overflow: auto!important;
       height: 211px!important;
}*/
/*#divEmpLogin table tr th {
                height:36px!important;
            }*/
               #divEmpLogin table tr th:nth-child(3) {
                text-align:center;
            }
#idCalender {
            position: relative;
            top: -33px !important;
            /* right: -144px !important; */
            float: right;
            margin-right: 22% !important;
            margin-top : 4% !important;
        }
	    #dtHolidayDate {
            width:220px;
	    }
    #divEmpLogin .dataTables_scrollBody .clsTRColumnHeader{
        height:0px!important;
        }

        #divEmpLogin .dataTables_paginate {
            float:right!important;
        }
          #divEmpLogin .dataTables_paginate ul {
             margin-top: 2%!important;
             margin-left: -5%!important;
        }
#divEmpLogin .dataTables_scrollBody {
           overflow: auto!important;
            width: 101.7%!important;
            /*height: 132px!important;*/
            padding-right: 1.8%!important;
}

        #divEmpLogin .dataTables_scroll {
            overflow: hidden!important;
            width: 100%!important;

        }
 #divEmpLogin table tr th {
             border:1px solid #ddd!important;
              
            }
	    #EmployeeFilter {
            padding-bottom:15px !important;
	    }
	    #cboDepartment {
            height:29px;
	    }
	    #CboRole {
            height:29px;
	    }
	    #CboStatus {
             height:29px;
	    }
	    /*#CboUserName {
             height:29px;
	    }*/
          .dataTables_scrollBody, #modalbody {
                 -ms-overflow-style: none;
            }
            
/*Chakshuta*/
  /*Added By Dipali vekhande*/
	    .clslabel {
            margin-top:1.5%!important;
             font-size:12px!important;
	    }

        #idPlus {
            display:inline-block !important;
        }
	    #ShowHistoryGrid .dataTables_scrollBody {
            margin-top:-4%;
            background-color:white!important;
            overflow:auto;
            width:100%;
	    }

         #ShowHistoryGrid table tr th {
           width:130px!important;
           text-align:center!important;
	    }

          #ShowHistoryGrid table tr td {
           width:130px!important;
            text-align:center!important;
	    }

           /*#ShowHistoryGrid .clsTRColumnHeader {
           background-color:#641a02 !important;
           color:white!important;
	    }*/

	    #ShowHistoryGrid .dataTable no-footer {
            width:651px!important;
	    }

	    #ShowHistoryGrid {
	        overflow: auto !Important;
	        
	        padding-right: -1%!important;
	        width: 105%!important;
	        /*height: 158px!important;*/
	        padding-right: 2%!important;
	    }

	    #modalbody {
            overflow:hidden!important;
	    }
        .right .btn-default {
            background:white !important;
            color:black !important;
	    }
        .right .btn-default:hover {
            background:white !important;
            color:black !important;
	    }
     #isSaveandAdd{
        float: right;
        margin-top: 5px;
        margin-left: 5px;
        display:block;
        background-color:white!important;
        color:white;
    }
    /*Added by Usha Pandit on 18.12.2017 for alignment*/
	.alertify-notifier {
	    font-family: "Open Sans",sans-serif!important;
	    font-size: 14px !important;
	}
    /* End of addition*/
     .form-control:-ms-input-placeholder { /* IE 10+ */
          color: #bbb!important;
        }
      #EmployeeFilter {
                margin-top:-15px;
            }

    </style>

  <body class="" id="page-top">
       <%--<%PageInit("Load")%>--%>
       <%WriteTabsControls("", "Load", "")%>
    <!-- Navigation -->


   <div class="content-wrapper" style="margin-left: 0px !important;"><div class="container-fluid">
   <div class="request-details-pg clsSettings">
    <div class="v-tabs" style="width: auto;"><div id="" class="tabcontent">
      
       <div class="h-tabs" style="width:auto;" id="divMain">
       



            <div class="type-top-bar top-bar" id="Holiday_filter">
                  
                                   <ul class="right">
                       <li class="clearall"><button type="button" class="btn btn-default" onclick="AddEmployee()">Add<i class="fa fa-plus" aria-hidden="true"></i></button></li>
                                           <li class="clearall"><button type="button" class="btn btn-default" title="Delete" onclick="DeleteEmployee()">Delete<i class="fa fa-trash-o" aria-hidden="true"></i></button></li>

                                   </ul>

                     </div>
    

<div class="table-responsive" style="margin-top: -11px;border-bottom: 1px solid #e3e2e2 !important;
    margin-bottom: 9px;" >
  <div>

<style type="text/css">
{TABLE 
{TABLE-LAYOUT: fixed;}
THEAD TH.DivHelpDeskSLA {POSITION: relative;}
THEAD TH.DivHelpDeskSLA.locked {POSITION: relative;}
THEAD TH.DivHelpDeskSLA {Z-INDEX: 10; ; TOP:expression(document.getElementById('DivHelpDeskSLA').scrollTop -1)}
THEAD TH.DivHelpDeskSLA.locked {Z-INDEX: 30}
TH.DivHelpDeskSLA.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('DivHelpDeskSLA').scrollLeft); POSITION:relative()}
}
 </style>
<style type="text/css">
{TABLE 
{TABLE-LAYOUT: fixed;}
THEAD TH.Sort_DivHelpDeskSLA {POSITION: relative;}
THEAD TH.Sort_DivHelpDeskSLA.locked {POSITION: relative;}
THEAD TH.Sort_DivHelpDeskSLA {Z-INDEX:10; ; TOP:expression(document.getElementById('DivHelpDeskSLA').scrollTop -1)}
THEAD TH.Sort_DivHelpDeskSLA.locked {Z-INDEX: 30}
TH.Sort_DivHelpDeskSLA.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('DivHelpDeskSLA').scrollLeft); POSITION:relative()}
THEAD TH.Sort_DivHelpDeskSLA{border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: normal; font-size: 11px; padding-bottom: 1pt; border-left: thin; color: white; padding-top: 1pt; border-bottom: thin; font-family: Verdana, Arial; height: 22px; background: #3D5FA3; background-image: url(Images/BrickRed/columnhdr_sel_bg.gif);}}
 </style>
<style type="text/css">
{TABLE 
{TABLE-LAYOUT: fixed;}
THEAD TH.Separator_DivHelpDeskSLA {POSITION: relative;}
THEAD TH.Separator_DivHelpDeskSLA.locked {POSITION: relative;}
THEAD TH.Separator_DivHelpDeskSLA {Z-INDEX: 10; ; TOP:expression(document.getElementById('DivHelpDeskSLA').scrollTop -1)}
THEAD TH.Separator_DivHelpDeskSLA.locked {Z-INDEX: 30}
TH.Separator_DivHelpDeskSLA.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('DivHelpDeskSLA').scrollLeft); POSITION:relative()}
THEAD TH.Separator_DivHelpDeskSLA {border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: bolder; font-size: 1pt; background-image: none; padding-bottom: 1pt; border-left: thin; width: 1px; color: black; padding-top: 1pt; border-bottom: thin; height: 22px; background-color: #D3E4FB;}
}
 </style>
<style type="text/css">{
TABLE {TABLE-LAYOUT: fixed;}
THEAD TH.DivHelpDeskSLA_Column {POSITION: relative;}
THEAD TH.DivHelpDeskSLA_Column.locked {POSITION: relative;}
THEAD TH.DivHelpDeskSLA_Column.locked {Z-INDEX: 30}
THEAD TH.DivHelpDeskSLA_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('DivHelpDeskSLA').scrollTop -1)}
TH.DivHelpDeskSLA_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('DivHelpDeskSLA').scrollLeft); POSITION:relative()}

 }</style>
<style type="text/css">{
TABLE {TABLE-LAYOUT: fixed;}
THEAD TH.Separator_DivHelpDeskSLA_Column {POSITION: relative;}
THEAD TH.Separator_DivHelpDeskSLA_Column.locked {POSITION: relative;}
THEAD TH.Separator_DivHelpDeskSLA_Column.locked {Z-INDEX: 30}
THEAD TH.Separator_DivHelpDeskSLA_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('DivHelpDeskSLA').scrollTop -1)}
TH.Separator_DivHelpDeskSLA_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('DivHelpDeskSLA').scrollLeft); POSITION:relative()}
THEAD TH.Separator_DivHelpDeskSLA {border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: bolder; font-size: 1pt; background-image: none; padding-bottom: 1pt; border-left: thin; width: 1px; color: black; padding-top: 1pt; border-bottom: thin; height: 22px; background-color: #D3E4FB;}

 }</style>
<style type="text/css">{
TABLE {TABLE-LAYOUT: fixed;}
THEAD TH.Sort_DivHelpDeskSLA_Column {POSITION: relative;}
THEAD TH.Sort_DivHelpDeskSLA_Column.locked {POSITION: relative;}
THEAD TH.Sort_DivHelpDeskSLA_Column.locked {Z-INDEX: 30}
THEAD TH.Sort_DivHelpDeskSLA_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('DivHelpDeskSLA').scrollTop -1)}
TH.Sort_DivHelpDeskSLA_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('DivHelpDeskSLA').scrollLeft); POSITION:relative()}
THEAD TH.Sort_DivHelpDeskSLA_Column {border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; font-weight: normal; font-size: 11px; padding-bottom: 1pt; border-left: thin; color: white; padding-top: 1pt; border-bottom: thin; font-family: Verdana, Arial; height: 22px; background: #3D5FA3; background-image: url(Images/BrickRed/columnhdr_sel_bg.gif);}
 }</style>

<style type="text/css">
Td.Locked, th.Locked {

left: expression(document.getElementById('DivHelpDeskSLA').scrollLeft);
position: relative;
z-index: 5;
}
</style>
<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer"><div class="row"></div><div class="row"><div class="col-sm-12"><div class="dataTables_scroll"><div class="dataTables_scrollHead" style="overflow: hidden; position: relative; border: 0px; width: 100%;"><div class="dataTables_scrollHeadInner" style="box-sizing: content-box; width: 1153px; padding-right: 58px;"><table class="table table-bordered table-stripped dataTable no-footer" cellpadding="0" cellspacing="1" width="99.9%" role="grid" style="margin-left: 0px; width: 1270px;" class="table-fixed"><thead class="clsTRColumnHeader ">
<tr role="row"><th align="left" class="DivHelpDeskSLA sorting_asc clsTRColumnHeader th" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 363px;" aria-sort="ascending" aria-label="Template Name: activate to sort column descending">Holiday Calender</th><th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 206px;" aria-label="Description: activate to sort column ascending">Holiday Date</th><th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 500px; text-align: center;" aria-label="Created Date: activate to sort column ascending"> Delete  </th>




</tr></thead></table></div></div><div class="dataTables_scrollBody" style="position: relative; overflow: auto; width: 100%; height: -1px;"><table class="table table-bordered table-stripped dataTable no-footer" cellpadding="0" cellspacing="1" width="99.9%" id="DataTables_Table_0" role="grid" aria-describedby="DataTables_Table_0_info" style="width: 99.9%;"><thead class="clsTRColumnHeader">
<tr role="row" style="height: 0px;"><th align="left" class="DivHelpDeskSLA sorting_asc" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 431px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; height: 0px;" aria-sort="ascending" aria-label="Template Name: activate to sort column descending"><div class="dataTables_sizing" style="height:0;overflow:hidden;">Template Name</div></th><th align="left" class="DivHelpDeskSLA sorting" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 430px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; height: 0px;" aria-label="Description: activate to sort column ascending"><div class="dataTables_sizing" style="height:0;overflow:hidden;">Description</div></th><th align="left" class="DivHelpDeskSLA sorting" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 197px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; height: 0px;" aria-label="Created Date: activate to sort column ascending"><div class="dataTables_sizing" style="height:0;overflow:hidden;">Created Date</div></th><th align="left" class="DivHelpDeskSLA sorting" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 104px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; height: 0px;" aria-label="Select: activate to sort column ascending"><div class="dataTables_sizing" style="height:0;overflow:hidden;">Select</div></th>

<tbody>






    
    






	<tr class="clsTREvenRow odd" role="row">
<td valign="top" align="left" title="Template Name" class="sorting_1">
Diwali</td>
<td valign="top" align="left" title="Description">11-Jan-2013
</td>
<td valign="top" align="center" title="Created Date"><input type="checkbox" id="chkchkSLATemplateDelete" name="chkchkSLATemplateDelete" value="2" style="margin-left:25px;">
</td>
<td valign="top" align="center" title="Created Date">
</td><td align="center" title="Delete"></td>

</tr>


<tr class="clsTROdd even" role="row">
<td valign="top" align="left" title="Template Name" class="sorting_1">
Diwali</td>
<td valign="top" align="left" title="Description">
11-Jan-2013</td>
<td valign="top" align="center" title="Created Date">
<input type="checkbox" id="Checkbox1" name="chkchkSLATemplateDelete" value="2" style="margin-left:25px;"></td>
<td valign="top" align="center" title="Created Date">
</td><td align="center" title="Delete"></td></tr>

	<tr class="clsTREvenRow odd" role="row">
<td valign="top" align="left" title="Template Name" class="sorting_1">
Diwali</td>
<td valign="top" align="left" title="Description">11-Jan-2013
</td>
<td valign="top" align="center" title="Created Date"><input type="checkbox" id="Checkbox2" name="chkchkSLATemplateDelete" value="2" style="margin-left:25px;">
<td valign="top" align="center" title="Created Date">
</td><td align="center" title="Delete"></td>
</td>


</tr>
<tr class="clsTROdd even" role="row">
<td valign="top" align="left" title="Template Name" class="sorting_1">
Diwali</td>
<td valign="top" align="left" title="Description">
11-Jan-2013</td>
<td valign="top" align="center" title="Created Date">
<input type="checkbox" id="Checkbox3" name="chkchkSLATemplateDelete" value="2"  style="margin-left:25px;"></td>
<td valign="top" align="center" title="Created Date">
</td><td align="center" title="Delete"></td></tr>
</tr></tbody></table></div></div></div></div>





<div class="row"><div class="col-sm-12 col-md-5"><div class="dataTables_info" id="DataTables_Table_0_info" role="status" aria-live="polite">Showing 1 to 5 of 39 entries</div></div><div class="col-sm-12 col-md-7"><div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate"><ul class="pagination"><li class="paginate_button page-item previous disabled" id="DataTables_Table_0_previous"><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li><li class="paginate_button page-item active"><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0" class="page-link">1</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0" class="page-link">2</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0" class="page-link">3</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0" class="page-link">4</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="5" tabindex="0" class="page-link">5</a></li><li class="paginate_button page-item disabled" id="DataTables_Table_0_ellipsis"><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="6" tabindex="0" class="page-link">…</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="7" tabindex="0" class="page-link">8</a></li><li class="paginate_button page-item next" id="DataTables_Table_0_next"><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="8" tabindex="0" class="page-link">Next</a></li></ul></div></div></div>
</div>
</div>



      </div>


      <div class="bottom-bar" id="divTypeBottom"><div class="pannel-section"><div class="col-md-12 col-sm-12" style="padding-left: 15px; padding-right: 15px;"><div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true"> <div class="panel"> <div class="panel-heading" role="tab" id="headingOne2"><h3><span>Holiday Calender<i class="fa fa-plus" style="float: none; padding-left: 10px;"></i></span></h3><h4 class="panel-title"><a role="button" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne5" aria-expanded="true" aria-controls="collapseOne4"><i class="fa fa-plus toggle-plus"></i><i class="fa fa-minus toggle-plus"></i></a></h4></div> <div id="collapseOne5" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne" aria-expanded="true" style="">

    <div class="panel-body" id="idPanelBody">  
<form class="form-horizontal" action="/action_page.php">

   

        <div class="form-group" style="    border-bottom: 1px solid #ebedf2;">

           <label class="control-label col-sm-2" for=" " style="text-align: right;font-size: 11px;padding-top: 2px;">Holiday Name   </label>
<div class="col-sm-4"> 
               <input type="Textbox" name="txtOrderNumber" id="txtOrderNumber" class="form-control" style=" text-align:Left" value=""> </div>
            </div>
     





             </div>
			 </form>
			 <form class="form-horizontal" action="/action_page.php">

   

        <div class="form-group" style="    border-bottom: 1px solid #ebedf2;">

           <label class="control-label col-sm-2" for=" " style="text-align: right;font-size: 11px;padding-top: 2px;">Holiday Date  </label>
<div class="col-sm-4"> 
               <input type="Textbox" name="txtOrderNumber" id="Textbox1" class="form-control" style=" text-align:Left" value=""> </div>
			   <i class="fa fa-calendar" style="margin-left:-93px;"></i>
            </div>
     

<div class="form-group"><div class="col-sm-12" style="margin-top: 5px;">
    <div class="left"></div>
<div class="right">
    <button type="button" id="btnSave" style="margin-left: 2px;font-size: 11px;line-height: 10px;    background: #4b3b86 !important;
    color: white!important;
    border-color: #4b3b86 !important;" onclick="SaveDepartmentDetails(&quot;Save&quot;)" class="btn btn-default save">Save</button>
    <button type="button" class="btn btn-default " onclick="minimizePanel(&quot;panelDepartment&quot;)" style="border:none;border-left:1px solid;font-size: 11px;line-height: 12px;    background: #4b3b86 !important;
    color: white!important;
    border-color: #4b3b86 !important;">Cancel</button>
</div>
</div>
</div>



             </div>
			 </form>
          </div>
     </div>
  </div>
 </div>
</div>
</div>

    </div>
  </div>
</div>
</div>
</div>
    <!-- /.content-wrapper -->
    <!-- /.content-wrapper -->
 <%--PlotGridControls(cityName);
  RefreshGrid('UserMaster');--%>
</body>
     <%-- *************************************************** Modal Plotting **************************************************************** --%>
        <div id="id13" class="modal">

            <form class="modal-content animate" action="/action_page.php">
                <div class="imgcontainer">
                    <span class="appro-title">Show History</span>
                    <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close">&times;</span>
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
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 26", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                         <label class="control-label col-sm-2 clslabel" for="request type code">Modified By</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 26", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                    </div>
                    <div class="container-fluid" id="modalbody" style="overflow:auto;height: 160px;">
                    </div>
                </div>
            </form>
        </div>
        
   
  
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
	<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>

   


<script src=" EnhancementFiles/js/timepicker.js"></script>
<script src=" EnhancementFiles/New_CommonFunctions.js"></script>

    <script src="../../General/CommonFunctions.js"></script>
        <script src="../../../EnhancementFiles/js/editor.js"></script>
    <link href="../../../EnhancementFiles/OnlineFiles/datepicker/datepicker3.css" rel="stylesheet" />
       <script src="../../../EnhancementFiles/OnlineFiles/datepicker/bootstrap-datepicker.js"></script>
  
<script>
    $(document).ready(function () {
        //var bodyHeight = window.innerHeight - $('#frmSettingsTabs').offset().top;
        
        //$('#frmSettingsTabs').css('height', bodyHeight + 200 + 'px');
        //var table = $('#DataTables_Table_0').dataTable();
        //alert(table.fnGetData().length);
        //EditHolidayID = 0;
        RefreshGridDetails();
        $('#dtHolidayDate').datepicker();
    });
  

    //Added by Dipali on 16th Dec for Close LogOut Pop_up
    $(document).click(function () {
        //alert(window.parent.parent.parent.location);
        $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

    })
    //End of Added by Dipali on 16th Dec for Close LogOut Pop_up

</script>
    
<script>
    var EditHolidayID = 0;
    var arrSelectedCheck = new Array();
    function openCity(evt, cityName, strTabURL) {

        $(".btnSettingTab").removeClass("active");
        evt.currentTarget.className += " active";

        setFrameLoader();

        $("#frmSettingsTabs").attr("src", "" + strTabURL + "");
       
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
    // Get the element with id="defaultOpen" and click on it
    //document.getElementById("defaultOpen").click();
    function AddHoliday() {
       
        $("#txtHolidayName").val("");
        $("#dtHolidayDate").val("");
        $("#EmployeeFilter").css("display", "none"); //Added by Usha Pandit on 18.12.2017
        $("#History").css("display", "none");
        $("#divRequestTypes").css("display", "none");
        $("#collapseOne2").addClass('in');
        $("#collapseOne2").css('height', 'auto!important');

        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto!important');
           
        }
        EditHolidayID = 0;

        $("#collapseOne2").css('height', '');
    }
   

    function Cancel_Holiday() {
        $("#EmployeeFilter").css("display", "block"); //Added by Usha Pandit on 18.12.2017
        $("#divRequestTypes").css("display", "block");
        $("#History").css("display", "none");
        $("#txtHolidayName").val("");
        $("#dtHolidayDate").val("");
        EditHolidayID = 0;
        RefreshGrid("Type", "Flag");
    }

    function SelectHolidayAll_Checkbox(obj) {
        // $("input[name=chkchkRoleMasterSelect]").prop('checked', true);
        var table = $('#divEmpLogin table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if ($(obj).is(':checked'))
            //  $("input[name=chkchkRoleMasterSelect]").prop('checked', true);
            //$("input[name=chkHolidayDelete]:not(:disabled)").prop('checked', true);
            $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
        else
            //$("input[name=chkHolidayDelete]").prop('checked', false);
            $('input[type="checkbox"]', rows).prop('checked', false);
    }
    //function DeleteEmployee() {
    //}
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
    
    //function RefreshGrid(cityName, Flag) {
    //    var strResult, data;
    //    var GridParameter = {};

       
    //    GridParameter.cityName = "Type";
    //    cityName = "Type";

       
    //    //alert(Status)
    //    if (Flag != "") {
    //        //data = JSON.stringify({ GridParameter: GridParameter });
    //        data = JSON.stringify({ GridParameter: GridParameter, Department: Department, Role: Role, Status: Status });

    //        strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
    //        var DivId;
    //        var DivSerach;
    //        //  alert(strResult.d);
    //        if (strResult.d != '') {

    //            DivId = "DivList";
    //            DivSerach = "txtSearchHistory";

    //            $("#divRequestTypes").html("");
    //            $("#divRequestTypes").html(strResult.d);

    //            $(".table-responsive:first table").addClass("table");


    //        }

    //    }
    //    RefreshGridDetails(Flag);
    //}
    function RefreshGrid(cityName, Flag) {
        var strResult, data;
        var GridParameter = {};
        //DivId = "DivList";
        //DivSerach = "txtSearchHistory";
        cityName = "Holiday";

        GridParameter.cityName = cityName;
        if (Flag != "") {
            data = JSON.stringify({ GridParameter: GridParameter });

            strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
            var DivId;
            var DivSerach;

            //$("#divRequestTypes").html("");
            //$("#divRequestTypes").html(strResult.d);
            

            DivId = "DivList";
            DivSerach = "txtSearchHistory";

            $("#divRequestTypes").html("");
            $("#divRequestTypes").html(strResult.d);

            $("#History").css("display", "none");
            $(".table-responsive:first table").addClass("table");




        }
        RefreshGridDetails();
    }
    //Commented and added by Usha Pandit on 20.12.2017 for setting height
    //function RefreshGridDetails(Flag) {
    //    //  debugger;

    //    var strResult, data;
    //    var GridParameter = {};
    //    var DivId;
    //    var DivSerach;
       
    //    DivId = "divEmpLogin";
    //    DivSerach = "txtSearchHistory";

    //    var TypeDiv; var accordion;
    //    var intDivGridHeight

    //    if (WhichBrowser() == "IE") {
    //        intDivGridHeight = (window.innerHeight / 2);
            
    //        if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
               
    //            intDivGridListHeight = parseInt(window.innerHeight) - 500;
    //            $('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');
    //            $('#divScroll').css('height', intDivGridListHeight + 155 + 'px');
    //        }

    //        else if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024)) {
               
    //            intDivGridListHeight = parseInt(window.innerHeight) - 355;
    //            $('#divRequestTypes').css('height', intDivGridListHeight - 150 + 'px');
    //            $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
    //        }
    //        else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
              
    //            intDivGridListHeight = parseInt(window.innerHeight) - 200;
    //        }
    //        else {
               
    //            intDivGridListHeight = parseInt(window.innerHeight) - 100;
                
    //        }
    //        $('#divRequestTypes').css('height', intDivGridListHeight - 650 + 'px');
    //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
    //    }
    //    else {
    //        intDivGridHeight = (window.innerHeight / 2);

    //        if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
    //            //alert(1);
    //            intDivGridListHeight = parseInt(window.innerHeight) - 370;
    //            //alert(intDivGridListHeight + 100);
    //            //$('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');
    //            $('#divScroll').css('height', intDivGridListHeight + 100 + 'px');
    //        }

    //        else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
    //            //alert(2);
    //            intDivGridListHeight = parseInt(window.innerHeight) - 360;
    //            $('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');

    //            $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
    //        }
    //        else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
    //            //alert(3);
    //            intDivGridListHeight = parseInt(window.innerHeight) - 470;
    //            $('#divRequestTypes').css('height', intDivGridListHeight - 80 + 'px');

    //            $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
    //        }
    //        else {
    //            //alert(4);
    //            intDivGridListHeight = parseInt(window.innerHeight) - 570;
    //            //alert(intDivGridListHeight+80);
    //            //$('#divRequestTypes').css('height', intDivGridListHeight - 250 + "px");

    //            //$('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
    //        }

    //        $('#divRequestTypes').css('height', intDivGridListHeight - 200 + 'px');
    //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');

    //        //    $('#Type').css('height', intDivGridListHeight + 500  + "px");
    //    }

    //    //   $(".table-responsive:first table").addClass("table");
       
       
    //    //if (count > 0) {          
    //        datatables(DivId, DivSerach, intDivGridListHeight);
    //       // setWidthDatatable(DivId);
    //    //}
        
        

    //}
   
    function RefreshGridDetails(Flag) {
        //  debugger;

        var strResult, data;
        var GridParameter = {};
        var DivId;
        var DivSerach;

        DivId = "divEmpLogin";
        DivSerach = "txtSearchHistory";

        var TypeDiv; var accordion;
        var intDivGridHeight

        //if (WhichBrowser() == "IE") {
        //    intDivGridHeight = (window.innerHeight / 2);

        //    /* Added by Usha pandit on 19.12.2017 to minimize sub Type grid height */
        //    if ((parseInt(window.innerHeight) <= 850 && parseInt(window.innerWidth) <= 1072)) {

        //        //alert(window.innerHeight);
        //        //alert(window.innerWidth);
        //        intDivGridListHeight = parseInt(window.innerHeight) - 500;


        //        $('#divRequestTypes').css('height', intDivGridListHeight - 120 + 'px');
        //        $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');

        //    }
        //        /* End of addition by Usha pandit */

        //    else if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

        //        intDivGridListHeight = parseInt(window.innerHeight) - 500;
        //        $('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');
        //        $('#divScroll').css('height', intDivGridListHeight + 155 + 'px');
        //    }

        //    else if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024)) {

        //        intDivGridListHeight = parseInt(window.innerHeight) - 355;
        //        $('#divRequestTypes').css('height', intDivGridListHeight - 150 + 'px');
        //        $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

        //        intDivGridListHeight = parseInt(window.innerHeight) - 200;
        //    }
        //    else {

        //        intDivGridListHeight = parseInt(window.innerHeight) - 145;

        //        $('#divRequestTypes').css('height', intDivGridListHeight - 680 + 'px');
        //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');

        //    }

        //}
        //else {
        //    intDivGridHeight = (window.innerHeight / 2);

        //    if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
        //        //alert(1);
        //        intDivGridListHeight = parseInt(window.innerHeight) - 370;
        //        //alert(intDivGridListHeight + 100);
        //        //$('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');
        //        $('#divScroll').css('height', intDivGridListHeight + 100 + 'px');
        //    }

        //    else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
        //        //alert(2);
        //        intDivGridListHeight = parseInt(window.innerHeight) - 360;
        //        $('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');

        //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //        //alert(3);
        //        intDivGridListHeight = parseInt(window.innerHeight) - 470;
        //        $('#divRequestTypes').css('height', intDivGridListHeight - 80 + 'px');

        //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
        //    }
        //    else {

        //        intDivGridListHeight = parseInt(window.innerHeight) - 580;

        //        //$('#divRequestTypes').css('height', intDivGridListHeight - 250 + "px");

        //        //$('#divScroll').css('height', intDivGridListHeight + 450 + 'px');

        //        $('#divRequestTypes').css('height', intDivGridListHeight - 250 + 'px');
        //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
        //    }



        //    //    $('#Type').css('height', intDivGridListHeight + 500  + "px");
        //}

        //   $(".table-responsive:first table").addClass("table");
        var intDivGridHeight, intDivGridListHeight
        intDivGridListHeight = parseInt(window.innerHeight);
        if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

            $("#divScroll").css('height', intDivGridListHeight - 280 + "px");
        }

        else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

            $("#divScroll").css('height', intDivGridListHeight - 320 + "px");
        }
        else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

            $("#divScroll").css('height', intDivGridListHeight - 280 + "px");
        }
        else {
            $("#divScroll").css('height', intDivGridListHeight - 280 + "px");
        }


        //if (count > 0) {          
        datatables(DivId, DivSerach, intDivGridListHeight);
        // setWidthDatatable(DivId);
        //}
    }

    //End of Addition by Usha Pandit  on 20.12.2017 for setting height
    function datatables(divID, txtBoxID) {
       
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        
        var table = $('#' + divID + ' > table').DataTable({
            //"ajax": {url: "{{ route('datatables') }}",
            ordering: false,
            responsive: true, "pageLength":3,
            //scrollY: '165px',                                 //Commented by Usha Pandit on 18.12.2017 for Grid height
            //scrollY: '115px',                                   //Added by Usha Pandit on 18.12.2017 for Grid height
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
    
    function setWidthDatatable(divID) {
        //alert(divID);
        var tblTotal = document.getElementById(divID).getElementsByClassName('dataTable')[0];
        var tblDetails = document.getElementById(divID).getElementsByClassName('dataTable')[1];
        //if (WhichBrowser() != 'FF') {
        
        console.log(tblDetails)
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
    var strPageName = "Holiday_calender.aspx"
    function DeleteHoliday() {
        var strHolidayIDs;
        var table = $('#divEmpLogin table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        //strHolidayIDs = $('input[name=chkHolidayDelete]:checked').map(function () {
        //    return this.value;
        //}).get().join(',');
        //strHolidayIDs = $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true).map(function () {
        //    return this.value;
        //}).get().join(',');

        if (document.getElementById('chkHolidaySelect').checked == true) {
            strHolidayIDs = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                return this.value;
            }).get().join(',');
        }
        else {
            //strHolidayIDs = $('input[name=chkHolidayDelete]:checked').map(function () {
            //    return this.value;
            //}).get().join(',');
            strHolidayIDs = arrSelectedCheck.join();
        }

        //alert(strHolidayIDs);
        if (strHolidayIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');         //added by Usha Pandit on 18.12.2017
            alertify.notify('Please select at least one Holiday record for deletion', 'error');  //added by Usha Pandit on 18.12.2017
            return;
        }
        data = JSON.stringify({ HolidayID: strHolidayIDs });

        strResult = AJAXCallWithResult(strPageName + "/DeleteHoliday", data, false);
        //alert(strResult.d);
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Holiday deleted successfully', 'success');

        RefreshGrid("Type", strResult.d);
       

    }
    var g_sResponseText = '';
    var g_oValidateXMLHttp;
    function ValidateData(strURL, MasterTagID, ParentTagID, strFocusOnControl) {
        //start .Added mode option in parameter list to the function         
        var blnPROGFlag = (arguments.length > 5) ? arguments[5] : 0;
        //End
        var strResult;
        var strNavigator;
        g_sResponseText = '';
        strNavigator = navigator.appName;
        strNavigator = strNavigator.toUpperCase();
        var browser = isIE();


        strURL = "../PasswordManagement/Ajax_XMLHttp.aspx?MasterTagID=" + MasterTagID + "&ParentTagID=" + ParentTagID + "&" + strURL;


        if (browser == 'IE') {
            g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
            //hook the event handler
            g_oValidateXMLHttp.onreadystatechange = GetResponseText;
            //prepare the call, http method=GET, false=asynchronous call
            g_oValidateXMLHttp.open("POST", strURL, false);
            //finally send the call
            g_oValidateXMLHttp.send();
        }
        else {
            // Mozilla - based browser 
            g_oValidateXMLHttp = new XMLHttpRequest();
            //hook the event handler
            g_oValidateXMLHttp.onreadystatechange = GetResponseText();
            //prepare the call, http method=GET, false=asynchronous call
            g_oValidateXMLHttp.open("POST", strURL, false);
            //finally send the call
            g_oValidateXMLHttp.send(null);
        }

        if (g_oValidateXMLHttp.responseText != null) {
            strResult = g_oValidateXMLHttp.responseText;
        }
        return strResult;
    }



    function GetResponseText() {
        if (g_oValidateXMLHttp.readyState == 4) {
            if (g_oValidateXMLHttp.responseText != null) {
                g_sResponseText = g_oValidateXMLHttp.responseText;
            }
        }
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
    function isDate(obj) {
        if (obj == null) { return true; }
        if (isBlank(getInputValue(obj))) { return true; }
        var msg = (arguments.length > 1) ? arguments[1] : "";
        var dofocus = (arguments.length > 2) ? arguments[2] : true;
        if (parseDate(getInputValue(obj))) {
            if (!isBlank(msg)) { alert(msg); }
            if (dofocus) {
                setFocus(obj);
            }
            return false;
        }
        return true;
    }
    function ValidateLoginType()
    {
        var chkVal = 0;
        var txtHolidayName = $("#txtHolidayName").val();
        var dtHolidayDate = $("#dtHolidayDate").val();


        //if (strHolidaySaveAndAddFlag == 1) {
        //    EditHolidayID = 0;
        //}

        var strMsg = "";
        if ($("#txtHolidayName").val() == "") {
            strMsg += "<li> Holiday Name should not be left blank </li><br>";
            chkVal = 1;

            //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            $("#txtHolidayName").focus();
            //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
        }
        if ($("#dtHolidayDate").val() == "") {
            strMsg += "<li> Holiday Date should not be left blank </li><br>";
            chkVal = 1;

            //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            var hasFocus = $('#txtHolidayName').is(':focus');
            if (hasFocus) {

            }
            else {
                $("#dtHolidayDate").focus();
            }
            //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
        }
        //alert(isDate(document.getElementById('dtHolidayDate')));
        if (isDate(document.getElementById('dtHolidayDate')) == false) {
            strMsg += "<li> Invalid Date format or Invalid Date. </li><br>";
            chkVal = 1;
        }
        //date1 = formatDate(dtHolidayDate.replace(/[\n\t\r]/g, ""));
        //if (String(date1) == "Invalid Date") {
        //    date1 = "0";
        //    strMsg += "<li>- Invalid Date </li>";
        //    chkVal = 1;
        //}

        //var pattern = /^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/;
        //var validateDate = pattern.test(dtHolidayDate);
        //    if(validateDate)
        //    {
                
        //    }
        //    else
        //    {
        //        strMsg += "<li> Invalid Date </li>";
        //        chkVal = 1;
        //    }
       
        //if (disallowSpecialCharacters(document.getElementById('txtHolidayName')) == true) {
        //    strMsg = '- A Holiday Name cannot contain any of these /\\:*?<>|,"+- characters.';
        //    errorMsg += "<li>" + strMsg + "</li>";
        //    chkVal = 1;
        //}

        //var regex = new RegExp("^[0-9a-zA-Z\b ]+$");
        //var regex = new RegExp("[/:*?+\"><|,\\\\]");
        //var str = document.getElementById("txtHolidayName").value;
        //if (regex.exec(str) == null) {

        //    strMsg += "<li> A Holiday Name cannot contain any of these /\\:*?<>|,+- characters. </li>";
        //    chkVal = 1;
        //} 

        if (dtHolidayDate != "") {
            data = JSON.stringify({ HolidayDate: dtHolidayDate, HolidayID: EditHolidayID });
            //alert(data);
            var strResult1 = AJAXCallWithResult("Holiday_calender.aspx/IsDuplicateHolidayDate", data, false);
            //alert(strResult1.d);
            if (strResult1 != undefined) {

                if (strResult1.d == "1") {

                    strMsg += "<li> Holiday Date already exists </li><br>";
                    chkVal = 1;

                    //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                    var hasFocus = $('#txtHolidayName').is(':focus');
                    if (hasFocus) {

                    }
                    else {
                        $("#dtHolidayDate").focus();
                    }
                    //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                }
            }
        }
        
        strMsg = strMsg.substr(0, strMsg.length - 1);
        strMsg = strMsg.replace(/<li>|_/g, '-');
        if (strMsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error',20);
        }

        return chkVal;
    }
    var strHolidaySaveAndAddFlag = "";
    function SaveAndAddHoliday() {
        strHolidaySaveAndAddFlag = 1;
        SaveHoliday();
       
    }
    function ShowHistory_OnClick() {
     
        var obj = { "UniqueID": EditHolidayID };
        var myJSON = JSON.stringify(obj);
        var url = "Holiday_calender.aspx/ShowMailHistoryDetails"
        
        var result = AJAXCallWithResult(url, myJSON, false)
        
        if (EditHolidayID == undefined || EditHolidayID == 0) {

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select atleast one entry..', 'error');
        }
        else {
            
            $("#id13 #modalbody").html(result.d);
            document.getElementById('id13').style.display = 'block';
        }
        datatables("ShowHistoryGrid", 'txtSearchHistory');
    }
    function ModifiedFieldFilter_Change() {

        var ModifiedField = $('#cboModifiedField :selected').text();
        var ModifiedBy = $('#cboModifiedBy :selected').text();

        var obj = { "newModifiedField": ModifiedField, "MessageID": EditHolidayID, "newModifiedBy": ModifiedBy };
        var myJSON = JSON.stringify(obj);

        var url = "Holiday_calender.aspx/FilteredHistory"
        var result = AJAXCallWithResult(url, myJSON, false)
        $("#id13 #modalbody").html(result.d);
        document.getElementById('id13').style.display = 'block';
        datatables("ShowHistoryGrid", 'txtSearchHistory');
    }
    function SaveHoliday() {
        
        if (ValidateLoginType() == 0) {
           

            var HolidayName = $("#txtHolidayName").val();
            var HolidayDate = $("#dtHolidayDate").val();
          
            //if (strHolidaySaveAndAddFlag == 1) {
            //    EditHolidayID = 0;
            //}
            data = JSON.stringify({ HolidayName: HolidayName, HolidayDate: HolidayDate, HolidayID: EditHolidayID });
            //alert(EditHolidayID);
            strResult = AJAXCallWithResult("Holiday_calender.aspx/SaveHoliday", data, false);
            //alert(strResult.d);
            //AddedBy Chakshuta H on 11th-Jan-2018 Purpose:Issue Id-10339 
            EditHolidayID = strResult.d;
            //End Of AddedBy Chakshuta H on 11th-Jan-2018 Purpose:Issue Id-10339 
            if (strResult.d != "") {
               
                $("#divRequestTypes").css("display", "block");
                $("#EmployeeFilter").css("display", "block");
                $("#RequestPaging").css("display", "block");
                if (EditHolidayID != 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Holiday details updated successfully', 'success');
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Holiday details saved successfully', 'success');
                }
                if (strHolidaySaveAndAddFlag == 1) {
                    $("#divRequestTypes").css("display", "none");
                    $("#EmployeeFilter").css("display", "none");
                    $("#txtHolidayName").val("");
                    $("#dtHolidayDate").val("");                    
                }
               
                RefreshGrid("Type", "Flag");

            }
            // }
        }
        else {
            strHolidaySaveAndAddFlag = 0;
        }
    }
    
    
    function Holiday_OnClick(HolidayID) {
        $("#History").css("display", "inline");
        EditHolidayID = HolidayID;
        $("#collapseOne2").css("display", "block");
        $("#collapseOne2").css("height", "auto");
        $("#collapseOne2 .panel-body").css("height", "auto");
        $("#plus").css("display", "none");
        $("#minus").css("display", "block");
        
        globalEmployeeID = HolidayID;
        //document.getElementById('hdnEmployeeID').value = globalEmployeeID;
        data = JSON.stringify({ HolidayID: HolidayID });
        strResult = AJAXCallWithResult("Holiday_calender.aspx/GetHolidayDetails", data, false);
        //alert(strResult.d);
        if (strResult.d != "")
        {
            var arrResult = strResult.d.split("#$#");
           
            $("#txtHolidayName").val(arrResult[0]);           
            $("#dtHolidayDate").val(arrResult[1]);
           
           
            $("#divRequestTypes").css("display", "none");
            $("#EmployeeFilter").css("display", "none"); //Added by Usha Pandit on 18.12.2017
         
            if ($("#Addaccordion").hasClass("collapsed"))
            {
                $("#Addaccordion").removeClass("collapsed");
                $("#collapseOne2").css('height', 'auto!important');
                $("#collapseOne2").addClass('in');
            }
        }
    }
    
    
    $("#frmSettingsTabs").load(function () {
        RemoveFrameLoader();
    });
    //Added by Yogesh Jalamkar on 20-dec-2017 Purpose Issue id = 9877
    function select_checkbox(obj) {
        if (obj.checked) {
            arrSelectedCheck.push(obj.value);	// record the value of the checkbox to valArray
        } else {
            arrSelectedCheck.pop(obj.value);	// remove the recorded value of the checkbox
        }
    }
    //End by Yogesh jalamkar Purpose Issue id = 9877
</script>


<script>
    // Get the modal for Request Type button popup
    //$('.modal').draggable();

    function myFunction()
    { }
    /*Added By Yasmin on 25th july 2018*/
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

