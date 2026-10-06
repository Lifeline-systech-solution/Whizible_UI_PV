<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyProfile.aspx.vb" Inherits="PbNIT.MyProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
    <%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>

    <%--  <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">--%>

    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" /> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css" />
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src='../../General/CommonFunctions.js'></script> -->
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

    <title></title>
   
</head>

<style>
    .form-control {
        width: 200px !important;
        color: #000;
    }

    select.form-control:not([size]):not([multiple]) {
        /*height: calc(2.25rem + 7px);*/
        height: 34PX;
    }

    .right {
        float: right !important;
        list-style-type: none;
    }
    /*.left {
          list-style-type: none;
    }*/

    .control-label {
        margin-top: 10px;
    }

    .tablinks1 li a {
        font-size: 12px;
        font-weight: 600;
        border: none;
        background: none;
        /*margin-right: 38px;*/
    }

    .tab-content {
        margin-top: 20px;
    }

    li {
        list-style: none;
    }

    #idCalender {
        position: relative;
        top: 10px !important;
        /* right: -144px !important; */
        float: right;
        margin-left: 5PX;
        /*margin-right: 8% !important;*/
    }

    .row.content {
        height: 1500px;
    }

    /* Set gray background color and 100% height */
    .sidenav {
        /*background-color: #f1f1f1;*/
        height: 100%;
    }

    /* Set black background color, white text and some padding */
    footer {
        background-color: #555;
        color: white;
        padding: 15px;
    }

    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
        .sidenav {
            height: auto;
            padding: 15px;
        }

        .row.content {
            height: auto;
        }
    }

    #divScroll {
        overflow: auto;
        height: 100%;
    }

    .profile-pic {
        position: relative;
        display: inline-block;
    }

    #fileUpload {
        display: none;
    }

    .lblField {
        width: 100%;
        float: left;
    }

    .lblNote {
        color: red;
        width: 100%;
    }
    /*#divCustomer .form-group {
        background-color:#edf3f9;
    }
    .divlblNote {
        background-color:transparent !important;
    }*/
    #EmpAlerts .form-control {
        width: 30px !important;
    }

    #txtHelpRequest, #txtHelpRequestAfter {
        display: inline;
        text-align: center !important;
    }

    .clsTable td {
        padding: 5px;
    }

    .clsTable {
        background-color: transparent !important;
    }

    #idCustomerList .container {
        width: 750PX;
    }

    #idCustomerList .modal-content {
        height: 500px;
        width: 750PX;
    }

    #idCustomerList .container {
        width: 750PX;
    }
    /*End of Reference from reqdetails.css*/

    #idCustomerList .form-control {
        padding: 0px;
    }

    #idCustomerList .container {
        width: 750PX;
    }

    #idEmployeeList .modal-content {
        height: 500px;
        width: 750PX;
    }

    #idEmployeeList .container {
        width: 750PX;
    }
    /*End of Reference from reqdetails.css*/

    #idEmployeeList .form-control {
        padding: 0px;
    }



    .table-responsive {
        overflow: hidden;
    }

    .control-label {
        font-weight: normal !important;
    }






  



    #idEmployeeList .bottom-bar input {
        height: 12px !important;
        width: 12px !important;
    }

    .appro-title {
        float: left;
        line-height: 34px;
        margin-left: 23px;
    }

    .close {
        position: absolute !important;
        right: 9px !important;
        top: 5px !important;
        color: #fff !important;textse
        font-size: 20px !important;
        font-weight: bold !important;
        opacity: 1 !important;
    }

        .close:hover,
        .close:focus {
            color: red;
            cursor: pointer;
        }

    .imgcontainer {
        text-align: center;
        position: relative;
        background: #364660;
        color: #fff;
        height: 34px;
    }

    .modal-content.animate {
        background: #e8edf6;
    }

    .dataTables_wrapper .row:nth-child(1) {
        display: none;
    }

    .right {
        display: inline-flex;
    }

    .multi-btn, .multi-drop, ul.pagination {
        padding: 0px 0 0 0px;
        float: left;
        width: 100%;
        margin: 0px;
    }

    .dataTables_paginate {
        float: right !important;
    }

    #divMain {
        overflow: auto;
    }

    button.btn {
        font-size: 11px !important;
        font-weight: 600 !important;
        border-radius: 0;
        cursor: pointer;
    }

    .FixedTD {
        /*background-color:#F0D1A1;/*#e6ffff*/
        padding: 5px !important;
        position: relative;
        /*background-clip: padding-box;*/
        /*background-color:#f0ccc3!important;*/
        border: 1px solid white;
    }

    ::-ms-clear {
        display: none;
    }

    #divEmployee {
        width: 110%;
        padding-right: 7%;
    }

    #divCustomer {
        width: 110%;
        padding-right: 7%;
    }

    #divEmployee .clsTRColumnHeader TH:nth-child(3) {
        text-align: center;
    }

    #divCustomer .clsTRColumnHeader TH:nth-child(3) {
        text-align: center;
    }

    .container {
        overflow: hidden;
    }

    select::-ms-expand {
        border: none;
        background: #fff;
    }

    .top-bar {
        padding-top: 14px !important;
        padding-right: 0px !important;
    }

    /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
    .form-control:-ms-input-placeholder { /* IE 10+ */
        color: #bbb !important;
    }
