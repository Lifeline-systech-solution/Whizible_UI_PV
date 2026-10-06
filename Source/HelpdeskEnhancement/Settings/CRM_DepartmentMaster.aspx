<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_DepartmentMaster.aspx.vb" Inherits="PbNIT.CRM_DepartmentMaster" %>

<!DOCTYPE html>
<html>
    
<%CommonFunctions.General.PlotPageHeadTag("Admin Panel")%>
<head id="Head1" runat="server">

    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>--%>
    
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,height=device-height, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Admin Panel</title>
    <!-- Bootstrap core CSS -->
    <!-- Bootstrap core CSS -->
 <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>

    <!-- Custom fonts for this template -->
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" />--%>
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->

    <!-- Plugin CSS -->
    <%--<link href="css/editor.css" type="text/css" rel="stylesheet"/>
	 <link href="css/style.css" rel="stylesheet" />
	 <link href="css/reqdetail.css" rel="stylesheet" />
	 <link href="css/setting.css" rel="stylesheet" />
    <link href="css/sb-admin.css" rel="stylesheet" />
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />	
	<link rel="stylesheet" href="css/timepicker.min.css" />--%>
    <link href="../../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
    <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />

        <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

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
        .search-bar .fa-search {
            top:0px;
        }
        .topMargin {
            margin-top:5px;
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
        .top-bar {
            height: 40px!important;
            border-width: 0px 0 1px 0!important;
        }

        .v-tabs .h-tabs div.tab {
            height: 33px;
        }

        .content-wrapper {
            margin-left: 0px !important;
            padding-left: 0px !important;
        }

       #collapseOne .panel-body {
            /*OVERFLOW: auto;*/
            /*HEIGHT: 246PX;*/
        }
        
        .h-tabs div .panel-heading {
            height: 21px;
            border-style: solid;
            border-color: #e3e2e2;
            border-width: 1px 0 1px 0;
            background: #cbddfa;
        }

        .table-responsive .btn-default .btn {
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
            border-bottom: none!important;
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
            /*margin-top: 8px;*/
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

        .edit-bt .delet-btn {
            background: transparent;
            border: none;
            /*font-size: 22px;
            position: relative;
            top: -3px;
            color: #1e88e5;*/
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
        #divDepartment td, #divConfigureHRM td, #divRequestTypeMapping td, #divWorkingHours td, #divRoleMapping td, #divGroupEmail td, #divCustomerMapping td {
            border: none !important;
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
        }

        #divDepartment .table {
            /*width: 101% !important;*/
           
        }
        #divDepartment {
            margin-top: 0px !important;
        }
  /*#divDepartment .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
           
            position: relative;
        }*/

        
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

        #accDepMaster {
            overflow:hidden;
        }
        .fa-pencil-square-o {
    color: #4caac0 !important;
}

        #DivList .dataTables_scroll {
            overflow: hidden!important;
            width: 100%!important;
        }

      #divDepartment .dataTables_scroll {
    overflow: hidden!important;
    width: 100%!important;
}

        #DivList .dataTables_scrollBody {
    overflow: auto!important;
    width: 102%!important;
    height: 130px;
    padding-right: 2%!important;
}   

          /*#divDepartment .dataTables_scrollBody {
    overflow: auto!important;
    width: 102%!important;
    height: 130px;
    padding-right: 2%!important;*/
/*}*/   
        #idPanelBody {
        /*overflow: auto;*/
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
        /*OVERFLOW: HIDDEN;*/
        }

          #divDepartment .dataTables_scroll {
        /*OVERFLOW: HIDDEN;*/
        }

        #tblCustomerMapping .dataTables_scroll {
            /*OVERFLOW: HIDDEN;*/
        }
        #divGridSubRequestType .dataTables_scrollBody {
            position: relative;
            /*overflow: auto;*/
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }
         #divDepartment .dataTables_scrollBody {
            position: relative;
            /*overflow: auto;*/
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }
        
          #tblCustomerMapping .dataTables_scrollBody {
            position: relative;
            /*overflow: auto;*/
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }
        #DivList table tr td:nth-child(1) {
            width:25%!important
        }
         /*#divDepartment table tr td:nth-child(1) {
            width:25%!important
        }*/
        
            #DivList table tr td:nth-child(2) {
            width:25%!important
        }
                #DivList table tr td:nth-child(3) {
            width:40%!important
        }
                   /*#divDepartment table tr td:nth-child(2) {
            width:25%!important
        }
                #divDepartment table tr td:nth-child(3) {
            width:40%!important
        }*/

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
         #divDepartment .dataTables_scrollHeadInner table  .clsTRColumnHeader tr th:nth-child(4) {
            text-align:center;            
        }

         #tblCustomerMapping dataTables_scrollHeadInner table  .clsTRColumnHeader tr th:nth-child(4) {
            text-align:center;
        }
        #divGridSubRequestType .container-fluid {
            min-height: 0px !important;
        }

        #divDepartment .container-fluid {
            min-height: 0px !important;
        }

         #tblCustomerMapping .container-fluid {
            min-height: 0px !important;
        }

          #divStatus .container-fluid {
     min-height: 0px !important; 
}
        #collapseOne2 {
        /*overflow:hidden;*/
        }
         #collapseOne2 .panel-body {
           /*overflow: auto;*/
        /*height: 150px;*/
        width: 103%;
        padding-right: 2%;
        }
           #collapseOne3 {
        /*overflow:hidden;*/
        }
         #collapseOne3 .panel-body {
           /*overflow: auto;*/
        /*height: 150px;*/
        width: 103%;
        padding-right: 2%;
        }

        .dataTables_scrollBody .table tbody .even {
        /*background-color:#e8edf6;*/
        
        }

           #divStatus .dataTables_scroll {
        /*OVERFLOW: HIDDEN;*/
        }
        #divStatus .dataTables_scrollBody {
            position: relative;
            /*overflow: auto;*/
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
          select.form-control:not([size]):not([multiple]) {
    height: calc(2.25rem + 7px);
        }
        #divPriority .container-fluid {
            min-height: 0px !important; 
        }
        
        #collapseOne4 {
            /*overflow:hidden;*/
        }
        #collapseOne4 .panel-body {
            /*overflow: auto;*/
            /*height: 150px;*/
            width: 103%;
            padding-right: 2%;
        }

          #divPriority .dataTables_scroll {
        /*OVERFLOW: HIDDEN;*/
        }
        #divPriority .dataTables_scrollBody {
            position: relative;
            /*overflow: auto;*/
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }
           #divSeverity .dataTables_scroll {
        /*OVERFLOW: HIDDEN;*/
        }
        #divSeverity .dataTables_scrollBody {
            position: relative;
            /*overflow: auto;*/
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

          #divSeverity .container-fluid {
            min-height: 0px !important;
           
        }
        
        #collapseOne5 {
            /*overflow:hidden;*/
        }
        #collapseOne5 .panel-body {
            /*overflow: auto;*/
            /*height: 150px;*/
            width: 103%;
            padding-right: 2%;
        }
        .clsCheckbox {
            width: 11px !important;
        }
        .clsShowHorizontalDiv {
            display:block;
        }
          .clsHideHorizontalDiv {
              display:none;
        }

        .clsSubtags {
            width:auto !important;
            padding:12px;
        }
        /*#tblRoleMapping_wrapper {
            min-height:200px!important;
        }*/
        #SearchRequestDepartment {
            border-radius: 25px;
            border: 1px solid #ddd;
            outline: none;
            margin-top: 0px;
            /*margin-left: 5%;*/
            font-weight: normal;
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
            /*padding: 20px;*/
            /*width: 200px;
            height: 150px;*/
        }
        .dataTables_info {
            /*display:none;*/
        }
        .container-fluid {
    min-height: 0px !important;
}

        .table-stripped {
            /*background-color:lightgrey !important;*/
        }

        .clsAnchorRequestLink:hover{
                /*text-decoration : none !important;*/
                font-size:14px!important;
            }
        .h-tabs .bottom-bar .form-group {
            padding: 2px 0 !important;
        }
        .clsSubTagFont {
            font-size:12px !important;
        }
        .clsEditCenterAlign {
            text-align:center;
        }

        .v-tabs .h-tabs div.tab button.active {
            border: 1px solid lightgrey;
            padding-left: 15px;
            height:200px;
            border-bottom: none;
        }

        .faSettingSearch {
            position: absolute;
            margin-top: 8px;
            margin-left: 8%;
        }
        .tablinks4 {
            height: 30px;
            background-color: white;
        }




        .tab {
            padding-left: 15px;
            margin-bottom: 0px;
        }

        #Department .h-tabs div.tab button {
        /*border:none !important;*/
        border-bottom:1px solid #ddd;
         
        }

        .multi-btn, .multi-drop, ul.pagination {
            padding: 0px 4px 0 0px;
            float: left;
            width: 100%;
        }

        #Department .h-tabs div.tab {
        border-bottom: none;
        }

        .clsShowHorizontalDiv div.tab button {
        border:none ;
        outline:none ;
        }
        /*#divDepartment {
            border:none;
        }*/
        #divConfigureHRM .dataTables_wrapper .row:nth-child(2) > .col-sm-12{
            padding-right:0px!important;
            padding-left:0px!important;
        }
        .dataTables_scrollHeadInner {
            width: 100%;
        }
        #accDepMaster a .fa.fa-minus{display:block;color:white!important;}
        #accDepMaster a .fa.fa-plus{display:none;color:white!important;}
        #accDepMaster .collapse.in .fa.fa-minus{ display:block;color:white!important;}
        #accDepMaster .collapse.in .fa.fa-plus{display:none;color:white!important;}
        #accDepMaster .collapsed .fa.fa-minus{display:none;color:white!important;}
        #accDepMaster .collapsed .fa.fa-plus{display:block;color:white!important;}
        #btnSaveAndAdd .fa.fa-plus{display:inline-block!important; color:white;}
        /*#accCustMapping a .fa.fa-minus{display:block;}
        #accCustMapping a .fa.fa-plus{display:none;}
        #accCustMapping .collapse.in .fa.fa-minus{ display:block;}
        #accCustMapping .collapse.in .fa.fa-plus{display:none;}
        #accCustMapping .collapsed .fa.fa-minus{display:none;}
        #accCustMapping .collapsed .fa.fa-plus{display:block;}*/
        

        #divDepartment th:nth-child(3), #divConfigureHRM th:nth-child(3), #divRoleMapping  th:nth-child(3), #divGroupEmail  th:nth-child(3), #divCustomerMapping  th:nth-child(2), #divCustomerMapping  th:nth-child(3){
            text-align: center;
        }
        #divWorkingHours th:nth-child(4) {
             text-align: left;
        }
        /*#divConfigureHRM th:nth-child(3) {
            text-align: center;
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
            padding-right: 0px !important;
        }
        .dataTables_scroll {
            border-bottom: 1.5px solid lightgrey;
        }
        /*#btnDepartment {
            background-color: transparent !important;
            color: black !important;
        }*/
        .top-bar .btn-default {
            background-color: transparent !important;
            color: black !important;
            border:none;
            font-size: 11px;
            font-weight: 600;
            line-height: 10px;
        }
        /*#btnDepartment {
            font-size: 11px;            
        }*/
       #btnConfigureHRM, #btnRoleMapping, #btnGroupEmail, #btnCustomerMapping, #btnRequestTypeMapping, #btnWorkingHours {
            font-size: 12px;       
        }

        .top-bar {
            float: left;
            width: 98%;
        }
        /*.bottom-bar .pannel-section i.fa.fa-plus, .bottom-bar .pannel-section i.fa.fa-minus {
            color: #000;
            line-height: 7px;
        }*/

        .form-horizontal .form-group {
            line-height: 3;
        }
        .h-type div.tab button.active {
            border: 1px solid #ddd !important;
            border-bottom: none !important;
        }
        .fa-trash-o {
            color: red;           
        }
        .top-bar {
            padding: 0px 0px !important;
            /*padding-bottom: 7px !important;*/
        }
        .panel-body ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 17px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
            padding-left: 0px;
            padding-top: 10px;
            position: relative;
        }
        .h-tabs {
            padding: 0 0 5px 0px !important;
        }
        .panel-body ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 17px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 0px;
            padding-left: 0px;
            padding-top: 0px;
            position: relative;
        }

        /*.top-bar ul.right li {
            border-right: 0px solid #ddd;
        }*/
        .form-group {
            border:none!important;
             font-weight: normal;
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
        }
        .bottom-bar input {
            width: 292px;
            /*height: 23px;*/
            padding: 0;
            font-size: 11px;
            border-radius: 3px;
            padding-left: 7px;
            border-color: #bbb;
        }
        .bottom-bar textarea {
            border-color: #bbb;
        }
        .form-control {
            display: block;
            width: 100%;
            height: 34px;
            padding: 0px 0px; 
            font-size: 14px;
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
        input.form-control, input.form-control, select {
            height: 23px;
        }
    
         #cboResource, #cboDepartmentHead, #cboRoles, #cboCustomers {
            height: 23px;
        }


        /*.right .btn-default:hover {
            background: #567a00 !important;
            color: white!important;
        }
        CRM_DepartmentM…rTagID=396:599 .top-bar .btn-default {
            background-color: transparent !important;
            color: black !important;
            border: none;
            font-size: 11px;
            font-weight: 600;
            line-height: 10px;
        }*/

        #btnAddConfigureHRM, #btnAddRoleMapping, #btnAddCustomerMapping, #btnAddGroupEmail{
            padding: 0 10px;
            float: left;
            font-size: 12px;
            font-weight: 600;
        }

          .right .btn-default {
            background-color:white!important;
            color:black!important;
        }

        #divDepartment .fa-sort {
            display:none!important;
        }

        .input.form-control, input.form-control {
    height: 28px!important;
}

        #cboDepartmentHead {
            height:28px!important;
        }

        select {
             height:28px!important;
        }
        /*.bottom-bar .fa.fa-plus {
            display:block!important;
        }*/

        .bottom-bar .fa.fa-plus {
            display:block;
        }
        .top-bar ul.right li {
            border-right:1px solid white!important;
        }

        #chkDepartmentSelectAll {
            text-align:center;
            margin-left:-8%;
        }

        /*Added by Yasmin On 11th July 2018*/
        .bottom-bar {
            width: 97%!important;
            margin-left: 12px;
        }
        .dataTables_paginate {
            float: right !important;
            margin-right: -2px!important;
        }

        @media (max-width:875px) {
          .bottom-bar {
            width: 96%!important;
           
        }
        }
    </style>

<body class="" id="page-top">

    <!-- Navigation -->
    <%--<button type='button' class='btn btn-default right'>Test</button>--%>
    <% PlotHTML() %>

    <!-- ----- Request Type inherit status flow button popup---------------------------->
    <div id="id14" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Inherit Status Flow</span>
                <span onclick="document.getElementById('id14').style.display='none'" class="close" title="Close">&times;</span>
            </div>
            <div class="container">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="request type">From Sub Request*</label>
                    <div class="col-sm-8">
                        <%--<select class="form-control" id="Select11" style="width: 200px;">
                                <option>Department</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                            </select>--%>
                        <%=CommonFunctions.HTMLControls.DrawComboBox("CbofrmSubRequest", "usp_Sel_InheritRequestTypes 'FromSubType'", , , "class='form-control' ", False, True)%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="request type code">To Sub Request Type*</label>
                    <div class="col-sm-8">
                        <%-- <select class="form-control" id="Select12" style="width: 200px;">
                                <option></option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                            </select>--%>
                        <%=CommonFunctions.HTMLControls.DrawComboBox("CboToSubRequest", "usp_Sel_InheritRequestTypes 'ToSubType',NULL", , , "class='form-control'", False, True)%>
                    </div>
                </div>
                <div class="form-group">
                    <div class="right">
                        <button type="button" class="btn btn-default" onclick="Inherit_StatusFlow()" style="background-color: #343660; color: #fff;">Inherit</button>
                        <button type="button" class="btn btn-default" onclick="Cancel_StatusFlow()" style="background-color: #fff; color: #343660;">Cancel</button>
                    </div>
                </div>
            </div>
        </form>
    </div>


    <!-- -----Department in Working Hours button popup---------------------------->
    <div id="id15" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Working Hours</span>
                <span onclick="document.getElementById('id15').style.display='none'" class="close" title="Close">&times;</span>
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
                                    <td><i class="fa fa-pencil-square-o" aria-hidden="true" style="color: #1e88e5;"></i></td>
                                    <td>
                                        <button type="button" class="btn btn-default" style="background-color: #343660; color: #fff;">Save</button></td>
                                </tr>

                                <tr>
                                    <td>1-Monday</td>
                                    <td>
                                        <input type="checkbox" id="Checkbox9"></td>
                                    <td>3:30 AM</td>
                                    <td>4:30 AM</td>
                                    <td><i class="fa fa-pencil-square-o" aria-hidden="true" style="color: #1e88e5;"></i></td>
                                    <td></td>
                                </tr>

                                <tr>
                                    <td>1-Monday</td>
                                    <td>
                                        <input type="checkbox" id="Checkbox10"></td>
                                    <td>3:30 AM</td>
                                    <td>4:30 AM</td>
                                    <td><i class="fa fa-pencil-square-o" aria-hidden="true" style="color: #1e88e5;"></i></td>
                                    <td></td>
                                </tr>

                                <tr>
                                    <td>2-Friday</td>
                                    <td>
                                        <input type="checkbox" id="Checkbox11"></td>
                                    <td>3:30 AM</td>
                                    <td>4:30 AM</td>
                                    <td><i class="fa fa-pencil-square-o" aria-hidden="true" style="color: #1e88e5;"></i></td>
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
                <span onclick="document.getElementById('id09').style.display='none'" class="close" title="Close">&times;</span>
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
                <span onclick="document.getElementById('id10').style.display='none'" class="close" title="Close">&times;</span>
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
                <span onclick="document.getElementById('id11').style.display='none'" class="close" title="Close">&times;</span>
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
                <span onclick="document.getElementById('id12').style.display='none'" class="close" title="Close ">&times;</span>
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
                <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close ">&times;</span>
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
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <div id="divHistory" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Show History</span>
                <span onclick="document.getElementById('divHistory').style.display='none'" class="close" title="Close ">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group" style="margin-top:5px;">
                    <label class="control-label col-sm-2 clslabel" style="margin-top:5px;" for="request type">Modified Field</label>
                    <div class="col-sm-4">
                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter " & Request.QueryString("MasterTagID"), 150, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                    </div>

                    <label class="control-label col-sm-2 clslabel" style="margin-top:5px;" for="request type code">Modified By</label>
                    <div class="col-sm-4">
                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter " & Request.QueryString("MasterTagID"), 150, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                    </div>

                </div>
                <div class="container-fluid" id="modalbody" style="overflow: auto; height: 245px;">
                </div>
            </div>
        </form>
    </div>


    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>

    <%--<script src="vendor/popper/popper.min.js"></script>--%>
    <script src="../../../EnhancementFiles/vendor/popper/popper.min.js"></script>

    <%--<script src="js/editor.js"></script>--%>
    <script src="../../../EnhancementFiles/js/editor.js"></script>

    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>

    <!-- Time picker -->
    <%--<script src="js/timepicker.min.js"></script>
