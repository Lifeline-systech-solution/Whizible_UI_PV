<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BusinessGroup.aspx.vb" Inherits="PbNIT.BusinessGroup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <%CommonFunctions.General.PlotPageHeadTag("Business Group")%>
    
    <head runat="server">
        <title>Bussiness Group</title>
        <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>--%>
        
        <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" /> -->
    <!-- Custom fonts for this template -->
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" />--%>
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->


    <link href="../../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" /> -->
    <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />

    <!-- <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" /> -->
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
    #DivList .dataTables_filter {
    display: none;
    }

    #DivList .dataTables_length {
    display: none;
    }

    #DivList .dataTables_filter {
    display: none;
    }

    .container-fluid {
    min-height: 0px !important;
    }

    #DivList table tr th:nth-child(3) {
    text-align: center !important;
    }

    #DivList table tr td:nth-child(3) {
    text-align: center !important;
    word-break: break-all !important;
    }

    #DivList table tr th:nth-child(4) {
    text-align: center !important;
    }

    #DivList table tr th:nth-child(5) {
    text-align: center !important;
    }

    .edit-bt {
    background: transparent;
    border: none;
    font-size: 14px !important;
    position: relative;
    top: -3px;
    color: #1e88e5;
    }

    .edit-bt1 {
    background: transparent;
    border: none;
    font-size: 14px !important;
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

    #DivList {
    overflow-x: hidden !important;
    }

    #DivList .dataTables_scrollBody {
    /*overflow: auto!important;*/
    width: 102% !important;
    /*height: 141px;*/
    /*padding-right: 2%!important;*/
    }

    #idPanelBody {
    /*overflow-x: hidden;*/
    height: 140px;
    width: 104%;
    padding-right: 2%;
    }

    #divSubRequestType .dataTables_scroll {
    OVERFLOW: HIDDEN;
    }

    #divSubRequestType .dataTables_scrollBody {
    position: relative;
    overflow: auto;
    width: 102% !important;
    /*height: 180px;*/
    padding-right: 0.5%;
    }

    #panelHRM {
    margin-top: 3%;
    }
    /*.form-horizontal .control-label {
    line-height:2!important;
    }*/

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

    /*#DivList table tr td:nth-child(1) {
    width:25%!important
    }
    #DivList table tr td:nth-child(2) {
    width:25%!important
    }
    #DivList table tr td:nth-child(3) {
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


    .form-control {
    font-weight: 100;
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





    #collapseOne5 {
    overflow: hidden;
    }

    #collapseOne5 .panel-body {
    overflow: auto;
    /*height: 150px;*/
    width: 103%;
    padding-right: 2%;
    }

    /*#DivList .pagination {
    float: right!important;
    margin-right: -70%;
    margin-top: 2%;
    }*/

    .control-label {
    font-weight: normal !important;
    padding-top: 1% !important;
    }

    .dataTables_paginate {
    /*float: right !important;*/ /*Commented by Usha Pandit on 24 JAN 2018 for pagination*/
    margin-top: 2%;
    margin-right: -2%;
    }

    .pagination {
    margin: 5px 0 !important;
    }

    .dataTables_info {
    margin-top: 14px;
    }

    .tablinks4 {
    height: 30px;
    background-color: white;
    }

    .clsSubtags {
    width: 160px !important;
    }

    #btnConfigureHRM {
    font-size: 12px;
    }



    /*/////////////////////*/

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



    .dataTables_paginate {
    float: right !important;
    /*margin-top: -3%;
    margin-right: -2%;*/
    }

    .pagination {
    margin: 5px 0 !important;
    }


    #lblActive {
    margin-top: -1%;
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

    #idPanelBody {
    /*overflow-x: hidden;*/
    height: 150px;
    width: 104%;
    padding-right: 2%;
    }

    #divSubRequestType .dataTables_scrollBody {
    position: relative;
    overflow: auto;
    width: 102% !important;
    /*height: 180px;*/
    padding-right: 0.5%;
    }

    #divGridSubRequestType .dataTables_scrollBody {
    position: relative;
    overflow: auto;
    width: 102% !important;
    /*height: 180px;*/
    padding-right: 0.5%;
    }



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

    .form-control {
    font-weight: 100;
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





    #collapseOne5 {
    overflow: hidden;
    }

    #collapseOne5 .panel-body {
    overflow: auto;
    /*height: 150px;*/
    width: 103%;
    padding-right: 2%;
    }



    #CboAutocloser {
    margin-left: -37% !important;
    }

    #tblCloser {
    margin-left: -1.4% !important;
    }



    #DivAuto {
    padding-top: 0% !important;
    padding-left: 1% !important;
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

    .content-wrapper {
    overflow: hidden !important;
    }

    .tabcontent1 {
    border: none !important;
    }




    .container-fluid {
    min-height: auto !important;
    }

    #DivList {
    overflow-x: hidden !important;
    }

    #divOU {
    width: 101%;
    margin-left: 1%;
    overflow-x: hidden !important;
    overflow-y: auto !important;
    }
    /*#spnOU {
    margin: -6px!important;
    }*/
    .panel-heading h3 {
    width: auto !important;
    float: left;
    color: rgb(255, 255, 255);
    font-size: 13px;
    font-weight: 100;
    margin: -2px;
    }

    #collapseOne11 {
    width: 98%;
    /*margin-left:-7%;*/
    }


    #collapseOne22 {
    width: 98%;
    margin-left: -7%;
    }



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

    #divOU .dataTables_scrollHeadInner {
    width: 100% !important;
    /*width:100%!important;*/
    }

    #divOU .pagination {
    /*margin: -6px 11px !important;*/ /*Commented by Usha Pandit on 24 JAN 2018*/
    }

    #divOU tr th:nth-child(1) {
    width: 300px !important;
    }

    #divOU tr th:nth-child(3) {
    text-align: center;
    }

    #divOU tr th:nth-child(4) {
    text-align: center;
    }

    #divOU tr td:nth-child(1) {
    word-break: break-all;
    }

    #divOU tr td:nth-child(2) {
    word-break: break-all;
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



    .clscombo {
    width: 200px !important;
    height: 28px !important;
    font-size: 12px !important;
    }


    #ConfigureHRM .type-top-bar .fa.fa-plus {
    display: block !important;
    margin-left: 95% !important;
    margin-top: -16% !important;
    }

    #ConfigureHRM .type-top-bar .fa.fa-plus {
    display: block !important;
    margin-left: 95% !important;
    margin-top: -16% !important;
    }

    #ConfigureHRM .type-top-bar #IconAddNew {
    display: block !important;
    margin-left: 95% !important;
    margin-top: -24% !important;
    }

    #ProjectMapping .top-bar #IconAddNew {
    display: block !important;
    margin-left: 95% !important;
    margin-top: -45% !important;
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

    #ExiOu {
    margin-right: -34% !important;
    float: right !important;
    }
    /*.panel-heading #idheader {

    margin:-5px!important;
    }*/
    #NewOU {
    margin-right: -5% !important;
    float: right !important;
    }

    .save {
    border-color: white !important;
    }

    .bottom-bar {
    float: none !important;
    }





    #DivList .dataTables_scrollBody .clsTRColumnHeader {
    height: 0PX !important;
    }

    #ShowHistoryGrid .dataTables_scrollBody {
    margin-top: -4%;
    }

    #edit {
    margin-left: -4%;
    }

    /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
    .form-control:-ms-input-placeholder { /* IE 10+ */
    color: #bbb !important;
    }

    .h-type div#headingOne {
    /*margin-top:3%!important;*/ /*Commented by Usha Pandit on 25 JAN 2018*/
    }

    #ShowHistoryGrid .dataTables_scrollBody {
    margin-top: -4%;
    background-color: white !important;
    overflow: auto;
    width: 100%;
    }

    #ShowHistoryGrid table tr th {
    width: 130px !important;
    text-align: center !important;
    }

    #ShowHistoryGrid table tr td {
    width: 130px !important;
    text-align: center !important;
    }

    #ShowHistoryGrid table tr td:nth-child(4) {
    word-break: break-all !important;
    }

    /*#ShowHistoryGrid .clsTRColumnHeader {
    background-color:#641a02 !important;
    color:white!important;
    }*/

    #ShowHistoryGrid .dataTable no-footer {
    width: 651px !important;
    }

    #ShowHistoryGrid {
    overflow: auto !Important;
    padding-right: -1% !important;
    width: 105% !important;
    height: 221px !important;
    padding-right: 2% !important;
    }

    #modalbody {
    overflow: hidden !important;
    }

    #id14 .modal-content {
    width: 740px;
    height: 340px;
    }

    #cboModifiedField {
    height: 29px;
    }

    #cboModifiedBy {
    height: 29px;
    }

    #divOU table tr th:nth-child(3) {
    text-align: center !important;
    width: 15% !important;
    }

    #divOU table tr th:nth-child(4) {
    text-align: center;
    width: 15% !important;
    }

    #divOU table tr th:nth-child(1) {
    width: 35% !important;
    }

    #divOU table tr th:nth-child(2) {
    width: 35% !important;
    }

    #divOU table tr td:nth-child(3) {
    text-align: center !important;
    width: 15% !important;
    }

    #divOU table tr td:nth-child(4) {
    text-align: center !important;
    width: 15% !important;
    }

    #divOU table tr td:nth-child(1) {
    width: 35% !important;
    }

    #divOU table tr td:nth-child(2) {
    width: 35% !important;
    }

    /*Added by Usha Pandit on 24 JAN 2018 for alignment issue*/
    .Edit-All-btn {
    padding-right: 0px !important;
    padding-left: 20px !important;
    }

    .Delete-All-btn {
    padding-right: 0px !important;
    padding-left: 20px !important;
    }

    /*End of Added by Usha Pandit on 24 JAN 2018 for alignment issue*/
    /*'/*Added by Kashish for ui change*/
    .search-bar {
    margin-left: 1px !important;
    }
    /*'/*Added by Kashish on 10 july 2018 for ui change*/
    .top-bar {
    padding-bottom: 15px !important;
    }
