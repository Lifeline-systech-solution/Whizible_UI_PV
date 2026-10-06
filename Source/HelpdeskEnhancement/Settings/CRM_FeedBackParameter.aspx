<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_FeedBackParameter.aspx.vb" Inherits="PbNIT.CRM_FeedBackParameter" %>

<!DOCTYPE html>
<html lang="en">

<%CommonFunctions.General.PlotPageHeadTag("Setting")%>
  <head>
    <%--<meta charset="utf-8" />--%>
    <meta name="description" content="" />
    <meta name="author" content="" />
       <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("CRM_FeedBackParameter")%>--%>
    <%--<title>Setting</title>--%>
   
<!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
<meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
<meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
<meta name='vs_defaultClientScript' content='JavaScript'>
<meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache">
<link rel='stylesheet' type='text/css' href='../General/StyleSheetChanakya_Purple.css'/>
<link  id='lnkWhizStyleSheetImgDir' type='text/plain' href=' images/purple/'/>
<script language='javascript' src='EnhancementFiles/CommonFunctions.js'></script>
   
    <!-- Bootstrap core CSS -->
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/timepicker.min.css" />
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

</HEAD>

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

      

        #divActivity .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        #divActivity .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
         
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
       #divActivity .dataTables_wrapper {
           padding-right:15px;
        padding-left: 0px;
        margin-right: auto;
        margin-left: auto;
         }
        #accordion {
        overflow:hidden;#divActivity .dataTables_scrollBody
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
       #divActivity .dataTables_scroll {
        OVERFLOW: HIDDEN;
        }
        #divActivity .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            /*height: 180px;*/
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
        font-weight:100;
        }
          #divStatus .dataTables_scrollHeadInner table  .clsTRColumnHeader tr th:nth-child(4) {
            text-align:left;
        }
          /*select.form-control:not([size]):not([multiple]) {
    height: calc(2.25rem + 7px);
        }*/
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
        .form-horizontal{
    width: 100%;
    line-height: 2;
}
        #accordion4 .form-group {
        border-bottom:none;
        }

        #tblTypeSLADetails .clsTxtControls {
        width: 43px !important;
        } 
        #tblTypeSLADetails .clscboControls {
        width:79px !important;
        margin-left:4PX;
        }
       #tblTypeSLADetails .col-sm-4 {
        padding-right:30PX;
        }
       #tblTypeSLADetails .form-group {
       float:none;
       
        }
        .container-fluid {
        min-height:0px !important;
        }
        #CboType {
        width:75px;
        }

        #idSearchHistory {
    position: absolute;
    margin-top: 14px;
    margin-left: 10px;
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
        /*'/*commented by Kashish for ui change*/
        /*width:102%;*/
        padding-right:2%;
        overflow:auto;
      }
  #divCustomerLogin .collapseOne2 {
            overflow:hidden!important;
            width:100%!important;
        }

    #divCustomerLogin .dataTables_scrollBody .clsTRColumnHeader{
        height:0px!important;
        }

        #divCustomerLogin .dataTables_paginate {
            float:right!important;
        }
          #divCustomerLogin .dataTables_paginate ul {
             margin-top: 2%!important;
             margin-left: -5%!important;
        }
#divCustomerLogin .dataTables_scrollBody {
           overflow: auto!important;
            width: 101.5%!important;
            /*height: 132px!important;*/
            padding-right: 1.8%!important;
}

        #divCustomerLogin .dataTables_scroll {
            overflow: hidden!important;
            width: 100%!important;

        }
 #divCustomerLogin table tr th {
             border:1px solid #ddd!important;
              
            }
	    /*Added by Kashish for ui change*/
	    #CustomerFilter {
            margin-top: -3%!important;
            padding-bottom:15px !important;

	    }
	    #cboDepartment {
            height:29px;
	    }
	    #CboRole {
            height:29px;
	    }
	    #CboStatus {
             height:29px;
	    }
	    /*.right .btn-default {
            background:#641a02 !important;
            color : white !important;
	    }
           .right .btn-default:hover {
             background:#641a02 !important;
            color : white !important;
	    }*/
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
	        height: 189px!important;
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
  </div>       
  
</body>
     <%-- *************************************************** Modal Plotting **************************************************************** --%>
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
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter 916", 173, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                         <label class="control-label col-sm-2 clslabel" for="request type code">Modified By</label>
                        <div class="col-sm-4">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 916 ", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>

                    </div>
                    <%--<div class="form-group"
                        <label class="control-label col-sm-2" for="request type code">Modified By</label>
                        <div class="col-sm-3">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter 916", 173, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                        </div>
                    </div>--%>
                    <div class="container-fluid" id="modalbody" style="overflow:auto;height: 191px;">
                    </div>
                </div>
            </form>
        </div>
    <!-- Bootstrap core JavaScript -->
    
