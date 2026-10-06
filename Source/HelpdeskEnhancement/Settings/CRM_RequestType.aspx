.css"<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_RequestType.aspx.vb" Inherits="PbNIT.CRM_RequestType" %>

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

    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />


     <!-- Bootstrap core JavaScript -->
<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>

<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>



    <%--<script src="js/editor.js"></script>--%>
    <script src="../../../EnhancementFiles/js/editor.js"></script>

    <%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>
    <%--<script src="../../../EnhancementFiles/OnlineFiles/js/jquery/1.12.1/jquery-ui.js"></script>--%>

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
        .clsbuttonLinks .fa-plus {
            display:block!important;
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
             margin: 5px 0px !important;
           
            /*margin: 4px 214px !important;
            WIDTH:103%*/
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

        /*#divSubRequestType .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }*/

        

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
            /* Added By Usha Pandit on 15.12.2017 for search box alignment*/
            /*  position: absolute;
            margin-top: 13px;
            margin-left: 10px;*/
            /*position: absolute;
            margin-top: 7px!important;
            margin-left: 5px!important;*/
            /* End of addition Usha Pandit on 15.12.2017*/
        }

        .clsSettingstabs {
            margin-top: -13px;
        }

        /*'/*commented by Kashish for ui change*/
        /*.form-horizontal .form-group {
            line-height: 3;
        }*/

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

        .tabcontent1 {
            border: none !important;
        }

        #Type {
            width: 100%;
            overflow: hidden;
        }

        #divScroll {
            width: 102%;
            padding-right: 2%;
            overflow: auto;
        }

        .dataTables_scrollBody .clsTRColumnHeader {
            height: 0px !important;
        }

        .type-top-bar {
            /*padding-right:5px!important;*/
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

        #divSubRequestType .clsTRColumnHeader TH:nth-child(2) {
            text-align: center;
        }

        /* Added By Usha Pandit on 15.12.2017*/

        .bottom-bar textarea {
            border-color: #bbb;
        }

        /*'/*commented by Kashish for ui change*/
        /*.form-group {
            margin-bottom: 1%!important;
        }*/

        #divList td, #divSubRequestType td  {
            border: none !important;
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
        }

        .edit-bt {
            outline: none;
        }

        #SearchRquestType {
            outline: none;
        }

        dataTables_paginate {
            margin: 0;
            white-space: nowrap;
            text-align: right;
        }

        dataTables_info {
            float:left!important;
        }
       
        /* End of addition Usha Pandit on 15.12.2017*/
        #isSaveandAdd{
        float: right;
        margin-top: 5px;
        margin-left: 5px;
        display:block;
        background-color:white!important;
        color:white;
    }

        .container-fluid {
            min-height:0px!important;
        }


       #divSubRequestType .dataTables_paginate{
        margin-top: -6%!important;
    
    }

    #divSubRequestType .dataTables_info{
        margin-top: -6%!important;
    
    }

    .panel-body ul li {
        background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
        font-size: 17px;
        font-weight: 300;
        line-height: 28px;
        list-style: outside none none;
        padding-bottom: 5px;
        padding-left: 1px!important;
        padding-top: 4px!important;
        position: relative;
}

