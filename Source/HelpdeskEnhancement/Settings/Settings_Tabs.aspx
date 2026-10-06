<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Settings_Tabs.aspx.vb"  Inherits="Whizible.Settings_Tabs" %>

<!DOCTYPE html>
<html lang="en">

<%CommonFunctions.General.PlotPageHeadTag("Setting")%>
<head>
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="description" content="" />
    <meta name="author" content="" />

    <%--<title>Setting</title>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/timepicker.min.css" />
    
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>--%>

    <!-- time picker -->
    <script>
//$('.timepicker').pickatime()
    </script>
    

</head>

    <style>
        .allyform label {
            font-size: 13px;
            font-weight: 600;
            margin: 15px 0 0 0;
        }

        .allyform select {
            margin: 5px 0 0 0;
        }

        .allyform textarea {
            margin: 5px 0 0 0;
        }

        .allyform > div.col-md-9 {
            padding-bottom: 10px;
        }

        .date-picker-form p {
            padding-top: 9px;
        }


        .content-wrapper {
            margin-left: 0px !important;
            padding-left: 0px !important;
            min-width: inherit !important;
        }

        #preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
            border: 3px solid #ababab;
            box-shadow: 1px 1px 10px #ababab;
            border-radius: 20px;
            background-color: white;
            background: url("../../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
            width: 90px;
            height: 90px;
            /*z-index: 99;
            height: 100%;*/
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }

        #fillDiv {
            opacity: 0.4;
            background-color: ghostwhite;
            /*DISPLAY: none;*/
            Z-INDEX: 100;
            LEFT: 0px;
            VISIBILITY: visible;
            WIDTH: 100%;
            POSITION: absolute;
            TOP: 0px;
            HEIGHT: 100%;
            float: right;
        }

        .ui-helper-hidden-accessible {
            display: none !important;
        }

        .v-tabs .tab {
            height: 349px;
        }

        .v-tabs .tabcontent {
            float: left;
            padding: 0;
            border-style: none;
            border-color: none;
            border-width: 0px;
            width: 85%;
            border-left: none;
            /*height: 1100px;*/
        }

        .v-tabs .tab {
            float: left;
            width: 15%;
            /*height: 1100px;*/
            padding-left: 0;
        }

        .v-tabs .tab {
            height: 476px;
            margin-top: 31px;
        }

         /*Added By Dipali V On 11th Feb 2021 For Scroll ISsue*/
        .v-tabs {
            position:fixed!important;
        }
         /*End of Added By Dipali V On 11th Feb 2021 For Scroll ISsue*/
    </style>

<body class="" id="page-top">

    <!-- Navigation -->



        <!--modified by pradip on 7-1-2021-->

                <div class="v-tabs">
                    <div class="tab clsTabs">
                        <%--<h3 class="setting-icon">Settings</h3>--%>

                        <%WriteSettingTabs("")%>
                        <%--  <button class="" onclick="openCity(event, 'Request')" id="defaultOpen">Request</button>
				  <button class="" onclick="openCity(event, 'Email')">Email</button>
				  <button class="" onclick="openCity(event, 'SLA')">SLA</button>
				  <button class="" onclick="openCity(event, 'Users')">Users & Role Access</button>
				  <button class="" onclick="openCity(event, 'Others')">Others</button>--%>
                        <%--  <div class="search-bar search-bt" style="margin-top: 10px;">
										<i class="fa fa-search" aria-hidden="true" style="color: #000;vertical-align:top;padding-left: 10px;"></i>
											<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search History" title="Type in a name"style="width: 184px;margin-top: -26px;">
										</div>--%>
                    </div>

                    <div id="divMainTab" class="tabcontent">
                        <iframe name="frmSettingsTabs" id="frmSettingsTabs" src="" scrolling="no" marginwidth="0" allowtransparency="false" marginheight="0" frameborder="0" vspace="0" hspace="0" style="width: 100%; height: auto;"></iframe>

                    </div>


                </div>


</body>
        
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/popper.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/New_CommonFunctions.js"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../General/CommonFunctions.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>

<script>
    $(document).ready(function () {
        var bodyHeight = window.innerHeight - $('#frmSettingsTabs').offset().top;

        $('#frmSettingsTabs').css('height', bodyHeight + 200 + 'px');
    });

</script>

<script>
    function openCity(evt, cityName, strTabURL) {

        $(".btnSettingTab").removeClass("active");
        evt.currentTarget.className += " active";

        //setFrameLoader();

        $("#frmSettingsTabs").attr("src", "" + strTabURL + "");
        //if (cityName == 'Request') {

        //    $("#frmSettingsTabs").attr("src", "../HelpdeskEnhancement/CRM_RequestSetting.aspx?Mode=SR");
        //}
        //else if (cityName == 'Email') {
        //    $("#frmSettingsTabs").contents().find("body").html("<h4>Knowledge Page is under develpment.</h4>");
        //}
        //else if (cityName == 'SLA') {
        //    $("#frmSettingsTabs").attr("src", "../HelpdeskEnhancement/CRM_RequestListNew.aspx?Mode=SR");
        //}
        //else if (cityName == 'Users') {
        //    $("#frmSettingsTabs").attr("src", "../HelpdeskEnhancement/CRM_User_RoleAccess.aspx?Mode=SR");
        //}
        //else if (cityName == 'Others') {
        //    $("#frmSettingsTabs").attr("src", "../HelpdeskEnhancement/CRM_RequestListNew.aspx?Mode=SR");
        //}
    }

    // Get the element with id="defaultOpen" and click on it
    if (document.getElementById("defaultOpen") != null)
        document.getElementById("defaultOpen").click();

    $("#frmSettingsTabs").load(function () {
        RemoveFrameLoader();
    });
</script>


<script>
                                             // Get the modal for Request Type button popup
                                             $('.modal').draggable();

                                             function myFunction() { }

</script>
</html>

