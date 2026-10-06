<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CustomFieldMaintainance.aspx.vb" Inherits="PbNIT.CustomFieldMaintainance" %>

<!DOCTYPE html>

<html>

<%CommonFunctions.General.PlotPageHeadTag("Custom Field Maintainance")%>
<head runat="server">
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<title>Custom Field Maintainance</title>
    <meta charset="utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
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
</head>

    <style>
          /*Added By Yasmin on 27th july 2018*/

        button.btn.btn-default.save {
            margin-left: 3px!important;
             margin-right: 3px!important;
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
/*Added by Usha Pandit On 02 Aug 2018 to bring alertify popup front side*/
        .alertify-notifier {
            z-index: 9000!important;
        }
        /*End of Added by Usha Pandit On 02 Aug 2018 to bring alertify popup front side*/
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

        #divTypeStatus {
            width: 102%;
            padding-right: 2%;
            /* overflow: auto; */
            /*height: 346px;*/
            overflow-x: hidden!important;
            overflow-y: auto!important;
        }

        #DivList .dataTables_length {
            display: none;
        }

        #DivList .dataTables_filter {
            display: none;
        }

        #DivList .pagination {
            /*margin: 5px 0 !important;*/
            float: right;
            margin-right: -38%;
            margin-top: 2%;
        }

        #divAssignType .dataTables_length {
            display: none;
        }

        #divAssignType .dataTables_filter {
            display: none;
        }

        #divAssignType table tr td:nth-child(2) {
            text-align:center;
        }
        #divAssignType .top-bar ul li {
            /*margin: 5px 0 !important;
            float: right;
            margin-right: -38%;
            margin-top: 2%;*/
            /*padding:1px 0px!important;*/
        }

        #DivList .dataTables_info {
            margin-top: 2%;
        }

    .fa-trash-o{
       color:red;
    font-size:14px;
    
    }

        .edit-bt {
            background: transparent;
            border: none;
            font-size: 14px!important;
            position: relative;
            top: 2px;
            color: #1e88e5;
        }

        .edit-bt1 {
            background: transparent;
            border: none;
            font-size: 14px!important;
            position: relative;
            top: -3px;
            color: red;
        }

        #DivList {
            overflow: hidden!important;
        }

            #DivList table tr td:nth-child(3) {
                text-align: center;
                width:15%!important;
            }
             #DivList table tr td:nth-child(5) {
                text-align: center;
                width:5%!important;
            }
              #DivList table tr td:nth-child(6) {
                text-align: center;
                width:5%!important;
            }
               #DivList table tr td:nth-child(7) {
                text-align: center;
                width:5%!important;
            }

            #DivList table tr td:nth-child(4) {
                text-align: center!important;
                 width:15%!important;
            }

             #DivList table tr td:nth-child(1) {
                text-align: left!important;
                 width:20%!important;
                  word-break:break-all;
            }

               #DivList table tr td:nth-child(2) {
                text-align: left!important;
                 width:20%!important;
                 word-break:break-all;
            }

                 #DivList table tr th:nth-child(1) {
                text-align: left!important;
                 width:20%!important;
            }

                   #DivList table tr th:nth-child(2) {
                text-align: left!important;
                 width:20%!important;
            }

            #DivList table tr th:nth-child(3) {
                text-align: center;
                 width:15%!important;
            }

            #DivList table tr th:nth-child(4) {
                text-align: center!important;
                 width:15%!important;
            }

            #DivList table tr th:nth-child(5) {
                text-align: center!important;
                 width:5%!important;
            }

            #DivList table tr th:nth-child(6) {
                text-align: center!important;
                 width:5%!important;
            }

            #DivList table tr th:nth-child(7) {
                text-align: center!important;
                 width:5%!important;
            }

            #DivList .dataTables_scrollBody {
                overflow: inherit!important;
                padding-right: 2%;
            }

            #DivList .dataTables_paginate {
                display: none;
            }

            #DivList .dataTables_info {
                display: none;
            }

        .boxnew {
            border: 1px solid #ddd;
             /*padding: 151px;*/ 
            height: 489px;
            border-top: none;
        }
        #divAssignType {
            overflow-x:hidden;
            margin-top:2%;
        }
        .DivRightClass {
            border: 1px solid #ddd;
            /* padding: 66px; */
            /*height: 560px;*/
            /*width: 48%;*/
            /* padding: 20%; */
            /*margin-left: 1%;*/
            margin-top: 1%;
        }

        .DivLeftClass {
            border: 1px solid #ddd;
            /* padding: 66px; */
             /*height: 560px;*/
            /*width: 48%;*/
            /* padding: 20%; */
            margin-right: 1%;
            margin-top: 1%;
            padding-right:2%;
        }

        /*#divAssignType .dataTables_scrollHeadInner table:nth-child(1) {

            width:500px!important;
        }*/

        #divAssignType .dataTables_scrollHeadInner {

            /*Commented and Added by Usha Pandit on 30 July 2018 for Sub request type mapping table header alignment issue*/
            /*width:93%!important;*/
             width:94%!important;
              /*End of Added by Usha Pandit on 30 July 2018 for Sub request type mapping table header alignment issue*/
        }

        #divAssignType .dataTables_scrollHeadInner table {

            width:auto!important;
        }
        #divAssignType .dataTables_info {
            margin-top:14%;
        }
        #tblcontrl {
            width: 100%;
            /*border: 1px solid #ddd;*/
        }

        #tdRight {
            width: 50%;
        }

        #tdleft {
            width: 50%;
            /*float:right;*/
        }

        /*#CustomDetails tr td {
            vertical-align: baseline;
        }*/
        #CustomDetails tr:last-child
        {
           /*border-bottom:1px solid white;*/
        }

        .table td, .table th {
            border-top:1px solid white!important;
            border:none!important;
        }
        #CustomDetails tr td:nth-child(1){
           text-align:left!important;
           padding-left:2%;
        }
          #CustomDetails table tr td
          {
              border-bottom:1px solid white!important;
             border-top:1px solid white!important;
        }
        #CustomDetails .clsTREven {
            border-bottom:1px solid white!important;
             border-top:1px solid white!important;

        }
          #CustomDetails tr td:nth-child(3){
           text-align:left!important;
        }

        #CustomDetails label {
            font-weight: 100;
        }

        #CustomDetails {
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
        }

        .clsSubtags {
            width: 160px !important;
        }

        #btnTab1 {
            font-size: 12px;
        }

        .tablinks4 {
            height: 30px;
            background-color: white;
        }

        .h-tabs {
            margin-top: 2%;
        }

        #divmain {
            overflow: auto;
            width: 102%;
            /*height:400px;*/
            /*padding-right:2%;*/
        }

        /*#divInner {
            overflow: hidden;
        }*/

        #Tab2 .type-top-bar {
            padding:0px 16px !important;
                margin-top: 25px;
        }

        #Tab2 ul .right li:nth-child(1) {
         font-weight: 100!important;
        margin-left: -10%!important;
        margin-top: 0%;
}

        #lblassigntype {
              font-weight: 100!important;
        margin-left: -33%!important;
        margin-top: 0%;

        }
        #libtn {
            margin-right:2%;
            margin-top:-1%;
            float:right;
        }

           .alertify-notifier {
                font-family: "Open Sans",sans-serif!important;
                font-size: 14px !important;
            }

           .btn-default:hover {
          color: rgb(51, 51, 51);
           background-color: none!important;
           border-color: none!important;
}


        .top-bar ul.right li {
            border-right:none!important;
        }
        /*Added ruby Yasmin content 22-5-19 for alignment issue*/
        #btnsaveClick {
            float:right!important;
            /*margin-top:0%;*/
          margin-left:2px;
        }

        #btncancelClick {
             float:right!important;
              /*margin-top:0%;*/
              margin-left:2px;
        }
        #btndelete:hover {
            background-color:none!important;
        }

        .btn-default:hover {
            background-color:none!important;
        }
        #btnShowHistory {
            float:right;
        }
        #btnAccess {
              margin-left:2px;
        }
        #page-top {
               font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
        }

        .container-fluid {
            min-height:0px!important;
        }

        #RuleValidation1 table tr th {
            height:30px!important;
        }

        #RuleValidation1 table tr th:nth-child(2) {
            text-align:center
        }
          /*#ShowHistory table tr th:nth-child(1) {
            text-align:center
        }*/

        #modalbody1 {
            height:275px;
            padding-right:0px;
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

        #divList1 .clsTREven a {
            color:#4caac0 !important

        }
        .clsTextBoxReadOnly {
            font-weight:100!important;
        }
          #ShowHistoryGrid table tr td {
           width:130px!important;
            text-align:center!important;
	    }

        #ShowHistoryGrid .dataTables_length {
            display:none;
        }
        
        #ShowHistoryGrid .dataTables_filter {
            display:none;
        }

        #ShowHistoryGrid .container-fluid {
            overflow-x:hidden!important;
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
	        height: 200px!important;
	        padding-right: 2%!important;
	    }

            #ShowHistoryGrid .pagination 
            {
           /*// margin: 5px 0 !important;*/
           /*Commented and Added by Usha Pandit on 31 July 2018 for pagination alignment*/
            /*margin-right:-50%;*/
             /*float:right;*/

            margin-left: 43%;
            /*End of Added by Usha Pandit on 31 July 2018 for pagination alignment*/
           
        }

        #ShowHistoryGrid .dataTables_info {
            margin-top:10%;
        }

           .clslabel {
            margin-top:1.5%!important;
            font-weight:100!important;
	    }

        #divAssignType .odd {
            background-color:white!important;
            border:1px solid #ddd!important;
        }

        #divAssignType table tr {
             border-bottom:1px solid #ddd!important;
        }
        #tblProjectMapping {
            border-bottom:none!important;
            /*height:350px*/
        }

        #btnsaveList {
            /*float:right;*/
            /*margin-right:-230%;*/
        }

        #icondelete  {
            font-size:14px!important;
            color:red!important;
        }

        #btndelete {
            border:none!important;
             float:right;
        }
        #frmTaskCustomFields {
            font-size:12px!important;
        }

        #btngroup {
            float:right;
            margin-right:2.3%;
        }
        #divAssignType .dataTables_scrollBody {
                    position: relative;
                    overflow: auto;
                    width: 101%;
                    height: 350px;
                    padding-right: 3%
        }
        #divAssignType {
            overflow:hidden!important;
        }
         #divAssignType .dataTables_scroll {
                   overflow: hidden;
              
                width: 107%;
        }
        #btngroupSave {
             float:right;
            margin-right:3.3%;
        }

        #btnAccess {
            float:right;
        }


        #divAccess .dataTables_length {
            display:none;
        }

         #divAccess .dataTables_filter {
            display:none;
        }

          #divAccess .dataTables_scrollBody {
           margin-top:-4%;
        }

        /*#divAccess .pagination {
        margin-top: -1%;
        margin-left: 4%;
}*/
       #divAccess  .dataTables_paginate {
        float: right !important;
        margin-top: -7%;
        margin-right: 0%;
}
        /*#divAssignType  .dataTables_paginate {
        float: right !important;
        margin-top: 0%;
        margin-right: -1%;
}*/

        #divAssignType .dataTables_paginate {
        float: right !important;
        margin-top: 0%;
        margin-right: -6%;
        width: 115%;
}
        #divAssignType .dataTables_scrollBody {
            margin-top:-1%;
            width:101%!important;
        }
       
        #divAccess table tr th:nth-child(1) {
             
             width:75%;
        }
         #divAccess table tr th:nth-child(2) {
             text-align:center;
             width:25%;
        }

         #divAccess table tr td:nth-child(2) {
             text-align:center;
             width:25%;
        }

        #idAccess {
                margin-left: -61%;
                overflow:hidden!important;
    height: 29PX;
    line-height: 10%;
        }

       #Idcal {
            float: right!important;
            margin-top: 9%!important;
            width: 17px!important;
}
        #txtDefaultValue {
            /*width:90px!important;*/
        }
        #Tab2 .search-bar {
    margin-left: 0%;
    margin-top: -6%;
    float: left;
}


        :-ms-input-placeholder { /* IE 10+ */
  color: #bbb!important;
}

        button[disabled], html input[disabled] {
    cursor: not-allowed!important;
}

        #RuleValidation1 .modal-content {
            background-color: #fefefe;
            margin: 5% auto 15% auto;
            border: 1px solid #888;
            width: 740px;
            height: 385px!important;
}
        #btnValidation {
                height: 30px;
    line-height: 2%;
        }

       #txtQueryText {
        margin-left: 21%;
        width: 322px!important;
        height: 70px!important;
}
        #cboModifiedBy {
            height:29px;
        }

           #cboModifiedField {
         height:29px;
        }

        #Button1 {
        height: 25px;
        line-height: 0;
        }

        #errormsg {
            color:red;
        }
        .txtDefaultValue {
            width:90px!important;
        }

        a:not([href]):not([tabindex]) {
            color: #337ab7!important;
    /* text-decoration: none; */
}
        /*'/*Added by Kashish for ui change*/
	    .search-bar {
	        /*margin-left: 10px!important;*/
            margin-top: -7px!important;
	    }
    </style>
   
<body id="page-top">
    <form id="frmTaskCustomFields">
        <div>
            <%WritePage("", "Load", "")%>
        </div>

        
    </form>
    <div id="RuleValidation1" class="modal">

            <form class="modal-content animate" action="/action_page.php">
                <div class="imgcontainer">
                    <span class="appro-title" style="font-size:12px">Validation Rules</span>
                    <span onclick="close_onclick()" class="close" title="Close">&times;</span>
                </div>
                <div class="container-fluid">
                    
                    <div class="form-group">
                      <%--  <label class="control-label col-sm-2 clslabel" for="request type">Modified Field</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 919", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                         <label class="control-label col-sm-2 clslabel" for="request type code">Modified By</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 919", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>--%>
                        <ul>
                            <li style="float:right;margin-top:1%;">
                                <button type='button' onclick='SetValidated()' style='' class='btn btn-default save' id="btnValidation" title='Set Validation'>Set / Remove Validation</button>
                            </li>
                        </ul>
                    </div>
                    <div class="container-fluid" id="modalbody1" style="overflow-x: hidden;overflow-y: auto;width:700px;">
                    </div>
                </div>
            </form>
        </div>


    <div id="divHistory" class="modal clsSettingstabs">

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
                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 3560", 150, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                    </div>

                </div>
                <div class="container-fluid" id="modalbody" style="overflow-y: auto!important;overflow-x:hidden!important; height: 245px;">
                </div>
            </div>
        </form>
    </div>


     <div id="divAccess1" class="modal clsSettingstabs">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Configure Access</span>
                <span onclick="document.getElementById('divAccess1').style.display='none'" class="close" title="Close ">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group" style="margin-top:5px;">
                   <ul>
                            <li style="float:left;margin-top:1%;">
                                  <div class='left search-bar' style="float:left;margin-left:14%;">
                                       <i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>
                                      <input type='text' id='Access' placeholder='Search in table' >
                                    </div>
                            </li>
                            <li style="float:right;margin-top:1%;">
                                <button type='button' onclick='SaveAccess()' style='' id='idAccess' class='btn btn-default save' >Save</button>
                            </li>
                        </ul>
                </div>
                <div class="container-fluid" id="divAccessModelBody" style="overflow-y: auto!important;overflow-x:hidden!important; height: 245px;">
                </div>

                <div class="form-group" style="margin-top:5px;">
                   <ul>
                           <%-- <li style="float:left;margin-top:1%;">
                                  <div class='left search-bar' style="float:left;margin-left:14%;">
                                       <i id='i1' class='fa fa-search' aria-hidden='true'></i>
                                      <input type='text' id='Text1' placeholder='Search in table' title='Type here to search '>
                                    </div>
                            </li>--%>
                           <%-- <li style="float:right;margin-top:-8%;margin-right:4%">
                                <button type='button' onclick='SaveAccess()' style='' id='Button1' class='btn btn-default save' title='Save'>Save</button>
                            </li>--%>
                        </ul>
                </div>
            </div>
        </form>
    </div>
