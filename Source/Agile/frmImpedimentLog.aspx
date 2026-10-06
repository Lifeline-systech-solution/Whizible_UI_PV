<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmImpedimentLog.aspx.vb" Inherits="PbNIT.frmImpedimentLog" %>

<!DOCTYPE html>

<html>
            <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
     <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<%--    <title></title>--%>

<%--    
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/editor.css" />
<%--    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css" />--%>
    <link rel="stylesheet" href="css/Impediment.css?v=1.7" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />

  <%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script--%>>
    <script src="js/autosize.js"></script>    
  <%--  <script src="../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
    <script src="js/CommonJS.js"></script>    
<%--    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
     <script src="../../Whizible2.0-new/dist/js/timepicker.min.js"></script>  
<%--    <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>  --%>  




        <script src="../../Whizible2.0-new/dist/js/editor.js"></script>
    

</head>
    
    <style>
        body{
            background-color: #FFF;
        }
        #divImpedimentbody .form-control[readonly],#divRiskbody .form-control[readonly]{
            cursor: auto !important;
            background: transparent !important;
        }

        .fa-remove {
            background: red !important;
            color: #fff !important;
            border-radius: 15px;
            padding: 1.5px 2.5px;
            font-size: 9px !important;
            vertical-align: middle;
        }

        .dropdown-menu {
            right: 0px !important;
            left: auto !important;
        }

            .dropdown-menu li {
                list-style: none;
                cursor: pointer;
                float: left;
                width: 100%;
                padding: 6px;
                font-weight: normal;
            }

        /*ul li {
            display: inline !important;
        }*/

        .btn-Green {
            background-color: #22B14C;
            color: #fff;
            border-radius: 0px;
            padding: 4px 12px;
        }

        #divMain {
            margin-left: 8px;
            /*overflow: hidden;*/
            overflow-x: auto;
            padding-left: 12px;
            width: 99%;
            height: 806px;
            -ms-scrollbar-arrow-color: white !important;
            -ms-scrollbar-base-color: white !important;
            -ms-scrollbar-shadow-color: white !important;
        }

        ::-webkit-scrollbar {
            -moz-box-orient: vertical;
            overflow: -moz-scrollbars-none;
        }

        #date_status {
            white-space: nowrap;
        }

        ::-webkit-scrollbar {
            background: transparent; /* optional: just make scrollbar invisible */
            width: 0px;
        }



        td {
            color: #888888;
            font-weight: 500;
        }

        .img-circle {
            width: 25px;
        }



        .selected {
            background-color: #f5f5f5;
            color: white !important;
            text-decoration: underline;
        }

        .dropdown-menu li:hover {
            background-color: #428bca;
            color: white !important;
        }

        #divDSbody {
            padding-top: 23px !important;
        }

        /**:not(.fa):not(small) {
            font-family: helvetica !important;
            font-size: 14px;
        }*/


        .col-form-label {
            font-weight: 100;
            /* color: #88888880; */
            white-space: nowrap;
            font-size: 14px;
            margin-top: 15px;
            color: gray;
            text-align: right;
        }

        @media (min-width: 992px) {
            #container_impediment {
                /*width:1287px;*/
            }
        }

        textarea:focus, input:focus {
            outline: none;
        }

        .paginate_button {
            outline: none;
        }

        #txtAssignedTo {
            background-image: url('/css/searchicon.png');
            background-position: 10px 12px;
            background-repeat: no-repeat;
            width: 100%;
            font-size: 16px;
            /*padding: 12px 20px 12px 40px;*/
            border: 1px solid #ddd;
            /*margin-bottom: 12px;*/
        }



        #emplistUL, .clsRequestStatusList {
            height: 300px;
            overflow: auto;
        }

        .clsAssignToList a {
            margin-left: 5px;
        }

        #myUL li a:hover:not(.header) {
            background-color: #eee;
        }

        .clsAssignedListItem a {
            padding: 0px !important;
        }

        .ui-datepicker {
            z-index: 99999 !important;
        }
        /*ul li {
        display: inline !important;
        }*/


        #DivImpedimentLogList {
            height: 100%;
            overflow: auto;
            /*width: 104%;*/
        }

        .clsDivImpedimentLogList {
            white-space: nowrap;
            overflow: hidden !important;
            text-overflow: ellipsis;
            width: 400px;
        }

        .dataTables_paginate {
            padding-right: 20px;
            padding-top: 10px;
        }

        /*Changed By Yasmin on 12-3-19*/
       
        /*Commented And Added By Usha Pandit On 25.04.2020 For hovering parent only if child is not hover*/
        /*#UlFilter > li:hover {
            color: #fff !important;
            text-decoration: none !important;
            background-color: #007bff !important;
        }*/
        #UlFilter > li:not(.no-hover):hover {
            color: #333 !important;
            text-decoration: none !important;
            background-color: #e1e3e9 !important;
        }
        /*End Of Added By Usha Pandit On 25.04.2020 For hovering parent only if child is not hover*/

        #ExcelFilter > li:hover {
            color: #fff !important;
            text-decoration: none !important;
            background-color: #007bff !important;
        }

        .clsFilterDiv li {
            white-space: nowrap;
        }

        #UlFilter {
            /*max-height: 300px;*/
            overflow: auto;
            margin: 2px 0 0;
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
        }

        #ExcelFilter {
            max-height: 300px;
            overflow: auto;
            margin: 2px 0 0;
            font-size: 11.5px !important;
            /* Modified By Madhuri.K On 01-04-2026 */
        }

        .clsFilterDiv {
            margin-left: -15px;
        }

        #DivImpedimentLogList .clsTRColumnHeader {
            display: none;
        }

        #DivImpedimentLogList .dataTables_length {
            display: none;
        }

        #DivImpedimentLogList .dataTables_scrollHead {
            display: none;
        }

        #DivImpedimentLogList .dataTables_filter {
            display: none;
        }

        #DivImpedimentLogList .dataTables_paginate {
            float: right;
            margin-top: -5%;
        }

        #DivImpedimentLogList table td {
            border: none;
        }

        #DivImpedimentLogList table {
            border: none;
        }

            #DivImpedimentLogList table tr {
                border-bottom: 1px solid #ddd;
            }

        #txtSearchDailyScrum {
            border: 1px solid #ccc !important;
        }

        /*#divfilterDropdown:hover #UlFilter {
            display: block !important;
        }*/

        /*#divfilterExport:hover #ExcelFilter {
            display: block !important;
        }*/

        #tblweekdates tr td {
            border-bottom: 1px solid #ddd;
        }

        #tblweekdates th {
            border-bottom: none;
        }

        #divweekdates {
            /*border-right: 1px solid #ddd;*/
        }

        .selecteddate {
            background-color: #428bca!important;
        }

            .selecteddate a {
                color: white !important;
            }

        #DivImpedimentLogList table tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivImpedimentLogList table tr td:nth-child(2) {
            width: 30% !important;
        }

        #DivImpedimentLogList table tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivImpedimentLogList table tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivImpedimentLogList table tr td:nth-child(3) {
            width: 5% !important;
        }

        #DivImpedimentLogList table tr td:nth-child(3) {
            width: 25% !important;
        }

        /*table {
            table-layout: fixed;
        }
            table th {
                word-wrap: break-word;
            }*/




        /*#DivGridShowHistory table tr td:nth-child(1) {
            width: 10%!important;
            max-width:150px;
        }

        #DivGridShowHistory table tr td:nth-child(2) {
            width: 35%!important;
            max-width:150px;
        }

        #DivGridShowHistory table tr td:nth-child(3) {
            width: 35%!important;
            max-width:150px;
        }

        #DivGridShowHistory table tr td:nth-child(4) {
            width: 10%!important;
            max-width:150px;
        }

        #DivGridShowHistory table tr td:nth-child(5) {
            width: 5%!important;
            max-width:150px;
        }*/




        #divAddImpediment .modal-content {
            height: 45% !important;
        }

        #divAddDS .modal-content {
            height: 45% !important;
        }

        @media only screen and (max-width:1024px) {
            #container_impediment {
                left: 0;
                height: 420px !important;
                overflow: auto;
            }
        }

        .clsShow {
            display: none;
        }

        textarea {
            box-sizing: border-box;
            resize: none;
        }

        #DivShowHistory {
            position: relative;
            overflow: auto;
            width: 100%;
            margin-top: 1%;
            height: 430PX;
            overflow-x: hidden;
            margin-left: 1%;
            font-weight: 100 !important;
        }

        #DivGridShowHistory table tr th {
            padding-top: 10px !important;
            font-weight: normal !important;
            text-align: center !important;
        }

            #DivGridShowHistory table tr th .dataTables_sizing {
                height: 36px !important;
            }

        #DivGridShowHistory .dataTables_scrollHead {
            /*height:36px;*/
            font-weight: 100;
        }

        #DivGridShowHistory .dataTables_length {
            display: none;
        }

        #DivGridShowHistory .dataTables_filter {
            display: none;
        }

        #DivGridShowHistory .paging_simple_numbers {
            float: right;
        }

        #DivGridShowHistory .dataTables_scrollHeadInner table tr th {
            display: none !important;
        }

        #DivGridShowHistory .dataTables_scrollBody table thread tr th {
            height: 50px !important;
        }

        #DivGridShowHistory .dataTables_scrollBody table tr {
            height: 50px !important;
        }

        #DivGridShowHistory .dataTables_paginate {
            float: right;
        }

        #DivGridShowHistory .dataTables_info {
            margin-top: 9%;
        }

        #DivGridShowHistory THEAD.clsTRColumnHeader {
            BORDER-RIGHT: thin;
            PADDING-RIGHT: 1pt;
            BORDER-TOP: thin;
            PADDING-LEFT: 1pt;
            FONT-WEIGHT: normal;
            FONT-SIZE: 11px;
            BACKGROUND-IMAGE: url(../../Images/Blue/columnhdr_bg.gif);
            PADDING-BOTTOM: 1pt;
            BORDER-LEFT: thin;
            COLOR: black;
            PADDING-TOP: 1pt;
            BORDER-BOTTOM: thin;
            FONT-FAMILY: Verdana, Arial;
            HEIGHT: 22px;
            BACKGROUND-COLOR: #aec2ce;
        }

        #DivGridShowHistory TR.clsTROdd {
            BORDER-RIGHT: thin;
            PADDING-RIGHT: 2pt;
            BORDER-TOP: thin;
            PADDING-LEFT: 2pt;
            FONT-SIZE: 8pt;
            PADDING-BOTTOM: 2pt;
            MARGIN: 2pt;
            BORDER-LEFT: thin;
            COLOR: black;
            PADDING-TOP: 2pt;
            BORDER-BOTTOM: thin;
            FONT-FAMILY: Verdana, Arial;
            HEIGHT: 18px;
            BACKGROUND-COLOR: #F2F3F3;
        }

        #DivGridShowHistory TR.clsTREvenRow {
            BORDER-RIGHT: thin;
            PADDING-RIGHT: 2pt;
            BORDER-TOP: thin;
            PADDING-LEFT: 2pt;
            FONT-SIZE: 8pt;
            PADDING-BOTTOM: 2pt;
            MARGIN: 2pt;
            BORDER-LEFT: thin;
            COLOR: black;
            PADDING-TOP: 2pt;
            BORDER-BOTTOM: thin;
            FONT-FAMILY: Verdana, Arial;
            HEIGHT: 18px;
            BACKGROUND-COLOR: white;
        }

        .alertify-notifier li {
            word-break: normal !important;
            white-space: normal !important;
        }

        .alertify-notifier .ajs-message {
            width: 300px;
            word-break: break-word;
            padding-left: 5px !important;
        }

            .alertify-notifier .ajs-message > ul {
                padding-left: 5px !important;
            }


        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            word-break: break-all;
            margin-left: 0px !important;
        }


        #content browser {
            margin-right: -14px !important;
            overflow-y: scroll !important;
            overflow-x: hidden !important;
        }
        /*html, body {
            height: 100%;
            width: 100%;
            overflow: hidden;
        }

        #divMain {
            width: 100%;
            height: 100%;
            overflow: auto;
            padding-right: 0px;
        }*/

        .clsScrollHide {
            /*display: inline-block;
            vertical-align: top;
            overflow: hidden;
            border: solid grey 1px;*/
            overflow-y: hidden;
        }

            .clsScrollHide option {
                overflow-y: hidden;
                /*padding: 10px;
                margin: -5px -20px -5px -5px;*/
            }

        select {
            overflow-y: hidden;
            background-image: none;
        }
        /*.ellipsis {
                max-width: 350px;
                overflow: hidden;
                text-overflow: ellipsis;
                display: -webkit-box;
                line-height: 16px;id="divAddDS
                max-height: 32px; 
                -webkit-line-clamp: 2; 
                -webkit-box-orient: vertical;
            }*/
        .clsSetHeight {
            height: 325px !important;
        }

        .clsDisableColor {
            background-color: white !important;
        }
        /*Added by Usha Pandit on 18 Apr 2018 for calendar*/
        .datepicker-dropdown {
            margin-right: 35%;
        }

        /*.datepicker-dropdown-margin {
            margin-right: 0%!important;
        }*/
        /*End of Added by Usha Pandit on 18 Apr 2018 for calendar*/
        /*Added by Usha Pandit on 18 Apr 2018 for responsive popup*/
        @media (max-width: 800px) /* The minimum width of the display area, such as a browser window*/
        {
            .modal-dialog {
                width: 550px;
                /*overflow: hidden;*/
            }

            #h1 {
                color: maroon;
                font-size: 17px;
                font-weight: 500;
                color: grey !important;
                width: 520px;
            }
        }

        @media (max-width: 650px) /* The minimum width of the display area, such as a browser window*/
        {
            .modal-dialog {
                width: 400px;
                /*overflow: hidden;*/
            }

            #h1 {
                color: maroon;
                font-size: 17px;
                font-weight: 500;
                color: grey !important;
                width: 350px;
            }
        }

        /*@media (max-width: 1150px) 
        {*/
        @media (min-width: 750px) /* The minimum width of the display area, such as a browser window*/
        {
            #lblDescription {
                margin-top: 21px;
            }
        }
        /*}*/

        .searchboxHeight {
            height: 30px !important;
        }
        /*Added by Usha Pandit on 18 Apr 2018 for responsive popup*/
        /*.pagination > .active > a, .pagination > .active > span, .pagination > .active > a:hover, .pagination > .active > span:hover, .pagination > .active > a:focus, .pagination > .active > span:focus {
            /* z-index: 2; 
             color: #fff; 
             cursor: default; 
             background-color: #428bca; 
             border-color: #428bca; 
        }*/

        .clsRemoveBottomBorder {
            border-collapse: initial;
            border-bottom: 1px solid white !important;
        }




        .tooltip {
            position: fixed;
        }

        /*.large.tooltip-inner {
            max-width: 450px;
            width: 450px;
            max-height: 280px;
            height: 280px;
        }*/

        .large.tooltip-inner {
            max-width: 400px !important;
            width: 400px !important;
            max-height: 320px !important;
            height: auto !important;
            margin-top: 30px !important;
            word-break: break-all !important;
        }

        /*table {
            width:100%;
            table-layout:fixed;
        }*/

        .dataTables_empty {
            background-color: white !important;
            border-color: white !important;
            /*border-bottom: 1px solid #ddd!important;*/
            text-align: center !important;
        }
        /*for chrome search clear*/
        /*input[type="search"] {
            -webkit-appearance: searchfield;
        }

            input[type="search"]::-webkit-search-cancel-button {
                -webkit-appearance: searchfield-cancel-button;
            }*/


        /*::-ms-clear {
            display: none;
        }*/
        /*for chrome search clear*/
        .form-control-clear {
            z-index: 10;
            pointer-events: initial;
            cursor: pointer;
        }
        #DSFilterSprint
        {
            width:70%!important;
        }
        .HeaderFreeze.fixed-top{display:flex}
        #divHeaderLeftSection{display:block}
        .fa.fa-search{height:30px}
        .fixed-top{padding-bottom:0;margin-top: 0px;}

        #divImpedimentbody,#divIssuebody,#divRiskbody,#divDSbody {
            overflow: auto;
            height: 405px;
        }
         /* Added By Gauri On 03rd Sep 2024 For Alignment Issue */
         @media only screen and (min-width: 992px) and (max-width: 1240px){
            #txtSearchDailyScrum{
                margin-top: 0;
            }
        }
        #tblweekdates tbody tr td a{
            font-weight: 600;
            font-size: 11.5px;
            /* Modified By Madhuri.K On 26-03-2026 */
        }
        .close {
            font-size: 21px;
        }
        /* End of Added By Gauri On 03rd Sep 2024 For Alignment Issue */

        /* Added By Gauri On 09th Sep 2024 For Datepicker Alignment Issue */
        .ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next,
        .ui-datepicker .ui-datepicker-prev:hover, .ui-datepicker .ui-datepicker-next:hover {
            top: unset;
            bottom: 5px;
        }
        .ui-datepicker table {
            border-collapse: separate;
        }
        .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active {
            border: 1px solid rgb(197, 197, 197) !important;
            background: rgb(246, 246, 246);
            font-weight: normal;
            color: rgb(69, 69, 69);
        }
        .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
            border: 1px solid rgb(0, 62, 255);
            background: rgb(0, 127, 255) !important;
            color: rgb(255, 255, 255);
        }
        .ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight {
            border: 1px solid #dad55e !important;
            background: #fffa90 !important;
            color: #777620 !important;
        }
        /* End of Added By Gauri On 09th Sep 2024 For Datepicker Alignment Issue */
    </style>
