<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_CustomerMaster.aspx.vb" Inherits="PbNIT.CRM_CustomerMaster" %>

<!DOCTYPE html>
<html>

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head id="Head1" runat="server">

    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>--%>


    <!-- Bootstrap core CSS -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>

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
    <link href="../../../EnhancementFiles/css/setting.css?v=1.1" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <%--<link href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet"/>--%>
    <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />

    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

    <title></title>
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
            /*OVERFLOW: auto;
            HEIGHT: 246PX;*/
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
            margin-right: -14PX;
            margin-top: -30px;
            float: right;
        }

        .pagination {
            margin: 0 !important;
        }

        /*.dataTables_info {
            margin-top: -7px;
        }*/

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

        .edit-bt1 {
            background: transparent;
            border: none;
            font-size: 22px;
            position: relative;
            top: -3px;
            color: red;
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

        #frmType {
            width: 100%;
        }

        #divSubRequestType .dataTables_wrapper {
            padding-right: 15px;
            padding-left: 0px;
            margin-right: auto;
            margin-left: auto;
        }
        /*#accordion {
        overflow:hidden;
        }*/
        .fa-pencil-square-o {
            color: #4caac0 !important;
        }

        #DivList .dataTables_scroll {
            /*overflow: hidden!important;*/
            width: 100% !important;
        }

        #DivList .dataTables_scrollHead {
            overflow: hidden !important;
            width: 102% !important;
        }

        /*Commented by yasmin for pagination alignment on 3rd july 2018*/
        #DivList .dataTables_scrollBody {
            /*overflow: auto!important;*/
            width: 102% !important;
            margin-bottom: 10px;
            /*height: 141px;*/
            /*padding-right: 2%!important;*/
        }
        /*Commented by yasmin for pagination alignment on 3rd july 2018*/
        #idPanelBody {
            /*overflow-x: hidden;*/
            /*height: 175px;*/
            /*width: 104%;*/
            padding-right: 2%;
        }

        #divSubRequestType .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divSubRequestType .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 100%;
            padding-right: 0.5%;
        }

        #divCustomerContact .dataTables_paginate {
            margin-top: 12px;
            float: right;
            margin-right: 0px;
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
            margin-top: 13px;
            margin-left: 10px;
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

        .tabcontent1 {
            border: none !important;
        }



        /*#Type .tab button.active {
        background: #364660;
        color: #fff;
        border-radius: 3px;
}

        #Type .tab button {
            width: 138px;
        }*/
        .container-fluid {
            min-height: auto !important;
        }

        #DivList {
            overflow-x: hidden !important;
        }

        #divCustomerContact {
            width: 100%;
            margin-left: 1%;
            overflow-x: hidden !important;
            overflow-y: auto !important;
        }

        #customerControl {
            width: 99%;
            margin-left: 1%;
        }

            #customerControl .pagination {
                margin: 5px 11px !important;
            }

        /*Change By Yasmin on 2nd July 2018*/
        #collapseOne11 {
            width: 100%;
            /*margin-left:-7%;*/
        }

        /*Commented By Yasmin on 2nd July 2018*/
        #collapseOne22 {
            width: 100%;
            /*margin-left:-7%;*/
        }
        /*Commented By Yasmin on 2nd July 2018*/
        #CustomerContact {
            /*margin-right:-5%!important;*/
            float: right !important;
        }

        /*.clsHideHorizontalDiv {
              display:none;
        }*/

        .clsSubtags {
            width: 160px !important;
        }

        #btnConfigureHRM {
            font-size: 12px;
        }

        .tablinks4 {
            height: 30px;
            background-color: white;
        }

        #divCustomerContact .dataTables_scrollHeadInner {
            width: 100% !important;
            /*width:100%!important;*/
        }

        #divCustomerContact .pagination {
            /*margin: -6px 11px !important;*/
        }

        #divCustomerContact tr th:nth-child(1) {
            width: 300px !important;
        }

        #divCustomerContact tr th:nth-child(7) {
            text-align: center;
        }

        #divCustomerContact tr th:nth-child(8) {
            text-align: center;
        }

        #divCustomerContactcilent tr th:nth-child(7) {
            text-align: center;
        }

        #divCustomerContactcilent tr th:nth-child(8) {
            text-align: center;
        }

        .tab {
            padding-left: 15px;
            margin-bottom: 0px;
        }

        #Type .h-tabs div.tab button.active {
            border-left: 1px solid #e3e2e2;
            border-right: 1px solid #e3e2e2;
            border-top: 1px solid #e3e2e2;
            border-bottom: none;
            background: none;
        }

        #Type .h-tabs div.tab button {
            /*border: none !important;*/
            border-bottom: 1px solid #ddd;
            border-right: 1px solid white;
            border-top: 1px solid white;
        }

        .clsShowHorizontalDiv div.tab button {
            border: none;
            outline: none;
        }

        .right .btn-default {
            /*background-color:#ddd!important;*/
        }

        #divCustomerContact tr td:nth-child(4) {
            text-align: center !important;
        }

        #divCustomerContact tr td:nth-child(5) {
            text-align: center !important;
        }

        /*#Type .right .btn-default {
            background-color:white!important;
            color:black!important;
        }*/

        /*Commented By Yasmin on 2nd July 2018*/
        .clscombo {
            /*width:200px!important;*/
            height: 28px !important;
            font-size: 12px !important;
        }

        /*.fa-minus {
            color:white!important;
        }

        .fa-plus {
             color:white!important;
        }*/

        /*.bottom-bar .fa.fa-plus {
            display:block!important;
        }*/
        #ConfigureHRM .type-top-bar .fa.fa-plus {
            /*Commented and Added by Usha Pandit on 5 JAN 2018*/
            /*display:block!important;
            margin-left: 95%!important;
            margin-top: -45%!important;*/
            display: -webkit-inline-box !important;
            /* End of Added by Usha Pandit on 5 JAN 2018*/
        }

        #ProjectMapping .top-bar .fa.fa-plus {
            /*Commented and Added by Usha Pandit on 5 JAN 2018*/
            /*display: block!important;
            margin-left: 95%!important;
            margin-top: -45%!important;*/
            display: -webkit-inline-box !important;
            /* End of Added by Usha Pandit on 5 JAN 2018*/
        }

        #btnSelectFile {
            white-space: inherit;
        }

        #UploadImage {
            margin-left: 41px;
        }

        #btnSelectFile:hover {
            font-size: 11px !important;
            font-weight: normal !important;
        }

        #UploadImage .col-xs-1 {
            height: 86PX !important;
            width: 86PX !important;
        }

        #btnSelectFile {
            white-space: inherit;
        }

        .bros-btn .btn-default {
            color: #364660;
            padding: 3px 16px;
            background: #fff;
            border: 1px solid #d3cfd0;
            margin-left: 15px;
        }

        #file {
            display: none;
        }

        .form-horizontal {
            /*overflow-x:hidden;*/
        }

        .bros-btn {
            float: none;
            margin: 4px 0px 15px -9PX;
            margin-top: -16px;
            margin-left: 5px !important;
            /*margin-top: 10px!important;*/
        }

        #UploadImage .col-xs-1 {
            height: 75PX !important;
            width: 75PX !important;
        }

        #btnSelectFile {
            white-space: inherit;
        }

        #UploadImage {
            margin-left: 72px;
        }

        #btnSelectFile:hover {
            font-size: 11px !important;
            font-weight: normal !important;
        }
        /*#imgUser {
            height: 30px;
            width: 30px;
            border-radius: 50%;
        }*/
        #imgUser {
            height: 75px;
            width: 75px;
            border-radius: 50%;
            margin-top: -1px;
            margin-left: -16px;
            line-height: 20px !important;
            cursor: pointer;
        }

        .col-xs-1 {
            border: 1px solid #ddd;
            border-radius: 35px;
        }

        #Type {
            width: 100%;
            overflow: hidden;
        }

        #divTypeStatus {
            width: 102%;
            padding-right: 2%;
            /* overflow: auto; */
            /*height: 346px;*/
            overflow-x: hidden !important;
            overflow-y: auto !important;
        }

        #divCustomerContact {
            height: auto !important;
        }

        .save {
            border-color: white !important;
        }

        .bottom-bar {
            float: none !important;
        }

        /*Commented By Yasmin on 2nd July 2018*/
        #DateAssigned {
            /*width:123%!important;*/
        }
        /*Change By Yasmin on 2nd July 2018*/
        #idTentativeLeavingDate {
            float: right;
            margin-top: -19px !important;
            font-size: 14px;
            margin-right: -16px;
        }
        /*Commented By Yasmin on 2nd July 2018*/
        #ContractDate {
            /*width:123%!important;*/
        }

        #ContractDate1 {
            float: right;
            margin-top: -19px;
            font-size: 14px;
            margin-right: -17px;
        }

        #divCustomerContact table tr td:nth-child(1) {
            word-break: break-all !important;
        }


        #divCustomerContact .dataTables_scrollBody .clsTRColumnHeader {
            height: 0PX !important;
        }

        #divCustomerContactcilent .dataTables_scrollBody .clsTRColumnHeader {
            height: 0PX !important;
        }


        #DivList .dataTables_scrollBody .clsTRColumnHeader {
            height: 0PX !important;
        }

        #EditImage {
            padding-left: 11%;
        }

        #fileUpload {
            display: none;
        }

        #edit {
            margin-left: -4%;
        }

        /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
            color: #bbb !important;
        }

        #divCustomerContact .table {
            width: 100% !important;
        }

        table {
            table-layout: fixed;
            word-wrap: break-word;
        }

        .dataTables_info {
            margin-top: -28px !important;
            font-size: 13px !important;
        }

        @media (min-width:1200px) {
        }
        /*Added By Yasmin on 2nd July 2018*/
        @media (max-width:992px) {
            #divTypeBottom .col-sm-3 {
                max-width: 100%;
            }

            .form-horizontal .form-group {
                margin-right: -15px;
                margin-left: 0px;
            }
        }
       /*Change By Yasmin on 9th June*/
        @media (max-width:1100px) {
            .dataTables_paginate {
                margin-right: -14PX;
                margin-top: 0px;
                float: right;
            }

            #divCustomerContactcilent .dataTables_paginate {
                margin-right: -2PX;
                margin-top: 10px;
            }

            .dataTables_info {
                margin-top:0px !important;
                font-size: 13px !important;
            }
        }
    </style>

