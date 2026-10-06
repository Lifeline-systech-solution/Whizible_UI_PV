<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_OrganizationUnit.aspx.vb" Inherits="PbNIT.CRM_OrganizationUnit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<%CommonFunctions.General.PlotPageHeadTag("Organization Unit")%>
<head runat="server">
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<title> Organization Unit</title>
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>

   
    <!-- Bootstrap core CSS -->
    <%--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />--%>
 <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>

    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" />--%>
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->

    
    <link href="../../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>

    <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />

    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
   <link href=" slacss.css" rel="stylesheet" />
    <%--<script src="../../../whizible2.0-new/plugins/jquery/jquery-3.6.1.min.js"></script>
    <script src="../../../whizible2.0-new/plugins/jqueryui/jquery-ui-1.13.2.min.js"></script>--%>

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

       .clsTRColumnHeader th:nth-child(2) {
            text-align: left;
        }
       .clsTRColumnHeader th:nth-child(4) {
            text-align: center;
        }
        .clsTRColumnHeader th:nth-child(3) {
            text-align: center;
        }
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

      

        #divOU .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        #divOU .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
         
            position: relative;
        }

        
        .dataTables_info {
        font-size:13px;
        }
        #frmType {
        width:100%;
        }
       #divOU .dataTables_wrapper {
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

      
        #idPanelBody {
        overflow: auto;
        height: 175px;
        width: 103%;
        padding-right: 2%;
}
       #divOU .dataTables_scroll {
        OVERFLOW: HIDDEN;
        }
        #divOU .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            /*height: 180px;*/
            padding-right: 0.5%;
        }
          #divOU .dataTables_scroll {
        OVERFLOW: HIDDEN;
        }
        #divOU .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            /*height: 180px;*/
            padding-right: 0.5%;
        }

        #divOU table tr td:nth-child(1) {
            width:30%!important;
            word-break:break-all!important;
            
        }
            #divOU table tr td:nth-child(2) {
            width:30%!important;
             word-break:break-all!important;
            

        }
                #divOU table tr td:nth-child(3) {
            width:10%!important;
             text-align:center;
             word-break:break-all!important;
   
        }
                      #divOU table tr td:nth-child(4) {
            width:15%!important;
                word-break:break-all!important;
        }
                            #divOU table tr td:nth-child(5) {
            width:15%!important;
            word-break:break-all!important;
        }

          #divOU table tr th:nth-child(1) {
            width:30%!important
        }
            #divOU table tr th:nth-child(2) {
            width:30%!important
        }
                #divOU table tr th:nth-child(3) {
            width:10%!important;
           
                
        }
                      #divOU table tr th:nth-child(4) {
            width:15%!important
        }
                            #divOU table tr th:nth-child(5) {
            width:15%!important
        }

    .container-fluid {
        min-height:0px!important
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

       
        .form-control {
        font-weight:100;
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
    height:23px;
    /*padding: 0;*/
    font-size: 11px;
    border-radius: 0;
    padding-left: 10px;
   border:1px solid #bbb;
   border-radius:3px;
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
 .form-control {
    /* display: block; */
    width: 71%;
    height: 29px !important;
    padding: 6px 12px;
    font-size: 14px;

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
  #divScroll {
        width:102%;
        padding-right:2%;
        overflow:auto;
      }
    #Type {
         width:102%;
        padding-right:2%;
        overflow:auto;
    }
	    .clslabel {
            margin-top:1.5%!important;
            font-size:12px!important;
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

             #ShowHistoryGrid table tr td:nth-child(4) {
          word-break:break-all!important;
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
	        height: 221px!important;
	        padding-right: 2%!important;
	    }

	    #modalbody {
            overflow:hidden!important;
	    }
        .right .btn-default {
            background:white !important;
            color:black !important;
	    }
        .right .btn-default:hover {
            background:white !important;
            color:black !important;
	    }
        #isSaveandAdd{
        float: right;
        margin-top: 5px;
        margin-left: 5px;
        display:block;
        background-color:white!important;
        color:white;
    }
        #idPlus {
            display:inline-block !important;
        }



         /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
          color: #bbb!important;
        }

	    #CustomerFilter {
            margin-top:-26px;
	    }
        :-ms-input-placeholder { /* IE 10+ */
  color: #bbb!important;
}

        #CboCountry
        {
            margin-top:6px !important

        }
         /*'/*Added by Kashish for ui change*/
	    .search-bar {
	        margin-left: -7px!important;
	    }
          /*'/*Added by Kashish on 10 july 2018 for ui change*/
        .top-bar {
            padding-bottom: 15px !important;
        }
    </style>


 <body class="" id="page-top">

  <div id='Type' class='tabcontent1 h-type clsSettingstabs'>

  <div class="content-wrapper" style="margin-left: 0px !important;" id="divScroll">
  <div class="container-fluid">
   <div class="request-details-pg clsSettings" style="min-height:0px">
    <div class="v-tabs1"><div id="" class="tabcontent">

       <div class="h-tabs" id="divMain">
             <%WritePage()%>
    </div>
  </div>
