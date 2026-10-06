<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_DocumentCategory.aspx.vb" Inherits="PbNIT.PM_DocumentCategory" %>

<!DOCTYPE html>
<html>
    <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
        <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">

    <%--alertify Css--%>
<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

 
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
       .disabled-checkbox+label {
               cursor: no-drop;
        }
       body {background-color:#fff;}
       .note-wrap-txt {width:97% !important;display:flex;}
       .pl-20 {padding-left:20px;}
        div#DocCategoryTbl_wrapper {width: 97%;margin: 0 auto 40px;}
        #DocCategoryTbl thead tr th:first-child, #DocCategoryTbl tbody tr td:first-child {text-align:left;}

table.dataTable thead>tr>th.sorting_asc:before, table.dataTable thead>tr>th.sorting_desc:after, table.dataTable thead>tr>td.sorting_asc:before, table.dataTable thead>tr>td.sorting_desc:after{ display:none;}

    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="Main_DocCategory">
    <% If m_blnDocViewAccess = True Then %>
   <div class="tab-pane pstbl_custom pt-0 practicesettinglist in active" id="pstbl_DocCategory">
       <div class="modalpgHead pt-1 pb-1 col-sm-12">
            <span><%= MyBase.GetResourceString("C_DocumentCategory") %></span>
       </div>
       <h5 class="float-start pl-20 mb-10 pt-3">Project Name : <span id="spanProjectName"></span></h5>  
       <div class="note-wrap note-wrap-txt pt-10">
            <p><strong><%= MyBase.GetResourceString("C_Note") %> </strong><%= MyBase.GetResourceString("C_NoteData") %></p>
       </div>
       <div class="right-side-save mb-15">
            <%--<a href="javascript:;" class="btn borderbtn mr-5">Delete</a>--%>
            <% If m_blnDocEditAccess = True Then %>
            <a href="javascript:;" class="btn btnyellow" onclick=" UpdateDocCategory();"><%= MyBase.GetResourceString("C_Save") %></a>
            <% End If %>
       </div>
        <table class="table table-stripped table-bordered" id="DocCategoryTbl" style="width:100%;">
            <thead>
                <tr>
                    <th class="nosort"><%= MyBase.GetResourceString("C_DocumentCategory") %></th>
                    <th class="inp-select">
                        <div class="custom_chckbox">
                            <input type="checkbox" id="docCatSltAll" class="chckHead">
                            <label for="docCatSltAll"></label>
                        </div>
                    </th>
                </tr>
            </thead>
            <tbody id="DocCategoryTblbody">
            </tbody>
        </table>
    </div>

    <% Else %>
    <div id="NotAuthorized">
        <h4>You are not authorized to view this record. </h4>
    </div>
    <% End If %>

    <div id="NoProjectDivID" hidden="hidden">
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>You have not selected any project, please select the project.</h4>
    </div>

    <!--Page modal start here-->

    <!--Page modal end here-->

    <!-- REQUIRED JS SCRIPTS -->

          <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
<%-- 
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- jqueryUI js -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>

    <!-- alertify -->
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        //var ProjectID = '<%= ProjectID %>';
        var ajaxResult = "";
        var SelectedCategoryIDs = "";
        var ProjectID;       
        var cntDocCategory = 0;
        $(document).ready(function () {           
            
            //$("#docCatSltAll").click(function () {
            //   $(".doc-chck").prop('checked', $(this).prop('checked'));
            //});

            $('#docCatSltAll').click(function () {
                arrDocCatIds = [];
                var table = $('#DocCategoryTbl').DataTable();
                if ($(this).prop("checked") == true) {

                    var rows = table.rows({ 'search': 'applied' }).nodes();
                    $('input[type="checkbox"]:not(:disabled)', rows).each(function () {
                        this.checked = true;
                        
                        var curId = $(this).attr("id");
                        if (curId != undefined) {
                            curId = curId.toString().replace("DocCat", "");                           
                            
                            if (arrDocCatIds.indexOf(curId) == -1) {
                                arrDocCatIds.push(curId);
                            }
                        }
                    });
                   
                    //var strDocIDs = $('input[type="checkbox"]:not(:disabled)', rowss).map(function () {
                        
                    //}).get().join(',');
                    //alert(strDocIDs);
                    //arrDocCatIds

                }
                else if ($(this).prop("checked") == false) {
                    var row = table.rows({ 'search': 'applied' }).nodes();
                    $('input[type="checkbox"]:not(:disabled)', row).each(function () {
                        this.checked = false;
                    });
                }
            });


            $(document).on('change', '.doc-chck', function () {
               
                var table = $("#DocCategoryTbl").DataTable();
                var checke = table.rows().nodes().to$().find('input[type="checkbox"].chckHead').length;
                var checked = table.rows().nodes().to$().find('input[type="checkbox"].chckHead:checked').length;
                if (checke == checked) {
                    $("#DocCategoryTbl > thead > tr >th.sorting_disabled > div >#docCatSltAll").prop("checked", true);
                }
                else {
                    $("#DocCategoryTbl > thead > tr >th.sorting_disabled > div >#docCatSltAll").prop("checked", false);

                }

            });

             
            params = getParams();
            ProjectID = unescape(params["ProjectID"]);
         
            GetProjectName(ProjectID);
          
            if (ProjectID != 0) {
                GetDocCategoryList();
            }
            else {
                StartLoader("#Main_DocCategory");
                $("#NoProjectDivID").show();
                $("#pstbl_DocCategory").hide();
                StopAjaxLoader("#Main_DocCategory");
            }
        });        

        function GetDocCategoryList() {
            cntDocCategory = 0;
            StartLoader("#Main_DocCategory");

            var DocCategoryPrameters = {

                ProjectID: encodeURI(ProjectID)
            }
            var paramater = JSON.stringify(DocCategoryPrameters);
            var strResult = AJAXCallWithResult("/api/PM_DocumentCategory/GetDocCategoryList", paramater, false);
            
            $("#DocCategoryTbl").dataTable().fnDestroy();
            $("#DocCategoryTblbody").html('');
            var strHTML = "";
           
            cntDocCategory = strResult.length;
            for (var i = 0; i < strResult.length; i++) {

                var CategoryID = strResult[i]["CategoryID"]
                var Category = strResult[i]["Category"];
                var Used = strResult[i]["Used"];

                if (CategoryID != undefined || CategoryID != null || CategoryID != '') {
                    var CategoryIDExist = GetDocCategoryID(CategoryID);
                }
                
                strHTML += ' <tr>'
                strHTML += ' <td>' + Category + '</td>'
                strHTML += ' <td class="inp-select text-center">'
                strHTML += ' <div class="custom_chckbox">'
                if (Used != '0') {
                    strHTML += ' <input type="checkbox" id="DocCat' + CategoryID + '" class="disabled-checkbox" disabled checked name=chckAccess>'
                }
                else if (CategoryIDExist != null) {
                    strHTML += ' <input type="checkbox" id="DocCat' + CategoryID + '" class="chckHead doc-chck" checked name=chckAccess onclick="chkbxclickevent(this.id)">'
                    
                    if (arrDocCatIds.indexOf(CategoryID) == -1) {
                        arrDocCatIds.push(CategoryID);
                    }
                } else {
                    strHTML += ' <input type="checkbox" id="DocCat' + CategoryID + '" class="chckHead doc-chck" name=chckAccess onclick="chkbxclickevent(this.id)">'

                }
                strHTML += ' <label for="DocCat' + CategoryID + '"></label>'
                strHTML += ' </div>'
                strHTML += '</td>'
                strHTML += '</tr>'

            }

            $("#DocCategoryTblbody").html("")
            $("#DocCategoryTblbody").html(strHTML);

            StopAjaxLoader("#Main_DocCategory");
            $("#DocCategoryTbl").DataTable({
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "retrieve": true,
                "ordering": false,
                "columnDefs": [{
                    'width': '10%',
                    'targets': [1], /* column index */
                    'orderable': false, /* true or false */
                }],


            });

            if (strHTML == "") {
                $("#DocCategoryTbl tbody tr td").prop("colspan", 3);
            }
            Allcheckboxchecked();

        }

        function GetDocCategoryID(CategoryID) {
            var DocCategoryPrameters = {
                ProjectID: encodeURI(ProjectID),
                CategoryID: encodeURI(CategoryID)
            }
            var paramater = JSON.stringify(DocCategoryPrameters);
            var strResult = AJAXCallWithResult("/api/PM_DocumentCategory/GetDocCategoryID", paramater, false);
            return strResult;
        }
               
        var arrDocCatIds = [];
        function chkbxclickevent(chkbxid) {
            
           
            var CheckID = chkbxid.replace("DocCat", "");
            CheckID = parseInt(CheckID);
            var value = $("#" + chkbxid).is(':enabled:checked');
            if (value == true) {                
                if (arrDocCatIds.indexOf(CheckID) ==-1 )  {
                    arrDocCatIds.push(CheckID);
                }
               
            } else {                
                CheckID = parseInt(CheckID);
                if (arrDocCatIds.indexOf(CheckID) !=-1 ) {
                   
                    arrDocCatIds = jQuery.grep(arrDocCatIds, function(value) {
                             return value != CheckID;
                    });                   
                
                }
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
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_DocumentCategory%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");

                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_DocumentCategory%>');
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
        function UpdateDocCategory() {

            //debugger
            SelectedCategoryIDs = "";
            $.each(arrDocCatIds, function (i, item) {
                SelectedCategoryIDs += arrDocCatIds[i] + ",";
            });

            console.log(SelectedCategoryIDs);
            var DocCategoryPrameters = {
                CategoryIDs: encodeURI(SelectedCategoryIDs),
                ProjectID: encodeURI(ProjectID)
            }
            var paramater = JSON.stringify(DocCategoryPrameters);
            var strResult = AJAXCallWithResult("/api/PM_DocumentCategory/UpdateDocCategoryDetail", paramater, false);
            if (strResult != null) {
                alertify.success('<%= MyBase.GetResourceString("A_DocumentCategorySave") %>');
                //Commented And Added By Usha Pandit On 05.05.2020 For alert disappear issue
                //GetDocCategoryList();
                //SelectedCategoryIDs = "";
                //refreshMyParent();
                setTimeout(function () {
                    GetDocCategoryList();
                    SelectedCategoryIDs = "";
                    refreshMyParent();
                }, 2000);
                //End Of Added By Usha Pandit On 05.05.2020 For alert disappear issue
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
            var param = {
                ProjectID: ProjectID
            }
            //var paramater = JSON.stringify(param);
            
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectName',
                method: 'Post',
                data: JSON.stringify(param),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
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

        function Allcheckboxchecked() {
            var table = $("#DocCategoryTbl").DataTable();
            var checke = table.rows().nodes().to$().find('input[type="checkbox"].chckHead').length;
            var checked = table.rows().nodes().to$().find('input[type="checkbox"].chckHead:checked').length;
            if (checke == checked) {
                $("#DocCategoryTbl > thead > tr >th.sorting_disabled > div >#docCatSltAll").prop("checked", true);
            }
            else {
                $("#DocCategoryTbl > thead > tr >th.sorting_disabled > div >#docCatSltAll").prop("checked", false);
            }

            if (cntDocCategory == 0) {
                $("#docCatSltAll").attr("checked", false);
            }
        }
    </script>


</body>

</html>
