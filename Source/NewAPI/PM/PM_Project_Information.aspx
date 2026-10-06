<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Project_Information.aspx.vb" Inherits="PbNIT.PM_Project_Information" %>

<!DOCTYPE html>

<html>
        <!-- Commented by Madhuri.K On 09-08-2024 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
    <title></title>
  
</head>
      <style type="text/css">
        div#NoProjectDivID {
            width: 60%;
            margin: 100px auto;
            text-align: center;
            background-color: #fff;
            padding: 84px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px 0px #ddd;
        }

        #NoProjectDivID i {
            font-size: 30px;
            vertical-align: middle;
            margin-right: 10px;
            color: #ed1c24;
        }

        /*added by pradip on 09-04-2020*/
        body{ background:#fff;}
        /*Added By Dipali V On 16th May 2020 For Loader Issues*/
        .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
            /* border: 3px solid #ababab; */
            /* box-shadow: 1px 1px 10px #ababab; */
            border-radius: 15px;
            background: #ddd;
            /* background-color: white; */
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            /* background: url(../../../Whizible2.0-new/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat; */
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }


        .clsShowHide {
            display: none !important;
        }



    </style>
<body id="bodyprojectinformation">
    <div id="divProjectinfo" class="preloader">
         <div class="clsShowHide" id="maindiv">
    <form id="form1" runat="server">
        <div>
            <div id="NoProjectDivID" hidden="hidden">
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>Session Project is applicable for Project Information, Please select the project from Project listing page.</h4>
        <%-- <div class="ProjectList"><a onclick="List_onclick()">List Of Projects</a></div>--%>
    </div>
        </div>
    </form>
        </div>
        </div>

    
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
        <!-- jqueryUI js -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
  
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>

        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
      
     <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
      <script src="../../General/CommonFunctions.js"></script>--%>
  
    <script>
        $(document).ready(function () {
             $("#divProjectinfo").removeClass("center");
             $("#divProjectinfo").removeClass("preloader");
            
             //StartLoader("#bodyprojectinformation");
            var ProjectID = '<%= Session("intProjectID") %>';
            var WhichAction = 'C';
            if (ProjectID == 0) {
                $("#maindiv").removeClass('clsShowHide');
               // StopAjaxLoader("#bodyprojectinformation");
                $("#NoProjectDivID").show();
                //StopAjaxLoader("#bodyprojectinformation");
            }
            else {
                StartLoader("#bodyprojectinformation");
               // debugger;
                var cur_PKToken = GenerateToken(ProjectID);
                $("#maindiv").removeClass('clsShowHide');
                //Added By Dipali V On 1st Feb 2021 For Session Project Issues
                var ProjectName = '<%= Session("strProjectName") %>';
                if (ProjectName != "") {
                     //commneted by Aditya J. on 18-05-2026 for Session Project dropdown in W27
                    //var HeaderCaption = $(parent.document.getElementById('mainHeadingProject'));
                    //HeaderCaption.text("");
                    // //HeaderCaption.text("Project : " + ProjectName);
                    //HeaderCaption.append(" Project : " + ProjectName);
                    //HeaderCaption.append(' <i class="fa fa-key" onclick="SetDefaultProject()" title="Set as default project" style="cursor:pointer;"></i>');
                    //End of commneted by Aditya J. on 18-05-2026 for Session Project dropdown in W27
    
                }
                 //End of Added By Dipali V On 1st Feb 2021 For Session Project Issues
                         
                         
                window.location.href = "PM_CreateProject.aspx?FromWhereProjectId=" + ProjectID + "&FromWhereData=" + WhichAction + "&PKToken=" + cur_PKToken + "&Mode=Edit";
                StopAjaxLoader("#bodyprojectinformation");
            }

            function GenerateToken(ProjectID) {
                var SelectedProjectID = ProjectID;
                var strSessionResult = ajaxCall("PM_ProjectList.aspx/GeneratePK_Token", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: SelectedProjectID }));
                if (strSessionResult != undefined) {
                    return (strSessionResult.d);
                }
                else
                    return 0;
            }


            function ajaxCall(url, type, contentType, dataType, data) {
                var ajaxResult;

                $.ajax({
                    url: url,
                    type: "POST",
                    data: data,
                    async: false,
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {

                        ajaxResult = data;
                    },
                    error: function (err) {

                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                });

                return ajaxResult;
            }
        });




        function StartLoader(bodyID) {

            $(bodyID).append("<div id='preloader'></div>");
            $(bodyID).append("<div id='fillDiv'></div>");
        }
    </script>
</body>
</html>
