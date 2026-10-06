<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_RoleAccess.aspx.vb" Inherits="PbNIT.CRM_RoleAccess" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head>

    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
     <%--<meta charset="utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/timepicker.min.css" />
   <%-- <link href="../../General/loaderStylesheet.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />

    <title></title>--%>
</head>

  <style>


      .h-type .form-group {
          font-size:12px;
          font-weight:100;
      }

      #cboModule {
          height:30px!important;
          font-size:12px!important;
          font-weight:100!important;
      }

      .control-label {
          line-height:37.2px!important;
      }

      #cboRole {
          height:30px!important;
          width:250px!important;
            font-size:12px!important;
          font-weight:100!important;
      }

      .ClsTR {
          font-size:12px!important;
          background-color:white!important;
      }

      .dataTables_length {
          display:none!important;
      }

      .dataTables_filter {
               display:none!important;
      }

      #DivList  {
         /*Added By Kashish for ui change*/
         width:101%!important;
         overflow:auto!important;

      }

     #MainOuterDiv {
        width: 100%!important;
      
        padding-right: 2%!important;
        overflow: hidden!important;
}

      /*#DivList .dataTables_scrollBody {
          height:190px!important;
      }*/

      #DivList .dataTables_paginate{
          float:right!important;
      }

       .btn-primary {
        margin:4px;
    }
    .divBtn {
        float:right;
        font-size:12px!important;
        margin-right: 3%;
        margin-top:-6%;
    }

      #DivList ul.pagination {
          margin-top:3%!important;
      }

      /*#labelRole {
          width:10%;
      }

      #labelModule {
           width:22%;
      }*/


        .FixedTD {
            /*background-color:#F0D1A1;/*#e6ffff*/
            padding: 5px !important;
            position: relative;
            /*background-clip: padding-box;*/
            /*background-color:#f0ccc3!important;*/
            border: 1px solid white;
        }

        #DivList .table thead > tr > th {
            position: relative;
            left: 0px;
            padding: 5px;
            z-index: 99999;
        }
      #labelModule {
         white-space:nowrap;
      }
      #preloader {
          TOP:40%;
      }
   /*#DivList table { position:fixed; width: 100%; height: 230px;}
 #DivList tr {  }
 
 #DivList thead, tbody { overflow-y: scroll; }
 #DivList tbody { height: 230px; }*/
 

  </style>

<body>
    <form id="frmRoleAccess" method="post">
    <div>
       <input type="hidden" id="hdnRoleID" name="hdnRoleID" value="" />
     
          <%PageInit("", "Load", "")%>
    </div>
    </form>
</body>
</html>

     <!-- Bootstrap core JavaScript -->
<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
<script src="../../../Whizible2.0-new/dist/js/editor.js"></script>
<script src="../../../Whizible2.0-new/dist/js/timepicker.min.js"></script>
<%--<script src="../../General/CommonFunctions.js"></script>
<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
<script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

