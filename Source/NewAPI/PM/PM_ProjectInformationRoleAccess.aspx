<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectInformationRoleAccess.aspx.vb" Inherits="PbNIT.PM_ProjectInformationRoleAccess" %>

<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">--%>
  
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

</head>
    
    <style>
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

        body {background-color:#fff;}
        .proj-info-role-inner .note-wrap {width:97%;}
        .pl-20 {padding-left:20px;}
        #ProInfoRoleAcessTbl_wrapper {width:97% !important;margin:15px auto 40px;}
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="main_ProInfoRoleAcess">

    <% If m_blnPIRAViewAccess = True Then %>

    <div class="tab-pane pstbl_projInfoRole practicesettinglist in active" id="pstbl_ProInfoRoleAcess" style="border-top: 1px solid #ddd;">
        <div class="modalpgHead pt-1 pb-1 col-sm-12 mb-10">
            <span>&nbsp;&nbsp;<%= MyBase.GetResourceString("C_ProjectInformationRoleAccess") %></span>
        </div>
        <h5 class="float-start pl-20 pt-3 clearfix">Project Name : <span id="spanProjectName"></span></h5>  
        
        <div class="proj-info-role-inner">
            <div class="note-wrap">
                <p><strong><%= MyBase.GetResourceString("C_Note") %></strong> <%= MyBase.GetResourceString("C_RoleNote") %></p>
            </div>
           <% If m_blnPIRAEditAccess = True Then %>
                <div class="right-side-save">
                    <a href="#" class="btn btnyellow" onclick="UpdateProjectInfoRoleAccess();"><%= MyBase.GetResourceString("C_Save") %></a>
                </div>
          <% End If %>
            <table class="table table-stripped table-bordered tbl-role-access" id="ProInfoRoleAcessTbl">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("C_Role") %></th>
                        <th class="text-center multi-selectbox">
                            <div class="form-check">
                                <div class="custom_chckbox">
                                    <input id="ProjInfoRoleAll" class="chcktbl" type="checkbox">
                                    <label for="ProjInfoRoleAll"></label>
                                </div>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="ProInfoRoleAcessTblBody">
                </tbody>
            </table>
        </div>
    </div>

    <% Else %>
    <div id="NotAuthorized">
        <h4>You are not authorized to view this record. </h4>
    </div>
    <% End If %>

    <div id="NoProjectDivID" hidden="hidden">
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>You have not selected any project, please select the project.</h4>
    </div>

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
                            <center>Are you sure, you want to delete the selected records?</center>
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
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>      
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>    
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

    <!-- custome js -->
    <%--<script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?v=1"></script>--%>

    <script>
        //$('.editor1').wysihtml5();
        //change date format
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };

        //datepicker

        $('#newprostartdate, #newproenddate, #RRdate').datepicker({
            autoclose: true,
            changeMonth: true,
            dateFormat: 'dd M yy'
        });

    </script>

    <script>

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        //var ProjectID = '<%= ProjectID %>';
        var ajaxResult = "";
        var UserID = '<%= Session("intUserID") %>';
        var ProjectID;        

        $(document).ready(function () {

            //this use for if checek box checked then all check box selected and all issue id stored in rows array
            $('#ProjInfoRoleAll').click(function () {

                var table = $('#ProInfoRoleAcessTbl').DataTable();
                if ($(this).prop("checked") == true) {

                    var rows = table.rows({ 'search': 'applied' }).nodes();
                    $('input[type="checkbox"]', rows).each(function () {
                        this.checked = true;
                    });

                }
                else if ($(this).prop("checked") == false) {
                    var row = table.rows({ 'search': 'applied' }).nodes();
                    $('input[type="checkbox"]', row).each(function () {
                        this.checked = false;
                    });
                }
            });


            $(document).on('change', '.role-access-chck', function () {
                var table = $("#ProInfoRoleAcessTbl").DataTable();
                var checke = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl').length;
                var checked = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length;
                if (checke == checked) {
                    $("#ProInfoRoleAcessTbl > thead> tr > th.multi-selectbox > div > div > #ProjInfoRoleAll").prop("checked", true);

                }
                else {
                    $("#ProInfoRoleAcessTbl > thead> tr > th.multi-selectbox > div > div > #ProjInfoRoleAll").prop("checked", false);

                }

            });

            params = getParams();
            ProjectID = unescape(params["ProjectID"]);

            GetProjectName(ProjectID);

            if (ProjectID != 0) {
                GetProjectInfoRoleAccessList();
            }
            else {
                StartLoader("#main_ProInfoRoleAcess");
                $("#NoProjectDivID").show();
                $("#pstbl_ProInfoRoleAcess").hide();
                StopAjaxLoader("#main_ProInfoRoleAcess");
            }
        });        
        //add by omkar 31/12/2019 for chcek main or head checkbox
        function HeadCheckboxChecked () {
             var table = $("#ProInfoRoleAcessTbl").DataTable();
                var checke = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl').length;
                var checked = table.rows().nodes().to$().find('input[type="checkbox"].chcktbl:checked').length;
                if (checke == checked) {
                    $("#ProInfoRoleAcessTbl > thead> tr > th.multi-selectbox > div > div > #ProjInfoRoleAll").prop("checked", true);

                }
                else {
                    $("#ProInfoRoleAcessTbl > thead> tr > th.multi-selectbox > div > div > #ProjInfoRoleAll").prop("checked", false);

                }
        }
        //end of add by omkar 31/12/2019 for chcek main or head checkbox


        function GetProjectInfoRoleAccessList() {

            StartLoader("#main_ProInfoRoleAcess");


            var paramater = { };
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetProInfoRoleAcessList", paramater, false);

            $("#ProInfoRoleAcessTbl").dataTable().fnDestroy();

            $("#ProInfoRoleAcessTblBody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {

                var RoleID = strResult[i]["RoleID"]
                var RoleDescription = strResult[i]["RoleDescription"];

                if (RoleID != undefined || RoleID != null || RoleID != '') {
                    var RoleExist = RoleExistOrNot(RoleID);
                }

                strHTML += ' <tr>'
                strHTML += '<td>' + RoleDescription + '</td>'
                strHTML += ' <td class="text-center inp-select">'
                strHTML += '<div class="form-check">'
                strHTML += ' <div class="custom_chckbox">'
                if (RoleExist == 1) {
                    strHTML += ' <input id="testLead' + RoleID + '" class="chcktbl role-access-chck" type="checkbox" checked  name="chckAccess">'
                }
                else {
                    strHTML += ' <input id="testLead' + RoleID + '" class="chcktbl role-access-chck" type="checkbox"  name="chckAccess">'
                }
                strHTML += '<label for="testLead' + RoleID + '"></label>'
                strHTML += ' </div>'
                strHTML += ' </div>'
                strHTML += ' </td>'
                strHTML += ' </tr>'

            }

            $("#ProInfoRoleAcessTblBody").html("")
            $("#ProInfoRoleAcessTblBody").html(strHTML);

            StopAjaxLoader("#main_ProInfoRoleAcess");

            $("#ProInfoRoleAcessTbl").DataTable({

                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "retrieve": true,
                "ordering": true,
                "columnDefs": [{
                    /* column index */
                    'targets': [1],
                    'orderable': false,
                    "orderDataType": "dom-checkbox"/* true or false */
                }],

            });

            if (strHTML == "") {
                $("#ProInfoRoleAcessTbl tbody tr td").prop("colspan", 4);
            }

            //added by omkar 31/12/2019
            HeadCheckboxChecked();
            //end of added by omkar 31/12/2019
        }

        function RoleExistOrNot(RoleID) {
            var ProInfoRoleAcessPrameters = {
                RoleID: encodeURI(RoleID),
                ProjectID: encodeURI(ProjectID)
            }
            var paramater = JSON.stringify(ProInfoRoleAcessPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/RoleExistOrNot", paramater, false);
            return strResult;
        }

        function getURLParameter(url, name) {
            return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
        }
        function refreshMyParent() {
            try {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ProjectInformationRoleAccess%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");

                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ProjectInformationRoleAccess%>');
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
        function UpdateProjectInfoRoleAccess() {
           
            var table = $('#ProInfoRoleAcessTbl').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            SelectedRoleIDs = $('input[name=chckAccess]:checked', rows).map(function () {
                return this.id;
            }).get().join(',');
            SelectedRoleIDs = SelectedRoleIDs.replace(/testLead/g, '');
            if (SelectedRoleIDs != "") {
                var ProInfoRoleAcessPrameters = {
                    RoleIDs: encodeURI(SelectedRoleIDs),
                    ProjectID: encodeURI(ProjectID)
                }
                var paramater = JSON.stringify(ProInfoRoleAcessPrameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/UpdateProInfoRoleAcess", paramater, false);

                //alertify.success(strResult);
                //Added By Dipali V On 4th May 2020 For issue id:-24071
                setTimeout(function () {
                    alertify.success(strResult);
                }, 350);
                //End of Added By Dipali V On 4th May 2020 For issue id:-24071
                GetProjectInfoRoleAccessList();
                refreshMyParent();
            }
            //Added By Reshma Chavan on 20th Dec 2021 if no record selected give alert
            else {
                alertify.error("Please Select atleast one Record");
                $("#ProjInfoRoleAll").prop('checked', false);
                return false;
            }
            //End of Added By Reshma Chavan on 20th Dec 2021 if no record selected give alert
            
        }

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




        //optional//
        function RoleselectAllOrNot() {
            RoleCheckedOrNot();
        }

        function RoleCheckedOrNot() {
            var checke = "";
            var checked = "";

            checke = $('#ProInfoRoleAcessTblBody input[type="checkbox"]').length;
            checked = $('#ProInfoRoleAcessTblBody input[type="checkbox"]:checked').length;

            if (checke == checked) {
                $("#ProInfoRoleAcessTbl > thead> tr > th.multi-selectbox > div > div > #ProjInfoRoleAll").prop("checked", true);
            }
            else {
                $("#ProInfoRoleAcessTbl > thead> tr > th.multi-selectbox> div > div > #ProjInfoRoleAll").prop("checked", false);
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
            //var ProjectID = ProjectID;
            var Parameter = { ProjectId: ProjectID }
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

    </script>

</body>

</html>
