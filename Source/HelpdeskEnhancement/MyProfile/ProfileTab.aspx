<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProfileTab.aspx.vb" Inherits="PbNIT.ProfileTab" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    
    <%CommonFunctions.General.PlotPageHeadTag("Helpdesk Main Page")%>

    <head runat="server">
        <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        
        <!-- Bootstrap core CSS -->
        <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" /> -->
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
        <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

    <title>Helpdesk Main Page</title>

</head>

<style>
    .help-desk {
        position: relative;
    }

    .affix {
        top: 49px;
        width: 100%;
        <!-- position: fixed; -->
    }

        .affix .row {
            background: #edf3f9;
        }

    .help-desk {
        float: left;
        width: 100%;
        z-index: 100;
    }

    .dropdown-menu {
        transform: translate3d(0px, 0px, 0px) !important;
        top: 100% !important;
    }

    .form-info span.glyphicon {
        background: #0bc813;
        border-radius: 50%;
        color: #fff;
        padding: 3px;
    }

        .form-info span.glyphicon.glyphicon-minus {
            background: red;
        }


    /**------responsive 767 view---------------**/



    .icons {
        float: left;
    }



    .content-wrapper {
        margin-left: auto !important;
        padding-left: 0px !important;
    }

    @media only screen and (max-width:767px) {
        .icons {
            float: left;
            width: 100%;
        }
    }

    .clsTopNav li a.Active {
        border-bottom: 4px solid #f3565d;
    }

        .clsTopNav li a.Active:hover {
            border-bottom: 4px solid #f3565d;
        }

    .clsTopNav li a:not(.Active):hover {
        border-bottom: 4px solid #f7c1c3;
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
    /*Reference From style.css*/
    .container-fluid {
        min-height: initial;
    }

    .req-dsk-kn.new-req-head .active a {
        color: #364660;
        text-decoration: none;
    }

    .req-dsk-kn.new-req-head {
        padding: 5px 43px;
    }
    /*End of Reference From style.css*/

    ul.clsTopNav {
        margin-bottom: 0px;
    }

    #page-top {
        overflow: hidden !important;
    }

    .clsTopNav a {
        font-size: 12px !important;
    }
</style>

<body>
    <form id="frmHelpdeskTab" runat="server">
        <div>
            <div class="content-wrapper">

                <div class="container-fluid">
                    <!---- HelpDesk---------------------->
                    <div class="help-desk" data-spy="affix" data-offset-top="100">
                        <div class="row">
                            <div class="req-dsk-kn new-req-head">
                                <div class="col-md-12">
                                    <ul class="clsTopNav">
                                        
                                        <% If objAccess.View Then%>
                                        <%If Request.QueryString("FromWhere") Is Nothing Then%>
                                           <li class="active"><a class="Active" href="#" mode="All">My Profile</a></li>
                                            <li><a href="#" mode="Dashboard">Dashboard</a></li>
                                        <%Else%>
                                        <li class="active"><a href="#" class="Active" mode="Dashboard">Dashboard</a></li>
                                        <%End If%>
                                           
                                        <% Else%>
                                           <li class="active"><a class="active" href="#" mode="Dashboard">Dashboard</a></li>
                                        <% End If%>
                                     
                                        
                                     
                                        <li style="float: right">
                                            <label class="label label-danger">Beta Version</label>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                        </div>

                    </div>

                      <% If objAccess.View And Request.QueryString("FromWhere") Is Nothing Then%>
                          <div id="HelpdeskFrameDiv" class="row">
                        <iframe name="frmHelpdeskFrame" id="frmHelpdeskFrame" src="../MyProfile/MyProfile.aspx?Mode=SR&MasterTagID=1085" scrolling="auto" marginwidth="0" allowtransparency="false" marginheight="0" frameborder="0" vspace="0" hspace="0" style="width: 100%; height: 670PX;">
                            <div></div>
                        </iframe>
                    </div>
                    <%Else%>
                     <div id="HelpdeskFrameDiv" class="row">
                        <iframe name="frmHelpdeskFrame" id="frmHelpdeskFrame" src="../Dashboard/Helpdesk_Dashboard.aspx" scrolling="auto" marginwidth="0" allowtransparency="false" marginheight="0" frameborder="0" vspace="0" hspace="0" style="width: 100%; height: 670PX;">
                            <div></div>
                        </iframe>
                    </div>
                       <% End If%>
                    
                </div>
                <%--container-fluid--%>
            </div>
            <%-- content-wrapper--%>
        </div>

    </form>
</body>

<!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script> -->
<script src="../../../Whizible2.0-new/dist/js/popper.min.js"></script>
<!-- <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../General/CommonFunctions.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>  -->

<script>
    $(document).ready(function () {
        var ObjTd = window.frames.parent.document.getElementById('tdTree')
        var ObjImg = window.frames.parent.document.getElementById('ImgShowHide')
        var ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')

        if (ObjTd != null && ObjImg != null) {

            ObjTd.style.display = 'none';
            ObjImg.src = '../../Images/Home/RightMove.gif';
            ObjLeftnavigation.style.display = '';
        }

        var bodyHeight = window.innerHeight - $('#frmHelpdeskFrame').offset().top;

        $('#frmHelpdeskFrame').css('height', bodyHeight - 5 + 'px');
        $('[data-toggle="tooltip"]').tooltip();
  
    });

    $(".clsTopNav li a").click(function () {
        $(".clsTopNav li a").removeClass("Active");
        $(this).addClass("Active");



        var strMode = $(this).attr("Mode");
        $("#hdnMode").val(strMode);

        if (strMode == 'Dashboard') {
            setFrameLoader();
            $("#frmHelpdeskFrame").attr("src", "../Dashboard/Helpdesk_Dashboard.aspx");

            //$("#frmHelpdeskFrame").contents().find("body").html("<h4>Dashboard Page is under develpment.</h4>");
        }
        else if (strMode == 'KM') {
            //$("#frmHelpdeskFrame").attr("src", "");
            $("#frmHelpdeskFrame").contents().find("body").html("<h4>Knowledge Page is under develpment.</h4>");
        }
        else if (strMode == 'All') {
            setFrameLoader();

            $("#frmHelpdeskFrame").attr("src", "../MyProfile/MyProfile.aspx?Mode=SR&MasterTagID=1085");
        }

    });

    $("#btnSetting").click(function () {
        $("#frmHelpdeskFrame").attr("src", "../Settings/Settings_Tabs.aspx");
        $(".clsTopNav li a").removeClass("Active");
    });

    $("#frmHelpdeskFrame").load(function () {

        var ObjTd = window.frames.parent.document.getElementById('tdTree')
        var ObjImg = window.frames.parent.document.getElementById('ImgShowHide')
        var ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')

        if (ObjTd != null && ObjImg != null) {

            ObjTd.style.display = 'none';
            ObjImg.src = '../../Images/Home/RightMove.gif';
            ObjLeftnavigation.style.display = '';
        }
        RemoveFrameLoader();

    });
</script>
<script>
    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>
</html>