</body>


    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>



<script src="../../../EnhancementFiles/js/editor.js"></script>
 <link href="../../../EnhancementFiles/OnlineFiles/datepicker/datepicker3.css" rel="stylesheet" />
<script src="../../../EnhancementFiles/OnlineFiles/datepicker/bootstrap-datepicker.js"></script>



    <%--<script src="../../General/CommonFunctions.js"></script>
	    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
	<%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
</html>

<script>
    
    $(function () {


        $('#txtDefaultValue').datepicker();
        $('#txtDefaultValue').datepicker();


    });

    $(function () {
        $(document).tooltip({
            position: {
                //Commented and Added by Yasmin Shaikh on 30 July 2018
                //my: "center bottom-20",
                my: "center bottom-10",
                //End of Added by Yasmin Shaikh on 30 July 2018

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
    var globalCustomFieldID, globalCustomFieldName;
    var SelectedValidationRules="";
    $(window).load(function () {
        $("#header").css("display", "none");
        RefreshGridDetails();
        RemoveFrameLoader();
        $("#divSubRequestType").css("display", "none");
    });

    var TypeDiv; var accordion;
    var intDivGridHeight;

        

    var intDivGridHeight, intDivGridListHeight
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
        if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) 
        {
           // alert('1');
           // $("#divmain").css('height', intDivGridListHeight - 400 + "px");
            $("#divTypeStatus").css('height', intDivGridListHeight - 280 + "px");
          
            //alert(intDivGridListHeight - 400);
        }

        else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) 
        {

            //alert('11');
            $("#divTypeStatus").css('height', intDivGridListHeight - 320 + "px");
        }
        else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) 
        {
            //alert('111');
            $("#divTypeStatus").css('height', intDivGridListHeight - 280 + "px");
        }
        else 
        {
            //alert('1111');
            $("#divTypeStatus").css('height', intDivGridListHeight - 280 + "px");
        }


        datatables(DivId, DivSerach, "");
        $("#header").css("display", "block");
       
    }

    function datatables(divID, txtBoxID, height) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({
            responsive: true,
            "aLengthMenu": [100],
            //ordering:false,
            //scrollY: '400px',
            //pagingType: "simple_numbers",
            //   scrollX: true,
            //language: {
            //    paginate: {
            //        first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
            //        next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
            //        previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
            //        last: '<i class="fa fa-angle-right" title="Last"></i>'
            //    }
            //},
            "columnDefs": [{
                "orderable": false,
            }], 
            // "bstateSave": true,
            scrollX: true
        });

        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }


    function datatables1(divID, txtBoxID, height) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({
            responsive: true,
            pageLength: 3,
            //scrollY: '400px',
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

    function datatablesAcess(divID, txtBoxID, height) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({
            responsive: true,
            pageLength: 5,
            //scrollY: '400px',
            pagingType: "simple_numbers",
           
            scrollX: true
        });

        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }


    function Assigndatatables(divID, txtBoxID, height) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({
            responsive: true,
            pageLength: 25,
            scrollY: '350',
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
            //Added by Usha Pandit on 30 July 2018 for Sub request type mapping table header alignment issue*/
            , "drawCallback": function( settings ) {
                browserIESpecificAlignment();
            }
        }).on( 'page.dt', function () {
           
            browserIESpecificAlignment();
            //End of Added by Usha Pandit on 30 July 2018 for Sub request type mapping table header alignment issue*/
        });


        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }

    //Added by Usha Pandit on 30 July 2018 for Sub request type mapping table header alignment issue*/
    function browserIESpecificAlignment()
    {
        var Browser = isIE();
          
        if (Browser == 'IE') {
            $("#divAssignType").find(".dataTables_scrollHeadInner").css("cssText","width:104%!important;");               
        }  
    }
    //End of Added by Usha Pandit on 30 July 2018 for Sub request type mapping table header alignment issue*/

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



    function Edit_Custom(obj, CustomFieldID, CustomFieldName) {
        $("#divSubRequestType").css("display", "");
        globalCustomFieldName = CustomFieldName;
        globalCustomFieldID = CustomFieldID;

      
        var strResult1, data1;
        if (CustomFieldID == "")
        {
            CustomFieldID = "";

        }
      
        data1 = JSON.stringify({ CustomFieldID: CustomFieldID, Flag: "EditCustom", CustomFieldName: CustomFieldName });
        strResult1 = AJAXCallWithResult("CustomFieldMaintainance.aspx/PlotSubtab", data1, false);
        //alert(strResult1.d);
        if(strResult1 != undefined)
        {
            if (strResult1.d != '') {

                // $("#divSubRequestType").html("");
                $("#divSubRequestType").html(strResult1.d);
                $("#divSubRequestType").addClass("boxnew");
                $("#DivRight").addClass("DivRightClass");
                $("#DivLeft").addClass("DivLeftClass");
                $("#divTypeStatus").css("display", "none");
                //$("#divTypeStatus").html("");
                $("#header").css("display", "block");
                //$("#btnShowHistory").css("display", "block");
                $("#Spanconfiguration").html(globalCustomFieldName + " >> Custom Fields Details");
                if ($("#btnTab1").length == 0) 
                {                    
                    PlotSubtab1("ClientContact");
                    $("#DivLeft").addClass("DivLeftClass");
                    //$("#DivLeft").addClass("DivLeftClass");
                    RefreshGridDetails();
                }
            
                if (WhichBrowser() == "IE") 
                {
                
                    if (parseInt(window.innerHeight) <= 787 && parseInt(window.innerWidth) <= 1047) 
                    {
               
                        intDivGridListHeight = parseInt(window.innerHeight) - 600;
                    
                        $("#divmain").css('height', intDivGridListHeight + 220 + "px");
                        $(".DivRightClass").css('height', intDivGridListHeight + 400 + "px");
                        $(".DivLeftClass").css('height', intDivGridListHeight + 400 + "px");
                    }
                    else
                    {
                
                        intDivGridListHeight = parseInt(window.innerHeight) - 600;
                        // alert(intDivGridListHeight);
                        $(".boxnew").css('height', intDivGridListHeight + 320 + "px");
                        $("#divmain").css('height', intDivGridListHeight + 260 + "px");
                        $(".DivRightClass").css('height', intDivGridListHeight + 200 + "px");
                        $(".DivLeftClass").css('height', intDivGridListHeight + 200 + "px");
                
                    }

                }
                else
                {

               
                    if (parseInt(window.innerHeight) <= 775 && parseInt(window.innerWidth) <= 1047) 
                    {
               
                        intDivGridListHeight = parseInt(window.innerHeight) - 600;
                        // alert(intDivGridListHeight + 350 );
                        $("#divmain").css('height', intDivGridListHeight + 220 + "px");
                        $(".DivRightClass").css('height', intDivGridListHeight + 450 + "px");
                        $(".DivLeftClass").css('height', intDivGridListHeight + 450 + "px");
                    }
                    else 
                    {
              
                        intDivGridListHeight = parseInt(window.innerHeight) - 600;
                        // alert(intDivGridListHeight);
                        $(".boxnew").css('height', intDivGridListHeight + 320 + "px");
                        $("#divmain").css('height', intDivGridListHeight + 260 + "px");
                        $(".DivRightClass").css('height', intDivGridListHeight + 200 + "px");
                        $(".DivLeftClass").css('height', intDivGridListHeight + 200 + "px");
                    }
                }
                //ResolutionCheck();
                if(globalCustomFieldID!="")
                {
                    $("#btnAccess").css("display","block");
                    $("#btnShowHistory").css("display","block");
            
                }
            }
        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });
        //Added by yasmin on 6th Aug to remove combo box tooltip
        $('option[title]').each(function() { $(this).removeAttr('title'); }); 
        //Added by Usha Pandit on 31 July 2018 for removing blank field from combo box plot 
        $('#lstValue option')
    .filter(function() {
        return !this.value || $.trim(this.value).length == 0;
    })
   .remove();
        
        //End of Added by Usha Pandit on 31 July 2018 for removing blank field from combo box plot 



        //Added by Usha Pandit on 31 July 2018 for Custom field date calender selection on date field click
        $(".clsDateControl").each(function (id, val) {
            $(this).datepicker().on('show', function (e) {               
                if ($(this).val().length > 0) {
                    $(this).datepicker('update', new Date($(this).val()));
                }
            });
        })
        //End of Added by Usha Pandit on 31 July 2018 for removing blank field from combo box plot 


        //Added by Usha Pandit on 02 Aug 2018 for checking applicable validation rule
       
        $('#cboDataType').change(function(event) {

            var strcurmsg = "";
            var errorcurMsg = "<ul>"; 
            var table = $('#modalbody1 table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            //var curvalidationrules = $('input[id="chkApply"]:checked', rows).map(function ()
            //{
            //    return this.value;
            //}).get().join(','); 
            //table.destroy();
            var curvalidationrules = "";
            if(curvalidationrules == "")
            {
                curvalidationrules = $("#txtValidationRules").val();
            }
           
            if(isSubstringExists(curvalidationrules, ",9,") || isSubstringExists(curvalidationrules, ",9") || isSubstringExists(curvalidationrules, "9"))
            { 
                if( $("#cboDataType").val() == 1)
                {
                    strcurmsg = ' - Data Type Numeric is not allowed when Only Alphabates validation rule is applied';
                    errorcurMsg += "<li>" + strcurmsg + "</li>";
                    $("#cboDataType").val(2);
                }
                
            }
           
            if(isSubstringExists(curvalidationrules, ",3,") || isSubstringExists(curvalidationrules, ",3") || isSubstringExists(curvalidationrules, "3")
                || isSubstringExists(curvalidationrules, ",16,") || isSubstringExists(curvalidationrules, ",16") || isSubstringExists(curvalidationrules, "16")
                || isSubstringExists(curvalidationrules, ",17,") || isSubstringExists(curvalidationrules, ",17") || isSubstringExists(curvalidationrules, "17")
                || isSubstringExists(curvalidationrules, ",18,") || isSubstringExists(curvalidationrules, ",18") || isSubstringExists(curvalidationrules, "18")
                || isSubstringExists(curvalidationrules, ",13,") || isSubstringExists(curvalidationrules, ",13") || isSubstringExists(curvalidationrules, "13"))
            { 
                if( $("#cboDataType").val() == 2)
                {
                    strcurmsg = ' - Data Type Text is not allowed when Numeric/Positive Numeric/Value Range/Max Value/Min Value validation rule is applied';
                    errorcurMsg += "<li>" + strcurmsg + "</li>";
                    $("#cboDataType").val(1);
                }
                
            }
           
            if (strcurmsg != "")
            {
                alertify.dismissAll();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorcurMsg, 'error', 5);
               
            }
        });

 //End of Added by Usha Pandit on 02 Aug 2018 for checking applicable validation rule



    }


    function ResolutionCheck()
    {
    
    
        if (WhichBrowser() == "IE") 
        {
                
            if (parseInt(window.innerHeight) <= 787 && parseInt(window.innerWidth) <= 1047) 
            {
               
                intDivGridListHeight = parseInt(window.innerHeight) - 600;
                    
                $("#divmain").css('height', intDivGridListHeight + 220 + "px");
                $(".DivRightClass").css('height', intDivGridListHeight + 400 + "px");
                $(".DivLeftClass").css('height', intDivGridListHeight + 400 + "px");
            }
            else
            {
                
                intDivGridListHeight = parseInt(window.innerHeight) - 600;
                // alert(intDivGridListHeight);
                $(".boxnew").css('height', intDivGridListHeight + 320 + "px");
                $("#divmain").css('height', intDivGridListHeight + 260 + "px");
                $(".DivRightClass").css('height', intDivGridListHeight + 200 + "px");
                $(".DivLeftClass").css('height', intDivGridListHeight + 200 + "px");
                
            }

        }
        else
        {

               
            if (parseInt(window.innerHeight) <= 775 && parseInt(window.innerWidth) <= 1047) 
            {
               
                intDivGridListHeight = parseInt(window.innerHeight) - 600;
                // alert(intDivGridListHeight + 350 );
                $("#divmain").css('height', intDivGridListHeight + 220 + "px");
                $(".DivRightClass").css('height', intDivGridListHeight + 450 + "px");
                $(".DivLeftClass").css('height', intDivGridListHeight + 450 + "px");
            }
            else 
            {
              
                intDivGridListHeight = parseInt(window.innerHeight) - 600;
                // alert(intDivGridListHeight);
                $(".boxnew").css('height', intDivGridListHeight + 320 + "px");
                $("#divmain").css('height', intDivGridListHeight + 260 + "px");
                $(".DivRightClass").css('height', intDivGridListHeight + 200 + "px");
                $(".DivLeftClass").css('height', intDivGridListHeight + 200 + "px");
            }
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
    function CancelPage() {
        $("#divTypeStatus").css("display", "block");
        $("#divTypeTab").css("display", "block");
        $("#divRequestTypes").css("display", "block");
        $("#divSubRequestType").html("");
        RefreshGrid('Type');
    }



    function openCity4(evt, cityName) {
        //debugger;
        var i, tabcontent4, tablinks4;

        if (cityName == "Tab1") {
            PlotSubtab1("PlotSubtab");
           
            RefreshGridDetails();

            //Added by Usha Pandit on 31 July 2018 for removing blank field from combo box plot 
            $('#lstValue option')
 .filter(function() {
     return !this.value || $.trim(this.value).length == 0;
 })
.remove();
            //End of Added by Usha Pandit on 31 July 2018 for removing blank field from combo box plot 
        }
        if (cityName == "Tab2") 
        {
            PlotSubtab1("ClientContact");
            //RefreshGrid('ClientContact');
            $("#DivLeft").addClass("DivLeftClass");
            RefreshGridDetails();
           
            //Added by Usha Pandit on 30 July 2018 for Sub request type mapping table header alignment issue*/
            browserIESpecificAlignment();
            //End of Added by Usha Pandit on 30 July 2018 for Sub request type mapping table header alignment issue*/
        }


    }


    function PlotSubtab1(Flag) 
    {

        // alert(EditCustomerID);
        
        var strResult1, data1;
        //debugger;
       
        data1 = JSON.stringify({ CustomFieldID: globalCustomFieldID, Flag: Flag, CustomFieldName: globalCustomFieldName });
        strResult1 = AJAXCallWithResult("CustomFieldMaintainance.aspx/PlotSubtab", data1, false);
        //alert(strResult1.d);
        if (strResult1.d != '') {
            if (Flag == "PlotSubtab") {
                $("#DivHorizontal").html("");
                $("#DivHorizontal").html(strResult1.d);
                // $("#divSubRequestType").addClass("table");
                $("#divSubRequestType").css("display", "block!imporatnt");
                // $("#btnConfigureHRM")
                if ($("#btnTab1").hasClass('active')) {

                    $("#btnTab1").removeClass('active')
                    $("#btnTab1").addClass('active')

                }
                else {
                    $("#btnTab1").addClass('active')
                    // $("#btnProjectMapping").css('Margin-top', '1px solid #ddd')
                    // $("#btnProjectMapping").css('Margin-bottom', '')
                    $("#btnTab2").removeClass('active')

                }


            }

            else {

                $("#DivHorizontal").html("");
                $("#DivHorizontal").html(strResult1.d);
                // $("#divSubRequestType").addClass("table");
                $("#divCustomerContactcilent").css("display", "block!imporatnt");
               // $("#DivLeft").addClass("");
               // $("#DivLeft").addClass("DivLeftClass");
                if ($("#btnTab2").hasClass('active')) {

                    $("#btnTab2").removeClass('active')

                }
                else {
                    $("#btnTab2").addClass('active')
                    $("#btnTab1").removeClass('active')

                }
            }
            //if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

            //    intDivGridListHeight = parseInt(window.innerHeight) - 250;

            //}
            //else {
            //    //  intDivGridListHeight = (window.innerHeight / 3) + 6;
            //    intDivGridListHeight = parseInt(window.innerHeight) - 600;
            //}
            if (WhichBrowser() == "IE") 
            {
                
                if (parseInt(window.innerHeight) <= 787 && parseInt(window.innerWidth) <= 1047) 
                {
               
                    intDivGridListHeight = parseInt(window.innerHeight) - 600;
                    
                    $("#divmain").css('height', intDivGridListHeight + 220 + "px");
                    $(".DivRightClass").css('height', intDivGridListHeight + 400 + "px");
                    $(".DivLeftClass").css('height', intDivGridListHeight + 400 + "px");
                }
                else
                {
                
                    intDivGridListHeight = parseInt(window.innerHeight) - 600;
                    // alert(intDivGridListHeight);
                    $(".boxnew").css('height', intDivGridListHeight + 320 + "px");
                    $("#divmain").css('height', intDivGridListHeight + 260 + "px");
                    $(".DivRightClass").css('height', intDivGridListHeight + 200 + "px");
                    $(".DivLeftClass").css('height', intDivGridListHeight + 200 + "px");
                
                }

            }
            else
            {

               
                if (parseInt(window.innerHeight) <= 775 && parseInt(window.innerWidth) <= 1047) 
                {
               
                    intDivGridListHeight = parseInt(window.innerHeight) - 600;
                    // alert(intDivGridListHeight + 350 );
                    $("#divmain").css('height', intDivGridListHeight + 220 + "px");
                    $(".DivRightClass").css('height', intDivGridListHeight + 450 + "px");
                    $(".DivLeftClass").css('height', intDivGridListHeight + 450 + "px");
                }
                else 
                {
              
                    intDivGridListHeight = parseInt(window.innerHeight) - 600;
                    // alert(intDivGridListHeight);
                    $(".boxnew").css('height', intDivGridListHeight + 320 + "px");
                    $("#divmain").css('height', intDivGridListHeight + 260 + "px");
                    $(".DivRightClass").css('height', intDivGridListHeight + 200 + "px");
                    $(".DivLeftClass").css('height', intDivGridListHeight + 200 + "px");
                }
            }
           // ResolutionCheck();

            //  alert(intDivGridListHeight);
            // datatableMainPage("divCustomerContact", intDivGridListHeight);
            if (Flag = "ClientContact") 
            {
                Assigndatatables("divAssignType", "AssignType", "")
            }
            $("#header").css("display", "block");
            $("#Spanconfiguration").html(globalCustomFieldName + " >> Custom Fields Details");
           // $("#divSubRequestType").addClass("boxnew");
           // $("#DivRight").addClass("DivRightClass");
            $("#DivLeft").addClass("DivLeftClass");
            //else if (Flag = "ClientContact") {
            //    datatables("divCustomerContact", "", intDivGridListHeight)
            //}
        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });
        //Added By Yasmin on 6th Aug to remove combo box tooltip
        $('option[title]').each(function() { $(this).removeAttr('title'); }); 
    }

    function SaveAssignTypes()
    {
        var data1, strResult1;
        var SelectedAssignType = $('input[id=chkAssignTypeSelect]:checked').map(function ()
        {
            return this.value;
        }).get().join(',');
      

        //Added by Usha Pandit on 30 July 2018 for Custom Field Map Sub Request Type from every page issue
       
        var table = $('#divAssignType table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        SelectedAssignType = $('input[id="chkAssignTypeSelect"]:checked', rows).map(function ()
        {
            return this.value;
        }).get().join(',');      

        //End of Added by Usha Pandit on 30 July 2018 for Custom Field Map Sub Request Type from every page issue

        data1 = JSON.stringify({ SelectedAssignType: SelectedAssignType });
        strResult1 = AJAXCallWithResult("CustomFieldMaintainance.aspx/SaveAssignTypes", data1, false);
        //alert(strResult1.d);
        if (strResult1.d == "1")
        {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Assign Type Save Successfully", 'success');
            RefreshGrid('AssignType');
            Assigndatatables("divAssignType", "AssignType", "300")
        }
        else
        {
        
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Assign Type Save Successfully", 'success');
            RefreshGrid('AssignType');
            Assigndatatables("divAssignType", "AssignType", "300")
        }
    }

    function SaveAccess() {        
        var data1, strResult1, SelectedAccess;
        var table = $('#divAccess table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        SelectedAccess = $('input[id="chkAccess"]:checked', rows).map(function ()
        {
            return this.value;
        }).get().join(',');      
       
        
        var m_strCustomFieldID = $("#txthdnCustomID").val();
      
        data1 = JSON.stringify({ SelectedAccess: SelectedAccess, m_strEntityName: "Help-Desk", m_strCustomFieldID: globalCustomFieldID });
        strResult1 = AJAXCallWithResult("CustomFieldMaintainance.aspx/SaveAccess", data1, false);
      
        if (strResult1.d == "-1") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Configure Access Saved Successfully", 'success');
            RefreshGrid('divAccess');
            datatablesAcess("divAccess", "", "300")
           // document.getElementById('divAccess').style=''
        }

    }
    /*For Insert Value*/
    function ValidateInsert()
    {
        //Added by Usha Pandit on 02 Aug 2018 for min-length and max-length validation 
        var blnIsNonNumeric = false;
        //End of Added by Usha Pandit on 02 Aug 2018 for min-length and max-length validation 
        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"

        var objNewElement, objTextBox, objListBox, objLabel, objValidationRules;
        var intCtr, msg, strObjectCaption;
        var objDataType;
        objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
        objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
        objTextBox = GetObjectReference('frmTaskCustomFields', 'txtValue');
        objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
        objLabel = GetObjectReference('frmTaskCustomFields', 'lblSelectedValue');
        strObjectCaption = "value";

        // Check whether the value to be inserted is blank.
        // if(disallowBlank(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("ENTERINSERTVALUE")%>","<=>", strObjectCaption)))
        // return;
        if (objTextBox.value == "")
        {

            strmsg = '- Please Enter Value.';
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objTextBox);
            checkvalue = 1;
        }

     

        else if(isSubstringExists(objTextBox.value,","))
        {
            strmsg = '- Comma ( , ) is not allowed';
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objTextBox);
            checkvalue = 1;
		   
		   
        }

        else if((isSubstringExists("," + objValidationRules.value + "," ,",3,") == true && objDataType.value==1))
        {
            if (RestrictNonNumeric(document.getElementById('txtValue')) == true)
            {
                // alertify.set('notifier', 'position', 'top-right');
                //Commented and Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                //strmsg = ' - Please Enter only positive numeric value for Validation Rules';
                strmsg = ' - Please Enter only numeric values';
                blnIsNonNumeric = true;
                //End of Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;

            }
        }
        
        //Added by Usha Pandit on 02 Aug 2018 for min-length and max-length validation 
        else if((isSubstringExists("," + objValidationRules.value + "," ,",3,")  == true && objDataType.value==2))
        {
            if (RestrictNonNumeric(document.getElementById('txtValue')) == true)
            {
                // alertify.set('notifier', 'position', 'top-right');
                //Commented and Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                //strmsg = ' - Please Enter only positive numeric value for Validation Rules';
                strmsg = ' - Please Enter only numeric values';
                blnIsNonNumeric = true;
                //End of Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;

            }
        }
     
        if((isSubstringExists("," + objValidationRules.value + "," ,",13,") == true && objDataType.value==1))
        {
            if (disallowNegativeNumeric(document.getElementById('txtValue')) == true)
            {
                // alertify.set('notifier', 'position', 'top-right');
                //Commented and Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                //strmsg = ' - Please Enter only positive numeric value for Validation Rules';
                strmsg = ' - Please Enter only positive numeric values';
              
                //End of Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;

            }
        }

        if((isSubstringExists("," + objValidationRules.value + "," ,",13,")  == true && objDataType.value==2))
        {
            if (disallowNegativeNumeric(document.getElementById('txtValue')) == true)
            {
                // alertify.set('notifier', 'position', 'top-right');
                //Commented and Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                //strmsg = ' - Please Enter only positive numeric value for Validation Rules';
                strmsg = ' - Please Enter only positive numeric values';
              
                //End of Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;

            }
        }

        if((isSubstringExists("," + objValidationRules.value + "," ,",15,")) == true)
        {
            if (disallowSpecialCharacters(document.getElementById('txtValue')) == true)
            {
                strmsg = ' - Combo box cannot contain any of these /\:*?<>|,"+!#%@$- characters as per applied validation rule';                  
          
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;

            }
        }

        if( objDataType.value==1 && blnIsNonNumeric == false)
        {
            var objMinValue = GetObjectReference('frmTaskCustomFields', 'txtMinValue');
            var objMaxValue = GetObjectReference('frmTaskCustomFields', 'txtMaxValue');

            if(objMinValue != null && objMaxValue != null && objMinValue != undefined && objMaxValue != undefined)
            {
                if(objMinValue.value != "")
                {
                    if(parseInt($('#txtValue').val()) < objMinValue.value)
                    {  
                        strmsg = ' - Value ' + objTextBox.value + ' is less than minimum value';
                        errorMsg += "<li>" + strmsg + "</li>";
                        setFocus(objTextBox);
                        checkvalue = 1;                    
                    }
                }
                  
                if(objMaxValue.value != "")
                {
                    if(parseInt($('#txtValue').val()) > objMaxValue.value)
                    {
                        strmsg = ' - Value ' + objTextBox.value + ' is greater than maximum value';
                        errorMsg += "<li>" + strmsg + "</li>";
                        setFocus(objTextBox);
                        checkvalue = 1;                    
                    }
                }
            }
               
        }

        var lstValuecheck = $("#lstValue option").map(function () 
        {
            return $(this).text();
        }).get().join('');
       

        var table = $('#modalbody1 table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();
        var curvalidationrules = $('input[id="chkApply"]:checked', rows).map(function ()
        {
            return this.value;
        }).get().join(','); 
        table.destroy();
        
        if(curvalidationrules == "")
        {
            curvalidationrules = $("#txtValidationRules").val();
        }
        if(isSubstringExists(curvalidationrules, ",9,") || isSubstringExists(curvalidationrules, ",9") || isSubstringExists(curvalidationrules, "9"))
        { 
            if(objDataType.value != 1)
            {
                var curtxtValue = $('#txtValue').val();

                if(curtxtValue != "")
                {
                    if (!curtxtValue.match(/^[a-zA-Z]+$/)) 
                    {
                        strmsg = ' - Please Enter only alphabates for combo box';
                        errorMsg += "<li>" + strmsg + "</li>";
                    
                        checkvalue = 1;
                    }
                }
            }                  
        }
       
        //End of Added by Usha Pandit on 02 Aug 2018 for min-length and max-length validation 

        //Check whether the value to be inserted already exists in the list.
        for(intCtr=0 ; intCtr < objListBox.length ; intCtr++)
        {
            //Replace () with [] and innerHTML with innerHTML
            if(Trim(objListBox.options[intCtr].innerHTML.toUpperCase()) == Trim(objTextBox.value.toUpperCase()))
            {
                //msg = replaceSubstring("<%=Mybase.GetResourceString("VALUEALREADYEXISTS")%>","<=>", strObjectCaption);
                // msg = replaceSubstring(msg, "<==>",objTextBox.value);
                //msg = replaceSubstring(msg, "&#39;","'");
                //alert(msg);
                strmsg = ' - The ' + objTextBox.value + ' already exists';
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;
            }
			
        }
     
        if (strmsg != "") 
        {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;

    }
    
    //Added by Usha Pandit on 01 aug 2018 for update combo field items validation

    function disallowNegativeNumeric(obj){
        if (obj == null) {return false;} 
        if (isBlank(getInputValue(obj))) {return false;}
        var msg=(arguments.length>1)?arguments[1]:"";
        msg=replaceSubstring(msg,"&#39;","'");
        var dofocus=(arguments.length>2)?arguments[2]:true;
        if (disallowNonNumeric(obj,msg,dofocus)) {return true;}
        else if (getInputValue(obj) < 0) {
            //if(!isBlank(msg)){alert(msg);}
            if(dofocus){
                setFocus(obj);
            }
            return true;
        }	
        return false;
    }

    function disallowSpecialCharacters(obj)
    {
        if (obj == null) {return false;} 
        if (isBlank(getInputValue(obj))) {return false;}
        var msg=(arguments.length>1)?arguments[1]:"";
        msg=replaceSubstring(msg,"&#39;","'");
        var dofocus=(arguments.length>2)?arguments[2]:true;
        var spChars=(arguments.length>3)?arguments[3]:"[/:*?+!#%@$\"><|,\\\\]";
        if (hasSpecialCharacters(getInputValue(obj),spChars)) {
            //if(!isBlank(msg)){alert(msg);}
            if(dofocus){
                setFocus(obj);
            }
            return true;
        }	
        return false;
    }

    function ValidateUpdate(intSelectedIndex)
    {
        //Added by Usha Pandit on 02 Aug 2018 for min-length and max-length validation 
        var blnIsNonNumeric = false;
        //End of Added by Usha Pandit on 02 Aug 2018 for min-length and max-length validation 
      
        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"

        var objNewElement, objTextBox, objListBox, objLabel, objValidationRules;
        var intCtr, msg, strObjectCaption;
        var objDataType;
        objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
        objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
        objTextBox = GetObjectReference('frmTaskCustomFields', 'txtValue');
        objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
        objLabel = GetObjectReference('frmTaskCustomFields', 'lblSelectedValue');
        strObjectCaption = "value";

        // Check whether the value to be inserted is blank.
        // if(disallowBlank(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("ENTERINSERTVALUE")%>","<=>", strObjectCaption)))
        // return;
        if (objTextBox.value == "")
        {

            strmsg = '- Please Enter Value.';
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objTextBox);
            checkvalue = 1;
        }

     

        else if(isSubstringExists(objTextBox.value,","))
        {
            strmsg = '- Comma ( , ) is not allowed';
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objTextBox);
            checkvalue = 1;
		   
		   
        }

        else if((isSubstringExists("," + objValidationRules.value + "," ,",3,") || objDataType.value==1) == true)
        {
            if (RestrictNonNumeric(document.getElementById('txtValue')) == true)
            {
                // alertify.set('notifier', 'position', 'top-right');
                //Commented and Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                //strmsg = ' - Please Enter only positive numeric value for Validation Rules';
                strmsg = ' - Please Enter only numeric values';
                blnIsNonNumeric = true;
                //End of Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;

            }
        }
		
        //Added by Usha Pandit on 02 Aug 2018 for min-length and max-length validation 

        if((isSubstringExists("," + objValidationRules.value + "," ,",13,") && objDataType.value==1) == true)
        {
            if (disallowNegativeNumeric(document.getElementById('txtValue')) == true)
            {
                // alertify.set('notifier', 'position', 'top-right');
                //Commented and Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                //strmsg = ' - Please Enter only positive numeric value for Validation Rules';
                strmsg = ' - Please Enter only positive numeric values';
              
                //End of Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;

            }
        }

        if((isSubstringExists("," + objValidationRules.value + "," ,",13,") && objDataType.value==2) == true)
        {
            if (disallowNegativeNumeric(document.getElementById('txtValue')) == true)
            {
                // alertify.set('notifier', 'position', 'top-right');
                //Commented and Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                //strmsg = ' - Please Enter only positive numeric value for Validation Rules';
                strmsg = ' - Please Enter only positive numeric values';
              
                //End of Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;

            }
        }

        if((isSubstringExists("," + objValidationRules.value + "," ,",15,")) == true)
        {
            if (disallowSpecialCharacters(document.getElementById('txtValue')) == true)
            {
                strmsg = ' - Combo box cannot contain any of these /\:*?<>|,"+!#%@$- characters as per applied validation rule';              
          
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;

            }
        }

        if( objDataType.value==1 && blnIsNonNumeric == false)
        {
            var objMinValue = GetObjectReference('frmTaskCustomFields', 'txtMinValue');
            var objMaxValue = GetObjectReference('frmTaskCustomFields', 'txtMaxValue');

            if(objMinValue != null && objMaxValue != null && objMinValue != undefined && objMaxValue != undefined)
            {
                if(objMinValue.value != "")
                {
                    if(parseInt($('#txtValue').val()) < objMinValue.value)
                    {  
                        strmsg = ' - Value ' + objTextBox.value + ' is less than minimum value';
                        errorMsg += "<li>" + strmsg + "</li>";
                        setFocus(objTextBox);
                        checkvalue = 1;                    
                    }
                }
                  
                if(objMaxValue.value != "")
                {
                    if(parseInt($('#txtValue').val()) > objMaxValue.value)
                    {
                        strmsg = ' - Value ' + objTextBox.value + ' is greater than maximum value';
                        errorMsg += "<li>" + strmsg + "</li>";
                        setFocus(objTextBox);
                        checkvalue = 1;                    
                    }
                }
            }
               
        }
        //End of Added by Usha Pandit on 02 Aug 2018 for min-length and max-length validation 
       

        var lstValuecheck = $("#lstValue option").map(function () 
        {
            return $(this).text();
        }).get().join('');
       

        var table = $('#modalbody1 table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();
        var curvalidationrules = $('input[id="chkApply"]:checked', rows).map(function ()
        {
            return this.value;
        }).get().join(','); 
        table.destroy();
        
        if(curvalidationrules == "")
        {
            curvalidationrules = $("#txtValidationRules").val();
        }
        if(isSubstringExists(curvalidationrules, ",9,") || isSubstringExists(curvalidationrules, ",9") || isSubstringExists(curvalidationrules, "9"))
        { 
            if(objDataType.value != 1)
            {
                var curtxtValue = $('#txtValue').val();

                if(curtxtValue != "")
                {
                    if (!curtxtValue.match(/^[a-zA-Z]+$/)) 
                    {
                        strmsg = ' - Please Enter only alphabates for combo box';
                        errorMsg += "<li>" + strmsg + "</li>";
                    
                        checkvalue = 1;
                    }
                }
            }                     
        }


        //Check whether the value to be inserted already exists in the list.
        for(intCtr=0 ; intCtr < objListBox.length ; intCtr++)
        { 
            //Replace () with [] and innerHTML with innerHTML
            if(Trim(objListBox.options[intCtr].innerHTML.toUpperCase()) == Trim(objTextBox.value.toUpperCase()) && intCtr != intSelectedIndex )
            {
                //msg = replaceSubstring("<%=Mybase.GetResourceString("VALUEALREADYEXISTS")%>","<=>", strObjectCaption);
                // msg = replaceSubstring(msg, "<==>",objTextBox.value);
                //msg = replaceSubstring(msg, "&#39;","'");
                //alert(msg);
                strmsg = ' - The ' + objTextBox.value + ' already exists';
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objTextBox);
                checkvalue = 1;
            }
			
        }
     
        if (strmsg != "") 
        {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;

    }
    //End of Added by Usha Pandit on 01 aug 2018 for update combo field items validation

    function InsertValue_OnClick() {
       

        var objNewElement, objTextBox, objListBox, objLabel, objValidationRules;
        var intCtr, msg, strObjectCaption;
        var objDataType;
        objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
        objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
        objTextBox = GetObjectReference('frmTaskCustomFields', 'txtValue');
        objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
        objLabel = GetObjectReference('frmTaskCustomFields', 'lblSelectedValue');
        strObjectCaption = "value";

        if (ValidateInsert() == 0)
        {
            objNewElement = document.createElement("OPTION");


            if (navigator.appName == 'Netscape')
                objNewElement.innerHTML = objTextBox.value;
            else
                objNewElement.innerHTML = objTextBox.value;


            objNewElement.value = objTextBox.value;
            objListBox.appendChild(objNewElement);

            objTextBox.value = "";
            setFocus(objTextBox);

        }

    }

   
    function Delete_OnClick()
    {
        var objchkDelete, blnSelected, intCnt, objAction;

        objchkDelete = GetObjectReference('frmTaskCustomeFields', 'chkCustomDelete', true);
        if (objchkDelete == null)
        {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Select at least one Record for Deletion", 'error', 15);
		    return;
		}
        blnSelected = false;
        if (objchkDelete.length == 1) {
            objchkDelete = GetObjectReference('frmTaskCustomeFields', 'chkCustomDelete');
            if (objchkDelete.checked == true)
                blnSelected = true;
        }
        else if (objchkDelete.length > 1)
        {
            for (intCnt = 0; ((intCnt < objchkDelete.length) && (blnSelected == false)) ; intCnt++)
            {

                if (objchkDelete[intCnt].checked == true)
                    blnSelected = true;
            }
        }
        if (blnSelected == false)
        {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Select at least one Record for Deletion", 'error', 15);
            return;
        }

        else {
           
            var data1, strResult1;
            var SelectedDeleteContrl = $('input[id=chkCustomDelete]:checked').map(function () {
                return this.value;
            }).get().join(',');

            data1 = JSON.stringify({ SelectedDeleteContrl: SelectedDeleteContrl });
            strResult1 = AJAXCallWithResult("CustomFieldMaintainance.aspx/DeleteCustomFieldList", data1, false);

            if (strResult1.d == "1")
            {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Records Delete Successfully", 'success');
                RefreshGrid('Type');
            }
        }
		   // objForm.submit();
        //}
    }
    /*For Delete Value*/

    function validateDeleteValue() {

        var objElement, objTextBox, objListBox, objLabel, objDefaultValue;
        var intCtr, msg, strObjectCaption, intSelectedIndex;

        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"


        objTextBox = GetObjectReference('frmTaskCustomFields', 'txtValue');
        objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
        objLabel = GetObjectReference('frmTaskCustomFields', 'lblSelectedValue');
        strObjectCaption = "value";
        objLabel.innerHTML = "";
        objDefaultValue = GetObjectReference('frmTaskCustomFields', 'txtDefaultValue');

        if (objListBox.selectedIndex == -1) {
            strmsg = ' - Please select the values for deletion';
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objListBox);
            checkvalue = 1;


        }

        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;

    }

    function DeleteValue_OnClick()
    {
        var objElement, objTextBox, objListBox, objLabel, objDefaultValue;
        var intCtr, msg, strObjectCaption, intSelectedIndex;
        objTextBox = GetObjectReference('frmTaskCustomFields', 'txtValue');
        objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
        objLabel = GetObjectReference('frmTaskCustomFields', 'lblSelectedValue');
        strObjectCaption = "value";
        objLabel.innerHTML = "";
        objDefaultValue = GetObjectReference('frmTaskCustomFields', 'txtDefaultValue');
        

        if (validateDeleteValue() == 0)
        {

            //if (!confirm("Are you sure you want to delete the selected records?"))
            //    checkvalue = 1;

            intSelectedIndex = -1;
            while (objListBox.selectedIndex != -1) {

                if (navigator.appName == 'Netscape') {
                    if (objListBox.options[objListBox.selectedIndex].innerHTML == objDefaultValue.value) {
                        objDefaultValue.value = "";

                    }
                    objListBox.remove(objListBox.selectedIndex);
                }
                else {
                    if (objListBox.options[objListBox.selectedIndex].innerHTML == objDefaultValue.value) {
                        objDefaultValue.value = "";

                    }
                    objListBox.remove(objListBox.selectedIndex);

                }

            }
        }
       

       
    }

    /*For Update Value*/
    function validatedUpadte() {

        var checkvalue = 0;
        var Flag = 0;

        var strmsg = "";
        var errorMsg = "<ul>"

        var objTextBox, objListBox, objLabel, objDataType, objValidationRules;
        var intCtr, msg, strObjectCaption, intSelectedIndex;
        objTextBox = GetObjectReference('frmTaskCustomFields', 'txtValue');
        objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
        objLabel = GetObjectReference('frmTaskCustomFields', 'lblSelectedValue');
        objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
        objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
        strObjectCaption = "value";
        intSelectedIndex = objListBox.selectedIndex;

        if (intSelectedIndex == -1) {

            strmsg = ' - Please select the  for updating' + strObjectCaption;
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objListBox);
            checkvalue = 1;

        }



            // if (disallowBlank(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("NEWVALUEFORUPDATION")%>", "<=>", strObjectCaption)))
            //return;
        else if (objTextBox.value == "") {

            strmsg = ' - Please enter the for updating' + "<=>" + strObjectCaption;
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objListBox);
            checkvalue = 1;

        }


        else if (isSubstringExists(objTextBox.value, ",")) {

            strmsg = '- Comma ( , ) is not allowed';
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objListBox);
            checkvalue = 1;

        }

        else if ((isSubstringExists("," + objValidationRules.value + ",", ",3,") || objDataType.value == 1) == false) {


            if (RestrictNonNumeric(document.getElementById('txtValue')) == true) {

                strmsg = ' - Please enter only Numeric values for list';
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objListBox);
                checkvalue = 1;

            }
        }

        for (intCtr = 0 ; intCtr < objListBox.length ; intCtr++) {


            if (Trim(objListBox.options[intCtr].innerHTML.toUpperCase()) == Trim(objTextBox.value.toUpperCase())) {
                if ((intCtr != intSelectedIndex) && (intCtr != objListBox.length)) {

                    strmsg = ' - The  already exists';
                    errorMsg += "<li>" + strmsg + "</li>";
                    setFocus(objListBox);

                    checkvalue = 1;
                }
            }
        }

        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;
    }

    function UpdateValue_OnClick()
    {
        var checkvalue = 0;
        var objTextBox, objListBox, objLabel, objDataType, objValidationRules;
        var intCtr, msg, strObjectCaption, intSelectedIndex;
        objTextBox = GetObjectReference('frmTaskCustomFields', 'txtValue');
        objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
        objLabel = GetObjectReference('frmTaskCustomFields', 'lblSelectedValue');
        objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
        objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
        strObjectCaption = "value";
        intSelectedIndex = objListBox.selectedIndex;

        //Commented and Added by Usha Pandit on 01 Aug 2018 for update combo field items validation
        //if (checkvalue == 0)
        //{
        if (ValidateUpdate(intSelectedIndex) == 0)
            {
                //End of Added by Usha Pandit on 01 Aug 2018 for update combo field items validation
            if (navigator.appName == 'Netscape') {
                objListBox.options[intSelectedIndex].innerHTML = objTextBox.value;
                objListBox.options[intSelectedIndex].value = objTextBox.value;
                objTextBox.value = "";
            }
            else {
                objListBox.options[intSelectedIndex].innerHTML = objTextBox.value;
                objListBox.options[intSelectedIndex].value = objTextBox.value;
                objTextBox.value = "";
            }


            //objLabel.innerHTML = "Selected" + strObjectCaption;
            //objLabel.innerHTML = objLabel.innerHTML + " : <B>" + objListBox.options[objListBox.selectedIndex].innerHTML
            //objLabel.innerHTML = objLabel.innerHTML + "</B>&nbsp;&nbsp;&nbsp;|&nbsp;";
            //objLabel.innerHTML = objLabel.innerHTML + "<A style='TEXT-DECORATION: none' HREF='javascript:SetAsDefault_OnClick()'>";
            //objLabel.innerHTML = objLabel.innerHTML + "<FONT size=1 face=verdana color=black>";
            //objLabel.innerHTML = objLabel.innerHTML + "<B>Set As Default</B>";
            //objLabel.innerHTML = objLabel.innerHTML + "</FONT>";
            //objLabel.innerHTML = objLabel.innerHTML + "</A>&nbsp;|";


            //Commented and Added by Usha Pandit on 06 Aug 2018 for set as default link
            //objLabel.innerHTML = "Selected " + strObjectCaption;
            //objLabel.innerHTML = objLabel.innerHTML + " : <B>" + objListBox.options[objListBox.selectedIndex].innerHTML 
            //objLabel.innerHTML = objLabel.innerHTML + "</B>&nbsp;&nbsp;&nbsp;|";
            //objLabel.innerHTML = objLabel.innerHTML + "<A style='TEXT-DECORATION: none' HREF='javascript:SetAsDefault_OnClick()'>";
            //objLabel.innerHTML = objLabel.innerHTML + "<FONT size=1 face=verdana color=black>";
            //objLabel.innerHTML = objLabel.innerHTML + "<B>Set As Default</B>";
		    //objLabel.innerHTML = objLabel.innerHTML + "</FONT>";
		    //objLabel.innerHTML = objLabel.innerHTML + "</A>|";

            strTemp = "";
            strTemp = "Selected " + strObjectCaption;
            strTemp = strTemp + " : <B>" + objListBox.options[objListBox.selectedIndex].innerHTML;
            strTemp = strTemp + "</B>&nbsp;&nbsp;&nbsp;|";
            strTemp = strTemp + "<A style='TEXT-DECORATION: none' HREF='javascript:SetAsDefault_OnClick()'>";
            strTemp = strTemp + "<FONT size=1 face=verdana color=black>";
            strTemp = strTemp + "<B>Set As Default</B>";
            strTemp = strTemp + "</FONT>";
            objLabel.innerHTML = strTemp + "</A>|";

            //End of Added by Usha Pandit on 06 Aug 2018 for set as default link


        }
		
    }

    /*Select value From ListBox*/

    function SelectElement_OnClick(strValueType)
    {
        var objTextBox, objListBox, objLabel, objDefaultValue;
        var strObjectCaption, intSelectedValue, strTemp;

        objTextBox = GetObjectReference('frmTaskCustomFields', 'txtValue');

        if (strValueType == 'C') {
            objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
            objLabel = GetObjectReference('frmTaskCustomFields', 'lblSelectedValue');
        }
        else
            objListBox = GetObjectReference('frmTaskCustomFields', 'lstValueQ');
        strObjectCaption = "value";
        intSelectedValue = objListBox.selectedIndex;
        if (intSelectedValue < 0)
            return;
        objTextBox.value = objListBox.options[objListBox.selectedIndex].innerHTML;
        if (strValueType == 'Q') {
            objDefaultValue = GetObjectReference('frmTaskCustomFields', 'txtDefaultValue');


            if (navigator.appName == 'Netscape')
                objDefaultValue.value = objListBox.options[objListBox.selectedIndex].innerHTML;
            else
                objDefaultValue.value = objListBox.options[objListBox.selectedIndex].innerHTML;

        }
        else {
            //strTemp = "";
            //strTemp = "Selected " + strObjectCaption;
			//strTemp = strTemp + " : <B>" + objListBox.options[objListBox.selectedIndex].innerHTML;
			//strTemp = strTemp + "</B>&nbsp;&nbsp;&nbsp;";
			//strTemp = strTemp + "<A style='TEXT-DECORATION: none' HREF='javascript:SetAsDefault_OnClick()'>";
			//strTemp = strTemp + "<FONT size=1 face=verdana color=black>";
			//strTemp = strTemp + "<Set As Default";
			//strTemp = strTemp + "</FONT>";
			//objLabel.innerHTML = strTemp + "</A>";

			strTemp = "";
			strTemp = "Selected " + strObjectCaption;
            strTemp = strTemp + " : <B>" + objListBox.options[objListBox.selectedIndex].innerHTML;
            strTemp = strTemp + "</B>&nbsp;&nbsp;&nbsp;|";
            strTemp = strTemp + "<A style='TEXT-DECORATION: none' HREF='javascript:SetAsDefault_OnClick()'>";
            strTemp = strTemp + "<FONT size=1 face=verdana color=black>";
            strTemp = strTemp + "<B>Set As Default</B>";
			strTemp = strTemp + "</FONT>";
			objLabel.innerHTML = strTemp + "</A>|";

			setFocus(objTextBox);
        }
    }

    function SetAsDefault_OnClick() {
        var objListBox, objDefaultValue;
       
        objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
        objDefaultValue = GetObjectReference('frmTaskCustomFields', 'txtDefaultValue');
        //alert(objListBox.options[objListBox.selectedIndex].innerHTML);
        //alert(objDefaultValue.value);
        objDefaultValue.value = objListBox.options[objListBox.selectedIndex].innerHTML;
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


    function validation() {
        //alert(globalCustomFieldID);
       // debugger;
        var checkvalue = 0;
        var Flag = 0;

        var strmsg = "";
        var errorMsg = "<ul>"

        var i, objAction;
        var objUserGivenCaption, objCFList, objFieldList, objRowNumber, objColumnNumber, objDataType;
        var objControlHeight, objControlWidth, objMaxLength, objMaxValue,objtxtMaxLength, objMinValue;
        var objOrderNoList, objDBFieldName, objlstValue, objoptComboValue, objDefaultValue;
        var objValidationRules, strValidation = '', objQuery;
        objtxtMaxLength = GetObjectReference('frmTaskCustomFields', 'txtMaxLength');
        objUserGivenCaption = GetObjectReference('frmTaskCustomFields', 'txtUserGivenCaption');
       // objUserGivenCaption = document.getElementById('objUserGivenCaption');
       // if (disallowBlank(objUserGivenCaption, "<%=MyBase.GetResourceString("ENTERCONTROLCAPTION")%>"))
		   // return;
        if (objUserGivenCaption.value=="")
        {
            strmsg = ' - Please enter the control caption';
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objUserGivenCaption);
           
            checkvalue = 1;
        
        }

       else if (isSubstringExists(objUserGivenCaption.value, ","))
        {
            strmsg = ' - Comma ( , ) is not allowed';
            errorMsg += "<li>" + strmsg + "</li>";
          
		    setFocus(objUserGivenCaption);
		    checkvalue = 1;
		}


        else if (isSubstringExists(Trim(objUserGivenCaption.value.toUpperCase()), 'ORDER BY')) {
            strmsg = '- Value of custom field caption cannot be Order By';
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objUserGivenCaption);
            checkvalue = 1
            
        }


        // objCFList = GetObjectReference('frmTaskCustomFields', 'txthidCFList');
        //objUserCaption = GetObjectReference('frmTaskCustomFields', 'txtDatabaseFieldName');
        //var objCFList = $("#txthidCFList").val();
       
        //if (isSubstringExists("," + objCFList + ",", "," + objUserGivenCaption.value + ","))
        //{
        //    strmsg = ' - Control caption already exists' +  "<=>" +  objUserCaption.value ;
        //    errorMsg += "<li>" + strmsg + "</li>";
        //    setFocus(objUserGivenCaption);
        //    checkvalue = 1
           
        //}


        //objFieldList = GetObjectReference('frmTaskCustomFields', 'txthidFieldList');
        var objFieldList = $("#txthidFieldList").val();
      
        if (isSubstringExists(objFieldList, "," + objUserGivenCaption.value + ","))
        {

            strmsg = ' -' + objUserGivenCaption.value + 'This is a standard attribute of Issue, and cannot be used as a custom field caption'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objUserGivenCaption);
            checkvalue = 1

           // alert("'" + objUserGivenCaption.value + "' This is a standard attribute of Issue, and cannot be used as a custom field caption");
           // setFocus(objUserGivenCaption);
           // return;
        }

        // objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
        objDataType = document.getElementById('cboDataType');
        if ($("#cboDataType").val() == "")
        {

            strmsg = ' - Please select the appropriate data type'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objDataType);
            checkvalue = 1
        }
        //objRowNumber = document.getElementById('txtRowNumber');
        objRowNumber = GetObjectReference('frmTaskCustomFields', 'txtRowNumber');
        if ($("#txtRowNumber").val() == "") {

            strmsg = ' - Please enter the row number'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objRowNumber);
            checkvalue = 1
        }

        else if (disallowNegativeInteger(objRowNumber, "") == true) 
        {
            strmsg = ' - Please enter the appropriate value'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objRowNumber);
            checkvalue = 1

        }
        else if ($("#txtRowNumber").val() == 0) 
        {

            strmsg = ' - Please enter the appropriate value'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objRowNumber);
            checkvalue = 1

            //alert("Please enter the appropriate value");
            //setFocus(objRowNumber);
            //return;
        }
        objColumnNumber = document.getElementById('txtColumnNumber');
        objColumnNumber = GetObjectReference('frmTaskCustomFields', 'txtColumnNumber');
        if ($("#txtColumnNumber").val() == "") {

            strmsg = ' - Please enter the column number'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objColumnNumber);
            checkvalue = 1
        }
       
        else if (disallowNegativeInteger(objColumnNumber, "") == true) {
            strmsg = ' - Please enter the appropriate value'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objColumnNumber);
            checkvalue = 1

        }
        else if ((objColumnNumber.value > 2) || (objColumnNumber.value <= 0))
        {
            strmsg = ' - Please enter the column number in the range (1-2)'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objColumnNumber);
            checkvalue = 1
           // alert("Please enter the column number in the range (1-2)");
           // setFocus(objColumnNumber);
            //return;
        }

        objControlHeight = document.getElementById('txtControlHeight');
       // objControlHeight = GetObjectReference('frmTaskCustomFields', 'txtControlHeight');
        objControlHeight = $("#txtControlHeight")
        if (disallowNegativeInteger(objControlHeight, "") == true) {
            strmsg = ' - Please enter the appropriate value for Control Height'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objControlHeight);
            checkvalue = 1

        }
        objControlWidth = document.getElementById('txtControlWidth');
       // objControlWidth = GetObjectReference('frmTaskCustomFields', 'txtControlWidth');
        objControlWidth = $("#txtControlWidth")
        if (disallowNegativeInteger(objControlWidth, "") == true) {
            strmsg = ' - Please enter the appropriate value for Control Width'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objControlWidth);
            checkvalue = 1

        }

       
        objMaxLength = document.getElementById('txtMaxLength');
      //  objMaxLength = GetObjectReference('frmTaskCustomFields', 'txtMaxLength');
        if (disallowNegativeInteger(objMaxLength, "") == true) {
            strmsg = ' - Please enter the appropriate value For MaxLength'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objMaxLength);
            checkvalue = 1

        }
        objMinValue = GetObjectReference('frmTaskCustomFields', 'txtMinValue');
        var blnMinValidationCheck = false;
            objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
            
            if(objMinValue != undefined && objMinValue != null)
            {
                if(objMinValue.value == " ")
                {
                    objMinValue.value = "";
                }
            }
            
            if (disallowNegativeInteger(objMinValue, "") == true && isSubstringExists("," + objValidationRules.value + ",", ",13,") == true && isSubstringExists("," + objValidationRules.value + ",", ",3,") == false) {
                blnMinValidationCheck=true;
                strmsg = ' - Please enter a valid minimum value '
                errorMsg += "<li>" + strmsg + "</li>";
                setFocus(objMinValue);
                checkvalue = 1

            }
            if(objMinValue != undefined && objMinValue != null)
            {
                
                if(objMinValue.value != "")
                {   
                    if (RestrictNonNumeric(objMinValue) == true)
                    {
                        if(blnMinValidationCheck == false)
                        {
                            strmsg = ' - Please enter a valid minimum value';
                            errorMsg += "<li>" + strmsg + "</li>";
                            setFocus(objMinValue);
                            checkvalue = 1;
                        }
                    }                
                }
            }
      
       
        objMaxValue = document.getElementById('txtMaxValue');
        //objMaxValue = GetObjectReference('frmTaskCustomFields', 'txtMaxValue');
        //Added by Usha Pandit on 30 July 2018 for CustomField save issue
        if(objMaxValue != undefined && objMaxValue != null)
        {
            //End of Added by Usha Pandit on 30 July 2018 for CustomField save issue

            var blnMaxValidationCheck = false;
            if(objMaxValue.value!="")
            {
                objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
                if (disallowNegativeInteger(objMaxValue, "") == true && isSubstringExists("," + objValidationRules.value + ",", ",13,") == true && isSubstringExists("," + objValidationRules.value + ",", ",3,") == false) 
       
                    //if(disallowNegativeInteger(document.getElementById('txtMaxValue')) == true)
                {
                    blnMaxValidationCheck = true;
                    strmsg = ' - Please enter a valid maximum value'
                    errorMsg += "<li>" + strmsg + "</li>";
                    setFocus(objMaxValue);
                    checkvalue = 1

                }
            }
            //Added by Usha Pandit on 30 July 2018 for CustomField save issue
            if(objMaxValue.value != "")
            {   
                if (RestrictNonNumeric(objMaxValue) == true)
                {
                    if(blnMaxValidationCheck == false)
                    {
                        strmsg = ' - Please enter a valid maximum value';
                        errorMsg += "<li>" + strmsg + "</li>";
                        setFocus(objMaxValue);
                        checkvalue = 1;
                    }
                }                
            }

        }
        //End of Added by Usha Pandit on 30 July 2018 for CustomField save issue
        objOrderNoList = GetObjectReference('frmTaskCustomFields', 'txthidOrderNoList');
        if (isSubstringExists("," + objOrderNoList.value + ",", "," + objRowNumber.value)) {
            strmsg = ' - Row number already exist'
            errorMsg += "<li>" + strmsg + "</li>";
            setFocus(objRowNumber);
            checkvalue = 1
            //alert("Row number and column number already exist");
            //setFocus(objRowNumber);
            //return;
        }
     
        //  objlstValue = GetObjectReference('frmTaskCustomFields', 'lstValue');
        objlstValue = GetObjectReference('frmTaskCustomFields', 'lstValue'); //document.getElementById('lstValue');
        objoptComboValue = GetObjectReference('frmTaskCustomFields', 'optComboValue', true);

        objDBFieldName = GetObjectReference('frmTaskCustomFields', 'txtDatabaseFieldName');
        if (isSubstringExists(objDBFieldName.value, "CustomFieldCombo"))
        {

            //Replace () with [] 
          
            //Added by usha Pandit on 03 Aug 2018 for tab change, validation missing to add combo box values
            if(objlstValue == null)
            {
                openCity4(event, "Tab1");
                objlstValue = GetObjectReference('frmTaskCustomFields', 'lstValue'); //document.getElementById('lstValue');
            }
            //End of Added by usha Pandit on 03 Aug 2018 for tab change, validation missing to add combo box values
            if(objlstValue != null)
            {
                if ((objlstValue.length == 0) && (objoptComboValue[0].checked == true))
                {
                    strmsg = ' - Please add at least one value for this combobox'
                    errorMsg += "<li>" + strmsg + "</li>";
                    document.getElementById("txtValue").focus();
                    checkvalue = 1
                    //alert("Please add at least one value for this combobox");
                    //setFocus(objlstValue);
                    //return;
                }
            }
        }

        objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
        objDefaultValue = GetObjectReference('frmTaskCustomFields', 'txtDefaultValue');
        if ($("#txtDefaultValue").val() == 1)
            //if (disallowNonNumeric(objDefaultValue, "Please enter numeric default value"))
            //return;
            //if (RestrictNonNumeric(document.getElementById('txtDefaultValue')) == true)
            //{
            //    // alertify.set('notifier', 'position', 'top-right');
            //    strmsg = ' - Please enter numeric default value';
            //    errorMsg += "<li>" + strmsg + "</li>";
            //    //alertify.notify('', 'error');
            //    checkvalue = 1;

            //}
        //alert(objDBFieldName.value);
       

        objDataType = $("#cboDataType").val();
        objDefaultValue = document.getElementById('txtDefaultValue');
        if (isSubstringExists(objDBFieldName.value, "CustomFieldCombo"))
        {
            if(objlstValue != null)
            {
                //Replace () with [] 
                if (objoptComboValue[0].checked == true) {

                    for (i = 0; i < objlstValue.length; i++)
                    {
                        if (isSubstringExists("," + objValidationRules.value + ",", ",3,") || objDataType == 1)

                            if (!isNumeric(objlstValue[i].value))
                            {
                                strmsg = ' - Please enter only Numeric values for list'
                                errorMsg += "<li>" + strmsg + "</li>";
                                // setFocus(objlstValue);
                                checkvalue = 1
                                break;
                                // alert("Please enter only Numeric values for list");
                                //return;
                            }


                    }

                    if (objDefaultValue.value != "") {
                        for (i = 0; i < objlstValue.length; i++) {

                            //Replace () with [] 
                            if (objlstValue[i].value == objDefaultValue.value)
                                break;
                        }
                        if (i == objlstValue.length) 
                        {
                            objDefaultValue.value = "";
                            strmsg = ' - Please enter the appropriate default value'
                            errorMsg += "<li>" + strmsg + "</li>";
                            // setFocus(objlstValue);
                            checkvalue = 1
                            //alert("Please enter the appropriate default value");
                            setFocus(objDefaultValue);
                            //return;
                        }
                    }
                }
            }
        }
        //if (isSubstringExists(objDBFieldName.value, "CustomFieldDate")){
        //    if (isDate(document.getElementById('txtDefaultValue')) == false) {
        //        strmsg = ' - Please enter the default value in the date format';
        //        errorMsg += "<li>" + strmsg + "</li>";
        //        //alertify.notify('', 'error');
        //        checkvalue = 1;               
        //    }
        //}        
        //alert(document.getElementById("cboDataType").value);
        if (isSubstringExists(objDBFieldName.value, "CustomFieldText")){
            if ((RestrictNonNumeric(document.getElementById('txtDefaultValue')) == true)&& (document.getElementById("cboDataType").value ==1))
            {           
                strmsg = ' - Please enter numeric default value';
                errorMsg += "<li>" + strmsg + "</li>";         
                checkvalue = 1;
            }
        }
        if (isSubstringExists(objDBFieldName.value, "CustomFieldArea")){
            if ((RestrictNonNumeric(document.getElementById('txtDefaultValue')) == true)&& (document.getElementById("cboDataType").value ==1))
            {           
                strmsg = ' - Please enter numeric default value';
                errorMsg += "<li>" + strmsg + "</li>";         
                checkvalue = 1;
            }
        }
        if (isSubstringExists(objDBFieldName.value, "CustomFieldNumeric")){
            if ((RestrictNonNumeric(document.getElementById('txtDefaultValue')) == true)&& (document.getElementById("cboDataType").value ==1))
            {           
                strmsg = ' - Please enter numeric default value';
                errorMsg += "<li>" + strmsg + "</li>";         
                checkvalue = 1;
            }
        }

        var blnMaxValueAlert = false ;
        var objDataType = document.getElementById('cboDataType');
            //$("#cboDataType").val()
        if (objValidationRules)
            strValidation = "," + objValidationRules.value + ",";
        else
            strValidation = "";
        if ((isSubstringExists(strValidation, ",18,")) || (isSubstringExists(strValidation, ",16,")) || (isSubstringExists(strValidation, ",17,")))
        {
            if (objDataType.value != 1)
            {
                objDefaultValue.value = "";
                strmsg = ' - The field data type must be numeric'
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1
                setFocus(objDataType);
               
            }
           
           
            if (isSubstringExists(strValidation, ",18,") == true)
            {

                if(objMinValue != undefined && objMinValue != null)
                {
                    if(objMinValue.value == " ")
                    {
                        objMinValue.value = "";
                    }
                }

                if(objMaxValue != undefined && objMaxValue != null)
                {
                    if(objMaxValue.value == " ")
                    {
                        objMaxValue.value = "";
                    }
                }

                if ((objMinValue != null) && (objMinValue.value ==""))
                {
                        strmsg = ' - Please enter a valid minimum value'
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1
                        setFocus(objMinValue);

                }
                  
                //if ((objMaxValue != null) && (disallowBlank(objMaxValue, "Please enter a valid maximum value")))
                // return;
                else if ((objMaxValue != null) && (objMaxValue.value == "")) 
                {
                    strmsg = ' - Please enter a valid maximum value'
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1
                    setFocus(objMaxValue);
                    blnMaxValueAlert = true;
                }


            }
            else if (isSubstringExists(strValidation, ",16,") == true)
            {
                //if ((objMinValue != null) && (disallowBlank(objMinValue, "Please enter a valid minimum value")))
                // return;

                if ((objMinValue != null) && (objMinValue.value == "")) {
                    strmsg = ' - Please enter a valid minimum value'
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1
                    setFocus(objMinValue);

                }

            }
             if (isSubstringExists(strValidation, ",17,") == true) {
               // if ((objMaxValue != null) && (disallowBlank(objMaxValue, "Please enter a valid maximum value")))
                 // return;

                 if(objMaxValue != undefined && objMaxValue != null)
                 {
                     if(objMaxValue.value == " ")
                     {
                         objMaxValue.value = "";
                     }
                 }

                 if ((objMaxValue != null) && (objMaxValue.value == "") && blnMaxValueAlert==false) {
                     strmsg = ' - Please enter a valid maximum value'
                     errorMsg += "<li>" + strmsg + "</li>";
                     checkvalue = 1
                     // setFocus(objDataType);

                 }

            }
        }
       
        if ((objMaxLength != null) && (objMaxLength.value != ""))
        {
           

            if (isSubstringExists(objDBFieldName.value.toUpperCase(), "CUSTOMFIELDTEXTAREA") == true)
            {
                //if (disallowValueRangeViolation(objMaxLength, 1, 3800, replaceSubstring("The maximum length for this field should be in the range (1-<=MAX>)", "<=MAX>", "3800")))
                //    return;
                //if($(objMaxLength))
              
                if (objMaxLength.value > 3800) {

                    strmsg = ' - The maximum length for this field should be in the range (1-3800)'
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1
                    setFocus(objQuery);

                }
               

            }
           

        }
        //Pending
       
        if ((objMinValue  != null) && (objMaxValue  != null))
        {
            // (disallowValue1LessThanValue2(objMaxValue, objMinValue, "Please enter a &#39;maximum value&#39; greater than &#39;minimum value&#39;")))

            if(objMinValue.value != "" )
            {
                if(objMinValue.value > parseInt(objMaxValue.value))
                {
            
                    strmsg = ' - Please enter a maximum value greater than minimum value'
                    errorMsg += "<li>" + strmsg + "</li>";
                    setFocus(objMinValue);
                    checkvalue = 1
                }
            }
        
        }
           

        


        if ((isSubstringExists(strValidation, ",12,")) && (isSubstringExists(objDBFieldName.value, "CustomFieldCombo") == false))
        {
            //Added by Usha Pandit on 01 Aug 2018 for checking undefined field
            if ((objtxtMaxLength != null) && (objtxtMaxLength  != undefined))
            {
                //End of Added by Usha Pandit on 01 Aug 2018 for checking undefined field
                if ((objtxtMaxLength.value != null) && (objtxtMaxLength.value == ""))
                {
                    strmsg = ' - Please enter maximum length'
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1
                    // setFocus(objDataType);

                }
            }
        }

       


        if (isSubstringExists(objDBFieldName.value, "CustomFieldDate")){
            if (isDate(document.getElementById('txtDefaultValue')) == false) {
                strmsg = ' - Please enter the default value in the date format';
                errorMsg += "<li>" + strmsg + "</li>";
                //alertify.notify('', 'error');
                checkvalue = 1;               
            }
        }     


        
        objQuery = GetObjectReference('frmTaskCustomFields', 'txtQueryText');
        if (isSubstringExists(objDBFieldName.value, "CustomFieldCombo"))
        {

            //Replace () with [] 
            if (objoptComboValue[1].checked == true)
            {
               // if (disallowBlank(objQuery, "Please enter the query or stored procedure to populate the combo box"))
                // return;
                if ((objQuery.value == ""))
                {
                    strmsg = ' - Please enter the query or stored procedure to populate the combo box'
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1
                     setFocus(objQuery);

                }
                //if (disallowMaxlengthViolation(objQuery, 1000, "Please enter a query or stored procedure of less than 1000 characters"))
                   // return;
                if ($("#txtQueryText").val() > 1000) {

                    strmsg = ' - Please enter a query or stored procedure of less than 1000 characters'
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1
                    setFocus(objQuery);

                }

                if (isSubstringExists(objQuery.value, "\""))
                {
                    strmsg = ' - Character \" is not allowed in the query'
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1
                    setFocus(objQuery);
                  
                   
                }
            }
        }

        //Added by Usha Pandit on 01 Aug  2018 for checking max length of default value field
        if(objtxtMaxLength != null && objtxtMaxLength != undefined)
        {
            if (objtxtMaxLength.value != "" && objtxtMaxLength.value != undefined && objtxtMaxLength.value != null)
            {
                if(objDefaultValue != null && objDefaultValue != undefined)
                {
                    if (objDefaultValue.value != "" && objDefaultValue.value != undefined && objDefaultValue.value != null)
                    {                
                        if(objDefaultValue.value.length > objtxtMaxLength.value)
                        {
                            strmsg = ' - Default value length should not be greater than Max Length ' + objtxtMaxLength.value;
                            errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1
                            setFocus(objDefaultValue);
                        }
                  
                    }  
                }
            }
        }


        var objCurDBFieldName = GetObjectReference('frmTaskCustomFields', 'txtDatabaseFieldName');
        var objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
        if(objDataType.value == 1 && (isSubstringExists(strValidation, ",9,")))
        {
            strmsg = ' - Only Alphabets validation rule is not applicable when data type is Numeric';
            errorMsg += "<li>" + strmsg + "</li>";
            checkvalue = 1
            setFocus(objValidationRules);
        }

       
            var lstValuecheck = $("#lstValue option").map(function () 
            {
                return $(this).text();
            }).get().join('');

          
            if(lstValuecheck != "")
            {
                if(isSubstringExists(strValidation, ",9,"))
                {                   
                    if(objDataType.value != 1)
                    {
                        if (!lstValuecheck.match(/^[a-zA-Z]+$/)) 
                        {
                            strmsg = ' - Please Enter only alphabates for combo box';
                            errorMsg += "<li>" + strmsg + "</li>";
                    
                            checkvalue = 1;
                        }
                    }                  
                }
            }
            if(objDefaultValue != null && objDefaultValue != undefined)
            {
                if(isSubstringExists(strValidation, ",9,"))
                {
                    if(objDefaultValue.value != "")
                    {
                        if(objDataType.value != 1)
                        {
                            if (!objDefaultValue.value.match(/^[a-zA-Z]+$/)) 
                            {
                                strmsg = ' - Please Enter only alphabates for default value';
                                errorMsg += "<li>" + strmsg + "</li>";
                    
                                checkvalue = 1;
                            }
                        }
                    }
                }

                if(objMinValue != null && objMaxValue != null && objMinValue != undefined && objMaxValue != undefined && objDataType.value == 1)
                {
                    if(objMinValue.value != "")
                    {
                        if(objDefaultValue.value != "")
                        {
                            if(parseInt(objDefaultValue.value) < parseInt(objMinValue.value))
                            { 
                                strmsg = ' - Default Value ' + parseInt(objDefaultValue.value) + ' is less than Minimum Value ' + parseInt(objMinValue.value);
                                errorMsg += "<li>" + strmsg + "</li>";
                    
                                checkvalue = 1;
                            }
                        }
                    }
                    if(objMaxValue.value != "")
                    {  
                        if(objDefaultValue.value != "")
                        {
                            if(parseInt(objDefaultValue.value) > parseInt(objMaxValue.value))
                            {
                                strmsg = ' - Default Value ' + parseInt(objDefaultValue.value) + ' is greater than Maximum Value ' + parseInt(objMaxValue.value);
                                errorMsg += "<li>" + strmsg + "</li>";                    
                                checkvalue = 1;
                            }
                        }
                    }
                }
                if(objValidationRules != null && objValidationRules != undefined)
                {
                    if((isSubstringExists("," + objValidationRules.value + "," ,",13,") && objDataType.value==1) == true)
                    {
                        if (disallowNegativeNumeric(document.getElementById('txtDefaultValue')) == true)
                        {
                            strmsg = ' - Please Enter only positive numeric value for Default Value field';
              
                            errorMsg += "<li>" + strmsg + "</li>";                        
                            checkvalue = 1;

                        }
                    }
                

                    if((isSubstringExists("," + objValidationRules.value + "," ,",15,")) == true)
                    {
                        if (disallowSpecialCharacters(document.getElementById('txtDefaultValue')) == true)
                        {
                            strmsg = ' - Default Value field cannot contain any of these /\:*?<>|,"+!#%@$- characters as per applied validation rule';                  
          
                            errorMsg += "<li>" + strmsg + "</li>";
                       
                            checkvalue = 1;

                        }
                    }

                    if((isSubstringExists("," + objValidationRules.value + "," ,",3,")) == true && document.getElementById('txtDefaultValue').value != "")
                    {
                        if (!isNumeric(document.getElementById('txtDefaultValue').value))
                        { 
                            strmsg = ' - Please enter only numeric values for default value field';                  
          
                            errorMsg += "<li>" + strmsg + "</li>";
                       
                            checkvalue = 1;
                        }
                    }

                    if((isSubstringExists("," + objValidationRules.value + "," ,",13,")) == true && objDataType.value==2)
                    {
                        if (disallowNegativeNumeric(document.getElementById('txtDefaultValue')) == true)
                        { 
                            strmsg = ' - Please enter only positive numeric value for default value field';                  
          
                            errorMsg += "<li>" + strmsg + "</li>";
                       
                            checkvalue = 1;
                        }
                    }
                }
                if (isSubstringExists(objDBFieldName.value, "CustomFieldCombo")){
                    if(objDataType.value == 1 && document.getElementById('txtDefaultValue').value != "")
                    {
                        if (!isNumeric(document.getElementById('txtDefaultValue').value))
                        { 
                            strmsg = ' - Please enter only numeric values for default value field';                  
          
                            errorMsg += "<li>" + strmsg + "</li>";
                       
                            checkvalue = 1;
                        }
                    }
                }
            }
       
            var objListBox = GetObjectReference('frmTaskCustomFields', 'lstValue');
            if(objListBox != null && objListBox != undefined )
            {
                for(intCtr=0 ; intCtr < objListBox.length ; intCtr++)
                {
                    if(objMinValue != null && objMaxValue != null && objMinValue != undefined && objMaxValue != undefined && objDataType.value == 1)
                    {
                        if(objMinValue.value != "")
                        {
                            if(parseInt(Trim(objListBox.options[intCtr].innerHTML)) < objMinValue.value )
                            { 
                                strmsg = ' - Combo box Value ' + Trim(objListBox.options[intCtr].innerHTML) + ' is less than minimum value ' + objMinValue.value;
                                errorMsg += "<li>" + strmsg + "</li>";                               
                                checkvalue = 1;     
                            }
                        }

                        if(objMaxValue.value != "")
                        {
                            if(parseInt(Trim(objListBox.options[intCtr].innerHTML)) > objMaxValue.value )
                            {
                                strmsg = ' - Combo box Value ' + Trim(objListBox.options[intCtr].innerHTML) + ' is greater than maximum value ' + objMaxValue.value;
                                errorMsg += "<li>" + strmsg + "</li>";                               
                                checkvalue = 1;   
                            }
                        }
                    }

                    if((isSubstringExists("," + objValidationRules.value + "," ,",13,")  == true && objDataType.value==1))
                    {

                        if (parseInt(Trim(objListBox.options[intCtr].innerHTML)) < 0  || parseInt(Trim(objListBox.options[intCtr].innerHTML)) == "NAN")
                        {
                            // alertify.set('notifier', 'position', 'top-right');
                            //Commented and Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                            //strmsg = ' - Please Enter only positive numeric value for Validation Rules';
                            strmsg = ' - Please Enter only positive numeric value for Combo box Value ' + Trim(objListBox.options[intCtr].innerHTML);
              
                            //End of Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                            errorMsg += "<li>" + strmsg + "</li>";                                   
                            checkvalue = 1;

                        }

                        if (!isNumeric(parseInt(Trim(objListBox.options[intCtr].innerHTML))))
                        {
                            strmsg = ' - Please enter only Numeric values for combo box value ' + (Trim(objListBox.options[intCtr].innerHTML));
                            errorMsg += "<li>" + strmsg + "</li>";
                            // setFocus(objlstValue);
                            checkvalue = 1
                          
                            // alert("Please enter only Numeric values for list");
                            //return;
                        }
                    }

                    if((isSubstringExists("," + objValidationRules.value + "," ,",13,")  == true && objDataType.value==2))
                    {
                        if (!isNumeric(Trim(objListBox.options[intCtr].innerHTML)))
                        { 
                            strmsg = ' - Please enter only positive numeric values for Combo box Value ' + Trim(objListBox.options[intCtr].innerHTML);          
          
                            errorMsg += "<li>" + strmsg + "</li>";
                       
                            checkvalue = 1;
                        }
                     
                        if (parseInt(Trim(objListBox.options[intCtr].innerHTML)) < 0 || parseInt(Trim(objListBox.options[intCtr].innerHTML)) == "NAN")
                        {
                            // alertify.set('notifier', 'position', 'top-right');
                            //Commented and Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                            //strmsg = ' - Please Enter only positive numeric value for Validation Rules';
                            strmsg = ' - Please Enter only positive numeric value for Combo box Value ' + Trim(objListBox.options[intCtr].innerHTML);
              
                            //End of Added by Usha Pandit on 02 Aug 2018 for correct validation alert
                            errorMsg += "<li>" + strmsg + "</li>";                                   
                            checkvalue = 1;

                        }
                    }
                   
                    if(objValidationRules.value == ""  && objDataType.value == 1)
                    {
                        if (!isNumeric(parseInt(Trim(objListBox.options[intCtr].innerHTML))))
                        {
                            strmsg = ' - Please enter only Numeric values for combo box value ' + (Trim(objListBox.options[intCtr].innerHTML));
                            errorMsg += "<li>" + strmsg + "</li>";
                            // setFocus(objlstValue);
                            checkvalue = 1
                          
                            // alert("Please enter only Numeric values for list");
                            //return;
                        }
                    }
                   
                    if((isSubstringExists("," + objValidationRules.value + "," ,",15,")) == true)
                    {
                        ///\:*?<>|,"+-
                        var r = "";
                        if((isSubstringExists("," + objValidationRules.value + "," ,",3,")) == true || (isSubstringExists("," + objValidationRules.value + "," ,",13,")) == true)
                            r = new RegExp('[/\:*?<>|,"+!#%@$]', 'g');
                        else
                            r = new RegExp('[/\:*?<>|,"+!#%@$-]', 'g');
                        if (Trim(objListBox.options[intCtr].innerHTML).match(r))
                        {
                            if((isSubstringExists("," + objValidationRules.value + "," ,",3,")) == true || (isSubstringExists("," + objValidationRules.value + "," ,",13,")) == true)
                                strmsg = ' - Combo box  Value ' + Trim(objListBox.options[intCtr].innerHTML) + ' cannot contain any of these /\:*?<>|,"+!#%@$ characters as per applied validation rule';   
                            else
                                strmsg = ' - Combo box  Value ' + Trim(objListBox.options[intCtr].innerHTML) + ' cannot contain any of these /\:*?<>|,"+!#%@$- characters as per applied validation rule';

                            errorMsg += "<li>" + strmsg + "</li>";
                       
                            checkvalue = 1;

                        }
                    }
                }
            }


            if($("#txtControlWidth").val() > 200)
            { 
                strmsg = ' - Control width should not be greater than 200';
                errorMsg += "<li>" + strmsg + "</li>";
                // setFocus(objlstValue);
                checkvalue = 1
            }

            var objoptComboValue = GetObjectReference('frmTaskCustomFields', 'optComboValue', true);
           
            if(objoptComboValue[0]!=null && objoptComboValue[0]!=undefined && objoptComboValue[1]!=null && objoptComboValue[1]!=undefined )
            {
                if(objoptComboValue[0].value != null && objoptComboValue[0].value != undefined && objoptComboValue[1].value != null && objoptComboValue[1].value != undefined)
                {
                   
                    if (objoptComboValue[1].checked == true)
                    { 
                       

                        var m_bitIsQueryValue = 1; 
                        var m_strQueryText = $("#txtQueryText").val();
                        var data = JSON.stringify({strQuery:m_strQueryText});
                        strResult = AJAXCallWithResult("CustomFieldMaintainance.aspx/ValidateCustomComboQuery", data, false);
                        if(strResult.d!="" && strResult.d != undefined)
                        {
                            if(strResult.d != "Success")
                            { 
                                strmsg = ' - ' + strResult.d;
                                errorMsg += "<li>" + strmsg + "</li>";
                                // setFocus(objlstValue);
                                checkvalue = 1
                            }
                        }
                    }
                   
                }
            }
           
        //End of Added by Usha Pandit on 01 Aug  2018 for checking max length of default value field

        if (strmsg != "")
        {
            alertify.dismissAll();
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
       
        return checkvalue;
    }


    function Save_OnClick()
    {
        
        if (validation() == 0)
        {
           
            var objoptComboValue = GetObjectReference('frmTaskCustomFields', 'optComboValue', true);
            var m_strDefaultValue,m_strDefaultValueType,m_bitIsQueryValue; 
            var m_strDBFieldName = $("#txtDatabaseFieldName").val();
            var m_txtUserGivenCaption = $("#txtUserGivenCaption").val();
            var m_intDataType = $("#cboDataType").val();
            var m_intRowNumber = $("#txtRowNumber").val();
            var m_intColumnNumber = $("#txtColumnNumber").val();
            var m_strControlHeight = $("#txtControlHeight").val();
            var m_strControlWidth = $("#txtControlWidth").val();
            var m_strMaxLength = $("#txtMaxLength").val();
           // alert($("#txtMinValue").length);
            var m_strMinValue = $("#txtMinValue").val();
            var m_strMaxValue = $("#txtMaxValue").val();
            // var m_strDefaultValue = $("#txtDefaultValue").val();
           
           
            //Commented and Added by Usha Pandit on 31 July 2018 for Query text save issue
            //if(objoptComboValue.value!=null && objoptComboValue.value!=undefined)
            //{
            //alert(objoptComboValue);
           
            if(objoptComboValue[0]!=null && objoptComboValue[0]!=undefined && objoptComboValue[1]!=null && objoptComboValue[1]!=undefined )
            {
                if(objoptComboValue[0].value != null && objoptComboValue[0].value != undefined && objoptComboValue[1].value != null && objoptComboValue[1].value != undefined)
                {
                    
                    //End of Added by Usha Pandit on 31 July 2018 for Query text save issue
                    if (objoptComboValue[1].checked == true)
                    {                   
                        m_bitIsQueryValue = 1; 
                    }
                    else if (objoptComboValue[0].checked == true)
                    {                    
                        m_bitIsQueryValue = 0;
                    }                   
                }
            }
           // if (isSubstringExists(objDBFieldName.value, "CustomFieldCombo"))
            if(isSubstringExists(m_strDBFieldName, "CustomFieldCombo"))
            {
                
                m_strDefaultValueType = $("#optDefaultValue").val();
                if(m_strDefaultValueType!= undefined)
                {
                    if(m_strDefaultValueType == "S")
                    {
                
                          m_strDefaultValue= $("#txtDefaultValue").val();
                    }
                    else{
                
                         m_strDefaultValue= $("#cboDefaultValue").val();
                    }
                }
                    //Added by Usha Pandit on 30 July 2018 for blank default value getting passed, when default value entered
                else{
                
                    m_strDefaultValue= $("#txtDefaultValue").val();
                }
                //End of Added by Usha Pandit on 30 July 2018 for blank default value getting passed, when default value entered

            }
            else
            {
                 m_strDefaultValue = $("#txtDefaultValue").val();
                
                m_strDefaultValueType = "S";
            
            }
            
            //var m_strMinValue = document.getElementById('txtMinValue').value;
           // if($("input:radio[name='optComboValue']").is(":checked")) 
            // {

            
            var m_strQueryText = $("#txtQueryText").val();
            //var lstValue = $("#lstValue").val();
            var lstValue = $("#lstValue option").map(function () 
            {
                return $(this).text();
            }).get().join(',');

            if (m_strDBFieldName == "" || m_strDBFieldName == undefined) {

                m_strDBFieldName = "";
            }

            if (m_txtUserGivenCaption == "" || m_txtUserGivenCaption == undefined) {

                m_txtUserGivenCaption = "";
            }

            if (m_strDefaultValue == "" || m_strDefaultValue == undefined) {

                m_strDefaultValue = "";
            }

            if (m_strDefaultValueType == "" || m_strDefaultValueType == undefined) {

                m_strDefaultValueType = "";
            }

            if (m_intDataType == "" || m_intDataType == undefined) {

                m_intDataType = "";
            }

            if (m_intRowNumber == "" || m_intRowNumber == undefined) {

                m_intRowNumber = "";
            }

            if (m_intColumnNumber == "" || m_intColumnNumber == undefined) {

                m_intColumnNumber = "";
            }

            if (m_strControlHeight == "" || m_strControlHeight == undefined) {

                m_strControlHeight = "";
            }

            if (m_strControlWidth == "" || m_strControlWidth == undefined) {

                m_strControlWidth = "";
            }

            if (m_strMaxLength == "" || m_strMaxLength == undefined) {

                m_strMaxLength = "";
            }

            if (m_strMinValue == "" || m_strMinValue == undefined) {

                m_strMinValue = "";
            }

            if (m_strMaxValue == "" || m_strMaxValue == undefined) {

                m_strMaxValue = "";
            }

            if (m_strQueryText == "" || m_strQueryText == undefined) {

                m_strQueryText = "";
            }

            if (m_bitIsQueryValue == "" || m_bitIsQueryValue == undefined) {

                m_bitIsQueryValue = "";
            }

            if (lstValue == "" || lstValue == undefined) {

                lstValue = "";
            }
           
            var m_strValidationRules = $("#txtValidationRules").val();
            if (m_strValidationRules == "" || m_strValidationRules == undefined) {

                m_strValidationRules = "";
            }

           
            var strResult1, data1;
            data1 = JSON.stringify({m_txtUserGivenCaption:m_txtUserGivenCaption, m_strDBFieldName: m_strDBFieldName, m_intDataType: m_intDataType, m_intRowNumber: m_intRowNumber, m_intColumnNumber: m_intColumnNumber, m_strControlHeight: m_strControlHeight, m_strControlWidth: m_strControlWidth, m_strValidationRules: m_strValidationRules, m_strMaxLength: m_strMaxLength, m_strMinValue: m_strMinValue, m_strMaxValue: m_strMaxValue, m_strDefaultValue: m_strDefaultValue, m_strQueryText: m_strQueryText, lstValue: lstValue,m_bitIsQueryValue:m_bitIsQueryValue, m_strDefaultValueType:m_strDefaultValueType });
            //alert(data1);
            strResult1 = AJAXCallWithResult("CustomFieldMaintainance.aspx/SaveCustomFieldDetails", data1, false);
            if(strResult1.d!="")
            {
                if (globalCustomFieldID != "") 
                {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Custom Fields Details Updated Successfully', 'success');
              

                }
                else 
                {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Custom Fields Details Saved Successfully', 'success');
                    $("#btnAccess").css("display","block");
                    $("#btnShowHistory").css("display","block");
               
                    //Added by Usha Pandit on 27 July 2018 for Custom field configure Access Save Issue
                    if(strResult1.d != undefined )
                        var arrResultData = strResult1.d.split("|");                 
                    
                    globalCustomFieldID = arrResultData[1];
                    //End of Added by Usha Pandit on 27 July 2018 for Custom field configure Access Save Issue
                }
            }

            else
            {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Error: Invalid Query.', 'error');
              //  $("#errormsg").html("Error: Invalid Query");
                // $("#btnAccess").css("display","none");
                // $("#btnShowHistory").css("display","none");
               
            }

            //if(globalCustomFieldID!= "")
            //{
               
            
           // }


        }

    }

    function RefreshGrid(cityName) {
        // debugger;
        var strResult, data;
        var GridParameter = {};
      
        GridParameter.cityName = cityName;

        data = JSON.stringify({ GridParameter: GridParameter, CustomerID: "", Role: "", Status: "" });
        // alert(data);
        strResult = AJAXCallWithResult("CustomFieldMaintainance.aspx/RefreshGrid", data, false);
        var DivId;
        // alert(strResult);
        var DivSerach;
        // alert(strResult.d);
        if (strResult != '' && strResult != 'undefined') {
            if (cityName == "Type")
            {
                DivId = "DivList";
                DivSerach = "SearchRquestType";
                $("#" + DivId + " .table-responsive:first").html(strResult.d);
            }
            else if (cityName == "AssignType") {
                DivId = "divAssignType";
                DivSerach = "AssignType";
                
                // var tablename = "divCustomerContact";
                $("#Tab2" + " .table-responsive:first").html(strResult.d);
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


        
        if (cityName == "AssignType") {

            Assigndatatables(DivId, DivSerach, "300");
        }
        else {

            datatables(DivId, DivSerach, "");
        }
    }


    function SelectValidation(strDatabaseFieldName, intProjectID)
    {
        //alert(SelectedValidationRules);
       
        var strValidationRules, objValidationRules;
        objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
        strValidationRules = $("#txtValidationRules").val();
        //alert(strValidationRules);
        var data = JSON.stringify({ strDatabaseFieldName: strDatabaseFieldName, strValidationRules: strValidationRules });
        //var myJSON = JSON.stringify(data);
        var url = "CustomFieldMaintainance.aspx/GetValidationRules"

        var result = AJAXCallWithResult(url, data, false)
        if (result.d!="")
        {
            //datatables("RuleValidation", '', "");
            $("#RuleValidation1 #modalbody1").html(result.d);
        
            document.getElementById('RuleValidation1').style.display = 'block';
            datatables("divValidation", '', "");
           // objValidationRules.value = strValidationRules;
            //txtValidationRules_OnPropertyChange();
           
        }

        //Added by Usha Pandit on 01 Aug 2018 for checking applicable validation rule
       
        $('input[type="checkbox"]').change(function(event) {
            // State has changed to checked/unchecked.
            var strcurmsg = "";
            var errorcurMsg = "<ul>"; 
            if($(this).is(":checked")) {
                  
                if($(this).attr('id') == "chkApply" && $(this).val() == 12)
                {
                        
                    var objCurDBFieldName = GetObjectReference('frmTaskCustomFields', 'txtDatabaseFieldName');
                        
                    if (isSubstringExists(objCurDBFieldName.value, "CustomFieldCombo") == true)
                    {
                           
                        strcurmsg = ' - Max Length validation rule is not applicable for combobox';
                        errorcurMsg += "<li>" + strcurmsg + "</li>";
                        
                        // setFocus(objDataType);
                    }
                }

                if($(this).attr('id') == "chkApply" && $(this).val() == 9)
                {
                    var objCurDBFieldName = GetObjectReference('frmTaskCustomFields', 'txtDatabaseFieldName');
                    var objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
                    //if(objDataType.value == 1)
                    //{
                    //    strcurmsg = ' - Only Alphabets validation rule is not applicable when data type is Numeric';
                    //    errorcurMsg += "<li>" + strcurmsg + "</li>";
                    //}
                   
                    var table = $('#modalbody1 table').DataTable();
                    var rows = table.rows({ 'search': 'applied' }).nodes();
                    var curvalidationrules = $('input[id="chkApply"]:checked', rows).map(function ()
                    {
                        return this.value;
                    }).get().join(','); 
                    table.destroy();
                   
                    if ((isSubstringExists("," + curvalidationrules, "18") == true) ||	//Value Range Validation
                   (isSubstringExists("," + curvalidationrules, "17") == true) ||	//Max Value Validation
                   (isSubstringExists("," + curvalidationrules, "16") == true || objDataType.value == 1))	//Min Value Validation
                    {
                        strcurmsg = ' - Only Alphabets validation is not applicable when Numeric/Positive Numeric/Value Range/Max Value/Min Value Validation is applied or if data type is numeric';
                        errorcurMsg += "<li>" + strcurmsg + "</li>";
                    }
                }


                if($(this).attr('id') == "chkApply" && ($(this).val() == 16 || $(this).val() == 17 || $(this).val() == 18 || $(this).val() == 3 ))
                { 
                    var table = $('#modalbody1 table').DataTable();
                    var rows = table.rows({ 'search': 'applied' }).nodes();
                    var curvalidationrules = $('input[id="chkApply"]:checked', rows).map(function ()
                    {
                        return this.value;
                    }).get().join(','); 
                    table.destroy();

                    if( isSubstringExists("," + curvalidationrules, "9") == true)
                    {
                        strcurmsg = ' - Both numeric data/Value Range/Max Value/Min Value and only alphabets validations cannot be set for the same control';
                        errorcurMsg += "<li>" + strcurmsg + "</li>";
                    }
                }

                if($(this).attr('id') == "chkApply" && ($(this).val() == 16 || $(this).val() == 13 || $(this).val() == 17 || $(this).val() == 18 || $(this).val() == 3 ))
                {
                    var objCurDBFieldName = GetObjectReference('frmTaskCustomFields', 'txtDatabaseFieldName');
                    var objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
                   
                    var table = $('#modalbody1 table').DataTable();
                    var rows = table.rows({ 'search': 'applied' }).nodes();
                    var curvalidationrules = $('input[id="chkApply"]:checked', rows).map(function ()
                    {
                        return this.value;
                    }).get().join(','); 
                    table.destroy();
                   
                    if (objDataType.value == 2)	
                    {
                        //strcurmsg = ' - Numeric/Positive Numeric/Value Range/Max Value/Min Value validation is not applicable when data type is text';
                        //errorcurMsg += "<li>" + strcurmsg + "</li>";
                    }
                }

                if (strcurmsg != "")
                {
                    alertify.dismissAll();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(errorcurMsg, 'error', 5);
                    $(this).attr('checked', false);
                }
            }
              
        });

       
        //End of Added by Usha Pandit on 01 Aug 2018 for checking applicable validation rule
    }
       
    function txtValidationRules_OnPropertyChange() {
        var objMinValue, objMaxValue, objValidationRules;
        var strValidation;

        objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
        objMinValue = GetObjectReference('frmTaskCustomFields', 'txtMinValue');
        objMaxValue = GetObjectReference('frmTaskCustomFields', 'txtMaxValue');
        //Added by ShraddhaM To disable MaxLength textbox if validation is applied.
        objtxtMaxLength = GetObjectReference('frmTaskCustomFields', 'txtMaxLength');
        //Ended by ShraddhaM
        objMinValue.disabled = true;
        objMaxValue.disabled = true;
        //Added by Usha Pandit on 01 Aug 2018 for checking undefined field
        if ((objtxtMaxLength != null) && (objtxtMaxLength  != undefined))
        {
            //End of Added by Usha Pandit on 01 Aug 2018 for checking undefined field

            objtxtMaxLength.disabled = true;
        }
        if (Trim(objValidationRules.value) != "") {
            strValidation = "," + objValidationRules.value;
           
            //Added by Usha Pandit on 01 Aug 2018 for checking undefined field
            if ((objtxtMaxLength != null) && (objtxtMaxLength  != undefined))
            {
                //End of Added by Usha Pandit on 01 Aug 2018 for checking undefined field
                if (isSubstringExists(strValidation, ",12,"))
                    objtxtMaxLength.disabled = false;
                else
                    objtxtMaxLength.value = "";
            }
            
            
            //Rule 18 : Specified Range Check (Both the minimum value and maximun value required )
            if (isSubstringExists(strValidation, ",18,")) {
                objMinValue.disabled = false;
                objMaxValue.disabled = false;
                return;
            }
            //Rule 16 : Minimum Value Check(Only minimum value required.)
            if (isSubstringExists(strValidation, ",16,"))
                objMinValue.disabled = false;
            else
                objMinValue.value = "";

            //Rule 17 : Maximum Value Check(Only maximum value required.)
            if (isSubstringExists(strValidation, ",17,"))
                objMaxValue.disabled = false;
            else
                objMaxValue.value = "";

            //Added by ShraddhaM To disable MaxLength textbox if validation is applied.		        
            
           
            //Ended by ShraddhaM

        }
        else	//Mimimum and Maximum value textboxes must be empty
        {
            objMinValue.value = "";
            objMaxValue.value = "";

            //Added by Usha Pandit on 01 Aug 2018 for checking undefined field
            if ((objtxtMaxLength != null) && (objtxtMaxLength  != undefined))
            {
                //End of Added by Usha Pandit on 01 Aug 2018 for checking undefined field
                objtxtMaxLength.value = "";
            }
        }
    }
   
    function close_onclick()
    {

        document.getElementById('RuleValidation1').style.display = 'none';

    }

    
    function SetValidated()
    {  
        var objValidationCheckbox, i, j;
        var objCustomFields = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
        objValidationCheckbox = GetObjectReference('frmTaskCustomFields', 'chkApply', true);

        strValidationRules = "";
        for (i = 0; i < objValidationCheckbox.length; i++)
        {
            if (objValidationCheckbox[i].checked == true)
            {
                if (objValidationCheckbox[i].value == 3)
                {
                    for (j = 0; j < objValidationCheckbox.length; j++) {
                        if ((objValidationCheckbox[j].checked == true) && (objValidationCheckbox[j].value == 9)) {
                            //alert(replaceSubstring("<%=MyBase.GetResourceString("NUMDATA_AND_ONLY_ALPHABETS")%>", "&#39;","'"));
                            // return;
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Both 'numeric data' and 'only alphabets' validations cannot be set for the same control", 'error', 15);
                            return;
                        }
                        if ((objValidationCheckbox[j].checked == true) && (objValidationCheckbox[j].value == 13)) {
                            //alert(replaceSubstring("<%=MyBase.GetResourceString("NUMDATA_AND_POSIIVE_NUMDATA")%>", "&#39;","'"));
                            // return;
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Both 'numeric data' and 'positive numeric data' validations cannot be set for the same control", 'error', 15);
                            return;
                        }
                    }
                }
                if (objValidationCheckbox[i].value == 9)
                {

                    for (j = 0; j < objValidationCheckbox.length; j++) {
                        if ((objValidationCheckbox[j].checked == true) && (objValidationCheckbox[j].value == 13)) {
                            //alert(replaceSubstring("<%=MyBase.GetResourceString("ONLY_ALPHABETS_AND_POSITIVE_NUMDATA")%>", "&#39;", "'"));
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Both 'only alphabets' and 'positive numeric data' validations cannot be set for the same control", 'error', 15);
                            return;
                        }
                    }
                }
                strValidationRules = strValidationRules + objValidationCheckbox[i].value + ",";
            }
        }
      
     
        if ((isSubstringExists("," + strValidationRules, "18") == true) ||	//Value Range Validation
           (isSubstringExists("," + strValidationRules, "17") == true) ||	//Max Value Validation
           (isSubstringExists("," + strValidationRules, "16") == true))	//Min Value Validation
        {
            if (isSubstringExists("," + strValidationRules, "3") == false)	//Numeric Data Validation
            {
                strValidationRules = "3," + strValidationRules;
            }
        }
      
       
        if (objCustomFields.value != null || objCustomFields.value !== 'undefined')
        {
            var objCustomFields = GetObjectReference('frmCustomeFields', 'txtValidationRules');
        }
    
        objCustomFields.value = strValidationRules;
        SelectedValidationRules = strValidationRules;
       
         txtValidationRules_OnPropertyChange();
        document.getElementById('RuleValidation1').style.display = 'none';
    }
        //End Modification
		
    function ConFigureAccess()
    {
       // debugger;
        var myJSON = JSON.stringify({ flag: "ShowAccess" });
        var url = "CustomFieldMaintainance.aspx/ShowAccess"

        var result = AJAXCallWithResult(url, myJSON, false)
        if (result.d != "") {
           
            $("#btnAccess").css("display", "block");
            $("#divAccess1 #divAccessModelBody").html(result.d);
            document.getElementById('divAccess1').style.display = 'block';

            datatables1("divAccess", 'Access');
        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }

    function DeleteMultiple()
    {

        var table = $('#DivList table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllCustom').checked == true) {
            //$("input[name=chkActivityDelete]:not(:disabled)").prop('checked', true);
            $('input[id="chkCustomDelete"]:not(:disabled)', rows).prop('checked', true);
        }
        else {
            //$("input[name=chkActivityDelete]").prop('checked', false);
            $('input[id="chkCustomDelete"]', rows).prop('checked', false);
        }



    }
    function ShowHistory() {
        $("#cboModifiedBy").val("");
        $("#cboModifiedField").val("");
        var obj = { "UniqueID": globalCustomFieldID };
        var myJSON = JSON.stringify(obj);
        var url = "CustomFieldMaintainance.aspx/ShowCustomDetails"

        var result = AJAXCallWithResult(url, myJSON, false)
       
        if (globalCustomFieldID == undefined || globalCustomFieldID == 0) {

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(' - Please select atleast one entry..', 'error');
        }
        else
        {

            $("#divHistory #modalbody").html(result.d);
            document.getElementById('divHistory').style.display = 'block';
        }
        datatables1("ShowHistoryGrid", 'txtSearchHistory');
    }


    function ModifiedFieldFilter_Change() {

        var ModifiedField = $('#cboModifiedField :selected').text();
        var ModifiedBy = $('#cboModifiedBy :selected').text();

        var obj = { "newModifiedField": ModifiedField, globalCustomFieldID: globalCustomFieldID, "newModifiedBy": ModifiedBy };
        var myJSON = JSON.stringify(obj);

        var url = "CustomFieldMaintainance.aspx/FilteredHistory"
        var result = AJAXCallWithResult(url, myJSON, false)
        $("#divHistory #modalbody").html(result.d);
        document.getElementById('divHistory').style.display = 'block';
        datatables1("ShowHistoryGrid", 'txtSearchHistory');
    }

    function SaveListDetails() {

        var data1, strResult1;
        var SelectedActiveContrl = $('input[id=chkActive]:checked').map(function () {
            return this.value;
        }).get().join(',');

        data1 = JSON.stringify({ SelectedActiveContrl: SelectedActiveContrl });
        strResult1 = AJAXCallWithResult("CustomFieldMaintainance.aspx/SaveCustomFieldList", data1, false);
       
        if (strResult1.d == "1")
        {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Custom Fields list details Updated Successfully", 'success');
            RefreshGrid('Type');
        }

    }
    // =============================== In Case of CustomCombo Depending on static values or Query Values enable/disable coresponding List and QueryText=====================//
    function optComboValue_Onclick() {
       
        var bitQuery = <%=m_bitIsQueryValue%>;
        var objoptComboValue, objDefaultValue, objValue;
        objQuery = GetObjectReference('frmTaskCustomFields', 'txtQueryText');//TRQueryText
        objoptComboValue = GetObjectReference('frmTaskCustomFields', 'optComboValue', true);
        objDefaultValue = GetObjectReference('frmTaskCustomFields', 'txtDefaultValue');
        TRQueryText = GetObjectReference('frmTaskCustomFields', 'TRQueryText');
        divComboboxValues = GetObjectReference('frmTaskCustomFields', 'txtDefaultValue');
        divQueryValues = GetObjectReference('frmTaskCustomFields', 'txtQueryText');

        if (objoptComboValue[1].checked == true)
        {
            TRQueryText.style.display = "";
            // divComboboxValues.style.display = "none";
        
            //PlotSubtab1("ClientContact");
          
            openCity4(event,"Tab2");
            //Commented by Usha Pandit on 07 Aug 2018 for displaying tab 1 for combo values generated by Query or Stored Procedure
            //$("#btnTab1").css("display","none") 
            //End of Commented by Usha Pandit on 07 Aug 2018 for displaying tab 1 for combo values generated by Query or Stored Procedure

            $("#DivLeft").addClass("DivLeftClass");
           // RefreshGridDetails();
            divQueryValues.style.display = "";
            if (bitQuery == 0)
                objDefaultValue.value = "";
            bitQuery = 1;
        }
        else if (objoptComboValue[0].checked == true)
        {
            TRQueryText.style.display = "none";
            // divComboboxValues.style.display = "block";
             openCity4(event,"Tab1");
           // $("#btnTab2").css("display","none")
            // divQueryValues.style.display = "none";
            if (bitQuery == 1) {
                objDefaultValue.value = "";
                objValue = GetObjectReference('frmTaskCustomFields', 'txtValue');
                if (objValue != null)
                    objValue.value = "";
            }
            bitQuery = 0;
        }
    }


    function optDefaultValue_Onclick() {
        var objDefaultValue;

        objDefaultValue = GetObjectReference('frmTaskCustomFields', 'optDefaultValue', true);
        if (objDefaultValue(0).checked == true) {
            TDCommonFieldDefaultValue.style.display = "none";
            TDStaticDefaultValue.style.display = "block";
        }
        else {
            TDCommonFieldDefaultValue.style.display = "block";
            TDStaticDefaultValue.style.display = "none";
        }
    }
</script>
