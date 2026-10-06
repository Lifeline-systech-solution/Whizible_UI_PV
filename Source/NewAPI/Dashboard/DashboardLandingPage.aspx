<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DashboardLandingPage.aspx.vb" Inherits="PbNIT.DashboardLandingPage" %>

<!DOCTYPE html>
<html>
     <%CommonFunctions.General.PlotPageHeadTag("Dashboard")%>
<head>
     <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">--%>

        <!--Whizible20_theme_custome---->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
        <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/skins/_all-skins.min.css">

       <link href='../../../Whizible2.0-new/dist/css/animate.css' rel='stylesheet'>


</head>

    <style type="text/css">
        /* Changed background color to white by Madhuri.k on 10-12-2025 */
       body{background:#fff}
       /* Changed background color to white by Madhuri.k on 10-12-2025 */
.content-wrapper,.right-side{background:#fff}
.content-wrapper{height:100%;min-height:100vh}
.dashmain .TLmain.content{padding:20px}
.TL_treecirclecolumn{margin:-4.6em -15px 0;display:inline-block;vertical-align:top;width: 400px; white-space: nowrap;}
.TL_treecirclecolumn.first{margin-left:-30px}
.TL_treecirclecolumn.last{margin-right:20px}
.tl_wrap{text-align:center}
.TL_treelist{min-height:160px;width: 300px;white-space: normal;right:-28px;margin-left:10px;margin-bottom:-65px;padding-bottom:70px;position:relative;padding-left:40px;transition:all .6s ease-in}
/* Modified By Madhuri.K On 26-03-2026 */
ul.TL_treelist::before{content:"";position:absolute;left:0;height:100%;width:2px;background:#ec2029;transition:all .5s ease-in-out;top:9px}
.TL_treecirclecolumnBrown ul.TL_treelist::before{background:#ca6d20}
.TL_treecirclecolumnLightyellow ul.TL_treelist::before{background:#cebb0f}
.TL_treecirclecolumnGreen ul.TL_treelist::before{background:#6bcb21}
.TL_treecirclecolumnLightblue ul.TL_treelist::before{background:#21ecd9}
.TL_treecirclecolumnDarkblue ul.TL_treelist::before{background:#2062ec}
.TL_treelist li{position:relative;margin:0 0 6px;line-height:normal;min-width:166px}
/* Modified By Madhuri.K On 26-03-2026 */
.TL_treelist li span{font-size:11.5px;color:#464a4c;padding-left:10px;margin-top:0;display:block;text-align:left}
.TL_treelist li::before{content:"";position:absolute;left:-18px;width:16px;height:16px;border-radius:50%;background-size:contain;background-repeat:no-repeat;top:9px;background-image:url(../../../Whizible2.0-new/dist/img/Red_Dot.png);background-size:contain}
.TL_treecirclecolumnBrown .TL_treelist li::before{background-image:url(../../../Whizible2.0-new/dist/img/Orange-Dot.png)}
.TL_treecirclecolumnLightyellow .TL_treelist li::before{background-image:url(../../../Whizible2.0-new/dist/img/Yellow-Dot.png)}
.TL_treecirclecolumnGreen .TL_treelist li::before{background-image:url(../../../Whizible2.0-new/dist/img/Green-Dot.png)}
.TL_treecirclecolumnLightblue .TL_treelist li::before{background-image:url(../../../Whizible2.0-new/dist/img/Blue-Dot.png)}
.TL_treelist li:hover::before{animation:pulsate infinite 1s}
.TL_treelist li:hover span{color:#000}
@-webkit-keyframes pulsate {
0%{-webkit-transform:scale(1,1);opacity:1}
100%{-webkit-transform:scale(1.2,1.2);opacity:1}
}
.TL_treelist li::after{position:absolute;content:"";width:26px;height:2px;top:16px;left:-40px;display:block;background:#ec2029;border-radius:5px 0 0 0}
.TL_treecirclecolumn.Tl_treecolumOdd{margin-top:14.7em}
.Tl_treecolumOdd .TL_treelist{transform:scale(-1)}
.Tl_treecolumOdd .TL_treelist li{transform:scale(-1)}
.Tl_treecolumOdd .TL_treelist li::before{right:-16px;left:auto}
.Tl_treecolumOdd .TL_treelist li::after{right:-40px;left:auto; top:18px;}
.Tl_treecolumOdd .TL_treelist{margin-left:0;margin-right:-10px;right:auto;left:-38px;bottom:55px}
.TL_treecirclecolumn.TL_treecirclecolumnBrown.Tl_treecolumOdd{margin-top:8em}
.Tl_treecolumOdd .TL_treelist li span{margin-left:0;margin-right:10px;text-align:right}
.TL_treecirclecolumnBrown .TL_treelist li::after{background:#ca6d20}
.TL_treecirclecolumnLightyellow .TL_treelist li::after{background:#cebb0f}
.TL_treecirclecolumnGreen .TL_treelist li::after{background:#6bcb21}
.TL_treecirclecolumnLightblue .TL_treelist li::after{background:#21ecd9}
.TL_treecirclecolumnDarkblue .TL_treelist li::after{background:#2062ec}
.TL_treecirclebox{width:200px;height:200px;margin:0 auto;border-radius:50%;line-height:140px;text-align:center;padding:15px;overflow:hidden;position:relative;z-index:9999}
.TL_treecircleboxRed{background:#ec2029}
.TL_treecircleboxBrown{background:#ca6d20}
.TL_treecircleboxLightyellow{background:#cebb0f}
.TL_treecircleboxGreen{background:#6bcb21}
.TL_treecircleboxLightblue{background:#21ecd9}
.TL_treecircleboxDarkblue{background:#2062ec}
.TL_treecircleboxinner{line-height:normal;background:#fff;border-radius:50%;width:100%;height:100%;line-height:100%;position:relative;box-shadow:1px 0 6px -1px #464a4c}
/* Modified By Madhuri.K On 26-03-2026 */
.TL_treecircleboxinner p{position:absolute;top:0;left:0;right:0;height:50px;margin:auto;bottom:0;vertical-align:middle;padding-top:16px;font-size:17px;line-height:normal;font-weight:400}
.TL_treecircleboxinner p span{display:block}
.TL_treecircleboxinner:hover p{color:#000;text-shadow:0 1px 3px #ccc;transition:.2s ease-in-out 0}
a.closeLPbtn{position:absolute;right:30px;background:none;border:none;outline:none;opacity:.6}
a.closeLPbtn:hover{opacity:1}

/*pady css*/
.Tl_treecolumOdd ul.TL_treelist::before{ top:32px;}

.PLPHeading{text-align:center;margin-bottom:40px}
.PLPHeading h2{line-height:normal;color:#4263c1; font-size: 22px;}
.tl_wrap {display: inline-flex;flex-wrap: nowrap;width: 100%;align-content: space-around;justify-content: center;align-items: center;}
.tl_wrap>div:first-child .TL_treelist{ right:-92px;}
.tl_wrap>div:nth-child(2n) .TL_treelist{ left:-18px; margin-right:-12px; bottom:50px;}
.tl_wrap>div:nth-child(2n) .TL_treelist li{ margin-right:-80px;}
.tl_wrap>div:nth-child(3n) .TL_treelist{ right:-117px; margin-left:-15px;}


@media screen and (max-width:767px){

.content-wrapper, .right-side, .main-footer{ margin-left: 0!important; }
.fixed .content-wrapper, .fixed .right-side{ padding-top: 0!important; }

}

@media only screen and (max-device-height: 780px) {
/*.TL_treecirclecolumn{ margin-top: 0px; }*/
/*.TL_treecirclecolumn.TL_treecirclecolumnBrown.Tl_treecolumOdd {margin-top:160px;}
.TL_treecirclecolumn.Tl_treecolumOdd { margin-top: 160px;}*/

}

/* Added CSS by Madhuri.K On 22-Aug-2024 for adding dots on landing page Start here*/

/* Added CSS by Madhuri.K On 22-Aug-2024 for adding dots on landing page End here*/
    </style>


<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">

            <!-- Main content -->
            <!-- Commented graybg class by Madhuri.K on 10-12-2025 -->
            <section class="content TLmain">

                <div class="landingpg_wrapper">
                    <!--<a href="#" class="closeLPbtn"><img data-toggle="tooltip" data-placement="left" data-container="body" title="Click here hide view" src="dist/img/close.svg" width="16px" style="width: 26px;"></a>-->
                    <div class="PLPHeading">
                        <h2>Real-time Data Analytics & Project Dashboards</h2>
                    </div>

                    <div class="tl_wrap">
                        <div class="TL_treecirclecolumn first animated fadeInDown">
                            <div class="TL_treecirclecolumn_inner">
                                <ul class="TL_treelist">
                                    <li><span>Strong end-to-end integration enables the capture of all project data in a real-time, which is used to generate metrics reports and dashboards</span></li>

                                </ul>
                                <div class="TL_treecirclebox TL_treecircleboxRed">
                                    <div class="TL_treecircleboxinner"><p class="tl_circletitle">Metrics based on<span>real-time data</span></p></div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>


                        <div class="TL_treecirclecolumn TL_treecirclecolumnBrown Tl_treecolumOdd animated fadeInUp">
                            <div class="TL_treecirclecolumn_inner">
                                <div class="TL_treecirclebox TL_treecircleboxBrown">
                                    <div class="TL_treecircleboxinner"><p class="tl_circletitle">Offers Single <span>Version of Truth</span></p></div>
                                </div>
                                <ul class="TL_treelist">
                                    <li><span>Whizible offers single master data using interconnected modules and easy integration with other software used by the project organization</span></li>

                                </ul>
                                <div class="clearfix"></div>

                            </div>
                        </div>


                        <div class="TL_treecirclecolumn TL_treecirclecolumnLightyellow animated fadeInDown">
                            <div class="TL_treecirclecolumn_inner">
                                <ul class="TL_treelist">

                                    <li><span>Whizible can be configured and customized based on the resource role</span></li>
                                </ul>
                                <div class="TL_treecirclebox TL_treecircleboxLightyellow">
                                    <div class="TL_treecircleboxinner"><p class="tl_circletitle">Access-based<span>Dashboards</span></p></div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <div class="clearfix"></div>
                    </div>
                </div>

            </section>
        
    <!--wrapper-->
    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>

<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>







</body>

</html>