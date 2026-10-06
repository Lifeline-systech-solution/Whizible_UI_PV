<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectLandingPage.aspx.vb" Inherits="PbNIT.PM_ProjectLandingPage" %>
<!DOCTYPE html>
<html>
  <!-- Commented by Madhuri.K for JQuery and Bootstrap version upgrade -->
   <%CommonFunctions.General.PlotPageHeadTag("Project")%>
<head>


    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">    
       <link href='../../../Whizible2.0-new/dist/css/animate.css' rel='stylesheet'>--%>

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
</head>

    <style type="text/css">
        /* Changed background color to white by Madhuri.K on 10-12-2025 */
               body{background: #ffffff;}
/* Changed background color to white by Madhuri.K on 10-12-2025 */
.content-wrapper,.right-side{background:#fff}
/* Changed background color to white by Madhuri.K on 10-12-2025 */
.content-wrapper{height:100%;min-height:100vh}
.dashmain .TLmain.content{padding:20px; height:98vh;}
.TL_treecirclecolumn{margin:10em -15px 0;display:inline-block;vertical-align:top}
.TL_treecirclecolumn.first{margin-left:-30px}
.TL_treecirclecolumn.last{margin-right:20px}
.tl_wrap{text-align:center}
.TL_treelist{min-height:150px;right:-28px;margin-left:10px;margin-bottom:-55px;padding-bottom:80px;position:relative;padding-left:40px;transition:all .6s ease-in}
/* Modified By Madhuri.K On 26-03-2026 */
ul.TL_treelist::before{content:"";position:absolute;left:0;height:100%;width:2px;background:#ec2029;transition:all .5s ease-in-out;top:9px}
.TL_treecirclecolumnBrown ul.TL_treelist::before{background:#ca6d20}
.TL_treecirclecolumnLightyellow ul.TL_treelist::before{background:#cebb0f}
.TL_treecirclecolumnGreen ul.TL_treelist::before{background:#6bcb21}
.TL_treecirclecolumnLightblue ul.TL_treelist::before{background:#21ecd9}
.TL_treecirclecolumnDarkblue ul.TL_treelist::before{background:#2062ec}
.TL_treelist li{position:relative;margin:0 0 12px;line-height:normal;min-width: 166px;}
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
.TL_treecirclecolumn.Tl_treecolumOdd{margin-top:19.7em}
.Tl_treecolumOdd .TL_treelist{transform:scale(-1)}
.Tl_treecolumOdd .TL_treelist li{transform:scale(-1)}
.Tl_treecolumOdd .TL_treelist li::before{right:-16px;left:auto}
.Tl_treecolumOdd .TL_treelist li::after{right:-40px;left:auto}
.Tl_treecolumOdd .TL_treelist{margin-left:0;margin-right:-10px;right:auto;left:-38px;bottom:55px}
.TL_treecirclecolumn.TL_treecirclecolumnBrown.Tl_treecolumOdd{margin-top:19.7em}
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

a.closeLPbtn {position: absolute;right: 30px;background: none;border: none;outline: none; opacity: 0.6;}
a.closeLPbtn:hover{ opacity:1; }

@media screen and (max-width: 767x){

.content-wrapper, .right-side, .main-footer{ margin-left: 0!important; }
.fixed .content-wrapper, .fixed .right-side{ padding-top: 0!important; }

}

@media only screen and (max-device-height: 780px) {
.TL_treecirclecolumn{ margin-top: 0px; }
.TL_treecirclecolumn.TL_treecirclecolumnBrown.Tl_treecolumOdd {margin-top:160px;}
.TL_treecirclecolumn.Tl_treecolumOdd { margin-top: 160px;}

}


/*need to remove below css property after implementing code in frame*/
.content-wrapper, .right-side, .main-footer{ margin-left:0;}
.fixed .content-wrapper, .fixed .right-side{ padding-top:0;}

    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    

    <div class="wrapper">
     
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
            <!-- Commented graybg class by Madhuri.K on 10-12-2025 -->
            <section class="content TLmain ">

               <div class="landingpg_wrapper">
                 <a href="#" class="closeLPbtn" onclick="ClosePage()" hidden><img data-bs-toggle="tooltip" data-bs-placement="left" data-bs-container="body" title="Click here hide view" src="../../../Whizible2.0-new/../../../Whizible2.0-new/dist/img/close.svg" width="16px" style="width: 26px;"></a>

                   <div class="tl_wrap">                   
                       <div class="TL_treecirclecolumn first animated fadeInDown">
                         <ul class="TL_treelist">
                        <li><span>Create Project<br/>Information</span></li>
                        <li><span>Detail Budgets<br/>from all source</span></li>
                        <li><span>Seek Approvals<br/>&nbsp;</span></li>
                        </ul>

                           <div class="TL_treecirclebox TL_treecircleboxRed">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Initiate<span>&nbsp;</span></p></div>
                           </div>
                           <div class="clearfix"></div>
                       </div>


                       <div class="TL_treecirclecolumn TL_treecirclecolumnBrown Tl_treecolumOdd animated fadeInUp">                        
                           <div class="TL_treecirclebox TL_treecircleboxBrown">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Plan</p></div>
                           </div>
                           <ul class="TL_treelist">
                        <li><span>Manage Project<br/>Team</span></li>
                        <li><span>Create <br/>WBS</span></li>
                        <li><span>Plan Execution<br/> Method</span></li>
                        </ul>
                           <div class="clearfix"></div>
                       </div>



                         <div class="TL_treecirclecolumn TL_treecirclecolumnLightyellow animated fadeInDown">
                         <ul class="TL_treelist">
                        <li><span>Intigrate/Upload<br/>Detailed Plan</span></li>
                        <li><span>Assign Task and<br/>update completion</span></li>
                        <li><span>Close <br/>Milestone</span></li>
                        </ul>

                           <div class="TL_treecirclebox TL_treecircleboxLightyellow">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Execute<span>&nbsp;</span></p></div>
                           </div>
                           <div class="clearfix"></div>
                       </div>

                       <div class="TL_treecirclecolumn TL_treecirclecolumnGreen Tl_treecolumOdd animated fadeInUp">
                         <div class="TL_treecirclebox TL_treecircleboxGreen">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Monitor<span>&nbsp;</span></p></div>
                           </div>
                           <ul class="TL_treelist">
                        <li><span>Manage <br/>Risk</li>
                        <li><span>Derive Project <br/>health</span></li>
                        <li><span>Request for <br/>Invoice</span></li>
                        </ul>
                           <div class="clearfix"></div>
                       </div>

                       <div class="TL_treecirclecolumn TL_treecirclecolumnLightblue last animated fadeInDown">
                          <ul class="TL_treelist">
                        <li><span>Update Resource <br/>Skills</span></li>
                        <li><span>Release <br/>Resources</span></li>
                        <li><span>Publish Lessons <br/>Learnt</span></li>
                        </ul>
                           <div class="TL_treecirclebox TL_treecircleboxLightblue">
                            <div class="TL_treecircleboxinner"><p class="tl_circletitle">Close<span>&nbsp;</span></p></div>
                           </div>
                          
                           <div class="clearfix"></div>
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
   
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>

    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>

    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../General/CommonValidations.js?v=1"></script>--%>
    
     <script>

         var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
          var EmployeeID = '<%= Session("intUserID") %>';
          var TagID = '<%= Request.QueryString("TagID")%>';
         var ChildTagID = '<%= Request.QueryString("ChildTagID")%>';
          ////Commemted & Added By Dipali V On 18th June 2020 For Take Tagid as default
          //  if (TagID == "") {
          //      TagID = 32;
          //  }
          //  //alert(TagID);
          //  //End of Commemted & Added By Dipali V On 18th June 2020 For  Take Tagid as default
         if (TagID != "") {
            $(".closeLPbtn").show();
        }
        function ClosePage() {            
           
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (taskParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                    }
                },
                success: function (data) {
                  
                    if (TagID == 32)
                    {
                    //parent.reload();
                    //$(parent.location.href = parent.location.href);
                        window.location.href = "PM_ProjectList.aspx";
                    //window.open("../../General/Navigation.aspx?FromWhere=PM&FromOld=32", "_top");
                    }
                    
                    
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

     </script>
    
</body>

</html>
