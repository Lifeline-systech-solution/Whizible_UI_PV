<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Security_login_employee.aspx.vb" Inherits="PbNIT.Security_login_employee" %>

<!DOCTYPE html>
<html lang="en">

<%CommonFunctions.General.PlotPageHeadTag("Setting")%>
  <head>
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="description" content="" />
    <meta name="author" content="" />
       <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>--%>
    <%--<title>Setting</title>--%>
      
<HEAD>
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
           padding: 4px!important;
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

       /*.clsTRColumnHeader th:nth-child(4) {
           text-align: center;
       }

       .clsTRColumnHeader th:nth-child(5) {
           text-align: center;
       }*/






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
       .container-fluid {
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
           border-color: #bbb;/*#82c4d3;*/
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
               /*text-align:center;*/
           }

       /*#divEmpLogin table tr th:nth-child(1) {
           width:819px!important;
       }

      
          #divEmpLogin table tr td:nth-child(1) {
              width:80%!important
           }
            #divEmpLogin table tr td:nth-child(2) {
               width: 13%!important;
           }
             #divEmpLogin table tr td:nth-child(3) {
              width:0%!important;
              padding-left:1.2%!important;
           }
              #divEmpLogin table tr td:nth-child(4) {
              width:6%!important;
           }
       #divEmpLogin .dataTables_wrapper .row:nth-child(1) {
       display:none;
       }*/
       #divEmpLogin .dataTables_scrollBody .clsTRColumnHeader{
       height:0px!important;
       }

       #divEmpLogin .dataTables_paginate {
           float:right!important;
       }
         #divEmpLogin .dataTables_paginate ul {
            margin-top: 2%!important;
            margin-left: -1%!important;
       }
       #divEmpLogin .dataTables_scrollBody {
          overflow: auto!important;
           width: 101.8%!important;
           /*height: 132px!important;*/
           padding-right: 2%!important;
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
       /*Chakshuta*/
       .right .btn-default {
           background:white !important;
           color:black !important;
       }
       .right .btn-default:hover {
           background:white !important;
           color:black !important;
       }
       /*@media only screen and (max-width:991px) and (min-width:768px)*/
       tr.clsTROdd {
           font-family: Verdana;
           font-size: 12px;
           border-right: thin;
           padding-right: 2pt;
           border-top: thin;
           padding-left: 2pt;
           padding-bottom: 2pt;
           margin: 2pt;
           border-left: thin;
           color: black;
           padding-top: 2pt;
           border-bottom: thin;
           height: 18px;
           background-color:white !important;
       }

       #cboDepartment {

           font-size:12px !important;
           font-weight:100!important;
       }

       #CboRole {
             font-size:12px !important;
           font-weight:100!important;
       }
       #CboStatus {
             font-size:12px !important;
           font-weight:100!important;
       }

       #CboUserName {
           height:29px!important;
       }
       input.form-control, input.form-control {
            height:29px!important;
       }
     #isSaveandAdd{
       float: right;
       margin-top: 5px;
       margin-left: 5px;
       display:block;
       background-color:white!important;
       color:white;
       }

      .alertify-notifier {
           font-family: "Open Sans",sans-serif!important;
           /*font-size: 12px !important;*/
       }

       /*.alertify-notifier {

           height:30px!important;
           line-height:30px!important;
       }*/
       #txtSearchHistory::-ms-clear {
           display: none;
       }

        /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
       .form-control:-ms-input-placeholder { /* IE 10+ */
         color: #bbb!important;
       }
    #idPlus {
           display:inline-block !important;
       }
   </style>
   
  <body class="" id="page-top">
       <%--<%PageInit("Load")%>--%>
       <%WriteTabsControls("", "Load", "")%>
    <!-- Navigation -->


  <div class="content-wrapper" style="margin-left: 0px !important;"><div class="container-fluid">
   <div class="request-details-pg clsSettings">
    <div class="v-tabs" style="width: auto;"><div id="" class="tabcontent">
      <%--<div class="setting-src">
        <div class="row"><div class="col-md-6">
          <div class="left"><h3>Login</h3></div>
           </div>
           <div class="col-md-6"></div>
         </div>
       </div>--%>
       <div class="h-tabs" style="width:auto;" id="divMain">
    <%--  <div class="tab">
          <button class="tablinks1 active" onclick="openCity1(event, '../HelpdeskEnhancement/CRM_RequestType.aspx?MasterTagID=918')" id="defaultOpen918">Employee</button>
        </div>--%>



            <div class="type-top-bar top-bar" id="EmployeeFilter">
                    <ul class="left">
                      <li class="search-bar"><div class="left search-bar"><i id="idSearchHistory" class="fa fa-search" aria-hidden="true" style="margin-top: 13px"></i><input type="text" id="txtSearchHistory" placeholder="Search History" title="Type in a name"></div></li>
                      <li style="font-weight:normal !important;">
                                                    <select onchange="DepartMentFilter_OnChange(this)" class="form-control" id="cboDepartment" name="cboDepartment" style="width:129px; font-weight:normal !important;" ><option title="Department" value="0">Department</option><option title="Product Helpdesk" value="2">Product Helpdesk</option><option title="Management" value="3">Management</option><option title="Services" value="8">Services</option><option title="Human Resource" value="51">Human Resource</option><option title="test1" value="64">test1</option><option title="test2" value="65">test2</option><option title="test3" value="66">test3</option><option title="test4" value="67">test4</option></select>
                      </li> 
                      <li style="font-weight:normal !important;">
                                                    <select onchange="DepartMentFilter_OnChange(this)" class="form-control" id="CboRole" name="CboRole" style="width:129px "><option title="Role" value="0">Role</option><option title="DELIVERY MANAGER" value="1">DELIVERY MANAGER</option><option title="APPLICATION ADMINISTRATOR" value="7">APPLICATION ADMINISTRATOR</option><option title="HELPDESK EXECUTIVE" value="24">HELPDESK EXECUTIVE</option><option title="PRESIDENT" value="68">PRESIDENT</option><option title="MANAGING DIRECTOR" value="69">MANAGING DIRECTOR</option><option title="SOFTWARE ENGINEER / TEAM MEMBER" value="70">SOFTWARE ENGINEER / TEAM MEMBER</option><option title="IMPLEMENTATION ENGG / BUSINESS ANALYST" value="71">IMPLEMENTATION ENGG / BUSINESS ANALYST</option><option title="TEAM LEADER" value="72">TEAM LEADER</option><option title="HELPDESK LEAD / MANAGER" value="73">HELPDESK LEAD / MANAGER</option><option title="PROJECT MANAGER / SCRUM MASTER" value="74">PROJECT MANAGER / SCRUM MASTER</option><option title="HR MANAGER / EXECUTIVE" value="75">HR MANAGER / EXECUTIVE</option><option title="ADMIN MANAGER" value="76">ADMIN MANAGER</option><option title="BUSINESS DEVELOPMENT MANAGER" value="77">BUSINESS DEVELOPMENT MANAGER</option><option title="SALES EXECUTIVE" value="78">SALES EXECUTIVE</option><option title="FINANCE MANAGER" value="82">FINANCE MANAGER</option><option title="TEST ENGINEER" value="83">TEST ENGINEER</option><option title="TEST LEAD" value="85">TEST LEAD</option><option title="IT SUPPORT EXECUTIVE" value="88">IT SUPPORT EXECUTIVE</option><option title="SUPPORT (My Assets)" value="90">SUPPORT (My Assets)</option><option title="PROJECT CO-ORDINATOR" value="91">PROJECT CO-ORDINATOR</option></select>
                      </li>
                    
                      <li style="font-weight:normal !important;">
                                                   <select onchange="DepartMentFilter_OnChange(this)" class="form-control" id="CboStatus" name="CboStatus" style="width:129px "><option title="Status" value="-1">Status</option><option title="Active" value="0">Active</option><option title="Inactive" value="1">Inactive</option></select>
                      </li>
                       
                    </ul>
                                   <ul class="right">
                       <li class="clearall"><button type="button" class="btn btn-default" onclick="AddEmployee()">Add<i class="fa fa-plus" aria-hidden="true"></i></button></li>
                                           <li class="clearall"><button type="button" class="btn btn-default" title="Delete" onclick="DeleteEmployee()">Delete<i class="fa fa-trash-o" aria-hidden="true"></i></button></li>

                                   </ul>

                     </div>
    

