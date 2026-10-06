<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HelpdeskTab.aspx.vb"  Inherits="Whizible.HelpdeskTab" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<%CommonFunctions.General.PlotPageHeadTag("Helpdesk Main Page")%>
<head runat="server">
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <!-- Bootstrap core CSS -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />

    <%--<title>Helpdesk Main Page</title>--%>

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

        /****************************Added By Bharat T on 5th-Oct-2017**********************************/
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
        /****************************End of Added By Bharat T on 5th-Oct-2017**********************************/

        .clsTopNav a {
            font-size: 12px !important;
        }
        /*#HelpdeskFrameDiv {
        height:auto ;
        }*/
        a{text-decoration:none}

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
                                        <li class="new-r-btn">
                                            <button type="button" class="btn btn-default" id="btnNewRequest" onclick="clickbtnNewRequest()">New Request<i class="fa fa-plus" aria-hidden="true"></i></button>
                                        </li>
                                        <li class="active"><a class="Active" href="#" mode="All" id="All" onclick="SelectTab('All')">Requests</a></li>
                                        <li><a  mode="Dashboard"  id="Dashboard" onclick="SelectTab('Dashboard')">Dashboard</a></li>
                                        <%If IsHRMOrAdmin = "1" Then%>
                                        <li><a  mode="UnCategorized" id="UnCategorized" onclick="SelectTab('UnCategorized')">UnCategorized</a></li>
                                         <%End If%>

                                        <%-- Commented By Vaijat K ON 17/11/2017 For Releasing to Production --%>
                                        <%--<li><a href="#" Mode="KM">Knowledge</a></li>--%>
                                        <%-- End of Commented By Vaijat K ON 17/11/2017 For Releasing to Production --%>

                                        <%If objAccess.Access.ToString = "True" And CommonFunctions.General.GetApplicationKeySetting("ShowSettingPage") = "1" Then%>
                                        <li style="float: right; padding-right: 0; display: none;" class="setting-btn">
                                            <button type="button" class="btn " style="border: none; padding: 0;" title="Setting" id="btnSetting"><i class="fa fa-cog" aria-hidden="true"></i></button>
                                        </li>
                                        <%End If%>
                                       <%-- <li style="float: right">
                                            <label class="label label-danger" title="Whizible version 13">Beta Version</label>
                                        </li>--%>
                                    </ul>
                                </div>
                            </div>

                        </div>

                    </div>

                    <div id="HelpdeskFrameDiv" class="row">
                        <%If Request.QueryString("QueryID") IsNot Nothing Then%>
						<%--Commented And Added By Usha Pandit On 25.01.2020 For getting default selected request filter --%>
                        <%--<iframe name="frmHelpdeskFrame" id="frmHelpdeskFrame" src="../Request/CRM_RequestDetailsNew.aspx?Mode=EDIT&FromWhere=DB&QueryEditAccess=True&PageFlag=DefaultSR&PageNumber=1<%=IIf(Request.QueryString("QueryID") Is Nothing, "", "&QueryID=" & Request.QueryString("QueryID"))%>" scrolling="auto" marginwidth="0" allowtransparency="false" marginheight="0" frameborder="0" vspace="0" hspace="0" style="width: 100%; height: 528PX;">
                            <div></div>
                        </iframe>--%>
                        <%If Request.QueryString("LoadFilterID") IsNot Nothing Then%>
                        <iframe name="frmHelpdeskFrame" id="frmHelpdeskFrame" src="../Request/CRM_RequestDetailsNew.aspx?Mode=EDIT&FromWhere=DB&QueryEditAccess=True&PageFlag=<%= Request.QueryString("LoadFilterID")%>&PageNumber=1<%=IIf(Request.QueryString("QueryID") Is Nothing, "", "&QueryID=" & Request.QueryString("QueryID"))%>" scrolling="auto" marginwidth="0" allowtransparency="false" marginheight="0" frameborder="0" vspace="0" hspace="0" style="width: 100%; height: 528PX;">
                            <div></div>
                        </iframe> <%--modified height by pradip on 24-02-2021--%>
                        <%Else%>
                        <iframe name="frmHelpdeskFrame" id="frmHelpdeskFrame" src="../Request/CRM_RequestDetailsNew.aspx?Mode=EDIT&FromWhere=DB&QueryEditAccess=True&PageFlag=DefaultSR&PageNumber=1<%=IIf(Request.QueryString("QueryID") Is Nothing, "", "&QueryID=" & Request.QueryString("QueryID"))%>" scrolling="auto" marginwidth="0" allowtransparency="false" marginheight="0" frameborder="0" vspace="0" hspace="0" style="width: 100%; height: 528PX;">
                            <div></div>
                        </iframe> <%--modified height by pradip on 24-02-2021--%>
						<%End If%>
                        <%--End Of Added By Usha Pandit On 25.01.2020 For getting default selected request filter --%>
                        <%Else%>
                        <iframe name="frmHelpdeskFrame" id="frmHelpdeskFrame" src="../RequestList/CRM_RequestListNew.aspx?Mode=SR<%=IIf(Request.QueryString("QueryID") Is Nothing, "", "&QueryID=" & Request.QueryString("QueryID"))%>" scrolling="auto" marginwidth="0" allowtransparency="false" marginheight="0" frameborder="0" vspace="0" hspace="0" style="width: 100%; height: 528PX;">
                            <div></div>
                        </iframe> <%--modified height by pradip on 24-02-2021--%>
                        <%End If%>
                        
                    </div>
                </div>
                <%--container-fluid--%>
            </div>
            <%-- content-wrapper--%>
        </div>

    </form>
