<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ConfiguringTimesheetBlocking.aspx.vb" Inherits="PbNIT.PM_ConfiguringTimesheetBlocking" %>

<!DOCTYPE html>
<html>
        <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Project")%> 

<head>
  <%--  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to</style> be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizibreloadle2.0/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
   
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">
    --%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css" />
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">

    <%--alertify Css--%>
<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>


</head>
    <style>
                   /*CSS Added command commented ruby Madhuri.K content 02-Sep-2024 for adject space between pagination command count*/
     div.dataTables_wrapper div.dataTables_info {
    padding-top: 1px;
}

.dataTables_info {
    padding-top: 1px;
}
.dataTables_info {
    margin-top: 10px;
    float: left;
}
/*CSS Added command commented ruby Madhuri.K content 02-Sep-2024 for adject space between pagination command count*/
        
        div#NoProjectDivID {
            width: 60%;
            margin: 100px auto;
            text-align: center;
            background-color: #fff;
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px 0px #ddd;
        }

        #NoProjectDivID i {
            font-size: 30px;
            vertical-align: middle;
            margin-right: 10px;
            color: #ed1c24;
        }
           .custom_chckbox input[type=checkbox][disabled] + label:before {
             margin-right: 15px; 
             CURSOR: NOT-ALLOWED; 
        }
        .pl-20 {padding-left:20px;}
        body {background-color:#fff;}
        #pstbl_confureTimesheetTbl_wrapper {width:97% !important;margin:10px auto;}
        /*Added by pradip on 04-12-2019*/
        #addProjectSla .col-sm-6 {margin: 0 0 10px;}
        /*Added by Chetan M on 21th Dec 2019*/
        #pstbl_confureTimesheetTbl th {
            min-width: 220px;
        }
        /*End of addition by Chetan M on 21th Dec 2019*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="Main_confureTimesheet">
    <% If m_blnCTBViewAccess = True Then %>
    <!--ps_list_table_start-->
    <div class="tab-pane pstbl_confureTimesheet pt-0 practicesettinglist in active" id="pstbl_confureTimesheet" style="border-top: 1px solid #ddd;">
      
        <div class="modalpgHead pt-1 pb-1 col-sm-12 mb-10">
            <span>&nbsp;&nbsp;<%= MyBase.GetResourceString("C_ConfiguringTimesheetBlocking") %></span>
        </div>

        <h5 class="float-start pl-20 pt-2 px-3 clearfix">Project Name : <span id="spanProjectName"></span></h5>  
        <div class="right-side-save">
            <%--<a href="javascript:;" class="btn borderbtn mr-5" id="" data-bs-toggle="modal" data-bs-target="#addTimesheet"><i class="fa fa-plus" aria-hidden="true"></i>Add</a>--%>
            <% If m_blnCTBEditAccess = True Then %>
            <a href="#" class="btn btnyellow" onclick="UpdateIsBackDatingAndIsForwardDating();"><%= MyBase.GetResourceString("C_Save") %></a>
            <% End If %>
        </div>
        <table class="table table-stripped table-bordered tbl-keywords" id="pstbl_confureTimesheetTbl">
            <thead>
                <tr>
                    <th><%= MyBase.GetResourceString("C_ProjectCode") %></th>
                    <th><%= MyBase.GetResourceString("C_ProjectName") %></th>
                    <th class="nosort"><%= MyBase.GetResourceString("C_Backdated") %></th>
                    <th class="nosort"><%= MyBase.GetResourceString("C_Forwarddated") %></th>
                </tr>
            </thead>
            <tbody id="pstbl_confureTimesheetTblBody">
            </tbody>
        </table>
        <div class="root-add-btn">
            <!--<a href="javascript:;" class="btn borderbtn" id="" data-bs-toggle="modal" data-bs-target="#addTimesheet"><i class="fa fa-plus" aria-hidden="true"></i> Add</a>
                    <button id="delete-row" class="btn borderbtn">Delete</button>-->
        </div>
    </div>
    <!--ps_list_table_end-->

    <% Else %>
    <div id="NotAuthorized">
        <h4>You are not authorized to view this record. </h4>
    </div>
    <% End If %>

    <div id="NoProjectDivID" hidden="hidden">
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>You have not selected any project, please select the project.</h4>
    </div>
    <!--Add new site modal end here-->

    <!--Add new project os start here-->
    <div class="modal custmodal fade" id="addTimesheet" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Configuring Timesheet Blocking</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group mb-3">
                        <div class="row">
                            <div class="form-group col-sm-6">
                                <label class="control-label">Project Code</label>
                                <input type="text" name="" class="text-field">
                            </div>
                            <div class="col-sm-6">
                                <label>Project Name</label>
                                <input type="text" name="" class="text-field">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-12 btns-center">
                                    <button data-bs-dismiss="modal" class="btn borderbtn">Close</button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow float-end ml-1">Save</button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Add new project os end here-->


    <!--Add_new_Sub_tasktype_modal_Start_here-->
    <div class="modal custmodal fade" id="CPaddSubtaskModal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Add New Sub Task</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <label class="control-label col-sm-4">Sub Task Type</label>
                            <div class="col-sm-8">
                                <select class="form-select selectpicker">
                                    <option>Risk Analysis</option>
                                    <option>Requirement Analysis</option>
                                    <option>Feasibility Study</option>
                                    <option>Documentation</option>
                                    <option>Defect Analysis</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <label class="control-label col-sm-4">&nbsp;</label>
                            <div class="col-sm-8">
                                <button data-bs-dismiss="modal" class="btn borderbtn">Close</button>
                                <button data-bs-dismiss="modal" class="btn btnyellow float-end ml-1">Save</button>
                                <button data-bs-dismiss="modal" class="btn btnyellow float-end">Save and Add</button>

                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!--Add_new_Sub_tasktype_modal_end_here-->

    <!--Delete_new_Sub_tasktype_modal_Start_here-->
    <div class="modal custmodal fade" id="CPdelSubtaskModal" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Delete Sub Task</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <h5>
                            <center>Are you sure you want to delete these records?</center>
                        </h5>
                    </div>
                    <br />
                    <center>
                                    <button data-bs-dismiss="modal" class="btn borderbtn">No</button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow ml-1">Yes</button>
                                </center>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!--Delete_new_Sub_tasktype_modal_end_here-->

    <!-- REQUIRED JS SCRIPTS -->

  
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- jqueryUI js -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
 --%>  <%-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%> 
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <!-- alertify -->
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

<%--    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>



    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        //var ProjectID = '<%= ProjectID %>';
        var ajaxResult = "";
        var UserID = '<%= Session("intUserID") %>';
        var ProjectID;

        $(document).ready(function () {

            params = getParams();
            ProjectID = unescape(params["ProjectID"]);
            GetProjectName(ProjectID);

            if (ProjectID != 0) {
                GetConfigTimeBlockingList();
            }
            else {
                StartLoader("#Main_confureTimesheet");
                $("#NoProjectDivID").show();
                $("#pstbl_confureTimesheet").hide();
                StopAjaxLoader("#Main_confureTimesheet");
            }
        });        
        var cntTimesheetBlockRec = 0;
        function GetConfigTimeBlockingList() {
            cntTimesheetBlockRec = 0;
            StartLoader("#Main_confureTimesheet");

            var ConfigureTimePrameters = {
                BackDatingEmployeeID: encodeURI(UserID)

            }
            var paramater = JSON.stringify(ConfigureTimePrameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetConfigTimeBlockingList", paramater, false);
            $("#pstbl_confureTimesheetTbl").dataTable().fnDestroy();
            $("#pstbl_confureTimesheetTblBody").html('');
            var strHTML = "";
            
            cntTimesheetBlockRec = strResult.length;
            for (var i = 0; i < strResult.length; i++) {

                var ProjectID = strResult[i]["ProjectID"]
                var ProjectCode = strResult[i]["ProjectCode"];
                var ProjectName = strResult[i]["ProjectName"];
                var IsBackDating = strResult[i]["IsBackDating"];
                var IsForwardDating = strResult[i]["IsForwardDating"];

                strHTML += ' <tr>'
                strHTML += '<td>' + ProjectCode + '</td>'
                strHTML += '<td>' + ProjectName + '</td>'
                strHTML += ' <td>'
                strHTML += ' <div class="custom_chckbox">'
                if (IsBackDating == 1) {
                    strHTML += '<input id = "backDate' + ProjectID + '" class="chckHead" type = "checkbox" checked>'
                }
                else {
                    strHTML += '<input id = "backDate' + ProjectID + '" class="chckHead" type = "checkbox">'
                }

                strHTML += ' <label for="backDate' + ProjectID + '"></label>'
                strHTML += ' </div>'
                strHTML += ' </td>'
                strHTML += ' <td>'
                strHTML += '<div class="custom_chckbox">'
                if (IsForwardDating == 1) {
                    strHTML += ' <input id="forwardDate' + ProjectID + '" class="chckHead" type="checkbox" checked>'
                } else {
                    strHTML += ' <input id="forwardDate' + ProjectID + '" class="chckHead" type="checkbox">'
                }
                strHTML += '<label for="forwardDate' + ProjectID + '"></label>'
                strHTML += ' </div>'
                strHTML += ' </td>'
                strHTML += ' </tr>'

            }

            $("#pstbl_confureTimesheetTblBody").html("")
            $("#pstbl_confureTimesheetTblBody").html(strHTML);

            StopAjaxLoader("#Main_confureTimesheet");

            $("#pstbl_confureTimesheetTbl").DataTable({
                
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "retrieve": true,
                "ordering": true,
                "columnDefs": [{                    
                    /* column index */
                    'orderable': false,
                    "orderDataType": "dom-checkbox"/* true or false */
                }],
               
            });

            if (strHTML == "") {
                $("#pstbl_confureTimesheetTbl tbody tr td").prop("colspan", 4);
                $("#pstbl_confureTimesheetTbl tbody tr td").css("cssText", "text-align:center!important");
            }


        }
        function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
        function refreshMyParent() {
            try {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ConfiguringTimesheetBlocking%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");

                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ConfiguringTimesheetBlocking%>');
                newpath = newpath.toString().replace("FromWhereProjectId=" + currentFromWhereProjectId, "FromWhereProjectId=" + '<%= Request.QueryString("ProjectID") %>');
                newpath = newpath.toString().replace("FromWhereData=D", "FromWhereData=C");
                if (newpath.indexOf("Add#") != -1) {
                    newpath = newpath.toString().replace("Add#", "Edit&update=done");
                }
                else if (newpath.indexOf("Edit#") != -1) {
                    newpath = newpath.toString().replace("Edit#", "Edit&update=done");
                }
                else if (newpath.indexOf("Edit") != -1) {
                    newpath = newpath.toString().replace("Edit", "Edit&update=done");
                }
                opener.window.location.replace(newpath);
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        function UpdateIsBackDatingAndIsForwardDating() {
            try {
                var ProjectID = "";

                //Loop through all checked CheckBoxes in GridView.
                var selectedID = [];
                $('#pstbl_confureTimesheetTbl input[type="checkbox"]:checked').each(function () {
                    selectedID.push($(this).attr('id'));
                });

                var ForwardDateProjectID = "";
                var BackDateProjectID = "";

                for (var i = 0; i < selectedID.length; i++) {
                    if (selectedID[i].indexOf("forwardDate") > -1) {
                        ForwardDateProjectID += selectedID[i].replace("forwardDate", "") + ",";

                    }
                    else {
                        BackDateProjectID += selectedID[i].replace("backDate", "") + ",";

                    }

                }
                ForwardDateProjectID = ForwardDateProjectID.replace(/,\s*$/, "");
                BackDateProjectID = BackDateProjectID.replace(/,\s*$/, "");

                var IsBackDating = "";
                var IsForwardDating = "";
                if (BackDateProjectID == '') {
                    IsBackDating = 0;
                }
                else {
                    IsBackDating = 1;
                }
                if (ForwardDateProjectID == '') {
                    IsForwardDating = 0;
                }
                else {
                    IsForwardDating = 1;
                }
                var ConfigureTimePrameters = {
                    BackDatingEmployeeID: encodeURI(UserID),
                    ForwardDateProjectID: encodeURI(ForwardDateProjectID),
                    BackDateProjectID: encodeURI(BackDateProjectID),
                    IsForwardDating: encodeURI(IsForwardDating),
                    IsBackDating: encodeURI(IsBackDating)
                }
                var paramater = JSON.stringify(ConfigureTimePrameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/UpdateIsBackDatingAndIsForwardDating", paramater, false);
                if (cntTimesheetBlockRec != 0) {
                    alertify.success(strResult);
                }
                GetConfigTimeBlockingList();

                refreshMyParent();
                //opener.window.location.href += "&update=done";
                //opener.window.location.reload();
                //self.close();
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        //Added By Reshma On 29Nov 2019
         function getParams() {
            var params = {},
                pairs = document.URL.split('?')
                    .pop()
                    .split('&');
            for (var i = 0, p; i < pairs.length; i++) {
                p = pairs[i].split('=');
                params[p[0]] = p[1];
            }
            return params;
        }


        function GetProjectName(ProjectID) {
        
            var Parameter = { ProjectID: ProjectID }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectName',
                method: 'Post',
                data: JSON.stringify(Parameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                    }
                },
                success: function (result) {                   
                    $("#spanProjectName").text(result);                   
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }
        //End Added By Reshma On 29Nov 2019
        //AjaxCall Function
        function AJAXCallWithResult(url, param, async) {

            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {

                    //StopAjaxLoader("#WBSBody");
                    ajaxResult = data;
                },
                error: function (err) {
                    //StopAjaxLoader("#WBSBody");
                    console.log(err);
                    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }

        //dynamically set height
            function resizeSection(tag) {
                var divhieght2 = $(window).height();
                $('.Tabdetailpage-content').css({ 'height': divhieght2 - 140, "overflow-y": "auto" });
            }

            $(window).on("load resize scroll click", function (e) {
                resizeSection(this);
            });


    </script>

</body>

</html>