<script src="js/timepicker.js"></script>--%>
    <script src="../../../EnhancementFiles/js/timepicker.js"></script>
    <script src="../../../EnhancementFiles/js/timepicker.min.js"></script>


    <%--<script src="../../General/CommonFunctions.js"></script>
	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../../Plugins/alertify/alertify.min.js"></script>
    <!-- Time picker -->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="js/timepicker.min.js"></script>
    <script src="js/timepicker.js"></script>
    <script>
         
             
       
        
            $(function () {
                $('#timepicker1').timepicker();
                $('#timepicker2').timepicker();
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
            });
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


    <script>
            var strPageName = "CRM_DepartmentMaster.aspx";
            $(document).click(function () {
                //alert(window.parent.parent.parent.location);
                $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
                $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

            })
            $(document).ready(function () {
                $("#txtEditor").Editor();
                $("#txtEditor1").Editor();
                $("#txtEditor2").Editor();
                $("#txtEditor3").Editor();
                
            });
    </script>

    <script>
            var TabName = "";
            var Flag = "";

            function openCity4(evt, cityName) {
                //debugger;
                var i, tabcontent4, tablinks4;
                tabcontent4 = document.getElementsByClassName("tabcontent4");
                for (i = 0; i < tabcontent4.length; i++) {
                    tabcontent4[i].style.display = "none";
                }
                tablinks4 = document.getElementsByClassName("tablinks4");
                for (i = 0; i < tablinks4.length; i++) {
                    tablinks4[i].className = tablinks4[i].className.replace(" active", "");
                }
                document.getElementById(cityName).style.display = "block";
                evt.currentTarget.className += " active";
                if (cityName == "ConfigureHRM") {
                    try {

                        RefreshGrid(cityName, Flag);
                        //$("#tblConfigureHRM").find("tr:gt(0)").remove();
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                    showHidePanel('panelHRM', 'panelHRMAdd', 'none');
                    //getConfiguredHRM(CurDepartment);
                    AddConfigureHRM();
                    getDepartmentResource(CurDepartment);
                }
                if (cityName == "RoleMapping") {
                    try
                    {
                        RefreshGrid("RoleMapping", Flag);
                        // AddRoleMapping()
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                    //$("#tblRoleMapping").find("tr:gt(0)").remove();
                    showHidePanel('panelRole', 'panelRoleAdd', 'none');

                    //$("#tblRoleMapping").css("min-height","100px");
                  
                    //getMappedRoles(CurDepartment);
                    getRoles(CurDepartment);
                    AddRoleMapping();
                }
                //Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
                if (cityName == "ProjectMapping") {
                    //$("#tblGroupEmail").find("tr:gt(0)").remove();

                    RefreshGrid("ProjectMapping", Flag);
                    showHidePanel('panelProjectMapping', 'panelProjectMappingAdd', 'none');
                    getProjects(CurDepartment);
                    AddProjectMapping();
                }
               //End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
                if (cityName == "GroupEmail") {
                    //$("#tblGroupEmail").find("tr:gt(0)").remove();

                    RefreshGrid("GroupEmail", Flag);
                    showHidePanel('panelGroupEmail', 'panelGroupEmailAdd', 'none');
                    //getGroupEmails(CurDepartment);
                    AddGroupEmail();
                }
                if (cityName == "CustomerMapping") {
                    //$("#tblCustomerMapping").find("tr:gt(0)").remove();
                    RefreshGrid("CustomerMapping", Flag);
                    showHidePanel('panelCustomerMapping', 'panelCustomerMappingAdd', 'none');
                    //getCustomerMapping(CurDepartment);
                    getCustomers(CurDepartment);
                    AddCustomerMapping();
                    andExposeToCustomer();
                }
                if (cityName == "RequestTypeMapping")
                {
                    $("#tblRequestTypeMapping").find("tr:gt(0)").remove();
                    showHidePanel('panelRequestType', 'panelRequestTypeAdd', 'none');
                    getRequestMapDepartment(CurDepartment);
                    getRequestMapRequestType(CurDepartment);
                    RefreshGrid("RequestTypeMapping", Flag);

                    $('#cboRequestMapDepartment option[value="0"]').attr("disabled", "disabled");
                    $('#cboRequestMapRequestType option[value="0"]').attr("disabled", "disabled");
                    
                    //getRequestTypeMapping(CurDepartment);
                }
                if (cityName == "WorkingHours") {
                    $("#tblWorkingHours").find("tr:gt(0)").remove();
                    showHidePanel('panelWorkingHours', 'panelWorkingHoursAdd', 'none');
                    RefreshGrid("WorkingHours", Flag);
                    //getWorkingHours(CurDepartment);
                }
                
            }
            function RefreshSubTags()
            {
                if ($("#btnConfigureHRM").hasClass("active"))
                {
                    
                    RefreshGrid("ConfigureHRM", Flag);
                    //$("#tblConfigureHRM").find("tr:gt(0)").remove();
                   
                    showHidePanel('panelHRM', 'panelHRMAdd', 'none');
                    //getConfiguredHRM(CurDepartment);
                    AddConfigureHRM();
                    getDepartmentResource(CurDepartment);
                }

                if ($("#btnRoleMapping").hasClass("active")) {
                    //$("#tblRoleMapping").find("tr:gt(0)").remove();
                    RefreshGrid("RoleMapping", Flag);
                    showHidePanel('panelRole', 'panelRoleAdd', 'none');

                    //$("#tblRoleMapping").css("min-height", "100px");

                    //getMappedRoles(CurDepartment);
                    getRoles(CurDepartment);
                }

                //Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
                if ($("#btnProjectMapping").hasClass("active")) {
                    RefreshGrid("ProjectMapping", Flag);
                    showHidePanel('panelProjectMapping', 'panelProjectMappingAdd', 'none');
                }
                //End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue

                if ($("#btnGroupEmail").hasClass("active")) {
                    //$("#tblGroupEmail").find("tr:gt(0)").remove();
                    RefreshGrid("GroupEmail", Flag);
                    showHidePanel('panelGroupEmail', 'panelGroupEmailAdd', 'none');
                    //getGroupEmails(CurDepartment);
                }

                if ($("#btnCustomerMapping").hasClass("active")) {
                    $("#tblCustomerMapping").find("tr:gt(0)").remove();
                    showHidePanel('panelCustomerMapping', 'panelCustomerMappingAdd', 'none');
                    RefreshGrid("CustomerMapping", Flag);
                    //getCustomerMapping(CurDepartment);
                    getCustomers(CurDepartment);
                }

                if ($("#btnRequestTypeMapping").hasClass("active")) {
                    $("#tblRequestTypeMapping").find("tr:gt(0)").remove();
                    showHidePanel('panelRequestType', 'panelRequestTypeAdd', 'none');
                    getRequestMapDepartment(CurDepartment);
                    getRequestMapRequestType(CurDepartment);
                    RefreshGrid("RequestTypeMapping", Flag);
                    //getRequestTypeMapping(CurDepartment);
                }

                if ($("#btnWorkingHours").hasClass("active")) {
                    $("#tblWorkingHours").find("tr:gt(0)").remove();
                    showHidePanel('panelWorkingHours', 'panelWorkingHoursAdd', 'none');
                    //getWorkingHours(CurDepartment);
                    RefreshGrid("WorkingHours", Flag);
                }
            }
            function showHidePanel(panelname, panelnameadd, flag) {

                if (WhichBrowser() == "IE") {
                    if (flag == 'grid') {
                        $("#" + panelname).css('visibility', '' + 'visible' + '');
                        $("#" + panelnameadd).css('visibility', '' + 'visible' + '');
                    }
                    if (flag == 'none') {
                        $("#" + panelname).css('visibility', '' + 'hidden' + '');
                        $("#" + panelnameadd).css('visibility', '' + 'hidden' + '');
                    }
                }
                else {
                    $("#" + panelname).css('display', '' + flag + '');
                    $("#" + panelnameadd).css('display', '' + flag + '');
                }
            }
            function ShowHideHorizontalDiv() {
                if ($("#DivHorizontal").hasClass("clsShowHorizontalDiv")) {
                    $("#DivHorizontal").removeClass("clsShowHorizontalDiv");
                    $("#DivHorizontal").addClass("clsHideHorizontalDiv");
                }
            }
            function ShowHideMainTable(flag) {
                if (flag == 'show') {
                    $("#divDepartment").css("display", "block");
                    $("#divDatatableSearchButton").css("display", "block");

                }
                else {
                    $("#divDepartment").css("display", "none");
                    $("#divDatatableSearchButton").css("display", "none");
                }

            }
            function ShowHidecollapseOneDept() {
                var isHidden = document.getElementById("collapseOneDept").style.display == "none";              
                if (isHidden) {
                    $("#collapseOneDept").css("display", "block");
                    $("#faplus").css("display", "none");
                    $("#faminus").css("display", "block");
                    if (btnAddClick == 0) {
                        $("#cboDepartmentHead").css("visibility", "visible");
                        $("#lblDepartmentHead").css("visibility", "visible");
                    }
                }
                else {
                    $("#collapseOneDept").css("display", "none");

                    $("#faplus").css("display", "block");
                    $("#faminus").css("display", "none");

                    $("#cboDepartmentHead").css("visibility", "hidden");
                    $("#lblDepartmentHead").css("visibility", "hidden");
                }

            }
            function openCity1(evt, cityName) {
                if (cityName == 'Department') {
                    ShowHideHorizontalDiv();
                    clearDepartmentDetails();
                    btnAddClick = 0;
                    btnEditClick = 0;
                    $("#cboDepartmentHead").css("visibility", "hidden");
                    $("#lblDepartmentHead").css("visibility", "hidden");
                }
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

                RefreshGrid(cityName, Flag);
                evt.currentTarget.className += " active";
            }
            // Get the element with id="defaultOpen" and click on it
            //document.getElementById("defaultOpen1").click();
            function RefreshPage() {

                var strResult, data;
                var GridParameter = {};

               
                var DivId;
                var DivSerach;
              
                        DivId = "divDepartment";
                        DivSerach = "SearchRequestDepartment";
                   
                var TypeDiv; var accordion;
                //TypeDiv = document.getElementById('divRequestTypes');
                //accordion = document.getElementById('accordion');
                var intDivGridHeight
               //    if (TypeDiv != null && accordion != null) {
                if (WhichBrowser() == "IE") {
                    intDivGridHeight = (window.innerHeight / 2);

                    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {

                        intDivGridListHeight = parseInt(window.innerHeight) - 500;
                    }
                    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                        intDivGridListHeight = parseInt(window.innerHeight) - 500;
                    }
                    else {
                     
                        //intDivGridListHeight = parseInt(window.innerHeight) - parseInt($('#' + DivId).offset().top) - 250;
                        intDivGridListHeight = (window.innerHeight / 3) - 5;
                    }

                    //$('.panel-body').css('height', intDivGridListHeight + "px");
                    //$('#accordion').css('height', intDivGridListHeight - 20 + "px");
                    $("#divMainBlock").css('height', intDivGridListHeight + 470 + "px");
                    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
                    
                }
                else {
                   
                    intDivGridHeight = (window.innerHeight / 2);

                    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
                      
                        intDivGridListHeight = parseInt(window.innerHeight) - 500;
                        
                    }
                    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                       
                        intDivGridListHeight = parseInt(window.innerHeight) - 500;
                       
                    }
                   
                    else {
                        
                        intDivGridListHeight = (window.innerHeight / 3) - 5;
                        
                    }
                    
                    //$('#accordion').css('height', intDivGridListHeight - 20 + "px");
                    $("#divMainBlock").css('height', intDivGridListHeight + 470 + "px");
                    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
                    
                }

                datatables(DivId, DivSerach);
                //setWidthDatatable("DivList");

            }

            function RefreshGrid(cityName, Flag) {
                try{
                   
                    var strResult, data;
                    var GridParameter = {};
               
                    GridParameter.cityName = cityName;
                    if (CurDepartment == "")
                        CurDepartment = 0;
                    if (Flag == 'changedept') {
                        data = JSON.stringify({ GridParam: GridParameter, Id: GlobalDepartmentID });
                    }
                    else {
                        data = JSON.stringify({ GridParam: GridParameter, Id: GlobalDepartmentID });
                    }
                    if (Flag == 'changedeptandrequest') {
                        data = JSON.stringify({ GridParam: GridParameter, Id: GlobalDepartmentID, RequestType: $("#cboRequestMapRequestType").val() });
                        strResult = AJAXCallWithResult(strPageName + "/GetGridDataWithRequestType", data, false);
                    }
                    else {
                        strResult = AJAXCallWithResult(strPageName + "/GetGridData", data, false);
                    }
                    var DivId;
                    var DivSerach;
                    
                    if (strResult.d != '') {
                        if (cityName == "ConfigureHRM") {
                            DivId = "divForConfigureHRM";
                            DivSerach = "";
                        }
                        else if (cityName == "RoleMapping") {
                            DivId = "divForRoleMapping";
                            DivSerach = "";
                        }
                        //Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
                        else if (cityName == "ProjectMapping") {
                            DivId = "divForProjectMapping";
                            DivSerach = "";
                        }
                        //End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
                        else if (cityName == "GroupEmail") {
                            DivId = "divForGroupEmail";
                            DivSerach = "";
                        }

                        else if (cityName == "CustomerMapping") {
                            DivId = "divForCustomerMapping";
                            DivSerach = "";
                        }
                        else if (cityName == "RequestTypeMapping") {
                            DivId = "divForRequestTypeMapping";
                            DivSerach = "";
                        }
                        else if (cityName == "WorkingHours") {
                            DivId = "divForWorkingHours";
                            DivSerach = "";
                        }
                        else if (cityName == "Department") {
                            //DivId = "divDepartment";
                            //DivSerach = "SearchRequestDepartment";

                            DivId = "divForDepartment";
                            DivSerach = "SearchRequestDepartment";                        
                        }

                        //else if (cityName == "Type") {
                        //    DivId = "DivList";
                        //}


                 
                        //if (WhichBrowser() == "IE") {
                        //if (cityName == "Department") {
                        //    $("#" + DivId).html(strResult.d);

                        //    $("#" + DivId).addClass("table");
                        //}
                        //else {
                        $("#" + DivId + " .table-responsive:first").html(strResult.d);

                        $("#" + DivId + " .table-responsive:first table").addClass("table");
                        //}
                        //}
                        //else {
                        //    $("#" + DivId).html(strResult.d);

                        //    $("#" + DivId).addClass("table");
                        //}
                   
                    }
                    var TypeDiv; var accordion;
                    //TypeDiv = document.getElementById('divRequestTypes');
                    //accordion = document.getElementById('accordion');
                    var intDivGridHeight
                    //   if (TypeDiv != null && accordion != null) {
                    //if (WhichBrowser() == "IE") {
                    //    intDivGridHeight = (window.innerHeight / 2);

                    //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {

                    //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
                    //    }
                    //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                    //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
                    //    }
                    //    else {

                    //        intDivGridListHeight = parseInt(window.innerHeight) - parseInt($('#' + DivId).offset().top) - 250;
                    //    }

                    //    $('.panel-body').css('height', intDivGridListHeight + "px");
                    //    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
                    //    $('#divRequestTypes').css('height', intDivGridListHeight - 130 + "px");
                    //}
                    //else {
                    //    intDivGridHeight = (window.innerHeight / 2);

                    //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
                    //        intDivGridListHeight = parseInt(window.innerHeight) - 385;
                    //    }
                    //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                    //        intDivGridListHeight = parseInt(window.innerHeight) - 385;
                    //    }
                    //    else {
                    //        intDivGridListHeight = (window.innerHeight / 3) - 5;
                    //    }

                    //    $('#accordion').css('height', intDivGridListHeight - 20 + "px");
                    //    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
                    //    $('#divRequestTypes').css('height', intDivGridListHeight - 130 + "px");
                    //}
                    if (cityName == "ConfigureHRM")
                        datatables(DivId, DivSerach);
                    else if (cityName == "RoleMapping")
                        datatables(DivId, DivSerach);
                    else if (cityName == "GroupEmail")
                        datatables(DivId, DivSerach);
                    else if (cityName == "CustomerMapping")
                        datatables(DivId, DivSerach);
                    else if (cityName == "RequestTypeMapping")
                        datatables(DivId, 'SearchRquestType');
                    else if (cityName == "WorkingHours")
                        datatables(DivId, DivSerach);
                    else
                        datatables(DivId, DivSerach);
                    //RefreshPage();
                    //setWidthDatatable("DivList");
                }
                catch (ex) {
                    //alert(ex.message);
                }
            }


            // $(".table-responsive tbody").css("overflow", "auto");
            // $(".table-responsive").css("height", intDivGridListHeight + "px");

            //   }
           
            function getDepartmentHead(entity) {
                var url = "CRM_DepartmentMaster.aspx/Default_GetDepartmentHead"


                data = JSON.stringify({ DepartmentID: entity });
                CustomAJAXCall(url, data, BindDropDownDepartmentHead);
            }
            function BindDropDownDepartmentHead(result) {
                //  debugger;
                var strArray = String(result.d).split("|")
                var objCbo = document.getElementById("cboDepartmentHead");

                var i = 0;

                objCbo.innerHTML = "";

             

                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    // $("#DRequestType").val($("#DRequestType option:first").val());
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = obj.UserName;
                    objOption.value = obj.EmployeeID;

                });
            }

            function getRoles(entity) {
                var url = "CRM_DepartmentMaster.aspx/Default_GetRoles"


                data = JSON.stringify({ DepartmentID: entity });
                CustomAJAXCall(url, data, BindDropDownRoles);
            }
            function BindDropDownRoles(result) {
                //  debugger;
                var strArray = String(result.d).split("|")
                var objCbo = document.getElementById("cboRoles");

                var i = 0;

                objCbo.innerHTML = "";
                $('#cboRoles').find('option').remove().end();
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = "";
                objOption.value = "";

                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    // $("#DRequestType").val($("#DRequestType option:first").val());
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = obj.RoleDescription;
                    objOption.value = obj.RoleID;
                });
            }

        //Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
        function getProjects(entity) {
                var url = "CRM_DepartmentMaster.aspx/Default_GetProjects"


                data = JSON.stringify({ DepartmentID: entity });
                CustomAJAXCall(url, data, BindDropDownProjects);
            }
            function BindDropDownProjects(result) {
                //  debugger;
                var strArray = String(result.d).split("|")
                var objCbo = document.getElementById("cboProjects");

                var i = 0;

                objCbo.innerHTML = "";
                $('#cboProjects').find('option').remove().end();
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = "";
                objOption.value = "";

                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    // $("#DRequestType").val($("#DRequestType option:first").val());
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = obj.ProjectName;
                    objOption.value = obj.ProjectID;
                });
            }
       //End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
            function getCustomers(entity) {
                var url = "CRM_DepartmentMaster.aspx/Default_GetCustomers"


                data = JSON.stringify({ DepartmentID: entity });
                CustomAJAXCall(url, data, BindDropDownCustomers);
            }
            function BindDropDownCustomers(result) {
                //  debugger;
                var strArray = String(result.d).split("|")
                var objCbo = document.getElementById("cboCustomers");

                var i = 0;

                objCbo.innerHTML = "";


                $('#cboCustomers').find('option').remove().end();
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = "";
                objOption.value = "";
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                  
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = obj.CustomerName;
                    objOption.value = obj.Customer;

                });
            }

            function getDepartmentResource(entity) {
                var url = "CRM_DepartmentMaster.aspx/Default_GetDepartmentResource"


                data = JSON.stringify({ DepartmentID: entity });
                CustomAJAXCall(url, data, BindDropDownDepartmentResource);
            }
            function BindDropDownDepartmentResource(result) {
                //  debugger;
                var strArray = String(result.d).split("|")
                var objCbo = document.getElementById("cboResource");

                var i = 0;

                objCbo.innerHTML = "";


                $('#cboResource').find('option').remove().end();
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = "";
                objOption.value = "";
                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);


                    objOption.text = obj.UserName;
                    objOption.value = obj.EmployeeID;

                });
            }


            function getRequestMapDepartment(entity) {
                //debugger;
                var url = "CRM_DepartmentMaster.aspx/Default_GetRequestMapDepartment"


                data = JSON.stringify({ DepartmentID: entity });
                CustomAJAXCall(url, data, BindDropDownRequestMapDepartment);
                $('#cboRequestMapDepartment').val(entity);
            }
            function BindDropDownRequestMapDepartment(result) {
                  //debugger;
                var strArray = String(result.d).split("|")
                var objCbo = document.getElementById("cboRequestMapDepartment");

                var i = 0;

                objCbo.innerHTML = "";
                $('#cboRequestMapDepartment').find('option').remove().end();


                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    // $("#DRequestType").val($("#DRequestType option:first").val());
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = obj.Department;
                    objOption.value = obj.DepartmentID;

                });
            }
            
            function getRequestMapRequestType(entity) {
                //debugger;
                var url = "CRM_DepartmentMaster.aspx/Default_GetRequestMapRequestType"


                data = JSON.stringify({ DepartmentID: entity });
                CustomAJAXCall(url, data, BindDropDownRequestMapRequestType);
            }
            function BindDropDownRequestMapRequestType(result) {
                  //debugger;
                var strArray = String(result.d).split("|")
                var objCbo = document.getElementById("cboRequestMapRequestType");

                var i = 0;

                objCbo.innerHTML = "";

                $('#cboRequestMapRequestType').find('option').remove().end();

                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);

                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    // $("#DRequestType").val($("#DRequestType option:first").val());
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = obj.RequestType;
                    objOption.value = obj.RequestTypeID;

                });
            }
            function AddConfigureHRM() {
              
                //debugger;
                //$("#panelHRM").css('display', 'block');
                //$("#panelHRMAdd").css('display', 'block');
                showHidePanel('panelHRM', 'panelHRMAdd', 'grid');
                $("#cboResource").prop('disabled', false);
                $('#cboResource').focus();
            }
            
           
          
            function deleteConfigureHRM(functionCRMID) {
              
              //  alertify.confirm('', 'Are you sure, you want to delete the selected records?', function () {
                    //alertify.success('Ok');
                    data = JSON.stringify({ FunctionCRMID: functionCRMID });

                    strResult = AJAXCallWithResult(strPageName + "/DeleteConfiguredHRM", data, false);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('HRM deleted successfully', 'success');
                    RefreshGrid("ConfigureHRM", Flag);
                    //getConfiguredHRM(CurDepartment);

                //}
                // , function () {
                //     //alertify.error('Cancel');
                //     //return false;
                // });                   
                  
               
            }

            function updateConfigureHRM(functionCRMID, CRMID, sendMail, userName) {
                //debugger;
                //$("#panelHRM").css('display', 'block');
                //$("#panelHRMAdd").css('display', 'block');
                showHidePanel('panelHRM', 'panelHRMAdd', 'grid');
                FunctionCRMID = functionCRMID;

                if (sendMail == "True") {
                    $('#chkSendEmail').prop('checked', true);
                }
                else {
                    $('#chkSendEmail').prop('checked', false);
                }
                var objCbo = document.getElementById("cboResource");

                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = userName;
                objOption.value = CRMID;
                $("#cboResource").val(CRMID);
                $("#cboResource").focus();
                $("#cboResource").prop('disabled', true);              
            }

            function saveConfigureHRM(btntype) {
                //debugger;
                //if (ValidateConfigureHRM() == 0) {

                if ($("#cboResource").val() != "") {

                    var isSendMail = 0;

                    if ($('#chkSendEmail').is(":checked")) {
                        isSendMail = 1
                    }
                    //alert(FunctionCRMID);
                    if (FunctionCRMID == 0) {

                        //btnAddEmailClick = 1;
                        data = JSON.stringify({
                            DepartmentID: CurDepartment, EmployeeID: $("#cboResource").val(), SendMail: isSendMail
                        });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/SaveConfiguredHRM", data, false);
                    }
                    else {
                        //btnEditEmailClick = 1;
                        data = JSON.stringify({
                            FunctionCRMID: FunctionCRMID, SendMail: isSendMail
                        });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/UpdateConfiguredHRM", data, false);
                    }
                    FunctionCRMID = 0;

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('HRM saved successfully', 'success');

                    RefreshGrid("ConfigureHRM", Flag);

                    //getConfiguredHRM(CurDepartment);
                    getDepartmentResource(CurDepartment);
                    $("#cboResource").prop('disabled', false);
                    //$("#panelHRM").css('display', 'none');
                    //$("#panelHRMAdd").css('display', 'none');

                    // showHidePanel('panelHRM', 'panelHRMAdd', 'none');
                    if (btntype == 'SaveAndAdd') {
                        AddConfigureHRM();
                    }
                    //}
                    //if (btntype == 'Save') {
                    //}
                    //if (btntype == 'SaveAndAdd') {
                    //    clearGroupEmailDetails();
                    //}

                }
                else {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(' - Please select at least one Resource', 'error');

                }
            }
            function clearConfigureHRMDetails() {
                $("#txtGroupName").val("");
                $("#txtEmail").val("");
                $("#txtDescription").val("");
            }

            function ValidateConfigureHRM() {
                //debugger;
                var chkVal = 0;
                var strmsg = "";
                var errorMsg = "<ul>"

                var ResourceId = $("#cboResource").val();


                //if ($("#txtGroupName").val() == "") {
                //    strmsg = strmsg + '- Group Name should not be left blank.';
                //    errorMsg += "<li>" + strmsg + "</li></n>";
                //    chkVal = 1;
                //}

                if ($("#cboCustomers").val() != "") {

                    data = JSON.stringify({ DepartmentID: CurDepartment, CustomerID: CustomerId });
                    var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/CheckDuplicateCustomer", data, false);

                    if (strResult1.d == "1") {
                        strmsg = strmsg + 'Customer already exists.';
                        chkVal = 1;
                    }
                }

                errorMsg += "</ul>";
                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmsg, 'error');
                }

                return chkVal;
            }


            function AddRoleMapping() {
                
                showHidePanel('panelRole', 'panelRoleAdd', 'grid');
                getRoles(CurDepartment);
                $('#cboRoles').focus();
            }
          
            //Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
            function AddProjectMapping() {
                showHidePanel('panelProjectMapping', 'panelProjectMappingAdd', 'grid');
                getProjects(CurDepartment);
                FunctionProjectID = 0;
                $('#cboProjects').focus();
            }
           //End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
            function deleteMappedRole(functionRoleID) {               

               // alertify.confirm('', 'Are you sure, you want to delete the selected records?', function () {
                    data = JSON.stringify({ FunctionRoleID: functionRoleID });

                    strResult = AJAXCallWithResult(strPageName + "/DeleteMappedRole", data, false);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Role unmapped successfully', 'success');
                    RefreshGrid("RoleMapping", Flag);
                    //getMappedProjects(CurDepartment);
                }
            //        , function () {
            //            //alertify.error('Cancel');
            //            //return false;
            //        });
               
            //}
            function updateMappedRole(functionRoleID, mappedRoleID, mappedRoleName) {
                //debugger;
                showHidePanel('panelRole', 'panelRoleAdd', 'grid');
                FunctionRoleID = functionRoleID;
                var objCbo = document.getElementById("cboRoles");
                
              
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = mappedRoleName;
                    objOption.value = mappedRoleID;

                    $("#cboRoles").val(mappedRoleID);

                $("#cboRoles").focus();
            }
            function saveMappedRole(btntype)
            {
                if (ValidateMappedRole() == 0)
                {
                   
                    if (FunctionRoleID == 0) {
                        data = JSON.stringify({ DepartmentID: CurDepartment, RoleID: $("#cboRoles").val() });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/SaveMappedRole", data, false);

                    }
                    else {
                        data = JSON.stringify({ FunctionRoleID: FunctionRoleID, RoleID: $("#cboRoles").val() });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/UpdateMappedRole", data, false);

                    }
                    FunctionRoleID = 0;
                   
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Role mapped successfully', 'success');
                    RefreshGrid("RoleMapping", Flag);
                    //getMappedProjects(CurDepartment);
                   // showHidePanel('panelProject', 'panelProjectAdd', 'none');
                    if (btntype == 'SaveAndAdd') {
                        AddRoleMapping();
                    }
                }
            }
            function ValidateMappedRole() {
                //debugger;
                var chkVal = 0;
                var strmsg = "";
                var errorMsg = "<ul>"

                var RoleId = $("#cboRoles").val();
                              
                if (FunctionRoleID == 0) {
                    if ($("#cboRoles").val() != "") {

                    }
                    else {
                        chkVal = 1;
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(" - Please select at least one Role", 'error');
                    }
                }
               

                errorMsg += "</ul>";
                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmsg, 'error');
                }

                return chkVal;
            }
           
           
            function AddGroupEmail() {
                DepartmentGroupID = 0;
                showHidePanel('panelGroupEmail', 'panelGroupEmailAdd', 'grid');
                clearGroupEmailDetails();
                $('#txtGroupName').focus();
            }
            function deleteGroupEmail(departmentGroupID) {
               // alertify.confirm('', 'Are you sure, you want to delete the selected records?', function () {
                    data = JSON.stringify({ DepartmentGroupID: departmentGroupID });

                    strResult = AJAXCallWithResult(strPageName + "/DeleteGroupEmail", data, false);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Group deleted successfully', 'success');
                    RefreshGrid("GroupEmail", Flag);
                    //getGroupEmails(CurDepartment);

                }
            //     , function () {
            //         //alertify.error('Cancel');
            //         //return false;
            //     });

            //}
       //Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
        function updateProjectMapping(FunctionID, mapProjectID, mapProjectName, IsDefaultProject, departmentProjectID) {
             showHidePanel('panelPrjectMapping', 'panelPrjectMappingAdd', 'grid');
                    
              var objCbo = document.getElementById("cboProjects");
                
              
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = mapProjectName;
                    objOption.value = mapProjectID;

                    $("#cboProjects").val(mapProjectID);
          
                if (IsDefaultProject == "True") {
                    $('#chkIsDefaultProject').prop('checked', true);
                }
                else {
                    $('#chkIsDefaultProject').prop('checked', false);
                }
                //$("#chkIsDefaultProject").val(IsDefaultProject);
                
                FunctionProjectID = departmentProjectID;            
                 $("#cboProjects").focus();
        }
         function deleteProjectMapping(functionProjID) {
              
              //  alertify.confirm('', 'Are you sure, you want to delete the selected records?', function () {
                    //alertify.success('Ok');
            
                    data = JSON.stringify({ FunctionProjectID: functionProjID });

             strResult = AJAXCallWithResult(strPageName + "/DeleteProjectMapping", data, false);
            
             if (strResult != undefined) {
                 if (strResult.d == "Success") {
                     alertify.set('notifier', 'position', 'top-right');
                     alertify.notify('Project Mapping deleted successfully', 'success');
                     RefreshGrid("ProjectMapping", Flag);
                 }
             }
                    //getConfiguredHRM(CurDepartment);

                //}
                // , function () {
                //     //alertify.error('Cancel');
                //     //return false;
                // });                   
                  
               
            }
        //End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
            function updateGroupEmail(groupName, emailAlias, description, departmentGroupID) {
                //debugger;
                showHidePanel('panelGroupEmail', 'panelGroupEmailAdd', 'grid');
                $("#txtGroupName").val(groupName);
                $("#txtEmail").val(emailAlias);
                $("#txtDescription").val(description);
                
                DepartmentGroupID = departmentGroupID;            
                $("#txtGroupName").focus();
            }

        //Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
        function saveProjectMapping(btntype) {
           
            if (ValidateProjectMapping() == 0) {

               var isDefaultProject = 0;

                if ($('#chkIsDefaultProject').is(":checked")) {
                    isDefaultProject = 1;
                }
                  if (FunctionProjectID == 0) {
                       
                        //btnAddEmailClick = 1;
                      
                        data = JSON.stringify({
                            DepartmentID: CurDepartment, ProjectID: $("#cboProjects").val() , IsDefaultProject: isDefaultProject, FunctionProjectID: FunctionProjectID
                        });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/SaveProjectMapping", data,

    false);

                    }
                    else {
                      
                        //btnEditEmailClick = 1;
                      
                      data = JSON.stringify({
                          DepartmentID: CurDepartment, ProjectID: $("#cboProjects").val(), IsDefaultProject: isDefaultProject, FunctionProjectID: FunctionProjectID
                      });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/saveProjectMapping",

    data, false);

                    }
                    //DepartmentGroupID = 0;

                    alertify.set('notifier', 'position', 'top-right');
                    //FunctionProjectID = 0;
                    if (strResult1.d == "1") {
                        //alertify.notify('Email or Group Name already exists.', 'error');
                        //$('#txtGroupName').focus();
                    }
                    else {
                        alertify.notify('Project Mapping saved successfully', 'success');
                       // showHidePanel('panelGroupEmail', 'panelGroupEmailAdd', 'none');
                        //getGroupEmails(CurDepartment);
                        RefreshGrid("ProjectMapping", Flag);
                        if (btntype == 'Save') {
                            getProjects(CurDepartment);   
                            $($('#cboProjects').children()[1]).attr('selected', true);
                        }
                        if (btntype == 'SaveAndAdd') {
                            AddProjectMapping();
                            $('#chkIsDefaultProject').prop('checked', false);
                        }
                    }
            }
        }
        //End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
            function saveGroupEmail(btntype) {
                //debugger;
                if (ValidateGroupEmail() == 0) {
                   
                    if (DepartmentGroupID == 0) {
                       
                        btnAddEmailClick = 1;
                        data = JSON.stringify({
                            DepartmentID: CurDepartment, GroupName: $("#txtGroupName").val(),

                            Email: $("#txtEmail").val(), Description: $("#txtDescription").val()
                        });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/SaveGroupEmail", data,

    false);

                    }
                    else {
                      
                        btnEditEmailClick = 1;
                        data = JSON.stringify({
                            DepartmentGroupID: DepartmentGroupID, GroupName: $("#txtGroupName").val(),

                            Email: $("#txtEmail").val(), Description: $("#txtDescription").val()
                        });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/UpdateGroupEmail",

    data, false);

                    }
                    //DepartmentGroupID = 0;

                    alertify.set('notifier', 'position', 'top-right');
                  
                    if (strResult1.d == "1") {
                        alertify.notify('Email or Group Name already exists.', 'error');
                        $('#txtGroupName').focus();
                    }
                    else {
                        alertify.notify('Group saved successfully', 'success');
                       // showHidePanel('panelGroupEmail', 'panelGroupEmailAdd', 'none');
                        //getGroupEmails(CurDepartment);
                        RefreshGrid("GroupEmail", Flag);
                        if (btntype == 'Save') {
                        }
                        if (btntype == 'SaveAndAdd') {
                            AddGroupEmail();
                        }
                    }
                  
                   
                }
                
               
            }
            function clearGroupEmailDetails() {
                $("#txtGroupName").val("");
                $("#txtEmail").val("");
                $("#txtDescription").val("");
            }

            //Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
            function ValidateProjectMapping() {
                var chkVal = 0;
                var strmsg = "";
                var errorMsg = "<ul>";
              
                if (FunctionProjectID == 0) {
                    if ($("#cboProjects").val() != "") {

                    }
                    else {
                        chkVal = 1;
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(" - Please select at least one Project", 'error');
                    }
                }

                errorMsg += "</ul>";
                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmsg, 'error');
                }

                return chkVal;
            }
            //End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue

            function ValidateGroupEmail() {
                //debugger;
                var chkVal = 0;
                var strmsg = "";
                var errorMsg = "<ul>"

                var GroupName = $("#txtGroupName").val();
                var Email = $("#txtEmail").val();
                
                if ($("#txtGroupName").val() == "") {
                    strmsg =  '- Group Name should not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li></n>";
                    chkVal = 1;
                }


                if ($("#txtEmail").val() == "") {
                    strmsg = '- Email should not be left blank.';
                    errorMsg += "</n><li>" + strmsg + "</li>";
                    chkVal = 1;
                }
              
                //if (DepartmentGroupID == 0) {
                    if ($("#txtEmail").val() != "") {
                     
                        data = JSON.stringify({DepartmentID:GlobalDepartmentID,GroupName: "", Email: Email, Flag: "EmailAlias" });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/CheckDuplicateGroupEmail", data, false);

                        if (strResult1.d == "1") {
                            strmsg = '- Email already exists.';
                            errorMsg += "<li>" + strmsg + "</li>";
                            chkVal = 1;
                        }
                    }

                    if ($("#txtGroupName").val() != "") {
                       
                        data = JSON.stringify({DepartmentID:GlobalDepartmentID,GroupName: GroupName, Email: "", Flag: "GroupName" });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/CheckDuplicateGroupEmail", data, false);

                        if (strResult1.d == "1") {
                            strmsg = '- Group Name already exists.';
                            errorMsg += "<li>" + strmsg + "</li>";
                            chkVal = 1;
                        }
                    }
                //}
               
                if (chkVal == 0) {
                    if (ValidateEmail(Email) == false) {
                        strmsg = '- You have entered an invalid email address!';
                        errorMsg += "<li>" + strmsg + "</li>";
                        chkVal = 1;
                    }
                }
                errorMsg += "</ul>";
                if (strmsg != "")
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorMsg, 'error');
                }

                return chkVal;
            }
            function ValidateEmail(mail) {
                if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail)) {
                    return (true)
                }
                //alert("You have entered an invalid email address!")
                return (false)
            }
            function ValidateWorkHours() {
                //debugger;
                var chkVal = 0;
                if ($('#chkIsWorkingDay').is(":checked")) {



                    var strmsg = "";
                    var errorMsg = "<ul>"

                    var FromTime = $("#txtFromTime").val();
                    var ToTime = $("#txtToTime").val();

                    //if ($("#txtFromTime").val() == "") {
                    //    strmsg = strmsg + '- From Time cannot be blank.';
                    //    errorMsg += "<li>" + strmsg + "</li></n>";
                    //    chkVal = 1;
                    //}


                    //if ($("#txtToTime").val() == "") {
                    //    strmsg = strmsg + '- To Time cannot be blank.';
                    //    errorMsg += "</n><li>" + strmsg + "</li>";
                    //    chkVal = 1;
                    //}

                    var reg = /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/;
                    if (!reg.test($('#txtFromTime').val())) {
                        //alert("Invalid Time entered for From time.");
                        //$('#txtFromTime').val('');
                        //$('#txtFromTime').focus();
                        strmsg = strmsg + '- Invalid Time entered for From time.';
                        errorMsg += "</n><li>" + strmsg + "</li>";
                        chkVal = 1;
                    }
                    if (!reg.test($('#txtToTime').val())) {
                        //alert("Invalid Time entered for To Time.");
                        //$('#txtToTime').val('');
                        //$('#txtToTime').focus();
                        strmsg = strmsg + '- Invalid Time entered for To Time.';
                        errorMsg += "</n><li>" + strmsg + "</li>";
                        chkVal = 1;
                    }
                    //alert(chkVal);
                    if (chkVal == 0) {                       
                        if (Date.parse('01/01/2011 ' + $('#txtToTime').val()) < Date.parse('01/01/2011 ' + $('#txtFromTime').val())) {
                            strmsg = strmsg + '- To Time should be greater than From Time.';
                            errorMsg += "</n><li>" + strmsg + "</li>";
                            chkVal = 1;
                        }
                    }
                    //if (chkVal == 0) {
                    //    var hours = parseInt($("#txtToTime").val().split(':')[0], 10) - parseInt($("#txtFromTime").val().split(':')[0], 10);
                    //    if (hours < 0) {
                    //        hours = 24 + hours;
                    //    }
                    //    if (hours < 9) {
                    //        strmsg = strmsg + '- Work hours are less than required work hours .';
                    //        errorMsg += "</n><li>" + strmsg + "</li>";
                    //        chkVal = 1;
                    //    }
                    //}
                    errorMsg += "</ul>";
                    if (strmsg != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strmsg, 'error');
                    }
                }
                return chkVal;
            }
            
            function andExposeToCustomer() {
               
                if ($('#chkExposeToCustomer').is(":checked")) {
                    $("#btnAddCustomerMapping").css("visibility", "visible");
                    $(".clsPanelCustomerMapping").css("visibility", "visible");
                }
                else {
                    $("#btnAddCustomerMapping").css("visibility", "hidden");
                    $(".clsPanelCustomerMapping").css("visibility", "hidden");
                }
                //var url = "CRM_DepartmentMaster.aspx/ExposeToCustomer"


                //data = JSON.stringify({ DepartmentID: entity });
                //CustomAJAXCall(url, data, BindExposeToCustomer);
            }
            function BindExposeToCustomer(result) {
                //alert(result.d);
            }
           
            function AddCustomerMapping() {
                DeptCustMappingID = 0;
                showHidePanel('panelCustomerMapping', 'panelCustomerMappingAdd', 'grid');
                getCustomers(CurDepartment);
                $('#cboCustomers').focus();
            }
            function deleteCustomerMapping(deptCustMappingID) {
                //alertify.confirm('', 'Are you sure, you want to delete the selected records?', function () {
                    data = JSON.stringify({ DeptCustMappingID: deptCustMappingID });

                    strResult = AJAXCallWithResult(strPageName + "/DeleteCustomerMapping", data, false);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Customer deleted successfully', 'success');
                    RefreshGrid("CustomerMapping", Flag);
                    //getCustomerMapping(CurDepartment);
                }
            //     , function () {
            //         //alertify.error('Cancel');
            //         //return false;
            //     });
            //}

            function updateCustomerMapping(deptCustMappingID, customerID) {
                showHidePanel('panelCustomerMapping', 'panelCustomerMappingAdd', 'grid');
                DeptCustMappingID = deptCustMappingID;
                $("#cboCustomers").val(customerID);
                $("#cboCustomers").focus();
            }

            function saveCustomerMapping(btntype) {
                //debugger;
                if (ValidateCustomerMapping() == 0) {

                    if (DeptCustMappingID == 0) {

                        //btnAddEmailClick = 1;
                        data = JSON.stringify({
                            DepartmentID: CurDepartment, CustomerID: $("#cboCustomers").val()
                        });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/SaveCustomerMapping", data,

    false);

                    }
                    else {
                        //btnEditEmailClick = 1;
                        data = JSON.stringify({
                            DepartmentID: CurDepartment, CustomerID: $("#cboCustomers").val(), DeptCustMappingID: DeptCustMappingID
                        });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/UpdateCustomerMapping",

    data, false);

                    }
                    //DepartmentGroupID = 0;

                    alertify.set('notifier', 'position', 'top-right');

                    if (strResult1.d == "1") {
                        alertify.notify(' - Customer Mapping already exists.', 'error');
                        $('#cboCustomers').focus();
                    }
                    else {



                        alertify.notify('Customer saved successfully', 'success');
                      //  showHidePanel('panelCustomerMapping', 'panelCustomerMappingAdd', 'none');
                        RefreshGrid("CustomerMapping", Flag);
                        //getCustomerMapping(CurDepartment);
                        //if (btntype == 'Save') {
                        //}
                        if (btntype == 'SaveAndAdd') {
                            AddCustomerMapping();
                        }
                    }

                }
                

            }
            //function clearCustomerMappingDetails() {
            //    $("#txtGroupName").val("");
            //    $("#txtEmail").val("");
            //    $("#txtDescription").val("");
            //}

            function ValidateCustomerMapping() {
                //debugger;
                var chkVal = 0;
                var strmsg = "";
                var errorMsg = "<ul>"

                var CustomerId = $("#cboCustomers").val();
                

                //if ($("#txtGroupName").val() == "") {
                //    strmsg = strmsg + '- Group Name should not be left blank.';
                //    errorMsg += "<li>" + strmsg + "</li></n>";
                //    chkVal = 1;
                //}
                if (DeptCustMappingID == 0)
                {
                    if ($("#cboCustomers").val() != "")
                    {

                        data = JSON.stringify({ DepartmentID: CurDepartment, CustomerID: CustomerId });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/CheckDuplicateCustomer", data, false);

                        if (strResult1.d == "1") {
                            strmsg = ' - Customer already exists.';
                            chkVal = 1;
                        }
                    }
                    else
                    {

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(" - Please Select at least one Customer", 'error');
                        return 1;
                    }
                }
                
                errorMsg += "</ul>";
                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmsg, 'error');
                }

                return chkVal;
            }
            var curTempDepartment;
            function getRequestTypeDepartmentMapping() {
              
                if ($("#cboRequestMapRequestType").val() == 0) {

                    RefreshGrid("RequestTypeMapping", "changedept");
                    //getRequestTypeMapping($("#cboRequestMapDepartment").val());
                }
                else {
                    RefreshGrid("RequestTypeMapping", "changedeptandrequest");

                    //getRequestTypeDepartmentWiseMapping($("#cboRequestMapDepartment").val(), $("#cboRequestMapRequestType").val());
                }
            }
            //function getRequestTypeDepartmentWiseMapping(DeptID, ReqTypeID) {               

            //    var url = "CRM_DepartmentMaster.aspx/GetRequestTypeDepartmentMapping"
                               
            //    data = JSON.stringify({ DepartmentID: DeptID, RequestTypeID: ReqTypeID });
            //    CustomAJAXCall(url, data, BindTRRequestTypeMapping);
            //}
         
            function minimizePanel(panelname)
            {

                if (panelname == "panelHRM")
                {

                    $("#cboResource").val(""); 
                    if ($("#chkSendEmail").prop('checked', true))
                    {
                        $("#chkSendEmail").prop('checked', false);

                    }//("panelProject")
                    $("#cboResource").prop('disabled', false);
                }

                if (panelname == "panelRole") {

                    $("#cboRoles").val("");

                }


                if (panelname == "panelGroupEmail") {

                    $("#txtGroupName").val("");
                    $("#txtEmail").val("");
                    $("#txtGroupName").val("");
                    $("#txtDescription").val("");
                     

                    

                }//panelCustomerMapping

                if (panelname == "panelCustomerMapping") {

                    $("#cboCustomers").val("");



                }//panelCustomerMapping


                if (panelname == "panelRequestType") {

                    $("#txtRequestTypeDepartment").val("");
                    $("#txtRequestType").val("");
                    $("#txtSubRequestType").val("");
                    $("#txtRequestTypeGroupName").val("");
                 
                    if ($("#chkApprovalRequired").prop('checked', true)) {
                        $("#chkApprovalRequired").prop('checked', false);

                    }//("")


                }//pan


                if (panelname == "panelWorkingHours") {

                    $("#txtWeekDay").val("");
                    $("#txtFromTime").val("");
                    $("#txtToTime").val("");
                   // $("#txtRequestTypeGroupName").val("");

                    if ($("#chkIsWorkingDay").prop('checked', true)) {
                        $("#chkIsWorkingDay").prop('checked', false);

                    }//("")


                }//pan

                if (panelname == "ConfigureHRM")
                {
                    $("#txtDepartmentCode").val("");
                    $("#txtDepartment").val("");
                    //alert($("#chkExposeToCustomer").checked);
                    if ($("#chkExposeToCustomer").prop('checked', true)) {
                        $("#chkExposeToCustomer").prop('checked', false);

                    }
                    if ($("#chkExposeToProductExecution").prop('checked', true)) {
                        $("#chkExposeToProductExecution").prop('checked', false);

                    }
                    if ($("#chkAllowToDelete").prop('checked', true)) {
                        $("#chkAllowToDelete").prop('checked', false);

                    }
                    if ($("#chkIsSupportDepartment").prop('checked', true)) {
                        $("#chkIsSupportDepartment").prop('checked', false);

                    }
                    
                    $("#divDepartment").css("display", "");
                    $("#divDatatableSearchButton").css("display", "");
                    $("#DivHorizontal").css("display", "none");

                }
             
                if (panelname == "panelDepartment")
                {

                    $("#DivHorizontal").css("display", "none");
                    $("#divDepartment").css("display", "block");
                    $("#divDatatableSearchButton").css("display", "block");
                    $("#ConfigureHRM").css("display", "block");
                    $("#lblDepartmentHead").html("");
                    $("#cboDepartmentHead").css("display", "none");
                 
                    $("#txtDepartmentCode").val("");
                    $("#txtDepartment").val("");
                    if ($("#chkExposeToCustomer").prop('checked', true)) {
                        $("#chkExposeToCustomer").prop('checked', false);

                    }

                    if ($("#chkExposeToProductExecution").prop('checked', true)) {
                        $("#chkExposeToProductExecution").prop('checked', false);

                    }

                    if ($("#chkAllowToDelete").prop('checked', true)) {
                        $("#chkAllowToDelete").prop('checked', false);
                    }
                    if ($("#chkIsSupportDepartment").prop('checked', true)) {
                        $("#chkIsSupportDepartment").prop('checked', false);
                    }
                }
                $("#btnShowHistory").css("display", "none");

            }
            //function minimizePanel(panelname)
            //{
            //    if (panelname == 'panelHRM') {
            //        //$("#panelHRM").css('display', 'none');
            //        //$("#panelHRMAdd").css('display', 'none');
            //        showHidePanel('panelHRM', 'panelHRMAdd', 'none');
            //    }
            //    if (panelname == 'panelProject') {
                  
            //        showHidePanel('panelProject', 'panelProjectAdd', 'none');
            //    }
            //    if (panelname == 'panelGroupEmail') {

            //        showHidePanel('panelGroupEmail', 'panelGroupEmailAdd', 'none');
            //    }
            //    if (panelname == 'panelCustomerMapping') {

            //        showHidePanel('panelCustomerMapping', 'panelCustomerMappingAdd', 'none');
            //    }
            //    if (panelname == 'panelWorkingHours') {

            //        showHidePanel('panelWorkingHours', 'panelWorkingHoursAdd', 'none');
            //    }
            //    if (panelname == 'panelRequestType') {

            //        showHidePanel('panelRequestType', 'panelRequestTypeAdd', 'none');
            //    }
            //    if (panelname == 'panelDepartment') {

            //        showHidePanel('panelDepartment', 'panelDepartmentAdd', 'none');

            //        ShowHideMainTable('show');
            //        ShowHideHorizontalDiv();
            //        $("#cboDepartmentHead").css("visibility", "hidden");
            //        $("#lblDepartmentHead").css("visibility", "hidden");
            //    }
            //}
            function saveRequestApproval() {
                //debugger;
                var currentRequestTypeID = $("#cboRequestMapRequestType").val();
                var currentDepartmentID = $("#cboRequestMapDepartment").val();
                deleteExistingRequestType(GlobalDepartmentID, currentRequestTypeID);
                saveRequestTypeMapping(GlobalDepartmentID, currentRequestTypeID);
            }

            function updateRequestTypeMapping(functionRequestTypeID, functionID, department, requestType, subRequestType, groupName, groupEmail, reportingToApproval) {
                //debugger;
              
                showHidePanel('panelRequestType', 'panelRequestTypeAdd', 'grid');
                $("#txtRequestTypeDepartment").val(department);
            
                $("#txtRequestType").val(requestType);
                $("#txtSubRequestType").val(subRequestType);
                $("#txtRequestTypeGroupName").val(groupName);
                $("#txtRequestTypeGroupEmail").val(groupEmail);

                //alert(reportingToApproval);
                if (reportingToApproval == "True") {
                    $("#chkApprovalRequired").prop("checked", true);
                }
                else {
                    $("#chkApprovalRequired").prop("checked", false);
                }
                FunctionRequestTypeID = functionRequestTypeID;
                CurrentRequestDepartment = functionID;

                $("#chkApprovalRequired").focus();
            }
            function saveCurrentRequestTypeMapping() {
                if (ValidateRequestTypeMapping() == 0) {
                    var isApproval = 0;
                    if ($('#chkApprovalRequired').is(":checked")) {
                        isApproval = 1;
                    }
                    data = JSON.stringify({ DepartmentID: CurrentRequestDepartment, FunctionRequestTypeID: FunctionRequestTypeID, GroupName: $("#txtRequestTypeGroupName").val(), GroupEmail: $("#txtRequestTypeGroupEmail").val(), IsApprovalRequired: isApproval });
                    var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/SaveRequestTypeMapping", data, false);

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Request-type mapped successfully', 'success');
                   // showHidePanel('panelRequestType', 'panelRequestTypeAdd', 'none');
                    RefreshGrid("RequestTypeMapping", Flag);
                    //getRequestTypeMapping(CurDepartment);
                }
            }
            function ValidateRequestTypeMapping() {
                var chkVal = 0;
                var strmsg = "";
                var errorMsg = "<ul>";

                var GroupEmail = $("#txtRequestTypeGroupEmail").val();

               
                if (GroupEmail != "") {
                    if (chkVal == 0) {
                        if (ValidateEmail(GroupEmail) == false) {
                            strmsg = strmsg + '- Email Id Invalid';
                            chkVal = 1;
                        }
                    }
                    errorMsg += "</ul>";
                    if (strmsg != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strmsg, 'error');
                    }
                }
                return chkVal;
               
            }
            function saveRequestTypeMapping(DeptID, RequestID) {
                //debugger;
                try
                {                 
                    var strCheckedApprove;
                    strCheckedApprove = $('input[id=chkApproval]:checked').map(function () {
                        return this.value;
                    }).get().join(',');
                    var strUnCheckedApprove;
                    strUnCheckedApprove = $('input[id=chkApproval]:not(:checked)').map(function () {
                        return this.value;
                    }).get().join(',');
                    var strRequestSubRequestApprove;
                    strRequestSubRequestApprove = $('input[id=chkSelect]:checked').map(function () {
                        return this.value;
                    }).get().join(',');
                    

                    //Added by Usha Pandit on 20.05.2019 for select Request Types from more than one page in table and save 
                    var table = $('#divForRequestTypeMapping table').DataTable();
                    var rows = table.rows({ 'search': 'applied' }).nodes();        
                
                    strCheckedApprove = $('input[id=chkApproval]:checked', rows).map(function () {
                        return this.value;
                    }).get().join(',');

                    strUnCheckedApprove = $('input[id=chkApproval]:not(:checked)', rows).map(function () {
                        return this.value;
                    }).get().join(',');

                    strRequestSubRequestApprove = $('input[id=chkSelect]:checked', rows).map(function () {
                        return this.value;
                    }).get().join(',');

                    //End of Added by Usha Pandit on 20.05.2019 for select Request Types from more than one page in table and save 

                    //strRequestSubRequestApprove = arrSelectedCheckSubType.toString();
                    //strCheckedApprove = arrSelectedApprove.toString();
                 
                    //if (arrUnSelectedApprove != "")
                       // strUnCheckedApprove = arrUnSelectedApprove.toString();
                    
                    //if (strCheckedApprove != "" && strUnCheckedApprove != "") {
                    var arrRequestSubRequestApprove = strRequestSubRequestApprove.split(",");
                    var arrayLength = arrRequestSubRequestApprove.length;                                       
                
                        for (var i = 0; i < arrayLength; i++) {
                            //alert(arrRequestSubRequestApprove[i]);
                            arrRequestSubRequestApprove[i] = arrRequestSubRequestApprove[i].replace(/\\\//g, "/");
                            var strRequestSubRequestApproveSplit = arrRequestSubRequestApprove[i].split("|");
                            var arrayLengthSplit = strRequestSubRequestApproveSplit.length;
                            for (var j = 0; j < arrayLengthSplit; j++) {
                                strRequestSubRequestApproveSplit[j] = strRequestSubRequestApproveSplit[j].replace(/['"]+/g, '')
                                //alert(strRequestSubRequestApproveSplit[j]);
                                if (j == 1) {
                                    if (strCheckedApprove != "") {
                                        //alert(strCheckedApprove);
                                        var arrCheckedApprove = strCheckedApprove.split(",");
                                       
                                        var arrayLenCheckedApprove = arrCheckedApprove.length;
                                        for (var k = 0; k < arrayLenCheckedApprove; k++) {
                                            if (arrCheckedApprove[k] == strRequestSubRequestApproveSplit[1]) {
                                                strRequestSubRequestApproveSplit[3] = strRequestSubRequestApproveSplit[3].replace(/['"]+/g, '')
                                                strRequestSubRequestApproveSplit[4] = strRequestSubRequestApproveSplit[4].replace(/['"]+/g, '')
                                                insertRequestApproval(DeptID, strRequestSubRequestApproveSplit[0], strRequestSubRequestApproveSplit[1], 1, strRequestSubRequestApproveSplit[3], strRequestSubRequestApproveSplit[4]);
                                            }
                                        }
                                    }
                                    if (strUnCheckedApprove != "") {
                                        //alert(strUnCheckedApprove);
                                        var arrUnCheckedApprove = strUnCheckedApprove.split(",");
                                       
                                        var arrayLenUnCheckedApprove = arrUnCheckedApprove.length;
                                        for (var l = 0; l < arrayLenUnCheckedApprove; l++) {
                                            if (arrUnCheckedApprove[l] == strRequestSubRequestApproveSplit[1]) {
                                               

                                                strRequestSubRequestApproveSplit[3] = strRequestSubRequestApproveSplit[3].replace(/['"]+/g, '')
                                                strRequestSubRequestApproveSplit[4] = strRequestSubRequestApproveSplit[4].replace(/['"]+/g, '')
                                                insertRequestApproval(DeptID, strRequestSubRequestApproveSplit[0], strRequestSubRequestApproveSplit[1], 0, strRequestSubRequestApproveSplit[3], strRequestSubRequestApproveSplit[4]);
                                            }
                                        }
                                    }
                                }
                            }

                        }
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Request Type saved successfully', 'success');
                        plotTabs(GlobalDepartmentID)
                        $(".tablinks4").removeClass("active");
                        $("#btnRequestTypeMapping").addClass("active");
                        //RefreshGrid("RequestTypeMapping", Flag);
                        $("#cboRequestMapRequestType").change();
                    //}
                    //else {
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify('Please select at atleast one record', 'error');
                    //}
                        
                }
                catch (ex) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(ex.message, 'error');
                }
            }
            function insertRequestApproval(DeptID, RequestID, SubRequestID, isApprovalRequired, groupName, groupEmail) {
                //debugger;
                data = JSON.stringify({ DepartmentID: DeptID, RequestTypeID: RequestID, SubRequestTypeID: SubRequestID, IsApprovalRequired: isApprovalRequired, GroupName: groupName, GroupEmail: groupEmail });
                    var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/SaveRequestApproval", data, false);

                

                //alertify.set('notifier', 'position', 'top-right');
                //alertify.notify('Request Approval Mapping saved successfully', 'success');               
            }
            function deleteExistingRequestType(DeptID, delRequestID) {
                var curRequestID = "0";
                //if (delRequestID == "") {
                //    curRequestID = "0";
                //}
                //else {
                    curRequestID = delRequestID;
                //}
                data = JSON.stringify({ DepartmentID: DeptID, RequestTypeID: curRequestID });

                    strResult = AJAXCallWithResult(strPageName + "/DeleteRequestTypeMapping", data, false);
                   
                //RefreshGrid(TabName, Flag);
                    //RefreshGrid("RequestTypeMapping", Flag);
                    //getRequestTypeMapping(CurDepartment);
              

            }
          
            function updateWorkingHours(isWorking, fromTime, toTime, uniqueID, WeekDay) {
                //debugger;
                showHidePanel('panelWorkingHours', 'panelWorkingHoursAdd', 'grid');
                UniqueID = uniqueID;
                $("#txtFromTime").val(fromTime);
                $("#txtToTime").val(toTime);
                //alert(isWorking);
                if (isWorking == "False") {
                    $("#txtFromTime").prop('disabled', true);
                    $("#txtToTime").prop('disabled', true);
                    $("#chkIsWorkingDay").prop("checked", false);
                }
                else {
                    $("#txtFromTime").prop('disabled', false);
                    $("#txtToTime").prop('disabled', false);
                    $("#chkIsWorkingDay").prop("checked", true);
                }
                $("#chkIsWorkingDay").focus();
                $("#txtWeekDay").val(WeekDay);
                
              
            }
            function addWorkingHours() {
                showHidePanel('panelWorkingHours', 'panelWorkingHoursAdd', 'grid');
            }
            function saveWorkingHours(btntype) {
                //debugger;
                if (ValidateWorkHours() == 0) {
                    var isworking = 0;
                    if ($('#chkIsWorkingDay').is(":checked")) {
                        isworking = 1
                    }
                    data = JSON.stringify({
                        DepartmentID: CurDepartment, IsWorking: isworking,

                        FromTime: $("#txtFromTime").val(), ToTime: $("#txtToTime").val(), UniqueID: UniqueID
                    });
                    var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/SaveWorkingHours", data,

false);

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Working Hours updated successfully', 'success');
                   // showHidePanel('panelWorkingHours', 'panelWorkingHoursAdd', 'none');
                    //getWorkingHours(CurDepartment);
                    RefreshGrid("WorkingHours", Flag);
                    if (btntype == 'Save') {
                    }
                    //if (btntype == 'SaveAndAdd') {
                    //    addWorkingHours();
                    //}
                }
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
                        //Stop();
                    },
                    error: function (xhr, status, error) {
                        // Stop();
                        //  StopAjaxLoader("body");
                        console.log(xhr.responseText);
                        window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                    }
                });

            }
            function Add_Department() {
                ShowHideMainTable('hide');
                
                btnAddClick = 1;
                btnEditClick = 0;
                CurDepartment = "";
                showHidePanel('panelDepartment', 'panelDepartmentAdd', 'grid');
                clearDepartmentDetails();

                $("#cboDepartmentHead").css("visibility", "hidden");
                $("#lblDepartmentHead").css("visibility", "hidden");

                ShowHideHorizontalDiv();

                if ($("#accordion6").hasClass("collapsed")) {
                    $("#accordion6").removeClass("collapsed");
                    $("#collapseOne6").css('height', 'auto');
                    $("#collapseOne6").addClass('in');
                    //$("#collapseOneDept").css("display", "block");
                }
                $("#collapseOneDept").css("display", "block");
                $("#faplus").css("display", "none");
                $("#faminus").css("display", "block");
                $("#btnShowHistory").css("display", "none");
            }
            function getEntityDetails(entity, btnid) {
                //debugger;
                GlobalDepartmentID = entity;
                showHidePanel('panelDepartment', 'panelDepartmentAdd', 'grid');
                ShowHideMainTable('hide');
                btnAddClick = 0;
                btnEditClick = 1;
                if ($("#DivHorizontal").hasClass("clsHideHorizontalDiv")) {
                    $("#DivHorizontal").removeClass("clsHideHorizontalDiv");
                    $("#DivHorizontal").addClass("clsShowHorizontalDiv");
                }
                //if (btnid == 'btnSave') {
                $("#cboDepartmentHead").css("visibility", "visible");
                $("#lblDepartmentHead").css("visibility", "visible");
                //}
                //alert(entity);
                CurDepartment = entity
                getDepartmentHead(entity)

                data = JSON.stringify({ DepartmentID: entity });
                var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/GetDepartmentDetails", data, false);


                var arrData = strResult1.d.split(",");
               
                $("#txtDepartmentCode").val(arrData[2]);
                $("#txtDepartment").val(arrData[1]);

                $("#cboDepartmentHead").val(arrData[3]);
                //$("#cboDepartmentHead select").val(arrData[3]);
                //var element = document.getElementById('cboDepartmentHead');
                //element.value = arrData[3];
                if (arrData[5] == "True")
                    $("#chkExposeToCustomer").prop("checked", true);
                else
                    $("#chkExposeToCustomer").prop("checked", false);
                if (arrData[6] == "True")
                    $("#chkExposeToProductExecution").prop("checked", true);
                else
                    $("#chkExposeToProductExecution").prop("checked", false);
                if (arrData[7] == "True")
                    $("#chkAllowToDelete").prop("checked", true);
                else
                    $("#chkAllowToDelete").prop("checked", false);
               
                if (arrData[8] == "True")
                    $("#chkIsSupportDepartment").prop("checked", true);
                else
                    $("#chkIsSupportDepartment").prop("checked", false);
                
                //$("#tblConfigureHRM").find("tr:gt(0)").remove();

                //getConfiguredHRM(CurDepartment);


                //getDepartmentResource(CurDepartment);
              
                //showHidePanel('panelHRM', 'panelHRMAdd', 'none');
                plotTabs(GlobalDepartmentID)

                RefreshSubTags();
                $("#gridtab").css("display", "block");
                AddConfigureHRM();
                $("#DivHorizontal").css("display","");
                $("#txtDepartmentCode").focus();

                if ($("#accordion6").hasClass("collapsed")) {
                    $("#accordion6").removeClass("collapsed");
                    $("#collapseOne6").css('height', 'auto');
                    $("#collapseOne6").addClass('in');
                    //$("#collapseOneDept").css("display", "block");
                }
                $("#collapseOneDept").css("display", "block");
                $("#faplus").css("display", "none");
                $("#faminus").css("display", "block");
                $("#btnShowHistory").css("display", "inline-block");
                
            }
            function plotTabs(DepartmentID) {
                data = JSON.stringify({ DepartmentID: DepartmentID });
                var strRequestResult = AJAXCallWithResult("CRM_DepartmentMaster.aspx/CheckRequestType", data, false);
                if (strRequestResult.d != "") {
                    document.getElementById("divDepartmentTabs").innerHTML = strRequestResult.d;
                }
            }
            function SaveDepartmentDetails(btntype) {
                if (ValidateRequestDepartment() == 0) {                   
                    if (CurDepartment == "")
                        CurDepartment = 0
                    var isExposeToCustomer = 0;
                    var isExposeToProductExecution = 0;
                    var isAllowToDelete = 0;
                    var isSupportDepartment = 0;
                    if ($('#chkExposeToCustomer').is(":checked")) {
                        isExposeToCustomer = 1
                    }
                    if ($('#chkExposeToProductExecution').is(":checked")) {
                        isExposeToProductExecution = 1
                    }
                    if ($('#chkAllowToDelete').is(":checked")) {
                        isAllowToDelete = 1
                    }

                    if ($("#cboDepartmentHead").val() == "Task Type") {
                        $("#cboDepartmentHead").val("");
                    }
                    
                    if ($('#chkIsSupportDepartment').is(":checked")) {
                      
                        isSupportDepartment = 1
                    }
                    var intcboDepartmentHead = "Null";
                    if ($("#cboDepartmentHead").val() != 'Select Resource') {
                        intcboDepartmentHead = $("#cboDepartmentHead").val();
                    }
                    data = JSON.stringify({ DepartmentID: CurDepartment, Department: $("#txtDepartment").val(), DepartmentHeadID: intcboDepartmentHead, DepartmentCode: $("#txtDepartmentCode").val(), ExposeToCustomer: isExposeToCustomer, ExposeToProductExecution: isExposeToProductExecution, IsShowToCustomer: isAllowToDelete, IsSpportDepartment: isSupportDepartment });
                    var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/SaveDepartment", data, false);
                    //CurDepartment = "";
                    var arrstrResult1 = strResult1.d.split("$$");
                    if (strResult1.d != '') {
                        if ($("#DivHorizontal").hasClass("clsHideHorizontalDiv")) {
                            $("#DivHorizontal").removeClass("clsHideHorizontalDiv");
                            $("#DivHorizontal").addClass("clsShowHorizontalDiv");
                        }                        
                    }
                   
                    $("#cboDepartmentHead").css("visibility", "visible");
                    $("#lblDepartmentHead").css("visibility", "visible");


                    alertify.set('notifier', 'position', 'top-right');
                    
                    if (arrstrResult1[0] == "1") {
                        alertify.notify(' - Department or Department Code already exists.', 'error');
                        $('#txtGroupName').focus();
                    }
                    else {
                        alertify.notify('Department saved successfully', 'success');
                        //debugger;
                        CurDepartment = arrstrResult1[1];
                        GlobalDepartmentID = arrstrResult1[1];

                        RefreshGrid('Department', Flag);
                        if (btntype == 'Save')
                        {
                            ShowHideMainTable('hide');
                            showHidePanel('panelDepartment', 'panelDepartmentAdd', 'grid');
                            if ($("#DivHorizontal").hasClass("clsHideHorizontalDiv"))
                            {
                                $("#DivHorizontal").removeClass("clsHideHorizontalDiv");
                                $("#DivHorizontal").addClass("clsShowHorizontalDiv");
                            }
                            RefreshSubTags();
                            AddConfigureHRM();
                            var url = "CRM_DepartmentMaster.aspx/Default_GetRequestMapDepartment"


                            data = JSON.stringify({ DepartmentID: CurDepartment });
                            CustomAJAXCall(url, data, BindDropDownRequestMapDepartment);

                            //alert($('#cboRequestMapDepartment').find('option[text="test7"]').val());
                            //var currentDepartment = $('#cboRequestMapDepartment').find('option[text=' + $("#txtDepartment").val() + ']').val();
                            //var $dd = $('#cboRequestMapDepartment');
                            //var $options = $('option', $dd);
                            //$options.each(function () {
                            //    if ($(this).text() == $("#txtDepartment").val())
                            //        $(this).select(); // This is where my problem is
                            //});
                            //debugger;
                            $("#cboRequestMapDepartment option").each(function () {
                                //alert($(this).text());
                                //alert($(this).val());
                                //alert($("#txtDepartment").val());
                                if ($(this).text() == $("#txtDepartment").val()) {
                                    CurDepartment = $(this).val()
                                    $("#cboRequestMapDepartment").val($(this).val());
                                }
                            });
                            
                            //alert(currentDepartment);
                            //$('#cboRequestMapDepartment').val(currentDepartment);
                            $("#DivHorizontal").css("display", "");
                            plotTabs(GlobalDepartmentID)
                        }
                        if (btntype == 'SaveAndAdd')
                        {
                            //showHidePanel('panelDepartment', 'panelDepartmentAdd', 'none');
                            Add_Department();
                            if ($("#DivHorizontal").hasClass("clsHideHorizontalDiv")) {
                                $("#DivHorizontal").removeClass("clsHideHorizontalDiv");
                                $("#DivHorizontal").addClass("clsShowHorizontalDiv");
                            }
                            $("#DivHorizontal").css("display", "none");
                            RefreshSubTags();
                            AddConfigureHRM();
                        }
                    }
                }
            }
           
            function clearDepartmentDetails() {
                $("#chkExposeToCustomer").prop("checked", false);
                $("#chkExposeToProductExecution").prop("checked", false);
                $("#chkAllowToDelete").prop("checked", false);
                $("#chkIsSupportDepartment").prop("checked", false);
                
                $("#txtDepartment").val("");
                $("#txtDepartmentCode").val("");
                $("#cboDepartmentHead").val("");
            }
           
            function DeleteDepartment(deptid) {
              

                data = JSON.stringify({ DepartmentID: deptid });
                var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/DeleteDepartmentDetails", data, false);

                RefreshGrid(TabName, Flag);

                //if (strmsg != "") {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(strmsg, 'error');
                //}

                //return chkVal;
            }

            function DeleteSelectedepartment() {
                //debugger;

                var strRequestDepartmentID;
                //strRequestDepartmentID = $('input[id=chkDepartmentSelect]:checked').map(function () {
                //    return this.value;
                //}).get().join(',');

                var table = $('#divDepartment table').DataTable();
                var rows = table.rows({ 'search': 'applied' }).nodes();

                if (document.getElementById('chkDepartmentSelectAll').checked == true) {
                    strRequestDepartmentID = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                        return this.value;
                    }).get().join(',');
                }
                else {
                    strRequestDepartmentID = $('input[id=chkDepartmentSelect]:checked').map(function () {
                        return this.value;
                    }).get().join(',');
                }

                if (strRequestDepartmentID.length <= 0)
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(' - Please select at least one department for deletion', 'error');
                    return;
                }

                   //alertify.confirm('', 'Are you sure, you want to delete the selected records?', function () {
                    
                    data = JSON.stringify({ RequestDepartmentID: strRequestDepartmentID });

                    strResult = AJAXCallWithResult(strPageName + "/DeleteRequestDepartment", data, false);
                    //alert(strResult.d);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strResult.d, 'success');
                    RefreshGrid('Department', Flag);
                    ShowHideHorizontalDiv();
                    //showHidePanel('panelDepartment', 'panelDepartmentAdd', 'none');
               //// }
               //  , function () {
               //      //alertify.error('Cancel');
               //      //return false;
               //  });
            }
            function ValidateRequestDepartment() {
                //debugger;
                var chkVal = 0;
                var strmsg = "";
                var errorMsg = "<ul>"

                var Department = $("#txtDepartment").val();
                var DepartmentCode = $("#txtDepartmentCode").val();

               

              


                if ($("#txtDepartmentCode").val() == "")
                {
                    strmsg = '- Short Name should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    chkVal = 1;
                }
                

                if ($("#txtDepartment").val() == "") {
                    strmsg = '- Department should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></n>";
                    chkVal = 1;
                }
                if (btnAddClick == 1)
                {
                    if ($("#txtDepartment").val() != "")
                    {
                        var CurDepartment = $("#txtDepartment").val();
                        data = JSON.stringify({ DepartmentCode: "", Department: CurDepartment, Flag: "Department" });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/CheckDuplicateDepartment", data, false);

                        if (strResult1.d == "1")
                        {
                            strmsg = '- Department already exists';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            chkVal = 1;
                        }
                    }

                    if ($("#txtDepartmentCode").val() != "")
                    {
                        var CurDepartmentCode = $("#txtDepartmentCode").val();
                        data = JSON.stringify({ DepartmentCode: CurDepartmentCode, Department: "", Flag: "DepartmentCode" });
                        var strResult1 = AJAXCallWithResult("CRM_DepartmentMaster.aspx/CheckDuplicateDepartment", data, false);

                        if (strResult1.d == "1")
                        {
                            strmsg = '- Short Name already exists';
                            errorMsg += "<li>" + strmsg + "</li>";
                            chkVal = 1;
                        }
                    }
                }
                errorMsg += "</ul>";
                if (strmsg != "")
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorMsg, 'error',50);
                }
               
                return chkVal;
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
                //debugger;
                $('#' + divID + ' > table').removeClass("clsGridTable");
                $('#' + divID + ' table').addClass("table table-bordered table-stripped");
                var table = $('#' + divID + ' table').DataTable({
                    responsive: true,
                    pageLength: 10,
                    scrollY: height - 80 + 'px',
                    //scrollX: true,
                    pagingType: "simple",
                    //language: {
                    //    paginate: {
                    //        first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
                    //        next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
                    //        previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
                    //        last: '<i class="fa fa-angle-right" title="Last"></i>'
                    //    }
                    //},
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
        //var arrCheckedApprove = "";
        //var arrUnCheckedApprove = "";
        //var arrRequestSubRequestApprove = "";
        //function getUnique(array) {
        //    var uniqueArray = [];

        //    // Loop through array values
        //    for (i = 0; i < array.length; i++) {
        //        if (uniqueArray.indexOf(array[i]) === -1) {
        //            uniqueArray.push(array[i]);
        //        }
        //    }
        //    return uniqueArray;
        //}
            function datatables(divID, txtBoxID) {
               
                //debugger;
                var ColumnLength = 0;
                if (divID == 'divForDepartment') {
                    ColumnLength = 4;
                    divID = "divDepartment"
                }
                if (divID == 'divForConfigureHRM') {
                    ColumnLength = 2;
                    divID = "divConfigureHRM"
                }
                if (divID == 'divForRoleMapping') {
                    ColumnLength = 2;
                    divID = "divRoleMapping"
                }

                if (divID == 'ShowHistoryGrid'){
                    ColumnLength = 4;
                    divID = "ShowHistoryGrid"
                }

                $('#' + divID + ' table').removeClass("clsGridTable");
                $('#' + divID + ' table').addClass("table table-bordered table-stripped");
                var table = $('#' + divID + ' table').DataTable({
                    responsive: true,
                    pageLength: 3,
                    //scrollY: '130px',

                    pagingType: "simple_numbers",
                    "bstateSave": true,
                    //   scrollX: true,
                    //language: {
                    //    paginate: {
                    //        first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
                    //        next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
                    //        previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
                    //        last: '<i class="fa fa-angle-right" title="Last"></i>'
                    //    }
                    //},
                    //"columnDefs": [{
                    //    targets: ColumnLength
                    // }]
                    // "bstateSave": true,
                    //scrollX: true
                });

                //alert(2);
                // debugger;

                //$("#" + divID + " .dataTables_length").parent().css("display", "none");

                //$("#" + divID + " .dataTables_scrollHeadInner table th:first-child").css("width", "25%");
                //$("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(2)").css("width", "25%");
                //$("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(3)").css("width", "50%");

                //$("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(2)").css("text-align", "LEFT");
                //$("#" + divID + " .dataTables_scrollHeadInner table").css("width", "100%");
                //$("#" + divID + " .dataTables_scrollBody table").css("width", "100%");
                //$("#" + divID + " .dataTables_scrollBody table td:first-child").css("width", "25%");
                //$("#" + divID + " .dataTables_scrollBody table td:nth-child(2)").css("width", "25%");
                //$("#" + divID + " .dataTables_scrollBody table td:nth-child(3)").css("width", "50%");
                // $("#" + divID + " .dataTables_scrollBody table").css("table-layout", "fixed");
                //  $("#" + divID + " .dataTables_scrollHeadInner table").css("table-layout", "fixed");

                if (txtBoxID != "") {
                    $('#' + txtBoxID).on('keyup change', function () {
                        table.search($(this).val()).draw();
                    })
                }
            }

            function datatablessubtag(divID, txtBoxID) {
                $('#' + divID + ' #tblRequstTypeMapping_wrapper table').removeClass("clsGridTable");
                $('#' + divID + ' #tblRequstTypeMapping_wrapper table').addClass("table table-bordered table-stripped ");
                var table = $('#' + divID + ' #tblRequstTypeMapping_wrapper table').DataTable({

                    responsive: true, "pageLength": "10",
                    scrollY: '130px',
                    pagingType: "simple",
                    scrollX: true,
                    language: {
                        paginate: {
                            first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
                            next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
                            previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
                            last: '<i class="fa fa-angle-right" title="Last"></i>'
                        }
                    },
                });
                // debugger;
                if (txtBoxID != "") {
                    $('#' + txtBoxID).on('keyup change', function () {
                        table.search($(this).val()).draw();
                    })
                }
            }


            function setWidthDatatable(divID) {

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


            function Page_OnClick(PageNumber) {
                var strMode = $("#hdnMode").val();
                RefreshGrid('Department', Flag);
            }
            function PreviousePage(PageNumber) {

                if (PageNumber < 1) {
                    //alert("You are on the First page");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You are on the First page!', 'success');
                }
                else {
                    $("#hdnCurrentPage").val(PageNumber);
                    Page_OnClick(PageNumber);
                }
            }
            function NextPage(PageNumber) {
                //  debugger;
                var TotalNoOfPages = $("#hidNoOfPages").val();

                if (PageNumber > TotalNoOfPages) {
                    //alert("You are on the last page");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You are on the last page!', 'success');
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
                    alertify.notify('You are on the First page!', 'success');
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
                    alertify.notify('You are on the last page!', 'success');
                }
                else {
                    $("#hdnCurrentPage").val(PageNumber);
                    Page_OnClick(PageNumber);
                }
            }
            //function datatables(divID, txtBoxID, height) {
            //    $('#' + divID + ' > table').removeClass("clsGridTable");
            //    $('#' + divID + ' table').addClass("table table-bordered ");
            //    var table = $('#' + divID + ' > table').DataTable({

            //        //responsive: true, "pageLength": "10",
            //        scrollY: height + 130 + 'px',
            //        //pagingType: "simple_numbers",
            //        pagingType: "full_numbers",
            //        language: {
            //            paginate: {
            //                first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
            //                next: '<i class="fa fa-angle-right" title="Next"></i>',
            //                previous: '<i class="fa fa-angle-left" title="Previous"></i>',
            //                last: '<i class="fa fa-angle-right" title="Last"></i>'
            //            }
            //        },
            //    });
            //    // debugger;
            //    if (txtBoxID != "") {
            //        $('#' + txtBoxID).on('keyup change', function () {
            //            table.search($(this).val()).draw();
            //        })
            //    }
            //}

            function ValidateRequestType() {
                var chkVal = 0;
                var RequestType = $("#requesttype").val();
                var RequestTypeCode = $("#requesttypecode").val();
                var strmsg = "";
                if ($("#requesttype").val() == "") {
                    //  alertify.set('notifier', 'position', 'top-right');
                    // alertify.notify('Request Type should not be left blank', 'error');
                    strmsg = strmsg + '- Request Type should not be left blank';
                    chkVal = 1;
                }


                if (RequestType != "") {
                    data = JSON.stringify({ RequestType: RequestType });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicateRequestType", data, false);

                    if (strResult1.d == "1") {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify('Request Type is already exists', 'error');
                        strmsg = strmsg + '- Request Type already exists';
                        chkVal = 1;

                    }
                }
                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmsg, 'error');
                }

                return chkVal;
            }
            function SaveRequestType_Onclick() {
                if (ValidateRequestType() == 0) {
                    var RequestType = $("#requesttype").val();
                    var RequestTypeCode = $("#requesttypecode").val();

                    // if (strResult1 == 0) {

                    // var SubRequestType = $("#Subrequesttype").val();
                    //  data = JSON.stringify({ RequestType: RequestType, SubRequestType: SubRequestType, RequestTypeCode: RequestTypeCode,RequestTypeID:"0"});
                    data = JSON.stringify({ RequestType: RequestType, RequestTypeCode: RequestTypeCode, RequestTypeID: EditRequestTypeID });
                    //  alert(data);
                    strResult = AJAXCallWithResult("CRM_RequestSetting.aspx/SaveRequestType", data, false);
                    if (strResult.d != "") {

                        $("#divRequestTypes").css("display", "block");
                        $(".type-top-bar").css("display", "block");
                        $("#RequestPaging").css("display", "block");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Type saved successfully', 'success');
                        $("#requesttype").val("");
                        $("#requesttypecode").val("");
                        RefreshGrid('Department', Flag);
                    }
                    // }
                }
            }
            function ValidateRequestPriority() {
                var chkVal = 0;
                var strmsg = "";
                var errorMsg = "<ul>"

                var RequestPriorityCode = $("#txtRequestPriorityCode").val();
                var RequestPriorityOrderNo = $("#txtRequestPriorityOrderNo").val();
                var RequestPriority = $("#txtRequestPriority").val();
                var strmsg = "";
                if ($("#txtRequestPriorityCode").val() == "") {
                    strmsg = strmsg + 'Request Priority Code should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    chkVal = 1;
                }


                if (disallowSpecialCharacters(document.getElementById('txtRequestPriorityCode')) == true) {
                    strmsg = '- A Request Priority Code cannot contain any of these /\\:*?<>|,"+- characters.';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }

                if ($("#txtRequestPriorityOrderNo").val() == "") {
                    strmsg = strmsg + 'Request Priority Order No. should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    chkVal = 1;
                }

                if ($("#txtRequestPriority").val() == "") {
                    strmsg = strmsg + 'Request Priority should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    chkVal = 1;
                }

                errorMsg += "</ul>";
                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmsg, 'error');
                    chkVal = 1;
                }


                if ($("#txtRequestPriorityCode").val() != "") {
                    var PriorityCode = $("#txtRequestPriorityCode").val();
                    data = JSON.stringify({ PriorityCode: PriorityCode, Priority: "", PriorityOrderNo: "", StrFlag: "PriorityCode" });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicatePriorityControls", data, false);

                    if (strResult1.d == "1") {
                        strmsg = strmsg + 'Request Priority Code already exists';
                        chkVal = 1;
                    }
                }

                if ($("#txtRequestPriority").val() != "") {
                    var Priority = $("#txtRequestPriority").val();
                    data = JSON.stringify({ PriorityCode: "", Priority: Priority, PriorityOrderNo: "", StrFlag: "Priority" });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicatePriorityControls", data, false);

                    if (strResult1.d == "1") {
                        strmsg = strmsg + 'Request Priority already exists';
                        chkVal = 1;
                    }
                }
                if ($("#txtRequestPriorityOrderNo").val() != "") {
                    var PriorityOrderNo = $("#txtRequestPriorityOrderNo").val();
                    data = JSON.stringify({ PriorityCode: "", Priority: "", PriorityOrderNo: PriorityOrderNo, StrFlag: "PriorityOrderNo" });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicatePriorityControls", data, false);

                    if (strResult1.d == "1") {
                        strmsg = strmsg + 'Order Number already exists';
                        chkVal = 1;
                    }
                }
                return chkVal;
            }
            function SaveRequestPriority() {
                if (ValidateRequestPriority() == 0) {
                    var RequestPriorityCode = $("#txtRequestPriorityCode").val();
                    var RequestPriorityOrderNo = $("#txtRequestPriorityOrderNo").val();
                    var RequestPriority = $("#txtRequestPriority").val();
                    // if (strResult1 == 0) {

                    // var SubRequestType = $("#Subrequesttype").val();
                    //  data = JSON.stringify({ RequestType: RequestType, SubRequestType: SubRequestType, RequestTypeCode: RequestTypeCode,RequestTypeID:"0"});
                    data = JSON.stringify({ RequestPriorityCode: RequestPriorityCode, RequestPriorityOrderNo: RequestPriorityOrderNo, RequestPriority: RequestPriority, EditPriorityID: EditPriorityID });
                    //  alert(data);
                    strResult = AJAXCallWithResult("CRM_RequestSetting.aspx/SaveRequestPriority", data, false);
                    if (strResult.d != "") {

                        $("#divPriority").css("display", "block");
                        $(".type-top-bar").css("display", "block");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Request Priority saved successfully', 'success');
                        RefreshGrid(TabName, Flag);
                    }
                    // }
                }
            }

            function ValidateRequestSeverity() {
                var chkVal = 0;
                var strmsg = "";
                var errorMsg = "<ul>"

                var RequestSeverityCode = $("#txtRequestSeverityCode").val();
                var RequestSeverity = $("#txtRequestSeverity").val();

                if ($("#txtRequestSeverityCode").val() == "") {
                    strmsg = strmsg + '- Request Severity Code should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li></n>";
                    chkVal = 1;
                }


                if ($("#txtRequestSeverity").val() == "") {
                    strmsg = strmsg + '- Request Severity should not be left blank';
                    errorMsg += "</n><li>" + strmsg + "</li>";
                    chkVal = 1;
                }


                if ($("#txtRequestSeverityCode").val() != "") {
                    var SeverityCode = $("#txtRequestSeverityCode").val();
                    data = JSON.stringify({ SeverityCode: SeverityCode, Severity: "", StrFlag: "SeverityCode" });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicateSeverityControls", data, false);

                    if (strResult1.d == "1") {
                        strmsg = strmsg + 'Request Severity Code already exists';
                        chkVal = 1;
                    }
                }

                if ($("#txtRequestSeverity").val() != "") {
                    var Severity = $("#txtRequestSeverity").val();
                    data = JSON.stringify({ SeverityCode: "", Severity: Severity, StrFlag: "Severity" });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicateSeverityControls", data, false);

                    if (strResult1.d == "1") {
                        strmsg = strmsg + 'Request Severity already exists';
                        chkVal = 1;
                    }
                }

                errorMsg += "</ul>";
                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmsg, 'error');
                }

                return chkVal;
            }
            function SaveRequestSeverity() {
                if (ValidateRequestSeverity() == 0) {
                    var RequestSeverityCode = $("#txtRequestSeverityCode").val();
                    var RequestSeverity = $("#txtRequestSeverity").val();

                    data = JSON.stringify({ RequestSeverityCode: RequestSeverityCode, RequestSeverity: RequestSeverity, EditSeverityID: EditSeverityID });
                    //  alert(data);
                    strResult = AJAXCallWithResult("CRM_RequestSetting.aspx/SaveRequestSeverity", data, false);
                    if (strResult.d != "") {

                        $("#divSeverity").css("display", "block");
                        $(".type-top-bar").css("display", "block");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Request Severity saved successfully', 'success');
                        RefreshGrid(TabName, Flag);
                    }

                }
            }


            function MapSubRequestType(obj, SubRequestTypeID, RequestTypeID) {
                var strChecked;
                if (obj.checked == true) {
                    strChecked = 1;
                }
                else {
                    strChecked = 0;
                }

                // alert(strChecked);
                //  var RequestTypeID = obj.value;
                data = JSON.stringify({ RequestTypeID: RequestTypeID, SubRequestTypeID: SubRequestTypeID, Checked: strChecked });
                //  alert(data);
                strResult = AJAXCallWithResult("CRM_RequestSetting.aspx/MapSubRequestType", data, false);
                if (strResult.d != "") {

                    if (strResult.d == '1') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sub Type mapped successfully', 'success');
                    }
                    if (strResult.d == '0') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sub Type unmapped successfully', 'success');
                    }
                    var strResult1, data1;

                    data1 = JSON.stringify({ RequestTypeID: RequestTypeID });

                    strResult1 = AJAXCallWithResult(strPageName + "/PlotSubRequestType", data1, false);

                    if (strResult1.d != '') {
                        $("#divSubRequestType").html(strResult1.d);
                        $("#divSubRequestType").addClass("table");
                        $("#divSubRequestType").css("display", "block");

                        if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                            intDivGridListHeight = parseInt(window.innerHeight) - 350;

                        }
                        else {
                            //  intDivGridListHeight = (window.innerHeight / 3) + 6;
                            intDivGridListHeight = parseInt(window.innerHeight) - 350;
                        }

                        datatableMainPage("divSubRequestType", intDivGridListHeight);

                    }

                }

            }
            function ValidateSubRequestType() {
                //   debugger;
                var checkvalue = 0;
                var strmsg = "";
                var errorMsg = "<ul>"
                if ($("#SubrequesttypeCode").val() == "") {
                    // alertify.set('notifier', 'position', 'top-right');
                    //  alertify.notify('Sub Request Type Code should not be left blank', 'error');
                    strmsg = strmsg + '- Sub Request Type Code should not be left blank';
                    checkvalue = 1;
                }
                if ($("#Sub_requesttype").val() == "") {
                    // alertify.set('notifier', 'position', 'top-right');
                    // alertify.notify('Sub Request Type should not be left blank', 'error');
                    strmsg = '- Sub Request Type should not be left blank';

                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }

                if ($("#Sub_requesttype").val() != "") {
                    if (disallowMaxlengthViolation(document.getElementById('Sub_WorkHrs'), 100) == true) {
                        strmsg = '- Max Length of Sub Request Typeis 100 characters.\r\nYou have entered <L> characters.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    if (disallowSpecialCharacters(document.getElementById('Sub_WorkHrs')) == true) {
                        strmsg = '- A Sub Request Type cannot contain any of these /\\:*?<>|,"+- characters.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }


                if ($("#Sub_WorkHrs").val() == "") {
                    // alertify.set('notifier', 'position', 'top-right');
                    // alertify.notify('Please enter work hours in multiple of 0.25', 'error');
                    strmsg = '- Please enter work hours in multiple of 0.25';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }


                if ($("#Sub_WorkHrs").val() != "") {
                    if (disallowMaxlengthViolation(document.getElementById('Sub_WorkHrs'), 8) == true) {
                        strmsg = '- Max Length of Work (hrs) is 8 characters.\r\nYou have entered <L> characters.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    if (disallowNegativeNumeric(document.getElementById('Sub_WorkHrs')) == true) {
                        strmsg = '- Please enter only positive numeric value for Work (hrs)';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    if (disallowSpecialCharacters(document.getElementById('Sub_WorkHrs')) == true) {
                        strmsg = '- A Work (hrs) cannot contain any of these /\\:*?<>|,"+- characters.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }
                if ($("#Sub_WorkHrs").val() != "") {
                    if ($("#Sub_WorkHrs").val() < "0.25") {

                        // alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify('- Please enter work hours in multiple of 0.25', 'error');
                        strmsg = '-  Please enter work hours in multiple of 0.25';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;

                    }

                    else if (RestrictNonNumeric(document.getElementById('Sub_WorkHrs'), false) == true) {
                        strmsg = '-  Please enter work hours in multiple of 0.25';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    else if (disallowNegativeNumeric(document.getElementById('Sub_WorkHrs')) == true) {
                        strmsg = '-  Please enter work hours in multiple of 0.25';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }
                if ($("#SLAThRed").val() == "") {
                    //  alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify('SLA Red Threshold should not be left blank', 'error');
                    strmsg = '- SLA Red Threshold should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }
                if ($("#SLAThRed").val() != "") {

                    if (disallowSpecialCharacters(document.getElementById('SLAThRed')) == true) {
                        strmsg = '- A SLA Red Threshold cannot contain any of these /\\:*?<>|,"+- characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    else if (disallowMinValueViolation(document.getElementById('SLAThRed'), 1) == true) {
                        strmsg = '- The value of SLA Red Threshold should not be less than 1.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    else if (disallowNegativeInteger(document.getElementById('SLAThRed')) == true) {
                        strmsg = '- Please enter only positive Integer';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }

                }

                if ($("#SLAThYellow").val() == "") {
                    // alertify.set('notifier', 'position', 'top-right');
                    // alertify.notify('SLA Yellow Threshold should not be left blank', 'error');
                    strmsg = '- SLA Yellow Threshold should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }
                if ($("#SLAThYellow").val() != "") {

                    //if (RestrictNonNumeric(document.getElementById('SLAThYellow'), false) == true) {
                    //  //  alertify.set('notifier', 'position', 'top-right');
                    //   // alertify.notify('- Please enter positive numeric value for SLA Yellow Threshold', 'error');

                    //    strmsg = '- Please enter positive numeric value for SLA Yellow Threshold';
                    //    errorMsg += "<li>" + strmsg + "</li>";
                    //    checkvalue = 1;
                    //}
                    if (disallowSpecialCharacters(document.getElementById('SLAThYellow')) == true) {
                        strmsg = '- A SLA Yellow Threshold cannot contain any of these /\\:*?<>|,"+- characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    else if (disallowMinValueViolation(document.getElementById('SLAThYellow'), 1) == true) {
                        strmsg = '- The value of SLA Yellow Threshold should not be less than 1.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    else if (disallowNegativeInteger(document.getElementById('SLAThYellow')) == true) {
                        strmsg = '- Please enter only positive Integer';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                    else if (disallowValue1GreaterThanOrEqualToValue2(document.getElementById('SLAThYellow'), document.getElementById('SLAThRed')) == true) {
                        strmsg = '- The SLA Yellow Threshold should not be greater than or equal to SLA Red Threshold';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }

                if ($("#Sub_requesttype").val() != "") {
                    var SubRequestType = $("#Sub_requesttype").val();
                    data = JSON.stringify({ SubRequestType: SubRequestType });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicateSubRequestType", data, false);
                    //  alert(strResult1.d);
                    if (strResult1.d == "1") {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify('Request Type is already exists', 'error');
                        strmsg = strmsg + 'Sub Request Type already exists';
                        checkvalue = 1;
                    }
                }

                if (strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorMsg, 'error', 15);
                    checkvalue = 1;
                }
                //    alert(checkvalue);
                return checkvalue;

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
            var strSubTpeSaveAndAddFlag = "";
            function SaveAndAddSubRequestType_Onclick() {
                strSubTpeSaveAndAddFlag = 1;
                SaveSubRequestType_Onclick();

            }
            function SaveSubRequestType_Onclick() {
                //    SubRequestTypeCode, SubRequestType, DefaultWork, IsAttachmentMandatory, TaskType, GuidelinesForRequestor, GuidelinesForAssignee, SLARedLimit, SLAYellowLimit
                //  debugger;
                var strResult, data;
                if (ValidateSubRequestType() == 0) {

                    if (strSubTpeSaveAndAddFlag == 1) {
                        EditSubRequestTypeID = 0;
                    }
                    var SubRequestTypeCode = $("#SubrequesttypeCode").val();
                    var SubRequestType = $("#Sub_requesttype").val();
                    var DefaultWork = $("#Sub_WorkHrs").val();
                    var IsAttachmentMandatory = $("#ChkAttachment").val();
                    var TaskType = $("#SubrequestTasktype").val();
                    var GuidelinesForRequestor = $("#txtGForRequestor").val();
                    var GuidelinesForAssignee = $("#txtGForAssinee").val();
                    var SLARedLimit = $("#SLAThRed").val();
                    var SLAYellowLimit = $("#SLAThYellow").val();

                    var IsAttachmentMandatoryvalue;
                    if ($("#IsAttachmentMandatory").is(':checked'))
                        IsAttachmentMandatoryvalue = 1;
                    else
                        IsAttachmentMandatoryvalue = 0;

                    data = JSON.stringify({ SubRequestTypeCode: SubRequestTypeCode, SubRequestType: SubRequestType, DefaultWork: DefaultWork, IsAttachmentMandatory: IsAttachmentMandatoryvalue, TaskType: TaskType, GuidelinesForRequestor: GuidelinesForRequestor, GuidelinesForAssignee: GuidelinesForAssignee, SLARedLimit: SLARedLimit, SLAYellowLimit: SLAYellowLimit, SubRequestTypeID: EditSubRequestTypeID });
                    //     alert(data);
                    strResult = AJAXCallWithResult("CRM_RequestSetting.aspx/SaveSubRequestType", data, false);
                    if (strResult.d != "") {

                        if (strSubTpeSaveAndAddFlag == 1) {
                            $("#SubrequesttypeCode").val("");
                            $("#Sub_requesttype").val("");
                            $("#Sub_WorkHrs").val("");
                            $("#ChkAttachment").val("");
                            document.getElementById('ChkAttachment').checked = false;
                            $("#SubrequestTasktype").val("");
                            $("#txtGForRequestor").val("");
                            $("#txtGForAssinee").val("");
                            $("#SLAThRed").val("");
                            $("#SLAThYellow").val("");
                        }
                        $("#divtblSubType").css("display", "block");
                        $(".type-top-bar").css("display", "block");
                        $(".bottom-bar").css("margin-top", "0px");
                        EditSubRequestTypeID = 0;
                        $("#collapseOne2 .panel-body").css("height", "150px");
                        RefreshGrid(TabName, Flag);
                        //$(".table-responsive").css("display", "block");
                        //$(".type-top-bar").css("display", "block");
                        //$("#RequestPaging").css("display", "block");
                    }
                }
            }
            //$('input[name="chkSelectList2"]').change(function () {
            //    var chkList = document.getElementsByName("chkSelectList2")
            //    for (var i = 0; i < chkList.length; i++) {
            //        if (chkList[i] != null) {
            //            if (chkList[i].value != this.value) {
            //                chkList[i].checked = false;
            //            }
            //        }
            //    }
            //    var checkCount = $('input[name="chkSelectList2"]:checked').length;
            //    $('.EditModeLink').css('display', 'inline-block');
            //    if (checkCount > 1) {
            //        return;
            //    }
            var EditRequestTypeID = 0;
            var EditPriorityID = 0;
            var EditSeverityID = 0;
            function Edit_RequestType(obj, RequestTypeID) {
                EditRequestTypeID = RequestTypeID;
                //  if (obj.checked) {
                //Do stuff  
                //  var RequestTypeIDs = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "CRM_RequestSetting.aspx/GetRequestTypeDetails",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ RequestTypeID: RequestTypeID }),
                    success: function (data) {
                        var arrResult = data.d.split('##');
                        // $('#requesttype').val(arrResult[0]);
                        $('#requesttypecode').val(arrResult[1]);
                        $('#requesttype').val(arrResult[2]);

                        var strResult1, data1;

                        data1 = JSON.stringify({ RequestTypeID: arrResult[0] });

                        strResult1 = AJAXCallWithResult(strPageName + "/PlotSubRequestType", data1, false);

                        if (strResult1.d != '') {
                            $("#divSubRequestType").html(strResult1.d);
                            $("#divSubRequestType").addClass("table");
                            $("#divSubRequestType").css("display", "block");
                            if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                                intDivGridListHeight = parseInt(window.innerHeight);

                            }
                            else {
                                //  intDivGridListHeight = (window.innerHeight / 3) + 6;
                                intDivGridListHeight = parseInt(window.innerHeight);
                            }

                            datatableMainPage("divSubRequestType", intDivGridListHeight);
                            //$("#idPanelBody").css("overflow", "hidden");
                       //     var bodyHeight = window.innerHeight - $('#MainDiv').offset().top;
                            //  alert(bodyHeight);
                            $('#idPanelBody').css('height', bodyHeight - 10 + 'px');
                            $("#divRequestTypes").css("display", "none");
                            $(".type-top-bar").css("display", "none");
                            $("#RequestPaging").css("display", "none");
                            //$("#accordion").css("height", intDivGridListHeight + "px");
                            //  $("#divSubRequestType").css("height", intDivGridListHeight - 250 + "px");
                            $(".dataTables_scrollBody").css("height", intDivGridListHeight - 400 + "px");
                            //$("#divSubRequestType").css("overflow", "auto");
                            //$("#accordion").css("overflow", "hidden");


                        }

                    },

                    error: function (xhr) {
                        console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                    }

                });

                // }
                // });
            }

            var EditSubRequestTypeID = 0;
            var EditStatusID = 0;
            function Edit_SubRequestType(obj, SubRequestTypeID) {
                EditSubRequestTypeID = SubRequestTypeID;
                $.ajax({
                    type: "POST",
                    url: "CRM_RequestSetting.aspx/GetSubRequestTypeDetails",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ SubRequestTypeID: SubRequestTypeID }),
                    success: function (data) {
                        var arrResult = data.d.split('##');

                        $('#SubrequesttypeCode').val(arrResult[1]);
                        $('#Sub_requesttype').val(arrResult[2]);
                        $('#Sub_WorkHrs').val(arrResult[3]);
                        $('#ChkAttachment').val(arrResult[4]);
                        $('#SubrequestTasktype').val(arrResult[5]);
                        $('#txtGForRequestor').val(arrResult[6]);
                        $('#txtGForAssinee').val(arrResult[7]);
                        $('#SLAThRed').val(arrResult[8]);
                        $('#SLAThYellow').val(arrResult[9]);
                    },
                    error: function (xhr) {
                        console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                    }
                });
            }


            function EditRequestStatus(obj, RequestStatusID) {
                EditStatusID = RequestStatusID;
                $.ajax({
                    type: "POST",
                    url: "CRM_RequestSetting.aspx/GetRequestStatusDetails",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ RequestStatusID: RequestStatusID }),
                    success: function (data) {
                        var arrResult = data.d.split('##');

                        $('#txtStatusCode').val(arrResult[1]);
                        $('#txtOrderNumber').val(arrResult[2]);
                        $('#txtRequestStatus').val(arrResult[3]);
                        $('#CboSystemStatus').val(arrResult[4]);

                    },
                    error: function (xhr) {
                        console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                    }
                });
            }

            function EditRequestPriority(obj, RequestPriorityID) {
                EditPriorityID = RequestPriorityID;
                $.ajax({
                    type: "POST",
                    url: "CRM_RequestSetting.aspx/GetRequestPriorityDetails",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ RequestPriorityID: RequestPriorityID }),
                    success: function (data) {
                        var arrResult = data.d.split('##');

                        $('#txtRequestPriorityCode').val(arrResult[1]);
                        $('#txtRequestPriority').val(arrResult[2]);
                        $('#txtRequestPriorityOrderNo').val(arrResult[3]);

                    },
                    error: function (xhr) {
                        console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                    }
                });
            }

            function EditRequestSeverity(obj, RequestSeverityID) {
                EditPriorityID = RequestPriorityID;
                $.ajax({
                    type: "POST",
                    url: "CRM_RequestSetting.aspx/GetRequestSeverityDetails",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ RequestSeverityID: RequestSeverityID }),
                    success: function (data) {
                        var arrResult = data.d.split('##');

                        $('#txtRequestSeverityCode').val(arrResult[1]);
                        $('#txtRequestSeverity').val(arrResult[2]);

                    },
                    error: function (xhr) {
                        console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                    }
                });
            }

            function AddRequestType() {
                $("#divRequestTypes").css("display", "none");
                $(".type-top-bar").css("display", "none");
                // $("#RequestPaging").css("display", "none");
                $(".bottom-bar").css("margin-top", "0px");
                EditRequestTypeID = 0;
            }

            function AddSubRequestType() {
                $("#divtblSubType").css("display", "none");
                $(".type-top-bar").css("display", "none");
                $(".bottom-bar").css("margin-top", "0px");
                EditSubRequestTypeID = 0;
                $("#collapseOne2 .panel-body").css("height", "auto");
            }

            function AddRequestStatus() {
                $("#divStatus").css("display", "none");
                $(".type-top-bar").css("display", "none");
                $(".bottom-bar").css("margin-top", "0px");
                EditStatusID = 0;
                $("#collapseOne3 .panel-body").css("height", "auto");
            }

            function AddRequestPriority() {
                $("#divPriority").css("display", "none");
                $(".type-top-bar").css("display", "none");
                $(".bottom-bar").css("margin-top", "0px");
                EditPriorityID = 0;
                $("#collapseOne4 .panel-body").css("height", "auto");
            }
            function Cancel_RequestType() {

                $("#divRequestTypes").css("display", "block");
                $(".type-top-bar").css("display", "block");
                $("#RequestPaging").css("display", "block");
                RefreshGrid('Type', Flag);
            }

            function Cancel_SubType() {
                $("#divtblSubType").css("display", "block");
                $(".type-top-bar").css("display", "block");
                EditSubRequestTypeID = 0;
                //$("#collapseOne2 .panel-body").css("height", "150px");
                RefreshGrid('Subtype', Flag);

            }

            function Cancel_Status() {
                $("#divStatus").css("display", "block");
                $(".type-top-bar").css("display", "block");
                EditSubRequestTypeID = 0;
                $("#collapseOne3 .panel-body").css("height", "150px");
                RefreshGrid('Status', Flag);
            }

            function Cancel_Priority() {
                $("#divPriority").css("display", "block");
                $(".type-top-bar").css("display", "block");
                EditPriority = 0;
                $("#collapseOne4 .panel-body").css("height", "150px");
                RefreshGrid('Priority', Flag);
            }

            function Cancel_Severity() {
                $("#divSeverity").css("display", "block");
                $(".type-top-bar").css("display", "block");
                EditPriority = 0;
                $("#collapseOne5 .panel-body").css("height", "150px");
                RefreshGrid('Severity', Flag);
            }

            function DeleteRequestType() {
                var strRequestTypeIDs;
                strRequestTypeIDs = $('input[name=chkRequestTypeDelete]:checked').map(function () {
                    return this.value;
                }).get().join(',');

                if (strRequestTypeIDs.length <= 0) {
                    return;
                }
                data = JSON.stringify({ RequestTypeID: strRequestTypeIDs });

                strResult = AJAXCallWithResult(strPageName + "/DeleteRequestType", data, false);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Type deleted successfully', 'success');
                RefreshGrid('Type', Flag);

            }

            function DeleteMultiple_RequestType() {
                if (document.getElementById('chkAllDeleteType').checked == true) {
                    $("input[name=chkRequestTypeDelete]:not(:disabled)").prop('checked', true);
                }
                else {
                    $("input[name=chkRequestTypeDelete]").prop('checked', false);
                }
            }


            function DeleteSubRequestType() {
                var strSubRequestTypeIDs;
                strSubRequestTypeIDs = $('input[name=chkSubRequestTypeDelete]:checked').map(function () {
                    return this.value;
                }).get().join(',');

                if (strSubRequestTypeIDs.length <= 0) {
                    return;
                }
                data = JSON.stringify({ SubRequestTypeID: strSubRequestTypeIDs });

                strResult = AJAXCallWithResult(strPageName + "/DeleteSubRequestType", data, false);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Sub Type deleted successfully', 'success');
                RefreshGrid('Subtype', Flag);

            }

            function DeleteMultiple_SubRequestType() {
                if (document.getElementById('chkAllDeleteSubType').checked == true) {
                    $("input[name=chkSubRequestTypeDelete]:not(:disabled)").prop('checked', true);
                }
                else {
                    $("input[name=chkSubRequestTypeDelete]").prop('checked', false);
                }
            }



            function DeleteRequestStatus() {
                var strStatusIDs;
                strStatusIDs = $('input[name=chkStatusDelete]:checked').map(function () {
                    return this.value;
                }).get().join(',');

                if (strStatusIDs.length <= 0) {
                    return;
                }
                data = JSON.stringify({ RequestStausID: strStatusIDs });

                strResult = AJAXCallWithResult(strPageName + "/DeleteRequestStatus", data, false);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Request Status deleted successfully', 'success');
                RefreshGrid('Status', Flag);

            }

            function DeleteMultiple_Status() {
                if (document.getElementById('chkAllDeleteStatus').checked == true) {
                    $("input[name=chkStatusDelete]:not(:disabled)").prop('checked', true);
                }
                else {
                    $("input[name=chkStatusDelete]").prop('checked', false);
                }
            }



            function DeleteRequestPriority() {
                var strPriorityIDs;
                strPriorityIDs = $('input[name=chkPriorityDelete]:checked').map(function () {
                    return this.value;
                }).get().join(',');

                if (strPriorityIDs.length <= 0) {
                    return;
                }
                data = JSON.stringify({ RequestPriorityID: strPriorityIDs });

                strResult = AJAXCallWithResult(strPageName + "/DeleteRequestPriority", data, false);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Request Priority deleted successfully', 'success');
                RefreshGrid('Priority', Flag);

            }

            function DeleteMultiple_Priority() {
                if (document.getElementById('chkAllDeletePriority').checked == true) {
                    $("input[name=chkPriorityDelete]:not(:disabled)").prop('checked', true);
                }
                else {
                    $("input[name=chkPriorityDelete]").prop('checked', false);
                }
            }
            function DeleteRequestSeverity() {
                var strSeverityIDs;
                strSeverityIDs = $('input[name=chkSeverityDelete]:checked').map(function () {
                    return this.value;
                }).get().join(',');

                if (strSeverityIDs.length <= 0) {
                    return;
                }
                data = JSON.stringify({ RequestSeverityID: strSeverityIDs });

                strResult = AJAXCallWithResult(strPageName + "/DeleteRequestSeverity", data, false);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Request Severity deleted successfully', 'success');
                RefreshGrid('Severity', Flag);
            }

            function DeleteMultiple_Severity() {
                if (document.getElementById('chkAllDeleteSeverity').checked == true) {
                    $("input[name=chkSeverityDelete]:not(:disabled)").prop('checked', true);
                }
                else {
                    $("input[name=chkSeverityDelete]").prop('checked', false);
                }
            }

            function Inherit_StatusFlow() {
                var FromSubRequest = $("#CbofrmSubRequest").val();
                var ToSubRequest = $("#CboToSubRequest").val();
                data = JSON.stringify({ FromSubRequest: FromSubRequest, ToSubRequest: ToSubRequest });

                strResult = AJAXCallWithResult("CRM_RequestSetting.aspx/InheritStatusFlow", data, false);
                if (strResult.d != "") {
                }

            }




            function ValidateStatus() {
                var checkvalue = 0;
                var strmsg = "";
                var errorMsg = "<ul>"
                if ($("#txtStatusCode").val() == "") {
                    strmsg = strmsg + '- Status code should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }
                if ($("#txtOrderNumber").val() == "") {
                    strmsg = strmsg + '- Order Number should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }

                if ($("#txtOrderNumber").val() != "") {
                    if (disallowSpecialCharacters(document.getElementById('txtOrderNumber')) == true) {
                        strmsg = '- A order number cannot contain any of these /\\:*?<>|,"+- characters.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }

                    if (disallowNegativeNumeric(document.getElementById('txtOrderNumber')) == true) {
                        strmsg = '- Please enter only positive numeric value for order number';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }

                if ($("#txtRequestStatus").val() == "") {
                    strmsg = strmsg + '- Request Status should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }
                if ($("#CboSystemStatus").val() == "") {
                    strmsg = strmsg + '- System Status should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }


                if ($("#txtRequestStatus").val() != "") {
                    var RequestStatus = $("#txtRequestStatus").val()
                    data = JSON.stringify({ RequestStatus: RequestStatus });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicateStatusMapped", data, false);

                    if (strResult1.d == "1") {
                        strmsg = strmsg + 'Request Status already exists';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;

                    }
                }

                if ($("#txtOrderNumber").val() != "") {
                    var OrderNumber = $("#txtOrderNumber").val()
                    data = JSON.stringify({ OrderNumber: OrderNumber });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicateOrderNumber", data, false);

                    if (strResult1.d == "1") {
                        strmsg = strmsg + 'This order number is already applied';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;

                    }
                }

                if ($("#txtStatusCode").val() != "") {
                    var StatusCode = $("#txtStatusCode").val()

                    data = JSON.stringify({ StatusCode: StatusCode });
                    var strResult1 = AJAXCallWithResult("CRM_RequestSetting.aspx/IsDuplicateStatusCode", data, false);
                   
                    if (strResult1.d == "1") {
                        strmsg = strmsg + 'Status Code already exists.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;

                    }
                }


                if (checkvalue == 1 && strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorMsg, 'error');
                    checkvalue = 1;
                }

                return checkvalue;
            }
            var EditStatus = 0;
            function SaveStatus() {
                if (ValidateStatus() == 0) {
                    var StatusCode = $("#txtStatusCode").val();
                    var OrderNumber = $("#txtOrderNumber").val();
                    var RequestStatus = $("#txtRequestStatus").val();
                    var SystemStaus = $("#CboSystemStatus").val();

                    data = JSON.stringify({ StatusCode: StatusCode, OrderNumber: OrderNumber, RequestStatus: RequestStatus, SystemStaus: SystemStaus, StatusID: EditStatus });

                    strResult = AJAXCallWithResult("CRM_RequestSetting.aspx/SaveStatus", data, false);
                    if (strResult.d != "") {
                        $("#divStatus").css("display", "block");
                        $(".type-top-bar").css("display", "block");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Status saved successfully', 'success');
                        RefreshGrid('Status', "");
                    }

                }
            }

            function Cancel_StatusFlow() {
                $("#CbofrmSubRequest").val("");
                $("#CboToSubRequest").val("");
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
            var CurDepartment = "";
            var btnEditClick = 0;
            var btnAddClick = 0;
            
            var btnEditEmailClick = 0;
            var btnAddEmailClick = 0;

            var btnEditCustomerMap = 0;
            var btnAddCustomerMap = 0;

            var FunctionRoleID = 0;
            //Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
            var FunctionProjectID = 0;
           //End of Added by Usha Pandit on 20.05.2019 for Project Mapping Sub Tag Display Issue
            var DepartmentGroupID = 0;
            var DeptCustMappingID = 0;
            var FunctionCRMID = 0;
            var FunctionRequestTypeID = 0;
            var CurrentRequestDepartment = 0;

            var chkIsExposeToCustomer = 0;
            var UniqueID = 0;
            var tblConfigHRM;
            var tblProjMapping;
            var tblGrpEmail;
            var tblCustMapping;
            var tblReqMapping;
            var tblWorkHrs;
             var GlobalDepartmentID = 0;
           
            $(document).ready(function () {
                btnAddClick = 1;
                btnEditClick = 0;

              
                //var headingcolor = $(".panel-heading").css("background-color");
              
                //$('.btn-default').each(function () {
                //    this.style.setProperty('background-color', headingcolor, 'important');
                //    this.style.setProperty('color', "white", 'important');
                //});
                //  debugger;
                $("#txtRequestTypeDepartment").prop('disabled', true);
                $("#txtRequestType").prop('disabled', true);
                $("#txtSubRequestType").prop('disabled', true);
                $("#txtWeekDay").prop('disabled', true);
                $("#txtWeekDay").css("width", "50px");
                $("#txtFromTime").css("width", "150px");
                $("#txtToTime").css("width", "150px");

                $("#cboDepartmentHead").css("visibility", "hidden");
                $("#lblDepartmentHead").css("visibility", "hidden");
              //  var bodyHeight = window.innerHeight - $('#MainDiv').offset().top;
                //    alert(bodyHeight);
                // $('#MainDiv').css('height', bodyHeight - 10 + 'px');
              
              

                $('[data-toggle="tooltip"]').tooltip();
                $("#cboRequestMapDepartment").change(function () {
                    //debugger;
                    getRequestTypeDepartmentMapping();
                });
                $("#cboRequestMapRequestType").change(function () {
                    //debugger;
                    getRequestTypeDepartmentMapping();
                });
                //$('.selectall').click(function () {
                //    alert(1);
                //    if ($(this).is(':checked')) {
                //        $('#chkDepartmentSelect').prop('checked', true);
                //        //$('#chkDepartmentSelect').each(function()
                //        //{
                //        //    $(this).attr('checked', true);
                //        //});
                //    } else {
                //        $('#chkDepartmentSelect').prop('checked', false);
                //    }
                //});

                //$("#faminus").click(function () {
                //    $("#panelDepartmentAdd").css("width", "99%");
                //});
                //$("#faplus").click(function () {
                //    $("#panelDepartmentAdd").css("width", "99%");
                //});
                RefreshPage();
                
            });
            function fnClearAll() {
                var group = "input:checkbox[id='chkDepartmentSelect']";
                $("#chkDepartmentSelectAll").prop("checked", false);
                $(group).prop("checked", false);
            }
            //function SelectMultipleDepartment() {
            //    //debugger;
            //    //alert($("input[name=selectedItems]", itemsMgmtTable.fnGetNodes()).attr('checked', element.checked));
            //    var group = "input:checkbox[id='chkDepartmentSelect']";
            //    // the checked state of the group/box on the other hand will change
            //    // and the current value is retrieved using .prop() method
               
            //    if ($("#chkDepartmentSelectAll").is(":checked"))
            //        $(group).filter(function () {
            //            return !this.disabled;
            //        }).prop("checked", true);
            //    else
            //        $(group).filter(function () {
            //            return !this.disabled;
            //        }).prop("checked", false);
            //}
         
            function SelectMultipleDepartment() {
                //Modified By Chakshuta H on 28th-Dec-2017 Purpose:For Selecting checkbox accross pagination
                // var table = $('#DataTables_Table_0').DataTable();
                var table = $('#divDepartment table').DataTable();
                var rows = table.rows({ 'search': 'applied' }).nodes();

                if (document.getElementById('chkDepartmentSelectAll').checked == true) {
                    //$("input[name=chkActivityDelete]:not(:disabled)").prop('checked', true);
                    $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
                }
                else {
                    //$("input[name=chkActivityDelete]").prop('checked', false);
                    $('input[type="checkbox"]', rows).prop('checked', false);
                }
                //End Of By Chakshuta H on 28th-Dec-2017 Purpose:For Selecting checkbox accross pagination
            }
            //function SelectMultipleDepartment() {
            //    var table = $('#DataTables_Table_0').DataTable();
            //    var rows = table.rows({ 'search': 'applied' }).nodes();
            //    var group = "input:checkbox[id='chkDepartmentSelect']";
            //    //debugger;
            //    if ($('input:checked', rows).length == rows.length) {
            //        $('input[type="checkbox"]', rows).prop('checked', false);

            //    }
            //    else {
                    
            //        if ($("#chkDepartmentSelect").is(":disabled")){
            //            $('input[type="checkbox"]', rows).prop('checked', false);
            //        }
            //        else {
            //            $('input[type="checkbox"]', rows).prop('checked', true);
            //        }
            //    }               

            //}
            
            function checkWorkDay()
            {
                if ($("#chkIsWorkingDay").is(":checked")) {
                    $("#txtFromTime").prop('disabled', false);
                    $("#txtToTime").prop('disabled', false);
                }
                else {
                    $("#txtFromTime").prop('disabled', true);
                    $("#txtToTime").prop('disabled', true);
                }
            }
            $(window).load(function () {

                //var ObjTd = window.frames.parent.document.getElementById('tdTree')
                //var ObjImg = window.frames.parent.document.getElementById('ImgShowHide')
                //var ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')

                //if (ObjTd != null && ObjImg != null) {

                //    ObjTd.style.display = 'none';
                //    ObjImg.src = '../../Images/Home/RightMove.gif';
                //    ObjLeftnavigation.style.display = '';
                //}

            //    var bodyHeight = window.innerHeight - $('#MainDiv').offset().top;

                // $('#MainDiv').css('height', bodyHeight - 10 + 'px');


                //$("#divRequestType").addClass(".table-responsive");
                // $(".table-responsive table.clsGridTable").addClass("table");

        });

         //Added by Usha Pandit on 22.05.2019 for History ModifiedBy drop down refresh issue
        function getModifiedByEntity() {
            var url = "CRM_DepartmentMaster.aspx/Default_GetModifiedBy"


            data = JSON.stringify({});
            CustomAJAXCall(url, data, BindDropDownModifiedBy);
        }
            function BindDropDownModifiedBy(result) {
                //  debugger;
                var strArray = String(result.d).split("|")
                var objCbo = document.getElementById("cboModifiedBy");

                var i = 0;

                objCbo.innerHTML = "";
                $('#cboModifiedBy').find('option').remove().end();
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = "";
                objOption.value = "";

                $.each(JSON.parse(strArray[0]), function (id, obj) {
                  
                    // $("#DRequestType").val($("#DRequestType option:first").val());
                    var objOption = document.createElement("OPTION");
                    objCbo.options.add(objOption);
                    objOption.text = obj.ModifiedBy;
                    objOption.value = obj.ModifiedBy;
                });
            }
       //End of Added by Usha Pandit on 22.05.2019 for History ModifiedBy drop down refresh issue

        function ShowHistory(){
            var obj = { "UniqueID": GlobalDepartmentID };
            var myJSON = JSON.stringify(obj);
            var url = "CRM_DepartmentMaster.aspx/ShowMailHistoryDetails"
        
            var result = AJAXCallWithResult(url, myJSON, false)
            //alert(result.d);
            if (GlobalDepartmentID == undefined || GlobalDepartmentID == 0) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(' - Please select atleast one entry..', 'error');
            }
            else {
            
                $("#divHistory #modalbody").html(result.d);
                document.getElementById('divHistory').style.display = 'block';
            }
            datatables("ShowHistoryGrid", 'txtSearchHistory');
             //Added by Usha Pandit on 22.05.2019 for History ModifiedBy drop down refresh issue
            getModifiedByEntity();
             //End of Added by Usha Pandit on 22.05.2019 for History ModifiedBy drop down refresh issue
        }
        function ModifiedFieldFilter_Change() {

            var ModifiedField = $('#cboModifiedField :selected').text();
            var ModifiedBy = $('#cboModifiedBy :selected').text();

            var obj = { "newModifiedField": ModifiedField, "MessageID": GlobalDepartmentID, "newModifiedBy": ModifiedBy };
            var myJSON = JSON.stringify(obj);

            var url = "CRM_DepartmentMaster.aspx/FilteredHistory"
            var result = AJAXCallWithResult(url, myJSON, false)
            $("#divHistory #modalbody").html(result.d);
            document.getElementById('divHistory').style.display = 'block';
            datatables("ShowHistoryGrid", 'txtSearchHistory');
    }
    </script>
</body>

</html>



