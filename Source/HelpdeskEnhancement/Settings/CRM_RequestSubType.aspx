<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_RequestSubType.aspx.vb" Inherits="PbNIT.CRM_RequestSubType" %>

<!DOCTYPE html>
<html>

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head id="Head1" runat="server">

    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>--%>

   
    <!-- Bootstrap core CSS -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>

    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" />--%>
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="../../General/Overlay.css" rel="stylesheet" />
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

     <!-- Bootstrap core JavaScript -->
        <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <%--<script src="js/editor.js"></script>--%>
    <script src="../../../EnhancementFiles/js/editor.js"></script>

    <%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>

    <!-- Time picker -->
    <%--<script src="js/timepicker.min.js"></script>
<script src="js/timepicker.js"></script>--%>
    <script src="../../../EnhancementFiles/js/timepicker.js"></script>
    <script src="../../../EnhancementFiles/js/timepicker.min.js"></script>


    <%--<script src="../../General/CommonFunctions.js"></script>
	<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
	 
    <!-- Time picker -->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="js/timepicker.min.js"></script>
    <script src="js/timepicker.js"></script>
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

        .fa-pencil-square-o {
            color: #4caac0 !important;
        }

        #DivList .dataTables_scroll {
            overflow: hidden!important;
            width: 100%!important;
        }

        #DivList .dataTables_scrollBody {
            overflow: auto!important;
            width: 102%!important;
            height: 130px;
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
            height: 110px;
            padding-right: 0.5%;
        }

        #divGridSubRequestType .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divGridSubRequestType .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            /*height: 180px;*/
            padding-right: 1%;
        }

        #DivList table tr td:nth-child(1) {
            width: 25%!important;
        }

        #DivList table tr td:nth-child(2) {
            width: 25%!important;
        }

        #DivList table tr td:nth-child(3) {
            width: 40%!important;
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
                /*Added By Kashish for ui change*/
                /*height: 272px;
                width: 103%;*/
                /*padding-right: 6%;*/
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
            font-weight: 100;
        }

        #divStatus .dataTables_scrollHeadInner table .clsTRColumnHeader tr th:nth-child(4) {
            text-align: left;
        }

        select.form-control:not([size]):not([multiple]) {
            height: calc(2.25rem + 7px);
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


        #divAUTOCLOSER tr th:nth-child(3) {
            text-align: center!important;
        }

        #divAUTOCLOSER tr th:nth-child(5) {
            text-align: center!important;
        }


        #divAUTOCLOSER tr td:nth-child(3) {
            text-align: center!important;
        }

        #divAUTOCLOSER tr th:nth-child(4) {
            text-align: center!important;
        }

        #divAUTOCLOSER tr td:nth-child(4) {
            text-align: center!important;
        }

        #divAUTOCLOSER tr td:nth-child(5) {
            text-align: center!important;
        }

        #CboAutocloser {
            margin-left: -37%!important;
        }

        #tblCloser {
            margin-left: -1.4%!important;
        }

        #divAUTOCLOSER .dataTables_scrollBody {
            width: 100%!important;
            height: 179px!important;
            overflow: hidden !important;
        }

        #divAUTOCLOSER ul.pagination {
            padding: 0px 2px 0 0px!important;
        }

        #divAUTOCLOSER table {
            width: 1065px!important;
        }

        #Autoclose .panel-title a {
            color: #fff;
            display: block;
            font-size: 15px;
            font-weight: 600;
            padding: 0px 10px 19px 10px;
            position: relative;
            float: right;
            margin-top: 2px!important;
        }

        #DivAuto {
            padding-top: 0%!important;
            padding-left: 1%!important;
        }

        #divAUTOCLOSER .dataTables_paginate {
            float: right!important;
            margin-right: -22%!important;
        }

        #AutoclosePanelDiv {
            padding-right: 3%;
        }

        .faSettingSearch {
            /* Added By Usha Pandit on 14.12.2017 for search box alignment*/
            /*position: absolute;
            margin-top: 14px;
            margin-left: 10px;*/
            /*position: absolute;
            margin-top: 7px!important;
            margin-left: 5px!important;*/
            /* End of addition Usha Pandit on 14.12.2017*/
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
            border: none!important;
        }

        .content-wrapper {
            overflow: hidden !important;
        }

        #id14 button {
            line-height: 10px!important;
            font-weight: 600!important;
            font-size: 11px!important;
        }

        .h-form .form-horizontal .control-label {
            font-size: 12px;
        }

        #Subtype {
           height: 733px;
            overflow-x: hidden;
            overflow-y: auto;
            width: 102%;
        }

        #divScrollSubType {
            width: 102%;
            padding-right: 2%;
            overflow: auto;
        }

        .dataTables_scrollBody .clsTRColumnHeader {
            height: 0px !important;
        }

        .type-top-bar {
            padding-right: 5px!important;
        }

            .type-top-bar .right {
                padding: 0px !important;
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



        /* Added By Usha Pandit on 14.12.2017 for uniform textarea*/

        .bottom-bar textarea {
            border-color: #bbb;
        }

        /*'/*commented by Kashish for ui change*/
        /*.form-group {
            margin-bottom: 1%!important;
        }*/

        #divGridSubRequestType td {
            border: none !important;
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
        }

        #SearchSubRquestType {
            outline: none;
        }
        #isSaveandAdd{
        float: right;
        margin-top: 5px;
        margin-left: 5px;
        display:block;
        background-color:white!important;
        color:white;
    }
        /* End of addition Usha Pandit on 14.12.2017*/

        /*Dipali V on 19th Dec 2017 For History Link*/

           .clslabel {
            margin-top:1.5%!important;
            font-size:12px;
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
	        overflow-x: hidden !Important;
	        overflow-y: auto !Important;
	        padding-right: -1%!important;
	        width: 105%!important;
	        /*height: 158px!important;*/
	        padding-right: 2%!important;
	    }

	    #modalbody {
            overflow:hidden!important;
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
    margin: 23px 0px !important;
}

        #id14 label {
            font-size:12px;
            margin-top:3%!important;
}

       #ShowHistoryGrid .dataTables_info {
           margin-top:30px;
        }

        #ShowHistoryGrid .clsTROdd {
            background-color:white!important;
        }
        /*End of Dipali V on 19th Dec 2017 For History Link*/
         #btnConfigureHRM {
            font-size: 12px;       
        }
          #SubType .h-tabs div.navtab button.active {
    border-left: 1px solid #e3e2e2;
    border-right: 1px solid #e3e2e2;
    border-top: 1px solid #e3e2e2;
    border-bottom: none;
    background: none;
}
        #btnProjectMapping {
             border-left: 1px solid #e3e2e2;
    border-right: 1px solid #e3e2e2;
    border-top: 1px solid #e3e2e2;
    border-bottom: none;
    background: none;
        }
    #SubType .h-tabs div.navtab button {
     /*border: none !important;*/ 
     border-bottom: 1px solid #ddd;
    border-right:1px solid white;
     border-top:1px solid white;
}
     .clsSubtags {
            width:160px !important;
        }

          #btnConfigureHRM {
            font-size: 12px;       
        }

           .tablinks4 {
            height: 30px;
            background-color: white;
        }
           #ShowHistory .form-group{

   margin-top:3%!important

}
        #btnConfigureHRM {
            display:none;
        }
    #CustomerContact{
    margin-right:23px;
    }

        .panel-title a {
            float:none!important;
        }

        #divCustomerContactcilent table tr th:nth-child(3) {
            text-align:center!important;
        }

        .edit-bt1 {
            border:none!important;
        }
          /*added by Usha Pandit on 20.12.2017 for alignment*/
        td, th {
            white-space: nowrap;
        }

        #tblConfigureStatus td {
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
            text-align: center;
        }

        th {
            /*color: black;*/
        }

        /*added by Usha Pandit on 20.12.2017 for alignment*/
 #idPlus {
            display:inline-block !important;
        }
       
 .top-bar i::-ms-clear {
            display: none;
        }