:-ms-input-placeholder { /* IE 10+ */
  color: #bbb!important;
}
 #idPlus {
            display:inline-block !important;
        }
    </style>

    <body class="" id="page-top">

        <!-- Navigation -->

        <!----------------------------  Tabs----------------------------->
        <%WriteTabsControls("", "Load", "")%>
    </body>
    <!-- ----- Request Type inherit status flow button popup---------------------------->
    <div id="id14" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Inherit Status Flow</span>
                <span onclick="document.getElementById('id14').style.display='none'" class="close" title="Close Modal">&times;</span>
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
                        <button type="button" class="btn btn-default save" onclick="Inherit_StatusFlow()" style="background-color: #343660; color: #fff;">Inherit</button>
                        <button type="button" class="btn btn-default save" onclick="Cancel_StatusFlow()" style="background-color: #fff; color: #343660;">Cancel</button>
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
        var strPageName = "CRM_RequestType.aspx";
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
            RefreshGridDetails();
            //PlotControls(cityName, Flag);

            evt.currentTarget.className += " active";
        }

        // Get the element with id="defaultOpen" and click on it
        //   document.getElementById("defaultOpen1").click();


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

            if (WhichBrowser() == "IE") {

                intDivGridHeight = (window.innerHeight / 2);

                /* Added by Usha pandit on 15.12.2017 to minimize sub Type grid height */
                if ((parseInt(window.innerHeight) <= 850 && parseInt(window.innerWidth) <= 1072)) {
                    //alert(intDivGridHeight);
                    //alert(window.innerHeight);
                    //alert(window.innerWidth);
                    intDivGridListHeight = parseInt(window.innerHeight) - 500;
                    $('#divRequestTypes').css('height', intDivGridListHeight - 120 + 'px');
                    $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');

                }
                    /* End of addition by Usha pandit */

                else if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

                    intDivGridListHeight = parseInt(window.innerHeight) - 500;
                    $('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');
                    $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
                }

                else if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024)) {

                    intDivGridListHeight = parseInt(window.innerHeight) - 355;
                    $('#divRequestTypes').css('height', intDivGridListHeight - 150 + 'px');
                    $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
                }
                else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                    intDivGridListHeight = parseInt(window.innerHeight) - 200;
                    $('#divRequestTypes').css('height', intDivGridListHeight - 550 + 'px');
                    $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
                }
                else {

                    intDivGridListHeight = parseInt(window.innerHeight) - 145;


                    /* Commented and added by Usha pandit on 15.12.2017 to minimize sub Type grid height */
                    // $('#divRequestTypes').css('height', intDivGridListHeight - 550 + 'px');
                    //alert(intDivGridListHeight);
                  //  $('#divRequestTypes').css('height', intDivGridListHeight - 650 + 'px');

                    /* End of addition by Usha pandit */


                    $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
                }

            }
            else {
                intDivGridHeight = (window.innerHeight / 2);

                if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
                    intDivGridListHeight = parseInt(window.innerHeight) - 370;
                    //alert(intDivGridListHeight);

                    /* Commented and added by Usha pandit on 15.12.2017 to minimize sub Type grid height */
                    // $('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');

                   // $('#divRequestTypes').css('height', intDivGridListHeight - 220 + 'px');

                    /* End of addition by Usha pandit */


                    $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
                }

                else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

                    intDivGridListHeight = parseInt(window.innerHeight) - 360;

                   // $('#divRequestTypes').css('height', intDivGridListHeight - 140 + 'px');

                    $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
                }
                else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                    intDivGridListHeight = parseInt(window.innerHeight) - 470;

                   // $('#divRequestTypes').css('height', intDivGridListHeight - 80 + 'px');

                    $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
                }
                else {

                    intDivGridListHeight = parseInt(window.innerHeight) - 580;

                    /* Commented and added by Usha pandit on 15.12.2017 to minimize sub Type grid height */
                    //$('#divRequestTypes').css('height', intDivGridListHeight - 180 + "px");

                   // $('#divRequestTypes').css('height', intDivGridListHeight - 250 + 'px');

                    /* End of addition by Usha pandit */


                    $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
                }



                //    $('#Type').css('height', intDivGridListHeight + 500  + "px");
            }

            //   $(".table-responsive:first table").addClass("table");
            $("#frmType").css("width", "102%");
            $("#frmType .right").css("margin-right", "20px");
            $(".container-fluid").css("min-height", "0%!important");
           
            datatables(DivId, DivSerach, intDivGridListHeight);

            
            setWidthDatatable("DivList");

        }
        //    function RefreshGridDetails() {
        ////  debugger;
        //        var strResult, data;
        //        var GridParameter = {};
        //            var DivId;
        //            var DivSerach;

        //            DivId = "DivList";
        //            DivSerach = "SearchRquestType";

        //        var TypeDiv; var accordion;
        //        var intDivGridHeight

        //        if (WhichBrowser() == "IE") {
        //            intDivGridHeight = (window.innerHeight / 2);

        //            if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) ) {
        //                intDivGridListHeight = parseInt(window.innerHeight) - 355;
        //                $('#divRequestTypes').css('height', intDivGridListHeight - 150 + "px !important");
        //            }
        //            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //              intDivGridListHeight = parseInt(window.innerHeight) - 200;
        //            }
        //            else {
        //              intDivGridListHeight = parseInt(window.innerHeight) - 130;
        //            }


        //            $('#divRequestTypes').css('height', intDivGridListHeight - 550 + "px");

        //        }
        //        else {
        //            intDivGridHeight = (window.innerHeight / 2);
        //           // alert(parseInt(window.innerWidth))
        //            if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

        //                intDivGridListHeight = parseInt(window.innerHeight)-380;

        //                $('#divRequestTypes').css('height', intDivGridListHeight - 130 + "px");
        //                $('#Type').css('height', intDivGridListHeight + 500 + "px !important");

        //            }
        //            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

        //                intDivGridListHeight = parseInt(window.innerHeight) - 450;

        //                $('#divRequestTypes').css('height', intDivGridListHeight - 80 + "px");
        //                $('#Type').css('height', intDivGridListHeight + 500 + "px !important");

        //            }
        //            else {

        //                intDivGridListHeight = parseInt(window.innerHeight) -605;

        //                $('#divRequestTypes').css('height', intDivGridListHeight - 150 + "px");
        //                $('#Type').css('height', intDivGridListHeight + 800 + "px !important");

        //            }



        //        //    $('#Type').css('height', intDivGridListHeight + 500  + "px");
        //        }

        //     //   $(".table-responsive:first table").addClass("table");
        //        datatables(DivId, DivSerach, intDivGridListHeight);
        //        setWidthDatatable("DivList");

        //    }
        function RefreshGrid(cityName, Flag) {
            var strResult, data;
            var GridParameter = {};

            GridParameter.cityName = "Type";
            cityName = "Type";

            if (Flag != "") {
                data = JSON.stringify({ GridParameter: GridParameter });

                strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
                var DivId;
                var DivSerach;
                //  alert(strResult.d);
                if (strResult.d != '') {

                    DivId = "DivList";
                    DivSerach = "SearchRquestType";

                    $("#divRequestTypes").html("");
                    $("#divRequestTypes").html(strResult.d);

                    $(".table-responsive:first table").addClass("table");


                }

            }
            RefreshGridDetails();
        }
        // $(".table-responsive tbody").css("overflow", "auto");
        // $(".table-responsive").css("height", intDivGridListHeight + "px");

        //   }


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
                //scrollY: '115px',
                //scrollX: true,            
                "sDom": '<"row view-filter"<"col-sm-12"<"pull-right"l><"pull-right"f><"clearfix">>>t<"row view-pager"<"col-sm-12"<"text-center"ip>>>'
                //language: {
                //    paginate: {
                //        first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
                //        next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
                //        previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
                //        last: '<i class="fa fa-angle-right" title="Last"></i>'
                //    }
                //},
            });




            $(".dataTables_info").css("float", "left");
            $(".dataTables_paginate").css("float", "right");

            $(".pagination").css("float", "right");
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
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' > table').DataTable({
                responsive: true,
                "pageLength": 3,
               // scrollY: '115px',
                pagingType: "simple_numbers",
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
                scrollX: true                
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

                if ($('#' + txtBoxID).val() != "") {
                    table.search($('#' + txtBoxID).val()).draw();
                    //table.refresh();
                }
            }

            //$("#divSubRequestType").find(".dataTables_wrapper").find(".dataTables_paginate").css("padding-right", "0px");
                //.find("dataTables_paginate ").removeClass(".col-md-7").addClass(".col-md-8");
            //alert($(".col-md-7").parents("#divSubRequestType").length);
            //alert($(".dataTables_paginate").parents(".col-md-7").parents("#divSubRequestType").length);
            //alert($(".pagination").parents("#divSubRequestType").length);
            //if ($(".col-md-7").parents("#divSubRequestType").length == 1) {
            //    alert(1);
            //    // YES, the child element is inside the parent

            //} else {
            //    alert(1);
            //    // NO, it is not inside

            //}
        }

        //function datatables(divID, txtBoxID) {
        //    $('#' + divID + ' > table').removeClass("clsGridTable");
        //    $('#' + divID + ' table').addClass("table table-bordered ");
        //    var table = $('#' + divID + ' > table').DataTable({

        //        responsive: true, "pageLength": "10",
        //        scrollY: '130px',
        //        pagingType: "simple",
        //        scrollX: true,
        //        language: {
        //            paginate: {
        //                first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
        //                next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
        //                previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
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
            RefreshGrid(TabName, Flag);
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
            //debugger;
            var chkVal = 0;
            var RequestType = $("#requesttype").val();
            var RequestTypeCode = $("#requesttypecode").val();
            var strMsg = "";
            /* Added By Usha Pandit on 15.12.2017 for required field*/
            if ($("#requesttypecode").val() == "") {
                //  alertify.set('notifier', 'position', 'top-right');
                // alertify.notify('Request Type should not be left blank', 'error');
                // strmsg = strmsg + 'Request Type should not be left blank';
                strMsg += "<li>- Request Type Code should not be left blank </li> ";
                chkVal = 1;
            }
            /* End of addition Usha Pandit on 15.12.2017*/
            if ($("#requesttype").val() == "") {
                //  alertify.set('notifier', 'position', 'top-right');
                // alertify.notify('Request Type should not be left blank', 'error');
                // strmsg = strmsg + 'Request Type should not be left blank';
                strMsg += "<li>- Request Type should not be left blank </li> ";
                chkVal = 1;
            }


            if (RequestType != "") {
                data = JSON.stringify({ RequestType: RequestType, RequestTypeCode: "", Flag: "RequestType", RequestTypeID: EditRequestTypeID });
                var strResult1 = AJAXCallWithResult("CRM_RequestType.aspx/IsDuplicateRequestType", data, false);
                //alert(EditRequestTypeID);
              
                if (strResult1.d == "1")
                {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify('Request Type is already exists', 'error');
                        //  strmsg = strmsg + 'Request Type already exists';
                        strMsg += "<li>- Request Type already exists </li>";
                        chkVal = 1;

                    }
                }
            

            if (RequestTypeCode != "") {
                data = JSON.stringify({ RequestType: "", RequestTypeCode: RequestTypeCode, Flag: "RequestTypeCode", RequestTypeID: EditRequestTypeID });
                var strResult1 = AJAXCallWithResult("CRM_RequestType.aspx/IsDuplicateRequestType", data, false);
                //alert(EditRequestTypeID);
              

                    if (strResult1.d == "1") {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify('Request Type is already exists', 'error');
                        //  strmsg = strmsg + 'Request Type already exists';
                        strMsg += "<li>- Request Type Code already exists </li>";
                        chkVal = 1;

                   

                }
            }

            //   strMsg = strMsg.substr(0, strMsg.length - 1);

            if (strMsg != "") {

                alertify.set('notifier', 'position', 'top-right');
                // alertify.notify(strmsg, 'error');
                alertify.notify("<ul>" + strMsg + "</ul>", 'error');
            }
            return chkVal;
        }

        function SaveRequestType_Onclick(flag) {
            //debugger;
            if (ValidateRequestType() == 0) {

                var RequestType = $("#requesttype").val();
                var RequestTypeCode = $("#requesttypecode").val();

                // if (strResult1 == 0) {

                // var SubRequestType = $("#Subrequesttype").val();
                //  data = JSON.stringify({ RequestType: RequestType, SubRequestType: SubRequestType, RequestTypeCode: RequestTypeCode,RequestTypeID:"0"});
                data = JSON.stringify({ RequestType: RequestType, RequestTypeCode: RequestTypeCode, RequestTypeID: EditRequestTypeID });
                //  alert(data);
                strResult = AJAXCallWithResult("CRM_RequestType.aspx/SaveRequestType", data, false);
                if (strResult.d != "") {
                    //alert(strResult.d);

                    var NewRequestTypeID = strResult.d;
                    $("#divRequestTypes").css("display", "block");
                    $(".type-top-bar").css("display", "block");
                    $("#RequestPaging").css("display", "block");

                  

                    if (EditRequestTypeID == 0)
                    {

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Request Type saved successfully', 'success');
                    }
                    else {

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Request Type details updated successfully', 'success');
                    }
                  
                    RefreshGrid("Type", "Flag");
                    $("#divRequestTypes").css("display", "block");
                   // $("#divSubRequestType").css("visibility", "hidden");

                if (flag == "SaveAdd")
                {

                       
                      
                    Cancel_RequestType();
                       
                    }
                else
                    {
                       
                      Edit_RequestType(NewRequestTypeID);
                    }
                       
                        
                        
                       
                   /// }
                }
                // }
            }
        }


        function SaveAndAddRequestType_Onclick(flag)
        {
           
            SaveRequestType_Onclick(flag);
            $("#divRequestTypes").css("display", "none");
            $("#divTypeTab").css("display", "none");
            $("#RequestPaging").css("display", "none");
            $("#frmType").css("width", "102%");
            $("#frmType .right").css("margin-right", "20px");
            $("#divTypeBottom").css("margin-top", "15px");
            //$("#requesttypecode").val("");
            //$("#requesttype").val("");

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
            strResult = AJAXCallWithResult("CRM_RequestType.aspx/MapSubRequestType", data, false);
            if (strResult.d != "") {

                if (strResult.d == '1') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sub Type mapped successfully', 'success');
                }
                if (strResult.d == '0') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sub Type unmapped successfully', 'success');
                }
                //var strResult1, data1;

                //data1 = JSON.stringify({ RequestTypeID: RequestTypeID });

                //strResult1 = AJAXCallWithResult(strPageName + "/PlotSubRequestType", data1, false);

                //if (strResult1.d != '') {
                //    $("#divSubRequestType").html(strResult1.d);
                //    $("#divSubRequestType").addClass("table");
                //    $("#divSubRequestType").css("display", "block");

                //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                //        intDivGridListHeight = parseInt(window.innerHeight) - 350;

                //    }
                //    else {

                //        //  intDivGridListHeight = (window.innerHeight / 3) + 6;
                //        intDivGridListHeight = parseInt(window.innerHeight) - 500;
                //    }

                //    //datatableMainPage("divSubRequestType", intDivGridListHeight);
                //    //datatables("divSubRequestType", "", intDivGridListHeight);
                //}

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
                var strResult1 = AJAXCallWithResult("CRM_RequestType.aspx/IsDuplicateSubRequestType", data, false);
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
                strResult = AJAXCallWithResult("CRM_RequestType.aspx/SaveSubRequestType", data, false);
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
                    //   $("#collapseOne2 .panel-body").css("height", "150px");
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
        function Edit_RequestType(RequestTypeID) {
            EditRequestTypeID = RequestTypeID;
            //  if (obj.checked) {
            //Do stuff  
            //  var RequestTypeIDs = $(this).val();
         //   alert(RequestTypeID);
            Flag = 1;
            $.ajax({
                type: "POST",
                url: "CRM_RequestType.aspx/GetRequestTypeDetails",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ RequestTypeID: RequestTypeID }),
                success: function (data) {
                    var arrResult = data.d.split('##');
                    // $('#requesttype').val(arrResult[0]);
                    $('#requesttypecode').val(arrResult[1]);
                    $('#requesttype').val(arrResult[2]);
                    
                  //  $('#frmType').append(arrResult[3]);

                    var strResult1, data1;

                    data1 = JSON.stringify({ RequestTypeID: arrResult[0] });

                    strResult1 = AJAXCallWithResult(strPageName + "/PlotSubRequestType", data1, false);

                    if (strResult1.d != '') {
                        document.getElementById('tblSubRequestType').innerHTML = "";
                        //$("#divSubRequestType").html(strResult1.d);
                        document.getElementById('tblSubRequestType').innerHTML = strResult1.d;
                        $("#divSubRequestType").addClass("table");
                        $("#divSubRequestType").css("display", "block");
                        if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                            intDivGridListHeight = parseInt(window.innerHeight) - 250;

                        }
                        else {
                            //  intDivGridListHeight = (window.innerHeight / 3) + 6;
                            intDivGridListHeight = parseInt(window.innerHeight) - 600;
                        }

                        //datatableMainPage("divSubRequestType", intDivGridListHeight);
                        datatables("divSubRequestType", "", intDivGridListHeight);
                        // $("#idPanelBody").css("overflow", "auto");
                        // $("#idPanelBody").css("width", "102%");
                        // $("#idPanelBody").css("padding-right", "2%");
                        //var bodyHeight = window.innerHeight - $('#MainDiv').offset().top;
                        //  alert(bodyHeight);
                        // $('#idPanelBody').css('height', intDivGridListHeight +500 + 'px');
                        $("#divRequestTypes").css("display", "none");
                        $("#divTypeTab").css("display", "none");
                        $("#RequestPaging").css("display", "none");
                        //$("#accordion").css("height", intDivGridListHeight + "px");
                        // $("#divSubRequestType").css("height", intDivGridListHeight - 250 + "px");
                        //  $(".dataTables_scrollBody").css("height", intDivGridListHeight  + "px");
                        //   $("#divSubRequestType").css("overflow", "auto");
                        $("#collapseOne").css("width", "100%");
                        $("#collapseOne").css("overflow", "hidden");
                        //   $("#collapseOne").css("height", intDivGridListHeight + 500 + "px");
                        $("#frmType").css("width", "102%");
                        $("#frmType .right").css("margin-right", "20px");
                        $("#divTypeBottom").css("margin-top", "15px");



                        /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
                        if ($("#Addaccordion").hasClass("collapsed")) {
                            $("#Addaccordion").removeClass("collapsed");
                            $("#collapseOne").css('height', 'auto');
                            $("#collapseOne").css('width', 'auto');
                            $("#collapseOne").addClass('in');
                        
                        }
                      
                    /*End of Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
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
        function AddRequestType() {
            $("#divRequestTypes").css("display", "none");
            $("#divTypeTab").css("display", "none");
            // $("#RequestPaging").css("display", "none");
            //  $("#divTypeBottom").css("margin-top", "0px");
            $("#divTypeBottom").css("margin-top", "15px");
            $("#requesttypecode").val("");
            $("#requesttype").val("");
            EditRequestTypeID = 0;

            /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
            if ($("#Addaccordion").hasClass("collapsed")) {
                $("#Addaccordion").removeClass("collapsed");
                $("#collapseOne").css('height', 'auto');
                $("#collapseOne").addClass('in');
            }
        }
        /*End of Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/


        
        function Cancel_RequestType() {
            // alert(Flag);
            EditRequestTypeID = 0
            $("#divRequestTypes").css("display", "block");
            $("#divTypeTab").css("display", "block");
            $("#divTypeBottom").css("display", "block");
            $("#RequestPaging").css("display", "block");
            $("#divSubRequestType").css("display", "none");
            $("#requesttypecode").val("");
            $("#requesttype").val("");
            $("#divTypeBottom").css("margin-top", "0px");
            RefreshGrid('Type', "Flag");



            /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
            if ($("#Addaccordion").hasClass("collapsed")) {
                $("#Addaccordion").removeClass("collapsed");
                $("#collapseOne").css('height', 'auto');
                $("#collapseOne").addClass('in');
            }
        }
        /*End of Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
    
        function DeleteRequestType() {
            var strRequestTypeIDs;
            var table = $('#DivList table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();

            //strRequestTypeIDs = $('input[name=chkRequestTypeDelete]:checked').map(function () {
            //    return this.value;
            //}).get().join(',');
            //strRequestTypeIDs = $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true).map(function () {
            //    return this.value;
            //}).get().join(',');

            if (document.getElementById('chkAllDeleteType').checked == true) {
                strRequestTypeIDs = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                    return this.value;
                }).get().join(',');
            }
            else {
                strRequestTypeIDs = $('input[name=chkRequestTypeDelete]:checked').map(function () {
                    return this.value;
                }).get().join(',');
            }

            if (strRequestTypeIDs.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(' - Please select at least one Type for deletion', 'error');
                return;
            }
            data = JSON.stringify({ RequestTypeID: strRequestTypeIDs });

            strResult = AJAXCallWithResult(strPageName + "/DeleteRequestType", data, false);
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Type deleted successfully', 'success');
            RefreshGrid("Type", "Flag");

        }
        function DeleteMultiple_RequestType() {
            var table = $('#DivList table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();

            if (document.getElementById('chkAllDeleteType').checked == true) {
                //$("input[name=chkRequestTypeDelete]:not(:disabled)").prop('checked', true);
                $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
            }
            else {
                //$("input[name=chkRequestTypeDelete]").prop('checked', false);
                $('input[type="checkbox"]', rows).prop('checked', false);
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
            RefreshGrid('Subtype', "Flag");

        }
        function DeleteMultiple_SubRequestType() {
            if (document.getElementById('chkAllDeleteSubType').checked == true) {
                $("input[name=chkSubRequestTypeDelete]:not(:disabled)").prop('checked', true);
            }
            else {
                $("input[name=chkSubRequestTypeDelete]").prop('checked', false);
            }
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
            //$('[data-toggle="tooltip"]').tooltip();
            RefreshGridDetails();
            
            //$("#DataTables_Table_1_wrapper").find("div .col-md-7").removeClass(".col-md-7").addClass(".col-md-8");
        });

        $(window).load(function () {

            RemoveFrameLoader();
        });

    </script>
</head>

</html>