</div>
</div>
</div>
      </div>

           <div id="id13" class="modal">

            <form class="modal-content animate" action="/action_page.php">
                <div class="imgcontainer">
                    <span class="appro-title">Show History</span>
                    <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close ">&times;</span>
                </div>
                <div class="container-fluid">
                    <div class="form-group">
                        <label class="control-label col-sm-2 clslabel" for="request type">Modified Field</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 395", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                         <label class="control-label col-sm-2 clslabel" for="request type code">Modified By</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 395 ", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                    </div>
                  
                    <div class="container-fluid" id="modalbody" style="overflow:auto;height: 191px;">
                    </div>
                </div>
            </form>
        </div>
  </div>       
  
</body>
      
<%--<script src=" EnhancementFiles/OnlineFiles/js/jquery/2.1.4/jquery.min.js"></script>

<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
		
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>


		
		

    
<!-- Time picker -->


<%--<script src=" EnhancementFiles/js/timepicker.js"></script>--%>

    <%--<script src="../../General/CommonFunctions.js"></script>
	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>

      <!-- Bootstrap core JavaScript -->
        <script src="../../../EnhancementFiles/vendor/popper/popper.min.js"></script>

        <%--<script src="js/editor.js"></script>--%>
        <script src="../../../EnhancementFiles/js/editor.js"></script>

        <%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>
        <script src="../../../EnhancementFiles/OnlineFiles/js/jquery/1.12.1/jquery-ui.js"></script>
       <%--<script src="../../General/CommonFunctions.js"></script>
        <script src="../../../Plugins/alertify/alertify.min.js"></script>
        <!-- Time picker -->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
     