</style>

<body id="page-top">
    <form id="frmBussinessGroup" runat="server">

        <input type="hidden" id="hdnBGID" name="hdnBGID" value="" />
        <input type="hidden" id="hdnOUID" name="hdnOUID" value="" />
        <input type="hidden" id="hdnMiddleLevel" name="hdnMiddleLevel" value="" />
        <div>
            <%WritePage("", "Load", "")%>
        </div>


    </form>



    <div id="id13" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Show History</span>
                <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close ">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group" style="margin-top: 5px;">
                    <label class="control-label col-sm-2 clslabel" style="margin-top: 5px;" for="request type">Modified Field</label>
                    <div class="col-sm-4">
                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 1265", 150, "", "onchange = ModifiedFieldFilter_Change(""Main"")", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                    </div>

                    <label class="control-label col-sm-2 clslabel" style="margin-top: 5px;" for="request type code">Modified By</label>
                    <div class="col-sm-4">
                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 1265" , 150, "", "onchange=ModifiedFieldFilter_Change(""Main"")", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                    </div>

                </div>
                <div class="container-fluid" id="modalbody" style="overflow-y: auto!important; overflow-x: hidden!important; height: 245px;">
                </div>
            </div>
        </form>
    </div>


    <div id="id14" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Show History</span>
                <span onclick="document.getElementById('id14').style.display='none'" class="close" title="Close ">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group" style="margin-top: 5px;">
                    <label class="control-label col-sm-2 clslabel" style="margin-top: 5px;" for="request type">Modified Field</label>
                    <div class="col-sm-4">
                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField1", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 395 ", 150, "", "onchange = ModifiedFieldFilter_Change(""SubTab"")", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                    </div>

                    <label class="control-label col-sm-2 clslabel" style="margin-top: 5px;" for="request type code">Modified By</label>
                    <div class="col-sm-4">
                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy1", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 395 ", 150, "", "onchange=ModifiedFieldFilter_Change(""SubTab"")", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                    </div>

                </div>
                <div class="container-fluid" id="modalbody1" style="overflow-y: auto!important; overflow-x: hidden!important; height: 245px;">
                </div>
            </div>
        </form>
    </div>
</body>
<!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script> -->

<%--<script src="vendor/popper/popper.min.js"></script>--%>
<script src="../../../EnhancementFiles/vendor/popper/popper.min.js"></script>

<%--<script src="js/editor.js"></script>--%>
<script src="../../../EnhancementFiles/js/editor.js"></script>

<!-- <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script> -->

<!-- Time picker -->
<%--<script src="js/timepicker.min.js"></script>
        <script src="js/timepicker.js"></script>--%>
<%--<script src="../../../EnhancementFiles/js/timepicker.js"></script>
<script src="../../../EnhancementFiles/js/timepicker.min.js"></script>--%>


<!-- <script src="../../General/CommonFunctions.js"></script>
<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>  -->