<div class="table-responsive" id="divEmpLogin" style="margin-top: -11px;border-bottom: 1px solid #e3e2e2 !important;
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
<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer"><div class="row"></div><div class="row"><div class="col-sm-12"><div class="dataTables_scroll"><div class="dataTables_scrollHead" style="overflow: hidden; position: relative; border: 0px; width: 100%;"><div class="dataTables_scrollHeadInner" style="box-sizing: content-box; width: 1270px; padding-right: 17px;"><table class="table table-bordered table-stripped dataTable no-footer" cellpadding="0" cellspacing="1" width="99.9%" role="grid" style="margin-left: 0px; width: 1270px;"><thead class="clsTRColumnHeader">
<tr role="row"><th align="left" class="DivHelpDeskSLA sorting_asc clsTRColumnHeader th" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 431px;" aria-sort="ascending" aria-label="Template Name: activate to sort column descending">Department</th><th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 430px;" aria-label="Description: activate to sort column ascending">User Name</th><th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 197px;" aria-label="Created Date: activate to sort column ascending"> Login Name</th><th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 104px;" aria-label="Select: activate to sort column ascending">Designation</th>
<th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 104px;" aria-label="Select: activate to sort column ascending">Is Active</th>
<th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 104px;" aria-label="Select: activate to sort column ascending">Business Group  </th>
<th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 104px;" aria-label="Select: activate to sort column ascending">Location </th>
  <th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 107px;" aria-label="Delete: activate to sort column ascending">Edit</th>
  <th align="left" class="DivHelpDeskSLA sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 107px;" aria-label="Delete: activate to sort column ascending">Delete</th></tr></thead></table></div></div><div class="dataTables_scrollBody" style="position: relative; overflow-y: hidden; width: 100%; height: 130px;"><table class="table table-bordered table-stripped dataTable no-footer" cellpadding="0" cellspacing="1" width="99.9%" id="DataTables_Table_0" role="grid" aria-describedby="DataTables_Table_0_info" style="width: 99.9%;"><thead class="clsTRColumnHeader">
<tr role="row" style="height: 0px;"><th align="left" class="DivHelpDeskSLA sorting_asc" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 431px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; height: 0px;" aria-sort="ascending" aria-label="Template Name: activate to sort column descending"><div class="dataTables_sizing" style="height:0;overflow:hidden;">Template Name</div></th><th align="left" class="DivHelpDeskSLA sorting" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 430px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; height: 0px;" aria-label="Description: activate to sort column ascending"><div class="dataTables_sizing" style="height:0;overflow:hidden;">Description</div></th><th align="left" class="DivHelpDeskSLA sorting" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 197px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; height: 0px;" aria-label="Created Date: activate to sort column ascending"><div class="dataTables_sizing" style="height:0;overflow:hidden;">Created Date</div></th><th align="left" class="DivHelpDeskSLA sorting" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 104px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; height: 0px;" aria-label="Select: activate to sort column ascending"><div class="dataTables_sizing" style="height:0;overflow:hidden;">Select</div></th><th align="left" class="DivHelpDeskSLA sorting" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" style="width: 107px; padding-top: 0px; padding-bottom: 0px; border-top-width: 0px; border-bottom-width: 0px; height: 0px;" aria-label="Delete: activate to sort column ascending"><div class="dataTables_sizing" style="height:0;overflow:hidden;">Delete</div></th></tr></thead>

<tbody>






    
    





<tr class="clsTREvenRow odd" role="row">
<td valign="top" align="left" title="Template Name" class="sorting_1">
Acknowledgement - Non-Critical</td>
<td valign="top" align="left" title="Description">
1.3 Acknowledgement - Low</td>
<td valign="top" align="left" title="Created Date">
11-Jan-2013</td>
<td align="center" title="Edit Checkbox"><button type="button" class="edit-bt" data-toggle="tooltip" id="chkSLATemplateSelect " name="chkSLADetailSelect" onclick="Edit_SLATemplate(this,2)" value="2"><a href="#edit_target"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button></td>
<td align="center" title="Delete"><input type="checkbox" id="chkchkSLATemplateDelete" name="chkchkSLATemplateDelete" value="2"></td>

</tr>

<tr class="clsTROdd even" role="row">
<td valign="top" align="left" title="Template Name" class="sorting_1">
Acknowledgement - Urgent</td>
<td valign="top" align="left" title="Description">
1.2 Acknowledgement - Medium</td>
<td valign="top" align="left" title="Created Date">
11-Jan-2013</td>
<td align="center" title="Edit Checkbox"><button type="button" class="edit-bt" data-toggle="tooltip" id="chkSLATemplateSelect" name="chkSLADetailSelect" onclick="Edit_SLATemplate(this,3)" value="3"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button></td><td align="center" title="Delete"><input type="checkbox" id="Checkbox1" name="chkchkSLATemplateDelete" value="3"></td></tr><tr class="clsTREvenRow odd" role="row">
<td valign="top" align="left" title="Template Name" class="sorting_1">
Closure - Critical</td>
<td valign="top" align="left" title="Description">
4.1 Closure - High</td>
<td valign="top" align="left" title="Created Date">
11-Jan-2013</td>
<td align="center" title="Edit Checkbox"><button type="button" class="edit-bt" data-toggle="tooltip" id="Button1" name="chkSLADetailSelect" onclick="Edit_SLATemplate(this,10)" value="10"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button></td><td align="center" title="Delete"><input type="checkbox" id="Checkbox2" name="chkchkSLATemplateDelete" value="10"></td></tr><tr class="clsTREvenRow even" role="row">
<td valign="top" align="left" title="Template Name" class="sorting_1">
Closure - Non-Critical</td>
<td valign="top" align="left" title="Description">
4.3 Closure - Low</td>
<td valign="top" align="left" title="Created Date">
11-Jan-2013</td>
<td align="center" title="Edit Checkbox"><button type="button" class="edit-bt" data-toggle="tooltip" id="Button2" name="chkSLADetailSelect" onclick="Edit_SLATemplate(this,12)" value="12"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button></td><td align="center" title="Delete"><input type="checkbox" id="Checkbox3" name="chkchkSLATemplateDelete" value="12"></td></tr><tr class="clsTROdd odd" role="row">
<td valign="top" align="left" title="Template Name" class="sorting_1">
Closure - Urgent</td>
<td valign="top" align="left" title="Description">
4.2 Closure - Medium</td>
<td valign="top" align="left" title="Created Date">
11-Jan-2013</td>
<td align="center" title="Edit Checkbox"><button type="button" class="edit-bt" data-toggle="tooltip" id="Button3" name="chkSLADetailSelect" onclick="Edit_SLATemplate(this,11)" value="11"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button></td><td align="center" title="Delete"><input type="checkbox" id="Checkbox4" name="chkchkSLATemplateDelete" value="11"></td></tr></tbody></table></div></div></div></div>