</style>

<body>
    <form id="formEmp" runat="server">
        <div class="container-fluid" id="divScroll">
            <div class="row content" id="divMain">
                <div class="col-sm-3 sidenav">
                    <div class="col-md-1 hidden-xs" style="margin-bottom: -189px; width: 100%; text-align: center">
                        <div class="profile-pic">
                            <img src="" id="empimg" height="150" width="150" class="img-circle" style="margin-top: 99px;" />
                            <div class="edit">
                                <input name='img[]' class='file' id='fileUpload' type='file'><a data-toggle="tooltip" title='Edit Photo' id='btnSelectFile' style='text-align: center; font-weight: normal; font-size: 11px !important;' onclick='SelectFile()' filecount='0'><i class='fa fa-pencil' style="font-size: 16px"></i></a>
                            </div>
                            <%--<div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='' /></a></div></div></div>--%>
                        </div>
                    </div>


                </div>

                <div class="col-sm-9">


                    <ul class="nav nav-tabs tablinks1" style="margin: 20px 0 22px 0;">


                        <li class="active"><a data-toggle="tab" href="#EmpDetails">My Profile</a></li>

                        <%If strLoginType = "E" Then%>
                        <%If m_objAccessAlert.View Then%>
                        <li><a data-toggle="tab" href="#EmpAlerts">My Alerts</a></li>
                        <%End If%>
                        <%End If%>
                    </ul>

                    <div class="tab-content">

                        <div id="EmpDetails" class="tab-pane fade in active bottom-bar">

                            <div class="row">
                                <% WriteProfile()%>
                            </div>
                            <div class="type-top-bar top-bar" id="" style="height: 42px;">

                                <ul class="right" style="margin-top: -8px;">
                                    <div class="form-group" style="border-bottom: none; margin-top: 5px;">
                                        <div class="right">
                                            <%If m_objAccess.Edit = True Then%>
                                            <%If strLoginType = "C" Then%>
                                            <%--<button type="button" class="btn btn-default save" onclick="SaveCust_Onclick()" style="background-color: #343660; color: #ffffff">Save</button>--%>
                                            <% Else%>
                                            <button type="button" class="btn btn-default save" onclick="SaveEmp_Onclick()" style="background-color: #343660; color: #ffffff">Save</button>
                                            <button type="button" class="btn btn-default save clsbuttonLinks" onclick="Clear_Onclick()" style="margin-right: 19px; margin-left: 5px; background-color: #343660; color: #ffffff">Clear</button>
                                            <%End If%>

                                            <%End If%>
                                        </div>
                                    </div>


                                </ul>

                            </div>
                        </div>
                        <div id="EmpAlerts" class="tab-pane fade">
                            <div class="row" style="width: 100%">
                                <% WriteAlerts()%>
                            </div>
                            <div class="type-top-bar top-bar" id="" style="height: 42px;">

                                <ul class="right" style="margin-top: -8px;">
                                    <div class="form-group" style="border-bottom: none; margin-top: 5px;">
                                        <div class="right">

                                            <%If m_objAccessAlert.Add And m_objAccessAlert.Edit Then%>
                                            <button type="button" class="btn btn-default save" onclick="SaveAlert_Onclick()" style="background-color: #343660; color: #ffffff">Save</button>
                                            <%End If%>
                                            <button type="button" class="btn btn-default save clsbuttonLinks" onclick="ClearAlerts_Onclick()" style="margin-right: 19px; margin-left: 5px; background-color: #343660; color: #ffffff">Clear</button>



                                        </div>
                                    </div>


                                </ul>

                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div>
        <div id="idCustomerList" class="modal">

            <form enctype="multipart/form-data" class="modal-content animate" id="frmAttachmentDiv" action="/action_page.php" method="post">
                <div class="imgcontainer">
                    <span class="appro-title">Select Customers</span>
                    <span onclick="Close_AddNote('idCustomerList')" class="close" title="Close">&times;</span>

                </div>

                <div class="container" style="height: 90%">

                      <div style="display:inline-flex;width:100%">
                     <div class="top-bar">
                            <ul style="padding-left:0px">
                                <li style="padding-left:0px" class="left search-bar">
                                    <div class="left search-bar">
                                    <i class="fa fa-search faSettingSearch" aria-hidden="true"></i>
                                    <input type="text" id="SearchRole" placeholder="Search in table"/>
                                </div>
                            </li>
                            </ul>
                        </div>

                    <div class="top-bar">
                        <%-- <ul class="left">
                            <li class="left search-bar">
                                <div class="left search-bar">
                                    <i class="fa fa-search faSettingSearch" aria-hidden="true"></i>
                                    <input type="text" id="SearchRole" placeholder="Search in table">
                                </div>
                            </li>

                        </ul>--%>
                        <ul class="right">
                           
                            <li class="clearall">
                                <button type="button" class="btn btn-default save " onclick="SetCustomer_OnClick()">
                                Set Customers </li>
                            <li class="clearall">

                                <button type="button" id='showselectedCust' class="btn save  btn-default" onclick="ShowSelectedCustomer('1')">Show Selected Customers</button>

                                <button type="button" id='showAllCust' style='display: none' class="btn save  btn-default" onclick="ShowSelectedCustomer('0')">Show All Customers</button></li>


                        </ul>

                    </div>
                            </div>



                    <div class="bottom-bar clsSettingstabs" id="divCustomer" style="height: 88%; overflow: auto;">
                        <%plotReviewerListCustomer()%>
                    </div>

                </div>
            </form>
        </div>
        <div id="idEmployeeList" class="modal">

            <form enctype="multipart/form-data" class="modal-content animate" id="frmAttachmentDiv" action="/action_page.php" method="post">
                <div class="imgcontainer">
                    <span class="appro-title">Select Employees</span>
                    <span onclick="Close_AddNote('idEmployeeList')" class="close" title="Close">&times;</span>

                </div>

                <div class="container" style="height: 90%">
                    <div style="display:inline-flex;width:100%">
                        <div class="top-bar">
                            <ul style="padding-left:0px">
                                <li style="padding-left:0px" class="left search-bar">
                                    <div class="left search-bar">
                                        <i class="fa fa-search faSettingSearch" aria-hidden="true"></i>
                                        <input type="text" id="SearchEmpRole" placeholder="Search in table" />
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="top-bar">


                            <ul class="right">

                                <li class="clearall">
                                    <button type="button" class="btn btn-default save " onclick="SetEmployee_OnClick()">
                                        Set Employees
                                    </button>
                                </li>
                                <li class="clearall">

                                    <button type="button" id='showselectedEmp' class="btn save  btn-default" onclick="ShowSelectedEmployee('1')">Show Selected Employees</button>

                                    <button type="button" id='showAllEmp' style='display: none' class="btn save  btn-default" onclick="ShowSelectedEmployee('0')">Show All Employees</button></li>

                            </ul>

                        </div>

                    </div>

                    <div class="bottom-bar clsSettingstabs" id="divEmployee" style="height: 88%; overflow: auto;">
                        <%plotReviewerListEmployee()%>
                    </div>

                </div>
            </form>
        </div>
    </form>