</html>
<script>
     <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
    disableRightClick();
		    <%End If%>
    $(document).click(function () {
       
        $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

    })
    var arrSelectedCheck = new Array();
    var EditOUID = 0;
    $(document).ready(function () {
        RefreshGridDetails();
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

    function RefreshGridDetails() {
        //  debugger;
        var strResult, data;
        var GridParameter = {};
        var DivId;
        var DivSerach;

        DivId = "divOU";
        DivSerach = "txtSearchHistory";

        var TypeDiv; var accordion;
        var intDivGridHeight




        var intDivGridHeight, intDivGridListHeight
        intDivGridListHeight = parseInt(window.innerHeight);
        if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072))
        {
            
            $("#Type").css('height', intDivGridListHeight - 280 + "px");
        }

        else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
           
            $("#Type").css('height', intDivGridListHeight - 320 + "px");
        }
        else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
            
            $("#Type").css('height', intDivGridListHeight - 280 + "px");
        }
        else {
           
            $("#Type").css('height', intDivGridListHeight - 280 + "px");
        }


        datatables(DivId, DivSerach, "");


    }
    function datatables(divID, txtBoxID) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");

        var table = $('#' + divID + ' > table').DataTable({
            ordering: true,
            responsive: true, "pageLength": 3,
            //scrollY: '165px',
            pagingType: "simple_numbers",
            scrollX: true,
            language: {
               
            },

        });
        // debugger;
        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }

    function getdetail(OUID) {
        $.ajax({
            type: "POST",
            url: "CRM_OrganizationUnit.aspx/GetOUDetails",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ OUID: OUID }),
            success: function (data) {
                var arrResult = data.d.split('##');
                //alert(arrResult);

                $('#OrganizationUnit').val(arrResult[0]);
                if (arrResult[1] == "True") {
                    $("#CheckActive").prop('checked', true);
                }
                else {
                    $("#CheckActive").prop('checked', false);
                }

                $('#OrganizationUnitServer').val(arrResult[2]);

                $('#OrganizationUnitCode').val(arrResult[16]);
                document.getElementById('OrganizationUnitCode').disabled = true;
                $('#ShortCode').val(arrResult[3]);
                $('#Address1').val(arrResult[4]);
                $('#Address2').val(arrResult[5]);
                $('#City').val(arrResult[6]);
                $('#Zip').val(arrResult[7]);
                $('#State').val(arrResult[8]);
                $('#CboCountry').val(arrResult[9]);

                $('#Ph1').val(arrResult[10]);
                $('#Ph2').val(arrResult[11]);
                $('#Fax').val(arrResult[12]);
                $('#Email').val(arrResult[13]);
                $('#WorkingH').val(arrResult[14]);
                $('#WorkingD').val(arrResult[15]);
                //$("#History").css("display", "block");


                $("#collapseOne2").addClass('in');
                $("#collapseOne2").css("display", "block");
                $("#collapseOne2").css("overflow", "hidden");
                $("#collapseOne2").css("height", "auto");
                $("#History").css("display", "inline");
                if ($("#Addaccordion").hasClass("collapsed")) {
                    $("#Addaccordion").removeClass("collapsed");
                    $("#collapseOne2").addClass('height', 'auto !important');
                }


            }
        })
    }
    function EditOU_OnClick(OUID)
    {

        EditOUID = OUID;

        //var EditOUID = '';
        //var EditOUID = '';
       
        $.ajax({
            type: "POST",
            url: "CRM_OrganizationUnit.aspx/GetOUDetails",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ OUID: OUID }),
            success: function (data)
            {
                var arrResult = data.d.split('##');
                //alert(arrResult);

                $('#OrganizationUnit').val(arrResult[0]);
                if (arrResult[1] == "True") {
                    $("#CheckActive").prop('checked', true);
                }
                else {
                    $("#CheckActive").prop('checked', false);
                }

                $('#OrganizationUnitServer').val(arrResult[2]);

                $('#OrganizationUnitCode').val(arrResult[16]);
                document.getElementById('OrganizationUnitCode').disabled = true;
                $('#ShortCode').val(arrResult[3]);
                $('#Address1').val(arrResult[4]);
                $('#Address2').val(arrResult[5]);
                $('#City').val(arrResult[6]);
                $('#Zip').val(arrResult[7]);
                $('#State').val(arrResult[8]);
                $('#CboCountry').val(arrResult[9]);

                $('#Ph1').val(arrResult[10]);
                $('#Ph2').val(arrResult[11]);
                $('#Fax').val(arrResult[12]);
                $('#Email').val(arrResult[13]);
                $('#WorkingH').val(arrResult[14]);
                $('#WorkingD').val(arrResult[15]);

                $("#History").css("display", "inline");
                $("#divOU").css("display", "none");
                $("#CustomerFilter").css("display", "none");
                $("#CustomerFilter").css("display", "none");
                //$("#History").css("display", "block");
                $("#collapseOne2").addClass('in');
                $("#collapseOne2").css("display", "block");
                $("#collapseOne2").css("overflow", "hidden");
                $("#collapseOne2").css("height", "auto");

                if ($("#Addaccordion").hasClass("collapsed")) {
                    $("#Addaccordion").removeClass("collapsed");
                    $("#collapseOne2").addClass('height', 'auto !important');
                }



            }
        })
    }

    function AddOU() {
       
        $("#divOU").css("display", "none");
        $('#OrganizationUnit').val("");
        if ($("#CheckActive").checked == true) {
            $("#CheckActive").prop('checked', true);
        }
        else {
            $("#CheckActive").prop('checked', false);
        }

        $('#OrganizationUnitServer').val("");

        $('#OrganizationUnitCode').val("");
        document.getElementById('OrganizationUnitCode').disabled = false;
        $('#ShortCode').val("");
        $('#Address1').val("");
        $('#Address2').val("");
        $('#City').val("");
        $('#Zip').val("");
        $('#State').val("");
        $('#CboCountry').val("");

        $('#Ph1').val("");
        $('#Ph2').val("");
        $('#Fax').val("");
        $('#Email').val("");
        $('#WorkingH').val("");
        $('#WorkingD').val("");
        $("#History").css("display", "none");

        EditOUID = 0;
        $("#CustomerFilter").css("display", "none");

        $("#collapseOne2").addClass('in');
        $("#collapseOne2").css("display", "block");
        $("#collapseOne2").css("overflow", "hidden");
        $("#collapseOne2").css("height", "auto");
        //$("#accordion2").removeClass('collapsed');
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").addClass('height', 'auto !important');
        }
    }

    function validationOU()
    {

        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
      
        var blnOrganizationUnitInValid = false; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if ($("#OrganizationUnit").val() == "")
        {
            strmsg = '- Organization Unit should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;

            blnOrganizationUnitInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }


        if ($("#OrganizationUnit").val() != "") {
            if (checkSpecialCharacter($('#OrganizationUnit').val()) == true) {
                {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = '- A Organization Unit cannot contain any of these /\\:*?<>|,"+- Characters';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    checkvalue = 1;
                    blnOrganizationUnitInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                }
            }
        }

        if ($("#OrganizationUnit").val() != "")
        {
           // alert(EditOUID);
                if (EditOUID != 0)
                {
                    OUID = EditOUID;


                }
                else {

                    OUID = 0;

                }
                var url = 'CRM_OrganizationUnit.aspx/CheckOUName';
                var data = JSON.stringify({ Flag: "OU", OUName: $('#OrganizationUnit').val(), OUID: OUID });

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

                                strmsg = '-  Organization Unit Already Exists';
                                errorMsg += "<li>" + strmsg + "</li>";
                                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                                checkvalue = 1;
                                blnOrganizationUnitInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                            }
                        }
                    },

                });


            }

        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        if (blnOrganizationUnitInValid == true) {
            $('#OrganizationUnit').focus();
        }
        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

            if ($("#OrganizationUnitServer").val() != "") {
                if (checkSpecialCharacter($('#OrganizationUnitServer').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A Organization Unit Server Name cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                        var hasFocus = $('#OrganizationUnit').is(':focus');
                        if (hasFocus) {

                        }
                        else {
                            $("#OrganizationUnitServer").focus();
                        }
                        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                    }
                }
            }

            var blnOrganizationUnitCodeInValid = false; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

           





        if ($("#OrganizationUnitCode").val() == "") {
            strmsg = '- Organization Unit Code should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
            blnOrganizationUnitCodeInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }



        if ($("#OrganizationUnitCode").val() != "") {
            if (checkSpecialCharacter($('#OrganizationUnitCode').val()) == true) {
                {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = '- A Organization Unit Code cannot contain any of these /\\:*?<>|,"+- Characters';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    checkvalue = 1;
                    blnOrganizationUnitCodeInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                }
            }
        }
        if ($("#OrganizationUnitCode").val() != "")
        {
            
            if (EditOUID != 0)
            {
                OUID = EditOUID;


            }
            else {

                OUID = 0;
                var url = 'CRM_OrganizationUnit.aspx/CheckOUName';
                var data = JSON.stringify({ Flag: "OU1", OUName: $('#OrganizationUnitCode').val(), OUID: OUID });

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

                                strmsg = '-  Organization Unit Code   Already Exists';
                                errorMsg += "<li>" + strmsg + "</li>";
                                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                                checkvalue = 1;

                                blnOrganizationUnitCodeInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                            }
                        }
                    },

                });
            }

        }

        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        if (blnOrganizationUnitCodeInValid == true) {

            if ($('#OrganizationUnit').is(':focus') == true || $('#OrganizationUnitServer').is(':focus') == true) {

            }
            else {
                $("#OrganizationUnitCode").focus();
            }
        }
        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if ($("#ShortCode").val() != "") {
            if (checkSpecialCharacter($('#ShortCode').val()) == true) {
                {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = '- A Short Code cannot contain any of these /\\:*?<>|,"+- Characters';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    checkvalue = 1;
                    //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

                    if ($('#OrganizationUnit').is(':focus') == true || $('#OrganizationUnitServer').is(':focus') == true || $('#OrganizationUnitCode').is(':focus') == true) {

                    }
                    else {
                        $("#ShortCode").focus();
                    }
                    //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                }
            }
        }

            if ($("#Address1").val() != "") {
                if (checkSpecialCharacter($('#Address1').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A Address 1 cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                    }
                }
            }

            if ($("#Address2").val() != "") {
                if (checkSpecialCharacter($('#Address2').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A Address 2 cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                    }
                }
            }


            if ($("#City").val() != "") {
                if (checkSpecialCharacter($('#City').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A City  cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                    }
                }
            }


            if ($("#Zip").val() != "") {
                if (checkSpecialCharacter($('#Zip').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A Zip  cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                    }
                }
                else if (RestrictNonNumeric(document.getElementById('Zip')) == true) {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = ' - Please Enter only positive numeric value for Zip';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;

                }

            }

            if ($("#CboCountry").val() != "") {
                if (checkSpecialCharacter($('#Zip').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A Country  cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                    }
                }
            }


            if ($("#Ph1").val() != "") {
                if (checkSpecialCharacter($('#Ph1').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A Phone Number 1  cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                    }
                }

                else if (RestrictNonNumeric(document.getElementById('Ph1')) == true) {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = ' - Please Enter only positive numeric value for Phone Number 1';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;

                }
            }

            if ($("#Ph2").val() != "") {
                if (checkSpecialCharacter($('#Ph2').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A Phone Number 2  cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                    }
                }

                else if (RestrictNonNumeric(document.getElementById('Ph2')) == true) {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = ' - Please Enter only positive numeric value for Phone Number 2';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;

                }
            }

            if ($("#Fax").val() != "") {
                if (checkSpecialCharacter($('#Fax').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A Fax  cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                    }
                }

                else if (RestrictNonNumeric(document.getElementById('Fax')) == true)
                {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = ' - Please Enter only positive numeric value for Fax';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;

                }
            }

            if ($("#Email").val() != "") {
                if (checkSpecialCharacter($('#Email').val()) == true) {
                    {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = '- A Email  cannot contain any of these /\\:*?<>|,"+- Characters';
                        errorMsg += "<li>" + strmsg + "</li>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        checkvalue = 1;

                    }
                }
            }

            if ($("#Email").val() != "") {
                objTxt = $("#Email").val();
                flag = ValidateEmailID(objTxt);
                if (flag == false) {
                    strmsg = '- Email ID should be Valid';
                    errorMsg += "<li>" + strmsg + "</li>";
                    checkvalue = 1;
                }
            }
            var blnWorkingHoursInValid = false; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if ($("#WorkingH").val() == "") {
            strmsg = '- Working Hours should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
            blnWorkingHoursInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }


        if (RestrictNonNumeric(document.getElementById('WorkingH')) == true) {
            // alertify.set('notifier', 'position', 'top-right');
            strmsg = ' - Please Enter only positive numeric value for Working Hours';
            errorMsg += "<li>" + strmsg + "</li>";
            //alertify.notify('', 'error');
            checkvalue = 1;
            blnWorkingHoursInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }

        if ($("#WorkingH").val() != "") {
            if (checkSpecialCharacter($('#WorkingH').val()) == true) {
                {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = '- A Working Hours  cannot contain any of these /\\:*?<>|,"+- Characters';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    checkvalue = 1;
                    blnWorkingHoursInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                }
            }


            var Workingh = $('#WorkingH').val();
            if (parseInt(Workingh) > parseInt(24))
            {
                
                strmsg = '- The value of Working Hours should be in the range of (1-24).</li>';
                errorMsg += "<li>" + strmsg + "</li>";
                Flag = 1;
                checkvalue = 1;
                blnWorkingHoursInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            }
        }

        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        if (blnWorkingHoursInValid == true) {
            if ($('#OrganizationUnit').is(':focus') == true || $('#OrganizationUnitServer').is(':focus') == true || $('#OrganizationUnitCode').is(':focus') == true || $('#ShortCode').is(':focus') == true) {

            }
            else {
                $("#WorkingH").focus();
            }
        }

        var blnWorkingDaysInValid = false; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if ($("#WorkingD").val() == "") {
            strmsg = '- Working Days should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            Flag = 1;
            checkvalue = 1;
            blnWorkingDaysInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }


        if (RestrictNonNumeric(document.getElementById('WorkingD')) == true) {
            // alertify.set('notifier', 'position', 'top-right');
            strmsg = ' - Please Enter only positive numeric value for Working Days';
            errorMsg += "<li>" + strmsg + "</li>";
            //alertify.notify('', 'error');
            checkvalue = 1;
            blnWorkingDaysInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }

        if ($("#WorkingD").val() != "") {
            if (checkSpecialCharacter($('#WorkingD').val()) == true) {
                {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = '- A Working Days  cannot contain any of these /\\:*?<>|,"+- Characters';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    checkvalue = 1;
                    blnWorkingDaysInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                }
            }

            var WorkingD = $('#WorkingD').val();
            if (parseInt(WorkingD) > parseInt(7)) {
                //strMsg += "<li> The value of Working Days should be in the range of (1-7).</li><br>";
                //checkvalue = 1;
                strmsg = '- The value of Working Days should be in the range of (1-7).</li>';
                errorMsg += "<li>" + strmsg + "</li>";
                Flag = 1;
                checkvalue = 1;
                blnWorkingDaysInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            }
        }

        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        if (blnWorkingDaysInValid == true) {
            if ($('#OrganizationUnit').is(':focus') == true || $('#OrganizationUnitServer').is(':focus') == true || $('#OrganizationUnitCode').is(':focus') == true || $('#ShortCode').is(':focus') == true || $("#WorkingH").is(':focus') == true) {

            }
            else {
                $("#WorkingD").focus();
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


    function validateLength() {

        if ($('#ShortCode').length > 4)
        {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Short Code length should be less than 4 digits", 'error', 15);
        }
        else
        {


        }

    }
    var strSaveandAdd = 0;
    function SaveOU()
    {

        if (validationOU() == 0) {

            if (EditOUID != 0) {

                OUID = EditOUID;


            }
            else {

                OUID = 0;

            }

            var CheckActive;
            var OrganizationUnit = $('#OrganizationUnit').val();

            var CheckActive = document.getElementById('CheckActive');
            if (CheckActive.checked == true) {
                CheckActive = 1;
            }
            else {
                CheckActive = 0;
            }




            var OrganizationUnitServer = $('#OrganizationUnitServer').val();

            var OrganizationUnitCode = $('#OrganizationUnitCode').val();

            var ShortCode = $('#ShortCode').val();
            var Address1 = $('#Address1').val();
            var Address2 = $('#Address2').val();
            var City = $('#City').val();
            var Zip = $('#Zip').val();
            var State = $('#State').val();
            var Country = $('#CboCountry').val();

            var Ph1 = $('#Ph1').val();
            var Ph2 = $('#Ph2').val();
            var Fax = $('#Fax').val();
            var Email = $('#Email').val();
            var WorkingH = $('#WorkingH').val();
            var WorkingD = $('#WorkingD').val();


            if (OrganizationUnit == "" || OrganizationUnit == undefined) {

                OrganizationUnit = "";
            }

            if (OrganizationUnitServer == "" || OrganizationUnitServer == undefined) {

                OrganizationUnitServer = "";
            }

            if (OrganizationUnitCode == "" || OrganizationUnitCode == undefined) {

                OrganizationUnitCode = "";
            }

            if (ShortCode == "" || ShortCode == undefined) {

                ShortCode = "";
            }

            if (Address1 == "" || Address1 == undefined) {

                Address1 = "";
            }

            if (Address2 == "" || Address2 == undefined) {

                Address2 = "";
            }

            if (City == "" || City == undefined) {

                City = "";
            }

            if (Zip == "" || Zip == undefined) {

                Zip = "";
            }

            if (State == "" || State == undefined) {

                State = "";
            }

            if (Country == "" || Country == undefined) {

                Country = "";
            }

            if (Ph1 == "" || Ph1 == undefined) {

                Ph1 = "";
            }

            if (Ph2 == "" || Ph2 == undefined) {

                Ph2 = "";
            }

            if (Email == "" || Email == undefined) {

                Email = "";
            }


            if (Fax == "" || Fax == undefined) {

                Fax = "";
            }

            if (WorkingD == "" || WorkingD == undefined) {

                WorkingD = "";
            }

            if (WorkingH == "" || WorkingH == undefined) {

                WorkingH = "";
            }




            data = JSON.stringify({
                OrganizationUnit: OrganizationUnit, CheckActive: CheckActive, OrganizationUnitServer: OrganizationUnitServer, OrganizationUnitCode: OrganizationUnitCode, ShortCode: ShortCode, Address1: Address1,
                Address2: Address2,
                City: City,
                Zip: Zip,
                State: State,
                Country: Country,
                Ph1: Ph1,
                Ph2: Ph2,
                Email: Email,
                Fax: Fax,
                WorkingD: WorkingD,
                WorkingH: WorkingH,
                OUID: OUID


            });

            strResult = AJAXCallWithResult("CRM_OrganizationUnit.aspx/SaveOUDetails", data, false);
            //Commented and Added by Usha Pandit on 24 JAN 2018 for javascript error
            //if (strResult.d != '') {
                if (strResult.d != '' && strResult.d.indexOf("||") != -1) {
                //End of Added by Usha Pandit on 24 JAN 2018 for javascript error
                //alert(strResult.d);
                var MainResult = strResult.d.split("||")
                // var MainResult1 = MainResult.split(",")
                EditOUID = MainResult[0];

                if (MainResult[1] == 1) {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization Unit saved successfully', 'success');

                }

                else {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization Unit  Details Updated successfully', 'success');


                }
                RefreshGrid();
                getdetail(MainResult[0]);
                // EditOU_OnClick(MainResult[0]);
                $("#CustomerFilter").css("display", "block");
                $("#divActivity").css("display", "block");
                $("#CustomerFilter").css("display", "block");
               
            }
        }
      

    }

   
    function SaveAndAddOU(){

        if (validationOU() == 0)
        {
            strSaveandAdd = 1;
           
            if (EditOUID != 0)
            {

                OUID = EditOUID;


            }
            else {

                OUID = 0;

            }

            var CheckActive;
            var OrganizationUnit = $('#OrganizationUnit').val();

            var CheckActive = document.getElementById('CheckActive');
            if (CheckActive.checked == true) {
                CheckActive = 1;
            }
            else {
                CheckActive = 0;
            }




            var OrganizationUnitServer = $('#OrganizationUnitServer').val();

            var OrganizationUnitCode = $('#OrganizationUnitCode').val();

            var ShortCode = $('#ShortCode').val();
            var Address1 = $('#Address1').val();
            var Address2 = $('#Address2').val();
            var City = $('#City').val();
            var Zip = $('#Zip').val();
            var State = $('#State').val();
            var Country = $('#CboCountry').val();

            var Ph1 = $('#Ph1').val();
            var Ph2 = $('#Ph2').val();
            var Fax = $('#Fax').val();
            var Email = $('#Email').val();
            var WorkingH = $('#WorkingH').val();
            var WorkingD = $('#WorkingD').val();


            if (OrganizationUnit == "" || OrganizationUnit == undefined) {

                OrganizationUnit = "";
            }

            if (OrganizationUnitServer == "" || OrganizationUnitServer == undefined) {

                OrganizationUnitServer = "";
            }

            if (OrganizationUnitCode == "" || OrganizationUnitCode == undefined) {

                OrganizationUnitCode = "";
            }

            if (ShortCode == "" || ShortCode == undefined) {

                ShortCode = "";
            }

            if (Address1 == "" || Address1 == undefined) {

                Address1 = "";
            }

            if (Address2 == "" || Address2 == undefined) {

                Address2 = "";
            }

            if (City == "" || City == undefined) {

                City = "";
            }

            if (Zip == "" || Zip == undefined) {

                Zip = "";
            }

            if (State == "" || State == undefined) {

                State = "";
            }

            if (Country == "" || Country == undefined) {

                Country = "";
            }

            if (Ph1 == "" || Ph1 == undefined) {

                Ph1 = "";
            }

            if (Ph2 == "" || Ph2 == undefined) {

                Ph2 = "";
            }

            if (Email == "" || Email == undefined) {

                Email = "";
            }


            if (Fax == "" || Fax == undefined) {

                Fax = "";
            }

            if (WorkingD == "" || WorkingD == undefined) {

                WorkingD = "";
            }

            if (WorkingH == "" || WorkingH == undefined) {

                WorkingH = "";
            }




            data = JSON.stringify({
                OrganizationUnit: OrganizationUnit, CheckActive: CheckActive, OrganizationUnitServer: OrganizationUnitServer, OrganizationUnitCode: OrganizationUnitCode, ShortCode: ShortCode, Address1: Address1,
                Address2: Address2,
                City: City,
                Zip: Zip,
                State: State,
                Country: Country,
                Ph1: Ph1,
                Ph2: Ph2,
                Email: Email,
                Fax: Fax,
                WorkingD: WorkingD,
                WorkingH: WorkingH,
                OUID: OUID


            });

            strResult = AJAXCallWithResult("CRM_OrganizationUnit.aspx/SaveOUDetails", data, false);

            //Commented and Added by Usha Pandit on 24 JAN 2018 for javascript error
            //if (strResult.d != '') {
                if (strResult.d != '' && strResult.d.indexOf("||") != -1) {
            //End of Added by Usha Pandit on 24 JAN 2018 for javascript error

                var MainResult = strResult.d.split("||")
                // var MainResult1 = MainResult.split(",")

                if (MainResult[1] == 1) {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization Unit saved successfully', 'success');

                }

                else {
                    alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Organization Unit  Details Updated successfully', 'success');


                }

                RefreshGrid();
                AddOU();
            }
        }
            
                             
                
  }
    function RefreshGrid() {
        var strResult, data;
       
        data = JSON.stringify({})

        strResult = AJAXCallWithResult("CRM_OrganizationUnit.aspx/RefreshPlotGrid", data, false);
        var DivId;
        var DivSerach;
       
        if (strResult.d != '') {

            DivId = "divOU";
            DivSerach = "txtSearchHistory";

            $("#divMain").html("");
            $("#divMain").html(strResult.d);

            $(".table-responsive:first table").addClass("table");
        }
        RefreshGridDetails();
    }


    function CancelOU() {

            $("#divOU").css("display", "block");
            $('#OrganizationUnit').val("");
            if ($("#CheckActive").checked == true) {
                $("#CheckActive").prop('checked', true);
            }
            else {
                $("#CheckActive").prop('checked', false);
            }

            $('#OrganizationUnitServer').val("");
            document.getElementById('OrganizationUnitCode').disabled = false;
            $('#OrganizationUnitCode').val("");
            $('#ShortCode').val("");
            $('#Address1').val("");
            $('#Address2').val("");
            $('#City').val("");
            $('#Zip').val("");
            $('#State').val("");
            $('#CboCountry').val("");

            $('#Ph1').val("");
            $('#Ph2').val("");
            $('#Fax').val("");
            $('#Email').val("");
            $('#WorkingH').val("");
            $('#WorkingD').val("");
            EditActivityID = 0;
            $("#CustomerFilter").css("display", "block");
            $("#History").css("display", "none");

        }

        function checkSpecialCharacter(value)
        {
            var regularExpression = '/\:*?<>|,"+-';///\:*?<>|,"+- 
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
                    //setFocus(obj);    //Commented by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                }
                return true;
            }
            return false;
        }

        var AjaxResult;
        function AJAXCallWithResult(url, data, async) {
            console.log(url);
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
                    window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

            return AjaxResult;
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


        function ShowHistory_OnClick() {

            var obj = { "UniqueID": EditOUID };
            var myJSON = JSON.stringify(obj);
            var url = "CRM_OrganizationUnit.aspx/ShowMailHistoryDetails"

            var result = AJAXCallWithResult(url, myJSON, false)

                $("#id13 #modalbody").html(result.d);
                document.getElementById('id13').style.display = 'block';
                datatables("ShowHistoryGrid", 'txtSearchHistory');
            }

          

        
        function ModifiedFieldFilter_Change() {

            var ModifiedField = $('#cboModifiedField :selected').text();
            var ModifiedBy = $('#cboModifiedBy :selected').text();

            var obj = { "newModifiedField": ModifiedField, "MessageID": EditOUID, "newModifiedBy": ModifiedBy };
            var myJSON = JSON.stringify(obj);

            var url = "CRM_OrganizationUnit.aspx/FilteredHistory"
            var result = AJAXCallWithResult(url, myJSON, false)
            $("#id13 #modalbody").html(result.d);

            datatables("ShowHistoryGrid", 'txtSearchHistory');

            document.getElementById('id13').style.display = 'block';
        }



        function DeleteSelect_OU() {
            //debugger;
            var SelectedOU;
            var table = $('#divOU table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();

            if (document.getElementById('chkAllOU').checked == true) {
                SelectedOU = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                    return this.value;
                }).get().join(',');
            }
            else {
                SelectedOU = arrSelectedCheck.join();
            }
           
            //data1 = JSON.stringify({ SelectedOU: SelectedOU });
            //strResult1 = AJAXCallWithResult("CRM_OrganizationUnit.aspx/DeleteOU", data1, false);
            ////alert(strResult1.d);
            //if (strResult1.d == 2) {
            //    //alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            //    //alertify.set('notifier', 'position', 'top-right');
            //    //alertify.notify("Organization Unit deleted successfully", 'success');
            //    //RefreshGrid('OU');
            //    //$("#CboOU").val("");
            //    //$("#UnitName").val("");
            //    //$("#UnitCode").val("");



            //}
            //else {
            //    //alertify.set('notifier', 'position', 'top-right');
            //    //alertify.notify("Organization Unit is in uesed,can not  delete", 'error');


            //}

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

</script>