<!-- Time picker -->
<!-- <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script> -->
<script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--<script src="js/timepicker.min.js"></script>
<script src="js/timepicker.js"></script>--%>
</html>

<script>
    var strPageName = "BusinessGroup.aspx";

    var GlobalBGID = 0;
    var GlobalOUID = 0;
    var GlobalUniquid = 0;
    var UniqueID = 0;
    var ExitOU = 0;
    var BGID, OUID
    var arrSelectedCheck = new Array();
    var arrSelectedbgCheck = new Array();
    $(window).load(function () {

        RefreshGridDetails();
        RemoveFrameLoader();
    });


    function openCity4(evt, cityName) {
        //debugger;
        var i, tabcontent4, tablinks4;


        if (cityName == "OrgUnit") {
            // PlotSubtab1("PlotSubtab");

            //ShowHideHorizontalDiv();
            //RefreshSubTags();
            RefreshGridDetails();
        }
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

    function datatables(divID, txtBoxID, height) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({
            responsive: true,
            "pageLength": 3,
            // scrollY: '130px',
            pagingType: "simple_numbers",

            scrollX: true
        });

        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })

            //Added by Usha on 24 JAN 2018 for showing only records containing keywords in searchbox
            if ($('#' + txtBoxID).val() != "") {
                table.search($('#' + txtBoxID).val()).draw();
                //table.refresh();
            }
            //End of addition by Usha on 24 JAN 2018 for showing only records containing keywords in searchbox
        }

        //Added by Usha Pandit on 23 JAN 2018 for changing dataTables_info if no records exists
        var table = $('#' + divID + ' table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();



        if (rows.length <= 1 && divID == 'DivList') {
            $('#' + divID + ' .dataTables_info').html("Showing 0 to 0 of 0 entries ");
            $('.active.page-item .page-link').css("display", "none");
        }

        if (rows.length <= 1 && divID == 'divOU') {
            $('#' + divID + ' .dataTables_info').html("Showing 0 to 0 of 0 entries ");
            $('.active.page-item .page-link').css("display", "none");
        }

        //Added by Usha Pandit on 23 JAN 2018 for changing dataTables_info if no records exists
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


    function Edit_BusinessGroup(obj, BGID) {

        GlobalBGID = BGID;
        document.getElementById('hdnBGID').value = BGID;
        $.ajax({
            type: "POST",
            url: "BusinessGroup.aspx/GetBGDetails",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ BGID: BGID }),
            success: function (data) {
                var arrResult = data.d.split('##');


                $('#BussinessName').val(arrResult[0]);
                $('#BussinessGroupCode').val(arrResult[2]);

                //if (arrResult[4] == "True") {
                //    $("#CheckActive").prop('checked', true);
                //}
                //else {
                //    $("#CheckActive").prop('checked', false);
                //}

                document.getElementById('BussinessGroupCode').disabled = true;

                $("#div #headingOne").css("margin-top", "3%");
                $("#divRequestTypes").css("display", "none");
                $("#divTypeTab").css("display", "none");
                $("#divSubRequestType").css("display", "block");
                $("#HistoryBG").css("display", "inline");
                $("#HistoryBG").css("display", "block!important");



                var strResult1, data1;

                data1 = JSON.stringify({ BGID: GlobalBGID, Flag: "PlotSubtab" });
                //alert(data1);
                strResult1 = AJAXCallWithResult("BusinessGroup.aspx/PlotSubtab", data1, false);
                //alert(strResult1);
                if (strResult1.d != '') {

                    $("#divSubRequestType").html("");
                    $("#divSubRequestType").html(strResult1.d);
                    $("#divSubRequestType").addClass("table");

                    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                        intDivGridListHeight = parseInt(window.innerHeight) - 250;

                    }
                    else {

                        intDivGridListHeight = parseInt(window.innerHeight) - 600;
                    }


                    datatables("divOU", "", "")

                    /*Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
                    if ($("#Addaccordion").hasClass("collapsed")) {
                        $("#Addaccordion").removeClass("collapsed");
                        $("#collapseOne").css('height', 'auto !important');
                        $("#collapseOne").addClass('in');
                    }
                    $("#History").css("display", "block!important");
                    $("#History1").css("display", "block!important");


                    //Added by Usha Pandit on 23 JAN 2018 for checking browser type                  

                    if (WhichBrowser() == 'IE') {

                        $("#AddNew > label").removeClass("col-sm-3");
                        $("#AddNew > label").addClass("col-sm-2");
                        $(".pagination").css("cssText", "padding-right: 17px; !important;");
                    }
                    if (WhichBrowser() == 'CR') {
                        $(".pagination").css("cssText", "padding-right: 17px; !important;");
                        $("#editAllHeader").removeClass("Edit-All-btn");
                        $("#deleteAllHeader").removeClass("Delete-All-btn");
                    }
                    //End of Added by Usha Pandit on 23 JAN 2018 for checking browser type
                }
                /*End of Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/

            }
        });

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }

    //Added by Usha Pandit on 23 JAN 2018 for checking browser type
    function changePaginationAlign() {

        if (WhichBrowser() == 'IE') {

            $(".pagination").css("padding-right", "17px");
        }
        if (WhichBrowser() == 'CR') {
            $(".pagination").css("padding-right", "17px");
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
    //End of Added by Usha Pandit on 23 JAN 2018 for checking browser type

    function DeleteBU() {
        var table = $('#DivList table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllBU1').checked == true) {
            //$("input[name=chkActivityDelete]:not(:disabled)").prop('checked', true);
            $('input[id="chkAllBU"]:not(:disabled)', rows).prop('checked', true);
        }
        else {
            //$("input[name=chkActivityDelete]").prop('checked', false);
            $('input[id="chkAllBU"]', rows).prop('checked', false);
        }




    }

    function DeleteOU() {
        var table = $('#divOU table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        ////if (document.getElementById('chkAllOU1').checked == true) {
        ////    SLATemplateID = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
        ////        return this.value;
        ////    }).get().join(',');
        ////}
        ////else {
        ////    SLATemplateID = arrSelectedCheck.join();
        ////}
        if (document.getElementById('chkAllOU1').checked == true) {
            //$("input[name=chkActivityDelete]:not(:disabled)").prop('checked', true);
            $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
        }
        else {
            //$("input[name=chkActivityDelete]").prop('checked', false);
            $('input[type="checkbox"]', rows).prop('checked', false);
        }

        //Added by Usha Pandit on 24 JAN 2018 for Alignment Issue
        if (WhichBrowser() == 'IE') {

            $(".pagination").css("cssText", "padding-right: 17px; !important;");
        }
        if (WhichBrowser() == 'CR') {
            $(".pagination").css("cssText", "padding-right: 17px; !important;");
        }
        //End of Added by Usha Pandit on 24 JAN 2018 for Alignment Issue
    }



    function AddBG() {
        $('#BussinessName').val("");
        $('#BussinessGroupCode').val("");
        document.getElementById('BussinessGroupCode').disabled = false;
        //if ($("#CheckActive").checked == true) {
        //    $("#CheckActive").prop('checked', true);
        //}
        //else {
        //    $("#CheckActive").prop('checked', false);
        //}

        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne").css('height', 'auto !important');
            $("#collapseOne").addClass('in');
        }
    }

    function Cancel() {

        GlobalBGID = "";
        $('#BussinessName').val("");
        $('#BussinessGroupCode').val("");
        document.getElementById('BussinessGroupCode').disabled = false;

        if ($("#CheckActive").checked == true) {
            $("#CheckActive").prop('checked', true);
        }
        else {
            $("#CheckActive").prop('checked', false);
        }

        $("#divTypeTab").css("display", "block");
        $("#divRequestTypes").css("display", "block");
        $("#divSubRequestType").html("");
        $("#HistoryBG").css("display", "none");
        RefreshGrid('Type');

    }


    function CancelOU() {

        $('#UnitCode').val("");
        $('#UnitName').val("");
        $('#CboOU').val("");

        $("#tblConfigureHRM").css("display", "block");
        document.getElementById('UnitCode').disabled = false;
        //RefreshGrid('OU');           //Commented by Usha Pandit on 24 JAN 2018 for Alignment Issue

    }
    function AddBG() {

        document.getElementById('BussinessGroupCode').disabled = false;
        $('#BussinessName').val("");
        $('#BussinessGroupCode').val("");
        $('#CheckActive').val("");
        $("#divRequestTypes").css("display", "none");
        $("#divSubRequestType").css("display", "none");
        // $("#divTypeTab").html("");
        $("#History").css("display", "none");

        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne").css('height', 'auto !important');
            $("#collapseOne").addClass('in');
        }

    }

    function RefreshGrid(cityName) {
        // debugger;
        var strResult, data;
        var GridParameter = {};
        GlobalContactCustomerId = 0;
        GridParameter.cityName = cityName;

        data = JSON.stringify({ GridParameter: GridParameter, GlobalBGID: GlobalBGID, Role: "", Status: "" });
        // alert(data);
        strResult = AJAXCallWithResult("BusinessGroup.aspx/RefreshGrid", data, false);
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
            else if (cityName == "OU") {
                DivId = "divOU";
                // var tablename = "divCustomerContact";
                $("#ConfigureHRM" + " .table-responsive:first").html(strResult.d);
                DivSerach = "";
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

    function AddNewOU() {
        ExitOU = 0;
        GlobalUniquid = 0;

        $("#AddExiting").css("display", "none");

        $("#NewOU").css("display", "block");
        $("#AddNew").css("display", "block");
        $("#ExiOu").css("display", "none");
        $("#History1").css("display", "none");
        $("#History").css("display", "none");

        $('#UnitCode').val("");
        $('#UnitName').val("");
        $('#CboOU').val("");

        $("#tblConfigureHRM").css("display", "none");
        //$("#divSubRequestType").css("display", "none");
        document.getElementById('UnitCode').disabled = false;
        if ($("#addContact").hasClass("collapsed")) {
            $("#addContact").removeClass("collapsed");
            $("#collapseOne11").css('height', 'auto !important');
            $("#collapseOne11").addClass('in');
        }

    }
    function AddExitingOU() {
        ExitOU = 0;
        GlobalUniquid = 0;
        UniqueID = 0;
        $("#AddExiting").css("display", "block");
        $("#NewOU").css("display", "none");
        $("#AddNew").css("display", "none");
        $("#ExiOu").css("display", "block");
        
        // $("#History").css("display", "block");
        // $("#History").css("display", "inline");
        $("#History").css("display", "none");
        // $("#History1").css("display", "none");

        //Added by Usha Pandit on 21.05.2019 for refreshing OU drop down after adding new OU
        getExistingOU();
        //End of Added by Usha Pandit on 21.05.2019 for refreshing OU drop down after adding new OU 

        $('#UnitCode').val("");
        $('#UnitName').val("");
        $('#CboOU').val("");

        $("#tblConfigureHRM").css("display", "none");
        // $("#divSubRequestType").css("display", "none");
        document.getElementById('UnitCode').disabled = false;
        if ($("#addContact").hasClass("collapsed")) {
            $("#addContact").removeClass("collapsed");
            $("#collapseOne11").css('height', 'auto !important');
            $("#collapseOne11").addClass('in');
        }

    }

      //Added by Usha Pandit on 21.05.2019 for refreshing OU drop down after adding new OU 
    function getExistingOU() {
        var url = "BusinessGroup.aspx/Default_GetExistingOU"

        data = JSON.stringify({});
        CustomAJAXCall(url, data, BindDropDownExistingOU);
    }
    function BindDropDownExistingOU(result) {
        //  debugger;
        var strArray = String(result.d).split("|")
        var objCbo = document.getElementById("CboOU");

        var i = 0;

        objCbo.innerHTML = "";
        $('#CboOU').find('option').remove().end();
        var objOption = document.createElement("OPTION");
        objCbo.options.add(objOption);
        objOption.text = "";
        objOption.value = "";

        $.each(JSON.parse(strArray[0]), function (id, obj) {
            // $("#DRequestType").val($("#DRequestType option:first").val());
            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.Location;
            objOption.value = obj.LocationID;           
        });
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
      //End of Added by Usha Pandit on 21.05.2019 for refreshing OU drop down after adding new OU 

    function Edit_OU(obj, OUID, BGID, Uniquid) {
        GlobalBGID = BGID;
        GlobalOUID = OUID;
        GlobalUniquid = Uniquid
        // alert(GlobalUniquid)
        // alert(GlobalOUID)
        $.ajax({
            type: "POST",
            url: "BusinessGroup.aspx/GetOUDetails",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ BGID: BGID, OUID: OUID }),
            success: function (data) {

                var arrResult = data.d.split('##');
                //alert(arrResult);
                $('#UnitCode').val(arrResult[1]);
                $('#UnitName').val(arrResult[0]);

                if ($("#CboOU").length != 0) {

                    $("#CboOU").val(arrResult[2]);
                }
                document.getElementById('UnitCode').disabled = true;
                if (GlobalOUID != 0) {

                    $("#History1").css("display", "inline");
                    $("#History").css("display", "inline");

                    //Commented and Added by Usha Pandit on 24 JAN 2018 for Alignment Issue for Save Button
                    //$("#NewOU").css("margin-right", "-4%");

                     //Commented and Added by Usha Pandit on 20 May 2019 for multiple Save Button display issue
                    //$("#NewOU").css("cssText", "margin-right: 0% !important;");
                    if ($("#NewOU").css('display') == "none") {
                        $("#NewOU").css("cssText", "margin-right: 0% !important;display:none!important;");
                    }
                    else if ($("#NewOU").css('display') == "block") {
                        $("#NewOU").css("cssText", "margin-right: 0% !important;");
                    }
                    //End of Added by Usha Pandit on 20 May 2019 for multiple Save Button display issue

                    //End of Added by Usha Pandit on 24 JAN 2018 for Alignment Issue for Save Button


                }

            }

        });

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }

    function SaveBg() {

        if (validationBG() == 0) {


            if (GlobalBGID != 0) {
                BGID = GlobalBGID;


            }
            else {

                BGID = 0;

            }

            var BussinessName = $('#BussinessName').val();
            var BussinessGroupCode = $('#BussinessGroupCode').val();

            if (BussinessName == "" || BussinessName == undefined) {

                BussinessName = "";
            }

            if (BussinessGroupCode == "" || BussinessGroupCode == undefined) {

                BussinessGroupCode = "";
            }




            data = JSON.stringify({
                BussinessName: BussinessName, BussinessGroupCode: BussinessGroupCode,
                BGID: BGID


            });
            //alert(data);
            strResult = AJAXCallWithResult("BusinessGroup.aspx/SaveBGDetails", data, false);
            if (strResult.d != "" && strResult.d != undefined) {   //Added by Usha Pandit on 24 JAN 2018 for javascript error
                var MainResult = strResult.d.split("||")
                // var MainResult1 = MainResult.split(",")

                if (MainResult[1] == 1) {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Bussiness Group  Save successfully', 'success');
                    RefreshGrid('Type');
                }

                else {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Bussiness Group  Details Updated successfully', 'success');
                    RefreshGrid('Type');

                }
                Edit_BusinessGroup('', MainResult[0]);
            }//Added by Usha Pandit on 24 JAN 2018 for javascript error
        }

    }

    function SaveAddSaveBg(Flag) {
        if (validationBG() == 0) {

            if (GlobalBGID != 0) {
                BGID = GlobalBGID;


            }
            else {

                BGID = 0;

            }
            var BussinessName = $('#BussinessName').val();
            var BussinessGroupCode = $('#BussinessGroupCode').val();

            if (BussinessName == "" || BussinessName == undefined) {

                BussinessName = "";
            }

            if (BussinessGroupCode == "" || BussinessGroupCode == undefined) {

                BussinessGroupCode = "";
            }




            data = JSON.stringify({
                BussinessName: BussinessName, BussinessGroupCode: BussinessGroupCode, BGID: BGID
            });

            strResult = AJAXCallWithResult("BusinessGroup.aspx/SaveBGDetails", data, false);
            if (strResult.d != "" && strResult.d != undefined) {   //Added by Usha Pandit on 24 JAN 2018 for javascript error
                var MainResult = strResult.d.split("||")
                // var MainResult1 = MainResult.split(",")

                if (MainResult[1] == 1) {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Bussiness Group  Save successfully', 'success');
                    RefreshGrid('Type');
                }

                else {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Bussiness Group  Details Updated successfully', 'success');
                    RefreshGrid('Type');

                }
            }//Added by Usha Pandit on 24 JAN 2018 for javascript error
            // Edit_BusinessGroup('', MainResult[0]);

        }
        $('#BussinessName').val("");
        $('#BussinessGroupCode').val("");
        $('#divRequestTypes').css("display", "none");
        $('#divTypeTab').css("display", "none");



    }

    function validationExiting() {

        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"

        var blnIsCboOUInValid = false;  //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if ($("#CboOU").val() == "") {
            strmsg = '- Organization Unit should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;

            blnIsCboOUInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }

        if ($("#CboOU").val() != "") {

            if (GlobalOUID != 0) {
                OUID = GlobalOUID;


            }
            else {

                OUID = 0;

                if (GlobalUniquid != 0) {

                    Uniquid = GlobalUniquid;

                }
                else {
                    Uniquid = "";

                }
            }           

            var url = 'BusinessGroup.aspx/CheckBGName';
            var data = JSON.stringify({ Flag: "OU", BussinessName: $("#CboOU option:selected").text(), BGID: GlobalBGID, OUID: OUID, FlagSql: "OU", GlobalUniquid: Uniquid });

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

                            strmsg = '-  Organization Unit  Already Exists';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            checkvalue = 1;

                            blnIsCboOUInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                        }
                    }
                },

            });


        }



        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        if (blnIsCboOUInValid == true) {
            $("#CboOU").focus();
        }
        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if (strmsg != "") {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;


    }
    function SaveExiting() {
        //alert(LastestOUID);
        //alert(GlobalOUID)
       
        if (validationExiting() == 0) {
          
            if (ExitOU != 0) {
                OUID = ExitOU;


            }
            else {

                OUID = 0;

            }

            var OrgnztionName = $('#CboOU').val();

            //alert(OrgnztionName);
            //return;
            if (OrgnztionName == "" || OrgnztionName == undefined) {

                OrgnztionName = "";
            }




            data = JSON.stringify({
                OrgnztionName: OrgnztionName,
                GlobalOUID: OUID,
                GlobalBGID: GlobalBGID,

                UniqueID: UniqueID,


            });

            strResult = AJAXCallWithResult("BusinessGroup.aspx/SaveOUDetails", data, false);
           
            if (strResult.d != "" && strResult.d != undefined && strResult.d != null) {   //Added by Usha Pandit on 24 JAN 2018 for javascript error

                var MainResult = strResult.d.split("||")
                UniqueID = MainResult[2]
                ExitOU = MainResult[0]

                //alert(LastestOUID);
                if (MainResult[1] == 1) {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization  Save successfully', 'success');
                    //RefreshGrid('OU');
                }

                else {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization Details Updated successfully', 'success');
                    RefreshGrid('OU');

                }
                Edit_OU('', MainResult[0], GlobalBGID, UniqueID);
                //CancelOU();
                $("#tblConfigureHRM").css("display", "block");
                RefreshGrid('OU');
            } //Added by Usha Pandit on 24 JAN 2018 for javascript error
        }

    }


    function SaveAddExiting(Flag) {

        //if ($("#CboOU").val() == "") {

        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify("- Organization Unit should not be left blank", 'error', 15);
        //    return;

        //}
        //else {
        //alert(LastestOUID);
        //alert(GlobalOUID)
        if (validationExiting() == 0) {
            if (ExitOU != 0) {
                OUID = ExitOU;


            }
            else {

                OUID = 0;

            }

            var OrgnztionName = $('#CboOU').val();

            //alert(OrgnztionName);
            //return;
            if (OrgnztionName == "" || OrgnztionName == undefined) {

                OrgnztionName = "";
            }




            data = JSON.stringify({
                OrgnztionName: OrgnztionName,
                GlobalOUID: OUID,
                GlobalBGID: GlobalBGID,

                UniqueID: UniqueID,


            });

            strResult = AJAXCallWithResult("BusinessGroup.aspx/SaveOUDetails", data, false);
            if (strResult.d != "" && strResult.d != undefined) {   //Added by Usha Pandit on 24 JAN 2018 for javascript error
                var MainResult = strResult.d.split("||")
                UniqueID = MainResult[2]
                ExitOU = MainResult[0]

                //alert(LastestOUID);
                if (MainResult[1] == 1) {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization  Save successfully', 'success');
                    //RefreshGrid('OU');
                }

                else {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization Details Updated successfully', 'success');
                    // RefreshGrid('OU');

                }
                
                $("#tblConfigureHRM").css("display", "block");
                RefreshGrid('OU');
                $("#CboOU").val("");

            } //Added by Usha Pandit on 24 JAN 2018 for javascript error

        }
    }


    function SaveNew() {

        if (validationNewOU() == 0) {

            //if (GlobalOUID != 0) {
            //    OUID = GlobalOUID;


            //}
            //else {

            //    OUID = 0;

            //}

            var UnitCode = $('#UnitCode').val();
            var UnitName = $('#UnitName').val();

            if (UnitCode == "" || UnitCode == undefined) {

                UnitCode = "";
            }

            if (UnitName == "" || UnitName == undefined) {

                UnitName = "";
            }

            //Edit_OU('', GlobalOUID, GlobalBGID, Uniquid)
            // GlobalUniquid = GlobalUniquid;

            // debugger;

            //if (GlobalUniquid != 0)
            //{

            //    UniqueID = GlobalUniquid;

            //}
            //else
            //{
            //    UniqueID = "";

            //}

            data = JSON.stringify({
                UnitCode: UnitCode,
                UnitName: UnitName,
                GlobalBGID: GlobalBGID,
                GlobalUniquid: GlobalUniquid


            });

            strResult = AJAXCallWithResult("BusinessGroup.aspx/SaveNewOUDetails", data, false);
            if (strResult.d != "" && strResult.d != undefined) {   //Added by Usha Pandit on 24 JAN 2018 for javascript error
                var MainResult = strResult.d.split("||")
                // var MainResult1 = MainResult.split(",")
                //alert(MainResult);
                GlobalOUID = MainResult[0];
                GlobalUniquid = MainResult[2];
                if (MainResult[1] == 1) {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization  Save successfully', 'success');
                    // RefreshGrid('OU');
                }

                else {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization Details Updated successfully', 'success');


                }
                // Edit_OU('', MainResult[0], GlobalBGID,'');
                $("#tblConfigureHRM").css("display", "block");
                if ($("#UnitCode").val() != "") {

                    document.getElementById('UnitCode').disabled = true;

                }
                else {
                    document.getElementById('UnitCode').disabled = false;
                }
                RefreshGrid('OU');
                //$("#UnitCode").val("");
                //$("#UnitCode").val("");
            } //Added by Usha Pandit on 24 JAN 2018 for javascript error
        }

    }

    function SaveAddNew(flag) {

        if (validationNewOU() == 0) {

            //if (GlobalOUID != 0) {
            //    OUID = GlobalOUID;


            //}
            //else {

            //    OUID = 0;

            //}

            var UnitCode = $('#UnitCode').val();
            var UnitName = $('#UnitName').val();

            if (UnitCode == "" || UnitCode == undefined) {

                UnitCode = "";
            }

            if (UnitName == "" || UnitName == undefined) {

                UnitName = "";
            }

            //Edit_OU('', GlobalOUID, GlobalBGID, Uniquid)
            // GlobalUniquid = GlobalUniquid;

            // debugger;

            //if (GlobalUniquid != 0)
            //{

            //    UniqueID = GlobalUniquid;

            //}
            //else
            //{
            //    UniqueID = "";

            //}

            data = JSON.stringify({
                UnitCode: UnitCode,
                UnitName: UnitName,
                GlobalBGID: GlobalBGID,
                GlobalUniquid: GlobalUniquid


            });

            strResult = AJAXCallWithResult("BusinessGroup.aspx/SaveNewOUDetails", data, false);
            if (strResult.d != "" && strResult.d != undefined) {   //Added by Usha Pandit on 24 JAN 2018 for javascript error
                var MainResult = strResult.d.split("||")
                // var MainResult1 = MainResult.split(",")
                //alert(MainResult);
                GlobalOUID = MainResult[0];
                GlobalUniquid = MainResult[2];
                if (MainResult[1] == 1) {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization  Save successfully', 'success');
                    // RefreshGrid('OU');
                }

                else {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization Details Updated successfully', 'success');


                }
                // Edit_OU('', MainResult[0], GlobalBGID,'');
                $("#tblConfigureHRM").css("display", "block");
                if ($("#UnitCode").val() != "") {

                    document.getElementById('UnitCode').disabled = true;

                }
                else {
                    document.getElementById('UnitCode').disabled = false;
                }
                RefreshGrid('OU');
                if (flag == "AddNew") {

                    $("#UnitName").val("");
                    $("#UnitCode").val("");
                    document.getElementById('UnitCode').disabled = false;

                }
            } //Added by Usha Pandit on 24 JAN 2018 for javascript error
        }

    }

    function validationNewOU() {
        // debugger;
        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"

        var blnUnitCodeInValid = false; //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field

        if ($("#UnitCode").val() == "") {
            strmsg = '- Unit Code should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
            blnUnitCodeInValid = true; //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field
        }


        if ($("#UnitCode").val() != "") {
            if (checkSpecialCharacter($('#UnitCode').val()) == true) {
                {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = '- A Unit Code Name cannot contain any of these /\\:*?<>|,"+- Characters';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    checkvalue = 1;
                    blnUnitCodeInValid = true; //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field
                }
            }

            else if ($("#UnitCode").val().length > 20) {

                strmsg = '- A Unit Code length Should be less than OR equal to 20 characters';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
                blnUnitCodeInValid = true; //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field
            }
        }


        if ($("#UnitCode").val() != "") {


            if (GlobalOUID != 0) {
                OUID = GlobalOUID;


            }
            else {

                OUID = 0;


            }
            // alert(GlobalBGID);
            if (GlobalUniquid != 0) {

                Uniquid = GlobalUniquid;

            }
            else {
                Uniquid = "";

            }
            var url = "BusinessGroup.aspx/CheckBGName";
            // var data = JSON.stringify({ Flag: "OU", BussinessName: $('#UnitCode').val(), BGID: OUID, FlagSql: "OU1", GlobalUniquid: GlobalUniquid });
            var data = JSON.stringify({ Flag: "OU", BussinessName: $('#UnitCode').val(), OUID: OUID, BGID: GlobalBGID, FlagSql: "OU", GlobalUniquid: Uniquid });

            // alert(data);
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

                            strmsg = '-  Unit Code  Already Exists';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            checkvalue = 1;

                            blnUnitCodeInValid = true; //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field
                        }
                    }
                },
                error: function (xhr, status, error) {
                    //Stop();
                    //StopAjaxLoader("body");

                    console.log(xhr.responseText);
                    //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }


            });


        }

        //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field
        var blnUnitNameInValid = false;
        //End of Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field

        if ($("#UnitName").val() == "") {
            strmsg = '- Unit Name  should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
            blnUnitNameInValid = true; //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field
        }


        if ($("#UnitName").val() != "") {
            if (checkSpecialCharacter($('#UnitName').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- A Unit Name  Code cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;
                blnUnitNameInValid = true; //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field
            }
        }


        if ($("#UnitName").val() != "") {


            if (GlobalOUID != 0) {
                OUID = GlobalOUID;


            }
            else {

                OUID = 0;

                if (GlobalUniquid != 0) {

                    Uniquid = GlobalUniquid;

                }
                else {
                    Uniquid = "";

                }
            }
            var url = 'BusinessGroup.aspx/CheckBGName';
            var data = JSON.stringify({ Flag: "OU", BussinessName: $('#UnitName').val(), BGID: GlobalBGID, OUID: OUID, FlagSql: "OU", GlobalUniquid: Uniquid });

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

                            strmsg = '-  Unit Name  Already Exists';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            checkvalue = 1;
                            blnUnitNameInValid = true; //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field
                        }
                    }
                },

            });


        }

        //Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field

        if (blnUnitNameInValid == true) {
            $("#UnitName").focus();
        }
        if (blnUnitNameInValid == true || blnUnitCodeInValid == true) {
            var hasFocus = $('#UnitName').is(':focus');
            if (hasFocus) {

            }
            else {
                $("#UnitCode").focus();
            }
        }

        //End of Added by Usha Pandit on 22 JAN 2018 for giving focus to mandatory field

        if (strmsg != "") {
            alertify.dismissAll();   //Added by Usha Pandit on 22 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;

    }

    function Delete_OU() {
      
        //Commented and Added by Usha Pandit on 21.05.2019 for Select OU for Deletion issue
        //if (document.getElementById('chkAllOU1').checked == false || document.getElementsByName('chkAllOU').checked == false) {             
        //    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify("Please Select at least one record for deletion", 'error', 15);
        //    return;
        //}

         var table = $('#divOU table').DataTable();
                var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllOU1').checked == true) {
            strRequestOUId = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                return this.value;
            }).get().join(',');
        }
        else {
            strRequestOUId = $('input[id=chkAllOU]:checked').map(function () {
                return this.value;
            }).get().join(',');
        }

        if (strRequestOUId.length <= 0) {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Please Select at least one record for deletion", 'error', 15);
            return;
        }
        //End of Added by Usha Pandit on 21.05.2019 for Select OU for Deletion issue

        var SelectedOU;
        var table = $('#divOU table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllOU1').checked == true) {
            SelectedOU = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                return this.value;
            }).get().join(',');
        }
        else {
            SelectedOU = arrSelectedCheck.join();
        }
        //var SelectedOU = $('input[id=chkAllOU]:checked').map(function () {
        //    return this.value;
        //}).get().join(',');

        data1 = JSON.stringify({ SelectedOU: SelectedOU });
        strResult1 = AJAXCallWithResult("BusinessGroup.aspx/DeleteOU", data1, false);
        //alert(strResult1.d);
        if (strResult1.d == 2) {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Organization Unit deleted successfully", 'success');
            RefreshGrid('OU');
            $("#CboOU").val("");
            $("#UnitName").val("");
            $("#UnitCode").val("");



        }
        else {
            //alertify.set('notifier', 'position', 'top-right');
            //alertify.notify("Organization Unit is in uesed,can not  delete", 'error');


        }

        var arraySLA = SelectedOU.split(",");

        $.each(arraySLA, function (i) {
            arrSelectedCheck.pop(arraySLA[i]);
        });

        RefreshGrid('OU');
    }

    function select_checkbox(obj) {
        if (obj.checked) {
            arrSelectedCheck.push(obj.value);	// record the value of the checkbox to valArray
        } else {
            arrSelectedCheck.pop(obj.value);	// remove the recorded value of the checkbox
        }
    }


    function DeleteBG() {

        var SelectedBG;
        var table = $('#DivList table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        //if (document.getElementById('chkAllBU').checked == true  || document.getElementById('chkAllBU1').checked == true ){

        if (document.getElementById('chkAllBU').checked == false || document.getElementsByName('chkAllBU1').checked == false) {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Please Select at least one record for deletion", 'error', 15);
            return;

        }
        if (document.getElementById('chkAllBU1').checked == true) {
            SelectedBG = $('input[name="chkAllBU"]:not(:disabled)', rows).map(function () {
                return this.value;
            }).get().join(',');
        }
        else {
            SelectedBG = arrSelectedCheck.join();
        }


        data1 = JSON.stringify({ SelectedBG: SelectedBG });
        strResult1 = AJAXCallWithResult("BusinessGroup.aspx/DeleteBG", data1, false);
        if (strResult1.d == 1) {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Bussiness Group deleted successfully", 'success');
            RefreshGrid('Type');

        }

        var arraySLA = SelectedBG.split(",");

        $.each(arraySLA, function (i) {
            arrSelectedCheck.pop(arraySLA[i]);
        });
    }
    //else
    //{
    //    alertify.set('notifier', 'position', 'top-right');
    //    alertify.notify("Select at least one record for deletion", 'error');

    //}




    function validationBG() {

        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"

        if ($("#BussinessGroupCode").val() == "") {
            strmsg = '- Bussiness Group Code should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
            $("#BussinessGroupCode").focus();               //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        }


        if ($("#BussinessGroupCode").val() != "") {
            if (checkSpecialCharacter($('#BussinessGroupCode').val()) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = '- A Bussiness Group Code cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;
                $("#BussinessGroupCode").focus();               //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

            }

            if ($("#BussinessGroupCode").val().length > 20) {

                strmsg = '- A Bussiness Group Code length Should be less than or equal to 20 characters';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
                $("#BussinessGroupCode").focus();               //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

            }

        }

        if ($("#BussinessGroupCode").val() != "") {

            //if (document.getElementById('hdnBGID').value != '') {
            //    var BGID = 0;

            //}
            //else {

            //    BGID = GlobalBGID;

            //}

            if (GlobalBGID != 0) {
                BGID = GlobalBGID;


            }
            else {

                BGID = 0;

            }
            var url = 'BusinessGroup.aspx/CheckBGName';
            // var data = JSON.stringify({ Flag: "BG1", BussinessName: $('#BussinessGroupCode').val(), BGID: BGID, FlagSql: "BG" });
            var data = JSON.stringify({ Flag: "BG", BussinessName: $('#BussinessGroupCode').val(), BGID: BGID, OUID: "", FlagSql: "BG", GlobalUniquid: GlobalUniquid });
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

                            strmsg = '-  Bussiness Group Code   Already Exists';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            checkvalue = 1;
                            $("#BussinessGroupCode").focus();               //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

                        }
                    }
                },

            });


        }

        var blnBusinessNameInValid = false;    //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if ($("#BussinessName").val() == "") {
            strmsg = '- Bussiness Group  Name should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
            blnBusinessNameInValid = true;     //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }


        if ($("#BussinessName").val() != "") {
            if (checkSpecialCharacter($('#BussinessName').val()) == true) {
                {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = '- A Bussiness Group Name cannot contain any of these /\\:*?<>|,"+- Characters';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    checkvalue = 1;
                    blnBusinessNameInValid = true;  //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                }
            }

        }

        if ($("#BussinessName").val() != "") {



            if (GlobalBGID != 0) {
                BGID = GlobalBGID;


            }
            else {

                BGID = 0;

            }
            var url = 'BusinessGroup.aspx/CheckBGName';
            var data = JSON.stringify({ Flag: "BG", BussinessName: $('#BussinessName').val(), BGID: BGID, OUID: "", FlagSql: "BG", GlobalUniquid: GlobalUniquid });
            //var data = JSON.stringify({ Flag: "OU", BussinessName: $('#UnitCode').val(), BGID: GlobalBGID, OUID: OUID, FlagSql: "OU", GlobalUniquid: GlobalUniquid });
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

                            strmsg = '-  Bussiness Group Name   Already Exists';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            checkvalue = 1;
                            blnBusinessNameInValid = true;   //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                        }
                    }
                },

            });


        }




        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        if (blnBusinessNameInValid == true) {
            var hasFocus = $('#BussinessGroupCode').is(':focus');
            if (hasFocus) {

            }
            else {
                $("#BussinessName").focus();
            }
        }
        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field


        if (strmsg != "") {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);
        }
        return checkvalue;
    }

    function ShowHistory_OnClick() {
        $("#cboModifiedBy").val("");
        $("#cboModifiedField").val("");
        var obj = { "UniqueID": GlobalBGID, Flag: "Main" };
        var myJSON = JSON.stringify(obj);
        var url = "BusinessGroup.aspx/ShowMailHistoryDetails"

        var result = AJAXCallWithResult(url, myJSON, false)

        $("#id13 #modalbody").html(result.d);
        document.getElementById('id13').style.display = 'block';
        datatables("ShowHistoryGrid", 'txtSearchHistory');
    }




    function ModifiedFieldFilter_Change(Flag) {
        var UniqueID;
        //alert(Flag);
        var ModifiedField = $('#cboModifiedField :selected').text();
        var ModifiedBy = $('#cboModifiedBy :selected').text();

        if (ModifiedField == "") {
            ModifiedField = $('#cboModifiedField1 :selected').text();
        }
        if (ModifiedBy == "") {
            ModifiedBy = $('#cboModifiedBy1 :selected').text();
        }
        if (Flag == "Main") {
            UniqueID = GlobalBGID;
        }
        else {
            UniqueID = GlobalOUID;
        }

        //alert(ModifiedField);
        //alert(ModifiedBy);
        var obj = { "newModifiedField": ModifiedField, "MessageID": UniqueID, "newModifiedBy": ModifiedBy, Flag: Flag };
        var myJSON = JSON.stringify(obj);

        var url = "BusinessGroup.aspx/FilteredHistory"
        var result = AJAXCallWithResult(url, myJSON, false)

        if (Flag == "Main") {

            $("#id13 #modalbody").html(result.d);

            datatables("ShowHistoryGrid", 'txtSearchHistory');

            document.getElementById('id13').style.display = 'block';
        }
        else {

            $("#id14 #modalbody1").html(result.d);

            datatables("ShowHistoryGrid", 'txtSearchHistory');

            document.getElementById('id14').style.display = 'block';
            $("#cboModifiedBy").val("");
            $("#cboModifiedField").val("");
        }

    }

    function ShowSubTabHistory_OnClick() {

        var obj = { "UniqueID": GlobalOUID, "Flag": "Subtab" };
        var myJSON = JSON.stringify(obj);
        var url = "BusinessGroup.aspx/ShowMailHistoryDetails"

        var result = AJAXCallWithResult(url, myJSON, false)

        if (GlobalOUID == undefined || GlobalOUID == 0) {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select atleast one entry..', 'error');
        }
        else {
            $("#id14 #modalbody1").html(result.d);
            document.getElementById('id14').style.display = 'block';
            datatables("ShowHistoryGrid", 'txtSearchHistory');
            $("#cboModifiedBy").val("");
            $("#cboModifiedField").val("");
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
