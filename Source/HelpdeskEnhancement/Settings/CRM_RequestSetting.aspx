<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_RequestSetting.aspx.vb"  Inherits="Whizible.CRM_RequestSetting" %>

<!DOCTYPE html>
<html>

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head id="Head1" runat="server">

    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
   <%-- <%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>--%>
    <!-- Bootstrap core CSS -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/timepicker.min.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    <style>
        #frmTagNavigation {
            border: 0px !important;
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
            overflow: hidden !important;
            width: 100% !important;
        }

        #DivList .dataTables_scrollBody {
            overflow: auto !important;
            width: 102% !important;
            height: 130px;
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
            text-align: center !important;
        }

        #divAUTOCLOSER tr th:nth-child(5) {
            text-align: center !important;
        }


        #divAUTOCLOSER tr td:nth-child(3) {
            text-align: center !important;
        }

        #divAUTOCLOSER tr th:nth-child(4) {
            text-align: center !important;
        }

        #divAUTOCLOSER tr td:nth-child(4) {
            text-align: center !important;
        }

        #divAUTOCLOSER tr td:nth-child(5) {
            text-align: center !important;
        }

        #CboAutocloser {
            margin-left: -37% !important;
        }

        #tblCloser {
            margin-left: -1.4% !important;
        }

        #divAUTOCLOSER .dataTables_scrollBody {
            width: 100% !important;
            height: 179px !important;
            overflow: hidden !important;
        }

        #divAUTOCLOSER ul.pagination {
            padding: 0px 2px 0 0px !important;
        }

        #divAUTOCLOSER table {
            width: 1065px !important;
        }

        #Autoclose .panel-title a {
            color: #fff;
            display: block;
            font-size: 15px;
            font-weight: 600;
            padding: 0px 10px 19px 10px;
            position: relative;
            float: right;
            margin-top: 2px !important;
        }

        #DivAuto {
            padding-top: 0% !important;
            padding-left: 1% !important;
        }

        #divAUTOCLOSER .dataTables_paginate {
            float: right !important;
            margin-right: -22% !important;
        }

        #AutoclosePanelDiv {
            padding-right: 3%;
        }

        .faSettingSearch {
            position: absolute;
            margin-top: 14px;
            margin-left: 10px;
        }

        .clsSettings {
            margin-top: 0px!important;
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

        .right {
            MARGIN-RIGHT: 10PX;
        }

        .clsbuttonLinks {
            margin-left: 2px;
        }

        #Autoclose h3 {
            padding: 0PX !important;
            border: none !important;
        }

        .content-wrapper {
            overflow: hidden !important;
        }

        .tablinks.active, .tablinks1.active, .h-tabs div.tab button.tablinks1.active, .h-tabs div.tab button.tablinks2.active, .h-tabs div.tab button.tablinks3.active {
            color: #4caac0 !important;
            border: none !important;
            text-decoration: underline !important;
        }
        .tab {
        margin-bottom:6PX!important;
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
        .tab  button
        {
            white-space:nowrap;
        }
        
         /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
          color: #bbb!important;
        }
    </style>

    <body class="" id="page-top">

        <!-- Navigation -->

        <!----------------------------  Tabs----------------------------->
        <%PageInit("")%>
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
    <!-- Bootstrap core JavaScript -->
<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
<script src="../../../Whizible2.0-new/dist/js/editor.js"></script>
<script src="../../../Whizible2.0-new/dist/js/timepicker.min.js"></script>
<%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
<script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--<script src="../../General/CommonFunctions.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>
    