<div class="row"><div class="col-sm-12 col-md-5"><div class="dataTables_info" id="DataTables_Table_0_info" role="status" aria-live="polite">Showing 1 to 5 of 39 entries</div></div><div class="col-sm-12 col-md-7"><div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate"><ul class="pagination"><li class="paginate_button page-item previous disabled" id="DataTables_Table_0_previous"><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li><li class="paginate_button page-item active"><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="1" tabindex="0" class="page-link">1</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="2" tabindex="0" class="page-link">2</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="3" tabindex="0" class="page-link">3</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="4" tabindex="0" class="page-link">4</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="5" tabindex="0" class="page-link">5</a></li><li class="paginate_button page-item disabled" id="DataTables_Table_0_ellipsis"><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="6" tabindex="0" class="page-link">…</a></li><li class="paginate_button page-item "><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="7" tabindex="0" class="page-link">8</a></li><li class="paginate_button page-item next" id="DataTables_Table_0_next"><a href="#" aria-controls="DataTables_Table_0" data-dt-idx="8" tabindex="0" class="page-link">Next</a></li></ul></div></div></div>
</div>
</div>



      </div>


      <div class="bottom-bar" id="divSubTypeBottom edit_target" > <div class="pannel-section"><div class="col-md-12 col-sm-12"><div class="panel-group wrap" id="accordion2" role="tablist" aria-multiselectable="true"><div class="panel"><div class="panel-heading" role="tab" id="headingOne2"><h3><span><i class="fa fa-plus" style="float: none; padding-left: 10px;"></i><span style="margin-left: 5px;"> Employee</span></span></h3><h4 class="panel-title"><a role="button" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne2" aria-expanded="true" aria-controls="collapseOne2" class=""><i class="fa fa-plus toggle-plus"></i><i class="fa fa-minus toggle-plus"></i></a></h4></div><div id="collapseOne2" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne2" aria-expanded="true" style="">
        <div class="panel-body" style="height: 150px;">
          <form class="form-horizontal" action="/action_page.php">
          <div class="form-group">                            
                              <label class="control-label col-sm-2" for="Employee Type" style="text-align: right;font-size: 11px"> User Name </label>
                              <div class="col-sm-4">
                            
                                                                  <select class="form-control" id="CboEmplyeeType" name="CboEmplyeeType" style="width:217px "><option value="Select User"></option><option title="Contract" value="Contract">Contract</option><option title="Hourly" value="Hourly">Hourly</option><option title="Salary" value="Salary">Salary</option></select>
                               
                              </div>
                             <label class="control-label col-sm-2" for="Employee Type" style="text-align: right;font-size: 11px"> Login Name </label>
                <div class="col-sm-4">
                              <input type="text" style="width:217px;" class="form-control" id="Text1" name="" placeholder="Enter Login Name">
                              </div>
                            </div>

               
<div class="form-group"><label class="control-label col-sm-2" for="request type" style="text-align: right;font-size: 11px">Password*</label><div class="col-sm-4"><input type="Textbox" name="SubrequesttypeCode" id="SubrequesttypeCode" class="form-control" style="text-align:Left" value="" placeholder="Enter Password Name"></div>  <label class="control-label col-sm-2" for="request type" style="text-align: right;font-size: 11px">Confirm Password*</label> <div class="col-sm-4"><input type="Textbox" name="Sub_WorkHrs" id="Sub_WorkHrs" class="form-control" style="text-align:Left" value="" placeholder="Confirm Password Name"> </div></div>
              


               <div class="form-group">

                            </div>

                          <div class="form-group" style="    border-bottom: none; margin-top: 5px; "><div class="right"><button type="button" class="btn btn-default save" onclick="SaveRequestSeverity()" style="background-color: #343660; color: #ffffff">Save</button><button type="button" class="btn btn-default save clsbuttonLinks" onclick="SaveAndAddRequestSeverity()" style="border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff">Save and Add</button>
                            <button type="button" class="btn btn-default save clsbuttonLinks" onclick="Cancel_Severity()" style="    margin-left: 5px; background-color: #343660; color: #ffffff">Deactivate Login</button> <button type="button" class="btn btn-default save clsbuttonLinks" onclick="Cancel_Severity()" style="margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff">Cancel</button> </div></div>
                           </form></div>  </div></div></div>  </div> </div> </div>
    </div>
  </div>
</div>
</div>
</div>
   
</body>

   <%-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>

 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>

      <script language='javascript' src='EnhancementFiles/CommonFunctions.js'></script>


<script src=" EnhancementFiles/js/timepicker.js"></script>
<script src=" EnhancementFiles/New_CommonFunctions.js"></script>

   
        <script src="../../../EnhancementFiles/js/editor.js"></script>

      
        <script src="../../../EnhancementFiles/js/timepicker.js"></script>
        <script src="../../../EnhancementFiles/js/timepicker.min.js"></script>
    
    <%--<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
	<%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
        <script src="js/timepicker.min.js"></script>
        <script src="js/timepicker.js"></script>
<script>
    $(document).click(function () {
        //alert(window.parent.parent.parent.location);
        $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

    });

    $(document).ready(function () {
        //var bodyHeight = window.innerHeight - $('#frmSettingsTabs').offset().top;
        //$("#CboUserName").html("");

        //data = JSON.stringify({ Mode: 'Add' });
        //strResult = AJAXCallWithResult("Security_login_employee.aspx/ComboOnAdd", data, false);
        ////alert(strResult.d);
        //var strArray = String(strResult.d).split("|")

        //var objCbo = document.getElementById("CboUserName");
        //var i = 0;
        //objCbo.innerHTML = "";
        //alert(objCbo.value);
        //if (objCbo.value != '') {            
        //    insBlankOpt(objCbo);
        //}
        //$.each(JSON.parse(strArray[0]), function (id, obj) {

        //    var objOption = document.createElement("OPTION");
        //    objCbo.options.add(objOption);
        //    objOption.text = obj.UserName;
        //    objOption.value = obj.EmployeeID;

        //});
        
        //$('#frmSettingsTabs').css('height', bodyHeight + 200 + 'px');
        RefreshGridDetails();

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
    });
    $("[title]").click(function () {
        $('.ui-tooltip').fadeOut('fast', function () {
            $('.ui-tooltip').remove();
        });
    });