/*End of Added by Dipali V on 20th Dec 2017 For IE Browser*/
 .container-fluid {
            min-height: 4px !important;
        }
        .modal 
        {
            display: none;
            position: absolute;
            z-index: 2000;
            left: 0;
            top: -26px!important;
            width: 100%;
            height: auto;
            padding-top: 0px!important;
        }
        .modal-content {
            width:923px!important;
        }
          .FixedTD {
            /*background-color:#F0D1A1;/*#e6ffff*/
            padding: 5px !important;
            position: fixed;
            /*background-clip: padding-box;*/
            /*background-color:#f0ccc3!important;*/
            border: 1px solid white;
            overflow-x:hidden;
            overflow-y:auto;
        }

        #DivList1 .table thead > tr > th {
            position: relative;
            left: 0px;
            padding: 5px;
            z-index: 99999;
        }

    </style>

    <body class="" id="page-top">

        <!-- Navigation -->

        <!----------------------------  Tabs----------------------------->
         <input type="hidden" id="hdnCustomerCilentID" name="hdnCustomerCilentID" value="" />
        <%WriteTabsControls("", "Load", "", "")%>
    </body>
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
                        <button type="button" class="btn btn-default save" onclick="Inherit_StatusFlow()" style="background-color: #343660; color: #fff;" >Inherit</button>
                        <button type="button" class="btn btn-default save" onclick="Cancel_StatusFlow()" style="background-color: #fff; color: #343660;" >Clear</button>
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
                                        <button type="button" class="btn btn-default save" style="background-color: #343660; color: #fff;">Save</button></td>
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
                <span onclick="document.getElementById('id12').style.display='none'" class="close" title="Close">&times;</span>
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
     <div id="ShowHistory" class="modal">

            <form class="modal-content animate" action="/action_page.php">
                <div class="imgcontainer">
                    <span class="appro-title">Show History</span>
                    <span onclick="close_onclick()" class="close" title="Close">&times;</span>
                </div>
                <div class="container-fluid">
                    <%--<div class="form-group" style="margin-top:9px;">
                        <label class="control-label col-sm-3" for="request type">Modified Field</label>
                        <div class="col-sm-9">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 917", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top:9px;">
                        <label class="control-label col-sm-3" for="request type code">Modified By</label>
                        <div class="col-sm-9">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 917", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>
                    </div>--%>
                     <div class="form-group">
                        <label class="control-label col-sm-2 clslabel" for="request type">Modified Field</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 919", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                         <label class="control-label col-sm-2 clslabel" for="request type code">Modified By</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 919", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                    </div>
                    <div class="container-fluid" id="Div2" style="overflow-x: hidden;overflow-y: auto;width:700px;">
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
   



      <%--added by Usha Pandit on 20.12.2017 for Configure Status Flow Popup"--%>
    <div id="divConfigureStatusFlow" class="modal">
      <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title" id="Spanconfiguration"></span>

                <%-- Commented and added by Usha Pandit on 19.12.2017 for close modal popup
                  <%--  <span onclick="close_onclick()" class="close" title="Close Modal">&times;</span>--%>
                <button type="button" class="close" data-dismiss="modal" style="outline: none;" aria-hidden="true" onclick="closeStatusFlowDiv_onclick()" title="Close">&times;</button>
            </div>
            <div class="container-fluid">


                <%--added by Usha Pandit on 19.12.2017 for style="margin-top:3%;margin-left: 4%;"--%>
                <%--<div class="form-group" style="margin-top:3%;margin-left: 4%;">
                        <label class="control-label col-sm-2 clslabel" for="request type">Modified Field</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 917", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                         <label class="control-label col-sm-2 clslabel" for="request type code">Modified By</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 917", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                    </div>--%>
                <div id="Div3" style="overflow: hidden; width: 100%; margin-top: 1%">

                    <div class='table-responsive' style="overflow: auto; height: 250px; width: 103%;" id="DivList1">

                       
                        <table class='table table-bordered table-stripped' id='tblConfigureStatus'>
                           <%-- <thead>
                            </thead>
                            <tbody>
                            </tbody>--%>
                        </table>
                    </div>


                    <div class="form-group">
                        <div class="right">
                            <button type="button" id="btnSave" style="font-size: 11px; line-height: 10px;"
                                onclick="SaveConfigureStatusDetails()" title="Save" class="btn btn-default save">
                                Save</button>
                            <button type="button" id="btnCancel" style="font-size: 11px; line-height: 10px;"
                                onclick="closeStatusFlowDiv_onclick()" title="Cancel" class="btn btn-default save">
                                Cancel</button>
                        </div>
                    </div>



                </div>
            </div>
        </form>
    </div>
    <%--End of added by Usha Pandit on 20.12.2017 for Configure Status Flow Popup"--%>

    <script>
         <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
		    <%End If%>
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
        var strPageName = "CRM_RequestSubType.aspx";
        $(document).ready(function () {
            $("#divtblSubType").css("height", "auto!important");
           
            $("#txtEditor").Editor();
            $("#txtEditor1").Editor();
            $("#txtEditor2").Editor();
            $("#txtEditor3").Editor();

            //Added By Chakshuta H on 5thJan-2017 Purpose::Issue id-9869
            $("#Addaccordion").click(function () {

                if ($("#collapseOne2").hasClass("in")) {
                    $("#divSubRequestType").css("display", "none");
                    //$("#headingOne").css("margin-top", "11px");
                    $("#plus").css("display", "block");
                    $("#minus").css("display", "none");
                }
                else {
                    $("#divSubRequestType").css("display", "block");
                    $("#plus").css("display", "none");
                    $("#minus").css("display", "block");

                }
            })
            //End Of Added By Chakshuta H on 5thJan-2017 Purpose::Issue id-9869
           
        });


        //Added by Dipali on 16th Dec for Close LogOut Pop_up
        $(document).click(function () {
            //alert(window.parent.parent.parent.location);
            $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
            $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

        });
        //End of Added by Dipali on 16th Dec for Close LogOut Pop_up
    </script>

    <script>
        var TabName = "";
        var Flag = "";
        var arrSelectedCheck = new Array();
        var EditSubRequestTypeID = 0;
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


        function PlotControls() {
            // debugger;
            var strResult, data;
            var GridParameter = {};


            var DivId;
            var DivSerach;

            DivId = "divGridSubRequestType";
            DivSerach = "SearchSubRquestType";

            var TypeDiv; var accordion;

            var intDivGridHeight

           
                intDivGridHeight = (window.innerHeight / 2);
                intDivGridListHeight = parseInt(window.innerHeight);
                if ((parseInt(window.innerHeight) <= 900 && parseInt(window.innerWidth) <= 1080)) {
               
                    $('#divScrollSubType').css('height', intDivGridListHeight - 250 + 'px');
                   // alert(12);
                }

                else if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024)) {
                  
                    $('#divScrollSubType').css('height', intDivGridListHeight + 90 + 'px');
                   
                }
                else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                  
                    $('#divScrollSubType').css('height', intDivGridListHeight + 90 + 'px');
                  
                }
                else {
                  
                    $('#divScrollSubType').css('height', intDivGridListHeight - 250 + 'px');
                    /* End of addition by Usha pandit */
                }




            //var intDivGridHeight, intDivGridListHeight
            //intDivGridListHeight = parseInt(window.innerHeight);
            //if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

            //    $("#divScrollSubType").css('height', intDivGridListHeight - 280 + "px");
            //}

            //else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

            //    $("#divScrollSubType").css('height', intDivGridListHeight - 320 + "px");
            //}
            //else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

            //    $("#divScrollSubType").css('height', intDivGridListHeight - 280 + "px");
            //}
            //else {
            //    $("#divScrollSubType").css('height', intDivGridListHeight - 280 + "px");
            //}

            datatables(DivId, "SearchRquestType", '');
            datatables("divCustomerContactcilent", "", '');
            $('#divCustomerContactcilent').css('height', " 190px");

        }
        //function RefreshGrid(cityName, Flag) {
        //    //alert(Flag);
        //    //alert(cityName);
        //    var strResult, data;
        //    var GridParameter = {};
        //    if (cityName == "ClientContact") {
        //        DivId = "divCustomerContactcilent";
        //        DivSerach = "";
        //        //$("#ProjectMapping" + " .table-responsive:first").html(strResult.d);
        //    }
        //    else {
        //        DivId = "divGridSubRequestType";
        //        DivSerach = "SearchSubRquestType";
        //        cityName = "Subtype";
        //    }
        //    GridParameter.cityName = cityName;
            
        //    if (Flag != "") {
        //        data = JSON.stringify({ GridParameter: GridParameter });

        //        strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
        //        var DivId;
        //        var DivSerach;
        //        //  alert(strResult.d);

        //        if (cityName == "ClientContact") {
        //            //$("#tblProjectMapping").html("");
        //            //$("#tblProjectMapping").html(strResult.d);

        //            //$("#ProjectMapping" + " .table-responsive:first").html(strResult.d);
        //            //$(".table-responsive:first table").addClass("table");
        //        }
        //        else {
        //            $("#divtblSubType").html("");
        //            $("#divtblSubType").html(strResult.d);

        //            $(".table-responsive:first table").addClass("table");
        //        }
               
        //        PlotControls();


        //    }
        //}
        function RefreshGrid(cityName) {
            // debugger;
            var strResult, data;
            var GridParameter = {};
            GlobalContactCustomerId = 0;
            GridParameter.cityName = cityName;

            data = JSON.stringify({ GridParameter: GridParameter, RequestTypeID: EditSubRequestTypeID, Role: "", Status: "" });
            // alert(data);
            strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);
            var DivId;
            //alert(cityName);
            var DivSerach;
            // alert(strResult.d);
            if (strResult != '' && strResult != 'undefined') {
                if (cityName == "SubType") {
                    DivId = "divGridSubRequestType";
                    DivSerach = "SearchRquestType";
                    $("#divtblSubType").html(strResult.d);
                }
                else if (cityName == "PlotSubtab") {
                    DivId = "divCustomerContactcilent";
                    // var tablename = "divCustomerContact";
                    $("#ProjectMapping" + " .table-responsive:first").html(strResult.d);
                    DivSerach = "";
                }
                else if (cityName == "ClientContact") {
                    DivId = "divCustomerContactcilent";
                    DivSerach = "";
                    $("#ProjectMapping" + " .table-responsive:first").html(strResult.d);
                }
                
            }
            var TypeDiv; var accordion;
            //var intDivGridHeight

            //if (WhichBrowser() == "IE") {
            //    intDivGridHeight = (window.innerHeight / 2);

            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
            //        // alert('111');
            //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
            //        // alert('11');
            //        intDivGridListHeight = parseInt(window.innerHeight) - 200;
            //    }
            //    else {
            //        // alert('1');
            //        intDivGridListHeight = parseInt(window.innerHeight) - 130;
            //    }

            //    // alert('1');
            //    //alert(intDivGridListHeight - 500);
            //    //   $('.panel-body').css('height', intDivGridListHeight + "px");
            //    $('#divRequestTypes').css('height', intDivGridListHeight - 550 + "px");
            //    //$('#Type').css('height', " 400px");
            //    //$('#divTypeStatus').css('height', " 400px");
            //    // $('#Type').css('height', intDivGridListHeight + 500 + "px");
            //}
            //else {
            //    intDivGridHeight = (window.innerHeight / 2);
            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {                 
            //        intDivGridListHeight = parseInt(window.innerHeight) - 350;
            //        $('#divRequestTypes').css('height', intDivGridListHeight - 150 + "px");                  
            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
            //        // alert('22');

            //        intDivGridListHeight = parseInt(window.innerHeight) - 440;

            //        $('#divRequestTypes').css('height', intDivGridListHeight - 110 + "px");
                  
            //        $('#divTypeStatus').css('height', " 450px");
               
            //    }
            //    else {
                   
            //        intDivGridListHeight = parseInt(window.innerHeight) - 590;
                
            //        $('#divRequestTypes').css('height', intDivGridListHeight - 340 + "px");
             
            //    }


            //}


            var intDivGridHeight, intDivGridListHeight
            intDivGridListHeight = parseInt(window.innerHeight);
            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

                $("#divScrollSubType").css('height', intDivGridListHeight - 280 + "px");
                $('#divCustomerContactcilent').css('height', "170px");
            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

                $("#divScrollSubType").css('height', intDivGridListHeight - 320 + "px");
                $('#divCustomerContactcilent').css('height', "160px");
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                $("#divScrollSubType").css('height', intDivGridListHeight - 280 + "px");
                $('#divCustomerContactcilent').css('height', "160px");
              
            }
            else {
              
                $("#divScrollSubType").css('height', intDivGridListHeight - 280 + "px");
                $('#divCustomerContactcilent').css('height', "170px");
            }

           
            datatables(DivId, DivSerach, intDivGridListHeight);

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


        function datatables(divID, txtBoxID, height) {
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' > table').DataTable({
                responsive: true,
                "pageLength": 3,
                //scrollY: "115px",
                pagingType: "simple_numbers",
                ordering: true,
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
                //    "orderable": false,
                //}], 
                // "bstateSave": true,
                //scrollX: true
            });
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
            strResult = AJAXCallWithResult("CRM_RequestSubType.aspx/MapSubRequestType", data, false);
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
                        intDivGridListHeight = parseInt(window.innerHeight) - 500;
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
                strmsg = '- Sub Request Type Code should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
                $("#SubrequesttypeCode").focus();               //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            }
            if ($("#Sub_requesttype").val() == "") {
                // alertify.set('notifier', 'position', 'top-right');
                // alertify.notify('Sub Request Type should not be left blank', 'error');
                strmsg = '- Sub Request Type should not be left blank';

                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;

                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                var hasFocus = $('#SubrequesttypeCode').is(':focus');
                if (hasFocus) {

                }
                else {
                    $("#Sub_requesttype").focus();
                }
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            }

            if ($("#Sub_requesttype").val() != "") {
                //if (disallowMaxlengthViolation(document.getElementById('Sub_WorkHrs'), 100) == true) {
                //    strmsg = '- Max Length of Sub Request Typeis 100 characters.\r\nYou have entered <L> characters.';
                //    errorMsg += "<li>" + strmsg + "</li>";
                //    checkvalue = 1;
                //}
                //if (disallowSpecialCharacters(document.getElementById('Sub_WorkHrs')) == true) {
                //    strmsg = '- A Sub Request Type cannot contain any of these /\\:*?<>|,"+- characters.';
                //    errorMsg += "<li>" + strmsg + "</li>";
                //    checkvalue = 1;
                //}
            }


            //if ($("#Sub_WorkHrs").val() == "") {
            //    // alertify.set('notifier', 'position', 'top-right');
            //    // alertify.notify('Please enter work hours in multiple of 0.25', 'error');
            //    strmsg = '- Please enter work hours in multiple of 0.25';
            //    errorMsg += "<li>-" + strmsg + "</li>";
            //    checkvalue = 1;
            //}


            //if ($("#Sub_WorkHrs").val() != "") {
            //    if (disallowMaxlengthViolation(document.getElementById('Sub_WorkHrs'), 8) == true) {
            //        strmsg = '- Max Length of Work (hrs) is 8 characters.\r\nYou have entered <L> characters.';
            //        errorMsg += "<li>" + strmsg + "</li>";
            //        checkvalue = 1;
            //    }
            //    if (disallowNegativeNumeric(document.getElementById('Sub_WorkHrs')) == true) {
            //        strmsg = '- Please enter only positive numeric value for Work (hrs)';
            //        errorMsg += "<li>" + strmsg + "</li>";
            //        checkvalue = 1;
            //    }
            //    if (disallowSpecialCharacters(document.getElementById('Sub_WorkHrs')) == true) {
            //        strmsg = '- A Work (hrs) cannot contain any of these /\\:*?<>|,"+- characters.';
            //        errorMsg += "<li>" + strmsg + "</li>";
            //        checkvalue = 1;
            //    }
            //}
            //if ($("#Sub_WorkHrs").val() != "") {
            //    if ($("#Sub_WorkHrs").val() < "0.25") {

            //        // alertify.set('notifier', 'position', 'top-right');
            //        //alertify.notify('- Please enter work hours in multiple of 0.25', 'error');
            //        strmsg = '-  Please enter work hours in multiple of 0.25';
            //        errorMsg += "<li>" + strmsg + "</li>";
            //        checkvalue = 1;

            //    }

            //    else if (RestrictNonNumeric(document.getElementById('Sub_WorkHrs'), false) == true) {
            //        strmsg = '-  Please enter work hours in multiple of 0.25';
            //        errorMsg += "<li>-" + strmsg + "</li>";
            //        checkvalue = 1;
            //    }
            //    else if (disallowNegativeNumeric(document.getElementById('Sub_WorkHrs')) == true) {
            //        strmsg = '-  Please enter work hours in multiple of 0.25';
            //        errorMsg += "<li>" + strmsg + "</li>";
            //        checkvalue = 1;
            //    }
            //}
            if ($("#SLAThRed").val() == "") {
                //  alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify('SLA Red Threshold should not be left blank', 'error');
                strmsg = '- SLA Red Threshold should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;

                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                if ($('#SubrequesttypeCode').is(':focus') == true || $('#Sub_requesttype').is(':focus') == true) {

                }
                else {
                    $("#SLAThRed").focus();
                }
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
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

                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                if ($('#SubrequesttypeCode').is(':focus') == true || $('#Sub_requesttype').is(':focus') == true || $('#SLAThRed').is(':focus') == true) {

                }
                else {
                    $("#SLAThYellow").focus();
                }
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
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
                    errorMsg += "<li>-" + strmsg + "</li>";
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

            //Added by Usha Pandit on 14.12.2017 
            //if (EditSubRequestTypeID == 0) {
            //    //end of addition Usha Pandit

            //    //if ($("#Sub_requesttype").val() != "") {
            //    //    var SubRequestType = $("#Sub_requesttype").val();
            //    //    data = JSON.stringify({ SubRequestType: SubRequestType });
            //    //    var strResult1 = AJAXCallWithResult("CRM_RequestSubType.aspx/IsDuplicateSubRequestType", data, false);
            //    //    //  alert(strResult1.d);
            //    //    if (strResult1.d == "1") {
            //    //        //alertify.set('notifier', 'position', 'top-right');
            //    //        //alertify.notify('Request Type is already exists', 'error');
            //    //        strmsg = strmsg + '- Sub Request Type already exists';
            //    //        errorMsg += "<li>" + strmsg + "</li>";
            //    //        checkvalue = 1;
            //    //    }
            //    //}



            //    //Added by Usha Pandit on 14.12.2017 
            //}

            if ($("#SubrequesttypeCode").val() != "") {
                data = JSON.stringify({ RequestSubType: "", RequestSubTypeCode: $("#SubrequesttypeCode").val(), Flag: "RequestSubTypeCode", EditSubRequestTypeID: EditSubRequestTypeID });
                var strResult1 = AJAXCallWithResult("CRM_RequestSubType.aspx/IsDuplicateSubRequestType", data, false);
                //alert(EditRequestTypeID);

                if (strResult1.d == "1") {

                    strmsg = '- Sub Request Type Code already exists';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;



                }
            }

            if ($("#Sub_requesttype").val() != "") {
                data = JSON.stringify({ RequestSubType: $("#Sub_requesttype").val(), RequestSubTypeCode: "", Flag: "RequestSubType", EditSubRequestTypeID: EditSubRequestTypeID });
                var strResult1 = AJAXCallWithResult("CRM_RequestSubType.aspx/IsDuplicateSubRequestType", data, false);
                //alert(EditRequestTypeID);

                if (strResult1.d == "1") {
                    strmsg = '- Sub Request Type already exists ';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;

                }
            }





            //end of addition Usha Pandit
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.set('notifier', 'position', 'top-right');
                // alertify.notify(strmsg, 'error');
                alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 15);
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
        function SaveAndAddSubRequestType_Onclick(Flag) {
            strSubTpeSaveAndAddFlag = 1;
            SaveSubRequestType_Onclick(Flag);

        }
        function SaveSubRequestType_Onclick(Flag) {
            //    SubRequestTypeCode, SubRequestType, DefaultWork, IsAttachmentMandatory, TaskType, GuidelinesForRequestor, GuidelinesForAssignee, SLARedLimit, SLAYellowLimit
            //debugger;
            var strResult, data;

            if (ValidateSubRequestType() == 0) {

                //if (strSubTpeSaveAndAddFlag == 1) {
                //    EditSubRequestTypeID = 0;
                //}
                var SubRequestTypeCode = $("#SubrequesttypeCode").val();
                var SubRequestType = $("#Sub_requesttype").val();
                //var DefaultWork = $("#Sub_WorkHrs").val();
                var DefaultWork = "Null";
                var IsAttachmentMandatory = $("#ChkAttachment").val();
                //var TaskType = $("#SubrequestTasktype").val();
                var TaskType = "Null";
                var GuidelinesForRequestor = $("#txtGForRequestor").val();
                var GuidelinesForAssignee = $("#txtGForAssinee").val();
                var SLARedLimit = $("#SLAThRed").val();
                var SLAYellowLimit = $("#SLAThYellow").val();

                var IsAttachmentMandatoryvalue;
                var IsAttachmentMandatory = document.getElementById('ChkAttachment');

                if (IsAttachmentMandatory.checked == true) {
                    // alert(IsAttachmentMandatory.checked);
                    IsAttachmentMandatoryvalue = 1;

                }
                else {

                    IsAttachmentMandatoryvalue = 0;
                }
                //if ($("#IsAttachmentMandatory").is(':checked'))
                //    IsAttachmentMandatoryvalue = 1;
                //else
                //    IsAttachmentMandatoryvalue = 0;



                data = JSON.stringify({ SubRequestTypeCode: SubRequestTypeCode, SubRequestType: SubRequestType, DefaultWork: DefaultWork, IsAttachmentMandatory: IsAttachmentMandatoryvalue, TaskType: TaskType, GuidelinesForRequestor: GuidelinesForRequestor, GuidelinesForAssignee: GuidelinesForAssignee, SLARedLimit: SLARedLimit, SLAYellowLimit: SLAYellowLimit, SubRequestTypeID: EditSubRequestTypeID });
                //alert(data);
                strResult = AJAXCallWithResult("CRM_RequestSubType.aspx/SaveSubRequestType", data, false);
                //alert(EditSubRequestTypeID);
                //alert(strResult.d);
                //AddedBy Chakshuta H on 11th-Jan-2018 Purpose:Issue Id-10339 
                EditSubRequestTypeID = strResult.d;
                //End Of AddedBy Chakshuta H on 11th-Jan-2018 Purpose:Issue Id-10339 
                if (strResult.d != "") {
                    // alert(strSubTpeSaveAndAddFlag);
                    //Added by Usha Pandit on 14.12.2017 for duplicate check

                    //if (strResult.d == "1")
                    //{
                    //    alertify.notify('Sub Type already exists.', 'error');
                    //    $("#SubrequesttypeCode").focus();
                    //}
                    //else {
                    //End of addition Usha Pandit
                    if (strSubTpeSaveAndAddFlag == 1) {
                        $("#SubrequesttypeCode").val("");
                        $("#Sub_requesttype").val("");
                        //$("#Sub_WorkHrs").val("");
                        $("#ChkAttachment").val("");
                        document.getElementById('ChkAttachment').checked = false;
                        //$("#SubrequestTasktype").val("");
                        $("#txtGForRequestor").val("");
                        $("#txtGForAssinee").val("");
                        $("#SLAThRed").val("");
                        $("#SLAThYellow").val("");
                        $("#divtblSubType").css("display", "none");
                        $(".type-top-bar").css("display", "none");
                        $("#headingOne2").css("margin-top", "11px");
                    }
                    else {
                        $("#divtblSubType").css("display", "block");
                        $(".type-top-bar").css("display", "block");
                    }
                    $(".bottom-bar").css("margin-top", "0px");
                    //EditSubRequestTypeID = 0;
                    // alert(EditSubRequestTypeID);
                    
                    if (Flag != "SaveAdd" || EditSubRequestTypeID == 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sub Type saved successfully', 'success');

                        //Added by Usha Pandit on 04 JAN 2018
                        $("#divSubTypeBottom").css("margin-top", "15px");
                        //End of Added by Usha Pandit on 04 JAN 2018
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sub Type details updated successfully', 'success');

                    }
                    //Commented by Usha Pandit on 14.12.2017 to adjust panel height 
                    //$("#collapseOne2 .panel-body").css("height", "150px");
                    //End of addition by Usha Pandit
                    //RefreshGrid("SubType", "Flag");
                    RefreshGrid("SubType");

                }
                //$(".table-responsive").css("display", "block");
                //$(".type-top-bar").css("display", "block");
                //$("#RequestPaging").css("display", "block");
            }
        }
        // }

        var EditRequestTypeID = 0;
        var EditPriorityID = 0;
        var EditSeverityID = 0;


       
        var EditStatusID = 0;
        function Edit_SubRequestType(obj, SubRequestTypeID) {

            EditSubRequestTypeID = SubRequestTypeID;
            $.ajax({
                type: "POST",
                url: "CRM_RequestSubType.aspx/GetSubRequestTypeDetails",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ SubRequestTypeID: SubRequestTypeID }),
                success: function (data) {
                    var arrResult = data.d.split('##');

                    $('#SubrequesttypeCode').val(arrResult[1]);
                    $('#Sub_requesttype').val(arrResult[2]);
                    //$('#Sub_WorkHrs').val(arrResult[3]);

                    //Added & Commemted by Dipali v on 19th Dec 2017 
                    //alert(arrResult[4]);
                    //$('#ChkAttachment').val(arrResult[4]);

                    if (arrResult[4] == "True") {

                        $("#ChkAttachment").prop('checked', true);

                    }
                    else {

                        $("#ChkAttachment").prop('checked', false);
                    }
                    //End of Added & Commemted by Dipali v on 19th Dec 2017 

                    //$('#SubrequestTasktype').val(arrResult[5]);
                    $('#txtGForRequestor').val(arrResult[6]);
                    $('#txtGForAssinee').val(arrResult[7]);
                    $('#SLAThRed').val(arrResult[8]);
                    $('#SLAThYellow').val(arrResult[9]);

                    $("#idShowHistory").css("display", "inline");
                    $("#divSubTypeTab").css("display", "none");
                    $("#divtblSubType").css("display", "none");
                    $("#headingOne2").css("margin-top", "11px");

                    // $("#footerpanelbody").css("visibility", "visible");
                    $("#plus").css("display", "none");
                    $("#minus").css("display", "block");

                    /////////////////////////////////////////////////////
                    var strResult1, data1;
                    // alert(EditCustomerID);
                    data1 = JSON.stringify({ SubRequestTypeID: EditSubRequestTypeID, Flag: "CLIENTCONTACT" });
                    strResult1 = AJAXCallWithResult(strPageName + "/PlotSubtab", data1, false);
                    //alert(strResult1.d);
                    if (strResult1.d != '') {

                        //PlotSubtab1("ClientContact");

                        $("#divSubRequestType").html("");
                        $("#divSubRequestType").html(strResult1.d);
                        $("#divSubRequestType").addClass("table");
                       // alert(Flag);

                        if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366)
                        {
                            intDivGridListHeight = parseInt(window.innerHeight) - 250;
                        }
                        else {                       
                            intDivGridListHeight = parseInt(window.innerHeight) - 600;
                        }


                         datatables("divCustomerContact", "", intDivGridListHeight)

                    }
                    ///////////////////////////////////////////////////////////////
                    
                    PlotControls();

                    /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
                    if ($("#Addaccordion").hasClass("collapsed")) {
                        $("#Addaccordion").removeClass("collapsed");
                        $("#collapseOne2").css('height', 'auto');
                        $("#collapseOne2").css('width', 'auto');
                        $("#collapseOne2").addClass('in');

                    }
                    $("#panelProjectAdd").css("display", "none");
                    $("#panelProject").css("display", "none");
                    $("#CustomerContact").css("display", "none");
                    /*End of Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
                },
                error: function (xhr) {
                    console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                }
            });

            $("[title]").click(function () {
                $('.ui-tooltip').fadeOut('fast', function () {
                    $('.ui-tooltip').remove();
                });
            });
        }

        function PlotSubtab1(Flag) {

            // alert(EditCustomerID);

            var strResult1, data1;

            data1 = JSON.stringify({ CustomerID: EditSubRequestTypeID, Flag: Flag });
            strResult1 = AJAXCallWithResult(strPageName + "/PlotSubtab", data1, false);
            // alert(strResult1.d);
            if (strResult1.d != '') {
                if (Flag == "PlotSubtab") {
                    $("#divCustomerContactcilent").css("display", "none!imporatnt");
                    //$("#DivHorizontal").html("");
                    //$("#DivHorizontal").html(strResult1.d);
                    //// $("#divSubRequestType").addClass("table");
                    //$("#divSubRequestType").css("display", "none!imporatnt");
                    //// $("#btnConfigureHRM")
                    //if ($("#btnConfigureHRM").hasClass('active')) {

                    //    $("#btnConfigureHRM").removeClass('active')
                    //    $("#btnConfigureHRM").addClass('active')
                    //}
                    //else {
                    //    $("#btnConfigureHRM").addClass('active')
                    //    // $("#btnProjectMapping").css('Margin-top', '1px solid #ddd')
                    //    // $("#btnProjectMapping").css('Margin-bottom', '')
                    //    $("#btnProjectMapping").removeClass('active')

                    //}


                }

                else {

                    $("#DivHorizontal").html("");
                    $("#DivHorizontal").html(strResult1.d);
                    // $("#divSubRequestType").addClass("table");
                    $("#divCustomerContactcilent").css("display", "block!imporatnt");
                    $('#divCustomerContactcilent').css('height', " 192px");
                    $('#divCustomerContactcilent').css('width', " 101.5%");

                    if ($("#btnProjectMapping").hasClass('active')) {

                        $("#btnProjectMapping").removeClass('active')

                    }
                    else {
                        $("#btnProjectMapping").addClass('active')
                        $("#btnConfigureHRM").removeClass('active')

                    }
                }
                if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                    //alert(1);
                    intDivGridListHeight = parseInt(window.innerHeight) - 250;

                }
                else {
                    //alert(2);
                    //  intDivGridListHeight = (window.innerHeight / 3) + 6;
                    intDivGridListHeight = parseInt(window.innerHeight) - 300;
                }
                //  alert(intDivGridListHeight);
                // datatableMainPage("divCustomerContact", intDivGridListHeight);
                if (Flag == "PlotSubtab") {
                    datatables("divCustomerContact", "", intDivGridListHeight)
                }
                else if (Flag == "ClientContact") {
                    
                    datatables("divCustomerContactcilent", "", intDivGridListHeight)
                }
            }

            $("[title]").click(function () {
                $('.ui-tooltip').fadeOut('fast', function () {
                    $('.ui-tooltip').remove();
                });
            });

        }
        function openCity4(evt, cityName) {
            //debugger;
            var i, tabcontent4, tablinks4;
            //alert(cityName);

            $("#panelProjectAdd").css("display", "none");
            $("#panelProject").css("display", "none");
            $("#CustomerContact").css("display", "none");

            if (cityName == "ConfigureHRM") {
                //PlotSubtab1("PlotSubtab");
               
                //RefreshGridDetails();
                //PlotControls();
            }
            if (cityName == "ProjectMapping") {
                //$('#btnProjectMapping').css('display', 'none');
                //$('#panelProject').css('display', 'none');
                //$('#panelProjectAdd').css('display', 'none');
                //$('#CustomerContact').css('display', 'none');
                
                PlotSubtab1("ClientContact");            

                RefreshGrid('ClientContact');

                //RefreshGridDetails();
                PlotControls();
            }


        }
        var GlobalSubRequestTypeCaptionID;
        function Edit_ClientContact(obj, SubRequestTypeID, SubRequestTypeCaptionID) {
            GlobalSubRequestTypeCaptionID = SubRequestTypeCaptionID;
            $.ajax({
                type: "POST",
                url: "CRM_RequestSubType.aspx/GetCilentContactDetails",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ SubRequestTypeCaptionID: SubRequestTypeCaptionID }),
                success: function (data) {
                    var arrResult = data.d.split('##');

                    $('#FieldName').val(arrResult[0]);
                    $('#Caption').val(arrResult[1]);                                      
                    $('#collapseOne22').addClass("in");                  
                    $('#divCustomerContactcilent').css('display', 'none');
                    $("#plus").css("display", "none");
                    $("#minus").css("display", "block");


                    /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
                    if ($("#AddCaptionaccordion").hasClass("collapsed")) {
                        $("#AddCaptionaccordion").removeClass("collapsed");
                        $("#collapseOne22").css('height', 'auto');
                        $("#collapseOne22").css('width', 'auto');
                        $("#collapseOne22").addClass('in');

                    }
                    $("#panelProjectAdd").css("display", "block");                   
                    $("#panelProject").css("display", "block");
                    $("#CustomerContact").css("display", "block");
                }
            });

            $("[title]").click(function () {
                $('.ui-tooltip').fadeOut('fast', function () {
                    $('.ui-tooltip').remove();
                });
            });
        }
        function RefreshGridDetails() {
            //  debugger;
            var strResult, data;
            var GridParameter = {};
            var DivId;
            var DivSerach;

            DivId = "DivList";
            DivSerach = "SearchRquestType";

            var TypeDiv; var accordion;
            var intDivGridHeight

            //if (WhichBrowser() == "IE") {
            //    intDivGridHeight = (window.innerHeight / 2);

            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
            //        // alert('111');
            //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
            //        // alert('11');
            //        intDivGridListHeight = parseInt(window.innerHeight) - 200;
            //    }
            //    else {
            //        //alert('1');
            //        $('#divTypeStatus').css('height', " 700px");
            //        intDivGridListHeight = parseInt(window.innerHeight) - 130;
            //    }

            //    // alert('1');
            //    //alert(intDivGridListHeight - 500);
            //    //   $('.panel-body').css('height', intDivGridListHeight + "px");
            //    $('#divRequestTypes').css('height', intDivGridListHeight - 550 + "px");
            //    //$('#Type').css('height', " 400px");
            //    //$('#divTypeStatus').css('height', " 400px");
            //    // $('#Type').css('height', intDivGridListHeight + 500 + "px");
            //}
            //else {
            //    intDivGridHeight = (window.innerHeight / 2);
            //    // alert('2');
            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
            //        //alert('21');
            //        intDivGridListHeight = parseInt(window.innerHeight) - 350;

            //        $('#divRequestTypes').css('height', intDivGridListHeight - 150 + "px");

            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
            //        // alert('22');

            //        intDivGridListHeight = parseInt(window.innerHeight) - 440;

            //        $('#divRequestTypes').css('height', intDivGridListHeight - 110 + "px");
            //        // $('#Type').css('height', " 400px");
            //        $('#divTypeStatus').css('height', " 450px");
            //    }
            //    else {
            //        //alert('21');
            //        intDivGridListHeight = parseInt(window.innerHeight) - 590;
            //        //alert(intDivGridListHeight - 250)
            //        //$('#divRequestTypes').css('height', intDivGridListHeight - 340 + "px");
            //        //$('#Type').css('height', " 400px");
            //        // $('#divTypeStatus').css('height', " 400px");
            //    }
            //    // $('#divRequestTypes').css('height', intDivGridListHeight - 230 + "px");
            //    // $('#divTypeBottom').css('height', intDivGridListHeight + 70 + "px");
            //    //  $('.panel-body').css('height', intDivGridListHeight - 180 + "px");
            //    // alert(intDivGridListHeight-500);
            //    // $('#Type').css('height', " 400px");
            //    // $('#divTypeStatus').css('height', " 400px");

            //    //$('#Type').css('overflow-Y', 'auto');
            //    // $('#Type').css('overflow-X', 'hidden');
            //}


            var intDivGridHeight, intDivGridListHeight
            intDivGridListHeight = parseInt(window.innerHeight);
            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

                $("#divScrollSubType").css('height', intDivGridListHeight - 280 + "px");
            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

                $("#divScrollSubType").css('height', intDivGridListHeight - 320 + "px");
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                $("#divScrollSubType").css('height', intDivGridListHeight - 280 + "px");
            }
            else {
                $("#divScrollSubType").css('height', intDivGridListHeight - 280 + "px");
            }
         
            datatables(DivId, DivSerach, intDivGridListHeight);
            // setWidthDatatable("DivList");
            $(".FixedTD").css("top", "0px")
            $("#DivList1").scroll(function () {
                $(".FixedTD").css("top", $("#DivList1").scrollTop() - 1);
            });
        }
        function ValidateCilent() {
            var checkvalue = 0;
            var Flag = 0;
            var checkvalue = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            if ($("#FieldName").val() == "") {
                strmsg = '- Field Name should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                Flag = 1;
                checkvalue = 1;
                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                $("#FieldName").focus();
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            }


            if ($("#Caption").val() == "") {
                strmsg = '- Caption should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                Flag = 1;
                checkvalue = 1;

                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                var hasFocus = $('#FieldName').is(':focus');
                if (hasFocus) {

                }
                else {
                    $("#Caption").focus();
                }
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            }

            if (checkSpecialCharacter($('#FieldName').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- Field Name cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;

            }

            if (checkSpecialCharacter($('#Caption').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- Caption cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;

            }
             if (strmsg != "") {
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(errorMsg, 'error', 15);

             }
             return checkvalue;




         }
        function SaveCilentdetails() {
            if (ValidateCilent() == 0) {
                //if (document.getElementById('hdnCustomerCilentID').value == '') {
                //    CustomerCilentID = 0;

                //}
                //else {

                    CustomerCilentID = GlobalSubRequestTypeCaptionID;

                //}

                var Caption = $('#Caption').val();
                var FieldName = $('#FieldName').val();
                if (Caption == "" || Caption == undefined) {
                    Caption = "";
                }
                
                data = JSON.stringify({
                    Caption: Caption, CustomerCilentID: CustomerCilentID, EditSubRequestTypeID: EditSubRequestTypeID
                });
                
                strResult = AJAXCallWithResult("CRM_RequestSubType.aspx/SaveCilentContactDetails", data, false);
                if (strResult != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Caption Saved successfully', 'success');
                   
                    //$('#btnProjectMapping').css('display', 'none');
                    //$('#panelProject').css('display', 'none');
                    //$('#panelProjectAdd').css('display', 'none');
                    //$('#CustomerContact').css('display', 'none');
                    //$("#FieldName").val(FieldName);
                    //$("#Caption").val("0");

                    RefreshGrid('PlotSubtab');
                    //RefreshGrid('ClientContact', "Flag");
                }
            }


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
        function cancelCilent() {

            var FieldName = $("#FieldName").val("");
            var Caption = $("#Caption").val("");
           
            $("#divCustomerContactcilent").css("display", "block");
            // Cancel();
            /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
            if ($("#AddCaptionaccordion").hasClass("collapsed")) {
                $("#AddCaptionaccordion").removeClass("collapsed");
                $("#collapseOne22").css('height', 'auto');
                $("#collapseOne22").css('width', 'auto');
                $("#collapseOne22").addClass('in');

            }


        }
        function AddSubRequestType() {
            $("#divtblSubType").css("display", "none");
            $("#divSubTypeTab").css("display", "none");
            EditSubRequestTypeID = 0;
            $("#collapseOne2 .panel-body").css("height", "auto");
            $("#divSubTypeBottom").css("margin-top", "15px");

            $('#SubrequesttypeCode').val("");
            $('#Sub_requesttype').val("");
            //$('#Sub_WorkHrs').val("");
            $('#ChkAttachment').val("");
            //$('#SubrequestTasktype').val("");
            $('#txtGForRequestor').val("");
            $('#txtGForAssinee').val("");
            $('#SLAThRed').val("");
            $('#SLAThYellow').val("");

            /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
            if ($("#Addaccordion").hasClass("collapsed")) {
                $("#Addaccordion").removeClass("collapsed");
                $("#collapseOne2").css('height', 'auto');
                $("#collapseOne2").css('width', 'auto');
                $("#collapseOne2").addClass('in');

            }
        }
        function Cancel_SubType() {
            $("#divtblSubType").css("display", "block");
            $("#divSubTypeTab").css("display", "block");
            EditSubRequestTypeID = 0;
            //$("#collapseOne2 .panel-body").css("height", "150px");

            $('#SubrequesttypeCode').val("");
            $('#Sub_requesttype').val("");
            //$('#Sub_WorkHrs').val("");
            $('#ChkAttachment').val("");
            //$('#SubrequestTasktype').val("");
            $('#txtGForRequestor').val("");
            $('#txtGForAssinee').val("");
            $('#SLAThRed').val("");
            $('#SLAThYellow').val("");
            document.getElementById('ChkAttachment').checked = false;
            //RefreshGrid('Subtype', "Flag");
            RefreshGrid('Subtype');
            $("#divSubRequestType").html("");
            $("#idShowHistory").css('display', 'none');
            
            /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
            if ($("#Addaccordion").hasClass("collapsed")) {
                $("#Addaccordion").removeClass("collapsed");
                $("#collapseOne2").css('height', 'auto');
                $("#collapseOne2").css('width', 'auto');
                $("#collapseOne2").addClass('in');

            }
            /*End of Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
        }
        function DeleteMultiple_SubRequestType() {
            var table = $('#divGridSubRequestType table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();

            if (document.getElementById('chkAllDeleteSubType').checked == true) {
                //$("input[name=chkSubRequestTypeDelete]:not(:disabled)").prop('checked', true);
                $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
            }
            else {
                //$("input[name=chkSubRequestTypeDelete]").prop('checked', false);
                $('input[type="checkbox"]', rows).prop('checked', false);
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
        function Inherit_StatusFlow() {
            var FromSubRequest = $("#CbofrmSubRequest").val();
            var ToSubRequest = $("#CboToSubRequest").val();
            data = JSON.stringify({ FromSubRequest: FromSubRequest, ToSubRequest: ToSubRequest });

            strResult = AJAXCallWithResult("CRM_RequestSubType.aspx/InheritStatusFlow", data, false);
            if (strResult.d != "") {
                document.getElementById('id14').style.display = 'none';

            }
        }
        function Cancel_StatusFlow() {
            $("#CbofrmSubRequest").val("");
            $("#CboToSubRequest").val("");
        }
        function DeleteSubRequestType() {
            var strSubRequestTypeIDs;
            var table = $('#divGridSubRequestType table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();

            //strSubRequestTypeIDs = $('input[name=chkSubRequestTypeDelete]:checked').map(function () {
            //    return this.value;
            //}).get().join(',');
            //strSubRequestTypeIDs = $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true).map(function () {
            //    return this.value;
            //}).get().join(',');

            if (document.getElementById('chkAllDeleteSubType').checked == true) {
                strSubRequestTypeIDs = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                    return this.value;
                }).get().join(',');
            }
            else {
                //strSubRequestTypeIDs = $('input[name=chkSubRequestTypeDelete]:checked').map(function () {
                //    return this.value;
                //}).get().join(',');
                strSubRequestTypeIDs = arrSelectedCheck.join();
            }
            //alert(strSubRequestTypeIDs);

            if (strSubRequestTypeIDs.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please select at least one Sub Type for deletion', 'error');
                return;
            }

            data = JSON.stringify({ SubRequestTypeID: strSubRequestTypeIDs });

            strResult = AJAXCallWithResult("CRM_RequestSubType.aspx/DeleteSubRequestType", data, false);
            //RefreshGrid('Subtype', "Flag");
            //Commented and Added by Usha Pandit on 17.05.2019 for Refresh Issue after Delete Sub Request Type
            //RefreshGrid('Subtype');
            RefreshGrid('SubType');
            //End of Added by Usha Pandit on 17.05.2019 for Refresh Issue after Delete Sub Request Type

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Sub Type deleted successfully', 'success');
        }
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

        function openCity(evt, cityName) {

            //alert(cityName);
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
            //  debugger;

            setFrameLoader();
            //  $('[data-toggle="tooltip"]').tooltip();
            PlotControls();

        });

        $(window).load(function () {

            RemoveFrameLoader();

        });




        function ShowHistory() {
            //alert(EditPriorityID);
            var obj = { "UniqueID": EditSubRequestTypeID };
            var myJSON = JSON.stringify(obj);
            var url = "CRM_RequestSubType.aspx/ShowMailHistoryDetails"

            var result = AJAXCallWithResult(url, myJSON, false)
            //alert(EditSubRequestTypeID);
            //alert(result);
            if (EditSubRequestTypeID == undefined || EditSubRequestTypeID == 0)
            {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please select atleast one entry..', 'error');
            }
            else {

                $("#ShowHistory #Div2").html(result.d);
                document.getElementById('ShowHistory').style.display = 'block';
            }
            datatables("ShowHistoryGrid", 'SearchRquestType', "");
           // ModifiedFieldFilter_Change();
        }
        function ModifiedFieldFilter_Change() {

            var ModifiedField = $('#cboModifiedField :selected').text();
            var ModifiedBy = $('#cboModifiedBy :selected').text();

            var obj = { "newModifiedField": ModifiedField, "MessageID": EditSubRequestTypeID, "newModifiedBy": ModifiedBy };
            var myJSON = JSON.stringify(obj);

            var url = "CRM_RequestSubType.aspx/FilteredHistory"
            var result = AJAXCallWithResult(url, myJSON, false)
            $("#ShowHistory #Div2").html(result.d);
            document.getElementById('ShowHistory').style.display = 'block';
            datatables("ShowHistoryGrid", 'SearchRquestType', "");
        }
        function close_onclick() {
            document.getElementById('ShowHistory').style.display = 'none';
        }






        //Added by Usha Pandit on 20.12.2017 for modal popup of ConfigureStatusFlow

        var curSubRequestTypeID, curSubRequestType;
        var tblConfigStatus;
        function closeStatusFlowDiv_onclick() {
            //debugger;
            document.getElementById('divConfigureStatusFlow').style.display = 'none';

            //RefreshGrid("SubType");
        }
        function ConfigureStatusFlow(obj, SubRequestTypeID, SubRequestType) {
            //debugger;
            setFrameLoader();
           // $(".loadingoverlay", parent.document).css("display", "block");
            curSubRequestTypeID = SubRequestTypeID;
            curSubRequestType = SubRequestType;
            theaddata = '';
            //theadcount = 0;

            //var dt = ""
            var url = "CRM_RequestSubType.aspx/getConfigureData"
            //var result = AJAXCallWithResult(url, dt, false)
            //data = JSON.stringify({ DepartmentID: entity });
            CustomAJAXCall(url, "", BindDropDownStatusFlow);
            $(".loadingoverlay", parent.document).css("display", "none");

            $("#Spanconfiguration").html( SubRequestType + " >> Configure Status Flow")

        }
        function checkActiveStatusOfStatusFlow(SubRequestTypeID, FromStatus, ToStatus, FromStatusID, ToStatusID) {
            //debugger;

            var result = false;
            var data = JSON.stringify({ SubRequestTypeID: SubRequestTypeID, FromStatusID: FromStatusID, ToStatusID: ToStatusID, FromStatus: FromStatus, ToStatus: ToStatus });

            strResult = AJAXCallWithResult("CRM_RequestSubType.aspx/getStatusFlowActiveStatus", data, false);

            if (strResult.d != null) {
                result = true;
            }
            else {
                result = false;
            }
            return result;
        }
        function BindDropDownStatusFlow(result) {
            //debugger;
            try {
                var strArray = String(result.d).split("|")


                var i = 0;
                var newrowflag = 0;
                var currow = "";

                //if (tblConfigStatus != undefined)
                //    tblConfigStatus.destroy();
                $("#tblConfigureStatus thead").empty();
                $("#tblConfigureStatus tbody").empty();
                $("#tblConfigureStatus").html("<thead ></thead><tbody></tbody>");

                var theaddata = "<tr style='font-weight:normal;' class='imgcontainer'>";
                var tbodydata;

                $.each(JSON.parse(strArray[0]), function (id, obj) {
                   
                    var originalFromStatus = obj.FromStatus;
                    var originalToStatus = obj.ToStatus;
                    obj.FromStatus = obj.FromStatus.substring(obj.FromStatus.indexOf(".") + 1);
                    obj.FromStatus = obj.FromStatus.trim();
                    obj.ToStatus = obj.ToStatus.substring(obj.ToStatus.indexOf(".") + 1);
                    obj.ToStatus = obj.ToStatus.trim();
                    if (originalFromStatus != currow) {
                        //newrowflag = 0;


                        currow = originalFromStatus;

                        tbodydata += "</tr>";
                        tbodydata += "<tr>";

                        if (i == 0) {
                            theaddata += "<th class='FixedTD'></th>";
                            theaddata += "<th style='font-weight:normal;font-size: 12px;' class='FixedTD'>" + obj.FromStatus + "</th>";
                        }
                        else {
                            theaddata += "<th style='font-weight:normal;font-size: 12px;' class='FixedTD'>" + obj.FromStatus + "</th>";
                        }


                        tbodydata += "<td>" + obj.FromStatus + "</td>";
                    }
                    else {
                    }

                    if (obj.FromStatusID == obj.ToStatusID) {
                        tbodydata += "<td>" + "<input type=checkbox disabled name='chkStatusFlowSelect' id='chkStatusFlowSelect' title='select' value = " + "&quot;" + curSubRequestTypeID + "&quot;|&quot;" + curSubRequestType + "&quot;|" + obj.FromStatusID + "|" + obj.ToStatusID + "|&quot;" + obj.FromStatus + "&quot;|&quot;" + obj.ToStatus + "&quot;" + "/>" + "</td>";
                    }
                    else {
                        if (checkActiveStatusOfStatusFlow(curSubRequestTypeID, obj.FromStatus, obj.ToStatus, obj.FromStatusID, obj.ToStatusID) == true) {
                            //alert("&quot;" + curSubRequestTypeID + "&quot;|&quot;" + curSubRequestType + "&quot;|" + obj.FromStatusID + "|" + obj.ToStatusID + "|&quot;" + obj.FromStatus + "&quot;|&quot;" + obj.ToStatus + "&quot;");
                            tbodydata += "<td>" + "<input type=checkbox name='chkStatusFlowSelect' id='chkStatusFlowSelect' title='select' value = '" + "&quot;" + curSubRequestTypeID + "&quot;|&quot;" + curSubRequestType + "&quot;|" + obj.FromStatusID + "|" + obj.ToStatusID + "|&quot;" + obj.FromStatus + "&quot;|&quot;" + obj.ToStatus + "&quot;" + "' checked />" + "</td>";
                        }
                        else {
                            tbodydata += "<td>" + "<input type=checkbox name='chkStatusFlowSelect' id='chkStatusFlowSelect' title='select' value = '" + "&quot;" + curSubRequestTypeID + "&quot;|&quot;" + curSubRequestType + "&quot;|" + obj.FromStatusID + "|" + obj.ToStatusID + "|&quot;" + obj.FromStatus + "&quot;|&quot;" + obj.ToStatus + "&quot;'" + "/>" + "</td>";
                        }
                    }

                    i = i + 1;
                });
                theaddata += "</tr>";

                $("#tblConfigureStatus thead").html(theaddata);

                $("#tblConfigureStatus tbody").html(tbodydata);


                //tblConfigStatus = $('#tblConfigureStatus').DataTable({
                //    responsive: true,
                //    "bPaginate": false,
                //    //scrollY: '130px',
                //    ordering: false,
                //    pagingType: "simple_numbers"
                //});
                //datatablesconfigurestatusflow("tblConfigureStatus", "", "");

                document.getElementById('divConfigureStatusFlow').style.display = 'block';
                RemoveFrameLoader();
            }
            catch (ex) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(ex.message, 'error');
                RemoveFrameLoader();
            }

            //alert(i);
        }
        function SaveConfigureStatusDetails() {

            try {
                deleteExistingConfigurationDetails();
                var strCheckedStatusFlow;
                strCheckedStatusFlow = $('input[id=chkStatusFlowSelect]:checked').map(function () {
                    return this.value;
                }).get().join(',');

                $("input[id=chkStatusFlowSelect]:checked").each(function () {
                    //alert($(this).val());
                    //if ($(this).text() == $("#txtDepartment").val()) {
                    //    CurDepartment = $(this).val()
                    //    $("#cboRequestMapDepartment").val($(this).val());
                    //}
                });
                var arrCheckedStatusFlow = strCheckedStatusFlow.split(",");
                var arrLenCheckedStatusFlow = arrCheckedStatusFlow.length;
                for (var i = 0; i < arrLenCheckedStatusFlow; i++) {
                    //alert(arrRequestSubRequestApprove[i]);
                    arrCheckedStatusFlow[i] = arrCheckedStatusFlow[i].replace(/\\\//g, "/");
                    var arrStatusFlowParam = arrCheckedStatusFlow[i].split("|");
                    var arrayLenStatusFlowParam = arrStatusFlowParam.length;
                    //for (var j = 0; j < arrayLenStatusFlowParam; j++) {

                    insertActiveConfigurationDetails(arrStatusFlowParam[0], arrStatusFlowParam[1], arrStatusFlowParam[2], arrStatusFlowParam[3], arrStatusFlowParam[4], arrStatusFlowParam[5]);
                    //}
                    //break;
                }

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Status Flow Saved successfully', 'success');
            }
            catch (ex) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(ex.message, 'error');
            }
            //alert(strCheckedStatusFlow);

        }
        function insertActiveConfigurationDetails(SubRequestTypeID, SubRequestType, FromStatusID, ToStatusID, FromStatus, ToStatus) {


            data = JSON.stringify({ SubRequestTypeID: SubRequestTypeID, SubRequestType: SubRequestType, FromStatusID: FromStatusID, ToStatusID: ToStatusID, FromStatus: FromStatus, ToStatus: ToStatus });
            var strResult = AJAXCallWithResult("CRM_RequestSubType.aspx/SaveStatusFlowNewDetails", data, false);

        }
        function deleteExistingConfigurationDetails() {
            try {
                data = JSON.stringify({ SubRequestTypeID: curSubRequestTypeID });

                strResult = AJAXCallWithResult("CRM_RequestSubType.aspx/DeleteStatusFlowExistingDetails", data, false);
            }
            catch (ex) {
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
                async: true,
                success: function (result) {
                    method(result);
                    //Stop();
                },
                error: function (xhr, status, error) {
                    // Stop();
                    //  StopAjaxLoader("body");
                    console.log(xhr.responseText);
                   // window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });
        }

        //End of Added by Usha Pandit on 20.12.2017 for modal popup of ConfigureStatusFlow
    </script>
</head>

</html>