<body class="" id="page-top">
    <input type="hidden" id="hdnCustomerID" name="hdnCustomerID" value="" />
    <input type="hidden" id="hdnCustomerContactID" name="hdnCustomerContactID" value="" />
    <input type="hidden" id="hdnCustomerCilentID" name="hdnCustomerCilentID" value="" />
    <%WriteTabsControls("", "Load", "")%>
</body>
</html>

<!-- Bootstrap core JavaScript -->

<%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>

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
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
<!-- Time picker -->
<script src="../../../EnhancementFiles/vendor/datatables/jquery.dataTables.js"></script>
<script src="../../../EnhancementFiles/vendor/datatables/dataTables.bootstrap4.js"></script>
<script src="js/timepicker.min.js"></script>
<script src="js/timepicker.js"></script>
<script>
    // $(function () {
    //    $('#DateAssigned').timepicker();
    //    $('#ContractDate').timepicker();
    //});
</script>

<!-- End of time picker -->
<script>
    $(function () {


        $('#DateAssigned').datepicker();
        $('#ContractDate').datepicker();


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
    var strPageName = "CRM_CustomerMaster.aspx";
    var EditCustomerID = 0;
    var CustomerContact = 0;
    var GlobalContactCustomerId = 0;
    var GlobalContactCilentID = 0;
    var imgsrc;
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
        //  $("#divSubRequestType").css("display","none");
        imgsrc = $('#imgUser').attr('src');
        //Added By Chakshuta H on 5thJan-2017 Purpose::Issue id-9869
        $("#Addaccordion").click(function () {

            if ($("#collapseOne").hasClass("in")) {
                $("#divSubRequestType").css("display", "none");
                /*Commented By Yasmin on 9th June*/
                //$("#headingOne").css("margin-top", "11px");
            }
            else {
                $("#divSubRequestType").css("display", "block");

            }
        })
        //End Of Added By Chakshuta H on 5thJan-2017 Purpose::Issue id-9869

    });
</script>


