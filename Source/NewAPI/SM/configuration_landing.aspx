<%@ Page Language="vb" AutoEventWireup="false"  %>

<!DOCTYPE html>
<html>
         <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Project")%> 
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />    
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
<%--    <link href='../../../Whizible2.0-new/dist/css/animate.css' rel='stylesheet'>--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">



</head>
    <style type="text/css">
       body{background:#ffffff; overflow:hidden;}
/* Changed background color to white by Madhuri.K on 10-12-2025 */
.content-wrapper,.right-side{background:#fff}
/* Changed background color to white by Madhuri.K on 10-12-2025 */
.content-wrapper{height:100%;}
.dashmain .TLmain.content{padding:20px}
/*.TL_treecirclecolumn{margin:5.5em -15px 0;display:inline-block;vertical-align:top}*/
.TL_treecirclecolumn.first{margin-left:-30px}
.TL_treecirclecolumn.last{margin-right:20px}
.tl_wrap{text-align:center}
.TL_treelist{min-height:150px;right:-28px;margin-left:10px;margin-bottom:-55px;padding-bottom:70px;position:relative;padding-left:40px;top:12px;transition:all .6s ease-in}
/* Modified By Madhuri.K On 26-03-2026 */
ul.TL_treelist::before{content:"";position:absolute;left:0;height:100%;width:2px;background:#ec2029;transition:all .5s ease-in-out;top:-3px}
.TL_treecirclecolumnBrown ul.TL_treelist::before{background:#ca6d20}
.TL_treecirclecolumnLightyellow ul.TL_treelist::before{background:#cebb0f}
.TL_treecirclecolumnGreen ul.TL_treelist::before{background:#6bcb21}
.TL_treecirclecolumnLightblue ul.TL_treelist::before{background:#21ecd9}
.TL_treecirclecolumnDarkblue ul.TL_treelist::before{background:#2062ec}
.TL_treelist li{position:relative;margin:0 0 6px;line-height:normal;min-width:166px; top:-8px;}
/* Modified By Madhuri.K On 26-03-2026 */
.TL_treelist li span{font-size:11.5px;color:#464a4c;padding-left:10px;margin-top:0;display:block;text-align:left}
.TL_treelist li::before{content:"";position:absolute;left:-18px;width:16px;height:16px;border-radius:50%;background-size:contain;background-repeat:no-repeat;background-image:url(../../../whizible2.0-new/dist/img/Red_Dot.png);background-size:contain}
.TL_treecirclecolumnBrown .TL_treelist li::before{background-image:url(../../../whizible2.0-new/dist/img/Orange-Dot.png)}
.TL_treecirclecolumnLightyellow .TL_treelist li::before{background-image:url(../../../whizible2.0-new/dist/img/Yellow-Dot.png)}
.TL_treecirclecolumnGreen .TL_treelist li::before{background-image:url(../../../whizible2.0-new/dist/img/Green-Dot.png)}
.TL_treecirclecolumnLightblue .TL_treelist li::before{background-image:url(../../../whizible2.0-new/dist/img/Blue-Dot.png)}
.TL_treelist li:hover::before{animation:pulsate infinite 1s}
.TL_treelist li:hover span{color:#000}
@-webkit-keyframes pulsate {
0%{-webkit-transform:scale(1,1);opacity:1}
100%{-webkit-transform:scale(1.2,1.2);opacity:1}
}
.TL_treelist li::after{position:absolute;content:"";width:28px;height:2px;top:7px;left:-40px;display:block;background:#ec2029;border-radius:5px 0 0 0}
.TL_treecirclecolumn.Tl_treecolumOdd{/*margin-top:14.7em*/ margin-top:93px;}
/*added by pradip on 23-9-2020*/
.TL_treecirclecolumn {
    /*margin-top: -93px;*/
    margin: -93px -15px 0;
}
/*End of added by pradip on 23-9-2020*/
.Tl_treecolumOdd .TL_treelist{transform:scale(-1)}
.Tl_treecolumOdd .TL_treelist li{transform:scale(-1)}
.Tl_treecolumOdd .TL_treelist li::before{right:-16px;left:auto}
.Tl_treecolumOdd .TL_treelist li::after{right:-40px;left:auto}
.Tl_treecolumOdd .TL_treelist{margin-left:0;margin-right:-10px;right:auto;left:auto; right:38px; bottom:65px; top:auto;}
/*.TL_treecirclecolumn.TL_treecirclecolumnBrown.Tl_treecolumOdd{margin-top:14.5em}*/
.Tl_treecolumOdd .TL_treelist li span{margin-left:0;margin-right:10px;text-align:right}
.TL_treecirclecolumnBrown .TL_treelist li::after{background:#ca6d20}
.TL_treecirclecolumnLightyellow .TL_treelist li::after{background:#cebb0f}
.TL_treecirclecolumnGreen .TL_treelist li::after{background:#6bcb21}
.TL_treecirclecolumnLightblue .TL_treelist li::after{background:#21ecd9}
.TL_treecirclecolumnDarkblue .TL_treelist li::after{background:#2062ec}
.TL_treecirclebox{width:140px;height:140px;margin:0 auto;border-radius:50%;line-height:140px;text-align:center;padding:15px;overflow:hidden;position:relative;z-index:9999}
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
/*.Tl_treecolumOdd ul.TL_treelist::before{ top:13px;}*/

/*newcss*/
.tl_wrap {
    text-align: center;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    align-self: center;
    justify-content: center;
    height: 100%;
    /* min-height: 80vh; */
}
.landingpg_wrapper {
    height: 100%;
}

@media screen and (max-width: 767x){

.content-wrapper, .right-side, .main-footer{ margin-left: 0!important; }
.fixed .content-wrapper, .fixed .right-side{ padding-top: 0!important; }

}

@media only screen and (max-device-height: 780px) {
/*.TL_treecirclecolumn{ margin-top: 0px; }*/
/*.TL_treecirclecolumn.TL_treecirclecolumnBrown.Tl_treecolumOdd {margin-top:160px;}
.TL_treecirclecolumn.Tl_treecolumOdd { margin-top: 160px;}*/

}


    </style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">


    
            <!-- Content Header (Page header) -->
            <!-- Main content -->
            <!-- Commented graybg class by Madhuri.K on 10-12-2025 -->
            <section class="content TLmain ">

                <div class="landingpg_wrapper">
<!--commented by pradip on 2-10-2020-->
                    <!--<a href="#" class="closeLPbtn"><img data-toggle="tooltip" data-placement="left" data-container="body" title="Click here hide view" src="../../../Whizible2.0/dist/img/close.svg" width="16px" style="width: 26px;"></a>-->

                    <div class="tl_wrap">
                        <div class="TL_treecirclecolumn first animated fadeInDown">
                            <div class="TL_treecirclecolumn_inner">
                                <ul class="TL_treelist">

                                    <li><span>Organization Structure</span></li>
                                    <li><span>Stakeholders</span></li>
                                    <li><span>Business Units</span></li>

                                </ul>
                                <div class="TL_treecirclebox TL_treecircleboxRed">
                                    <div class="TL_treecircleboxinner"><p class="tl_circletitle">Constitute<span>&nbsp;</span></p></div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>


                        <div class="TL_treecirclecolumn TL_treecirclecolumnBrown Tl_treecolumOdd animated fadeInUp">
                            <div class="TL_treecirclecolumn_inner">
                                <div class="TL_treecirclebox TL_treecircleboxBrown">
                                    <div class="TL_treecircleboxinner"><p class="tl_circletitle">Construct</p></div>
                                </div>
                                <ul class="TL_treelist">
                                    <li><span>Roles and Privileges</span></li>
                                    <li><span>Access and Security</span></li>
                                    <li><span>Collaboration Protocols</span></li>
                                </ul>
                                <div class="clearfix"></div>

                            </div>
                        </div>



                        <div class="TL_treecirclecolumn TL_treecirclecolumnLightyellow animated fadeInDown">
                            <div class="TL_treecirclecolumn_inner">
                                <ul class="TL_treelist">
                                    <li><span>Modules and Sub Modules</span></li>
                                    <li><span>Interconnect Variables</span></li>
                                    <li><span>Synchronize Behavior</span></li>
                                </ul>
                                <div class="TL_treecirclebox TL_treecircleboxLightyellow">
                                    <div class="TL_treecircleboxinner"><p class="tl_circletitle">Parameterize<span>&nbsp;</span></p></div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <div class="TL_treecirclecolumn TL_treecirclecolumnGreen Tl_treecolumOdd animated fadeInUp">
                            <div class="TL_treecirclecolumn_inner">
                                <div class="TL_treecirclebox TL_treecircleboxGreen">
                                    <div class="TL_treecircleboxinner"><p class="tl_circletitle">Envision<span>&nbsp;</span></p></div>
                                </div>
                                <ul class="TL_treelist">
                                    <li><span>Data Integration</span></li>
                                    <li><span>Scaling of Deployment</span></li>
                                    <li><span>Modus Operandi</span></li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                        </div>

                        <div class="TL_treecirclecolumn TL_treecirclecolumnLightblue animated fadeInDown">
                            <div class="TL_treecirclecolumn_inner">
                                <ul class="TL_treelist">
                                    <li><span>Administrate Application</span></li>
                                    <li><span>Get Insights</span></li>
                                    <li><span>Perform Better</span></li>
                                </ul>
                                <div class="TL_treecirclebox TL_treecircleboxLightblue">
                                    <div class="TL_treecircleboxinner"><p class="tl_circletitle">Orchestrate<span>&nbsp;</span></p></div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>




                        <div class="clearfix"></div>
                    </div>
                </div>

            </section>
        
        <div class="clearfix"></div>
   
    <!--wrapper-->
    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
 <%--   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>

    <script>
        function resizeSection() {
            var tblheight = $(window).height();
            $('.content').css({ 'height': tblheight - 50, "overflow-y": "auto" });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });

    </script>

</body>

</html>