//Added script by pradip on 18-06-2021
          function resizeSection() {
            var contentheight = $(window).height();
            $('#frmTagNavigation').css({ 'height': contentheight - 282, "overflow-y": "auto" })
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        }); 
//End Added script by pradip 


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
    </script>


    <script>
        var strPageName = "CRM_RequestSetting.aspx";
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

            //Commented by pradip on 18-06-2021	
            // document.getElementById("frmTagNavigation").style.height = window.innerHeight - 10 + 'px';
        });
    </script>

    <script>
        var TabName = "";
        var Flag = "";
        function openCity1(evt, cityName) {
            // debugger;
            //TabName = cityName;
           

            document.getElementById("frmTagNavigation").src = cityName;
            //Commented by pradip on 18-06-2021	
            //document.getElementById("frmTagNavigation").style.height = window.innerHeight - 10 + 'px';
            $(".tabcontent1").css("display", "block");
            var i, tabcontent1, tablinks1;
            tabcontent1 = document.getElementsByClassName("tabcontent1");
            for (i = 0; i < tabcontent1.length; i++) {
                tabcontent1[i].style.display = "none";
            }
            tablinks1 = document.getElementsByClassName("tablinks1");
            for (i = 0; i < tablinks1.length; i++) {
                tablinks1[i].className = tablinks1[i].className.replace(" active", "");
            }

            //Commented and Added by Usha Pandit on 21.05.2019 for Javascript Error
            //evt.currentTarget.className = evt.currentTarget.className + " active";
            if (evt != undefined && evt != null) {
                if (evt.currentTarget != undefined && evt.currentTarget != null) {
                    if (evt.currentTarget.className != undefined && evt.currentTarget.className != null) {
                        evt.currentTarget.className = evt.currentTarget.className + " active";
                    }
                }
            } 
            //End of Added by Usha Pandit on 21.05.2019 for Javascript Error            
        }
        // Get the element with id="defaultOpen" and click on it
       // document.getElementById("defaultOpen1").click();

        function PlotControls(cityName, Flag) {
            // debugger;
            var strResult, data;
            var GridParameter = {};

            GridParameter.cityName = cityName;

            data = JSON.stringify({ GridParameter: GridParameter });
            if (cityName != "Type") {
                strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);
                var DivId;
                var DivSerach;

                if (strResult.d != '') {
                    if (cityName == "Type") {
                        DivId = "DivList";
                        DivSerach = "SearchRquestType";
                    }
                    else if (cityName == "Subtype") {
                        DivId = "divGridSubRequestType";
                        DivSerach = "SearchSubRquestType";
                    }

                    else if (cityName == "Status") {
                        DivId = "divStatus";
                        DivSerach = "SearchRequestStatus";
                    }

                    else if (cityName == "Priority") {
                        DivId = "divPriority";
                        DivSerach = "SearchRequestPriority";
                    }
                    else if (cityName == "Severity") {
                        DivId = "divSeverity";
                        DivSerach = "SearchRequestSeverity";
                    }

                    else if (cityName == "Autoclose") {
                        DivId = "divAUTOCLOSER";
                        DivSerach = "SearchAutoclose";
                    }

                    //else if (cityName == "Type") {
                    //    DivId = "DivList";
                    //}
                    //  alert(strResult.d);

                    //if (String(cityName).toUpperCase() != "AUTOCLOSE") {
                    $("#" + cityName).html(strResult.d);

                    //  $("#" + cityName + " .table-responsive:first table").addClass("table");
                    /// }
                }
            }
            if (cityName == "Type") {
                DivId = "DivList";
                DivSerach = "SearchRquestType";
            }
            else if (cityName == "Subtype") {
                DivId = "divGridSubRequestType";
                DivSerach = "SearchSubRquestType";
            }

            else if (cityName == "Status") {
                DivId = "divStatus";
                DivSerach = "SearchRequestStatus";
            }

            else if (cityName == "Priority") {
                DivId = "divPriority";
                DivSerach = "SearchRequestPriority";
            }
            else if (cityName == "Severity") {
                DivId = "divSeverity";
                DivSerach = "SearchRequestSeverity";
            }

            else if (cityName == "Autoclose") {
                DivId = "divAUTOCLOSER";
                DivSerach = "SearchAutoclose";
            }

            var TypeDiv; var accordion;
            //TypeDiv = document.getElementById('divRequestTypes');
            //accordion = document.getElementById('accordion');
            var intDivGridHeight
            //   if (TypeDiv != null && accordion != null) {
            if (WhichBrowser() == "IE") {
                intDivGridHeight = (window.innerHeight / 2);

                if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
                    //  $('.panel-body').css('padding-top', "0px");
                    intDivGridListHeight = parseInt(window.innerHeight) - 320;
                }
                else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                    //  $('.panel-body').css('padding-top', "0px");
                    intDivGridListHeight = parseInt(window.innerHeight) - 200;

                }
                else {
                    //  $('.panel-body').css('padding-top', "15px");
                    intDivGridListHeight = parseInt(window.innerHeight) - 150;
                }

                $('.panel-body').css('height', intDivGridListHeight + "px");
                //$('#divRequestTypes').css('height', intDivGridListHeight + 20);
                $('#divRequestTypes').css('height', intDivGridListHeight - 530 + "px");


            }
            else {
                intDivGridHeight = (window.innerHeight / 2);

                if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
                    //  $('.panel-body').css('padding-top', "0px");
                    intDivGridListHeight = parseInt(window.innerHeight) - 350;
                }
                else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                    //    $('.panel-body').css('padding-top', "0px");

                    intDivGridListHeight = parseInt(window.innerHeight) - 410;

                }
                else {
                    // $('.panel-body').css('padding-top', "15px");
                    intDivGridListHeight = parseInt(window.innerHeight) - 550;
                }

                //   $('#accordion').css('height', intDivGridListHeight +150 + "px");
                //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
                $('.panel-body').css('height', intDivGridListHeight - 180 + "px");
                $('#divRequestTypes').css('height', intDivGridListHeight - 100 + "px");
            }

            datatables(DivId, DivSerach, '');
          //  setWidthDatatable("DivList");

        }
        function RefreshGrid(cityName, Flag) {
            var strResult, data;
            var GridParameter = {};

            GridParameter.cityName = cityName;
            if (Flag != "") {
                data = JSON.stringify({ GridParameter: GridParameter });
                if (cityName != "Type") {
                    strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
                    var DivId;
                    var DivSerach;
                    //  alert(strResult.d);
                    if (strResult.d != '') {
                        if (cityName == "Type") {
                            DivId = "DivList";
                            DivSerach = "SearchRquestType";
                        }
                        else if (cityName == "Subtype") {
                            DivId = "divGridSubRequestType";
                            DivSerach = "SearchSubRquestType";
                        }

                        else if (cityName == "Status") {
                            DivId = "divStatus";
                            DivSerach = "SearchRequestStatus";
                        }

                        else if (cityName == "Priority") {
                            DivId = "divPriority";
                            DivSerach = "SearchRequestPriority";
                        }
                        else if (cityName == "Severity") {
                            DivId = "divSeverity";
                            DivSerach = "SearchRequestSeverity";
                        }

                        else if (cityName == "Autoclose") {
                            DivId = "divAUTOCLOSER";
                            DivSerach = "SearchAutoclose";
                        }

                        //else if (cityName == "Type") {
                        //    DivId = "DivList";
                        //}

                        if (String(cityName).toUpperCase() != "AUTOCLOSE") {
                            $("#" + cityName + " .table-responsive").html(strResult.d);

                            $("#" + cityName + " .table-responsive:first table").addClass("table");
                        }
                        else {
                            $("#" + cityName + " .table-responsive:first").html(strResult.d);

                            $("#" + cityName + " .table-responsive:first table").addClass("table");

                        }

                    }
                }
                if (cityName == "Type") {
                    DivId = "DivList";
                    DivSerach = "SearchRquestType";
                }
                else if (cityName == "Subtype") {
                    DivId = "divGridSubRequestType";
                    DivSerach = "SearchSubRquestType";
                }

                else if (cityName == "Status") {
                    DivId = "divStatus";
                    DivSerach = "SearchRequestStatus";
                }

                else if (cityName == "Priority") {
                    DivId = "divPriority";
                    DivSerach = "SearchRequestPriority";
                }
                else if (cityName == "Severity") {
                    DivId = "divSeverity";
                    DivSerach = "SearchRequestSeverity";
                }

                else if (cityName == "Autoclose") {
                    DivId = "divAUTOCLOSER";
                    DivSerach = "SearchAutoclose";
                }

                var TypeDiv; var accordion;
                //TypeDiv = document.getElementById('divRequestTypes');
                //accordion = document.getElementById('accordion');
                var intDivGridHeight
                //   if (TypeDiv != null && accordion != null) {
                if (WhichBrowser() == "IE") {
                    intDivGridHeight = (window.innerHeight / 2);

                    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
                        //  $('.panel-body').css('padding-top', "0px");
                        intDivGridListHeight = parseInt(window.innerHeight) - 320;
                    }
                    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                        //  $('.panel-body').css('padding-top', "0px");
                        intDivGridListHeight = parseInt(window.innerHeight) - 200;

                    }
                    else {
                        //  $('.panel-body').css('padding-top', "15px");
                        intDivGridListHeight = parseInt(window.innerHeight) -  200;
                    }

                    $('.panel-body').css('height', intDivGridListHeight + "px");
                    //$('#divRequestTypes').css('height', intDivGridListHeight + 20);
                    $('#divRequestTypes').css('height', intDivGridListHeight - 130 + "px");


                }
                else {
                    intDivGridHeight = (window.innerHeight / 2);

                    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
                        //  $('.panel-body').css('padding-top', "0px");
                        intDivGridListHeight = parseInt(window.innerHeight) - 350;
                    }
                    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                        //    $('.panel-body').css('padding-top', "0px");

                        intDivGridListHeight = parseInt(window.innerHeight) - 350;

                    }
                    else {
                        // $('.panel-body').css('padding-top', "15px");
                        intDivGridListHeight = parseInt(window.innerHeight) - 570;
                    }

                    //   $('#accordion').css('height', intDivGridListHeight +150 + "px");
                    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
                    $('.panel-body').css('height', intDivGridListHeight - 180 + "px");
                    $('#divRequestTypes').css('height', intDivGridListHeight - 160 + "px");
                }

                datatables(DivId, DivSerach, '');
                setWidthDatatable("DivList");

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
        function datatableMainPage(divID, height) {
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' table').DataTable({
                responsive: true,
                "pageLength": 10,
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

        function datatables(divID, txtBoxID) {
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' > table').DataTable({
                responsive: true,
                "pageLength": 5,
                scrollY: '130px',
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
            }
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


    </script>
    <script>

        function openCity(evt, cityName) {
            setFrameLoader();
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

        function ShowNext(num) {


            if (num == 1) {
                document.getElementById("hdnTabCount").value = parseInt(document.getElementById("hdnTabCount").value) - 1;
                $("#iNext").css("display", "");
            }
            else if (num == 2 && parseInt(document.getElementById("hdnTabCount").value) != parseInt(document.getElementById("hdnLastTabCount").value)) {
                document.getElementById("hdnTabCount").value = parseInt(document.getElementById("hdnTabCount").value) + 1;
                $("#iPrev").css("display", "");
            }
            else {
                $("#iNext").css("display", "none");
            }
            if (parseInt(document.getElementById("hdnTabCount").value) == 1) {
                $("#iPrev").css("display", "none");
            }
            if (parseInt(document.getElementById("hdnTabCount").value) == parseInt(document.getElementById("hdnLastTabCount").value)) {
                $("#iNext").css("display", "none");
            }
            $(".tablinks1").css("display", "none")
            $("[valForDisplay=" + document.getElementById("hdnTabCount").value + "]").css("display", "");
        }
        // Get the element with id="defaultOpen" and click on it
        //document.getElementById("defaultOpen3").click();
    </script>
    <style>
        #iNext {
            font-size: 20px;
            margin-top: 6px;
            cursor:pointer;
        }
         #iPrev {
            font-size: 20px;
            margin-top: 6px;
            float: left;
            margin-right:6px;
            cursor:pointer;
        }
    </style>
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

           // var bodyHeight = window.innerHeight - $('#MainDiv').offset().top;
            //    alert(bodyHeight);
            // $('#MainDiv').css('height', bodyHeight - 10 + 'px');

            $('[data-toggle="tooltip"]').tooltip();

           
        });

        

        
    </script>
</head>

</html>