<script>
    var objform, objdivlist;
    objform = GetFormReference('frmRoleAccess');
    objdivlist = GetObjectReference('frmRoleAccess', 'DivList');
    $(window).load(function () {
      
        RefreshGridDetails();
        RemoveFrameLoader();
        var color = $('.clsTRColumnHeader').css('background-color');
        $(".FixedTD").css("background-color", color);
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

        if (WhichBrowser() == "IE")
        {
            intDivGridHeight = (window.innerHeight / 2);
         
            if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
               // alert('111');
                intDivGridListHeight = parseInt(window.innerHeight) + 150;
                $('#Type #DivList').css('height', intDivGridListHeight + "px");
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                //alert('11');
                intDivGridListHeight = parseInt(window.innerHeight) - 300;
                $('#Type #DivList').css('height', intDivGridListHeight + "px");
            }
            else {
                //alert('1');
                intDivGridListHeight = parseInt(window.innerHeight) - 350;
                $('#Type #DivList').css('height', intDivGridListHeight + "px");
            }

            // alert('1');
            //alert(intDivGridListHeight - 500);
            //   $('.panel-body').css('height', intDivGridListHeight + "px");
           // $('#divRequestTypes').css('height', intDivGridListHeight - 550 + "px");
           // $('#DivList').css('height', " 400px");
            // $('#Type').css('height', intDivGridListHeight + 500 + "px");
        }
        else
        {
            intDivGridHeight = (window.innerHeight / 2);
            // alert('2');
            if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
                
                intDivGridListHeight = parseInt(window.innerHeight) + 200;
              
                $('#Type #DivList').css('height', intDivGridListHeight + "px");
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                 

                intDivGridListHeight = parseInt(window.innerHeight) - 350;
               
                $('#Type #DivList').css('height', intDivGridListHeight + "px");
            }
            else {
              
                intDivGridListHeight = parseInt(window.innerHeight) - 400;
               // alert(2);
                $('#Type #DivList').css('height', intDivGridListHeight + "px");
            }
               // $('#DivList').css('margin-top', "-2%");

              
        }   
        
        $(".FixedTD").css("top", "0px")
        $("#DivList").scroll(function () {
            $(".FixedTD").css("top", $("#DivList").scrollTop() - 1);
        });
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
            "pageLength": 10,
            scrollY: height + 'px',
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
    $("#cboRole").change(function () {
      //  alert();
        var returnHTML = "";
        returnHTML = LoadXmlDoc("CRM_RoleAccess.aspx?MasterTagID=312&strAction=Refresh&FromWhere=SM&Mode=Role&ModuleID=" + $("#cboModule").val() + "&RoleID=" + $("#cboRole").val())
       // alert(returnHTML);
        document.getElementById("DivList").innerHTML = "";
        document.getElementById("DivList").innerHTML = returnHTML;
        RefreshGridDetails();
    })
    function Module_OnChange() {

        var returnHTML = "";
        returnHTML = LoadXmlDoc("CRM_RoleAccess.aspx?MasterTagID=312&strAction=Refresh&FromWhere=SM&Mode=Role&ModuleID=" + $("#cboModule").val() + "&RoleID=" + $("#cboRole").val())
      
      
        document.getElementById("DivList").innerHTML = "";
        document.getElementById("DivList").innerHTML = returnHTML;
        RefreshGridDetails();
    }

    var strResult;
    function LoadXmlDoc(strUrl)
    {
       
        var Browser = WhichBrowser();
        strNavigator = navigator.appName;
        strNavigator = strNavigator.toUpperCase();

        if (Browser == 'IE') {
            g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
            g_objXHttp.onreadystatechange = state_change;
            //prepare the call, http method=GET, false=asynchronous call
            g_objXHttp.open("GET", strUrl, false);
            //finally send the call
            g_objXHttp.send();
        }
        else {
            // Mozilla - based browser , Netscape
            g_objXHttp = new XMLHttpRequest();
            //hook the event handler
            g_objXHttp.onreadystatechange = state_change;
            //prepare the call, http method=GET, false=asynchronous call
            g_objXHttp.open("GET", strUrl, false);
            //finally send the call
            g_objXHttp.send(null);

            if (g_objXHttp.responseText != null) {
                xmlDoc = document.implementation.createDocument("", "", null);
                xmlDoc.async = false;
                if (Browser == 'FF')
                    xmlDoc.load(g_objXHttp.responseXML);
                strResult = g_objXHttp.responseText;
            }
        }
        return strResult;
    }
    function state_change()
    {
        var Browser = WhichBrowser();
        if (g_objXHttp.readyState == 4) {
            // Make sure request came back OK 
            if (g_objXHttp.status == 200) {
                //if (window.ActiveXObject)
                if (Browser == 'IE') {
                    xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                    xmlDoc.async = false;
                    xmlDoc.loadXML(g_objXHttp.responseText);
                }
                    // code for Mozilla, etc.
                else if (document.implementation && document.implementation.createDocument) {
                    xmlDoc = document.implementation.createDocument("", "", null);
                    xmlDoc.async = false;
                    if (Browser == 'FF')
                        xmlDoc.load(g_objXHttp.responseXML);
                }
                //Save the Result in a Global variable
                strResult = g_objXHttp.responseText;
            }
        }
    }
    
    function Access_OnClick(indx) {//debugger;
       // debugger;
       // alert(indx);
        var objChkAdd, objChkEdit, objChkDel, objChkView;
        var objChkAccess, objModule;

        objModule = GetObjectReference('frmRoleAccess', 'cboModule');
        if (objModule != null && objModule.value == 'BTS')
        {
            objChkAccess = GetObjectReference('frmRoleAccess', 'chkAccess');
            objChkAdd = GetObjectReference('frmRoleAccess', 'chkAdd');
            objChkEdit = GetObjectReference('frmRoleAccess', 'chkEdit');
            objChkDel = GetObjectReference('frmRoleAccess', 'chkDelete');
            objChkView = GetObjectReference('frmRoleAccess', 'chkView');

            objChkAdd.disabled = !objChkAccess.checked;
            objChkEdit.disabled = !objChkAccess.checked;
            objChkDel.disabled = !objChkAccess.checked;
            objChkView.disabled = !objChkAccess.checked;

            objChkAdd.checked = objChkAccess.checked;
            objChkEdit.checked = objChkAccess.checked;
            objChkDel.checked = objChkAccess.checked;
            objChkView.checked = objChkAccess.checked;
        }
        else {//Added By Ninad on 18 May 2009 IssueID-30417
            if (isNaN(indx)) {
                var objChk = GetObjectEvent(indx);
                try {
                    document.getElementById('chkAdd' + objChk.value).checked = objChk.checked;
                    document.getElementById('chkEdit' + objChk.value).checked = objChk.checked;
                    document.getElementById('chkDelete' + objChk.value).checked = objChk.checked;
                    document.getElementById('chkView' + objChk.value).checked = objChk.checked;
                } catch (e) { }
                var objRows = document.getElementsByName(objChk.name + arguments[1] + 'TR')
                for (var i = 0; i < objRows.length; i++) {
                    var ele = null;
                    ele = objRows[i].all
                    if (ele != null) {
                        for (j = 0; j < ele.length; j++) {
                            if (ele[j].type == 'checkbox') {
                                if (ele[j].value != '') {
                                    if (ele[j].id.substring(0, 9).toUpperCase() != 'CHKACCESS')
                                        ele[j].disabled = !objChk.checked;
                                    ele[j].checked = objChk.checked;
                                }
                            }
                        }
                    }
                }
            }
            else {
                var objChk = GetObjectEvent(arguments[1]);
                //Modified By Ninad on 13 July 2009 ReqID-WAF3_PB_74
                objChkAdd = GetObjectReference('frmRoleAccess', 'chkAdd', true);
                if (objChkAdd.length > 0)
                {
                    objChkEdit = GetObjectReference('frmRoleAccess', 'chkEdit', true);
                    objChkDel = GetObjectReference('frmRoleAccess', 'chkDelete', true);
                    objChkView = GetObjectReference('frmRoleAccess', 'chkView', true);
                    //alert(objChkAdd);
                    //alert(objChkAdd[indx]);
                    objChkAdd[indx].disabled = !objChk.checked;
                    objChkEdit[indx].disabled = !objChk.checked;
                    objChkDel[indx].disabled = !objChk.checked;
                    objChkView[indx].disabled = !objChk.checked;

                    objChkAdd[indx].checked = objChk.checked;
                    objChkEdit[indx].checked = objChk.checked;
                    objChkDel[indx].checked = objChk.checked;
                    objChkView[indx].checked = objChk.checked;

                    //objChkAdd.disabled = !objChk.checked;
                    //objChkEdit.disabled = !objChk.checked;
                    //objChkDel.disabled = !objChk.checked;
                    //objChkView.disabled = !objChk.checked;

                    //objChkAdd.checked = objChk.checked;
                    //objChkEdit.checked = objChk.checked;
                    //objChkDel.checked = objChk.checked;
                    //objChkView.checked = objChk.checked;
                }
                else {
                    objChkAdd = GetObjectReference('frmRoleAccess', 'chkAdd' + objChk.value);
                    objChkEdit = GetObjectReference('frmRoleAccess', 'chkEdit' + objChk.value);
                    objChkDel = GetObjectReference('frmRoleAccess', 'chkDelete' + objChk.value);
                    objChkView = GetObjectReference('frmRoleAccess', 'chkView' + objChk.value);
                    objChkAdd.disabled = !objChk.checked;
                    objChkEdit.disabled = !objChk.checked;
                    objChkDel.disabled = !objChk.checked;
                    objChkView.disabled = !objChk.checked;

                    objChkAdd.checked = objChk.checked;
                    objChkEdit.checked = objChk.checked;
                    objChkDel.checked = objChk.checked;
                    objChkView.checked = objChk.checked;
                }
                //End Modification By Ninad on 13 July 2009 ReqID-WAF3_PB_74					
                //End Addition By Ninad on 18 May 2009 IssueID-30417
            }

        }
    }
    function GetObjectReference(strFormId, strElementId, blnIsName)
    {
        var objElement;
        var objCombo;

        if (blnIsName) {
            objElement = document.getElementsByName(strElementId);
        }
        else if (!(blnIsName)) {
            objElement = document.getElementById(strElementId);
        }
        return objElement;

    }
    var ns;
    if (navigator.appName == 'Netscape')
        ns = true;
    else
        ns = false;
    function GetFormReference(strFormId)
    {
        var objElement;

        objElement = document.getElementById(strFormId);
        return objElement;

    }
    function GetObjectEvent(e)
    {
        var objElement;
        if (ns)
        {
            objElement = e.target;
        }
        else
        {
            objElement = e.srcElement;
        }

        return objElement;
    }
    //For Clear All CheckBox
    function ClearAll_OnClick() {
        var ele = null;
        ele = document.getElementsByTagName("input");
        if (ele != null) {
            for (i = 0; i < ele.length; i++) {
                if (ele[i].type == 'checkbox') {
                    if (ele[i].value != '') {
                        if (ele[i].id.substring(0, 9).toUpperCase() != 'CHKACCESS')
                            ele[i].disabled = true;
                        ele[i].checked = false;
                    }
                }
            }
        }
    }
    //For Select All CheckBox
    function SelectAll_OnClick() {
        var ele = null;
        ele = document.getElementsByTagName("input");
        if (ele != null) {
            for (i = 0; i < ele.length; i++) {
                if (ele[i].type == 'checkbox') {
                    if (ele[i].value != '') {
                        ele[i].disabled = false;
                        ele[i].checked = true;
                    }
                }
            }
        }
    }

    function Save_OnClick(ACTION)
    {
       
        var Mode = (arguments.length > 1) ? arguments[1] : "1";
       // alert(Mode);
        if (Mode == "0")
        {
            document.body.readonly = true;
            window.setTimeout('Save_OnClick("' + ACTION + '","1")', 1);

        }
        if (Mode == "1") {
            var objTxt, count;

            objTxt = GetObjectReference('frmRoleAccess', 'hdtxtRowCount');
            count = objTxt.value;
           
            if (count > 0)
            {
               
                //var MenuTags = document.getElementsByTagName('A');
                //for (i = 0; i < MenuTags.length; i++) {
                //    if (MenuTags[i].className == "Menu") {
                //        //MenuTags[i].style.display= "none";
                //        MenuTags[i].parentNode.style.display = "none";
                //    }
                //}
              
                objform.action = "CRM_RoleAccess.aspx?MasterTagID=312&FromWhere=SM&Mode=Role&RoleID=" + $("#cboRole").val() + "&Action=" + ACTION + "&TagID=<%=m_lngTagID%>&ModuleID=" + $("#cboModule").val();
                // alert(objform.action);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Data Saved Successfully', 'success',5);
                // return;
                setFrameLoader();
                setTimeout(function () { objform.submit() }, 500);
             


               }
            }
        }
</script>