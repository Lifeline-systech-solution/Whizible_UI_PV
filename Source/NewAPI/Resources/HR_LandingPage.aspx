<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_LandingPage.aspx.vb" Inherits="PbNIT.HR_LandingPage" %>

<!DOCTYPE html>
<html>
<%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Project")%> 
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>--%>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel='stylesheet' href='../../../Whizible2.0-new/dist/css/animate.css'>--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <style type="text/css">
        /* Changed background color to white by Madhuri.K on 10-12-2025 - Override all background colors with maximum specificity */
        html, body, body.hold-transition { background: #ffffff !important; background-color: #ffffff !important; }
        .wrapper, body .wrapper { background: #ffffff !important; background-color: #ffffff !important; }
        .skin-blue-light .wrapper, body.skin-blue-light .wrapper, body.skin-blue-light.sidebar-mini .wrapper { background: #ffffff !important; background-color: #ffffff !important; }
        .skin-blue-light .main-sidebar, body.skin-blue-light .main-sidebar { background: #ffffff !important; background-color: #ffffff !important; }
        .skin-blue-light .left-side, body.skin-blue-light .left-side { background: #ffffff !important; background-color: #ffffff !important; }
        .content-wrapper, body .content-wrapper { background: #ffffff !important; background-color: #ffffff !important; height: 100%; min-height: 100vh; }
        .skin-blue-light .content-wrapper, body.skin-blue-light .content-wrapper { background: #ffffff !important; background-color: #ffffff !important; }
        .right-side, body .right-side { background: #ffffff !important; background-color: #ffffff !important; }
        .skin-blue-light .right-side, body.skin-blue-light .right-side { background: #ffffff !important; background-color: #ffffff !important; }
        .TLmain.content, body .TLmain.content { background: #ffffff !important; background-color: #ffffff !important; }
        .landingpg_wrapper, body .landingpg_wrapper { background: #ffffff !important; background-color: #ffffff !important; }
        /* Override any other potential background selectors */
        .skin-blue-light body, body.skin-blue-light { background: #ffffff !important; background-color: #ffffff !important; }
        .hold-transition, body.hold-transition { background: #ffffff !important; background-color: #ffffff !important; }
        .dashmain, body.dashmain { background: #ffffff !important; background-color: #ffffff !important; }
        body.skin-blue-light.sidebar-mini.dashmain.fixed .wrapper { background: #ffffff !important; background-color: #ffffff !important; }
.dashmain .TLmain.content{padding:20px}
.TL_treecirclecolumn{margin:5.5em -15px 0;display:inline-block;vertical-align:top;width:20%}
.TL_treecirclecolumn.first{margin-left:-30px}
.TL_treecirclecolumn.last{margin-right:20px}
.tl_wrap{text-align:center; max-width:1130px; margin:0 auto;}
.TL_treelist{min-height:150px;right:-28px;margin-left:10px;margin-bottom:-55px;padding-bottom:70px;position:relative;padding-left:40px;transition:all .6s ease-in}
/* Modified By Madhuri.K On 26-03-2026 */
ul.TL_treelist::before{content:"";position:absolute;left:0;height:100%;width:2px;background:#ec2029;transition:all .5s ease-in-out;top:9px}
.TL_treecirclecolumnBrown ul.TL_treelist::before{background:#ca6d20}
.TL_treecirclecolumnLightyellow ul.TL_treelist::before{background:#cebb0f}
.TL_treecirclecolumnGreen ul.TL_treelist::before{background:#6bcb21}
.TL_treecirclecolumnLightblue ul.TL_treelist::before{background:#21ecd9}
.TL_treecirclecolumnDarkblue ul.TL_treelist::before{background:#2062ec}
.TL_treelist li{position:relative;margin:0 0 6px;line-height:normal;min-width:166px;white-space:nowrap}
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
.TL_treecirclecolumn.Tl_treecolumOdd{margin-top:13.5em;}
.Tl_treecolumOdd .TL_treelist{transform:scale(-1)}
.Tl_treecolumOdd .TL_treelist li{transform:scale(-1)}
.Tl_treecolumOdd .TL_treelist li::before{right:-16px;left:auto}
.Tl_treecolumOdd .TL_treelist li::after{right:-40px;left:auto}
.Tl_treecolumOdd .TL_treelist{margin-left:0;margin-right:-10px;right:auto;left:-38px;bottom:55px}
.TL_treecirclecolumn.TL_treecirclecolumnBrown.Tl_treecolumOdd{margin-top:13.4em}
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
/* Modified By Madhuri.K On 26-03-2026 */
.Tl_treecolumOdd ul.TL_treelist::before{ top:9px;}

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
    

    <div class="wrapper">

        <div class="">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
            <!-- Commented graybg class by Madhuri.K on 10-12-2025 -->
            <section class="content TLmain ">

               <div class="landingpg_wrapper">
                 <%--<a href="#" class="closeLPbtn" onclick="ClosePage()"><img data-toggle="tooltip" data-placement="left" data-container="body" title="Click here hide view" src="../../../Whizible2.0-new/dist/img/close.svg" width="16px" style="width: 26px;"></a>--%>

                 <div class="tl_wrap">
                     <div class="TL_treecirclecolumn first animated fadeInDown">
                         <div class="TL_treecirclecolumn_inner">
                             <ul class="TL_treelist" style="right:-34px;">
                                 <li><span>Maintain Resource<br />Skill and Experience</span></li>
                                 <li><span>Keep Skill Inventory<br />Current</span></li>
                                 <li><span>Synch with Live Project<br />Deployment</span></li>

                             </ul>
                             <div class="TL_treecirclebox TL_treecircleboxRed">
                                 <div class="TL_treecircleboxinner"><p class="tl_circletitle">Maintain<span>&nbsp;</span></p></div>
                             </div>
                             <div class="clearfix"></div>
                         </div>
                   </div>


                     <div class="TL_treecirclecolumn TL_treecirclecolumnBrown Tl_treecolumOdd animated fadeInUp">
                         <div class="TL_treecirclecolumn_inner">
                             <div class="TL_treecirclebox TL_treecircleboxBrown">
                                 <div class="TL_treecircleboxinner"><p class="tl_circletitle">Pool</p></div>
                             </div>
                             <ul class="TL_treelist" style="left:-53px;">
                                 <li><span>Create Resource Pools<br />by Skill / Location</span></li>
                                 <li><span>Identify Joining / Exiting<br />Resource Pools</span></li>
                                 <li><span>Allow Soft Booking for<br />Future Projects</span></li>
                             </ul>


                             <div class="clearfix"></div>

                         </div>
                         </div>



                             <div class="TL_treecirclecolumn TL_treecirclecolumnLightyellow animated fadeInDown">
                                 <div class="TL_treecirclecolumn_inner">
                                     <ul class="TL_treelist" style="right:-32px;">
                                        
                                         <li><span>Apply Approval Workflow for<br />Allocation to Project</span></li>
                                         <li><span>Identify RMs to control<br />allocation and utilization</span></li>
                                         <li><span>Ensure Availability and<br />Never Lose Opportunity</span></li>
                                     </ul>
                                     <div class="TL_treecirclebox TL_treecircleboxLightyellow">
                                         <div class="TL_treecircleboxinner"><p class="tl_circletitle">Allocate<span>&nbsp;</span></p></div>
                                     </div>
                                     <div class="clearfix"></div>
                                 </div>
                                 </div>

                             <div class="TL_treecirclecolumn TL_treecirclecolumnGreen Tl_treecolumOdd animated fadeInUp">
                                 <div class="TL_treecirclecolumn_inner">
                                     <div class="TL_treecirclebox TL_treecircleboxGreen">
                                         <div class="TL_treecircleboxinner"><p class="tl_circletitle">Release<span>&nbsp;</span></p></div>
                                     </div>
                                     <ul class="TL_treelist" style="left:-53px">
                                         <li><span>Manage Resource <br />Release or Exit</span></li>
                                         <li><span>Reallocate Tasks, <br />Transfer Responsibility</span></li>
                                         <li><span>Achieve Optimal <br />Deployment</span></li>
                                     </ul>
                                     <div class="clearfix"></div>
                                 </div>
                                 </div>

                             <div class="TL_treecirclecolumn TL_treecirclecolumnLightyellow last animated fadeInDown">
                                 <div class="TL_treecirclecolumn_inner">
                                     <ul class="TL_treelist" style="right:-34px;">
                                         <li><span>Improve Resource Utilization <br/>and Billability</span></li>
                                         <li><span>Minimize Bench and <br />Maximize Profits</span></li>
                                         <li><span>Make the Optimal Hiring <br />Decisions</span></li>
                                     </ul>
                                     <div class="TL_treecirclebox TL_treecircleboxLightyellow">
                                         <div class="TL_treecircleboxinner"><p class="tl_circletitle">Gain<span>&nbsp;</span></p></div>
                                     </div>
                                     <div class="clearfix"></div>
                                 </div>
                                 </div>




                                 <div class="clearfix"></div>
                             </div>
               </div>

            </section>
        </div>
        <div class="clearfix"></div>
    </div>
    <!--wrapper-->

    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->
 <%--   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>


    <script>

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        function ClosePage() {            
            var EmployeeID = '<%= Session("intUserID") %>';
            var TagID = '<%= Request.QueryString("TagID")%>';
            var ChildTagID = '<%= Request.QueryString("ChildTagID")%>';
           var taskParameters ={
               EmployeeID : EmployeeID,
               TagID :TagID
            }
            $.ajax({
                url: strUrl + '/api/Navigation/PostLandingPageInformation',
                type: "POST",
                data: JSON.stringify(taskParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }

                },
                success: function (data) {
                  
                   // parent.location.reload();
                    window.open("../../General/Navigation.aspx?FromWhere=RM&FromOld=428", "_top");                  
                    
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })
        }

    </script>
    
    
</body>

</html>