<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
<script src="../../../Whizible2.0-new/dist/js/popper.min.js"></script>
<%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
<script src="../../../Whizible2.0-new/dist/js/New_CommonFunctions.js"></script>
<%--<script src="../../General/CommonFunctions.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
<script src="../../../EnhancementFiles/vendor/popper/popper.min.js"></script>
<script src="../../../Whizible2.0-new/dist/js/editor.js"></script>
<%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
<script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

<script>
     <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
    disableRightClick();
		    <%End If%>
    $(document).click(function () {
        //alert(window.parent.parent.parent.location);
        $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

    })

    var EditActivityID = 0;
    $(document).ready(function () {
        RefreshGridDetails();
    });

</script>
    
<script>
    var strPageName = "CRM_FeedBackParameter.aspx"
    function openCity(evt, cityName, strTabURL) {

        $(".btnSettingTab").removeClass("active");
        evt.currentTarget.className += " active";

        setFrameLoader();

        $("#frmSettingsTabs").attr("src", "" + strTabURL + "");

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
    // Get the element with id="defaultOpen" and click on it
    //document.getElementById("defaultOpen").click();
    function AddCustomer() {
        RefreshGrid();
        $("#divActivity").css("display", "none");

    }


    function Cancel_Login() {
        // alert(Flag);
     
        $("#divActivity").css("display", "block");
        $("#txtActivity").val();
        $('#txtParameter').val("");
        $('#txtRating').val("");
        EditActivityID = 0;
        $("#CustomerFilter").css("display", "block");
        $("#History").css("display", "none");
    }
    function DeleteMultiple_Activity() {
        //Modified By Chakshuta H on 28th-Dec-2017 Purpose:For Selecting checkbox accross pagination
       // var table = $('#DataTables_Table_0').DataTable();
        var table = $('#divActivityGrid table').DataTable();        
        var rows = table.rows({ 'search': 'applied' }).nodes();
                       
        if (document.getElementById('chkAllActivity').checked == true) {
            //$("input[name=chkActivityDelete]:not(:disabled)").prop('checked', true);
            $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
        }
        else {
            //$("input[name=chkActivityDelete]").prop('checked', false);
            $('input[type="checkbox"]', rows).prop('checked', false);
        }
        //End Of By Chakshuta H on 28th-Dec-2017 Purpose:For Selecting checkbox accross pagination
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

    function RefreshGrid() {
        var strResult, data;
        //EditActivityID = 0;
        //alert(Status)

        //data = JSON.stringify({ GridParameter: GridParameter });
        data = JSON.stringify({})

        strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
        var DivId;
        var DivSerach;
        //  alert(strResult.d);
        if (strResult.d != '') {

            DivId = "divMain";
            DivSerach = "txtSearchHistory";

            $("#divMain").html("");
            $("#divMain").html(strResult.d);

            $(".table-responsive:first table").addClass("table");
        }
        RefreshGridDetails();
    }
    function RefreshGridDetails() {
        //  debugger;

        var strResult, data;
        var GridParameter = {};
        var DivId;
        var DivSerach;

        DivId = "divActivityGrid";
        DivSerach = "txtSearchHistory";

        var TypeDiv; var accordion;
        var intDivGridHeight

        if (WhichBrowser() == "IE") {
            intDivGridHeight = (window.innerHeight / 2);

            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

                intDivGridListHeight = parseInt(window.innerHeight) - 500;
                $('#divActivity').css('height', intDivGridListHeight - 140 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }

            else if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024)) {

                intDivGridListHeight = parseInt(window.innerHeight) - 355;
                $('#divActivity').css('height', intDivGridListHeight - 150 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                intDivGridListHeight = parseInt(window.innerHeight) - 200;
            }
            else {

                intDivGridListHeight = parseInt(window.innerHeight) - 100;

            }
            $('#divActivity').css('height', intDivGridListHeight - 650 + 'px');
            $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
        }
        else {
            intDivGridHeight = (window.innerHeight / 2);

            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
               // alert(1);
                intDivGridListHeight = parseInt(window.innerHeight) - 370;
                $('#divActivity').css('height', intDivGridListHeight - 180 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
               // alert(2);
                intDivGridListHeight = parseInt(window.innerHeight) - 360;
                //alert(intDivGridListHeight + 450);
                $('#divActivity').css('height', intDivGridListHeight - 140 + 'px');

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
               // alert(3);
                intDivGridListHeight = parseInt(window.innerHeight) - 470;
              
                $('#divActivity').css('height', intDivGridListHeight - 100 + 'px');

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }
            else {
                //alert(4);
                intDivGridListHeight = parseInt(window.innerHeight) - 570;

                //$('#divActivity').css('height', intDivGridListHeight - 100 + "px");

                //$('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }


            $('#divActivity').css('height', intDivGridListHeight - 200 + 'px');
            $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            //    $('#Type').css('height', intDivGridListHeight + 500  + "px");
        }

        //   $(".table-responsive:first table").addClass("table");
        datatables(DivId, DivSerach, intDivGridListHeight);
        //setWidthDatatable(DivId);

    }
    function datatables(divID, txtBoxID) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
       
        var table = $('#' + divID + ' > table').DataTable({
            ordering : false,
            responsive: true, "pageLength": 3,
            //scrollY: '165px',
            pagingType: "simple_numbers",
            scrollX: true,
            language: {
                //paginate: {
                //    first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
                //    next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
                //    previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
                //    last: '<i class="fa fa-angle-right" title="Last"></i>'
                //}
            },
            
        });
        // debugger;
        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }



    $("#frmSettingsTabs").load(function () {
        RemoveFrameLoader();
    });
    var strSaveandAdd = 0;
    function SaveActivity() {
      
        //debugger;
        if (ValidateFeedBack() == 0) {
            var ActivityID = EditActivityID;
            var Parameter = $("#txtParameter").val();
            var Rating = $("#txtRating").val();
            var dataSave;
            dataSave = JSON.stringify({ ActivityID: ActivityID, Parameter: Parameter, Rating: Rating });
            //  alert(data);
            strResult = AJAXCallWithResult("CRM_FeedBackParameter.aspx/SaveActivity", dataSave, false);

            if (strResult.d != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('FeedBack Parameter saved successfully', 'success');
                RefreshGrid();
                $('#txtParameter').val(Parameter);
                $('#txtRating').val(Rating);
                

            }
          }
        
    }
    function SaveAndAddActivity() {

        if (ValidateFeedBack() == 0) {
            strSaveandAdd = 1;
            //var ActivityID = $("#chkActivityDelete").val();
            var ActivityID = EditActivityID;
            var Parameter = $("#txtParameter").val();
            var Rating = $("#txtRating").val();

            data = JSON.stringify({ ActivityID: ActivityID, Parameter: Parameter, Rating: Rating });
            //  alert(data);
            strResult = AJAXCallWithResult("CRM_FeedBackParameter.aspx/SaveActivity", data, false);

            if (strResult.d != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('FeedBack Parameter saved successfully', 'success');
                             
                RefreshGrid();
                AddActivity();

            }
        }

    }
   
    function Activity_OnClick(ActivityID) {
        $("#History").css("display", "inline");
        EditActivityID = ActivityID;
        var EditActivity = '';
        var EditRating = '';
        if (document.getElementById('txthdnActivity_' + ActivityID) != null) {
            EditActivity = document.getElementById('txthdnActivity_' + ActivityID).value;
        }
        if (document.getElementById('txthdnRating_' + ActivityID) != null) {
            EditRating = document.getElementById('txthdnRating_' + ActivityID).value;
        }
        $('#txtParameter').val(EditActivity);
        $('#txtRating').val(EditRating);
        $("#divActivity").css("display", "none");
        $("#CustomerFilter").css("display", "none");
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
    function ValidateFeedBack()
    {
        var chkVal = 0;
        var strMsg = "";
        var objtxtActivity;
        var Activity = $("#txtParameter").val();
        var Rating = $("#txtRating").val();
        objtxtRating = GetObjectReference("", "txtRating");
        disallowSpecialCharacters(objtxtRating)
        if ($("#txtParameter").val() == "") {
            strMsg += "<li> Feedback Parameter should not be left blank. </li><br>";
            chkVal = 1;
        }
        if ($("#txtRating").val() == "") {
            strMsg += "<li> Rating should not be left blank. </li><br>";
            chkVal = 1;
        }
               
        if (isNaN(Rating)) {           
            strMsg += "<li>The value of Rating should be in the range of (1-10).</li><br>";
            chkVal = 1;
        }

        if (parseInt(Rating) > parseInt(10)) {
            strMsg += "<li> The value of Rating should be in the range of (1-10). </li><br>";
            chkVal = 1;
        }
        else if (parseInt(Rating) < parseInt(1)) {
            strMsg += "<li> The value of Rating should be in the range of (1-10). </li><br>";
            chkVal = 1;
        }
        //alert(EditActivityID);
        //if (EditActivityID == '') {
            data = JSON.stringify({ Rating: Rating, EditActivityID: EditActivityID });
            //alert(data);
            strResult = AJAXCallWithResult("CRM_FeedBackParameter.aspx/CheckIsDuplicate", data, false);
            if (strResult.d == "1") {
                strMsg += "<li> Rating already exists. </li><br>";
                chkVal = 1;
            }
        //}
       
      
        //if (disallowSpecialCharacters(objtxtRating))
        //{
        //    strMsg += 'A Rating cannot contain any of these /\\:*?<>|,"+- characters.'
        //    chkVal = 1;
        //}
            strMsg = strMsg.substr(0, strMsg.length - 1);
        //alert(strMsg);
            var n = strMsg.indexOf("<li>");
        //alert(n);
            //strMsg = strMsg.substr(1);           
            strMsg = strMsg.replace(/<li>|_/g, '-');           
            //strMsg = strMsg.replace("</li>", '\n');//strMsg.replace("<li>", "-");
            //alert(strMsg);
        if (strMsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }

        return chkVal;
    }

    function DeleteActivity() {
      
        var strActivityIDs;
        var strMsg;

        //Added By Chakshuta H on 28th-Dec-2017 Purpose:For Selecting checkbox accross pagination
        var table = $('#divActivityGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        //strActivityIDs = $('input[name=chkActivityDelete]:checked').map(function () {
        //    return this.value;
        //}).get().join(',');
        //strActivityIDs = $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true).map(function () {
        //    return this.value;
        //}).get().join(',');

        if (document.getElementById('chkAllActivity').checked == true) {
            strActivityIDs = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                return this.value;
            }).get().join(',');
        }
        else {
            strActivityIDs = $('input[name=chkActivityDelete]:checked').map(function () {
                return this.value;
            }).get().join(',');
        }
        //End Of Added By Chakshuta H on 28th-Dec-2017 For Selecting checkbox accross pagination

        //alert(strActivityIDs);

        if (strActivityIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');         //added by Usha Pandit on 18.12.2017
            alertify.notify('Please select at least one Feedback Parameter record for deletion', 'error');  //added by Usha Pandit on 18.12.2017
            return;
        }
        data = JSON.stringify({ ActivityID: strActivityIDs });

        strMsg = AJAXCallWithResult(strPageName + "/DeleteActivity", data, false);
        //alert(strMsg.d);
        if (strMsg.d != "")
        {
            if (strMsg.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.notify(strMsg.d, 'success');
                alertify.notify('Feedback Parameter is in use, Cannot be deleted.', 'error');
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.notify(strMsg.d, 'success');
                alertify.notify('Feedback Parameter deleted successfully', 'success');
            }
        }
       
        RefreshGrid();

    }
    function AddActivity() {
        //RefreshGrid();
        $("#divActivity").css("display", "none");
        $('#txtParameter').val("");
        $('#txtRating').val("");
        EditActivityID = 0;
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
    function ShowHistory_OnClick() {

        var obj = { "UniqueID": EditActivityID };
        var myJSON = JSON.stringify(obj);
        var url = "CRM_FeedBackParameter.aspx/ShowMailHistoryDetails"

        var result = AJAXCallWithResult(url, myJSON, false)

        if (EditActivityID == undefined || EditActivityID == 0) {

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select atleast one entry..', 'error');
        }
        else {

            $("#id13 #modalbody").html(result.d);
            document.getElementById('id13').style.display = 'block';
        }

        datatables("ShowHistoryGrid", 'txtSearchHistory');

    }
    function ModifiedFieldFilter_Change() {

        var ModifiedField = $('#cboModifiedField :selected').text();
        var ModifiedBy = $('#cboModifiedBy :selected').text();

        var obj = { "newModifiedField": ModifiedField, "MessageID": EditActivityID, "newModifiedBy": ModifiedBy };
        var myJSON = JSON.stringify(obj);

        var url = "CRM_FeedBackParameter.aspx/FilteredHistory"
        var result = AJAXCallWithResult(url, myJSON, false)
        $("#id13 #modalbody").html(result.d);

        datatables("ShowHistoryGrid", 'txtSearchHistory');

        document.getElementById('id13').style.display = 'block';
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




   
</html>

