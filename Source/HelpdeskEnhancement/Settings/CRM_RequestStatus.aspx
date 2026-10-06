<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_RequestStatus.aspx.vb" Inherits="PbNIT.CRM_RequestStatus" %>

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
    <%--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />--%>
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

    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <!--[if IE]>
         <link href="../../../EnhancementFiles/css/all-ie-only.css" rel="stylesheet" />
  
    <![endif]-->
     
    <style>
       /*@media screen\0 {
    
        }*/
        /*Added by Yasmin For UI Changes On 11th July 2018*/

        @media screen and (-webkit-min-device-pixel-ratio:0) {
    .chromef {  margin-left: -13px!important;
                margin-right:24px!important;
    }
}
        _:-moz-tree-row(hover),.form-horizontal .form-group {
         margin-right: 0px!important;
       margin-left: -15px!important;
}
        .form-group {
            display: block!important;
        }
        /*Change by Yasmin For UI Changes On 12th July 2018*/
        #collapseOne3 .form-horizontal .form-group {
         margin-right: 0px!important;
       margin-left: 7px;
        }

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
            padding-top:0% !important;
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
            padding-right: 1%;
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


        #divAUTOCLOSER tr th:nth-child(3) {

            text-align:center!important; 
        }

          #divAUTOCLOSER tr th:nth-child(5) {

            text-align:center!important; 
        }


         #divAUTOCLOSER tr td:nth-child(3) {

            text-align:center!important; 
        }

          #divAUTOCLOSER tr th:nth-child(4) {

            text-align:center!important; 
        }

           #divAUTOCLOSER tr td:nth-child(4) {

            text-align:center!important; 
        }

             #divAUTOCLOSER tr td:nth-child(5) {

            text-align:center!important; 
        }

        #CboAutocloser {
            margin-left:-37%!important; 
        }

        #tblCloser {
            margin-left:-1.4%!important; 
        }

     #divAUTOCLOSER .dataTables_scrollBody
     {

         width:100%!important; 
         height:179px!important;
         overflow:hidden !important;
     }

        #divAUTOCLOSER ul.pagination {
            padding: 0px 2px 0 0px!important; 
        }

        #divAUTOCLOSER table  {
            width:1065px!important; 

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

            padding-right:3%;
        }

         .faSettingSearch {
    position: absolute;
    margin-top: 14px;
    margin-left: 10px;
}
        
        .clsSettingstabs {
            margin-top: -13px;
        }
        .form-horizontal .form-group {
        line-height:3;
        }
        .fa-sort {
        margin-left:4px;
        display:none;
        }
        #divSeverity .clsTRColumnHeader TH:nth-child(3) {
        text-align:center;
        }
        /*.right {
            MARGIN-RIGHT: 10PX;
        }*/
        .clsbuttonLinks {
        margin-left:2px;
        }
        #Autoclose h3 {
        padding:0PX !important;
        border:none!important;
        }
        .content-wrapper {
        overflow:hidden !important;
        }
          #Status {
        width:100%;
        overflow:hidden;
      } 
        #divScrollStatus {
        width:102%;
        padding-right:2%;
        overflow:auto;
      }
          .dataTables_scrollBody .clsTRColumnHeader{
        height:0px !important;
        }
        .type-top-bar {
        padding-right:5px !important;
        }

         .type-top-bar .right{
        padding:0px !important;
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
         /*Added By Dipali vekhande*/
	    .clslabel {
            margin-top:1.5%!important;
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

           
	    #ShowHistoryGrid .dataTable no-footer {
            width:651px!important;
	    }

	   #ShowHistoryGrid {
            overflow-x: hidden !Important;
            overflow-y: auto !Important;
            padding-right: -1%!important;
            width: 107%!important;
            /*height: 158px!important;*/
            padding-right: 4%!important;
}
	    #modalbody {
            overflow:hidden!important;
	    }

        #ShowHistoryGrid .container-fluid {
            min-height:0px!important;
        }


         #ShowHistoryGrid .dataTables_paginate {
        float: right !important;
        margin-right: 9%;
}

	    #modalbody {
            overflow:hidden!important;
	    }
        /*.search-bar .fa-search {
            position: absolute !important;
            margin-top: 10px !important;
            margin-bottom: 10px !important;
            right: 17px !important;
            left: auto !important;
            font-size: 14px !important;
            margin-left: 0px !important;
        }*/
        #isSaveandAdd{
        float: right;
        margin-top: 5px;
        margin-left: 5px;
        display:block;
        background-color:white!important;
        color:white;
    }
         .clslabel {
            margin-top:1.5%!important;
            font-size:12px;
	    }
    #idPlus {
            display:inline-block !important;
        }
    /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
          color: #bbb!important;
        }
        .container-fluid {
            min-height: 4px !important;
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
                            <button type="button" class="btn btn-default save" onclick="Inherit_StatusFlow()" style="background-color: #343660; color: #fff;">Inherit</button>
                            <button type="button" class="btn btn-default save"  onclick="Cancel_StatusFlow()" style="background-color: #fff; color: #343660;">Cancel</button>
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
        <%--<div id="id10" class="modal">

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
        </div>--%>
    <div id="id10" class="modal">

            <form class="modal-content animate" action="/action_page.php">
                <div class="imgcontainer">
                    <span class="appro-title">Show History</span>
                    <span onclick="close_onclick()" class="close" title="Close">&times;</span>
                </div>
                <div class="container-fluid">
                    <%--<div class="form-group" style="margin-top:9px;">
                        <label class="control-label col-sm-3" for="request type">Modified Field</label>
                        <div class="col-sm-9">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 915", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>
                    </div>
                    <div class="form-group" style="margin-top:9px;">
                        <label class="control-label col-sm-3" for="request type code">Modified By</label>
                        <div class="col-sm-9">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 915", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>
                    </div>--%>

                     <div class="form-group">
                        <label class="control-label col-sm-2 clslabel" for="request type">Modified Field</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 915", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                         <label class="control-label col-sm-2 clslabel" for="request type code">Modified By</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 915", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                    </div>
                    <div class="container-fluid" id="modalbody" style="overflow:auto;width:700px;">
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
        <div id="id13" class="modal">

            <form class="modal-content animate" action="/action_page.php">
                <div class="imgcontainer">
                    <span class="appro-title">Show History</span>
                    <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close">&times;</span>
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
        <script>
            $(function () {
                $('#timepicker1').timepicker();
                $('#timepicker2').timepicker();
            });
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
            var strPageName = "CRM_RequestStatus.aspx";
            $(document).ready(function () {
                $("#txtEditor").Editor();
                $("#txtEditor1").Editor();
                $("#txtEditor2").Editor();
                $("#txtEditor3").Editor();
                $("#History").css("display", "none");
                <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		        <%End If%>
            });
        </script>

        <script>
            var TabName = "";
            var Flag = "";
            var strSaveAndAdd = 0;
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
             
                DivId = "divStatus";
                DivSerach = "SearchRquestType";
                       
                var TypeDiv; var accordion;
                //TypeDiv = document.getElementById('divRequestTypes');
                //accordion = document.getElementById('accordion');
                var intDivGridHeight
                //   if (TypeDiv != null && accordion != null) {
                //if (WhichBrowser() == "IE") {
                //    intDivGridHeight = (window.innerHeight / 2);

                //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
                //        //  $('.panel-body').css('padding-top', "0px");
                //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
                //    }
                //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                //        //  $('.panel-body').css('padding-top', "0px");
                //        intDivGridListHeight = parseInt(window.innerHeight) - 590;

                //    }
                //    else {
                //        //  $('.panel-body').css('padding-top', "15px");
                //        intDivGridListHeight = parseInt(window.innerHeight) - 580;
                //    }

                //    $('#divScrollStatus').css('height', intDivGridListHeight + 170 + "px");
                //    //$('#divRequestTypes').css('height', intDivGridListHeight + 20);
                //   // $('#tblStatus').css('height', intDivGridListHeight - 250 + "px");

                //}
                //else {
                    
                
                //    intDivGridHeight = (window.innerHeight / 2);

                //    if ((parseInt(window.innerHeight) <= 680 && parseInt(window.innerWidth) <= 1080)) {
                        
                //        intDivGridListHeight = parseInt(window.innerHeight) - 380;
                //      //  $('#tblStatus').css('height', intDivGridListHeight - 140 + 'px !important');
                //        $('#divScrollStatus').css('height', intDivGridListHeight + 90 + 'px');
                //    }
                    
                //    else if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) ) 
                //    {
                        
                //        intDivGridListHeight = parseInt(window.innerHeight) - 395;
                //       // $('#tblStatus').css('height', intDivGridListHeight - 140 + 'px !important');
                //        $('#divScrollStatus').css('height', intDivGridListHeight + 90 + 'px');
                //    }
                //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                //        intDivGridListHeight = parseInt(window.innerHeight) - 485;
                //        $('#divScrollStatus').css('height', intDivGridListHeight + 90 + 'px');
                //       // $('#tblStatus').css('height', intDivGridListHeight - 120);

                //    }
                //    else {

                      
                //        intDivGridListHeight = parseInt(window.innerHeight) - 680;
                //        $('#divScrollStatus').css('height', intDivGridListHeight + 300 + 'px');
                //       // $('#tblStatus').css('height', intDivGridListHeight - 120);
                //    }
                                     
                //    $('#divScrollStatus').css('height', intDivGridListHeight + 170 + "px");
                //    //$('#divRequestTypes').css('height', intDivGridListHeight + 20);
                //    //$('#tblStatus').css('height', intDivGridListHeight - 150 + "px");
                

                //    //   $('#accordion').css('height', intDivGridListHeight +150 + "px");
                //    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
                     
                //}


                var intDivGridHeight, intDivGridListHeight
                intDivGridListHeight = parseInt(window.innerHeight);
                if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

                    $("#divRequestTypes").css('height', intDivGridListHeight - 280 + "px");
                }

                else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

                    $("#divRequestTypes").css('height', intDivGridListHeight - 320 + "px");
                }
                else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                    $("#divRequestTypes").css('height', intDivGridListHeight - 280 + "px");
                }
                else {
                    $("#divRequestTypes").css('height', intDivGridListHeight - 280 + "px");
                }
               // alert(intDivGridListHeight);
                datatables(DivId, DivSerach, intDivGridListHeight);
                setWidthDatatable(DivId);

            }
            function RefreshGrid(cityName, Flag) {
                var strResult, data;
                var GridParameter = {};
                cityName = "Status";
                DivId = "divStatus";
                DivSerach = "SearchRequestStatus";
                           
                GridParameter.cityName = cityName;
                if (Flag != "") {
                    data = JSON.stringify({ GridParameter: GridParameter });
                     strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
                        var DivId;
                        var DivSerach;
                         //alert(strResult.d);
                        if (strResult.d != '') {
                            $("#tblStatus").html("");
                            $("#tblStatus").html(strResult.d);

                                $(".table-responsive:first table").addClass("table");
                            }
                             
                        }
                if (strSaveAndAdd == 1) {
                    strSaveAndAdd = 0;
                }
                    PlotControls();
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

            function datatables(divID, txtBoxID, height) {
                $('#' + divID + ' > table').removeClass("clsGridTable");
                $('#' + divID + ' table').addClass("table table-bordered table-stripped");
                var table = $('#' + divID + ' > table').DataTable({
                    responsive: true,
                    "pageLength": 3,
                    scrollY: "115px",
                    pagingType: "simple_numbers",
                    ordering: false,
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
   
            function EditRequestStatus(obj, RequestStatusID) {
                EditStatusID = RequestStatusID;
                $.ajax({
                    type: "POST",
                    url: "CRM_RequestStatus.aspx/GetRequestStatusDetails",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ RequestStatusID: RequestStatusID }),
                    success: function (data) {
                        //alert(data);
                        $("#History").css("display", "inline");                      
                        $("#tblStatus").css("display", "none");                    
                        $("#divStatusTab").css("display", "none");
                        $("#divStatusBottom").css("margin-top", "15px");
                        var arrResult = data.d.split('##');

                        $('#txtStatusCode').val(arrResult[1]);
                        $('#txtOrderNumber').val(arrResult[4]);
                        $('#txtRequestStatus').val(arrResult[2]);
                       // alert(arrResult[3]);
                        $('#CboSystemStatus').val(arrResult[3]);
                        /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
                        if ($("#Addaccordion").hasClass("collapsed")) {
                            $("#Addaccordion").removeClass("collapsed");
                            $("#collapseOne3").css('height', 'auto');
                            $("#collapseOne3").css('width', 'auto');
                            $("#collapseOne3").addClass('in');

                        }

                    },
                    error: function (xhr) {
                        //alert(xhr.responseText);
                        console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);
                    }
                });
            }
             
            function AddRequestStatus() {
                $("#tblStatus").css("display", "none");
                $("#divStatusTab").css("display", "none");
                $("#divStatusBottom").css("margin-top", "0px");
                EditStatusID = 0;
                $("#collapseOne3 .panel-body").css("height", "auto");
                $("#divStatusBottom").css("margin-top", "15px");
                $('#txtStatusCode').val("");
                $('#txtOrderNumber').val("");
                $('#txtRequestStatus').val("");
                $('#CboSystemStatus').val("");
                $("#History").css("display", "none");


                /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
                if ($("#Addaccordion").hasClass("collapsed")) {
                    $("#Addaccordion").removeClass("collapsed");
                    $("#collapseOne3").css('height', 'auto');
                    $("#collapseOne3").css('width', 'auto');
                    $("#collapseOne3").addClass('in');

                }
            }
             
            function Cancel_Status() {
                $("#divStatus").css("display", "block");
                $("#divStatusTab").css("display", "block");
                EditSubRequestTypeID = 0;
                $("#tblStatus").css("display", "block");
                $('#txtStatusCode').val("");
                $('#txtOrderNumber').val("");
                $('#txtRequestStatus').val("");
                $('#CboSystemStatus').val("");
                $("#History").css("display", "none");
                RefreshGrid('Status', "Flag");
                /*Added By Dipali v on 22st Nov 2017 For Panel Minimize n Max Issue*/
                if ($("#Addaccordion").hasClass("collapsed")) {
                    $("#Addaccordion").removeClass("collapsed");
                    $("#collapseOne3").css('height', 'auto');
                    $("#collapseOne3").css('width', 'auto');
                    $("#collapseOne3").addClass('in');

                }
             
            }
              

            function DeleteRequestStatus() {
                var strStatusIDs;
                var table = $('#divStatus table').DataTable();
                var rows = table.rows({ 'search': 'applied' }).nodes();

                //strStatusIDs = $('input[name=chkStatusDelete]:checked').map(function () {
                //    return this.value;
                //}).get().join(',');
                //strStatusIDs = $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true).map(function () {
                //    return this.value;
                //}).get().join(',');
               
                if (document.getElementById('chkAllDeleteStatus').checked == true) {
                    strStatusIDs = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                        return this.value;
                    }).get().join(',');
                }
                else {
                    strStatusIDs = $('input[name=chkStatusDelete]:checked').map(function () {
                        return this.value;
                    }).get().join(',');
                }

                //alert(strStatusIDs);
                
                if (strStatusIDs.length <= 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(' - Please select at least one Status for deletion', 'error');
                    return;
                }
                
                data = JSON.stringify({ RequestStausID: strStatusIDs });

                strResult = AJAXCallWithResult(strPageName + "/DeleteRequestStatus", data, false);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Request Status deleted successfully', 'success');
                RefreshGrid('Status', "Flag");

            }

            function DeleteMultiple_Status() {
                var table = $('#divStatus table').DataTable();
                var rows = table.rows({ 'search': 'applied' }).nodes();
                if (document.getElementById('chkAllDeleteStatus').checked == true) {
                    //$("input[name=chkStatusDelete]:not(:disabled)").prop('checked', true);
                    $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
                }
                else {
                    //$("input[name=chkStatusDelete]").prop('checked', false);
                    $('input[type="checkbox"]', rows).prop('checked', false);
                }
            }

   
            function ValidateStatus() {
                var checkvalue = 0;
                var strmsg = "";
                var errorMsg = "<ul>"


                if ($("#txtStatusCode").val() == "") {
                    strmsg = strmsg + '- Request Status Code should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }

                if ($("#txtRequestStatus").val() == "") {
                    strmsg = '- Request Status should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }
                if ($("#CboSystemStatus").val() == "") {
                    strmsg = '- System Status should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }

                if ($("#txtOrderNumber").val() == "") {
                    strmsg = '- Order Number should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }

                if ($("#txtStatusCode").val() != "") {
                    if (disallowSpecialCharacters(document.getElementById('txtStatusCode')) == true) {
                        strmsg = '- A Request Status Code cannot contain any of these /\\:*?<>|,"+- characters.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }

                if ($("#txtRequestStatus").val() != "") {
                    if (disallowSpecialCharacters(document.getElementById('txtRequestStatus')) == true) {
                        strmsg = '- A Request Status cannot contain any of these /\\:*?<>|,"+- characters.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }

                if ($("#txtOrderNumber").val() != "") {
                    if (disallowSpecialCharacters(document.getElementById('txtOrderNumber')) == true) {
                        strmsg = '- A Order Number cannot contain any of these /\\:*?<>|,"+- characters.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }

                    if (disallowNegativeNumeric(document.getElementById('txtOrderNumber')) == true) {
                        strmsg = '- Please enter only positive numeric value for Order Number';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }

               


                if ($("#txtRequestStatus").val() != "") {
                    var RequestStatus = $("#txtRequestStatus").val()
                    data = JSON.stringify({ RequestStatus: RequestStatus, EditStatusID: EditStatusID });
                    var strResult1 = AJAXCallWithResult("CRM_RequestStatus.aspx/IsDuplicateStatusMapped", data, false);

                    if (strResult1 != undefined) {
                        if (strResult1.d == "1") {
                            strmsg = strmsg + '- Request Status already exists';
                            errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;

                        }
                    }
                }

                if ($("#txtOrderNumber").val() != "") {
                    var OrderNumber = $("#txtOrderNumber").val()
                    data = JSON.stringify({ OrderNumber: OrderNumber, EditStatusID: EditStatusID });
                    var strResult1 = AJAXCallWithResult("CRM_RequestStatus.aspx/IsDuplicateOrderNumber", data, false);
                    if (strResult1 != undefined) {
                        if (strResult1.d == "1") {
                            strmsg = '- This Order Number is already applied';
                            errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;

                        }
                    }
                }

                if ($("#txtStatusCode").val() != "") {
                    var StatusCode = $("#txtStatusCode").val()

                    data = JSON.stringify({ StatusCode: StatusCode, EditStatusID: EditStatusID });
                    var strResult1 = AJAXCallWithResult("CRM_RequestStatus.aspx/IsDuplicateStatusCode", data, false);
                    // alert(strResult1.d);
                    if (strResult1 != undefined) {
                        if (strResult1.d == "1") {
                            strmsg = '- Request Status Code already exists.';
                            errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;

                        }
                    }
                }


                if (checkvalue == 1 && strmsg != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorMsg, 'error');
                    checkvalue = 1;
                }

                return checkvalue;
            }
           
            function SaveAndAddStatus() {
                strSaveAndAdd = 1;
                SaveStatus();

            }
            var EditStatus = 0;
            var EditStatusID = 0;
            function SaveStatus() {
                //debugger;
                if (ValidateStatus() == 0) {
                    var StatusCode = $("#txtStatusCode").val();
                    var OrderNumber = $("#txtOrderNumber").val();
                    var RequestStatus = $("#txtRequestStatus").val();
                    var SystemStaus = $("#CboSystemStatus").val();

                    data = JSON.stringify({ StatusCode: StatusCode, OrderNumber: OrderNumber, RequestStatus: RequestStatus, SystemStaus: SystemStaus, StatusID: EditStatusID });

                    strResult = AJAXCallWithResult("CRM_RequestStatus.aspx/SaveStatus", data, false);
                    if (strResult.d != "") {
                        if (strSaveAndAdd == 1) {
                            $("#divStatus").css("display", "none");
                            $(".type-top-bar").css("display", "none");
                            $("#tblStatus").css("display", "none");
                            $('#txtStatusCode').val("");
                            $('#txtOrderNumber').val("");
                            $('#txtRequestStatus').val("");
                            $('#CboSystemStatus').val("");
                        }
                        else {
                            $("#divStatus").css("display", "block");
                            $(".type-top-bar").css("display", "block");
                            $("#tblStatus").css("display", "block");
                        }
                       
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Status saved successfully', 'success');
                        RefreshGrid('Status', "Flag");
                    }

                }
            }

            function HistoryDetails() {
                //alert(EditStatusID);
                var obj = { "UniqueID": EditStatusID };
                var myJSON = JSON.stringify(obj);
                var url = "CRM_RequestStatus.aspx/ShowMailHistoryDetails"

                var result = AJAXCallWithResult(url, myJSON, false)

                if (EditStatusID == undefined || EditStatusID == 0) {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please select atleast one entry..', 'error');
                }
                else {

                    $("#id10 #modalbody").html(result.d);
                    document.getElementById('id10').style.display = 'block';
                }
                datatables("ShowHistoryGrid", 'SearchRquestType');
            }
            function ModifiedFieldFilter_Change() {

                var ModifiedField = $('#cboModifiedField :selected').text();
                var ModifiedBy = $('#cboModifiedBy :selected').text();

                var obj = { "newModifiedField": ModifiedField, "MessageID": EditStatusID, "newModifiedBy": ModifiedBy };
                var myJSON = JSON.stringify(obj);

                var url = "CRM_RequestStatus.aspx/FilteredHistory"
                var result = AJAXCallWithResult(url, myJSON, false)
                $("#id10 #modalbody").html(result.d);
                document.getElementById('id10').style.display = 'block';

                datatables("ShowHistoryGrid", 'SearchRquestType');
            }
            function close_onclick() {
                document.getElementById('id10').style.display = 'none';
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
            //$('.modal').draggable();
            //var modal = document.getElementById('id10');

            //// When the user clicks anywhere outside of the modal, close it
            //window.onclick = function (event) {
            //    if (event.target == modal) {
            //        modal.style.display = "none";
            //    }
            //}
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
                PlotControls();
            });

            $(window).load(function () {
 
            });

             
        </script>
</head>

</html>