</body>

<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../General/CommonFunctions.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
<script>
    /*Added By Yasmin on 18th july 2018*/
    $('[data-toggle="tooltip"]').tooltip();
    $(document).click(function () {
        $("#profileDropdwn", window.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.document).parent().removeClass("open");

    });
    $('[data-toggle="tooltip"]').click(function () {
        $('.tooltip').fadeOut('fast', function () {
            $('.tooltip').remove();
        });
    });
    $(".btnNewRequest").mouseenter(function () {
        $('.tooltip').fadeIn('fast', function () {
            $('.tooltip').add();
        });
    });
    
    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
        /**********************************Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
        var ObjTd = window.frames.parent.document.getElementById('tdTree')
        var ObjImg = window.frames.parent.document.getElementById('ImgShowHide')
        var ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')

        if (ObjTd != null && ObjImg != null) {

            ObjTd.style.display = 'none';
            ObjImg.src = '../../Images/Home/RightMove.gif';
            ObjLeftnavigation.style.display = '';
        }

        //var bodyHeight = window.innerHeight - 100;//Commented by pradip on 24-2-2021
        //$('#frmHelpdeskFrame').css('height', bodyHeight - 5 + 'px');//Commented by pradip on 24-2-2021
        $('[data-toggle="tooltip"]').tooltip();

        //*********************************************Bharat**************************************************************       
    });

    //Added By Dipali V On 23th March 2023 For Selecting Tab 
    function SelectTab(strMode) {
        $("#hdnMode").val(strMode);
        $(".clsTopNav li a").removeClass("Active");
        $("#" + strMode).addClass("Active");

        if (strMode == 'Dashboard') {
            setFrameLoader();
            $("#frmHelpdeskFrame").attr("src", "../Dashboard/Helpdesk_Dashboard.aspx");
            // RemoveFrameLoader();
            setTimeout(function () {
                RemoveFrameLoader();
            }, 500);
            //$("#frmHelpdeskFrame").contents().find("body").html("<h4>Dashboard Page is under develpment.</h4>");
        }
        else if (strMode == 'KM') {
            //$("#frmHelpdeskFrame").attr("src", "");
            $("#frmHelpdeskFrame").contents().find("body").html("<h4>Knowledge Page is under develpment.</h4>");
        }
        else if (strMode == 'UnCategorized') {
            setFrameLoader();
            $("#frmHelpdeskFrame").attr("src", "../RequestList/CRM_UnCategorizedRequestList.aspx");
            // RemoveFrameLoader();
            setTimeout(function () {
                RemoveFrameLoader();
            }, 500);
        }
        else if (strMode == 'All') {
            setFrameLoader();

            $("#frmHelpdeskFrame").attr("src", "../RequestList/CRM_RequestListNew.aspx?Mode=SR");
            // RemoveFrameLoader();
            setTimeout(function () {
                RemoveFrameLoader();
            }, 500);
        }
        
    }

     //End of Added By Dipali V On 23th March 2023 For Selecting Tab 
   
    //Added By Bharat T on 5th-Oct-2017
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
        else if (strMode == 'UnCategorized') {
            setFrameLoader();
            $("#frmHelpdeskFrame").attr("src", "../RequestList/CRM_UnCategorizedRequestList.aspx");
        }
        else if (strMode == 'All') {
            setFrameLoader();

            $("#frmHelpdeskFrame").attr("src", "../RequestList/CRM_RequestListNew.aspx?Mode=SR");
        }

    });

    //$("#btnNewRequest").click(function () {
    /*$("#btnNewRequest").on('click', function () {*/
    //$(document).on('click', '#btnNewRequest', function () {
    //    $(".clsTopNav li a").removeClass("Active");
    //    $("#frmHelpdeskFrame").attr("src", "../Request/CRM_AddNewRequest.aspx?Mode=SR");
    //    setFrameLoader();
    //});

    function clickbtnNewRequest() {
        
        $(".clsTopNav li a").removeClass("Active");
        $("#frmHelpdeskFrame").attr("src", "../Request/CRM_AddNewRequest.aspx?Mode=SR");
        setFrameLoader();
        setTimeout(function () {
            RemoveFrameLoader();
        }, 2500);
        

    }
   

    $("#btnSetting").click(function () {
        $("#frmHelpdeskFrame").attr("src", "../Settings/Settings_Tabs.aspx");
        //setFrameLoader();
        $(".clsTopNav li a").removeClass("Active");
        // $("#frmHelpdeskFrame").contents().find("body").html("<h4>Setting Page is under develpment.</h4>");
    });

    //End of Added By Bharat T on 5th-Oct-2017

    $("#frmHelpdeskFrame").load(function () {

        /**********************************Added By Bharat T on 5th-Oct-2017 for new request list changes*************************************************/
        var ObjTd = window.frames.parent.document.getElementById('tdTree')
        var ObjImg = window.frames.parent.document.getElementById('ImgShowHide')
        var ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')

        if (ObjTd != null && ObjImg != null) {

            ObjTd.style.display = 'none';
            ObjImg.src = '../../Images/Home/RightMove.gif';
            ObjLeftnavigation.style.display = '';
        }

        //*********************************************Bharat**************************************************************
        RemoveFrameLoader();

    });
</script>
<script>
    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>
</html>