</script>
    
<script>
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
    function AddEmployee() {
        // $("#EmployeeFilter").css("display", "none");
        //$("#tblEmployee").css("display", "none")
        //$("#EmployeePagination").css("display", "none")
        $("#CboUserName").html("");

        data = JSON.stringify({ Mode: 'Add' });
        strResult = AJAXCallWithResult("Security_login_employee.aspx/ComboOnAdd", data, false);
        //alert(strResult.d);
        var strArray = String(strResult.d).split("|")
       
        var objCbo = document.getElementById("CboUserName");
        var i = 0;
        objCbo.innerHTML = "";

        if (objCbo.value != '') {
            insBlankOpt(objCbo);
        }
        $.each(JSON.parse(strArray[0]), function (id, obj) {

            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.UserName;
            objOption.value = obj.EmployeeID;

        });


        $("#Deactivate").css("display", "none");
        $("#FilerForEmp").css("display", "none");
        document.getElementById("txtLoginName").disabled = false;
        document.getElementById("CboUserName").disabled = false;
        $("#CboUserName").val("");
        $("#txtLoginName").val("");
        $("#txtPassword").val("");
        $("#txtConfirmPassword").val("");

        $("#divRequestTypes").css("display", "none");
        /*Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto');
            $("#collapseOne2").addClass('in');
        }

      
    }
   

    function Cancel_Login() {
        // alert(Flag);
        $("#CboUserName").html("");

        data = JSON.stringify({ Mode: 'Add' });
        strResult = AJAXCallWithResult("Security_login_employee.aspx/ComboOnAdd", data, false);
        //alert(strResult.d);
        var strArray = String(strResult.d).split("|")

        var objCbo = document.getElementById("CboUserName");
        var i = 0;
        objCbo.innerHTML = "";

        if (objCbo.value != '') {
            insBlankOpt(objCbo);
        }
        $.each(JSON.parse(strArray[0]), function (id, obj) {

            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.UserName;
            objOption.value = obj.EmployeeID;

        });

        $("#divRequestTypes").css("display", "block");
       
        $("#FilerForEmp").css("display", "block");
        $("#CboUserName").val("");
        $("#txtLoginName").val("");
        $("#txtPassword").val("");
        $("#txtConfirmPassword").val("");
        document.getElementById("txtLoginName").disabled = false;
        document.getElementById("CboUserName").disabled = false;
        $("#Deactivate").css("display", "none");
        RefreshGrid("Type", "Flag");

        /*Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto');
            $("#collapseOne2").addClass('in');
        }

        /*End of Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
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
    function SelectLoginAll_Checkbox(obj) {
        // $("input[name=chkchkRoleMasterSelect]").prop('checked', true);

        if ($(obj).is(':checked'))
            //  $("input[name=chkchkRoleMasterSelect]").prop('checked', true);
            $("input[name=chkRequestTypeDelete]:not(:disabled)").prop('checked', true);
        else
            $("input[name=chkRequestTypeDelete]").prop('checked', false);
    }

    var strSearch='';

    function DepartMentFilter_OnChange(Object) {

        var strResult, data;
        var GridParameter = {};
        var Department = $("#cboDepartment").val();
        var Role = $("#CboRole").val();

        if (Department == "0" || Department == "") {
            Department = ""
        }

        if (Role == "0" || Role == "") {
            Role = ""
        }
        // debugger;
        var Status = $("#CboStatus").val();
        //alert($("#CboStatus").val());
        //alert(Status);
        if (Status == -1) {
            Status = "null";
        }
        if ((Status == "Active") || (Status == 0)) {
            //alert();
            Status = 1;
        }
        else if ((Status == "InActive")||(Status == 1)) {
            Status = 0;
        }
        GridParameter.cityName = "cityName";
        //alert(Role);
        //alert(Status);
        // var getvalue = Object.val();

        // alert(getvalue)
        data = JSON.stringify({ GridParameter: GridParameter, Department: Department, Role: Role, Status: Status, strSearch: strSearch });
        //alert(data);
        strResult = AJAXCallWithResult("Security_login_employee.aspx/RefreshPlotGrid", data, false);
        //alert(strResult);
        //alert(strResult.d);
        if (strResult.d != "") {
            $("#divEmpLogin").html(strResult.d);
            datatables("divEmpLogin", 'txtSearchHistory');
            //setWidthEmployee();
            setWidthDatatable("divEmpLogin");
            //RefreshGrid(globalCityName);
            //var arrResult = strResult.d;
        }
        SaveandAdd = 0;
    }
    function RefreshGrid(cityName, Flag) {
        var strResult, data;
        var GridParameter = {};
        EditLoginID = 0;
        GridParameter.cityName = "Type";
        cityName = "Type";

        var Department = $("#cboDepartment").val();
        var Role = $("#CboRole").val();

        if (Department == "0" || Department == "") {
            Department = ""
        }

        if (Role == "0" || Role == "") {
            Role = ""
        }
        // debugger;
        var Status = $("#CboStatus").val();
        //alert($("#CboStatus").val());
        //alert(Status);
        if (Status == -1) {
            Status = "null";
        }
        if (Status == "Active") {
            Status = 1;
        }
        if (Status == "InActive") {
            Status = 0;
        }
        if (strSearch == undefined || strSearch == "") {
            strSearch = "null";
        }
        //alert(Status)
        if (Flag != "") {
            //data = JSON.stringify({ GridParameter: GridParameter });
            data = JSON.stringify({ GridParameter: GridParameter, Department: Department, Role: Role, Status: Status, strSearch: strSearch });

            strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
            var DivId;
            var DivSerach;
            
            if (strResult.d != '') {

                // DivId = "DivList";
                DivId = "divEmpLogin";
                DivSerach = "txtSearchHistory";

                $("#divRequestTypes").html("");
                $("#divRequestTypes").html(strResult.d);
                //DivId = "divMain";
                //DivSerach = "txtSearchHistory";

                //$("#divMain").html("");
                //$("#divMain").html(strResult.d);

                $(".table-responsive:first table").addClass("table");


            }

        }
        RefreshGridDetails();
    }

   
    function RefreshGridDetails() {
        //  debugger;

        var strResult, data;
        var GridParameter = {};
        var DivId;
        var DivSerach;

        DivId = "divEmpLogin";
        DivSerach = "txtSearchHistory";

        var TypeDiv; var accordion;
        var intDivGridHeight

        if (WhichBrowser() == "IE") {
            intDivGridHeight = (window.innerHeight / 2);
            
            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
               
                intDivGridListHeight = parseInt(window.innerHeight) - 500;
                $('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 155 + 'px');
            }

            else if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024)) {
               
                intDivGridListHeight = parseInt(window.innerHeight) - 355;
                $('#divRequestTypes').css('height', intDivGridListHeight - 150 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
              
                intDivGridListHeight = parseInt(window.innerHeight) - 200;
            }
            else {
               
                intDivGridListHeight = parseInt(window.innerHeight) - 100;
                
            }
            $('#divRequestTypes').css('height', intDivGridListHeight - 600 + 'px');
            $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
        }
        else {
            intDivGridHeight = (window.innerHeight / 2);

            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
                //alert(1);
                intDivGridListHeight = parseInt(window.innerHeight) - 370;
                //alert(intDivGridListHeight + 100);
                //$('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 100 + 'px');
            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
                //alert(2);
                intDivGridListHeight = parseInt(window.innerHeight) - 360;
               // $('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                //alert(3);
                intDivGridListHeight = parseInt(window.innerHeight) - 470;
                //$('#divRequestTypes').css('height', intDivGridListHeight - 80 + 'px');

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }
            else {
                //alert(4);
                intDivGridListHeight = parseInt(window.innerHeight) - 570;
                //alert(intDivGridListHeight+80);
                //$('#divRequestTypes').css('height', intDivGridListHeight - 100 + "px");

                //$('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }

           // $('#divRequestTypes').css('height', intDivGridListHeight - 180 + "px");

            $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');

            //    $('#Type').css('height', intDivGridListHeight + 500  + "px");
        }

        //   $(".table-responsive:first table").addClass("table");
        datatables(DivId, DivSerach, intDivGridListHeight);
        //setWidthDatatable(DivId);

    }
    //function RefreshGridDetails() {
    //    //  debugger;

    //    var strResult, data;
    //    var GridParameter = {};
    //    var DivId;
    //    var DivSerach;

    //    DivId = "divApplySLA";
    //    DivSerach = "SearchSLA";

    //    var TypeDiv; var accordion;
    //    var intDivGridHeight;

    //    var intDivGridHeight, intDivGridListHeight
    //    intDivGridListHeight = parseInt(window.innerHeight);
    //    if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
    //        $('#divRequestTypes').css('height', intDivGridListHeight - 600 + 'px');
    //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
    //    }

    //    else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
    //        $('#divRequestTypes').css('height', intDivGridListHeight - 600 + 'px');
    //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');

    //    }
    //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
    //        $('#divRequestTypes').css('height', intDivGridListHeight - 600 + 'px');
    //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');

    //    }
    //    else {
    //        $('#divRequestTypes').css('height', intDivGridListHeight - 600 + 'px');
    //        $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');

    //    }
    //    datatables(DivId, DivSerach, intDivGridListHeight);
    //    //setWidthDatatable("divApplySLA");
    //}

    function datatables(divID, txtBoxID) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({

            responsive: true, "pageLength":3,
            //scrollY: '165px',
            pagingType: "simple_numbers",
            scrollX: true,
            
            //datatables.parent().toggle(settings.fnRecordsDisplay() > 0),
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
                strSearch = $(this).val();
                table.search($(this).val()).draw();                
            })
        }
        
    }
    //function setWidthEmployee() {
    //    var tblTotal = document.getElementById("divEmpLogin").getElementsByClassName('dataTable')[0];
    //    var tblDetails = document.getElementById("divEmpLogin").getElementsByClassName('dataTable')[1];
    //    //if (WhichBrowser() != 'FF') {
    //    if (tblDetails != null) {
    //        tblTotal.style.width = tblDetails.offsetWidth + 'px';
    //        width = tblDetails.offsetWidth + 'px';
    //    }
    //    // }
    //    var FooterTableRow = tblTotal.rows[0];
    //    var HeaderRow = tblDetails.rows[0];
    //    for (var i = 0; i < tblTotal.rows[0].cells.length; i++) {
    //        if (FooterTableRow.cells[i] != null)
    //            if (HeaderRow.cells[i] != null) {
    //                FooterTableRow.cells[i].style.width = HeaderRow.cells[i].offsetWidth + 'px';
    //            }
    //    }


    //}
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
    var strPageName = "Security_login_employee.aspx"
    function DeleteEmployee() {
        var strLoginIDs;
        strLoginIDs = $('input[name=chkRequestTypeDelete]:checked').map(function () {
            return this.value;
        }).get().join(',');

        if (strLoginIDs.length <= 0) {
            return;
        }
        data = JSON.stringify({ LoginID: strLoginIDs });

        strResult = AJAXCallWithResult(strPageName + "/DeleteRequestType", data, false);
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Login deleted successfully', 'success');
        RefreshGrid("Type", "Flag");

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
    function ValidateLoginType() {
        var chkVal = 0;
     
        var UserName = $("#CboUserName").val();
        var txtLoginName = $("#txtLoginName").val();
        var txtPassword = $("#txtPassword").val();
        var txtConfirmPassword = $("#txtConfirmPassword").val();
        var strMsg = "";
        if ($("#CboUserName").val() == "" || $("#CboUserName").val() == null) {
            strMsg += "<li> User Name should not be left blank </li><br>";
            chkVal = 1;
        }
        if ($("#txtLoginName").val() == "") {
            strMsg += "<li> Login Name should not be left blank </li><br>";
            chkVal = 1;
        }
        else
        {
            if (txtLoginName != "") {
                if (EditLoginID == 0) {
                    data = JSON.stringify({ LoginName: txtLoginName });
                    strResult = AJAXCallWithResult(strPageName + "/CheckIsDuplicate", data, false);
                    if (strResult.d == "1") {
                        strMsg += "<li> Login Name already exists. </li><br>";
                        chkVal = 1;
                    }
                }
            }
        }
        if ($("#txtPassword").val() == "") {
            strMsg += "<li> Password should not be left blank </li><br>";
            chkVal = 1;
        }
        if ($("#txtConfirmPassword").val() == "") {
            strMsg += "<li> Confirm Password should not be left blank </li><br>";
            chkVal = 1;
        }

        //if ($("#txtPassword").val() != null && $("#txtConfirmPassword").val() != null && $("#txtPassword").val() != $("#txtConfirmPassword").val()) {
        //    strMsg += "<li>- The Password and Confirm Password fields do not match </li>";
        //    //alert("The Password and Confirm Password fields do not match.")
        //    chkVal = 1;
        //}

        //if (RequestType != "") {
        //    data = JSON.stringify({ RequestType: RequestType });
        //    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicateRequestType", data, false);

        //    if (strResult1.d == "1") {
        //        //alertify.set('notifier', 'position', 'top-right');
        //        //alertify.notify('Request Type is already exists', 'error');
        //        //  strmsg = strmsg + 'Request Type already exists';
        //        strMsg += "<li>- Request Type already exists </li>";
        //        chkVal = 1;

        //    }
        //}

        //Chakshuta           
        //var objUserName = GetObjectReference("frmCommonPage", "EmployeeID");              
        var objLoginName = $("#txtLoginName").val();       
        var objNewPwd = $("#txtPassword").val();        
        var objConfirmPwd =  $("#txtConfirmPassword").val();  
        var hdCount = GetObjectReference("frmCommonPage","NonDatabase3");     
        //Added By Vaijat K ON 24/07/2017 For Password Encryption     
        var strEncryptionKey = "";     
        var strEncryptedNewPwd = "";     
        var strEncryptedConPwd = "";              
        //$.ajax({                  
        //    type: "GET",                  
        //    contentType: "application/json; charset=utf-8",                  
        //    url: "../General/XmlHTTP.aspx?TagID=99999&Action=ValidateUserName&UserName=" + objLoginName,
        //    async: false,                  
        //    success: function (data) 
        //    {              
        //        alert(data);
        //        strEncryptionKey = data;                  
        //    },                  
        //    error: function (result) 
        //    {
        //        alert(url);
        //        alert(result);
        //    }
        //})     
        data = JSON.stringify({ objLoginName: objLoginName});
        strResult = AJAXCallWithResult("Security_login_employee.aspx/ValidateUserName", data, false);
        //alert(strResult.d);
        
        var arrResult = strResult.d.split("#$#");

        strEncryptionKey = arrResult[0];
        blnAllowSameLoginPwd = arrResult[1];
        blnEnablePassLength = arrResult[3];
        intMinPassLen = arrResult[4];
        intMaxPassLen = arrResult[5];
        blnEnableAlphaNumSpeChar = arrResult[6];
        intNumberOfAlpha = arrResult[7];
        intNumberOfNumerals = arrResult[8];
        intNumberOfSpecialChars = arrResult[9];
        EnablePreviousPassCheck= arrResult[12];
        PreviousPassCount = arrResult[13];
        AuthenticationType = arrResult[20];
        //alert(AuthenticationType);
        //alert(arrResult[0]);
        //alert(arrResult[1]);
        //alert(intMinPassLen);
        //alert(intMaxPassLen);
        //End Added By Vaijat K ON 24/07/2017 For Password Encryption                 
        //if (hdCount != null)     
        //    hdCount.value = strEncryptionKey.length;              
        var intCurrAlphaCount = 0;              
        var intCurrNumCount = 0;              
        var intCurrSpecCount = 0;              
        var intAsciiValue;              
        var strAlertMsg;                
        var stralphacharset = "65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122";              
        var strnumeralcharset = "48 49 50 51 52 53 54 55 56 57";              
        var strspecialcharset = "32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 58 59 60 61 62 63 64 91 92 93 94 95 96 123 124 125 126 127";                
        if (objNewPwd != null && objConfirmPwd != null && objNewPwd != objConfirmPwd) 
        {                  
            //alert("The New Password and Confirm Password fields do not match.")                  
            //return;
            strMsg += "<li>  The New Password and Confirm Password fields do not match.  </li><br>";
            chkVal = 1;
        }     
        var strNewPass = objNewPwd;
        var strConPass=objConfirmPwd;     
        //Added By Vaijat K ON 24/07/2017 For Password Encryption       
        for (var i = strNewPass.length - 1, len = 0; i >= 0; i--) 
        {                  
            strEncryptedNewPwd += strNewPass[i] + strEncryptionKey + '|';      
            strEncryptedConPwd += strConPass[i] + strEncryptionKey + '|';              
        }              
        //End Added By Vaijat K ON 24/07/2017 For Password Encryption                
        if(blnAllowSameLoginPwd == "True")              
        {                  
            if (objLoginName != null && objNewPwd != null && objLoginName == objNewPwd) 
            {                      
                //alert("The Login Name and Password fields should not be same.");                      
                //return;

                strMsg += "<li>  The Login Name and Password fields should not be same.  </li><br>";
                chkVal = 1;
            }              
        }                
        //Added By Bharat T on 30th-Nov-2016 for Euronet pwd Policy Changes              
        if(objLoginName != null)              
        {                  
            //var url2 = "Action=CHECKISLOCKED&LoginName=" + objLoginName + "";
            data1 = JSON.stringify({ objLoginName: objLoginName });
            strResult1 = AJAXCallWithResult("Security_login_employee.aspx/CHECKISLOCKED", data1, false);
            //alert(strResult1.d);
          
           
            if (strResult1.d == "1")
            {                      
                //alert("As the user is locked you can not change the password, Please unlocked the user.");                      
                //return;
                strMsg += "<li>  As the user is locked you can not change the password, Please unlock the user.  </li><br>";
                chkVal = 1;
            }              
        }              
        if(objLoginName != null &&  objNewPwd != null )              
        {      
            //Commented And Added By Vaijat K ON 24/02/2017                             
            //var url1 = "Action=CHECKOLDNEWPWD&LoginName=" + objLoginName.value + "&NewPassword=" + strEncryptedNewPwd + "&AuthNo=" + strEncryptionKey.length;      
            ////End of Commented And Added By Vaijat K ON 24/02/2017                  
            //var strResult1 = ValidateData(url1, 0, 0, 0);

            data2 = JSON.stringify({ LoginName: objLoginName, NewPassword: strEncryptedNewPwd, AuthNo: strEncryptionKey.length });
            strResult2 = AJAXCallWithResult("Security_login_employee.aspx/CHECKOLDNEWPWD", data2, false);
            //alert(strResult2.d);

            if (strResult2.d == "1")
            {                      
                //alert(" The 'Old Passowrd' and 'New Passoword' fields should not be same.");                      
                //return;
                strMsg += "<li>  The 'Old Password' and 'New Password' fields should not be same.  </li><br>";
                chkVal = 1;
            }                             
        }              
        //End of Added By Bharat T on 30th-Nov-2016 for Euronet pwd Policy Changes                
        //Commented and added by Yogesh Jalamkar on 17-NOV-2016 Purpose:Euronet Customization              
        //if (AuthenticationType == "N" && blnEnablePassLength == "True") 
        //{              
            if (( AuthenticationType == "N" || AuthenticationType == "M") && blnEnablePassLength == "True") 
            {                  
                //End of COmment by   Yogesh Jalamkar                  
                if (objNewPwd != null && intMinPassLen > TrimAll(objNewPwd).length) 
                {                      
                    strAlertMsg = "The password should have atleast <MINPASSWORDLENGTH> characters. ";                      
                    strAlertMsg = strAlertMsg.replace("<MINPASSWORDLENGTH>", intMinPassLen);                      
                    //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label                      
                    //alert(strAlertMsg);                      
                    //alert(strAlertMsg);

                    strMsg += "<li> " + strAlertMsg + " </li><br>";
                    chkVal = 1;
                    //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label                      
                    //objNewPwd.focus();                      
                    //return ;                  
                }                  
                if (objNewPwd != null && intMaxPassLen < TrimAll(objNewPwd).length) 
                {                      
                    strAlertMsg = "The password should have atmost <MAXPASSWORDLENGTH> characters. ";                      
                    strAlertMsg = strAlertMsg.replace("<MAXPASSWORDLENGTH>", intMaxPassLen);                      
                    //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label                      
                    //  alert(strAlertMsg);                      
                    //alert(strAlertMsg)

                    strMsg += "<li> " + strAlertMsg + " </li><br>";
                    chkVal = 1;
                    //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label                      
                    //objNewPwd.focus();                      
                    //return ;                  
                }              
            }              
            else 
            {                  
                if (objNewPwd != null && TrimAll(objNewPwd).length < 6) 
                {                      
                    //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label                      
                    //  alert("The password should have atleast six characters.");                               
                   // alert("The password should have atleast six characters.")
                    strMsg += "<li> The password should have atleast six characters. </li><br>";
                    chkVal = 1;
                    //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label                      
                    //setFocus(objNewPwd);                      
                    //return ;                  
                }              
            }              
            //Commented and added by Yogesh Jalamkar on 17-NOV-2016 Purpose:Euronet Customization              
            //if (AuthenticationType == "N" && blnEnableAlphaNumSpeChar == "True") 
           // {              
                if (( AuthenticationType == "N" || AuthenticationType == "M") && blnEnableAlphaNumSpeChar == "True") 
                {                  
                    //End of COmment by   Yogesh Jalamkar                  
                    if (objNewPwd != null) 
                    {                      
                        newPass = objNewPwd;                      
                        for (i = 0; i < newPass.length; i++) 
                        {                          
                            intAsciiValue = newPass.charCodeAt(i);                          
                            if (stralphacharset.indexOf(intAsciiValue) >= 0) 
                            {                              
                                intCurrAlphaCount = parseInt(intCurrAlphaCount) + 1;                          
                            }                          
                            if (strnumeralcharset.indexOf(intAsciiValue) >= 0) 
                            {                              
                                intCurrNumCount = parseInt(intCurrNumCount) + 1;                          
                            }                          
                            if (strspecialcharset.indexOf(intAsciiValue) >= 0) 
                            {                              
                                intCurrSpecCount = parseInt(intCurrSpecCount) + 1;                          
                            }                      
                        }                  
                    }                  
                    if (intCurrAlphaCount < intNumberOfAlpha || intCurrNumCount < intNumberOfNumerals || intCurrSpecCount < intNumberOfSpecialChars) 
                    {                      
                        strAlertMsg = "The Password should have atleast <NUMBEROFALPHABETS> alphabets, <NUMBEROFNUMERALS>  numerals and <NUMBEROFSPECIALCHAR> special characters. ";     
                        strAlertMsg = strAlertMsg.replace("<NUMBEROFALPHABETS>", intNumberOfAlpha);                      
                        strAlertMsg = strAlertMsg.replace("<NUMBEROFNUMERALS>", intNumberOfNumerals);                      
                        strAlertMsg = strAlertMsg.replace("<NUMBEROFSPECIALCHAR>", intNumberOfSpecialChars);                      
                        //Added by Vidya Jadhav on 24-Nov-2016 Purpose:Show validation msg                      
                        strAlertMsg = strAlertMsg.replace("alphabets", "alphabet(s)");                      
                        strAlertMsg = strAlertMsg.replace("numerals", "numeral(s)");                      
                        strAlertMsg = strAlertMsg.replace("characters", "character(s)");                      
                        //End Of Added by Vidya Jadhav on 24-Nov-2016 Purpose:Show validation msg                      
                        //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label                      
                        //  alert(strAlertMsg);                      
                        //alert(strAlertMsg);

                        strMsg += "<li> " + strAlertMsg + " </li><br>";
                        chkVal = 1;
                        //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label                      
                       // objNewPwd.focus();                        
                        //return ;                  
                    }              
                }                
                if ((AuthenticationType == "N" || AuthenticationType == "M") && (EnablePreviousPassCheck == "True")) 
                {        
                    //Commented And Added By Vaijat K ON 24/02/2017                  
                    //var strURL = "Action=CHECKLASTENTEREDPWDS&LoginName=" + objLoginName.value + "&NewPassword=" + objNewPwd.value + "";     
                    //var strURL = "Action=CHECKLASTENTEREDPWDS&LoginName=" + objLoginName.value + "&NewPassword=" + strEncryptedNewPwd + "&AuthNo=" + strEncryptionKey.length;                        
                    //var strResult = ValidateData(strURL, 0, 0, 0);

                    data3 = JSON.stringify({ LoginName: objLoginName, NewPassword: strEncryptedNewPwd, AuthNo: strEncryptionKey.length });
                    strResult3 = AJAXCallWithResult("Security_login_employee.aspx/CHECKLASTENTEREDPWDS", data3, false);

                    if (strResult3.d == "1")
                    {                      
                        //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label                      
                        // alert("Password should not be same as last " + PreviousPassCount + " passwords!");                      
                        //alert("Password should not be same as last " + PreviousPassCount + " passwords!")                      
                        //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label   
                        strMsg += "<li> Password should not be same as last " + PreviousPassCount + " passwords! </li><br>";
                        chkVal = 1;

                        //return ;                  
                    }              
                }       
                objNewPwd = strEncryptedNewPwd;              
                objConfirmPwd = strEncryptedConPwd;    
        //Chakshuta
               
                strMsg = strMsg.substr(0, strMsg.length - 1);
                strMsg = strMsg.replace(/<li>|_/g, '-');
        if (strMsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }

        return chkVal;
    }
  
    var SaveandAdd = 0;
    var EditLoginID = 0;
    function SaveLogin() {
        if (ValidateLoginType() == 0) {
            //var RequestType = $("#requesttype").val();
            //var RequestTypeCode = $("#requesttypecode").val();

            var LoginID = $("#chkRequestTypeDelete").val();
            var UserName = $("#CboUserName").val();
            var strLoginName = $("#txtLoginName").val();
            var strPassword = $("#txtPassword").val();
            var txtConfirmPassword = $("#txtConfirmPassword").val();
            
            data = JSON.stringify({ lngEmployeeID: UserName, strLoginName: strLoginName, strPassword: strPassword, LoginID: LoginID });
            //  alert(data);
            strResult = AJAXCallWithResult("Security_login_employee.aspx/SaveLogin", data, false);
           
            if (strResult.d != "") {
                var Result = String(strResult.d).split("||");
                var MsgFlags = [];
                MsgFlags = (Result[1]).split(",");
                var intCount = 0;
                //alert(Result[0])
                //alert(Result[1])
                //alert(Result[2])
                for (intCount = 0; intCount < MsgFlags.length ; intCount++) {
                    {
                        if (MsgFlags[intCount] == "20032") {
                            //window.open("../../Source/General/CRMSendEmail.aspx?MessageID=44&MultipleRequests=0&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");
                            window.open("../../HelpdeskEnhancement/EmailSettings/CRMSendEmail.aspx?MessageID=20032&LoginName=" + Result[0] + "&Password=" + Result[2] + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                        }
                        else if (MsgFlags[intCount] == "12") {
                            // window.open("../../HelpdeskEnhancement/EmailSettings/CRMSendEmail.aspx?MessageID=20032&LoginName=" + Result[0] + "&Password=" + Result[2] + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                            window.open("../../HelpdeskEnhancement/EmailSettings/CRMSendEmail.aspx?MessageID=12&UserID=" + UserName + "&UserType=E&LoginName=" + Result[0] + "&Password=" + Result[2] + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                         }
                    }
                }

               
                $(".type-top-bar").css("display", "block");
                $("#RequestPaging").css("display", "block");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Login saved successfully', 'success');
                if (SaveandAdd == 1) {
                    $("#divRequestTypes").css("display", "none");
                    $("#FilerForEmp").css("display", "none");
                    $("#CboUserName").val("");
                    $("#txtLoginName").val("");
                    document.getElementById("txtLoginName").disabled = false;
                    document.getElementById("CboUserName").disabled = false;

                    $("#CboUserName").html("");

                    data = JSON.stringify({ Mode: 'Add' });
                    strResult = AJAXCallWithResult("Security_login_employee.aspx/ComboOnAdd", data, false);
                    //alert(strResult.d);
                    var strArray = String(strResult.d).split("|")

                    var objCbo = document.getElementById("CboUserName");
                    var i = 0;
                    objCbo.innerHTML = "";

                    if (objCbo.value != '') {
                        insBlankOpt(objCbo);
                    }
                    $.each(JSON.parse(strArray[0]), function (id, obj) {

                        var objOption = document.createElement("OPTION");
                        objCbo.options.add(objOption);
                        objOption.text = obj.UserName;
                        objOption.value = obj.EmployeeID;

                    });
                }
                else{
                    $("#divRequestTypes").css("display", "block");
                    $("#FilerForEmp").css("display", "block");
                    document.getElementById("txtLoginName").disabled = true;
                    document.getElementById("CboUserName").disabled = true;

                 }
                              
                $("#txtPassword").val("");
                $("#txtConfirmPassword").val("");
               
                

                RefreshGrid("Type", "Flag");

            }
            // }
        }
    }
    
    function SaveAndAddLogin() {       
        SaveandAdd = 1;
        SaveLogin();
        //Cancel_Login();

    }

    function UserName_OnChange() {
        var LoginID = $("#CboUserName").val();
        //$("#txtLoginName").val($("#CboUserName").val());
        //EditLoginID = LoginID;
        data = JSON.stringify({ LoginID: LoginID });
        strResult = AJAXCallWithResult("Security_login_employee.aspx/GetUserName", data, false);
        //alert(LoginID);
        //alert(strResult.d);
        if (strResult.d != "") {
            var arrResult = strResult.d.split("#$#");
            //alert(arrResult[0]);
            if (LoginID == "") {
                $("#txtLoginName").val("");
            }
            else {
                $("#txtLoginName").val(arrResult[0]);
            }

            var LoginName = arrResult[0];

            var strLoginName = $("#txtLoginName").val();
            /*Automation password creation*/
            var objPassword = GetObjectReference('', 'txtPassword');
            var objconfirmPassword = GetObjectReference('', 'txtConfirmPassword');

            var strResult1 = AJAXCallWithResult("Security_login_customer.aspx/GetCompanyInformationDetails", data, false);

            if (strResult1.d != "") {
                var arrResult1 = strResult1.d.split("$$");
            }
            var blnIsAutoPasswordCreation = arrResult1[0];

            if (blnIsAutoPasswordCreation == 'True') {
                
                    if (objPassword != null)
                        objPassword.value = arrResult1[1];
                    if (objconfirmPassword != null)
                        objconfirmPassword.value = arrResult1[1];
                

            }
            /*Automation password creation*/

            $("#collapseOne8").addClass('in');

        }
       
    }
    function Employee_OnClick(LoginID, IsActiveLogin) {
        //alert(IsActiveLogin);
        //$("#collapseOne2").removeClass("collapsed");
        EditLoginID = LoginID;
        $("#Deactivate").css("display", "inline");
        if (IsActiveLogin == 'True') {
            $("#Deactivate").html("Deactivate Login");
        }
        else {
            $("#Deactivate").html("Activate Login");
        }
        $("#collapseOne2").css("display", "block");
        $("#collapseOne2").css("height", "auto");
        $("#collapseOne2 .panel-body").css("height", "auto");
        //$("#plus").css("display", "none");
        //$("#minus").css("display", "block");
      

        $("#CboUserName").html("");

        data = JSON.stringify({ Mode: 'Edit' });
        strResult = AJAXCallWithResult("Security_login_employee.aspx/ComboOnAdd", data, false);
        //alert(strResult.d);
        var strArray = String(strResult.d).split("|")

        var objCbo = document.getElementById("CboUserName");
        var i = 0;
        objCbo.innerHTML = "";

        if (objCbo.value != '') {
            insBlankOpt(objCbo);
        }
        $.each(JSON.parse(strArray[0]), function (id, obj) {

            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.UserName;
            objOption.value = obj.EmployeeID;

        });

        globalEmployeeID = LoginID;
        //document.getElementById('hdnEmployeeID').value = globalEmployeeID;
        data = JSON.stringify({ LoginID: LoginID });
        strResult = AJAXCallWithResult("Security_login_employee.aspx/GetLoginDetails", data, false);

        if (strResult.d != "") {
            var arrResult = strResult.d.split("#$#");

            //alert(arrResult[0]);
            //alert(arrResult[1]);
            //document.getElementById("UserName").disabled = true;   
            //$("#CboUserName").val("");
            //document.getElementById("CboUserName").disabled = true;
            $("#txtLoginName").val(arrResult[0]);
            document.getElementById("txtLoginName").disabled = true;
            $("#CboUserName").val(arrResult[1]);
            document.getElementById("CboUserName").disabled = true;
            // alert(arrResult[3]);
            $("#divRequestTypes").css("display", "none");
            $("#FilerForEmp").css("display", "none");



            /*Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
            if ($("#Addaccordion").hasClass("collapsed")) {
                $("#Addaccordion").removeClass("collapsed");
                $("#collapseOne2").css('height', 'auto');
                $("#collapseOne2").addClass('in');
            }

            /*End of Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
            //$("#collapseOne2").addClass('in');

        }
    }

    function Deactivate_Login() {
        var UserName = $("#CboUserName").val();

        data = JSON.stringify({ UserName: UserName });
        //  alert(data);
        strResult = AJAXCallWithResult("Security_login_employee.aspx/DeactivateLogin", data, false);
        //alert(strResult.d);
        if (strResult.d != "") {

            $("#divRequestTypes").css("display", "block");
            $(".type-top-bar").css("display", "block");
            $("#RequestPaging").css("display", "block");
            if (strResult.d == "2") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Login Activated', 'success');
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Login Deactivated', 'success');
            }
            $("#requesttype").val("");
            $("#requesttypecode").val("");
           
            RefreshGrid("Type", "Flag");
        }
    }

    
    $("#frmSettingsTabs").load(function () {
        
        RemoveFrameLoader();
    });
</script>


<script>
    // Get the modal for Request Type button popup
    //$('.modal').draggable();

    function myFunction()
    { }
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
</script>

   
</html>

