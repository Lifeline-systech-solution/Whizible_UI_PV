<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmAgileTree.aspx.vb" Inherits="PbNIT.frmAgileTree" %>

<!DOCTYPE html>

<html>

<head id="Head1" runat="server">
   <%-- <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">--%>
    <%CommonFunctions.General.PlotPageHeadTag("Product Backlog")%>
<%--    <link href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" rel="stylesheet" />

    <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <script src="js/jquery.nicescroll.js"></script>
<%--    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link href='../General/loaderStylesheet.css?v=1.3' rel='stylesheet' />
    <script>
        $(document).ready(function () {
            document.getElementById("divMain").style.height = window.innerHeight - 3 + 'px';
            //document.getElementById("divTree").style.height = window.innerHeight - 10 + 'px';
            document.getElementById("frmNavigation").style.height = window.innerHeight - 10 + 'px';
        })

        function NavigateToAgile(pageName, obj) {
            //setFrameLoader();
            $(".tab").removeClass("active");
            obj.className = "tab active";
            document.getElementById("frmNavigation").src = pageName;
        }
    </script>
   
</head>
     <style>
        .active {
            /*background: rgba(51, 51, 51, 0.8);*/
            color: #fff !important;
        }

        .Activity {
            height: 450px;
            overflow-y: auto;
            overflow-x: hidden !important;
        }

        #tblTree {
            width: 100%;
            margin-top: 18px;
            /*position: relative;
            overflow: hidden;
            height: 450px;
            width: 61px;
            transform: translate(22%,0);*/
        }

        /*#tblTree tbody {
                width: 94px;
                overflow-y: scroll;
                position: absolute;
                height: 450px;
                transform: translate(13%,0);
                z-index: 999;
                overflow-x: hidden;
            }*/

        .arrow {
            text-align: center !important;
            margin: 16% 0;
        }

            .arrow:hover {
                overflow: hidden !important;
            }

        #tblTree tr td {
            /*height: 65px;*/
            height: 79px;
            color: #fff;
            /*background: rgba(51, 51, 51, 0.8);*/
            cursor: pointer;
            text-align: center;
            border-bottom: 1px solid #ddd;
                border-left: 1px solid #4263c1;
        border-right: 1px solid #4263c1; 

        }

        /*.PageName {
            position: absolute;
            display: inline-block;
            top: 50%;
            left: 130px;
            margin-top: -20px;
            margin-left: 20px;
            text-align: left;
            white-space: nowrap;
            padding: 10px 13px;
            border-width: 0px !important;
            background-color: rgb(51, 51, 51);
            background-color: rgba(51, 51, 51, 0.8);
        }*/

        label {
            display: inline-block;
            max-width: 100%;
            MARGIN-TOP: 8PX;
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px; 
            margin-bottom: 5px;
            font-weight: 500;
            width: 100%;
            text-align: center;
            cursor: pointer;
        }

        #divTree {
            overflow-y: auto;
            overflow-x: hidden;
            border-radius: 2.1vw;
            background: #4263c1;
            text-align: center !important;
            /*width: 7.2vw;*/
            /*width: 115%;*/
        }

        #tblMain {
            width: 100%;
        }

        #tdLeft {
            width: 10%;
            overflow: hidden !important;
        }

        #tdRight {
            width: 90%;
        }

        #frmNavigation {
            height: 100%;
            width: 100%;
        }

        .fa, .fas, .far {
            /*font-size: 25px;*/
            font-size: 20px;
            cursor: pointer;
            /*color: #fff !important;*/
        }

        /*.PageName {
            display: none;
        }*/

        #icnHide {
            top: 0%;
            position: absolute;
            font-size: 22px;
            margin-left: 80px;
            margin-top: 2px;
        }

        .HeaderFreeze {
            margin-top: 45px;
        }

        .animate {
            -webkit-transition: all 0.3s ease-in-out;
            -moz-transition: all 0.3s ease-in-out;
            -o-transition: all 0.3s ease-in-out;
            -ms-transition: all 0.3s ease-in-out;
            transition: all 0.3s ease-in-out;
        }

        .navbar-fixed-left {
            position: fixed;
            top: 0px;
            left: 0px;
            border-radius: 0px;
        }

        .navbar-minimal {
            width: 42px;
            min-height: 40px;
            max-height: 100%;
            background-color: #4263c1; /*modified by pradip on 6-10-2020*/
            border-width: 0px;
            z-index: 1000;
            margin: 7px 6px;
            border-radius: 20px;
        }

            .navbar-minimal > .navbar-toggler {
                position: relative;
                min-height: 36px;
                z-index: 100;
                cursor: pointer;
            }

                .navbar-minimal.open > .navbar-toggler,
                .navbar-minimal > .navbar-toggler:hover {
                }

                .navbar-minimal > .navbar-toggler > span {
                    position: absolute;
                    top: 50%;
                    right: 50%;
                    margin: -8px -8px 0 0;
                    width: 16px;
                    height: 16px;
                    /*background-image: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE2LjIuMSwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoJIHdpZHRoPSIxNnB4IiBoZWlnaHQ9IjMycHgiIHZpZXdCb3g9IjAgMCAxNiAzMiIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgMTYgMzIiIHhtbDpzcGFjZT0icHJlc2VydmUiPgo8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iI0ZGRkZGRiIgZD0iTTEsN2gxNGMwLjU1MiwwLDEsMC40NDgsMSwxcy0wLjQ0OCwxLTEsMUgxQzAuNDQ4LDksMCw4LjU1MiwwLDgKCVMwLjQ0OCw3LDEsN3oiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGZpbGw9IiNGRkZGRkYiIGQ9Ik0xLDEyaDE0YzAuNTUyLDAsMSwwLjQ0OCwxLDFzLTAuNDQ4LDEtMSwxSDFjLTAuNTUyLDAtMS0wLjQ0OC0xLTEKCVMwLjQ0OCwxMiwxLDEyeiIvPgo8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iI0ZGRkZGRiIgZD0iTTEsMmgxNGMwLjU1MiwwLDEsMC40NDgsMSwxcy0wLjQ0OCwxLTEsMUgxQzAuNDQ4LDQsMCwzLjU1MiwwLDMKCVMwLjQ0OCwyLDEsMnoiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGZpbGw9IiNGRkZGRkYiIGQ9Ik0xLjMzLDI4Ljk3bDExLjY0LTExLjY0YzAuNDU5LTAuNDU5LDEuMjA0LTAuNDU5LDEuNjYzLDAKCWMwLjQ1OSwwLjQ1OSwwLjQ1OSwxLjIwNCwwLDEuNjYzTDIuOTkzLDMwLjYzM2MtMC40NTksMC40NTktMS4yMDQsMC40NTktMS42NjMsMEMwLjg3MSwzMC4xNzQsMC44NzEsMjkuNDMsMS4zMywyOC45N3oiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGZpbGw9IiNGRkZGRkYiIGQ9Ik0yLjk5MywxNy4zM2wxMS42NDEsMTEuNjRjMC40NTksMC40NTksMC40NTksMS4yMDQsMCwxLjY2MwoJcy0xLjIwNCwwLjQ1OS0xLjY2MywwTDEuMzMsMTguOTkzYy0wLjQ1OS0wLjQ1OS0wLjQ1OS0xLjIwNCwwLTEuNjYzQzEuNzg5LDE2Ljg3MSwyLjUzNCwxNi44NzEsMi45OTMsMTcuMzN6Ii8+Cjwvc3ZnPgo=);
                    background-repeat: no-repeat;
                    background-position: 0 0;*/ /*Commented by pradip on 12-4-2023*/
                    -webkit-transition: -webkit-transform .3s ease-out 0s;
                    -moz-transition: -moz-transform .3s ease-out 0s;
                    -o-transition: -moz-transform .3s ease-out 0s;
                    -ms-transition: -ms-transform .3s ease-out 0s;
                    transition: transform .3s ease-out 0s;
                    -webkit-transform: rotate(0deg);
                    -moz-transform: rotate(0deg);
                    -o-transform: rotate(0deg);
                    -ms-transform: rotate(0deg);
                    transform: rotate(0deg);
                }

            .navbar-minimal > .navbar-menu {
                position: absolute;
                top: -1000px;
                left: 0px;
                margin: 0px;
                padding: 0px;
                list-style: none;
                z-index: 50;
            }

                .navbar-minimal > .navbar-menu > li {
                    margin: 0px;
                    padding: 0px;
                    border-width: 0px;
                    height: 54px;
                }

                    .navbar-minimal > .navbar-menu > li > a {
                        position: relative;
                        display: inline-block;
                        color: rgb(255, 255, 255);
                        padding: 15px 23px;
                        text-align: left;
                        cursor: pointer;
                        border-bottom: 1px solid rgb(81, 81, 81);
                        width: 100%;
                        text-decoration: none;
                        margin: 0px;
                    }

                        .navbar-minimal > .navbar-menu > li > a:last-child {
                            border-bottom-width: 0px;
                        }

                        .navbar-minimal > .navbar-menu > li > a:hover {
                            background-color: rgb(158, 202, 59);
                        }

                        .navbar-minimal > .navbar-menu > li > a > .glyphicon {
                            float: right;
                        }

            .navbar-minimal.open {
                /*width: 65px;*/
                width: 75px;
                border-radius: 20px;
                /* margin-bottom: 20px; */
                min-height: 70px;
            }

                .navbar-minimal.open > .navbar-toggler > span {
                    background-position: 0 -16px;
                    -webkit-transform: rotate(-180deg);
                    -moz-transform: rotate(-180deg);
                    -o-transform: rotate(-180deg);
                    -ms-transform: rotate(-180deg);
                    transform: rotate(-180deg);
                    margin-top: -7px;
                }

                .navbar-minimal.open > .navbar-menu {
                    /*position: unset;*/
                    top: 33px;
                    width: 100%;
                    min-height: 100%;
                }

        #tblTree tbody tr td:hover {
            /*background-color: rgb(158, 202, 59);*/
        }

        .nicescroll-rails {
            width: 0px !important;
            left: 51px !important;
        }

        .fa-angle-double-down .tooltip {
            left: -15px !important;
            pointer-events: none;
            position: absolute !important;
        }


        .tooltip {
            pointer-events: none;
        }

        @media (min-width: 768px) {
            .navbar-minimal.open {
                /*width: 60px;*/
                text-align: center;
                display: inherit;
            }

                .navbar-minimal.open > .navbar-menu {
                    overflow: visible;
                }

            .navbar-minimal > .navbar-menu > li > a > .desc {
                position: absolute;
                display: inline-block;
                top: 50%;
                left: 130px;
                margin-top: -20px;
                margin-left: 20px;
                text-align: left;
                white-space: nowrap;
                padding: 10px 13px;
                border-width: 0px !important;
                background-color: rgb(51, 51, 51);
                background-color: rgba(51, 51, 51, 0.8);
                opacity: 0;
            }

                .navbar-minimal > .navbar-menu > li > a > .desc:after {
                    z-index: -1;
                    position: absolute;
                    top: 50%;
                    left: -10px;
                    margin-top: -10px;
                    content: '';
                    width: 0;
                    height: 0;
                    border-top: 10px solid transparent;
                    border-bottom: 10px solid transparent;
                    border-right: 10px solid rgb(51, 51, 51);
                    border-right-color: rgba(51, 51, 51, 0.8);
                }

            .navbar-minimal > .navbar-menu > li > a:hover > .desc {
                left: 60px;
                opacity: 1;
            }
        }
        /*Added by pradip on 6-10-2020*/
        #divTree .Activity {
    background-color: #4263c1 !important;
    color: white !important;
}
            #divTree .fa, #divTree .fas, #divTree .far {color: white !important;
            }
            /*End Added by pradip on 6-10-2020*/