<script>


    var TabName = "";
    var Flag = "";
    function openCity1(evt, cityName) {
        // debugger;
        ShowHideHorizontalDiv();
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
    // Get the element with id="defaultOpen" and click on it
    //   document.getElementById("defaultOpen1").click();
    function openCity4(evt, cityName) {
        //debugger;
        var i, tabcontent4, tablinks4;
        //tabcontent4 = document.getElementsByClassName("tabcontent4");
        //for (i = 0; i < tabcontent4.length; i++)
        //{
        //    tabcontent4[i].style.display = "none";
        //}
        //tablinks4 = document.getElementsByClassName("tablinks4");
        //for (i = 0; i < tablinks4.length; i++)
        //{
        //    tablinks4[i].className = tablinks4[i].className.replace(" active", "");
        //}
        //document.getElementById(cityName).style.display = "block";
        //evt.currentTarget.className += " active";

        if (cityName == "ConfigureHRM") {
            PlotSubtab1("PlotSubtab");

            //Added by Usha Pandit on 05 JAN 2018
            if (WhichBrowser() == "IE") {
                $("#ConfigureHRM").find(".top-bar").find(".fa.fa-plus").css("display", "inline");
            }
            //End of Addition by Usha Pandit on 05 JAN 2018

            //ShowHideHorizontalDiv();
            //RefreshSubTags();
            RefreshGridDetails();
        }
        if (cityName == "ProjectMapping") {
            PlotSubtab1("ClientContact");

            //Added by Usha Pandit on 05 JAN 2018
            if (WhichBrowser() == "IE") {
                $("#ProjectMapping").find(".top-bar").find(".fa.fa-plus").css("display", "inline");
            }
            //End of Addition by Usha Pandit on 05 JAN 2018

            ////RefreshSubTags();
            //ShowHideHorizontalDiv()

            RefreshGrid('ClientContact');

            RefreshGridDetails();
        }


    }

    function ShowHideHorizontalDiv() {
        if ($("#DivHorizontal").hasClass("clsShowHorizontalDiv")) {
            $("#DivHorizontal").removeClass("clsShowHorizontalDiv");

        }
        $("#DivHorizontal").addClass("clsHideHorizontalDiv");
    }


    $(window).load(function () {

        RefreshGridDetails();
        RemoveFrameLoader();
    });

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

        ////if (WhichBrowser() == "IE")
        ////{
        ////    intDivGridHeight = (window.innerHeight / 2);

        ////    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        ////       // alert('111');
        ////        intDivGridListHeight = parseInt(window.innerHeight) - 320;
        ////    }
        ////    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        ////       // alert('11');
        ////        intDivGridListHeight = parseInt(window.innerHeight) - 200;
        ////    }
        ////    else {
        ////        //alert('1');
        ////        $('#divTypeStatus').css('height', " 700px");
        ////        intDivGridListHeight = parseInt(window.innerHeight) - 130;
        ////    }

        ////    // alert('1');
        ////    //alert(intDivGridListHeight - 500);
        //// //   $('.panel-body').css('height', intDivGridListHeight + "px");
        ////    $('#divRequestTypes').css('height', intDivGridListHeight - 550 + "px");
        ////    //$('#Type').css('height', " 400px");
        ////    //$('#divTypeStatus').css('height', " 400px");
        ////   // $('#Type').css('height', intDivGridListHeight + 500 + "px");
        ////}
        ////else {
        ////    intDivGridHeight = (window.innerHeight / 2);
        ////   // alert('2');
        ////    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024)
        ////    {
        ////        //alert('21');
        ////        intDivGridListHeight = parseInt(window.innerHeight) - 350;

        ////        $('#divRequestTypes').css('height', intDivGridListHeight - 150 + "px");

        ////    }
        ////    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        ////        // alert('22');

        ////        intDivGridListHeight = parseInt(window.innerHeight) - 440;

        ////        $('#divRequestTypes').css('height', intDivGridListHeight - 110 + "px");
        ////       // $('#Type').css('height', " 400px");
        ////         $('#divTypeStatus').css('height', " 450px");
        ////    }
        ////    else {
        ////        //alert('21');
        ////        intDivGridListHeight = parseInt(window.innerHeight) - 590;
        ////        //alert(intDivGridListHeight - 250)
        ////        //$('#divRequestTypes').css('height', intDivGridListHeight - 340 + "px");
        ////        //$('#Type').css('height', " 400px");
        ////       // $('#divTypeStatus').css('height', " 400px");
        ////    }
        ////   // $('#divRequestTypes').css('height', intDivGridListHeight - 230 + "px");
        ////   // $('#divTypeBottom').css('height', intDivGridListHeight + 70 + "px");
        ////  //  $('.panel-body').css('height', intDivGridListHeight - 180 + "px");
        ////   // alert(intDivGridListHeight-500);
        ////   // $('#Type').css('height', " 400px");
        ////   // $('#divTypeStatus').css('height', " 400px");

        ////    //$('#Type').css('overflow-Y', 'auto');
        ////   // $('#Type').css('overflow-X', 'hidden');
        ////}

        //   $(".table-responsive:first table").addClass("table");


        var intDivGridHeight, intDivGridListHeight
        intDivGridListHeight = parseInt(window.innerHeight);
        if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

            $("#divTypeStatus").css('height', intDivGridListHeight - 280 + "px");
        }

        else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

            $("#divTypeStatus").css('height', intDivGridListHeight - 320 + "px");
        }
        else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

            $("#divTypeStatus").css('height', intDivGridListHeight - 280 + "px");
        }
        else {
            $("#divTypeStatus").css('height', intDivGridListHeight - 280 + "px");
        }


        datatables(DivId, DivSerach, "");


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
            // scrollY: '130px',
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

    //var EditCustomerID = 0;

    function Edit_Customer(CustomerID) {
        // debugger;
        EditCustomerID = CustomerID;
        document.getElementById('hdnCustomerID').value = CustomerID;
        $.ajax({
            type: "POST",
            url: "CRM_CustomerMaster.aspx/GetCustomerDetails",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ CustomerID: CustomerID }),
            success: function (data) {
                var arrResult = data.d.split('##');
                // alert(data.d);
                //alert(CustomerID)
                $('#CustomerName').val(arrResult[0]);
                $('#AbbreviatedName').val(arrResult[1]);
                $('#DateAssigned').val(arrResult[2]);
                $('#ContractDate').val(arrResult[3]);
                $('#EmailID').val(arrResult[4]);
                $('#Address').val(arrResult[5]);
                $('#City').val(arrResult[6]);
                $('#State').val(arrResult[7]);
                $('#PinCode').val(arrResult[8]);
                CustomerContact = arrResult[9];
                // alert(arrResult[10]);

                // $('#imgUser').attr("src", arrResult[10]);


                imgsrc = $('#imgUser').attr('src');     //Added by Usha Pandit on 16.12.2017 for image upload validation

                document.getElementById('idUploadImage').innerHTML = "";
                document.getElementById('idUploadImage').innerHTML = "<img id='imgUser' alt='Upload Image' src='" + arrResult[10] + "' />";

                if (arrResult[11] == "True") {
                    $("#SeeHelpdeskSLA").prop('checked', true);
                }
                else {
                    $("#SeeHelpdeskSLA").prop('checked', false);
                }
                $("#imgUser").css('margin-left', '-16px');
                $("#imgUser").css('margin-top', '-1px');
                $("#imgUser").css('line-height', '20px');
                $("#divRequestTypes").css("display", "none");
                $("#divTypeTab").css("display", "none");
                $("#EditImage").css("display", "block");
                //$("#collapseOne").addclass("in");
                //$("#divTypeTab").css("visible","");

                //PlotSubtab();
                // alert(CustomerContact);
                var strResult1, data1;
                // alert(EditCustomerID);
                data1 = JSON.stringify({ CustomerID: EditCustomerID, Flag: "PlotSubtab" });
                strResult1 = AJAXCallWithResult(strPageName + "/PlotSubtab", data1, false);
                //alert(strResult1.d);
                if (strResult1.d != '') {

                    $("#divSubRequestType").html("");
                    $("#divSubRequestType").html(strResult1.d);
                    $("#divSubRequestType").addClass("table");

                    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                        intDivGridListHeight = parseInt(window.innerHeight) - 250;

                    }
                    else {
                        //  intDivGridListHeight = (window.innerHeight / 3) + 6;
                        intDivGridListHeight = parseInt(window.innerHeight) - 600;
                    }
                    //  alert(intDivGridListHeight);
                    // datatableMainPage("divCustomerContact", intDivGridListHeight);

                    datatables("divCustomerContact", "", "")
                    //$("#divRequestTypes").css("display", "block");
                    /*Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
                    if ($("#Addaccordion").hasClass("collapsed")) {
                        $("#Addaccordion").removeClass("collapsed");
                        $("#collapseOne").css('height', 'auto !important');
                        $("#collapseOne").addClass('in');
                    }

                    //Added by Usha Pandit on 05 JAN 2018

                    if (WhichBrowser() == "IE") {
                        $("#ConfigureHRM").find(".top-bar").find(".fa.fa-plus").css("display", "inline");
                    }

                    if (WhichBrowser() == "IE") {
                        $("#ProjectMapping").find(".top-bar").find(".fa.fa-plus").css("display", "inline");
                    }

                    //End of Addition by Usha Pandit on 05 JAN 2018
                }
                /*End of Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
                $("#divSubRequestType").css("display", "block");
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

        data1 = JSON.stringify({ CustomerID: EditCustomerID, Flag: Flag });
        strResult1 = AJAXCallWithResult(strPageName + "/PlotSubtab", data1, false);
        // alert(strResult1.d);
        if (strResult1.d != '') {
            if (Flag == "PlotSubtab") {
                $("#DivHorizontal").html("");
                $("#DivHorizontal").html(strResult1.d);
                // $("#divSubRequestType").addClass("table");
                $("#divSubRequestType").css("display", "block!imporatnt");
                // $("#btnConfigureHRM")
                if ($("#btnConfigureHRM").hasClass('active')) {

                    $("#btnConfigureHRM").removeClass('active')
                    $("#btnConfigureHRM").addClass('active')
                }
                else {
                    $("#btnConfigureHRM").addClass('active')
                    // $("#btnProjectMapping").css('Margin-top', '1px solid #ddd')
                    // $("#btnProjectMapping").css('Margin-bottom', '')
                    $("#btnProjectMapping").removeClass('active')

                }


            }

            else {

                $("#DivHorizontal").html("");
                $("#DivHorizontal").html(strResult1.d);
                // $("#divSubRequestType").addClass("table");
                $("#divCustomerContactcilent").css("display", "block!imporatnt");

                if ($("#btnProjectMapping").hasClass('active')) {

                    $("#btnProjectMapping").removeClass('active')

                }
                else {
                    $("#btnProjectMapping").addClass('active')
                    $("#btnConfigureHRM").removeClass('active')

                }
            }
            if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                intDivGridListHeight = parseInt(window.innerHeight) - 250;

            }
            else {
                //  intDivGridListHeight = (window.innerHeight / 3) + 6;
                intDivGridListHeight = parseInt(window.innerHeight) - 600;
            }
            //  alert(intDivGridListHeight);
            // datatableMainPage("divCustomerContact", intDivGridListHeight);
            if (Flag = "PlotSubtab") {
                datatables("divCustomerContact", "", intDivGridListHeight)
            }
            else if (Flag = "ClientContact") {
                datatables("divCustomerContact", "", intDivGridListHeight)
            }
        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });
    }

    function Edit_CustomerContact(obj, CustomerId, ContactCustomerId) {

        GlobalContactCustomerId = ContactCustomerId
        //alert(ContactCustomerId);
        $.ajax({
            type: "POST",
            url: "CRM_CustomerMaster.aspx/GetCustomerContactDetails",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ ContactCustomerId: ContactCustomerId }),
            success: function (data) {
                var arrResult = data.d.split('##');

                $('#ContactPerson').val(arrResult[0]);
                $('#TypeofContact').val(arrResult[1]);
                $('#ContactEmailID').val(arrResult[2]);
                $('#Mobile').val(arrResult[3]);
                $('#Phone').val(arrResult[4]);
                $('#OnlineContact').val(arrResult[5]);
                $('#Fax').val(arrResult[6]);
                //$('#State').val(arrResult[7]);
                //$('#PinCode').val(arrResult[8]);
                $("#collapseOne11").addClass("in");
                if ($("#addContact").hasClass("collapsed")) {
                    $("#addContact").removeClass("collapsed");
                    $("#collapseOne11").css('height', 'auto !important');
                    $("#collapseOne11").addClass('in');
                }
                $("#divCustomerContact").css("display", "none");

            }
        });
    }


    function SaveAddCustomerdetails(SaveFlag) {


        SaveCustomerdetails(SaveFlag)
        //$("#divSubRequestType").css("display", "none");


    }

    function SaveCustomerdetails(SaveFlag) {


        if (ValidateCustomer() == 0) {

            if (document.getElementById('hdnCustomerID').value == '') {
                CustomerID = 0;

            }
            else {

                CustomerID = EditCustomerID;

            }
            //alert(CustomerID);
            var CustomerName = $('#CustomerName').val();
            var AbbreviatedName = $('#AbbreviatedName').val();
            var DateAssigned = $('#DateAssigned').val();
            var ContractDate = $('#ContractDate').val();
            var Region = $('#Region').val();


            var EmailID = $('#EmailID').val();
            var Address = $('#Address').val();
            var City = $('#City').val();

            var State = $('#State').val();
            var PinCode = $('#PinCode').val();
            var SeeHelpdeskSLAvalue;
            var SeeHelpdeskSLA = document.getElementById('SeeHelpdeskSLA');
            if (SeeHelpdeskSLA.checked == true) {
                SeeHelpdeskSLAvalue = 1;
            }
            else {
                SeeHelpdeskSLAvalue = 0;
            }


            if (DateAssigned == "" || DateAssigned == undefined) {

                DateAssigned = "";
            }

            if (EmailID == "" || EmailID == undefined) {

                EmailID = "";
            }


            if (ContractDate == "" || ContractDate == undefined) {

                ContractDate = "";
            }


            if (State == "" || State == undefined) {

                State = "";
            }


            if (PinCode == "" || PinCode == undefined) {

                PinCode = "";
            }

            if (Region == "" || Region == undefined) {

                Region = "";
            }




            var strURL = "CRM_CustomerMaster.aspx";
            //alert(CustomerID)
            var formData = new FormData();
            if (typeof fileObject == "undefined") {
                formData.append('EmployeePhoto', "");
            }
            else {
                formData.append('EmployeePhoto', fileObject[0]);
            }
            formData.append('Mode', 'SaveCustomerInfo');
            formData.append('CustomerName', CustomerName);
            formData.append('AbbreviatedName', AbbreviatedName);
            formData.append('Region', Region);
            formData.append('DateAssigned', DateAssigned);
            formData.append('ContractDate', ContractDate);
            formData.append('EmailID', EmailID);
            formData.append('Address', Address);
            formData.append('City', City);
            formData.append('State', State);
            formData.append('PinCode', PinCode);
            formData.append('SeeHelpdeskSLAvalue', SeeHelpdeskSLAvalue)
            formData.append('hdnCustomerID', CustomerID);

            setFrameLoader();
            $.ajax({
                url: strURL,  //Server script to process data
                type: 'POST',
                data: formData,
                async: false,
                success: function (result) {
                    var arrResult = result.split('##');

                    // alert(arrResult);
                    var newCustomerID = arrResult[1];
                    var Flag = arrResult[2];

                    //alert(Flag)

                    // alert(arrResult[1]);
                    //$('#CustomerName').val(arrResult[0]);
                    $('#UploadImage').html(arrResult[0]);
                    $("#imgUser").css('margin-left', '-16px');
                    $("#imgUser").css('margin-top', '-1px');
                    $("#imgUser").css('line-height', '20px');
                    //setTimeout(function () { RemoveFrameLoader(); }, 1000);
                    if (Flag == 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Customer Created successfully', 'success');
                    }
                    else {

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Customer details updated successfully', 'success');
                    }

                    if (SaveFlag == 'new') {

                        Edit_Customer(newCustomerID);

                    }
                    else {
                        $('#CustomerName').val("");
                        $('#AbbreviatedName').val("");
                        $('#DateAssigned').val("");
                        $('#ContractDate').val("");
                        $('#EmailID').val("");
                        $('#Address').val("");
                        $('#City').val("");
                        $('#State').val("");
                        $('#PinCode').val("");
                        $('#Region').val("");
                        $('#SeeHelpdeskSLA').val("");
                        document.getElementById('UploadImage').innerHTML = "";
                        document.getElementById('UploadImage').innerHTML = "<div class='col-xs-1' id='idUploadImage' ><div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='../../../Images/Photo/no-photo.png' /></a></div></div></div>";
                        $("#EditImage").css("display", "none");

                        if ($("#SeeHelpdeskSLA").checked == true) {
                            $("#SeeHelpdeskSLA").prop('checked', true);
                        }
                        else {
                            $("#SeeHelpdeskSLA").prop('checked', false);
                        }

                    }
                    // $("#divRequestTypes").css("display", "block");




                    if (SaveFlag == 'SaveAddnew') {
                        $("#divSubRequestType").css("display", "none");
                        $("#headingOne").css("margin-top", "11px");
                    }
                    else {
                        $("#divSubRequestType").css("display", "block");
                    }


                    // $("#divTypeTab").css("display", "none");


                },
                error: function (xhr, status, error) {
                    setTimeout(function () { RemoveFrameLoader(); }, 1000);
                    console.log(xhr.responseText);
                },
                cache: false,
                contentType: false,
                processData: false
            });
            RemoveFrameLoader();
        }


    }
    // }

    function Edit_ClientContact(obj, CustomerId, CilentCustomerId) {
        GlobalContactCilentID = CilentCustomerId;
        $.ajax({
            type: "POST",
            url: "CRM_CustomerMaster.aspx/GetCilentContactDetails",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ CilentCustomerId: CilentCustomerId }),
            success: function (data) {
                var arrResult = data.d.split('##');

                $('#ContactAbbreviatedName').val(arrResult[0]);
                $('#ClientName').val(arrResult[1]);
                $('#ContactAddress').val(arrResult[2]);
                $('#ContactCity').val(arrResult[3]);
                $('#ContactState').val(arrResult[4]);
                $('#EmailIDClient').val(arrResult[6]);
                $('#ContactPerson').val(arrResult[5]);
                //$('#State').val(arrResult[7]);
                //$('#PinCode').val(arrResult[8]);
                //if ($("#collapseOne22").hasclass('in'))
                //{
                $('#collapseOne22').addClass("in");
                $('#divCustomerContactcilent').css("display", "none");
                if ($("#addclient").hasClass("collapsed")) {
                    $("#addclient").removeClass("collapsed");
                    $("#collapseOne22").css('height', 'auto !important');
                    $("#collapseOne22").addClass('in');
                }
                //}
                //else {

                //    $('#collapseOne22').addClass("in");
                //}



            }
        });


    }


    function CancelCustomerContact() {

        $('#ContactPerson').val("");
        $('#TypeofContact').val("");
        $('#ContactEmailID').val("");
        $('#Mobile').val("");
        $('#Fax').val("");
        $('#Phone').val("");
        $('#OnlineContact').val("");
        $("#divCustomerContact").css("display", "block");
        //Cancel();


    }


    function validateCustomerContact() {


        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
        if ($("#ContactPerson").val() == "") {
            strmsg = '- Contact Person should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
        }
          //Added by Dipali V On 22nd May 2019 for Duplicate Contact Person
        if (checkvalue == 0) {
            if (ValidateContactPerson() == 1) {
                strmsg = '- Contact Person Already Exists';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }
        }
       //end of Added by Dipali V On 22nd May 2019 for Duplicate Contact Person
        if ($("#TypeofContact").val() == "") {
            strmsg = '- Type of Contact should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
        }


        if ($("#ContactEmailID").val() == "") {
            strmsg = '- EmailID should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
        }

        if ($("#ContactEmailID").val() != "") {
            objTxt = $("#ContactEmailID").val();
            flag = ValidateEmailID(objTxt);
            if (flag == false) {
                strmsg = '- Email ID should be Valid';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }
        }
        //Added by Usha Pandit on 17.05.2019 for Duplicate Email Save Issue
        if (checkvalue == 0) {
            if (ValidateDuplicateEmailId() == 1) {
                strmsg = '- Email ID Already Exists';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }
        }
        //End of Added by Usha Pandit on 17.05.2019 for Duplicate Email Save Issue
        if ($("#Mobile").val() != "") {
            if (checkSpecialCharacter($('#Mobile').val()) == true) {
                strmsg = '- A Mobile No. cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;

            }
        }
        if ($("#Phone").val() != "") {
            if (checkSpecialCharacter($('#Phone').val()) == true) {
                strmsg = '- A Phone No. cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;

            }
        }

        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;

    }
    function SaveCustomerdetails1() {


        if (validateCustomerContact() == 0) {


            if (document.getElementById('hdnCustomerContactID').value != '') {
                CustomerContactID = 0;

            }
            else {

                CustomerContactID = GlobalContactCustomerId;

            }

            var ContactPerson = $('#ContactPerson').val();
            var TypeofContact = $('#TypeofContact').val();
            var ContactEmailID = $('#ContactEmailID').val();
            var Fax = $('#Fax').val();
            var Phone = $('#Phone').val();

            var Mobile = $('#Mobile').val();
            var OnlineContact = $('#OnlineContact').val();




            if (OnlineContact == "" || OnlineContact == undefined) {

                OnlineContact = "";
            }

            if (Phone == "" || Phone == undefined) {

                Phone = "";
            }


            if (Fax == "" || Fax == undefined) {

                Fax = "";
            }


            if (ContactEmailID == "" || ContactEmailID == undefined) {

                ContactEmailID = "";
            }


            if (TypeofContact == "" || TypeofContact == undefined) {

                TypeofContact = "";
            }

            data = JSON.stringify({
                ContactPerson: ContactPerson, TypeofContact: TypeofContact, ContactEmailID: ContactEmailID,
                Fax: Fax, Phone: Phone, Mobile: Mobile, OnlineContact: OnlineContact,
                CustomerContactID: CustomerContactID, EditCustomerID: EditCustomerID


            });
            //alert(data);
            strResult = AJAXCallWithResult("CRM_CustomerMaster.aspx/SaveCustContactDetails", data, false);

            if (strResult.d != "") {
                if (GlobalContactCustomerId == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Customer Contact Created successfully', 'success');
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Customer Contact updated successfully', 'success');
                }
                RefreshGrid('PlotSubtab');
                //#divCustomerContact {
                //    height:auto!important;
                //}
                // CancelCustomerContact();




            }

        }



    }

    function SaveAddCustomerdetails1() {

        SaveCustomerdetails1();
        CancelCustomerContact();

    }
    function RefreshGrid(cityName) {
        // debugger;
        var strResult, data;
        var GridParameter = {};
        GlobalContactCustomerId = 0;
        GridParameter.cityName = cityName;

        data = JSON.stringify({ GridParameter: GridParameter, CustomerID: EditCustomerID, Role: "", Status: "" });
        // alert(data);
        strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);
        var DivId;
        // alert(strResult);
        var DivSerach;
        // alert(strResult.d);
        if (strResult != '' && strResult != 'undefined') {
            if (cityName == "Type") {
                DivId = "DivList";
                DivSerach = "SearchRquestType";
                $("#" + DivId + " .table-responsive:first").html(strResult.d);
            }
            else if (cityName == "PlotSubtab") {
                DivId = "divCustomerContact";
                // var tablename = "divCustomerContact";
                $("#ConfigureHRM" + " .table-responsive:first").html(strResult.d);
                DivSerach = "";
            }
            else if (cityName == "ClientContact") {
                DivId = "divCustomerContactcilent";
                DivSerach = "";
                $("#ProjectMapping" + " .table-responsive:first").html(strResult.d);
            }

            if (cityName == "Type") {

                (String(cityName).toUpperCase() != "AUTOCLOSE")
                {
                    $("#" + cityName + " .table-responsive:first").html(strResult.d);

                    $("#" + cityName + " .table-responsive:first table").addClass("table");
                }
            }
        }
        var TypeDiv; var accordion;
        var intDivGridHeight

        //if (WhichBrowser() == "IE")
        //{
        //    intDivGridHeight = (window.innerHeight / 2);

        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //        // alert('111');
        //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //        // alert('11');
        //        intDivGridListHeight = parseInt(window.innerHeight) - 200;
        //        $('#divRequestTypes').css('height', intDivGridListHeight - 110 + "px");
        //        // $('#Type').css('height', " 400px");
        //        $('#divTypeStatus').css('height', " 450px");
        //    }
        //    else {
        //        // alert('1');
        //        intDivGridListHeight = parseInt(window.innerHeight) - 130;
        //    }

        //    // alert('1');
        //    //alert(intDivGridListHeight - 500);
        //    //   $('.panel-body').css('height', intDivGridListHeight + "px");
        //  //  $('#divRequestTypes').css('height', intDivGridListHeight - 550 + "px");
        //    intDivGridListHeight = parseInt(window.innerHeight) - 590;
        //    //alert(intDivGridListHeight - 250)
        //    $('#divRequestTypes').css('height', intDivGridListHeight - 180 + "px");
        //    $('#divTypeStatus').css('height', " 700px");
        //    //$('#Type').css('height', " 400px");
        //    //$('#divTypeStatus').css('height', " 400px");
        //    // $('#Type').css('height', intDivGridListHeight + 500 + "px");
        //}
        //else {
        //    intDivGridHeight = (window.innerHeight / 2);

        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
        //        //alert('21');
        //        intDivGridListHeight = parseInt(window.innerHeight) - 350;
        //       // alert(intDivGridListHeight - 150);
        //        $('#divRequestTypes').css('height', intDivGridListHeight - 150 + "px");
        //        //alert('22');
        //       // $('#divCustomerContact').css('height', intDivGridListHeight - 550 + "px");
        //       // $('#divCustomerContactcilent').css('height', intDivGridListHeight - 550 + "px");
        //    }
        //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
        //        // alert('221');
        //        // alert(intDivGridListHeight - 110);
        //        intDivGridListHeight = parseInt(window.innerHeight) - 440;

        //        $('#divRequestTypes').css('height', intDivGridListHeight - 110 + "px");
        //        // $('#Type').css('height', " 400px");
        //        $('#divTypeStatus').css('height', " 450px");
        //       // $('#divCustomerContact').css('height', intDivGridListHeight - 550 + "px");
        //       // $('#<cilent').css('height', intDivGridListHeight - 550 + "px");
        //    }
        //    else {
        //        //alert('2111');
        //       // alert(intDivGridListHeight - 340);
        //        intDivGridListHeight = parseInt(window.innerHeight) - 590;
        //        //alert(intDivGridListHeight - 250)
        //        $('#divRequestTypes').css('height', intDivGridListHeight - 180 + "px");
        //        $('#divTypeStatus').css('height', " 700px");
        //       // $('#divCustomerContact').css('height', intDivGridListHeight - 550 + "px");
        //       // $('#divCustomerContactcilent').css('height', intDivGridListHeight - 550 + "px");
        //    }


        //}

        var intDivGridHeight, intDivGridListHeight
        intDivGridListHeight = parseInt(window.innerHeight);
        if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

            $("#divTypeStatus").css('height', intDivGridListHeight - 280 + "px");
        }

        else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

            $("#divTypeStatus").css('height', intDivGridListHeight - 320 + "px");
        }
        else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

            $("#divTypeStatus").css('height', intDivGridListHeight - 280 + "px");
        }
        else {
            $("#divTypeStatus").css('height', intDivGridListHeight - 280 + "px");
        }


        datatables(DivId, DivSerach, "");

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });
    }






    function Delete_Customer(obj, Customer) {

        data = JSON.stringify({ Customer: Customer });

        strResult = AJAXCallWithResult("CRM_CustomerMaster.aspx/DeleteCustomer", data, false);
       
        if (strResult.d != "") {
            //Commmented and added by Yogesh Jalamkar on 16-DEC-2017 Purpose:Issue fixing issueID = 9883
            //var strResult = strResult.d;
            var strResult = strResult.d.split('$$');
            //End by Yogesh Jalamkar
            alertify.set('notifier', 'position', 'top-right');

            //Commmented and added by Yogesh Jalamkar on 16-DEC-2017 Purpose:Issue fixing issueID = 9883
            //alertify.notify(strResult[0], 'success');
            alertify.notify(strResult[0], strResult[1]);
            //End by Yogesh Jalamkar
            RefreshGrid('Type');





        }

    }




    function Delete_CustomerContact(obj, CustomerID, CustomercontactId) {


        data = JSON.stringify({ CustomercontactId: CustomercontactId });
        //alert(data);
        strResult = AJAXCallWithResult("CRM_CustomerMaster.aspx/DeleteCustomerContact", data, false);

        if (strResult.d != "") {
            var Result = strResult.d;
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(Result, 'success');
            RefreshGrid('PlotSubtab');





        }


    }


    function Delete_ClientCustomer(obj, CustomerID, CustomerCilentId) {

        data = JSON.stringify({ CustomerCilentId: CustomerCilentId });
        strResult = AJAXCallWithResult("CRM_CustomerMaster.aspx/DeleteCustomerCilent", data, false);

        if (strResult.d != "") {
            var Result = strResult.d;
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(Result, 'success');
            RefreshGrid('ClientContact');
        }
    }

    //Added by Usha Pandit on 03 JAN 2018
    var specialKeys = new Array();
    specialKeys.push(8); //Backspace
    function validateContact(e) {
        var keyCode = e.which ? e.which : e.keyCode
        var flag = 0;
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
        {
            if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please enter only positive numeric value for "Contact".', 'error');
            }
        }
        return ret;
    }
    //End of added by Usha Pandit on 03 JAN 2018

    function ValidateCustomer() {
        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
        if ($("#CustomerName").val() == "") {
            strmsg = '- Customer Name should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
        }

        if ($("#CustomerName").val() != "") {
            if (checkSpecialCharacter($('#CustomerName').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- Customer Name cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;

            }


            var objCustomerName = $("#CustomerName").val();
            if (objCustomerName.indexOf("'") != -1) {
                strmsg = '- Customer Name should not contain single quote.';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }

        }
        if ($("#AbbreviatedName").val() == "") {
            strmsg = '- Abbreviated name should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
        }

        if ($("#AbbreviatedName").val() != "") {

            //Commented by Usha Pandit on 16.12.2017 for abbreviated name should accept special chars
            //if (checkSpecialCharacter($('#AbbreviatedName').val()) == true) {
            //    // alertify.set('notifier', 'position', 'top-right');
            //    strmsg = '- A Abbreviated name cannot contain any of these /\\:*?<>|,"+- Characters';
            //    errorMsg += "<li>" + strmsg + "</li>";
            //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //    checkvalue = 1;

            //}
            //End of comment

            var objCustomerName = $("#AbbreviatedName").val();
            if (objCustomerName.indexOf("'") != -1) {
                strmsg = '- Abbreviated name should not contain single quote.';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }

        }

        if ($("#AbbreviatedName").val() != "") {

            if (document.getElementById('hdnCustomerID').value == '') {
                CustomerID = 0;

            }
            else {

                CustomerID = EditCustomerID;

            }

            var url = 'CRM_CustomerMaster.aspx/CheckCustomerAbbName';
            var data = JSON.stringify({ Flag: "Customer", AbbName: $('#AbbreviatedName').val(), CustomerID: CustomerID });

            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                async: false,
                timeout: 180000,
                success: function (result) {
                    if (result.d == 1) {
                        checkValu = 1;
                        if (checkValu == 1) {

                            strmsg = '- Abbreviated name  Already Exists';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            checkvalue = 1;
                        }
                    }
                },
                //error: function (xhr, status, error) {
                //    console.log(xhr.responseText);
                //    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                //}
            });


        }
        //Added by Yogesh Jalamkar on 21-DEC-2017 Purpose:Issue fixing issue id = 9837
        var objSignedDate = GetObjectReference('', 'DateAssigned');
        var objContractDate = GetObjectReference('', 'ContractDate');
        var nowDate = new Date();
        var currentDate = nowDate.getFullYear() + '/' + (nowDate.getMonth() + 1) + '/' + nowDate.getDate();

        if (new Date(objSignedDate.value) > new Date(objContractDate.value)) {
            strmsg = "<li>- Date signed should not be greater than Contract Validity Date. </li>";
            errorMsg += "<li>" + strmsg + "</li>";
            checkvalue = 1;
        }
        if (EditCustomerID == 0 || EditCustomerID == undefined) {
            if (new Date(objContractDate.value) < new Date(currentDate)) {
                strmsg = "<li>- Contract Validity Date should not be less than Today's Date. </li>";
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }
        }
        //End by Yogesh Jalamkar
        if ($("#EmailID").val() == "") {

            strmsg = '- Email ID should not be left blank.';
            errorMsg += "<li>" + strmsg + "</li>";

            checkvalue = 1;

        }

        if ($("#EmailID").val() != "") {
            //if (checkSpecialCharacter($('#EmailID').val()) == true) 
            //{
            //    // alertify.set('notifier', 'position', 'top-right');
            //    strmsg = '- A EmailID cannot contain any of these /\\:*?<>|,"+- Characters';
            //    errorMsg += "<li>" + strmsg + "</li>";
            //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //    checkvalue = 1;

            //}


            objTxt = $("#EmailID").val();
            flag = ValidateEmailID(objTxt);
            if (flag == false) {
                strmsg = '- Email ID should be Valid';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;


            }


        }

        //Commented by Usha pandit on 02 JAN 2018 for Issue 10091	
        //if ($("#Address").val() != "") 
        //{
        //    if (checkSpecialCharacter($('#Address').val()) == true)
        //    {
        //        // alertify.set('notifier', 'position', 'top-right');
        //        strmsg = '- A Address cannot contain any of these /\\:*?<>|,"+- Characters';
        //        errorMsg += "<li>" + strmsg + "</li>";
        //        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
        //        checkvalue = 1;

        //    }

        //}
        //End of Commented by Usha pandit on 02 JAN 2018 for Issue 10091	

        if ($("#City").val() != "") {
            if (checkSpecialCharacter($('#City').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- A City cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;

            }
        }

        if ($("#State").val() != "") {
            if (checkSpecialCharacter($('#State').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- A State cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;

            }

        }
        if ($("#PinCode").val() != "") {
            if (checkSpecialCharacter($('#PinCode').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- A Pin Code cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;

            }

            if (RestrictNonNumeric(document.getElementById('PinCode')) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = ' - Please Enter only positive numeric value for Pin Code !!!';
                errorMsg += "<li>" + strmsg + "</li>";
                //alertify.notify('', 'error');
                checkvalue = 1;

            }
        }
        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;




    }




    function AddCustomer() {


        $('#CustomerName').val("");
        $('#AbbreviatedName').val("");
        $('#DateAssigned').val("");
        $('#ContractDate').val("");
        $('#EmailID').val("");
        $('#Address').val("");
        $('#City').val("");
        $('#State').val("");
        $('#PinCode').val("");
        $('#Region').val("");
        $("#SeeHelpdeskSLA").val("");
        $('#imgUser').attr("src", "");

        document.getElementById('UploadImage').innerHTML = "";
        document.getElementById('UploadImage').innerHTML = "<div class='col-xs-1' id='idUploadImage' ><div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' title='Upload Image' alt='Upload Image' src='../../../Images/Photo/no-photo.png' /></a></div></div></div>";
        $("#EditImage").css("display", "none");

        $("#divRequestTypes").css("display", "none");
        $("#divSubRequestType").css("display", "none");

        /*Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne").css('height', 'auto !important');
            $("#collapseOne").addClass('in');
        }
        /*End of Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
        // $("#collapseOne").addClass("in")
    }

    function AddcustomerContact() {

        CancelCustomerContact();
        $("#divCustomerContact").css("display", "none");

        if ($("#addContact").hasClass("collapsed")) {
            $("#addContact").removeClass("collapsed");
            $("#collapseOne11").css('height', 'auto !important');
            $("#collapseOne11").addClass('in');
        }

    }


    function AddClientContact() {

        cancelCilent();
        if ($("#addclient").hasClass("collapsed")) {
            $("#addclient").removeClass("collapsed");
            $("#collapseOne22").css('height', 'auto !important');
            $("#collapseOne22").addClass('in');
        }
        $("#divCustomerContactcilent").css("display", "none");
    }

    function Cancel() {


        $('#CustomerName').val("");
        $('#AbbreviatedName').val("");
        $('#DateAssigned').val("");
        $('#ContractDate').val("");
        $('#EmailID').val("");
        $('#Address').val("");
        $('#City').val("");
        $('#State').val("");
        $('#PinCode').val("");
        $('#Region').val("");
        $("#SeeHelpdeskSLA").val("");
        // $('#imgUser').attr("src", "");
        document.getElementById('UploadImage').innerHTML = "";
        document.getElementById('UploadImage').innerHTML = "<div class='col-xs-1' id='idUploadImage' ><div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' title='Upload Image' alt='Upload Image' src='../../../Images/Photo/no-photo.png' /></a></div></div></div>";
        $("#EditImage").css("display", "none");
        // alert($("#SeeHelpdeskSLA").checked)
        if ($("#SeeHelpdeskSLA").checked == true) {
            $("#SeeHelpdeskSLA").prop('checked', true);
        }
        else {
            $("#SeeHelpdeskSLA").prop('checked', false);
        }

        $("#divTypeTab").css("display", "block");
        $("#divRequestTypes").css("display", "block");
        $("#divSubRequestType").html("");
        document.getElementById('hdnCustomerID').value = "";
        RefreshGrid('Type');
        //  $("#divSubRequestType").css("display", "none");
    }

    function cancelCilent() {

        var ContactAbbreviatedName = $("#ContactAbbreviatedName").val("");
        var ClientName = $("#ClientName").val("");
        var ContactAddress = $("#ContactAddress").val("");
        var ContactCity = $("#ContactCity").val("");
        var ContactState = $("#ContactState").val("");
        var EmailID = $("#EmailIDClient").val("");
        var ContactPerson = $("#ContactPerson").val("");
        $("#divCustomerContactcilent").css("display", "block");
        // Cancel();

    }

    function ValidateCilent() {
        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
        if ($("#ContactAbbreviatedName").val() == "") {
            strmsg = '- Abbreviated Name should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
        }


        if ($("#ContactAbbreviatedName").val() != "") {
            if (checkSpecialCharacter($('#ContactAbbreviatedName').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- A Abbreviated Name cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;

            }
            if ($("#ContactAbbreviatedName").val().length > 50) {
                strmsg = '- A Abbreviated Name should not be greater than 50 characters.';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }
        }

        if ($("#ClientName").val() == "") {
            strmsg = '- Client Name should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
        }

        if ($("#ClientName").val() != "") {
            if (checkSpecialCharacter($('#ClientName').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- A Client Name cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;

            }
            if ($("#ClientName").val().length > 50) {
                strmsg = '- A Client Name should not be greater than 50 characters.';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }

            //  var Clientname = "<%=StrCustomercilent%>";
            //  if (Clientname.indexOf(',' + $('#ClientName').val() + ',') != -1) {
            // alert("Title Already Exists");
            //   strmsg = '- Client Name  Already Exists';
            //   errorMsg += "<li>" + strmsg + "</li>";
            //   alertify.notify('Employee Code Already Exists', 'error');
            // checkvalue = 1;

            //}

        }
        if ($("#ClientName").val() != "") {

            if (document.getElementById('hdnCustomerCilentID').value != '') {
                CustomerID = 0;

            }
            else {

                CustomerID = GlobalContactCilentID;

            }
            var url = 'CRM_CustomerMaster.aspx/CheckCustomerAbbName';
            var data = JSON.stringify({ Flag: "Client", AbbName: $('#ClientName').val(), CustomerID: CustomerID });

            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                async: false,
                timeout: 180000,
                success: function (result) {
                    if (result.d == 1) {
                        checkValu = 1;
                        if (checkValu == 1) {

                            strmsg = '-  Client Name  Already Exists';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            checkvalue = 1;
                        }
                    }
                },

            });


        }



        //if ($("#EmailIDClient").val() == "")
        //{


        //    strmsg = 'EmailID should not be left blank';
        //    errorMsg += "<li>" + strmsg + "</li>";
        //    Flag = 1;
        //    checkvalue = 1;

        //}

        if ($("#EmailIDClient").val() != "") {
            objTxt = $("#EmailIDClient").val();
            flag = ValidateEmailID(objTxt);
            if (flag == false) {
                strmsg = '- Email ID should be Valid';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;


            }


        }

        if ($("#ContactPerson").val() == "") {
            //if (RestrictNonNumeric(document.getElementById('textBillingRate')) == true) {
            //    // alertify.set('notifier', 'position', 'top-right');
            //    strmsg = ' - Please Enter only positive numeric value for Standard Billing Rate numeric values !!!';
            //    errorMsg += "<li>" + strmsg + "</li>";
            //    //alertify.notify('', 'error');
            //    checkvalue = 1;

            //}
        }

        if ($("#ContactPerson").val() == "") {
            strmsg = '- Contact Person should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
        }


        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;




    }

    //function AddClientContact() {

    //    cancelCilent();

    //}

    function SaveCilentdetails() {
        if (ValidateCilent() == 0) {
            if (document.getElementById('hdnCustomerCilentID').value != '') {
                CustomerCilentID = 0;

            }
            else {

                CustomerCilentID = GlobalContactCilentID;

            }

            var ContactAbbreviatedName = $('#ContactAbbreviatedName').val();
            var ClientName = $('#ClientName').val();
            var ContactAddress = $('#ContactAddress').val();
            var ContactCity = $('#ContactCity').val();
            var ContactState = $('#ContactState').val();
            var ContactPerson = $('#ContactPerson').val();
            var EmailID = $('#EmailIDClient').val();





            if (ContactAbbreviatedName == "" || ContactAbbreviatedName == undefined) {

                ContactAbbreviatedName = "";
            }

            if (ClientName == "" || ClientName == undefined) {

                ClientName = "";
            }


            if (ContactAddress == "" || ContactAddress == undefined) {

                ContactAddress = "";
            }


            if (ContactCity == "" || ContactCity == undefined) {

                ContactCity = "";
            }


            if (ContactState == "" || ContactState == undefined) {

                ContactState = "";
            }

            if (ContactPerson == "" || ContactPerson == undefined) {

                ContactPerson = "";
            }

            data = JSON.stringify({
                ContactAbbreviatedName: ContactAbbreviatedName, ClientName: ClientName,
                ContactAddress: ContactAddress, ContactCity: ContactCity, ContactState: ContactState, ContactPerson: ContactPerson, EmailID: EmailID,
                CustomerCilentID: CustomerCilentID, EditCustomerID: EditCustomerID


            });
            //alert(data);
            strResult = AJAXCallWithResult("CRM_CustomerMaster.aspx/SaveCilentContactDetails", data, false);

            if (strResult.d != "") {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Customer Cilent Contact Created successfully', 'success');
                RefreshGrid('ClientContact');





            }

        }


    }



    function SaveAddCilentdetails() {

        SaveCilentdetails();
        cancelCilent();
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

    //Added by Usha Pandit on 17.05.2019 for Duplicate Email Save Issue
    function ValidateDuplicateEmailId() {      
        data = JSON.stringify({
                EmailId: $("#ContactEmailID").val(), CustomerId: EditCustomerID
            });
            //alert(data);
        strResult = AJAXCallWithResult("CRM_CustomerMaster.aspx/checkDuplicateCustomerContactEmailId", data, false);
        
        return strResult.d
    }
    //End of Added by Usha Pandit on 17.05.2019 for Duplicate Email Save Issue


    function ValidateContactPerson()
    {
        data = JSON.stringify({
                ContactPerson: $("#ContactPerson").val(), CustomerId: EditCustomerID
            });
            //alert(data);
        strResult = AJAXCallWithResult("CRM_CustomerMaster.aspx/checkContactPerson", data, false);
        
        return strResult.d
    }

    function ValidateEmailID(strEmailList) {
        var strEmailArray;
        var intCtr
        var strNewEmailList
        if (strEmailList == "") {
            return false;
        }
        //Added By NikitaD of Send Mail functionality in 4.0
        //Added by swapnil aswale on 31/3/2016
        //if (strEmailList.charAt(strEmailList.length - 2) == ";") {
        if (strEmailList.charAt(strEmailList.trim().length - 1) == ";") {
            strNewEmailList = strEmailList.substr(0, strEmailList.trim().length - 1);
        }
            //Ended
        else {
            strNewEmailList = strEmailList;
        }
        strNewEmailList = strNewEmailList.replace(/ /g, '');
        //End Added By NikitaD of Send Mail functionality in 4.0
        objRegularExp = new RegExp("[\\,,\\ ,\\;]")
        strEmailArray = strNewEmailList.split(objRegularExp);

        if (strEmailArray.length == 0)
            return false;

        for (intCtr = 0; intCtr < strEmailArray.length; intCtr++) {
            if (isEmail(strEmailArray[intCtr]) == false) {
                //alert("Invalid Email ID = \"" + strEmailArray[intCtr] + "\"")
                return false;
            }
        }
        return true;
    }
    function isEmail(str) {
        /*
        '=====================================================================
        ' Procedure Name        :   isEmail
        ' Description           :   Generic function which validates if the Email Id entered by the user
        '							is in a proper format.	
        ' Purpose               :   To Validate the email id is in proper format or not
        ' Parameters Passed     :   Email ID which is to be validated
        ' Returns               :
        ' Parameters Affected   :   None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                :   UmaB
        ' Created               :   11th September 2000
        ' Revisions             :
        '=====================================================================
        */
        // Are regular expressions supported ?
        var supported = 0;

        if (window.RegExp) {
            var tempStr = "a";
            var tempReg = new RegExp(tempStr);
            if (tempReg.test(tempStr)) supported = 1;
        }

        if (!supported)
            return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);

        var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
        var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");

        return (!r1.test(str) && r2.test(str));

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
                $("#imgUser").css('margin-left', '-16px');
                $("#imgUser").css('margin-top', '-1px');
                $("#imgUser").css('line-height', '20px');

            }

            reader.readAsDataURL($("#file")[0].files[0]);
        }
    }


    var fileObject;
    $(document).on('change', '.file', function () {

        var fileNameDisplay;
        $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));

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

        // ImportOnclick();

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
</script>