</body>
<script>
       <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
    disableRightClick();
		    <%End If%>
    var modal = document.getElementById('idCustomerList');
    $('.modal').draggable();
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    $(function () {
        $("#dtDOB").datepicker();
    });
    var divHeight;
    $(document).ready(function () {
        //var DivId = "DivList";
        //var DivSerach = "SearchRole";
        $("#empimg").attr("src", '<%=strEmployeeImage%>');

        divHeight = window.innerHeight;

        //alert(divHeight);
        document.getElementById("divMain").style.height = divHeight + "px";
        datatableMainPage("DivList", "SearchRole");
        datatableMainPage("DivListEmp", "SearchEmpRole");
        //datatables(DivId, DivSerach);
        //$('#DivList').DataTable();
        //setWidthDatatable(DivId);

        //$("#selectedcust").on('click', function () {
        //    table.draw();
        //});
        $(".FixedTD").css("top", "0px")
        $("#divEmployee").scroll(function () {
            $(".FixedTD").css("top", $("#divEmployee").scrollTop() - 1);
        });
        $("#divCustomer").scroll(function () {
            $(".FixedTD").css("top", $("#divCustomer").scrollTop() - 1);
        });

        var color = $('.clsTRColumnHeader').css('background-color');
        $(".FixedTD").css("background-color", color);
    })

    function datatables(divID, txtBoxID) {
        //$('#' + divID + ' > table').removeClass("clsGridTable");
        //$('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({

            responsive: true,
            pagingType: "numbers",
            "pageLength": 10,
            //pagingType: "simple_numbers",
            //scrollX: true,
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
    function datatableMainPage(divID, txtBoxID) {

        // $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({
            responsive: true,
            "pageLength": 10,
            // scrollY: height - 80 + 'px',
            //scrollX: true,
            pagingType: "simple_numbers",
            //language: {
            //    paginate: {
            //        first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
            //        next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
            //        previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
            //        last: '<i class="fa fa-angle-right" title="Last"></i>'
            //    }
            //},

        });
        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
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
    var strPageName = "MyProfile.aspx";
    var fileObject;
    function SaveEmp_Onclick() {
        var dataSave;
        var strResult;
        var strCboBloodGroup = "";
        var strdtDOB = "";
        var strtxtAddress = "";
        var strtxtCurrentAddress = "";
        var strtxtCity = "";
        var strtxtCurrentCity = "";
        var strtxtState = "";
        var strtxtCurrentState = "";
        var strtxtPin = "";
        var strtxtCurrentPin = "";
        var strtxtPhone = "";
        var strtxtCurrentPhone = "";

        strCboBloodGroup = $("#CboBloodGroup").val();
        strdtDOB = $("#dtDOB").val();
        strtxtAddress = $("#txtAddress").val();
        strtxtCurrentAddress = $("#txtCurrentAddress").val();
        strtxtCity = $("#txtCity").val();
        strtxtCurrentCity = $("#txtCurrentCity").val();
        strtxtState = $("#txtState").val();
        strtxtCurrentState = $("#txtCurrentState").val();
        strtxtPin = $("#txtPin").val();
        strtxtCurrentPin = $("#txtCurrentPin").val();
        strtxtPhone = $("#txtPhone").val();
        strtxtCurrentPhone = $("#txtCurrentPhone").val();


        if (ValidateData() == 0) {
            var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
            var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
            var validateExtensions = strFileExtension.split(",");
            var imgvalidateExtensions = strImageExtension.split(",");

            var formData = new FormData();
            formData.append('Mode', 'SaveEmployeeProfile');
            if (typeof fileObject == "undefined") {
                formData.append('EmployeePhoto', "");
            }
            else {
                formData.append('EmployeePhoto', fileObject[0]);

            }

            formData.append('BloodGroup', strCboBloodGroup);
            formData.append('DOB', strdtDOB);
            formData.append('Address', strtxtAddress);
            formData.append('CurrentAddress', strtxtCurrentAddress);
            formData.append('City', strtxtCity);
            formData.append('CurrentCity', strtxtCurrentCity);
            formData.append('State', strtxtState);
            formData.append('CurrentState', strtxtCurrentState);
            formData.append('Pin', strtxtPin);
            formData.append('CurrentPin', strtxtCurrentPin);
            formData.append('Phone', strtxtPhone);
            formData.append('CurrentPhone', strtxtCurrentPhone);

            //dataSave = JSON.stringify({ BloodGroup: strCboBloodGroup, DOB: strdtDOB, Address: strtxtAddress, CurrentAddress: strtxtCurrentAddress, City: strtxtCity, CurrentCity: strtxtCurrentCity, State: strtxtState, CurrentState: strtxtCurrentState, Pin: strtxtPin, CurrentPin: strtxtCurrentPin, Phone: strtxtPhone, CurrentPhone: strtxtCurrentPhone });
            ////  alert(data);
            //strResult = AJAXCallWithResult(strPageName + "/SaveProfile", dataSave, false);

            //if (typeof fileObject != "undefined") {

            setFrameLoader();
            $.ajax({
                url: strPageName,  //Server script to process data
                type: 'POST',
                data: formData,
                async: false,
                success: function (result) {

                    strResult = result;
                    setTimeout(function () { RemoveFrameLoader(); }, 1000);
                },
                error: function (xhr, status, error) {
                    setTimeout(function () { RemoveFrameLoader(); }, 1000);
                    console.log(xhr.responseText);
                },
                cache: false,
                contentType: false,
                processData: false
            });
            if (strResult != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Profile updated successfully', 'success');
                if (typeof fileObject != "undefined") {
                    if (strResult != "1") {
                        $(".user-image", window.parent.parent.document).attr('src', '../../Images/Photo/' + strResult);
                        $("#userImageHeader", window.parent.parent.document).attr('src', '../../Images/Photo/' + strResult);

                    }
                }
            }
        }

        //}
    }
    function ValidateData() {
        var chkVal = 0;
        var strMsg = "";
        var objBirthDate = GetObjectReference('', 'dtDOB');
        var objJoiningDate = GetObjectReference('', 'txtJoiningDate');

        if (new Date(objBirthDate.value) > new Date(objJoiningDate.value)) {
            strMsg += "<li>- Birth date cannot be greater than joining date of the employee i.e " + objJoiningDate.value + ". </li>";
            chkVal = 1;
        }

        if (disallowBlank(GetObjectReference("", "dtDOB"))) {
            strMsg += "<li>- Birth Date should not be left blank. </li>";
            chkVal = 1;
        }




        if (disallowMaxlengthViolation(GetObjectReference("", "txtAddress"), 255)) {
            strMsg += "<li>- Max Length of Address is 255 characters.\r\nYou have entered " + $("#txtAddress").val().length + " characters. </li>";
            chkVal = 1;
        }


        if (disallowMaxlengthViolation(GetObjectReference("", "txtCurrentAddress"), 255)) {
            strMsg += "<li>- Max Length of Current Address is 255 characters.\r\nYou have entered " + $("#txtCurrentAddress").val().length + " characters. </li>";
            chkVal = 1;
        }





        if (disallowSpecialCharacters(GetObjectReference("", "txtCity"))) {
            strMsg += '<li>- City cannot contain any of these /\\:*?<>|,"+- characters. </li>';
            chkVal = 1;
        }
        else if (GetObjectReference("", "txtCity").value.match(/[0-9]/g)) {
            strMsg += '<li>- City cannot contain numbers </li>';
            chkVal = 1;
        }
        if (disallowSpecialCharacters(GetObjectReference("", "txtCurrentCity"))) {
            strMsg += '<li>- Current City cannot contain any of these /\\:*?<>|,"+- characters. </li>';
            chkVal = 1;
        }
        else if (GetObjectReference("", "txtCurrentCity").value.match(/[0-9]/g)) {
            strMsg += '<li>- Current City cannot contain numbers </li>';
            chkVal = 1;
        }

        if (disallowSpecialCharacters(GetObjectReference("", "txtState"))) {
            strMsg += '<li>- State cannot contain any of these /\\:*?<>|,"+- characters. </li>';
            chkVal = 1;
        }
        else if (GetObjectReference("", "txtState").value.match(/[0-9]/g)) {
            strMsg += '<li>- State cannot contain numbers </li>';
            chkVal = 1;
        }

        if (disallowSpecialCharacters(GetObjectReference("", "txtCurrentState"))) {
            strMsg += '<li>- Current State cannot contain any of these /\\:*?<>|,"+- characters. </li>';
            chkVal = 1;
        }
        else if (GetObjectReference("", "txtCurrentState").value.match(/[0-9]/g)) {
            strMsg += '<li>- Current State cannot contain numbers </li>';
            chkVal = 1;
        }


        if (disallowSpecialCharacters(GetObjectReference("", "txtPin"))) {
            strMsg += '<li>- Pin Code cannot contain any of these /\\:*?<>|,"+- characters. </li>';
            chkVal = 1;
        }

        if (disallowSpecialCharacters(GetObjectReference("", "txtCurrentPin"))) {
            strMsg += '<li>- Current Pin Code cannot contain any of these /\\:*?<>|,"+- characters. </li>';
            chkVal = 1;
        }

        if (disallowSpecialCharacters(GetObjectReference("", "txtPhone"))) {
            strMsg += '<li>- Phone cannot contain any of these /\\:*?<>|,"+- characters. </li>';
            chkVal = 1;
        }
        else if (disallowNonInteger(GetObjectReference("", "txtPhone"))) {
            strMsg += "<li>- Phone number cannot contain characters . </li>";
            chkVal = 1;
        }

        if (disallowSpecialCharacters(GetObjectReference("", "txtCurrentPhone"))) {
            strMsg += '<li>- Current Phone cannot contain any of these /\\:*?<>|,"+- characters. </li>';
            chkVal = 1;
        }
        else if (disallowNonInteger(GetObjectReference("", "txtCurrentPhone"))) {
            strMsg += "<li>- Phone number should cannot contain characters . </li>";
            chkVal = 1;
        }


        strMsg = strMsg.substr(0, strMsg.length - 1);
        if (strMsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }

        return chkVal;

    }

    function Clear_Onclick() {
        window.location.href = window.location.href;
    }
    function SelectFile() {
        var objCurrentFileControl = $("#fileUpload");

        objCurrentFileControl.click();
    }
    $(document).on('change', '#fileUpload', function () {

        var fileNameDisplay;
        $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));

        var objtxtFileName = document.getElementById('fileUpload');

        var fileName = objtxtFileName.value;
        fileNameDisplay = fileName;
        var index = fileName.lastIndexOf("\\");
        if (index == -1)
            index = fileName.lastIndexOf("/");

        if (index != -1)
            fileName = fileName.substring(index + 1, fileName.length);

        fileObject = $("#fileUpload")[0].files;

        if (typeof fileObject != "undefined") {
            var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
            var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
            var validateExtensions = strFileExtension.split(",");
            var imgvalidateExtensions = strImageExtension.split(",");
            for (var i = 0; i < fileObject.length; i++) {
                if (fileObject[i] != null || fileObject[i] != undefined) {

                    var allowSubmit = false;
                    var allowSubmitForImg = false;
                    var intActualFileSize = (fileObject[i].size);
                    if (intActualFileSize < intMinFileSize) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'error', 25);
                        fileObject = [];
                        return;
                    }
                    var file = fileObject[i].name;
                    var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();
                    for (var cnt = 0; cnt < validateExtensions.length ; cnt++) {
                        var strExtn;
                        strExtn = validateExtensions[cnt];
                        if (strExtn.toLowerCase() == extension)
                        { allowSubmit = true; }
                    }
                    if (allowSubmit == false) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("- File with extensions " + extension + " is not allowed.", 'error', 25);
                        fileObject = [];
                        return;
                    }
                    for (var cnt = 0; cnt < imgvalidateExtensions.length ; cnt++) {
                        var strExtn;
                        strExtn = imgvalidateExtensions[cnt];
                        if (strExtn.toLowerCase() == extension)
                        { allowSubmitForImg = true; }
                    }
                    if (allowSubmitForImg == false) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("- Only files with extensions " + (imgvalidateExtensions.join(", ", "").toUpperCase()) + " are  allowed.", 'error', 25);
                        fileObject = [];
                        return;
                    }


                }
            }
        }
        readURL();
        <%If strLoginType = "C" Then%>
        SaveCust_Onclick();
        <%End If%>


        // ImportOnclick();

    });
    function readURL(input) {
        if ($("#fileUpload")[0].files) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#empimg').attr("src", e.target.result);
                //$("#imgUser").css('margin-left', '-16px');
                //$("#imgUser").css('margin-top', '-1px');

            }

            reader.readAsDataURL($("#fileUpload")[0].files[0]);
        }
    }
    var strImageExtension = '<%=ConfigurationManager.AppSettings("AllowImageFile")%>';
    function SaveCust_Onclick() {
        var dataSave;
        var strResult
        var formData = new FormData();
        formData.append('Mode', 'SaveCustomerProfile');
        if (typeof fileObject == "undefined") {
            formData.append('CustomerPhoto', "");
        }
        else {
            formData.append('CustomerPhoto', fileObject[0]);
        }





        setFrameLoader();

        $.ajax({
            url: strPageName,  //Server script to process data
            type: 'POST',
            data: formData,
            async: false,
            success: function (result) {

                strResult = result;
                setTimeout(function () { RemoveFrameLoader(); }, 1000);
            },
            error: function (xhr, status, error) {
                setTimeout(function () { RemoveFrameLoader(); }, 1000);
                console.log(xhr.responseText);
            },
            cache: false,
            contentType: false,
            processData: false
        });
        if (strResult != "") {
            if (typeof fileObject != "undefined") {
                if (strResult != "1") {
                    $(".user-image", window.parent.parent.document).attr('src', '../../Images/Photo/' + strResult);
                    $("#userImageHeader", window.parent.parent.document).attr('src', '../../Images/Photo/' + strResult);

                }
            }
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Photo updated successfully', 'success');
        }

        else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please select file', 'error');
        }
    }
    function SaveAlert_Onclick() {


        var txtHelpRequestAfter = 0;
        var txtHelpRequest = 0;
        var chkCustomer = 0;
        var chkHelpRequestAfterFlag = 0;
        var chkHelpRequest = 0;

        var dataAlert;

        if (ValidateAlert() == 0) {
            if ($("#txtHelpRequestAfter").val() != undefined && $("#txtHelpRequestAfter") != null) {
                txtHelpRequestAfter = $("#txtHelpRequestAfter").val();
            }
            if ($("#txtHelpRequest").val() != undefined && $("#txtHelpRequest") != null) {
                txtHelpRequest = $("#txtHelpRequest").val();
            }
            if (document.getElementById("chkCustomer") != null) {
                if (document.getElementById("chkCustomer").checked) {
                    chkCustomer = 1;
                }
            }
            if (document.getElementById("chkHelpRequestAfterFlag") != null) {
                if (document.getElementById("chkHelpRequestAfterFlag").checked) {
                    chkHelpRequestAfterFlag = 1;
                }
            }
            if (document.getElementById("chkHelpRequest") != null) {
                if (document.getElementById("chkHelpRequest").checked) {
                    chkHelpRequest = 1;
                }
            }
            dataAlert = JSON.stringify({ HelpRequestAfter: txtHelpRequestAfter, HelpRequest: txtHelpRequest, CustomerFlag: chkCustomer, HelpRequestAfterFlag: chkHelpRequestAfterFlag, HelpRequestFlag: chkHelpRequest })
            var strResult = AJAXCallWithResult(strPageName + "/SaveAlerts", dataAlert, false);
            if (strResult.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Data Saved successfully', 'success');
                if (chkCustomer == 1) {
                    $("#lblCustomers").css("visibility", "visible");
                    $("#lblEmployees").css("visibility", "visible");
                    //$("#lblCustomers").css("display", "block");
                    //$("#lblEmployees").css("display", "block");
                }
                else {
                    $("#lblCustomers").css("visibility", "hidden");
                    $("#lblEmployees").css("visibility", "hidden");
                    //$("#lblCustomers").css("display", "none");
                    //$("#lblEmployees").css("display", "none");
                }
            }
        }
    }
    function ClearAlerts_Onclick() {
        $("#txtHelpRequestAfter").val("");
        $("#txtHelpRequest").val("");
    }

    function ValidateAlert() {

        var chkValue = 0;
        var strMsg = "";
        var objHelpDeskRequestAfter = document.getElementById('txtHelpRequestAfter');
        var objHelpRequest = document.getElementById('txtHelpRequest');
        if (disallowBlank(objHelpDeskRequestAfter)) {
            strMsg += "<li>- Enter Alert Days for HelpRequest. </li>";
            chkValue = 1;
        }
        if (disallowNonInteger(objHelpDeskRequestAfter)) {
            strMsg += "<li>-Enter Numbers only. </li>";
            chkValue = 1;
        }
        if (disallowNegativeInteger(objHelpDeskRequestAfter)) {
            strMsg += "<li>- Enter Positive Numbers only.</li>";
            chkValue = 1;
        }

        if (disallowBlank(objHelpRequest)) {
            strMsg += "<li>- Enter Alert Days for HelpRequest. </li>";
            chkValue = 1;
        }
        if (disallowNonInteger(objHelpRequest)) {
            strMsg += "<li>- Enter Numbers only. </li>";
            chkValue = 1;
        }
        if (disallowNegativeInteger(objHelpRequest)) {
            strMsg += "<li>- Enter Positive Numbers only. </li>";
            chkValue = 1;
        }
        strMsg = strMsg.substr(0, strMsg.length - 1);
        if (strMsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }
        return chkValue;

    }
    function chkHelpRequestAfter_Change() {
        var objchkHelpDeskRequestAfter = GetObjectReference('', 'chkHelpRequestAfterFlag');
        var objHelpDeskRequestAfter = GetObjectReference('', 'txtHelpRequestAfter');

        if (objchkHelpDeskRequestAfter.checked == false) {
            objHelpDeskRequestAfter.value = 0
            objHelpDeskRequestAfter.disabled = true
        }
        else {
            objHelpDeskRequestAfter.disabled = false
        }
    }
    function chkHelpRequest_Change() {
        var objChkHelpRequest = GetObjectReference('', 'chkHelpRequest');
        var objHelpRequest = GetObjectReference('', 'txtHelpRequest');

        if (objChkHelpRequest.checked == false) {
            objHelpRequest.value = 0
            objHelpRequest.disabled = true
        }
        else {
            objHelpRequest.disabled = false
        }
    }


    function chkCustomer_Change() {
    }
    function Customer_OnClick() {
        document.getElementById('idCustomerList').style.display = 'block';
    }
    function Employees_OnClick() {
        document.getElementById('idEmployeeList').style.display = 'block';
    }
    function SetCustomer_OnClick() {

        var blnSelected = false;
        var strReviewerIDList = "";

        try {




            $('input[name="chkCustomerSelect"]:checked').each(function () {
                blnSelected = true;
                strReviewerIDList = strReviewerIDList + $(this).val() + ",";
            });
            $(".clsCheckBox input:checked").each(function () {
                //console.log($(this).val()); //works fine
                blnSelected = true;
                strReviewerIDList = strReviewerIDList + $(this).val() + ",";

            });
            if (blnSelected == false) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please select at least one customer', 'error');
                return;

            }
            var dataCheck = JSON.stringify({ strReviewerIDList: strReviewerIDList });
            var strResult = AJAXCallWithResult(strPageName + "/SaveCustomers", dataCheck, false);
            if (strResult.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Data Saved successfully', 'success');
            }

        }
        catch (e)
        { }
    }
    function Close_AddNote(id) {
        document.getElementById(id).style.display = 'none';
    }
    function SetEmployee_OnClick() {
        var blnSelected = false;
        var strReviewerEmpIDList = "";

        try {
            $('input[name="chkEmployeeSelect"]:checked').each(function () {
                blnSelected = true;
                strReviewerEmpIDList = strReviewerEmpIDList + $(this).val() + ",";
            });

            if (blnSelected == false) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please select at least one employee', 'error');
                return;

            }
            var dataCheck = JSON.stringify({ strReviewerIDList: strReviewerEmpIDList });
            var strResult = AJAXCallWithResult(strPageName + "/SaveEmployees", dataCheck, false);
            if (strResult.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Data Saved successfully', 'success');
            }

        }
        catch (e)
        { }

    }
    function ShowSelectedEmployee(flag) {
        var data;
        var strResult;
        if (flag == 1) {
            data = JSON.stringify({ Flag: flag });
        }
        else {
            data = JSON.stringify({ Flag: flag });
        }
        strResult = AJAXCallWithResult(strPageName + "/ShowSelectedEmployee", data, false);
        if (strResult.d != "") {
            $("#divEmployee").html("");
            $("#divEmployee").html(strResult.d);
        }

        if (flag == 1) {
            $("#showselectedEmp").css("display", "none");
            $("#showAllEmp").css("display", "block");
        }
        else if (flag == 0) {
            $("#showselectedEmp").css("display", "block");
            $("#showAllEmp").css("display", "none");
        }
        var DivId = "DivListEmp";
        var DivSerach = "SearchEmpRole";

        datatableMainPage(DivId, DivSerach);
        var color = $('.clsTRColumnHeader').css('background-color');
        $(".FixedTD").css("background-color", color);
    }
    function ShowSelectedCustomer(flag) {
        var data;


        data = JSON.stringify({ Flag: flag });

        strResult = AJAXCallWithResult(strPageName + "/ShowSelectedCustomer", data, false);

        if (strResult.d != "") {
            $("#divCustomer").html("");
            $("#divCustomer").html(strResult.d);
        }



        if (flag == 1) {
            $("#showselectedCust").css("display", "none");
            $("#showAllCust").css("display", "block");
        }
        else if (flag == 0) {
            $("#showselectedCust").css("display", "block");
            $("#showAllCust").css("display", "none");
        }
        var DivId = "DivList";
        var DivSerach = "SearchRole";
        datatableMainPage(DivId, DivSerach);
        var color = $('.clsTRColumnHeader').css('background-color');
        $(".FixedTD").css("background-color", color);
    }
    function chkSelect_OnClick()
    { }


    /*Added by Dipali V On 3rd Jan 2017 For Remove Logout Pop_UP By Clicking Outside */
    $(document).click(function () {

        $("#profileDropdwn", window.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.document).parent().removeClass("open");

    });
    /*End of Added by Dipali V On 3rd Jan 2017 For Remove Logout Pop_UP By Clicking Outside */
</script>
</html>