td.tab:hover {background: #2e52a3;}
/*Added by pradip on 12-4-2023*/
.navbar-minimal > .navbar-toggler > span.openmenu{ display:block;}
.navbar-minimal > .navbar-toggler > span.closemenu{ display:none;}
.navbar-minimal.open > .navbar-toggler > span.openmenu{ display:none;}
.navbar-minimal.open > .navbar-toggler > span.closemenu{ display:block;}
/*End Added by pradip on 12-4-2023*/

    </style>
<body>
    <form id="form1" runat="server">
        <div id="divMain">
            <table id="tblMain">
                <tr>
                    <%--<td id="tdLeft"><%CommonFunctions.General.WriteHTML(PlotLeftTree())%></td>--%>
                    <td id="tdRight">
                        <%--   <i class="fa fa-bars" aria-hidden="true" id="icnHide"></i>--%>
                        <nav class="navbar navbar-fixed-left navbar-minimal animate menuburger " role="navigation">
                            <div class="navbar-toggler animate">
                                <%--  Added By Dipali V on 6th June 2018 For Issue Fixing--%>
                                <%--<span class="icon-bar" data-bs-original-title="Agile Menu's" data-bs-placement="right"></span>
                                <span class="icon-bar" data-bs-original-title="Agile Menu's" data-bs-placement="right"></span>
                                <span class="icon-bar" data-bs-original-title="Agile Menu's" data-bs-placement="right"></span>--%>                                
                                <%-- End of Added By Dipali V on 6th June 2018 For Issue Fixing--%>
                                <!--Commented prev code and added new code for toggle menu- added by pradip on 12-4-2023-->
                                <span class="navbar-toggler-icon openmenu"><i class="fas fa-bars" style="color: #ffffff;"></i></span>
                                <span class="navbar-toggler-icon closemenu"><i class="fas fa-times" style="color: #ffffff;"></i></span>
                                <!--End added by pradip on 12-4-2023-->
                            </div>

                            <ul class="navbar-menu animate">
                                <li>

                                    <%CommonFunctions.General.WriteHTML(PlotLeftTree())%>
				
                                </li>
                            </ul>
                        </nav>
                        <iframe id="frmNavigation" src="<%=strPageName%>"></iframe>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
<script>
    $(document).ready(function () {
        $(document).hover(function () {
            $(".tooltip").removeClass("in");
        });
        $(document).click(function () {
            $(".tooltip").removeClass("in");
        });
        $(".Activity").niceScroll({
            scrollspeed: 10
            //A smaller value increases the scroll speed. A larger value makes the scroll speed slower.

        });
        $(".navbar-toggler").mouseleave(function () {
            $(".tooltip").removeClass("in");
        });

        $(".fa-angle-double-down").mouseleave(function () {
            $(".tooltip").removeClass("in");
        });
        $(".fa-angle-double-down").hover(function () {
            $(".tooltip").removeClass("out");
        });
        $('[data-bs-toggle="tooltip"]').tooltip();



        $('.navbar-toggler').on('click', function (event) {
            event.preventDefault();
            $(this).closest('.navbar-minimal').toggleClass('open');


        });
        $('.navbar-menu li').on('click', function () {
            $(".navbar-minimal").removeClass("open");

        });
        /*Added by Yasmin on 8th May 2018Scroll Position Detect*/
        $(".Activity").scroll(function () {
            if ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
                $(".arrow").toggleClass("fa-angle-double-down fa-angle-double-up");
                $('.arrow').attr('data-original-title', 'Scroll Up');
            }
            if ($(this).scrollTop() == 0) {
                $(".arrow").toggleClass("fa-angle-double-up fa-angle-double-down ");
                $('.arrow').attr('data-original-title', 'Scroll Down');

            }
        });
    });
    $(".navbar-toggler").mouseenter(function () {
        $(".tooltip").addClass("in");
    });
    $(".navbar-toggler").mouseleave(function () {
        $(".tooltip").removeClass("in");
    });
</script>
</html>