<body>
    <form id="form1" runat="server">

        <div>
            <div id="divMain">

                <% WritePage()%>
                <%--</div>--%>
                <input type="hidden" id="hdnAssignToId" name="hdnAssignToId" />
            </div>

        </div>
        <%-- Modal Daily Scrum --%>
        <div class="modal fade" id="divAddDS" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="DSmodalcontent">
                    <div class="modal-header" id="SectionHeader">
                        <div class="col-sm-11">
                            <h5 class="modal-title" style="color: maroon; font-size: 17px; font-weight: 500; color: grey!important;" id="headerUS">Impediment</h5>
                        </div>
                        <div class="col-sm-1">

                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" data-bs-toggle='tooltip' data-bs-placement='bottom' title="Close " style="outline: none; margin-top: 4px!important">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                    </div>
                    <div class="modal-body" id="divDSbody">
                    </div>
                    <div class="modal-footer" style="padding-top: 0px;">
                        <button type="button" class="btn btn-info" style="width: 12%;" onclick="Save_Impediment_Details(0)" id="SaveDS">Save</button>
                        <%--<button type="button" class="btn btn-info" style="width: 100px;" onclick="Save_Impediment_Details(1)" id="SaveAndAddDS">Save & Add</button>--%>
                        <button type="button" class="btn btn-info" data-bs-dismiss="modal" id="btnClose">Close</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade" id="divAddIssue" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="Div3">
                    <div class="modal-header" id="Div4">
                        <div class="col-sm-11">
                            <h5 class="modal-title" style="color: maroon; font-size: 17px; font-weight: 500; color: grey!important;" id="h2">Issue</h5>
                        </div>
                        <div class="col-sm-1">

                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" data-bs-toggle='tooltip' data-bs-placement='bottom' title="Close " style="outline: none; margin-top: 4px!important">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                    </div>
                    <div class="modal-body" id="divIssuebody">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" style="width: 12%;" onclick="Save_Issue_Details(0)" id="btnSaveIssue">Save</button>
                        <button type="button" class="btn btn-info px-0" style="width: 100px;" onclick="Save_Issue_Details(1)" id="btnSaveAndAddIssue">Save & Add</button>
                        <button type="button" class="btn btn-info" data-bs-dismiss="modal" id="Button3">Close</button>

                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade" id="divAddRisk" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="Div6">
                    <div class="modal-header" id="Div7">
                        <div class="col-sm-11">
                            <h5 class="modal-title" style="color: maroon; font-size: 17px; font-weight: 500; color: grey!important;" id="h3">Risk</h5>
                        </div>
                        <div class="col-sm-1">

                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" data-bs-toggle='tooltip' data-bs-placement='bottom' title="Close " style="outline: none; margin-top: 4px!important">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                    </div>
                    <div class="modal-body" id="divRiskbody">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" style="width: 12%;" onclick="Save_Risk_Details(0)" id="btnSaveRisk">Save</button>
                        <button type="button" class="btn btn-info px-0" style="width: 100px;" onclick="Save_Risk_Details(1)" id="btnSaveAndAddRisk">Save & Add</button>
                        <button type="button" class="btn btn-info" data-bs-dismiss="modal" id="Button6">Close</button>

                    </div>

                </div>
            </div>
        </div>

        <%-- Show History Pop up --%>
        <div class="modal fade" id="DivShowhistory" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="col-sm-4">
                            <h5 class="modal-title" style="color: maroon;" id="">Show History</h5>
                        </div>
                        <div class="col-sm-7">
                            <%--<input type='search' name='table_search' id='txtSearchHistory' class='txtBox form-control float-end' placeholder='Search' /><i class="fa fa-search Release" aria-hidden="true"></i>--%>
                            <%--  <div class='input-group input-group-sm' style='width: 80%; margin-left: 56%;'>
                               
                                <div class='input-group-btn'>
                                    <button type='button' class='btn btn-default' onclick='PerformSearchForPTI()'><i class='fa fa-search'></i></button>
                                </div>

                                <input type='search' name='table_search' id='txtSearchHistory' class='txtBox form-control float-end searchboxHeight' value='' onkeyup='PerformSearchForPTI()' placeholder='Search' style="margin-right: 53%;" />
                            </div>--%>



                            <div class='input-group input-Group -sm ' style='width: 50%; margin-left: 50%;'>
                                    <!-- Added By Gauri On 09th Sep 2024 For Alignment Issue -->
                                    <!-- <div class='input-group-btn' style="width:100%!important"> -->
                                    <div class='input-group-btn' style="width:auto !important">
                                    <!-- End of Added By Gauri On 09th Sep 2024 For Alignment Issue -->
                                    <input type='search' name='table_search' id='txtSearchHistory' class='txtBox form-control float-end searchboxHeight' value='' onkeyup='PerformSearchForPTI()' placeholder='Search' />
                                </div>
                                <i class='fa fa-search' style='border-bottom-color: none; margin-left: 15px!important; /* z-index: 99; */margin-top: 10px;'></i>
                            </div>

                        </div>
                        <div class="col-sm-1">
                            <button type="button" class="close" data-bs-toggle='tooltip' data-bs-placement="bottom" data-bs-dismiss="modal" aria-label="Close" title="Close " style="outline: none;">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </div>
                    <div class="modal-body" id="GetShowhistory" style="margin-top: -2%">
                    </div>

                </div>
            </div>
        </div>


        <%-- End of show History pop up --%>




        <div class="modal fade bd-example-modal-lg" id="divAddImpediment" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <%--<div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel" style="font-size: 17px; font-weight: 500; color: grey; margin-left: 7px;">Impediment</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" style="margin-top: -24px;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>--%>
                    <div class="modal-header" id="Div1">
                        <div class="col-sm-11">
                            <h5 class="modal-title" style="color: maroon; font-size: 17px; font-weight: 500; color: grey!important;" id="h1">Impediment</h5>
                        </div>
                        <div class="col-sm-1">

                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" data-bs-toggle='tooltip' data-bs-placement='bottom' title="Close " style="outline: none; margin-top: 4px!important">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                    </div>
                    <%--Added by Usha Pandit on 18 Apr 2018 for remove popup scroll overflow:hidden; --%>
                    <div class="modal-body" id="divImpedimentbody">
                        <div class="" id="container_impediment">
                            <form id="frmImpedimentModal">
                                <div class="form-group row">
                                    <label class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Description">Description</label>
                                    <div class="col-sm-10">
                                        <textarea type="text" class="form-control" id="inputimpediment" style="width: 70%; margin-left: 9px;"></textarea>
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Severity">Severity</label>
                                    <div class="col-md-3">
                                        <div class="input-group">

                                            <input type="text" class="form-control" id="inputimpediment">
                                        </div>
                                    </div>
                                    <label for="inputEmail3" class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Priority">Priority</label>
                                    <div class="col-md-3">
                                        <div class="input-group">

                                            <select class="form-control input-md" id="inputimpediment" style="width: 213%;">
                                                <option value=""></option>
                                                <option>High</option>
                                                <option>Medium</option>
                                                <option>Low</option>
                                            </select>
                                        </div>
                                    </div>

                                </div>

                                <div class="form-group row">
                                    <label for="inputPassword3" class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Corrective Action">Corrective Action </label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="inputimpediment" style="width: 66%; margin-left: 45px;">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="inputEmail3" class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Preventive Action">Preventive Action</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="inputimpediment" style="width: 66%; margin-left: 45px;">
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Closure Date">Planned Issue </label>
                                    <div class="col-md-3">
                                        <div class="input-group">

                                            <input type="text" class="form-control " id="inputimpediment" style="margin-left: 43px;">
                                        </div>
                                    </div>
                                    <label for="inputEmail3" class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Status">Status</label>
                                    <div class="col-md-3">
                                        <div class="input-group">

                                            <select class="form-control input-md" style="width: 171%;" id="inputimpediment">
                                                <option value=""></option>
                                                <option>Open</option>
                                                <option>Closed</option>
                                                <option>In Progress</option>
                                            </select>
                                        </div>
                                    </div>

                                </div>
                                <div class="row form-group">
                                    <label class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Raised Date">Raised Date</label>
                                    <div class="col-md-3">
                                        <div class="input-group">

                                            <input type="text" class="form-control SprintStartdate" id="inputimpediment" style="margin-left: 43px;" />
                                        </div>
                                    </div>
                                    <label for="inputEmail3" class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Closure Date">Actual Issue</label>
                                    <div class="col-md-3">
                                        <div class="input-group">

                                            <input type="text" class="form-control " id="inputimpediment" style="margin-left: 43px;" />
                                        </div>
                                    </div>

                                </div>
                                <div class="row form-group">
                                    <label class="col-sm-1 col-form-label" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Converted To">Converted To</label>
                                    <div class="col-md-3">
                                        <div class="input-group">

                                            <input type="text" class="form-control" id="inputimpediment" style="margin-left: 33px;" />
                                        </div>
                                    </div>

                                </div>


                            </form>


                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" style="width: 12%;" onclick="Save_Impediment(0)" id="btnSaveImpediment">Save</button>
                        <button type="button" class="btn btn-info px-0" style="width: 100px;" onclick="Save_Impediment(1)" id="btnSaveAndAddImpediment">Save & Add</button>
                        <button type="button" class="btn btn-info" style="background-color: #428bca; border-color: #428bca;" data-bs-dismiss="modal" aria-label="Close">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <input type='hidden' id='hdnDSCurrentDate' />
    </form>
    <script>
        var divGridHeight;
        var dtHeight;
        var today = new Date();
        date = today.getDate();
        month = today.getMonth();
        year = today.getFullYear();
        month = month + 1;
        var GlobalImpedimentID = "";
        var strGlobaFilterField = "";
        var strGlobalFilterValue = "";

        $(function () {



            $('#DSTargetDate').datepicker({
                dateFormat: 'dd-mm-yy',
                minDate: 0
            });
            $('#dtPlannedIssueDate').datepicker({
                dateFormat: 'dd-mm-yy',
                minDate: 0
            });
            $('#dtRaisedDate').datepicker({
                dateFormat: 'dd-mm-yy',
                minDate: 0
            });
            $('#dtActualIssueDate').datepicker({
                dateFormat: 'dd-mm-yy',
                minDate: 0
            });
            
        });
        
        // Added By Gauri On 09th Sep 2024 For Tooltip Issue
        document.addEventListener('DOMContentLoaded', (event) => {
            const TooltipID = ['detailDropdown', 'filterDropdown']; 
            
            TooltipID.forEach(id => {
                const element = document.getElementById(id);
                if (element) {
                    const tooltip = bootstrap.Tooltip.getOrCreateInstance(element);
                    tooltip.hide();
                }
            });
        });
        // End of Added By Gauri On 09th Sep 2024 For Tooltip Issue


        $("#Prev").click(function () {
            try {
                var strUserResult = ajaxCall("frmImpedimentLog.aspx/GetWeekDates", "POST", "application/json", "json", JSON.stringify({ strFlag: 'Prev' }));
                //alert(strUserResult.d);
                
                if (strUserResult.d != "") {

                    $("#weekdates").html("");
                    $("#weekdates").html(strUserResult.d);

                }
            }
            catch (ex) {
                //ex.message();
            }
        });
        $(document.documentElement).keyup(function (e) {
            if (e.keyCode == 38) {
                var strUserResult = ajaxCall("frmImpedimentLog.aspx/GetWeekDates", "POST", "application/json", "json", JSON.stringify({ strFlag: 'Prev' }));
                if (strUserResult.d != "") {

                    $("#weekdates").html("");
                    $("#weekdates").html(strUserResult.d);

                }
            }

            if (e.keyCode == 40) {
                var strUserResult = ajaxCall("frmImpedimentLog.aspx/GetWeekDates", "POST", "application/json", "json", JSON.stringify({ strFlag: 'Next' }));

                if (strUserResult.d != "") {
                    //var strResult = strUserResult.d.Split("$$");
                    $("#weekdates").html("");
                    $("#weekdates").html(strUserResult.d);

                }
            }
        });
        //$("#Prev").keypress(function (e) {
        //    var key = e.which;
        //    alert("Page up key is clicked");
        //    if (key == 33)  // the up key code
        //    {
        //        alert("Page up key is clicked");
        //        var strUserResult = ajaxCall("frmImpedimentLog.aspx/GetWeekDates", "POST", "application/json", "json", JSON.stringify({ strFlag: 'Prev' }));
        //        if (strUserResult.d != "") {

        //            $("#weekdates").html("");
        //            $("#weekdates").html(strUserResult.d);

        //        }
        //    }
        //});


        $("#Next").click(function () {
            try {
                
                var strCurrentDate;

                var strUserResult = ajaxCall("frmImpedimentLog.aspx/GetWeekDates", "POST", "application/json", "json", JSON.stringify({ strFlag: 'Next' }));
                //alert(strUserResult.d);
                if (strUserResult.d != "") {
                    //var strResult = strUserResult.d.Split("$$");
                    $("#weekdates").html("");
                    $("#weekdates").html(strUserResult.d);

                }

            }
            catch (ex) {
                alert(ex.message);
            }

        });

        function GetSelectedSprint() {

        }
        var curWhereFlag = '';
        var curWhereValue = '';
        var curWhereDate = '';

        function Excel_OnClick(format) {

            var objform;
            //var format = 'EXCEL';

            format = format.toUpperCase();
            var strExportResult = ajaxCall("frmImpedimentLog.aspx/ExportToExcel", "POST", "application/json", "json", JSON.stringify({ ReportFormat: format, WhereFlag: curWhereFlag, WhereValue: curWhereValue, WhereDate: curWhereDate }));

            if (strExportResult.d != "") {
                //alert(strExportResult.d);
            }



            //Added By Bharat Tekade on 7th-Jun-2016 for show data in excel from grid 
            var objStatus, objHRM;
            //var strHiringMgr, strStatus, intCustomer, intSkill, intBG, strStaffingStatus, strURL;


            //strURL = "&HiringMgr=" + strHiringMgr + "&ApprovalStatus=" + strStatus + "&Customer=" + intCustomer + "&SkillID=" + intSkill + "&BusinessGroupID=" + intBG + "&StaffingStatus=" + strStaffingStatus + "";
            ////End of Added By Bharat Tekade on 7th-Jun-2016 for show data in excel from grid 
            //objform = GetFormReference('frmStaffingPlanApproval');


            //strURL = "HR_StaffingPlanApprovalProcess.aspx?Action=ExportExcel&ReportID=20046&Format=" + format + strURL;
            //var result = ValidateData(strURL, 0, 0, 0, 0);
            window.open("../CRW/CRW_ReportOutput.aspx?filename=" + strExportResult.d, "_report", "");
            //End of Commented and Added By Bharat Tekade on 28th-Sep-2016for show data in excel from grid 


        }

        function ValidateData(strURL, MasterTagID, ParentTagID, strFocusOnControl) {
            //debugger;
            //start .Added mode option in parameter list to the function         
            var blnPROGFlag = (arguments.length > 5) ? arguments[5] : 0;
            //End
            var strResult;
            var strNavigator;
            g_sResponseText = '';
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();

            //strURL="../XMLHttp/Customer_XMLHttp.aspx?MasterTagID=" + 	MasterTagID + "&ParentTagID=" +ParentTagID + "&" + strURL;


            if (strNavigator == 'MICROSOFT INTERNET EXPLORER') {
                g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText;
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET", strURL, false);
                //finally send the call
                g_oValidateXMLHttp.send();
            }
            else {
                // Mozilla - based browser 
                g_oValidateXMLHttp = new XMLHttpRequest();
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText();
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET", strURL, false);
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

        function SetWidthHeight() {
            var dtTopHeightPadding;

            //$("#divMain").css("height", (window.innerHeight) + 'px');
            //$("#divMain").css("height", '806px');

            dtHeight = window.innerHeight - 200;
            dtTopHeightPadding = dtHeight / 4;
            //alert(dtHeight);
            $("#divweekdates").css("height", dtHeight);
            $("#tblweekdates").css("height", dtHeight / 2);
            $("#DivShowhistory").find(".dataTables_scrollBody").css("height", (dtHeight / 4) + 59);


            $("#divweekdates").css("padding-top", dtTopHeightPadding);



            //divMain

        }
        $(window).resize(function () {

            SetWidthHeight();
        })

        function resizeTextarea(el) {
            jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);

        };

        $(document).ready(function () {

            $('[data-bs-toggle="tooltip"]').tooltip();
            //Added By Dipali V On 24th March 2023 For Datatable Issue
            if ($("#FilterImpedimentLogList").val() > 0) {
                datatables('DivImpedimentLogList', 'txtSearchDailyScrum', '');
            }
            //End of Added By Dipali V On 24th March 2023 For Datatable Issue
           

            //$('#filterDropdown').click(function () {
            //    if ($('#filterDropdown').data('open')) {
            //        alert("open");
            //        //$('#dropdown').data('open', false);
            //        //update_something();
            //    }
            //    else {
            //        alert("close");
            //    }
            //});

            $('.my-dropdown').dropdown();
            $('.my-dropdown').tooltip();


            $('.dropdown-menu').on('click', function (e) {
                e.stopPropagation();
            });

            $(".scrum_date").click(function () {

                $(".scrum_date").removeClass("selecteddate")

                $(this).addClass("selecteddate")


            })

            $('#txtSearchDailyScrum').keypress('click', function (e) {


                if (e.keyCode == 13) {
                    return false;
                }



            });

        });

        function checkTemplate() {
            $('#DivGridShowHistory table > tbody > tr ').each(function (index) {
                if ($(this).children('p').length == 0) {
                    alert(1);
                }
            });
        }
        function datatables(divID, txtBoxID, height) {

            try {
                var pageLength = 7;

                if (divID == "DivGridShowHistory") {
                    pageLength = 3;
                }
                var ordering = false;
                if ($('#' + divID + ' tbody > tr > td').text() == "There are no items to show in this view.") {
                    ordering = false;
                }
                else {
                    ordering = true;
                }

                divGridHeight = window.innerHeight - 200;

                $('#' + divID + ' > table').removeClass("clsGridTable");
                $('#' + divID + ' table').addClass("table table-bordered table-stripped");
                var table = $('#' + divID + ' > table').DataTable({
                    responsive: true,
                    "pageLength": pageLength,
                    //scrollY: divGridHeight+'px',
                    pagingType: "numbers",
                    sorting: true,
                    scrollX: true,
                    //Tooltip:true,
                    scrollY: dtHeight + 'px',
                    "drawCallback": function (settings) {
                        if (divID == "DivGridShowHistory") {
                            $('.tt_large').tooltip({
                                template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                            });
                            $('[data-bs-toggle="tooltip"]').tooltip();
                        }
                        if (divID == "DivImpedimentLogList") {
                            $('.mydetaildropdown').dropdown();
                            $('.mydetaildropdown').tooltip();

                            $('.tt_large').tooltip({
                                template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                            });
                            $('[data-bs-toggle="tooltip"]').tooltip();
                        }
                    },

                }).on('page.dt', function () {

                    if (divID == "DivImpedimentLogList") {
                        $('.mydetaildropdown').dropdown();
                        $('.mydetaildropdown').tooltip();
                    }

                });

                if (txtBoxID != "") {

                    $('#' + txtBoxID).on('keyup change', function (e) {

                        if (divID == "DivImpedimentLogList") {


                            table.search($(this).val()).draw();

                            //if ($(this).val() == "Closed" || $(this).val() == "Differed" || $(this).val() == "Open" || $(this).val() == "Rejected" || $(this).val() == "Delayed" || $(this).val() == "Info") {

                            //    var strUserResult = ajaxCall("frmImpedimentLog.aspx/DrawGrid", "POST", "application/json", "json", JSON.stringify({ Flag: "Status", Value: $(this).val(), DateValue: '' }));
                            //    if (strUserResult.d != null || strUserResult.d != undefined) {
                            //        $("#DivList").html("");
                            //        $("#DivList").html(strUserResult.d);
                            //        $('[data-bs-toggle="tooltip"]').tooltip();
                            //        datatables('DivImpedimentLogList', 'txtSearchDailyScrum', '')
                            //    }
                            //}
                        }
                        if (divID == "DivGridShowHistory") {
                            table.search($(this).val()).draw();
                        }
                    })
                }

                if (ordering == false) {

                    $("#" + divID).find(".dataTables_info").html("Showing 0 to 0 of 0 entries ");

                    $('.active.page-item .page-link').css("display", "none");
                    if (divID == "DivImpedimentLogList") {
                        //var dtHeightnew = window.innerHeight - 200;
                        //dtHeightnew = (dtHeightnew / 2) + 59;

                        //$("#DivImpedimentLogList").find(".dataTables_scrollBody").css("cssText", "height:" + dtHeightnew + "px!important;");
                        //$("#DivImpedimentLogList").find(".table-bordered").addClass("clsRemoveBottomBorder");
                        $("#DivImpedimentLogList").find(".table-bordered tbody > tr > td").css("cssText", "border-bottom:1px solid #FFFFFF!important;");
                    }
                }
                if (divID == "DivImpedimentLogList") {
                    $('.mydetaildropdown').dropdown();
                    $('.mydetaildropdown').tooltip();

                    $('.has-clear input[type="search"]').on('input propertychange', function () {
                        var $this = $(this);
                        var visible = Boolean($this.val());
                        $this.siblings('.form-control-clear').toggleClass('hidden', !visible);
                    }).trigger('propertychange');

                    $('.form-control-clear').click(function () {
                        $(this).siblings('input[type="search"]').val('')
                            .trigger('propertychange').focus();
                    });

                }
                $('.tt_large').tooltip({
                    template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                });

                $(".dataTables_empty").attr("colspan", 5);
                //$('#' + divID + ' tbody > tr > td > p[data-original-title="Action Item/Description"]').addClass("clsDivImpedimentLogList");
            }
            catch (ex) {
                alert(ex.message);
            }
        }

        /*commented by kashish For Texarea Enhancement*/

        //function AutoResizeTextArea() {
        //    jQuery.each(jQuery('textarea[data-autoresize]'), function () {
        //        var offset = this.offsetHeight - this.clientHeight;

        //        var resizeTextarea = function (el) {
        //            jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
        //        };
        //        jQuery(this).on('keyup input', function () {
        //            if ($(this).attr("id") == "txtSummary") {
        //                Maxlength(this, "Summary", 500);
        //            }
        //            if ($(this).attr("id") == "txtImpedimentDescription") {
        //                Maxlength(this, "ImpedimentDescription", 500);
        //            }
        //            if ($(this).attr("id") == "txtImpactDescription") {
        //                Maxlength(this, "ImpactDescription", 500);
        //            }
        //            if ($(this).attr("id") == "txtActionItems") {
        //                Maxlength(this, "ActionItems", 500);
        //            }
        //            if ($(this).attr("id") == "txtCorrectiveAction") {
        //                Maxlength(this, "CorrectiveAction", 1000);
        //            }
        //            if ($(this).attr("id") == "txtPreventiveAction") {
        //                Maxlength(this, "PreventiveAction", 1000);
        //            }

        //            resizeTextarea(this);
        //        }).removeAttr('data-autoresize');
        //    });
        //}
        function getProjectRiskId() {
            var strRiskResult = ajaxCall("frmImpedimentLog.aspx/GetProjectRiskId", "POST", "application/json", "json", JSON.stringify({}));
            if (strRiskResult != undefined) {
                return strRiskResult.d;
            }
            else {
                return '0';
            }
        }
        function ShowModal(id, obj, ImpedimentId, impedDescr, impedstatus, flag, accesseditflag, accessaddflag) {
            //debugger;
            //Added by Usha Pandit on 07 JUNE 2018 to prevent duplicate convert to risk/Issue 
            $("#btnSaveImpediment").attr('disabled', false);
            $("#btnSaveIssue").attr('disabled', false);
            $("#btnSaveRisk").attr('disabled', false);

            $("#SaveDS").attr('disabled', false);
            //End of Added by Usha Pandit on 07 JUNE 2018 to prevent duplicate convert to risk/Issue 

            //debugger
            //$(".datepicker-dropdown").removeClass("datepicker-dropdown-margin");
            if (id == 'divAddImpediment') {
                $("#divDSbody").html('');
                $("#divIssuebody").html('');
                $("#divRiskbody").html('');

                var strUserResult = ajaxCall("frmImpedimentLog.aspx/AddImpedimentModal", "POST", "application/json", "json", JSON.stringify({}));
                if (strUserResult != undefined) {
                    $("#divImpedimentbody").html(strUserResult.d);
                    /*Added by kashish For Texarea Enhancement*/
                    AutoResizeTextArea();
                    //autosize(document.querySelectorAll('textarea'));
                    $("#impedimentStatus").prop("disabled", true);
                    $("#impedimentStatus").addClass("clsDisableColor");
                    $("#divAddImpediment").modal('show');
                    $('#dtPlannedIssueDate,#dtRaisedDate').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                            //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                            //yearRange: '2000:2020'
                            yearRange: 'c-100:c+100'
                            //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        }
                    );
                    $('#dtPlannedIssueDate,#dtRaisedDate').prop('readonly', true);
                }
            }



            else if (id == 'divAddDS') {
                $("#divImpedimentbody").html('');
                $("#divIssuebody").html('');
                $("#divRiskbody").html('');
                //alert(ImpedimentId);
                GlobalImpedimentID = ImpedimentId;
                var strUserResult = ajaxCall("frmImpedimentLog.aspx/AddDailyScrumModal", "POST", "application/json", "json", JSON.stringify({ ImpedimentId: ImpedimentId }));
                if (strUserResult != undefined) {
                    $("#divDSbody").html(strUserResult.d);

                    if (impedstatus != undefined) {
                        if (impedstatus == "Info") {
                            $('#DSStatus').find('option').remove().end();
                            var objCbo = document.getElementById("DSStatus");
                            var objOption = document.createElement("OPTION");
                            objCbo.options.add(objOption);
                            objOption.text = "Info";
                            objOption.value = "Info";

                            $("#DSStatus").prop('disabled', true);
                            $("#DSStatus").addClass("clsDisableColor");
                        }
                        if (impedstatus == "Delayed") {
                            $('#DSStatus').find('option').remove().end();
                            var objCbo = document.getElementById("DSStatus");
                            var objOption1 = document.createElement("OPTION");
                            objCbo.options.add(objOption1);
                            //objOption1.text = "Delayed";
                            //objOption1.value = "Delayed";
                            objOption1.text = "Open";
                            objOption1.value = "Open";
                            var objOption2 = document.createElement("OPTION");
                            objCbo.options.add(objOption2);
                            objOption2.text = "Closed";
                            objOption2.value = "Closed";
                            var objOption3 = document.createElement("OPTION");
                            objCbo.options.add(objOption3);
                            objOption3.text = "Differed";
                            objOption3.value = "Differed";
                            var objOption4 = document.createElement("OPTION");
                            objCbo.options.add(objOption4);
                            objOption4.text = "Rejected";
                            objOption4.value = "Rejected";
                        }
                    }

                    $("#divAddDS").modal('show');
                    /*Added by kashish For Texarea Enhancement*/
                    AutoResizeTextArea();
                    getRows();
                    RemoveTextArea();
                    //autosize(document.querySelectorAll('textarea'));
                    //var resizeTextareanew = function (el) {

                    //    jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);

                    //};
                    //resizeTextareanew($("#txtActionItems"));
                    if ($("#DSStatus").val() == "Closed") {
                        //if (MeetingNo != "") {
                        $('#SaveAndAddDS').css("display", "none");
                        $('#SaveDS').css("display", "none");

                        if ($("#DSStatus").val().toUpperCase() == "CLOSED") {
                            $('#UpdateDS').css("display", "none");
                        }
                        else {
                            $('#UpdateDS').css("display", "inline-block");
                        }
                    }
                    else {

                        if (accesseditflag != undefined) {

                            if (accesseditflag == "True") {
                                $('#SaveDS').css("display", "inline-block");

                                $('#UpdateDS').css("display", "none");
                            }
                            else {
                                $('#SaveDS').css("display", "none");
                                $('#UpdateDS').css("display", "none");
                            }
                        }
                        if (accessaddflag != undefined) {

                            if (accessaddflag == "True") {
                                if (accesseditflag == "True") {
                                    $('#SaveAndAddDS').css("display", "inline-block");
                                }
                                else {
                                    $('#SaveAndAddDS').css("display", "none");
                                }
                            }
                            else {
                                $('#SaveAndAddDS').css("display", "none");
                            }
                        }
                    }
                }
            }
            else if (id == 'divAddIssue') {
                $("#divDSbody").html('');
                $("#divImpedimentbody").html('');
                $("#divRiskbody").html('');
                var strUserResult = '';
                if (impedDescr != undefined) {
                    strUserResult = ajaxCall("frmImpedimentLog.aspx/AddIssueModal", "POST", "application/json", "json", JSON.stringify({ ImpedimentId: ImpedimentId }));
                }
                else {
                    strUserResult = ajaxCall("frmImpedimentLog.aspx/AddIssueModal", "POST", "application/json", "json", JSON.stringify({ ImpedimentId: '' }));
                }
                if (strUserResult != undefined) {
                    $("#divIssuebody").html(strUserResult.d);
                    $("#divAddIssue").modal('show');
                    /*Added by kashish For Texarea Enhancement*/
                    AutoResizeTextArea();
                    //autosize(document.querySelectorAll('textarea'));
                    if (impedDescr != undefined) {
                        impedDescr = impedDescr.replace("**", "'");
                        $("#txtImpedimentDescription").val(impedDescr);


                        $("#btnSaveAndAddIssue").attr("onclick", "Save_Issue_Details(1," + ImpedimentId + ")");

                        $("#btnSaveAndAddIssue").css("display", "none");
                        $("#btnSaveIssue").text("Convert");

                        $("#btnSaveIssue").attr("onclick", "Save_Issue_Details(0," + ImpedimentId + ")");

                        if (accesseditflag != undefined) {
                            if (accesseditflag == "True") {
                                $("#btnSaveIssue").css("display", "inline-block");
                            }
                            else {
                                $("#btnSaveIssue").css("display", "none");
                            }
                        }

                    }
                    else {

                        GetDefaultIssueType();

                        $("#btnSaveAndAddIssue").css("display", "inline-block");
                        $("#btnSaveIssue").text("Save");
                        $("#btnSaveAndAddIssue").attr("onclick", "Save_Issue_Details(1)");
                        $("#btnSaveIssue").attr("onclick", "Save_Issue_Details(0)");
                    }

                }
            }
            else if (id == 'divAddRisk') {
                $("#divDSbody").html('');
                $("#divImpedimentbody").html('');
                $("#divIssuebody").html('');

                var strUserResult = '';
                if (impedDescr != undefined) {
                    strUserResult = ajaxCall("frmImpedimentLog.aspx/AddRiskModal", "POST", "application/json", "json", JSON.stringify({ ImpedimentId: ImpedimentId }));
                }
                else {
                    strUserResult = ajaxCall("frmImpedimentLog.aspx/AddRiskModal", "POST", "application/json", "json", JSON.stringify({ ImpedimentId: '' }));
                }
                if (strUserResult != undefined) {
                    $("#divRiskbody").html(strUserResult.d);
                    $("#divAddRisk").modal('show');
                    /*Added by kashish For Texarea Enhancement*/
                    AutoResizeTextArea();
                    //autosize(document.querySelectorAll('textarea'));
                    var curProjectRiskId = getProjectRiskId();
                    $("#ProjectRiskID").val(curProjectRiskId);
                    $("#ProjectRiskID").prop("disabled", true);
                    $("#ProjectRiskID").addClass("clsDisableColor");
                    if (impedDescr != undefined) {
                        impedDescr = impedDescr.replace("**", "'");
                        $("#txtImpedimentDescription").val(impedDescr);
                        $("#btnSaveAndAddRisk").attr("onclick", "Save_Risk_Details(1," + ImpedimentId + ")");
                        $("#btnSaveAndAddRisk").css("display", "none");
                        $("#btnSaveRisk").text("Convert");
                        if (flag != undefined) {
                            $("#btnSaveRisk").attr("onclick", "Save_Risk_Details(0," + ImpedimentId + ",'" + flag + "')");
                        }
                        else {
                            $("#btnSaveRisk").attr("onclick", "Save_Risk_Details(0," + ImpedimentId + ")");
                        }
                        if (accesseditflag != undefined) {
                            if (accesseditflag == "True") {
                                $("#btnSaveRisk").css("display", "inline-block");
                            }
                            else {
                                $("#btnSaveRisk").css("display", "none");
                            }
                        }
                    }
                    else {

                        $("#btnSaveAndAddRisk").css("display", "inline-block");
                        $("#btnSaveRisk").text("Save");
                        $("#btnSaveAndAddRisk").attr("onclick", "Save_Risk_Details(1)");
                        $("#btnSaveRisk").attr("onclick", "Save_Risk_Details(0)");
                    }
                    $('#IdentifiedDate').datepicker(
                        {
                            changeMonth: true,
                            changeYear: true,
                           //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                            //yearRange: '2000:2020'
                            yearRange: 'c-100:c+100'
                            //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                        }
                    );
                    $('#IdentifiedDate').prop('readonly', true);
                }

            }
        }
        function setTextAreaHeight() {
            try {

                var textAreas = [].slice.call(document.querySelectorAll('textarea'));

                // iterate through all the textareas on the page
                textAreas.forEach(function (el) {

                    var minHeight = el.scrollHeight;
                    adjustHeight(el, minHeight);
                });
            }
            catch (ex) {
                alert(ex.message);
            }
        }
        function adjustHeight(textareaElement, minHeight) {
            // compute the height difference which is caused by border and outline
            var outerHeight = parseInt(window.getComputedStyle(textareaElement).height, 10);
            var diff = outerHeight - textareaElement.clientHeight;

            // set the height to 0 in case of it has to be shrinked
            textareaElement.style.height = 0;

            // set the correct height
            // el.scrollHeight is the full height of the content, not just the visible part
            textareaElement.style.height = Math.max((minHeight + 100), textareaElement.scrollHeight + diff) + 'px';

        }
        function ShowHistory(ImpedimentID) {
            try {

                $("#txtSearchHistory").val("");
                var data = JSON.stringify({ ImpedimentID: ImpedimentID });
                var result = ajaxCall("frmImpedimentLog.aspx/ShowHistoryDetails", "POST", "application/json", "json", data);

                //alert(strResult.d);
                if (result != undefined) {

                    if (result.d != "") {

                        $("#DivShowhistory #GetShowhistory").html(result.d);

                        $('#DivGridShowHistory table > tbody > tr ').each(function (index) {
                            if ($(this).children('td').length == 0) {
                                $(this).remove();
                            }
                        });

                        //if ($('#DivGridShowHistory table > tbody > tr:has(td)')) {
                        //}
                        //datatables('DivGridShowHistory', 'txtSearchHistory', '');
                        //Added By Dipali V On 24th March 2023 For Datatable Issue
                        if ($("#FilterGridShowHistory").val() > 0) {
                            datatables('DivGridShowHistory', 'txtSearchHistory', '');
                        }
                      //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                        $("#DivGridShowHistory").find(".dataTables_wrapper").find(".row").find(".col-sm-12").find(".dataTables_scroll").find(".dataTables_scrollBody").addClass("clsSetHeight");
                        //$("#DivGridShowHistory").find(".dataTables_wrapper").find(".row").find(".col-sm-12").find(".dataTables_scroll").find(".dataTables_scrollBody").css("height", 325);
                        //datatable("#DivGridShowHistory");
                        //datatables("DivGridShowHistory", '', "");
                        SetWidthHeight();


                        $('.tt_large').tooltip({
                            template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner large"></div></div>'
                        });


                        $("#DivShowhistory").modal('show');
                        $("#Idheader").html("Show History");
                        //$('[data-bs-toggle="tooltip"]').tooltip();
                        //$('#DivGridShowHistory').DataTable();
                    }
                }
            }
            catch (ex) {
                alert(ex.message);
            }
        }
        //function ajaxCall(url, type, contentType, dataType, data) {
        //    var ajaxResult;
        //    $.ajax({
        //        url: url,
        //        type: type,
        //        contentType: contentType,
        //        dataType: dataType,
        //        data: data,
        //        async: false,
        //        success: function (result) {
        //            ajaxResult = result;
        //        },
        //        error: function (xhr) {
        //            console.log(xhr);
        //        }
        //    })

        //    return ajaxResult;
        //}
        function AssignToListClick(object) {
            $("#txtAssignedTo").val(object.name);
            $("#hdnAssignToId").val(object.id);

        }
        function ClearFilter(obj) {
            $('[data-bs-toggle="tooltip"]').tooltip();

            curWhereFlag = '';
            curWhereValue = '';

            strGlobaFilterField = "";
            strGlobalFilterValue = "";
            ShowFilter(strGlobalFilterValue, strGlobaFilterField);
            $(obj).css("visibility", "hidden");
        }
        function myFunction() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("txtAssignedTo");
            filter = input.value.toUpperCase();
            ul = document.getElementById("emplistUL");
            li = document.getElementsByClassName("clsAssignedListItem");
            for (i = 0; i < li.length; i++) {
                a = li[i].innerText;
                if (a.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";

                }
            }
        }
        function Maxlength(limitField, limitCountField, limitNum) {
            var length;
            if (limitField.value.length > limitNum) {
                limitField.value = limitField.value.substring(0, limitNum);
            } else {
                document.getElementById(limitCountField).innerHTML = +(limitNum - limitField.value.length);
            }

            if (limitNum - limitField.value.length == 0) {

                document.getElementById(limitCountField).style.color = 'red' //when Char 0 length  then Color red               



            }
            else {

                document.getElementById(limitCountField).style.color = 'black'
                // $('#spanBusinessValue').text("");


            }
            if (limitField.clientHeight < limitField.scrollHeight) {
                limitField.style.height = limitField.scrollHeight + "px";
                if (limitField.clientHeight < limitField.scrollHeight) {
                    limitField.style.height =
                        (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
                }
            }
        }
        function AssignedToSearch(assignedname) {
            if (assignedname == undefined)
                assignedname = '';
            var strUserResult = ajaxCall("frmImpedimentLog.aspx/DrawGrid", "POST", "application/json", "json", JSON.stringify({ Flag: "AssignTo", Value: assignedname, DateValue: '' }));
            if (strUserResult.d != null || strUserResult.d != undefined) {
                $("#DivList").html("");
                $("#DivList").html(strUserResult.d);
                //$('[data-bs-toggle="tooltip"]').tooltip();
                //Added By Dipali V On 24th March 2023 For Datatable Issue
                if ($("#FilterImpedimentLogList").val() > 0) {
                    datatables('DivImpedimentLogList', 'txtSearchDailyScrum', '');
                }
               //End of Added By Dipali V On 24th March 2023 For Datatable Issue
           

                $(".scrum_date").click(function () {

                    $(".scrum_date").removeClass("selecteddate")

                    $(this).addClass("selecteddate")

                })
            }
        }
        function WeekDate_onclick(strDate, obj) {
            curWhereDate = strDate;
            var strUserResult = ajaxCall("frmImpedimentLog.aspx/DrawGrid", "POST", "application/json", "json", JSON.stringify({ Flag: 'WEEKDATE', Value: strDate, DateValue: 'abc' }));
            //if (strUserResult.d != null || strUserResult.d != undefined) {
                if (strUserResult != null && strUserResult != undefined) {
                    if (strUserResult.d != null || strUserResult.d != undefined) {
                $("#DivList").html("");
                $("#DivList").html(strUserResult.d);




                //$('[data-bs-toggle="tooltip"]').tooltip();
                        //Added By Dipali V On 24th March 2023 For Datatable Issue
                        if ($("#FilterImpedimentLogList").val() > 0) {
                            datatables('DivImpedimentLogList', 'txtSearchDailyScrum', '');
                        }
               //End of Added By Dipali V On 24th March 2023 For Datatable Issue


                //datatables('DivImpedimentLogList', 'txtSearchDailyScrum', '');


                //$("#detailDropdown").addClass('mydetaildropdown');


                $(".scrum_date").click(function () {

                    $(".scrum_date").removeClass("selecteddate")

                    $(this).addClass("selecteddate")


                })
               }
             }

        }
        function RefreshGrid() {
            try {
                var strUserResult = ajaxCall("frmImpedimentLog.aspx/DrawGrid", "POST", "application/json", "json", JSON.stringify({ Flag: 'SAVEGRID', Value: '', DateValue: '' }));
                if (strUserResult.d != null || strUserResult.d != undefined) {
                    $("#DivList").html("");
                    $("#DivList").html(strUserResult.d);
                    //$('[data-bs-toggle="tooltip"]').tooltip();



                   
                    //Added By Dipali V On 24th March 2023 For Datatable Issue
                    if ($("#FilterImpedimentLogList").val() > 0) {
                        datatables('DivImpedimentLogList', 'txtSearchDailyScrum', '');
                    }
               //End of Added By Dipali V On 24th March 2023 For Datatable Issue


                    $(".scrum_date").click(function () {

                        $(".scrum_date").removeClass("selecteddate")

                        $(this).addClass("selecteddate")

                    });

                    var row = 1;
                    $('#tblweekdates tbody > tr').each(function (value, index) {

                        //var cell = 'table tr:nth-child(' + row + ') td:nth-child(8)';
                        //alert(index.text);
                        
                        if ($(this).find('td.selecteddate').length == 1) {
                            var selecteddate = $(this).find('a');
                            //Commented And Added By Usha Pandit On 18.02.2021 For getting date in correct format
                            //WeekDate_onclick(selecteddate.text());
			    selecteddate = selecteddate.text();
                            if ($(".selecteddate a").attr("onclick") != undefined) {
                                var currDate = $(".selecteddate a").attr("onclick");
                                currDate = currDate.toString().replace("WeekDate_onclick(", "");
                                currDate = currDate.toString().replace(",this)", "");
                                currDate = currDate.toString().replace(/'/g, ""); 
                                selecteddate = currDate;                               
                            }
                            WeekDate_onclick(selecteddate);
                            //End Of Added By Usha Pandit On 18.02.2021 For getting date in correct format
                        }
                        //row = row + 1;
                    });
                    //var table = document.getElementById("tblweekdates");
                    //for (var i = 0, row; row = table.rows[i]; i++) {
                    //    //iterate through rows
                    //    //rows would be accessed using the "row" variable assigned in the for loop
                    //    for (var j = 0, col; col = row.cells[j]; j++) {
                    //        if (col.hasClass("selecteddate")) {
                    //            alert(1);
                    //            var abc = col.find(a);
                    //            alert(abc.text);
                    //        }
                    //        //iterate through columns
                    //        //columns would be accessed using the "col" variable assigned in the for loop
                    //    }
                    //}

                    //$("#tblweekdates tr > td").hasClass(".dataTables_scrollBody").css("height", (dtHeight / 4) + 59);
                    //WeekDate_onclick();
                }
            }
            catch (ex) {

            }
        }

        var blnStatus = false;
        var blnSprints = false;
        var blnDailyStandUp = false;

        function ShowStatus(obj, divID) {

            var blnminuseactive = false;
            //UlFilter
            //overflow: hidden;
            //height: 220px;

            if ($(obj).hasClass("fa-plus-circle")) {
                $(obj).removeClass("fa-plus-circle");
                $(obj).addClass("fa-minus-circle");
                //Added By Usha Pandit On 25.04.2020 For highlight child on hover and remove hover for parent
                $(obj).parent().addClass("no-hover");
                //End Of Added By Usha Pandit On 25.04.2020 For highlight child on hover and remove hover for parent
                $("#" + divID).css("display", "block");                
                blnminuseactive = true;
            }
            else if ($(obj).hasClass("fa-minus-circle")) {
                $(obj).removeClass("fa-minus-circle");
                //Added By Usha Pandit On 25.04.2020 For highlight parent on hover and remove hover for child
                $(obj).parent().removeClass("no-hover");
                //End Of Added By Usha Pandit On 25.04.2020 For highlight parent on hover and remove hover for child
                $(obj).addClass("fa-plus-circle");
                $("#" + divID).css("display", "none");


            }

            if (divID == "divStatus") {
                if (blnminuseactive == true) {
                    blnStatus = true;
                }
                else {
                    blnStatus = false;
                }
            }
            if (divID == "divSprints") {
                if (blnminuseactive == true) {
                    blnSprints = true;
                } else {
                    blnSprints = false;
                }
            }
            if (divID == "divDailyStandUp") {
                if (blnminuseactive == true) {
                    blnDailyStandUp = true;
                } else {
                    blnDailyStandUp = false;
                }
            }
            if (blnStatus == true && blnSprints == false && blnDailyStandUp == false) {
                $("#UlFilter").css("cssText", "overflow: auto!important;height: 350px!important;transform: translate(-39px, 29px);");
            }
            if (blnStatus == false && blnSprints == true && blnDailyStandUp == false) {
                $("#UlFilter").css("cssText", "overflow: auto!important;height: 220px!important;transform: translate(-39px, 29px);");
            }
            if (blnStatus == false && blnSprints == false && blnDailyStandUp == true) {
                $("#UlFilter").css("cssText", "overflow: auto!important;height: 200px!important;transform: translate(-39px, 29px);");
            }
            if (blnStatus == false && blnSprints == false && blnDailyStandUp == false) {
                $("#UlFilter").css("cssText", "overflow: auto!important;height: 150px!important;transform: translate(-39px, 29px);");
            }
            if (blnStatus == true && blnSprints == true && blnDailyStandUp == true) {
                $("#UlFilter").css("cssText", "overflow: auto!important;height: 470px!important;transform: translate(-39px, 29px);");
            }
            if (blnStatus == false && blnSprints == true && blnDailyStandUp == true) {
                $("#UlFilter").css("cssText", "overflow: auto!important;height: 300px!important;transform: translate(-39px, 29px);");
            }
            if (blnStatus == false && blnSprints == true && blnDailyStandUp == true) {
                $("#UlFilter").css("cssText", "overflow: auto!important;height: 300px!important;transform: translate(-39px, 29px);");
            }
            if (blnStatus == true && blnSprints == true && blnDailyStandUp == false) {
                $("#UlFilter").css("cssText", "overflow: auto!important;height: 400px!important;transform: translate(-39px, 29px);");
            }
            if (blnStatus == true && blnSprints == false && blnDailyStandUp == true) {
                $("#UlFilter").css("cssText", "overflow: auto!important;height: 400px!important;transform: translate(-39px, 29px);");
            }
        }
        function ShowFilter(Value, flag) {
            //debugger;

            var fromdate = '';
            var m_names = new Array("Jan", "Feb", "Mar",
                "Apr", "May", "Jun", "Jul", "Aug", "Sep",
                "Oct", "Nov", "Dec");
            try {

                var tempdate = $(".selecteddate a").text();
                //var d = new Date(''+$(".selecteddate a").text()+'');
                //var d = new Date('' + tempdate + '');
                //var curr_date = d.getDate();
                //var curr_month = d.getMonth();
                //var curr_year = d.getFullYear();
                //fromdate = curr_date + "-" + m_names[curr_month] + "-" + curr_year;
                //Commented And Added By Usha Pandit On 16.02.2021 For getting date in correct format
                //fromdate = tempdate;
                //Commented And Added By Usha Pandit On 18.02.2021 For getting date in correct format
                //var decDate = $("#hidSelectedate").val();
                //if (decDate != '' && decDate != null && decDate != undefined)
                //    SelectedDate = decDate;
                //if (curWhereDate == "") {
                //    tempdate = decDate;
                //}
                //else {
                //    tempdate = curWhereDate;
                //}
                
                //tempdate = tempdate.toString().trim();
                //fromdate = tempdate;
                
                fromdate = tempdate;
                if ($(".selecteddate a").attr("onclick") != undefined) {                    
                    var currDate = $(".selecteddate a").attr("onclick");
                    currDate = currDate.toString().replace("WeekDate_onclick(", "");
                    currDate = currDate.toString().replace(",this)", "");
                    currDate = currDate.toString().replace(/'/g, "");
                    fromdate = currDate;
                }
                
                //End Of Added By Usha Pandit On 18.02.2021 For getting date in correct format
                //fromdate = tempdate;
                //End Of Added By Usha Pandit On 16.02.2021 For getting date in correct format
            }
            catch (ex) {
                //alert(ex.message);
            }
            strGlobaFilterField = flag;
            strGlobalFilterValue = Value;
            if (flag == "Sprints") {
                Value = $("#DSFilterSprint :selected").val();

            }
            curWhereFlag = flag;
            curWhereValue = Value;
            var strUserResult = ajaxCall("frmImpedimentLog.aspx/DrawGrid", "POST", "application/json", "json", JSON.stringify({ Flag: flag, Value: Value, DateValue: fromdate }));
             //Added by Usha Pandit on 10.05.2019 for impediment save crash        
            if (strUserResult != undefined) {
                 //End of Added by Usha Pandit on 10.05.2019 for impediment save crash
                if (strUserResult.d != null && strUserResult.d != undefined) {
                    $("#DivList").html("");
                    $("#DivList").html(strUserResult.d);
                    //$('[data-bs-toggle="tooltip"]').tooltip();
                    //Added By Dipali V On 24th March 2023 For Datatable Issue
                    if ($("#FilterImpedimentLogList").val() > 0) {
                        datatables('DivImpedimentLogList', 'txtSearchDailyScrum', '');
                    }
                    //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                }
            }

            if (strGlobaFilterField != "" && strGlobaFilterField != "WEEKDATE") {
                $("#filterClear").css("visibility", "visible");
            }
            else {
                $("#filterClear").css("visibility", "hidden");
            }

            //Added By Usha Pandit on 08 June 2018 for clearing filter if sprint not selected 
            //if (flag == "Sprints" && Value == "") {
            //    $("#filterClear").css("visibility", "hidden");
            //}
            //End of Added By Usha Pandit on 08 June 2018 for clearing filter if sprint not selected 
        }
        function Save_Impediment(flagMode) {
            //setFrameLoader();

           
            var Flag = 0;
            var checkvalue = 0;
            var strmsg = "";
            var errorMsg = ""

            var objtxtImpedimentDescription;
            var objimpedimentSeverity;
            var objimpedimentPriority;
            var objtxtCorrectiveAction;
            var objtxtPreventiveAction;
            var objdtPlannedIssueDate;
            var objimpedimentStatus;
            var objtxtConvertedTo;

            objtxtImpedimentDescription = document.getElementById("txtImpedimentDescription");
            objimpedimentSeverity = document.getElementById("impedimentSeverity");
            objimpedimentPriority = document.getElementById("impedimentPriority");
            objtxtCorrectiveAction = document.getElementById("txtCorrectiveAction");
            objtxtPreventiveAction = document.getElementById("txtPreventiveAction");
            objdtPlannedIssueDate = document.getElementById("dtPlannedIssueDate");
            objimpedimentStatus = document.getElementById("impedimentStatus");
            objtxtConvertedTo = $("#impedimentConvertTo :selected").text();

            if ($("#cboSprint :selected").text() == "") {
                strmsg = '- Please select sprint.';
                errorMsg += "<li>" + strmsg + "</li><BR/>";
                //alertify.notify('', 'error');
                $("#cboSprint").focus();
                checkvalue = 1;
            }

            if (objtxtImpedimentDescription.value == "") {
                strmsg = '- Description can not be left blank.';
                errorMsg += "<li>" + strmsg + "</li><BR/>";
                //alertify.notify('', 'error');
                if ($('#cboSprint').is(':focus') == true) {
                }
                else {
                    $("#txtImpedimentDescription").focus();
                }
                checkvalue = 1;
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            if (checkSpecialCharacter(objtxtImpedimentDescription.value, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtImpedimentDescription").focus();
                checkvalue = 1;
            }
			//End of Added By Riddhesh Patil

            //Added By Riddhesh Patil on 11-NOV-2022 
            if (objtxtCorrectiveAction.value != "") {
                if (checkSpecialCharacter(objtxtCorrectiveAction.value, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Corrective Action should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtCorrectiveAction").focus();
                    checkvalue = 1;
                }
            }  
            if (objtxtPreventiveAction.value != "") {
                if (checkSpecialCharacter(objtxtPreventiveAction.value, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Preventiv Action should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtPreventiveAction").focus();
                    checkvalue = 1;
                }
            }
			//End of Added By Riddhesh Patil
            if ($("#impedimentConvertTo :selected").text() == "Issue") {
                var blnDefaultIssue = false;
                var strUserResult = ajaxCall("frmImpedimentLog.aspx/DefaultIssueExist", "POST", "application/json", "json", JSON.stringify({}));
                if (strUserResult != undefined) {
                    if (strUserResult.d == "") {
                        blnDefaultIssue = true;
                    }
                    else {
                        blnDefaultIssue = false;
                        errorMsg += "<li> - " + strUserResult.d + "</li><BR/>";
                        checkvalue = 1;
                    }
                }
                if (blnDefaultIssue == true) {

                    if (objimpedimentPriority.value == "") {
                        if (objimpedimentSeverity.value != "") {
                            errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                        }
                        strmsg = '- Priority can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        //var hasFocus = $('#txtImpedimentDescription').is(':focus');
                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus')) {

                        }
                        else {
                            $("#impedimentPriority").focus();
                        }
                    }

                    if (objimpedimentSeverity.value == "") {
                        errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                        strmsg = '- Severity can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";

                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#impedimentPriority').is(':focus') == true) {

                        }
                        else {
                            $("#impedimentSeverity").focus();
                        }
                        checkvalue = 1;
                    }


                    objtxtResponsiblePerson = $("#ResponsiblePerson :selected").text();

                    if (objtxtResponsiblePerson == "") {
                        strmsg = '- Responsible Person can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#impedimentPriority').is(':focus') == true || $('#impedimentSeverity').is(':focus') == true) {

                        }
                        else {
                            $("#ResponsiblePerson").focus();
                        }
                    }
                }
            }

            if (objtxtConvertedTo == "Risk") {
                objtxtProbability = document.getElementById("Probability");
                objtxtImpact = document.getElementById("Impact");
                objoptRiskCategory = $("#RiskCategory :selected").val();

                if (objoptRiskCategory == "") {
                    strmsg = '- Risk Category can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;
                    //var hasFocus = $('#txtImpedimentDescription').is(':focus');
                    if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus')) {

                    }
                    else {
                        $("#RiskCategory").focus();
                    }
                }

                if (objtxtImpact.value == "") {
                    strmsg = '- Impact can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true) {

                    }
                    else {
                        $("#Impact").focus();
                    }
                }
                else if (objtxtImpact.value != "") {
                    if ($("#Impact").val() <= 0 || $("#Impact").val() > 10) {
                        strmsg = "- Enter Imapct value between 1-10.";
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true) {

                        }
                        else {
                            $("#Impact").focus();
                        }
                    }
                }
                if (objtxtProbability.value == "") {
                    strmsg = '- Probability can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#Impact').is(':focus') == true) {

                    }
                    else {
                        $("#Probability").focus();
                    }
                }
                else if (objtxtProbability.value != "") {
                    if ($("#Probability").val() < 0 || $("#Probability").val() > 1) {
                        strmsg = "- Enter probability between 0-1.";
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                        if ($('#cboSprint').is(':focus') == true || $('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#Impact').is(':focus') == true) {

                        }
                        else {
                            $("#Probability").focus();
                        }
                    }
                }
            }


            if (checkvalue == 0) {
                if (flagMode == 0) {
                    $("#btnSaveImpediment").attr('disabled', true);             //Added by Usha Pandit on 07 JUNE 2018 to prevent duplicate convert to risk/Issue 
                    $("#btnSaveAndAddImpediment").attr('disabled', false);
                }
                else if (flagMode == 1) {
                    $("#btnSaveImpediment").attr('disabled', false);
                    $("#btnSaveAndAddImpediment").attr('disabled', true);
                }
                var data = JSON.stringify({ ImpedimentID: '', ImpedimentDescription: objtxtImpedimentDescription.value, ImpedimentSeverity: objimpedimentSeverity.value, ImpedimentPriority: objimpedimentPriority.value, CorrectiveAction: objtxtCorrectiveAction.value, PreventiveAction: objtxtPreventiveAction.value, PlannedIssueDate: objdtPlannedIssueDate.value, impedimentStatus: objimpedimentStatus.value, ConvertedTo: objtxtConvertedTo, IterationID: $("#cboSprint :selected").val() });
                var result = ajaxCall("frmImpedimentLog.aspx/SaveImpediment", "POST", "application/json", "json", data);
                if (result != undefined) {
                    if (result.d != "") {



                        var ImpedimentID = result.d;
                        if (objtxtConvertedTo == "Risk") {

                            objtxtProbability = document.getElementById("Probability");
                            objtxtImpact = document.getElementById("Impact");
                            objoptRiskCategory = $("#RiskCategory :selected").val();

                            //Save Risk Details
                            var data = JSON.stringify({ Probability: objtxtProbability.value, Impact: objtxtImpact.value, Description: objtxtImpedimentDescription.value, RiskCategoryId: objoptRiskCategory, ImpedimentID: ImpedimentID, ImpactDescription: '', RiskStatus: '', DateIdentified: '' });
                            var result = ajaxCall("frmImpedimentLog.aspx/SaveImpedimentRisk", "POST", "application/json", "json", data);
                            if (result != undefined) {

                            }
                        }

                        if (objtxtConvertedTo == "Issue") {

                            //Save Issue Details
                            var data = JSON.stringify({ Description: objtxtImpedimentDescription.value, ImpedimentID: ImpedimentID, AssignTo: $("#ResponsiblePerson :selected").val(), Type: '', SubType: '', Status: '', ReportedBy: '', Summary: '', Priority: $("#impedimentPriority :selected").text(), Severity: $("#impedimentSeverity :selected").text() });
                            var result = ajaxCall("frmImpedimentLog.aspx/SaveImpedimentIssue", "POST", "application/json", "json", data);
                            if (result != undefined) {

                            }
                        }

                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Impediment Saved Successfully', 'success', 10);

                        //RemoveFrameLoader();
                        if (flagMode == 1) {

                            ShowFilter(strGlobalFilterValue, strGlobaFilterField);
                            ShowModal("divAddImpediment", "", "");
                            $("#btnSaveAndAddImpediment").attr('disabled', false);
                        }
                        else if (flagMode == 0) {
                            $("#divAddImpediment .close").click();
                            ShowFilter(strGlobalFilterValue, strGlobaFilterField);

                        }
                        RefreshGrid();
                    }
                }
            }
            else if (checkvalue == 1) {
                if (errorMsg != "") {
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 10);
                }
            }
        }

        function GetDefaultIssueType() {
            try {
                var url = "frmImpedimentLog.aspx/getDefaultIssueType"
                data = JSON.stringify({});
                var result = ajaxCall(url, "POST", "application/json", "json", data);
                if (result.d != undefined) {
                    arrDefault = result.d.split("|");
                    $("#txtType").val(arrDefault[0]);
                    GetSelectedType(arrDefault[0]);
                    $("#txtSubType").val(arrDefault[1]);
                    $("#txtStatus").val(arrDefault[2]);
                }
            }
            catch (ex) {
                alert(ex.message);
            }
        }

        function GetSelectedType(selectType) {

            try {
                var url = "frmImpedimentLog.aspx/GetSubType"
                if (selectType.value == undefined)
                    data = JSON.stringify({ Type: selectType });
                else
                    data = JSON.stringify({ Type: selectType.value });
                var result = ajaxCall(url, "POST", "application/json", "json", data);
                BindDropDownSubType(result);

                //Added By Usha Pandit On 09.11.2020 For getting correct status
                GetStatus(selectType)
                //End Of Added By Usha Pandit On 09.11.2020 For getting correct status
            }
            catch (ex) {
                alert(ex.message);
            }
        }

        //Added By Usha Pandit On 09.11.2020 For getting correct status
        function GetStatus(selectType) {
            try {
                var url = "frmImpedimentLog.aspx/GetStatus"
                if (selectType.value == undefined)
                    data = JSON.stringify({ Type: selectType });
                else
                    data = JSON.stringify({ Type: selectType.value });
                var result = ajaxCall(url, "POST", "application/json", "json", data);
                BindDropDownStatus(result);
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        function BindDropDownStatus(result) {
            //  debugger;
            var strArray = String(result.d).split("|")
            var objCbo = document.getElementById("txtStatus");

            var i = 0;

            objCbo.innerHTML = "";
            $('#txtStatus').find('option').remove().end();
            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = "";
            objOption.value = "";

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                // $("#DRequestType").val($("#DRequestType option:first").val());
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.FieldName;
                objOption.value = obj.FieldID;
            });
        }
        //End Of Added By Usha Pandit On 09.11.2020 For getting correct status

        function BindDropDownSubType(result) {
            //  debugger;
            var strArray = String(result.d).split("|")
            var objCbo = document.getElementById("txtSubType");            
            var i = 0;

            objCbo.innerHTML = "";
            $('#txtSubType').find('option').remove().end();
            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = "";
            objOption.value = "";

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                // $("#DRequestType").val($("#DRequestType option:first").val());
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.FieldName;
                objOption.value = obj.FieldID;
            });
        }

        function GetSelectedRelease(selectRelease) {
            try {
                var url = "frmImpedimentLog.aspx/GetIteration"
                data = JSON.stringify({ ReleaseId: selectRelease.value });
                var result = ajaxCall(url, "POST", "application/json", "json", data);
                BindDropDownIteration(result);
            }
            catch (ex) {
                alert(ex.message);
            }
        }



        function BindDropDownIteration(result) {
            //  debugger;
            var strArray = String(result.d).split("|")
            var objCbo = document.getElementById("txtIteration");

            var i = 0;

            objCbo.innerHTML = "";
            $('#txtIteration').find('option').remove().end();
            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = "";
            objOption.value = "";

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                // $("#DRequestType").val($("#DRequestType option:first").val());
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.IterationName;
                objOption.value = obj.IterationID;
            });
        }

        function GetSelectedIteration(selectIteration) {


            try {
                var url = "frmImpedimentLog.aspx/GetUserStory"
                data = JSON.stringify({ IterationId: selectIteration.value });
                var result = ajaxCall(url, "POST", "application/json", "json", data);
                BindDropDownUserStory(result);
            }
            catch (ex) {
                alert(ex.message);
            }
        }



        function BindDropDownUserStory(result) {
            //  debugger;
            var strArray = String(result.d).split("|")
            var objCbo = document.getElementById("txtUserStory");

            var i = 0;

            objCbo.innerHTML = "";
            $('#txtUserStory').find('option').remove().end();
            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = "";
            objOption.value = "";

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                // $("#DRequestType").val($("#DRequestType option:first").val());
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.UserStoryName;
                objOption.value = obj.UserStoryID;
            });
        }
        function getselectedDStatus(selectItem) {
            if (selectItem.value == "Rejected" || selectItem.value == "Differed") {
                if ($("#impedimentConvertTo").val() != "" && $('#impedimentConvertTo').is(':disabled') == false) {
                    var selectval = $("#impedimentConvertTo").val();
                    var selectstatus = selectItem.value;
                    $("#impedimentConvertTo").val("");
                    GetSelectedConvertTo("", selectval, selectstatus);
                }
                $("#impedimentConvertTo").prop("disabled", true);
                $("#impedimentConvertTo").addClass("clsDisableColor");
            }
            if (selectItem.value == "Open") {
                if ($("#impedimentConvertTo").val() != "" && $('#impedimentConvertTo').is(':disabled') == true) {

                }
                else {
                    $("#impedimentConvertTo").prop("disabled", false);
                }
            }
        }
        function GetSelectedConvertTo(selectItem, itemval, selectstatus) {
            if (selectItem == "") {
                $("#divResponsePerson").addClass("clsShow");
                $("#divRiskFields").addClass("clsShow");
                $("#divRiskCategory").addClass("clsShow");
                $(".clsIsMandetory").each(function () {
                    var $element = $(this)
                    try {
                        var tempval = $element.text();
                        tempval = tempval.replace("*", "");
                        $element.text(tempval);
                    }
                    catch (ex) {
                    }
                });
                alertify.dismissAll();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Impediment is ' + selectstatus + ' can not be converted as ' + itemval, 'error', 10);
            }
            else if (selectItem.value == "") {

                $("#divResponsePerson").addClass("clsShow");
                $("#divRiskFields").addClass("clsShow");
                $("#divRiskCategory").addClass("clsShow");
                $(".clsIsMandetory").each(function () {
                    var $element = $(this)
                    try {
                        var tempval = $element.text();
                        tempval = tempval.replace("*", "");
                        $element.text(tempval);
                    }
                    catch (ex) {
                    }
                });
            }
            else
                if (selectItem.value == "Issue") {
                    if ($("#DSStatus :selected").text() == selectstatus || $("#impedimentStatus :selected").text() == selectstatus) {
                        $("#impedimentConvertTo").val("");
                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- Impediment is ' + selectstatus + ' can not be converted as issue', 'error', 10);
                    }
                    else {
                        $("#divResponsePerson").removeClass("clsShow");
                        $("#divRiskFields").addClass("clsShow");
                        $("#divRiskCategory").addClass("clsShow");

                        $(".clsIsMandetory").each(function () {
                            var $element = $(this)
                            try {
                                var tempval = $element.text();
                                if (tempval.indexOf("*") == -1) {
                                    tempval = tempval.replace(tempval, tempval + "*");
                                    $element.text(tempval);
                                }
                            }
                            catch (ex) {

                            }
                        });
                    }
                }
                else if (selectItem.value == "Risk") {
                    if ($("#DSStatus :selected").text() == selectstatus || $("#impedimentStatus :selected").text() == selectstatus) {
                        $("#impedimentConvertTo").val("");
                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- Impediment is ' + selectstatus + ' can not be converted as risk', 'error', 10);
                    }
                    else {
                        $("#divRiskFields").removeClass("clsShow");
                        $("#divRiskCategory").removeClass("clsShow");
                        $("#divResponsePerson").addClass("clsShow");
                        $(".clsIsMandetory").each(function () {
                            var $element = $(this)
                            try {
                                var tempval = $element.text();
                                tempval = tempval.replace("*", "");
                                $element.text(tempval);
                            }
                            catch (ex) {

                            }
                        });
                    }
                }
        }
        function calculateMagnitude() {
            // debugger;
            var curImpact = $("#Impact").val();
            var curProbability = $("#Probability").val();
            if (curImpact == undefined) {

                curImpact = 0;

            }
            else {

                curImpact = curImpact;
            }

            if (curProbability == undefined) {

                curProbability = 0;

            }
            else {

                curProbability = curProbability;
            }

            if (curImpact == 0 && curMagnitude == 0) {
                $("#Magnitude").val("0");
            }
            else {
                var curMagnitude = curImpact * curProbability;
                $("#Magnitude").val(curMagnitude);
            }


        }
        var saveissue = 0;
        function Save_Issue_Details(flagMode, ImpedId) {
            //debugger;
            try {
                var checkvalue = 0;
                var errorMsg = "";
                var strmsg = "";

                objtxtImpedimentDescription = document.getElementById("txtImpedimentDescription");

                objimpedimentSeverity = document.getElementById("impedimentSeverity");
                objimpedimentPriority = document.getElementById("impedimentPriority");
                var objImpedimentDescription = $("#txtImpedimentDescription").val();
                if (objtxtImpedimentDescription.value == "") {
                    strmsg = '- Description can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    //alertify.notify('', 'error');

                    $("#txtImpedimentDescription").focus();
                    checkvalue = 1;
                }
                //Added By Riddhesh Patil on 11-NOV-2022 

                else if (checkSpecialCharacter(objImpedimentDescription, WebConfigSpecialCharacters) == true) {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = 'Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    $("#txtImpedimentDescription").focus();
                    checkvalue = 1;
                }

            //End of Added By Riddhesh Patil
                if (ImpedId == undefined) {

                    objtxtSummary = $("#txtSummary").val();

                    if (objtxtSummary == "") {
                        strmsg = '- Summary can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                        //var hasFocus = $('#txtImpedimentDescription').is(':focus');
                        //if (hasFocus) {

                        //}
                        //else {
                        $("#txtSummary").focus();
                        //}                      
                    }
                    //Added By Riddhesh Patil on 11-NOV-2022 
                    else if (checkSpecialCharacter(objtxtSummary, WebConfigSpecialCharacters) == true) {
                       // alertify.set('notifier', 'position', 'top-right');
                        strmsg = 'Summary should not contain any of these ' + WebConfigSpecialCharacters + ' characters';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        $("#txtSummary").focus();
                        checkvalue = 1;
                    }

            //End of Added By Riddhesh Patil
                    if (objtxtSummary != "" && objtxtImpedimentDescription.value == "") {
                        $("#txtImpedimentDescription").focus();
                        checkvalue = 1;
                    }
                    objtxtType = $("#txtType :selected").text();

                    if (objtxtType == "") {
                        strmsg = '- Type can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                        if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtSummary').is(':focus') == true) {

                        }
                        else {
                            $("#txtType").focus();
                        }
                    }

                    objtxtSubType = $("#txtSubType :selected").text();

                    if (objtxtSubType == "") {
                        strmsg = '- Sub Type can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtSummary').is(':focus') == true || $('#txtType').is(':focus') == true) {

                        }
                        else {
                            $("#txtSubType").focus();
                        }
                    }

                    if (objimpedimentPriority.value == "") {
                        if (objimpedimentSeverity.value != "") {
                            errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                        }
                        strmsg = '- Priority can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtSummary').is(':focus') == true || $('#txtType').is(':focus') == true || $('#txtSubType').is(':focus') == true) {

                        }
                        else {
                            $("#impedimentPriority").focus();
                        }
                    }

                    if (objimpedimentSeverity.value == "") {
                        errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                        strmsg = '- Severity can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtSummary').is(':focus') == true || $('#txtType').is(':focus') == true || $('#txtSubType').is(':focus') == true || $('#impedimentPriority').is(':focus') == true) {

                        }
                        else {
                            $("#impedimentSeverity").focus();
                        }
                    }


                    objtxtReportedBy = $("#txtReportedBy :selected").text();

                    if (objtxtReportedBy == "") {
                        strmsg = '- Reported By can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtSummary').is(':focus') == true || $('#txtType').is(':focus') == true || $('#txtSubType').is(':focus') == true || $('#impedimentPriority').is(':focus') == true || $('#impedimentSeverity').is(':focus') == true) {

                        }
                        else {
                            $("#txtReportedBy").focus();
                        }
                    }

                    objtxtStatus = $("#txtStatus :selected").text();

                    if (objtxtStatus == "") {
                        strmsg = '- Status can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtSummary').is(':focus') == true || $('#txtType').is(':focus') == true || $('#txtSubType').is(':focus') == true || $('#impedimentPriority').is(':focus') == true || $('#impedimentSeverity').is(':focus') == true || $('#txtReportedBy').is(':focus') == true) {

                        }
                        else {
                            $("#txtStatus").focus();
                        }
                    }

                    objtxtResponsiblePerson = $("#ResponsiblePerson :selected").text();

                    if (objtxtResponsiblePerson == "") {
                        strmsg = '- Responsible Person can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;

                        if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtSummary').is(':focus') == true || $('#txtType').is(':focus') == true || $('#txtSubType').is(':focus') == true || $('#impedimentPriority').is(':focus') == true || $('#impedimentSeverity').is(':focus') == true || $('#txtReportedBy').is(':focus') == true || $('#txtStatus').is(':focus') == true) {

                        }
                        else {
                            $("#ResponsiblePerson").focus();
                        }
                    }
                }
                if (ImpedId != undefined) {
                    var blnDefaultIssue = false;
                    var strUserResult = ajaxCall("frmImpedimentLog.aspx/DefaultIssueExist", "POST", "application/json", "json", JSON.stringify({}));
                    if (strUserResult != undefined) {
                        if (strUserResult.d == "") {
                            blnDefaultIssue = true;
                        }
                        else {
                            blnDefaultIssue = false;
                            errorMsg += "<li> - " + strUserResult.d + "</li><BR/>";
                            checkvalue = 1;
                        }
                    }

                    if (blnDefaultIssue == true) {

                        if (objimpedimentPriority.value == "") {
                            if (objimpedimentSeverity.value != "") {
                                errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                            }
                            strmsg = '- Priority can not be left blank.';
                            errorMsg += "<li>" + strmsg + "</li><BR/>";
                            checkvalue = 1;
                            var hasFocus = $('#txtImpedimentDescription').is(':focus');
                            if (hasFocus) {

                            }
                            else {
                                $("#impedimentPriority").focus();
                            }
                        }

                        if (objimpedimentSeverity.value == "") {
                            errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                            strmsg = '- Severity can not be left blank.';
                            errorMsg += "<li>" + strmsg + "</li><BR/>";
                            checkvalue = 1;
                            if ($('#txtImpedimentDescription').is(':focus') == true || $('#impedimentPriority').is(':focus') == true) {

                            }
                            else {
                                $("#impedimentSeverity").focus();
                            }
                        }


                        objtxtResponsiblePerson = $("#ResponsiblePerson :selected").text();

                        if (objtxtResponsiblePerson == "") {
                            strmsg = '- Responsible Person can not be left blank.';
                            errorMsg += "<li>" + strmsg + "</li><BR/>";
                            checkvalue = 1;

                            if ($('#txtImpedimentDescription').is(':focus') == true || $('#impedimentPriority').is(':focus') == true || $('#impedimentSeverity').is(':focus') == true) {

                            }
                            else {
                                $("#ResponsiblePerson").focus();
                            }
                        }
                    }
                }
                if (checkvalue == 0) {
                    $("#btnSaveIssue").attr('disabled', true);             //Added by Usha Pandit on 05 JUNE 2018 to prevent duplicate convert to risk/Issue 
                    //Save Issue Details
                    var data = "";
                    if (ImpedId != undefined)
                        data = JSON.stringify({ Description: objtxtImpedimentDescription.value, ImpedimentID: ImpedId, AssignTo: $("#ResponsiblePerson :selected").val(), Type: '', SubType: '', Status: '', ReportedBy: '', Summary: '', Priority: $("#impedimentPriority :selected").text(), Severity: $("#impedimentSeverity :selected").text() });
                    else
                        data = JSON.stringify({ Description: objtxtImpedimentDescription.value, ImpedimentID: '', AssignTo: $("#ResponsiblePerson :selected").val(), Type: objtxtType, SubType: objtxtSubType, Status: objtxtStatus, ReportedBy: objtxtReportedBy, Summary: objtxtSummary, Priority: '', Severity: '' });

                    var result = ajaxCall("frmImpedimentLog.aspx/SaveImpedimentIssue", "POST", "application/json", "json", data);
                    if (result != undefined) {
                        if (result.d.indexOf("Success") != -1) {
                            alertify.dismissAll();
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Issue Saved Successfully', 'success', 10);
                            //RemoveFrameLoader();
                        }
                        else {
                            alertify.dismissAll();
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(result.d, 'error', 10);
                            //RemoveFrameLoader();
                        }


                        if (flagMode == 1) {
                            ShowModal("divAddIssue", "", "");
                        }
                        else if (flagMode == 0) {
                            $("#divAddIssue .close").click();
                        }
                        RefreshGrid();
                    }
                }
                else if (checkvalue == 1) {
                    if (errorMsg != "") {
                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 10);
                    }
                }
            }
            catch (ex) {
                alert(ex.message);

            }
        }


        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function validatedatatype(e, fieldname) {

            var keyCode = e.which ? e.which : e.keyCode
            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Please enter only positive numeric value for ' + fieldname + ' .', 'error');
                }
            }

            return ret;
        }


        function Save_Risk_Details(flagMode, ImpedId, flag) {

            var checkvalue = 0;
            var errorMsg = "";
            var strmsg = "";
            objtxtImpedimentDescription = document.getElementById("txtImpedimentDescription");
            objtxtProbability = document.getElementById("Probability");
            objtxtImpact = document.getElementById("Impact");
            objoptRiskCategory = $("#RiskCategory :selected").val();
            var objImpedimentDescription = $("#txtImpedimentDescription").val();
            if (objtxtImpedimentDescription.value == "") {
                strmsg = '- Description can not be left blank.';
                errorMsg += "<li>" + strmsg + "</li><BR/>";
                //alertify.notify('', 'error');
                $("#txtImpedimentDescription").focus();
                checkvalue = 1;
            }
             //   Added By Riddhesh Patil on 11-NOV-2022 
            else if (checkSpecialCharacter(objImpedimentDescription, WebConfigSpecialCharacters) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = 'Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters';
                errorMsg += "<li>" + strmsg + "</li><BR/>";
                $("#txtImpedimentDescription").focus();
                checkvalue = 1;
            }

            //End of Added By Riddhesh Patil





            if (ImpedId == undefined) {
                objtxtImpactDescription = $("#txtImpactDescription").val();

                if (objtxtImpactDescription == "") {
                    strmsg = '- Impact Description can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;
                    var hasFocus = $('#txtImpedimentDescription').is(':focus');
                    if (hasFocus) {

                    }
                    else {
                        $("#txtImpactDescription").focus();
                    }

                }
                //   Added By Riddhesh Patil on 11-NOV-2022 
                else if (checkSpecialCharacter(objtxtImpactDescription, WebConfigSpecialCharacters) == true) {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = 'Impact Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    $("#txtImpactDescription").focus();
                    checkvalue = 1;
                }

            //End of Added By Riddhesh Patil

                if (objoptRiskCategory == "") {
                    strmsg = '- Risk Category can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;


                    if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtImpactDescription').is(':focus') == true) {

                    }
                    else {
                        $("#RiskCategory").focus();
                    }
                }
                objRiskStatus = $("#RiskStatus :selected").text();

                if (objRiskStatus == "") {
                    strmsg = '- Risk Status can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtImpactDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true) {

                    }
                    else {
                        $("#RiskStatus").focus();
                    }

                }
                if (objtxtImpact.value == "0") {
                    strmsg = '- Impact can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;
                    if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtImpactDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#RiskStatus').is(':focus') == true) {

                    }
                    else {
                        $("#Impact").focus();
                    }
                }
                //else if (objtxtImpact.value != "") {
                //    if ($("#Impact").val() <= 0 || $("#Impact").val() > 10) {
                //        strmsg = "- Enter Imapct value between 1-10.";
                //        errorMsg += "<li>" + strmsg + "</li><BR/>";
                //        checkvalue = 1;
                //        if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtImpactDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#RiskStatus').is(':focus') == true) {

                //        }
                //        else {
                //            $("#Impact").focus();
                //        }
                //    }
                //}
                if (objtxtProbability.value == "0") {
                    strmsg = '- Probability can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;
                    if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtImpactDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#RiskStatus').is(':focus') == true || $('#Impact').is(':focus') == true) {

                    }
                    else {
                        $("#Probability").focus();
                    }
                }
                else if (objtxtProbability.value != "") {
                    //if ($("#Probability").val() < 0 || $("#Probability").val() > 1) {
                    //    strmsg = "- Enter probability between 0-1.";
                    //    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    //    checkvalue = 1;
                    //    if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtImpactDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#RiskStatus').is(':focus') == true || $('#Impact').is(':focus') == true) {

                    //    }
                    //    else {
                    //        $("#Probability").focus();
                    //    }
                    //}
                }

                objDateIdentified = $("#IdentifiedDate").val();

                if (objDateIdentified == "") {
                    strmsg = '- Identified Date can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#txtImpedimentDescription').is(':focus') == true || $('#txtImpactDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#RiskStatus').is(':focus') == true || $('#Impact').is(':focus') == true || $('#Probability').is(':focus') == true) {

                    }
                    else {
                        $("#IdentifiedDate").focus();
                    }
                }
            }
            if (ImpedId != undefined) {
                if (objoptRiskCategory == "") {
                    strmsg = '- Risk Category can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    var hasFocus = $('#txtImpedimentDescription').is(':focus');
                    if (hasFocus) {

                    }
                    else {
                        $("#RiskCategory").focus();
                    }
                }

                if (objtxtImpact.value == "") {
                    strmsg = '- Impact can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true) {

                    }
                    else {
                        $("#Impact").focus();
                    }
                }
                else if (objtxtImpact.value != "") {
                    if ($("#Impact").val() <= 0 || $("#Impact").val() > 10) {
                        strmsg = "- Enter Imapct value between 1-10.";
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                        if ($('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true) {

                        }
                        else {
                            $("#Impact").focus();
                        }
                    }
                }
                if (objtxtProbability.value == "") {
                    strmsg = '- Probability can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#Impact').is(':focus') == true) {

                    }
                    else {
                        $("#Probability").focus();
                    }
                }
                else if (objtxtProbability.value != "") {
                    //if ($("#Probability").val() < 0 || $("#Probability").val() > 1) {
                    //    strmsg = "- Enter probability between 0-1.";
                    //    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    //    checkvalue = 1;

                    //    if ($('#txtImpedimentDescription').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#Impact').is(':focus') == true) {

                    //    }
                    //    else {
                    //        $("#Probability").focus();
                    //    }
                    //}
                }
            }
            if (checkvalue == 0) {
                $("#btnSaveRisk").attr('disabled', true);             //Added by Usha Pandit on 05 JUNE 2018 to prevent duplicate convert to risk/Issue 

                if (flag != undefined) {

                    if (flag == "True") {
                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('as the Associated impedement is not having preventive/corrective action hence description will be get added as the impact description', 'success', 10);
                    }
                }
                //Save Risk Details
                var data = "";
                if (ImpedId != undefined)
                    data = JSON.stringify({ Probability: objtxtProbability.value, Impact: objtxtImpact.value, Description: objtxtImpedimentDescription.value, RiskCategoryId: objoptRiskCategory, ImpedimentID: ImpedId, ImpactDescription: '', RiskStatus: '', DateIdentified: '' });
                else
                    data = JSON.stringify({ Probability: objtxtProbability.value, Impact: objtxtImpact.value, Description: objtxtImpedimentDescription.value, RiskCategoryId: objoptRiskCategory, ImpedimentID: '', ImpactDescription: objtxtImpactDescription, RiskStatus: objRiskStatus, DateIdentified: $("#IdentifiedDate").val() });

                var result = ajaxCall("frmImpedimentLog.aspx/SaveImpedimentRisk", "POST", "application/json", "json", data);
                if (result != undefined) {
                    if (result.d.indexOf("Success") != -1) {
                        //alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Risk Saved Successfully', 'success', 10);
                        //RemoveFrameLoader();
                    }
                    else {
                        alertify.dismissAll();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(result.d, 'error', 10);
                        //RemoveFrameLoader();
                    }
                    if (flagMode == 1) {
                        ShowModal("divAddRisk", "", "");
                    }
                    else if (flagMode == 0) {
                        $("#divAddRisk .close").click();
                    }

                    RefreshGrid();
                }
            }
            else if (checkvalue == 1) {
                if (errorMsg != "") {
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 10);
                }
            }

        }
        function checkDefaultIssueExist() {
        }
        function checkProjectEndDate(plannedclosedate) {
            //alert(plannedclosedate.value);

            var strProjectResult = ajaxCall("frmImpedimentLog.aspx/GetProjectEndDate", "POST", "application/json", "json", JSON.stringify({}));
            //alert(strProjectResult.d);
            var d1 = new Date(plannedclosedate.value);
            var d2 = new Date(strProjectResult.d);

            if (plannedclosedate.value == "") {

                alertify.dismissAll();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Invalid date', 'error', 10);
                $("#dtPlannedIssueDate").val("");
                $("#dtPlannedIssueDate").focus();
            }
            else {
                if (d1 < d2) {

                    //alert("lesser");
                }
                else if (d1 > d2) {
                    //alert("greater");
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- change the project end date or select planned closure date less than project end date', 'error', 10);
                    $("#dtPlannedIssueDate").val("");
                    $("#dtPlannedIssueDate").focus();
                }
            }
            //$("#dtPlannedIssueDate").focus();
            //alert(d1);
            //alert(d2);
        }
        function Save_Impediment_Details(flagMode) {

            var Flag = 0;
            var checkvalue = 0;
            var strmsg = "";
            var errorMsg = "";

            var objtxtImpedimentDescription;

            var objdtPlannedIssueDate;
            var objimpedimentStatus;
            var objtxtConvertedTo;
            var objimpedimentSeverity;
            var objimpedimentPriority;
            var objtxtCorrectiveAction;
            var objtxtPreventiveAction;
            var blnConvertedToIssue = false;
            var blnConvertedToRisk = false;

            objtxtImpedimentDescription = document.getElementById("txtActionItems");


            objdtPlannedIssueDate = document.getElementById("DSTargetDate");
            objimpedimentStatus = document.getElementById("DSStatus");
            objimpedimentSeverity = document.getElementById("impedimentSeverity");
            objimpedimentPriority = document.getElementById("impedimentPriority");
            objtxtCorrectiveAction = document.getElementById("txtCorrectiveAction");
            objtxtPreventiveAction = document.getElementById("txtPreventiveAction");
            objtxtConvertedTo = $("#impedimentConvertTo :selected").text();

            if ($("#cboSprint :selected").text() == "") {
                strmsg = '- Please select sprint.';
                errorMsg += "<li>" + strmsg + "</li><BR/>";
                //alertify.notify('', 'error');
                $("#cboSprint").focus();
                checkvalue = 1;
            }

            if (objtxtImpedimentDescription.value == "") {
                strmsg = '- Description can not be left blank.';
                errorMsg += "<li>" + strmsg + "</li><BR/>";
                //alertify.notify('', 'error');
                if ($('#cboSprint').is(':focus') == true) {
                }
                else {
                    $("#txtActionItems").focus();
                }
                checkvalue = 1;
            }

            if ($("#impedimentConvertTo :selected").text() == "Issue" && $('#impedimentConvertTo').is(':disabled') == false) {
                var blnDefaultIssue = false;
                var strUserResult = ajaxCall("frmImpedimentLog.aspx/DefaultIssueExist", "POST", "application/json", "json", JSON.stringify({}));
                if (strUserResult != undefined) {
                    if (strUserResult.d == "") {
                        blnDefaultIssue = true;
                    }
                    else {
                        blnDefaultIssue = false;
                        errorMsg += "<li> - " + strUserResult.d + "</li><BR/>";
                        checkvalue = 1;
                    }
                }
                if (blnDefaultIssue == true) {

                    if (objimpedimentPriority.value == "") {
                        if (objimpedimentSeverity.value != "") {
                            errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                        }
                        strmsg = '- Priority can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";

                        //var hasFocus = $('#txtActionItems').is(':focus');
                        if ($('#cboSprint').is(':focus') == true || $('#txtActionItems').is(':focus') == true) {

                        }
                        else {
                            $("#impedimentPriority").focus();
                        }
                        checkvalue = 1;
                    }

                    if (objimpedimentSeverity.value == "") {
                        errorMsg += "<li> - As Issue is selected, Priority and Severity are mandatory</li><BR/>";
                        strmsg = '- Severity can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";

                        if ($('#cboSprint').is(':focus') == true || $('#txtActionItems').is(':focus') == true || $('#impedimentPriority').is(':focus') == true) {

                        }
                        else {
                            $("#impedimentSeverity").focus();
                        }
                        checkvalue = 1;
                    }

                    objtxtResponsiblePerson = $("#ResponsiblePerson :selected").text();

                    if (objtxtResponsiblePerson == "") {
                        strmsg = '- Responsible Person can not be left blank.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";

                        if ($('#cboSprint').is(':focus') == true || $('#txtActionItems').is(':focus') == true || $('#impedimentPriority').is(':focus') == true || $('#impedimentSeverity').is(':focus') == true) {

                        }
                        else {
                            $("#ResponsiblePerson").focus();
                        }
                        checkvalue = 1;
                    }
                }
            }

            if (objtxtConvertedTo == "Risk" && $('#impedimentConvertTo').is(':disabled') == false) {
                objtxtProbability = document.getElementById("Probability");
                objtxtImpact = document.getElementById("Impact");
                objoptRiskCategory = $("#RiskCategory :selected").val();

                if (objoptRiskCategory == "") {
                    strmsg = '- Risk Category can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    //var hasFocus = $('#txtActionItems').is(':focus');
                    if ($('#cboSprint').is(':focus') == true || $('#txtActionItems').is(':focus') == true) {

                    }
                    else {
                        $("#RiskCategory").focus();
                    }
                }

                if (objtxtImpact.value == "") {
                    strmsg = '- Impact can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#cboSprint').is(':focus') == true || $('#txtActionItems').is(':focus') == true || $('#RiskCategory').is(':focus') == true) {

                    }
                    else {
                        $("#Impact").focus();
                    }
                }
                else if (objtxtImpact.value != "") {
                    if ($("#Impact").val() <= 0 || $("#Impact").val() > 10) {
                        strmsg = "- Enter Imapct value between 1-10.";
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                        if ($('#cboSprint').is(':focus') == true || $('#txtActionItems').is(':focus') == true || $('#RiskCategory').is(':focus') == true) {

                        }
                        else {
                            $("#Impact").focus();
                        }
                    }
                }
                if (objtxtProbability.value == "") {
                    strmsg = '- Probability can not be left blank.';
                    errorMsg += "<li>" + strmsg + "</li><BR/>";
                    checkvalue = 1;

                    if ($('#cboSprint').is(':focus') == true || $('#txtActionItems').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#Impact').is(':focus') == true) {

                    }
                    else {
                        $("#Probability").focus();
                    }
                }
                else if (objtxtProbability.value != "") {
                    if ($("#Probability").val() < 0 || $("#Probability").val() > 1) {
                        strmsg = "- Enter probability between 0-1.";
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                        if ($('#cboSprint').is(':focus') == true || $('#txtActionItems').is(':focus') == true || $('#RiskCategory').is(':focus') == true || $('#Impact').is(':focus') == true) {

                        }
                        else {
                            $("#Probability").focus();
                        }
                    }
                }
            }



            if (objtxtConvertedTo == "Issue" && $('#impedimentConvertTo').is(':disabled') == true && objimpedimentStatus.value == "Closed") {

                //Check If Issue Status is closed

                var dataIssueId = JSON.stringify({ ImpedimentID: GlobalImpedimentID });
                var resultIssueId = ajaxCall("frmImpedimentLog.aspx/checkIssueStatus", "POST", "application/json", "json", dataIssueId);
                if (resultIssueId != undefined) {

                    if (resultIssueId.d == "0") {
                        strmsg = '- Please close associated issue first.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                    }
                    else if (resultIssueId.d == "1")
                        checkvalue = 0;
                }
                else
                    checkvalue = 1;
            }
            // debugger;
            if (objtxtConvertedTo == "Risk" && $('#impedimentConvertTo').is(':disabled') == true && objimpedimentStatus.value == "Closed") {

                //Check If Risk Status is closed
                var dataRiskId = JSON.stringify({ ImpedimentID: GlobalImpedimentID });
                var resultRiskId = ajaxCall("frmImpedimentLog.aspx/checkRiskStatus", "POST", "application/json", "json", dataRiskId);
                if (resultRiskId != undefined) {

                    if (resultRiskId.d == "0") {
                        strmsg = '- Please close associated risk first.';
                        errorMsg += "<li>" + strmsg + "</li><BR/>";
                        checkvalue = 1;
                    }
                    else if (resultRiskId.d == "1")
                        checkvalue = 0;
                }
                else
                    checkvalue = 1;

            }
            if (checkvalue == 0) {

                $("#SaveDS").attr('disabled', true);             //Added by Usha Pandit on 07 JUNE 2018 to prevent duplicate convert to risk/Issue 
                if (objtxtCorrectiveAction.value == "" && objtxtPreventiveAction.value == "" && objtxtConvertedTo == "Risk" && $('#impedimentConvertTo').is(':disabled') == false) {
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('as the Associated impedement is not having preventive/corrective action hence description will be get added as the impact description', 'success', 10);
                }
                var data = JSON.stringify({ ImpedimentID: GlobalImpedimentID, ImpedimentDescription: objtxtImpedimentDescription.value, ImpedimentSeverity: objimpedimentSeverity.value, ImpedimentPriority: objimpedimentPriority.value, CorrectiveAction: objtxtCorrectiveAction.value, PreventiveAction: objtxtPreventiveAction.value, PlannedIssueDate: objdtPlannedIssueDate.value, impedimentStatus: objimpedimentStatus.value, ConvertedTo: objtxtConvertedTo, IterationID: $("#cboSprint :selected").val() });
                var result = ajaxCall("frmImpedimentLog.aspx/SaveImpediment", "POST", "application/json", "json", data);
                if (result.d != "") {

                    var ImpedimentID = GlobalImpedimentID;
                    if (objtxtConvertedTo == "Risk" && $('#impedimentConvertTo').is(':disabled') == false) {

                        objtxtProbability = document.getElementById("Probability");
                        objtxtImpact = document.getElementById("Impact");
                        objoptRiskCategory = $("#RiskCategory :selected").val();

                        //Save Risk Details
                        var data = JSON.stringify({ Probability: objtxtProbability.value, Impact: objtxtImpact.value, Description: objtxtImpedimentDescription.value, RiskCategoryId: objoptRiskCategory, ImpedimentID: ImpedimentID, ImpactDescription: '', RiskStatus: '', DateIdentified: '' });
                        var result = ajaxCall("frmImpedimentLog.aspx/SaveImpedimentRisk", "POST", "application/json", "json", data);
                        //RemoveFrameLoader();
                        if (result != undefined) {
                        }
                    }

                    if (objtxtConvertedTo == "Issue" && $('#impedimentConvertTo').is(':disabled') == false) {

                        //Save Issue Details
                        var data = JSON.stringify({ Description: objtxtImpedimentDescription.value, ImpedimentID: ImpedimentID, AssignTo: $("#ResponsiblePerson :selected").val(), Type: '', SubType: '', Status: '', ReportedBy: '', Summary: '', Priority: $("#impedimentPriority :selected").text(), Severity: $("#impedimentSeverity :selected").text() });
                        var result = ajaxCall("frmImpedimentLog.aspx/SaveImpedimentIssue", "POST", "application/json", "json", data);
                        //RemoveFrameLoader();
                        if (result != undefined) {

                        }
                    }

                    //alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Impediment Saved Successfully', 'success', 10);


                }

                if (flagMode == 1) {

                    ShowFilter(strGlobalFilterValue, strGlobaFilterField);
                    $("#divAddDS .close").click();
                    ShowModal("divAddImpediment", "", "");
                }
                else if (flagMode == 0) {
                    $("#divAddDS .close").click()
                    ShowFilter(strGlobalFilterValue, strGlobaFilterField);
                }
                RefreshGrid();
            }
            else if (checkvalue == 1) {
                if (errorMsg != "") {
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 10);
                }
            }
        }

        //function AutoResizeTextArea() {
        //    jQuery.each(jQuery('textarea[data-autoresize]'), function () {
        //        var offset = this.offsetHeight - this.clientHeight;

        //        var resizeTextarea = function (el) {
        //            jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
        //        };
        //        jQuery(this).on('keyup input', function () {
        //            //if ($(this).attr("id") == "txtActionItems") {
        //            //    Maxlength(this, "ActionItems", 1000);
        //            //}
        //            //if ($(this).attr("id") == "txtRemark") {
        //            //    Maxlength(this, "DSRemark", 1000);
        //            //}

        //            //if ($(this).attr("id") == "txtImpedimentDescription") {
        //            //    Maxlength(this, "ImpedimentDescription", 500);
        //            //}


        //            //if ($(this).attr("id") == "txtCorrectiveAction") {
        //            //    Maxlength(this, "CorrectiveAction", 1000);
        //            //}
        //            //if ($(this).attr("id") == "txtPreventiveAction") {
        //            //    Maxlength(this, "PreventiveAction", 1000);
        //            //}
        //            resizeTextarea(this);
        //        }).removeAttr('data-autoresize');


        //    });
        //}
        /*Added by kashish For Texarea Enhancement*/
        function AutoResizeTextArea() {
            //alert();
            jQuery.each(jQuery('textarea[data-autoresize]'), function () {
                //var offset = this.offsetHeight - this.clientHeight;

                var resizeTextarea = function (el) {
                    //jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
                };
                jQuery(this).on('keyup input', function () {
                    if ($(this).attr("id") == "txtSummary") {
                        Maxlength(this, "Summary", 500);
                    }
                    if ($(this).attr("id") == "txtImpedimentDescription") {
                        Maxlength(this, "ImpedimentDescription", 500);
                    }
                    if ($(this).attr("id") == "txtImpactDescription") {
                        Maxlength(this, "ImpactDescription", 500);
                    }
                    if ($(this).attr("id") == "txtActionItems") {
                        Maxlength(this, "ActionItems", 500);
                    }
                    if ($(this).attr("id") == "txtCorrectiveAction") {
                        Maxlength(this, "CorrectiveAction", 1000);
                    }
                    if ($(this).attr("id") == "txtPreventiveAction") {
                        Maxlength(this, "PreventiveAction", 1000);
                    }


                    resizeTextarea(this);
                }).removeAttr('data-autoresize');


            });
        }
        function AutoGrowTextArea(textField) {
            if (textField.clientHeight < textField.scrollHeight) {
                textField.style.height = textField.scrollHeight + "px";
                if (textField.clientHeight < textField.scrollHeight) {
                    textField.style.height =
                        (textField.scrollHeight * 2 - textField.clientHeight) + "px";
                }
            }
        }
        function RemoveTextArea() {
            $('textarea').keydown(function (e) {
                var $this = $(this),
                    rows = parseInt($this.attr('rows')),
                    lines;
                //alert(rows);
                //// on enter
                //if (e.which === 13) {
                //    $this.attr('rows', rows + 1);
                //}

                // on backspace -- THIS IS THE PROBLEM
                if (e.which === 8 && rows !== 2) {
                    lines = $(this).val().split('\n')
                    console.log(lines);
                    if (!lines[lines.length - 1]) {
                        $this.attr('rows', rows - 1);

                    }

                }
            });
        }


        function getRows() {
            //debugger;
            if ($("#txtActionItems").val() != undefined) {
                var numberOfColumns = 70;
                var numberOfLines = 1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine = $("#txtActionItems").val().split('\n');
                var lineheight = $("#txtActionItems").val();
                numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
                characterCount = lineheight.length + numberOfLineBreaks;

                if (characterCount > numberOfColumns) {
                    numberOfLines = parseInt(characterCount / numberOfColumns);
                    var height = document.getElementById("txtActionItems").rows = numberOfLines + 1;
                    $("#txtActionItems").attr("style", "height: auto !important");
                }

            }
            if ($("#txtImpedimentDescription").val() != undefined) {
                var numberOfColumns4 = 70;
                var numberOfLines4 = 1;
                //numberOfColumns4 = document.getElementById("txtImpedimentDescription").cols;
                var eachLine4 = $("#txtImpedimentDescription").val().split('\n');
                var lineheight4 = $("#txtImpedimentDescription").val();
                numberOfLineBreaks4 = (lineheight4.match(/\n/g) || []).length;
                characterCount4 = lineheight4.length + numberOfLineBreaks4;

                if (characterCount4 > numberOfColumns4) {
                    numberOfLines4 = parseInt(characterCount4 / numberOfColumns4);
                    var height4 = document.getElementById("txtImpedimentDescription").rows = numberOfLines4 + 1;
                    $("#txtImpedimentDescription").attr("style", "height: auto !important");
                }

            }
            if ($("#txtCorrectiveAction").val() != undefined) {
                var numberOfColumns2 = 70;
                var numberOfLines2 = 1;
                var characterCount2;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine2 = $("#txtCorrectiveAction").val().split('\n');
                var lineheight2 = $("#txtCorrectiveAction").val();
                numberOfLineBreaks2 = (lineheight2.match(/\n/g) || []).length;
                characterCount2 = lineheight2.length + numberOfLineBreaks2;

                if (characterCount2 > numberOfColumns2) {
                    numberOfLines2 = parseInt(characterCount2 / numberOfColumns2);
                    var height2 = document.getElementById("txtCorrectiveAction").rows = numberOfLines2 + 1;
                    $("#txtCorrectiveAction").attr("style", "height: auto !important");
                }

            }
            if ($("#txtPreventiveAction").val() != undefined) {
                var numberOfColumns3 = 70;
                var numberOfLines3 = 1;
                var characterCount3;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine3 = $("#txtPreventiveAction").val().split('\n');
                var lineheight3 = $("#txtPreventiveAction").val();
                numberOfLineBreaks3 = (lineheight3.match(/\n/g) || []).length;
                characterCount3 = lineheight3.length + numberOfLineBreaks3;

                if (characterCount3 > numberOfColumns2) {
                    numberOfLines3 = parseInt(characterCount3 / numberOfColumns3);
                    var height3 = document.getElementById("txtPreventiveAction").rows = numberOfLines3 + 1;
                    $("#txtPreventiveAction").attr("style", "height: auto !important");
                }

            }


        }
        //function getRows() {
        //    //alert(document.getElementById('txtFeatureName').value.split("\n").length);

        //    if ($("#txtActionItems").val() != undefined) {
        //        var str = document.getElementById("txtActionItems").value;
        //        str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
        //        document.getElementById("txtActionItems").value = str;
        //        var lineheight = document.getElementById("txtActionItems").value.split("\n").length + 1;
        //        var height = document.getElementById("txtActionItems").rows = lineheight;
        //        $("#txtActionItems").attr("style", "height: auto !important");
        //    }
        //    if ($("#txtImpedimentDescription").val() != undefined) {
        //        var str = document.getElementById("txtImpedimentDescription").value;
        //        str = str.replace(/(?!$|\n)([^\n]{80}(?!\n))/g, '$1\n');
        //        document.getElementById("txtImpedimentDescription").value = str;
        //        var lineheight1 = document.getElementById("txtImpedimentDescription").value.split("\n").length + 1;

        //        var height1 = document.getElementById("txtImpedimentDescription").rows = lineheight1;
        //        $("#txtImpedimentDescription").attr("style", "height: auto !important");
        //    }
        //    if ($("#txtImpactDescription").val() != undefined) {
        //        var str = document.getElementById("txtImpactDescription").value;
        //        str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
        //        document.getElementById("txtImpactDescription").value = str;
        //        var lineheight2 = document.getElementById("txtImpactDescription").value.split("\n").length + 1;
        //        var height2 = document.getElementById("txtImpactDescription").rows = lineheight2;
        //        $("#txtImpactDescription").attr("style", "height: auto !important");
        //    }

        //    if ($("#txtCorrectiveAction").val() != undefined) {
        //        var str = document.getElementById("txtCorrectiveAction").value;
        //        str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
        //        document.getElementById("txtCorrectiveAction").value = str;
        //        var lineheight3 = document.getElementById("txtCorrectiveAction").value.split("\n").length + 2;
        //        var height3 = document.getElementById("txtCorrectiveAction").rows = lineheight3;
        //        $("#txtCorrectiveAction").attr("style", "height: auto !important");
        //    }
        //    //txtDescription

        //    if ($("#txtPreventiveAction").val() != undefined) {
        //        var str = document.getElementById("txtPreventiveAction").value;
        //        str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
        //        document.getElementById("txtPreventiveAction").value = str;
        //        var lineheight4 = document.getElementById("txtPreventiveAction").value.split("\n").length + 2;
        //        var height4 = document.getElementById("txtPreventiveAction").rows = lineheight4;
        //        $("#txtPreventiveAction").attr("style", "height: auto !important");
        //    }

        //    if ($("#txtSummary").val() != undefined) {
        //        var str = document.getElementById("txtSummary").value;
        //        str = str.replace(/(?!$|\n)([^\n]{80}(?!\n))/g, '$1\n');
        //        document.getElementById("txtSummary").value = str;
        //        var lineheight5 = document.getElementById("txtSummary").value.split("\n").length + 1;
        //        var height5 = document.getElementById("txtSummary").rows = lineheight5;
        //        $("#txtSummary").attr("style", "height: auto !important");
        //    }

        //}

        //Added By Riddhesh Patil on 22/12/2022
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //End of Added By Riddhesh Patil on 22/12/2022


        //Added By Riddhesh Patil on 22/12/2022
        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
            if (WebConfigSpecialCharacters != '') {
                var regularExpression = WebConfigSpecialCharacters;
                regularExpression += '"';
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
            else {
                return false;
            }
        }
		//End of Added By Riddhesh Patil on 22/12/2022
    </script>

</body>
</html>


