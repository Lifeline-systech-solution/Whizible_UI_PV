<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectKeywords.aspx.vb" EnableSessionState="true" Inherits="PbNIT.PM_ProjectKeywords" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    
    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Project</title>
    <!--Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/jquery-ui.css?v=2" />
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap.min.css?v=1" />
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0/bootstrap/css/bootstrap-select.css?v=2" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0/fontawesome/css/all.css?v=2" />--%>
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/AdminLTE.min.css?v=2" />
    <!-- animate css -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0/dist/css/animate.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/dataTables.bootstrap.min.css?v=0" />
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/style_custom_projctsetting.css?v=3.1" />
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0/dist/css/media_queries.css?v=2" />
    <%--<link href="../../../Plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../../Whizible2.0/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />

    <!--<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700" rel="stylesheet">-->
    
</head>

    <style type="text/css">
        .affix {
            top: 0;
            width: 100%;
            z-index: 9999 !important;
        }

        /*new css added by pradip_03-10-2019*/
        .CP_sitedetailpanel {
            clear: both;
            min-height: 55vh;
        }

        .CP_sitedetailpanelbody {
            padding: 15px;
        }

            .CP_sitedetailpanelbody .pull-right.btnlistinline {
                margin-top: -55px;
                margin-right: 15px;
            }

        .subcontainerbody a.pull-right.btn.borderbtn {
            margin-top: 3px;
        }

        .promaintotlerow td.text-right {
            text-align: right;
        }

        .pstbl_tasktype td:first-child, .pstbl_tasktype th:first-child {
            width: 29.5%;
        }

        .pstbl_tasktype td:nth-child(2), .pstbl_tasktype th:nth-child(2) {
            width: 10%;
        }

        .pstbl_tasktype td:nth-child(3), .pstbl_tasktype th:nth-child(3) {
            width: 30%;
        }

        .pstbl_tasktype td:nth-child(4), .pstbl_tasktype th:nth-child(4) {
            width: 20%;
        }

        .pstbl_tasktype td:last-child, .pstbl_tasktype th:last-child {
            width: 5%;
        }

        .practicesteeting_right {
            padding-left: 0;
            padding-right: 0;
        }

        .practicesettinglistheader {
            background: #f5f5f5;
        }

        .practicesettinglist table.toplinks td:last-child {
            text-align: right;
        }

        #commercialmilestone .container-fluid > a.btn.borderbtn {
            margin-bottom: 15px;
        }

        .cce_type ul.list-inline.pull-right {
            margin-top: -55px;
        }

        .budget_tbl tr:last-child td input {
            width: 100%;
            min-width: inherit;
        }

        .newpro_convotablist li a:hover {
            background: #ccc;
            color: #464a4c;
        }

        .alertify-notifier {
            z-index: 9999;
        }

        .tbl-keywords {
            width: 97%;
            margin: 0 auto 15px;
        }

        .pl-15 {
            padding-left: 15px;
        }
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divProjectKeywords">
        <!--ps_list_table_start-->
        <div class="tab-pane pstbl_keyword pt-0 in active" id="pstbl_keyword" style="border-top: 1px solid #ddd;">
            <div class="modalpgHead  pt-1 pb-1 col-sm-12 mb-10">
                <span>Keywords</span>
            </div>
            <h5 class="pull-left pl-20 mb-10">Project Name : <span id="spanProjectName"></span></h5>

            <table class="table table-stripped table-bordered tbl-keywords">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("C_PMKeywordHeading") %></th>
                        <th class="sm-wid">
                            <div class="custom_chckbox">
                                <input id="keywordAll" class="chkKeywordHead" type="checkbox" />
                                <label for="keywordAll"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tbodykeyword">
                </tbody>
            </table>
            <div class="keywords-add pl-15">
                <%If m_blnAddAccess = True Then%>
                <button class="btn borderbtn mr-5" id="addKeyword" data-toggle="modal" data-target="#addKeywordPopup"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_PMKeywordAdd") %></button>
                <%End If %>
                <%If m_blnDeleteAccess = True Then%>
                <button class="btn borderbtn" id="deleteKeyword" data-toggle="modal" data-target="#deleteKeywordPopup"><%= MyBase.GetResourceString("C_PMKeywordDelete") %></button>
                <%End If %>
            </div>
        </div>
        <!--ps_list_table_end-->

        <!--Add new site modal end here-->


        <!--Add keywords modal start here-->

        <div class="modal custmodal fade" id="addKeywordPopup" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_PMKeywordHeading") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_PMKeywordLabelModal") %> <span style="color: red">*</span></label>
                                <div class="col-sm-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cmbKeywords", "usp_Whizible2_Sel_tbl_IB_Keywords ",,, "class='form-control selectpicker'", False,,) %>
                                    <input id="hdnkey" type="hidden" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <!--<label class="control-label col-sm-4">&nbsp;</label>-->
                                <div class="col-sm-12 btns-center">
                                    <button data-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_PMKeywordCloseModal") %></button>
                                    <button id="btnKeywordSave" class="btn btnyellow pull-right ml-1" onclick="SaveKeywords()"><%= MyBase.GetResourceString("C_PMKeywordSaveModal") %></button>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--Add keywords modal end here-->

        <!--Delete_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="deleteKeywordPopup" aria-hidden="true" data-dismiss="modal">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_PMKeywordDeletePopup") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <h5>
                                <center><%= MyBase.GetResourceString("C_PMKeywordDeleteConfirm") %></center>
                            </h5>
                        </div>
                        <br />
                        <center>
                                    <button data-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_PMKeywordDeletePopupCancel") %></button>
                                    <button id="btnKeywordDelete" class="btn btnyellow ml-1"><%= MyBase.GetResourceString("C_PMKeywordDeletePopupOkay") %></button>
                                </center>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- REQUIRED JS SCRIPTS -->
        <!-- jQuery 2.1.4 -->
         <%--<script src="../../../Whizible2.0/plugins/jQuery/jQuery-2.1.4.min.js"></script>--%> 
    <%--<script src="../../../Whizible2.0/plugins/jQuery/jquery-3.5.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
        <!-- jqueryUI js -->
        <%--<script src="../../../Whizible2.0/plugins/jQueryUI/jquery-ui.min.js"></script>
        <!-- Bootstrap 3.3.5 -->
        <script src="../../../Whizible2.0/bootstrap/js/bootstrap-select.js"></script>
        <!-- Bootstrap 3.3.5 -->
        <script src="../../../Whizible2.0/bootstrap/js/bootstrap.min.js"></script>
        <!-- Bootstrap 3.3.5 -->
        <script src="../../../Whizible2.0/dist/js/jquery.dataTables.min.js"></script>
        <!-- alertify -->
        <script src="../../../Plugins/alertify/alertify.min.js"></script>--%>

        <script>
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        //var projectid = '<%=m_ProjectId%>';
            var userName = '<%=m_UserName%>';
            var ViewAccess = "<%= m_blnViewAccess %>";

            $(document).ready(function () {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectKeywords").html(bodyHTML);
                    return;
                }
                $("#keywordAll").click(function () {
                    $(".chkKeywordHead").prop('checked', $(this).prop('checked'));
                });

                params = getParams();
                projectid = unescape(params["ProjectID"]);

                GetProjectName(projectid);
                GetKeywordList();
            });

            var ajaxResult;
            function AJAXCallWithResult(url, param, async) {
                $.ajax({
                    url: strUrl + url,
                    type: "POST",
                    data: param,
                    async: async,
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (data) {
                        ajaxResult = data;
                    },
                    error: function (err) {
                        ajaxResult = undefined;
                        console.log(err);
                    }
                });
                return ajaxResult;
            }

            function GetKeywordList() {
                var projectKeywordParameters = {
                    ProjectID: projectid,
                }
                var param = JSON.stringify(projectKeywordParameters);
                var data = AJAXCallWithResult("/api/PM_ProjectKeywords/GetProjectKeywords", param, false);
                if (data != undefined) {
                    $('#tbodykeyword').html('');
                    var strHtml = '';
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            strHtml += '<tr>';
                        <%If m_blnEditAccess = True Then%>
                        strHtml += '<td><a href="#" class="text-center" onclick="EditKeyword(' + data[i].ProjectKeywordID + ',\'' + data[i].Keyword + '\')">' + data[i].Keyword + '</a></td>';
                        <%Else %>
                        strHtml += '<td>' + data[i].Keyword + '</td>';
                        <%End If %>
                        strHtml += '<td class="sm-wid">';
                        strHtml += '<div class="custom_chckbox">';
                        strHtml += '<input id="chkkeyword' + data[i].ProjectKeywordID.toString() + '" class="chkKeywordHead mainchck" type="checkbox" onchange="KeywordsAllchkbxchekedoruncheckd()"/>';
                        strHtml += '<label for="chkkeyword' + data[i].ProjectKeywordID.toString() + '"></label>';
                        strHtml += '</div>';
                        strHtml += '</td>';
                        strHtml += '</tr>';
                    }
                }
                else {
                    strHtml += '<tr>';
                    strHtml += '<td class="text-center"><%= MyBase.GetResourceString("C_PMKeywordNoRecords") %></td><td></td>';
                        strHtml += '</tr>';
                    }
                    $('#tbodykeyword').html(strHtml);
                }
            }

            $('#deleteKeyword').click(function () {
                var sel = $('.mainchck:checked').map(function () {
                    return this.id.replace('chkkeyword', '');
                }).get().join(',');
                if (sel == "") {
                    var msg = '<%= MyBase.GetResourceString("C_PMKeywordSelectMsgError") %>';
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(msg, 'error');
                    return false;
                }
            })

            $('#btnKeywordDelete').click(function () {
                var sel = $('.mainchck:checked').map(function () {
                    return this.id.replace('chkkeyword', '');
                }).get().join(',');
                if (sel == "") {
                    var msg = '<%= MyBase.GetResourceString("C_PMKeywordSelectMsgError") %>';
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(msg, 'error');
                    return false;
                }

                var projectKeywordParameters = {
                    ProjectID: projectid,
                    selectedList: sel,
                }
                var param = JSON.stringify(projectKeywordParameters);
                var data = AJAXCallWithResult("/api/PM_ProjectKeywords/DeleteProjectKeywords", param, false);
                if (data != undefined) {
                    if (data.toString().indexOf('cannot') > -1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(data.toString(), 'error');
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(data.toString(), 'success');
                    }
                }
                $('#deleteKeywordPopup').modal('hide');
                GetKeywordList();
            })

            function SaveKeywords() {
                $('#addKeywordPopup').modal('show');
                $("#btnKeywordSave").removeAttr('data-dismiss', 'modal');
                var key = $('#cmbKeywords').val();
                if (key == 0) {
                    var msg = '<%= MyBase.GetResourceString("C_PMKeywordSelectSaveMsgError") %>';
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(msg, 'error');
                return false;
            }
            var keyid = $('#hdnkey').val();
            var projectKeywordParameters = {
                ProjectID: projectid,
                ProjectKeyword: key,
                UserName: userName,
                ProjectKeywordID: keyid,
            }
            var param = JSON.stringify(projectKeywordParameters);

            var data = AJAXCallWithResult("/api/PM_ProjectKeywords/AddEditProjectKeywords", param, false);
            alertify.set('notifier', 'position', 'top-right');
            if (data != undefined) {
                if (data.toString().indexOf('Success') > -1) {
                    alertify.notify(data.toString(), 'success');
                }
                else {
                    alertify.notify(data.toString(), 'error');
                }
            }
            else {
                var msg = '<%= MyBase.GetResourceString("C_PMKeywordSaveMsgError") %>';
                    alertify.notify(msg, 'error');
                }
                $('#hdnkey').val('');
                //$('#addKeywordPopup').modal('hide');
                $("#btnKeywordSave").attr('data-dismiss', 'modal');
                GetKeywordList();
                $('table > thead > tr > th > div>input#keywordAll').prop('checked', false);
            }

            function EditKeyword(key, keyword) {
                $('#cmbKeywords').val(keyword).change();
                $('#hdnkey').val(key);
                $('#addKeywordPopup').modal('show');
            }

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
                var ProjectID = ProjectID;

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectName',
                    method: 'Post',
                    data: JSON.stringify(ProjectID),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    },
                    success: function (result) {
                        $("#spanProjectName").text(result);
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }
            //Added By Omkar to uncheck Select All
            function KeywordsAllchkbxchekedoruncheckd() {

                var ck_box_cnt = $('#tbodykeyword input[type="checkbox"]').length;

                var chk_box_checked_cnt = $('#tbodykeyword input[type="checkbox"]:checked').length;

                if (ck_box_cnt == chk_box_checked_cnt) {
                    $('table > thead > tr > th.sm-wid > div >input#keywordAll').prop('checked', true);

                } else {
                    $('table > thead > tr > th > div>input#keywordAll').prop('checked', false);
                }
            }


        //End Added By Omkar to uncheck Select All
        </script>
    </div>
</body>

</html>
