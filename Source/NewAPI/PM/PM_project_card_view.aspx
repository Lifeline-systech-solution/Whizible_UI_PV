<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_project_card_view.aspx.vb" Inherits="PbNIT.project_card_view" %>

<!DOCTYPE html>
 
<html>
    <!-- Commented by Madhuri.K On 09-08-2024 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("")%>
<head>
    <%--<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" />--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3" />
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css" rel="stylesheet" />

</head>
    <style type="text/css">
.myspan {display: none;}
.disabledbutton {pointer-events: none;opacity: 0.7;}

/*BS5 Changes*/
.main_graybgtbs.nav-tabs>li>a{ display:block;}
.filedownload button::after{ display:none;}
.pbCard_contctinfo{ margin-top:0px;}
.main_graybgtbs.nav-tabs>li>a.active{ background:#135a9c; color:#fff;}
/*End BS5 changes*/

    </style>


<body id="bodycardview" class="hold-transition sidebar-mini">


    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper-nomarginleft">
        <div class="graybg container-fluid pt-1 pb-1 statckmainheader">
            <div class="row">
                <div class="col-sm-3">
                    <% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-control form-select'  onChange='javascript:CboProject_OnChange(this.value);'", False,, ) %>                   
                </div>
                <div class="col-sm-9 form-inline text-end">
                    <div class="form-group dropdown">
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboProjectView", "usp_Whizible2_Sel_CardViews",,, "class='form-control form-select' onChange='javascript:ChangeView(this.value);'", False,, ) %>
                    </div>
                    <div class="form-group">
                    </div>
                    <div class="form-group">
                    </div>
                </div>

            </div>
        </div>
        <div class="timesheetrow container-fluid bgwhite pt-1 pb-1 Stack_headerbot">
            <div class="row">
                 <div class="col-md-6 col-sm-6 col-xs-7">
                   
                </div>
                <div id="divcardviewdownload" class="col-md-6 col-sm-6 col-xs-5 float-end">
                    <ul class="float-end btnlistinline">
                        <li class="ml-1"></li>
                        <li>
                            <div class="dropdown filedownload">
                                <button id="btnCardViewDownload" class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" autocomplete="off"><i class="fas fa-download" data-bs-toggle="tooltip" data-bs-placement="top" data-original-title="Download"></i></button>

                                <ul class="dropdown-menu" id="fas-download">
                                    <li>
                                        <a href="#" onclick="DownloadReport('PDF')">
                                            <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('EXCEL')">
                                            <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('XML')">
                                            <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('TEXT')">
                                          <%--  <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Doc--%>
                                              <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Text
                                        </a>
                                    </li>
                                </ul>

                            </div>

                        </li>
                        <li class="hidden-xs">
                            <!--  <a id="editresourcedetail" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Click here to edit" href="javascript:;" class="btn borderbtn nobtnstyle-xs">Edit</a> -->
                            <button id="saveresourcedetail" class="btn btnyellow nobtnstyle-xs hides">Save</button>
                        </li>
                    </ul>
                    <!--bootstrap_Alertify-->
                    <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" hidden="hidden">
                        <button type="button" onclick="CloseShowAlert()" class="close">×</button>
                        <p id="alertMsg"></p>
                    </div>
                    <!--bootstrap_Alertify-->
                </div>
               
                <div class="clearfix"></div>
            </div>
        </div>

        <!-- Main content -->
        <section id="sectioncardviewmain" class="content">
            <div class="bgwhitewrap cardviewbody">
                <ul class="nav nav-tabs main_graybgtbs float-start" role="tablist">
                    <li class="nav-item" id="ExternalBtn"><a href="#cardExternal" class="active" rol="tab" data-bs-toggle="tab" onclick="onClickExternal()"><%= MyBase.GetResourceString("C_ExternalButton") %></a></li>
                    <li id="InternalBtn" class="nav-item"><a href="#cardInternal" data-bs-toggle="tab" onclick="onClickInternal()"><%= MyBase.GetResourceString("C_InternalButton") %></a></li>
                </ul>
                <div class="clearfix"></div>

                <div class="tab-content active">
                    <div id="cardExternal" class="tab-pane active">
                        <div class="tabcontent_body">
                            <div class="row" id="cardExternalDiv">
                                
                            </div>

                        </div>
                    </div>


                    <div id="cardInternal" class="tab-pane">
                        <div class="tabcontent_body">
                            <div class="row" id="cardInternalDiv">
                              
                            </div>
                        </div>
                    </div>


                </div>




                <div class="col-sm-12">
                    <div class="col-sm-6">
                       
                    </div>
                </div>



                <div class="row">
                   
                </div>

                <br />
                <br />

                <div class="clearfix"></div>
            </div>

            <div class="clearfix"></div>



        </section>
    </div>
    <!-- /.content-wrapper -->
    <!-- ./wrapper -->

    <!-- REQUIRED JS SCRIPTS -->
     <!-- Commented by Madhuri.K On 09-08-2024 for JQuery and Bootstrap version upgrade -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>

    <!--added by vishal Mahajan 12-11-2019-->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <!--end-->
    <script src="../../General/CommonValidations.js"></script>--%>
    <script type="text/javascript">
        var AddAccess = '<%=m_AddAccess%>';
        var EditAccess = '<%=m_EditAccess%>';
        var DeleteAccess = '<%=m_DeleteAccess%>';
        var ViewAccess = '<%=m_ViewAccess%>';
        setUserAccess();
        function setUserAccess() {
            if (AddAccess == 'False' && EditAccess == 'False' && DeleteAccess == 'False' && ViewAccess == 'False') {
                $("#btnCardViewDownload").attr('title', 'You Dont have access to download');
                $("#btnCardViewDownload").addClass("disabledbutton");
            }
        }

        $('[data-bs-toggle="tooltip"]').tooltip();


        //dynamically set height
        function resizeSection(tag) {
            var tblhieght = $(window).height();
            $('.bgwhitewrap').css({ 'height': tblhieght - 145, "overflow-y": "auto" });

        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

    </script>
    <script>

        /**
         * Created Date   :   4 Sept 2019
         * Purpose        :   Working on Project Onchange
         * Author         :   Imran Mulla 
         * @param projectID
         * @param type
         */


        function CboProject_OnChange(projectID) {
            enableDisabledControls(projectID);
            var IntClass = $('#InternalBtn').attr('class');
            var ExtClass = $('#ExternalBtn').attr('class');

            if (IntClass == "active") {
                $('#cardInternalDiv').html('');
                var type = "Internal";
                if (type == "Internal") {
                    GetResourcesExternalInternal(projectID, type);
                }
            }
            else if (ExtClass == "active") {

                $('#cardExternalDiv').html('');
                var type = "External";
                GetResourcesExternalInternal(projectID, type);
            }
        }


        /**
         * Created Date   :   4 Sept 2019
         * Purpose        :   Working on Project Data
         * Author         :   Imran Mulla
         * @param projectID
         * @param type
         */

        function GetResourcesExternalInternal(projectID, type) {
            StartLoader("#bodycardview");
            var paramitersForGrid = {
                projectID: projectID,
                type: type

            }
            $.ajax({
                url: strUrl + '/api/PM_ProjectCard/GetProjectCardContact',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForGrid),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (paramitersForGrid) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForGrid) ? paramitersForGrid : JSON.stringify(paramitersForGrid)));
                    }
                },
                success: function (result) {
                    StopAjaxLoader("#bodycardview");
                    if (result.length > 0) {

                        //var type = "External";
                        if (type == "External") {
                            GetResource(result);
                        }
                        else if (type == "Internal") {
                            GetResourceInt(result);
                        }
                    }
                    else {
                        if (!(projectID == '' || projectID == '0'))
                            showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        //by vishal Mahajan 12-11-2019
        function enableDisabledControls(projectID) {
            if (projectID == '' || projectID == '0') {
                $.each($("#divcardviewdownload").find("li,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $.each($("#sectioncardviewmain").find("select,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $("#CboProjectView").addClass("disabledbutton");
            } else {
                $.each($("#divcardviewdownload").find("li,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $.each($("#sectioncardviewmain").find("select,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $("#CboProjectView").removeClass("disabledbutton");
            }

        }
        //end

        function GetResource(result) {

            if (result.length > 0) {

                var createTr = "";



                for (var i = 0; i < result.length; i++) {
                    var ImageURL = "";
                    if (result[i].Photo != "") {
                        ImageURL = result[i].Photo;
                    }
                    else {
                        ImageURL = " ../../../Images/Photo/no-photo.PNG";
                    }
                    createTr = createTr + '   <div class="col-sm-4">                                                            ' +
                        '                     <div class="pbCard">                                                              ' +
                        '                     <div class="pbCardtop row-eq-height">                                             ' +
                        '                     <div class="col-sm-3 pbCardprofile">                                              ' +
                        '                     <div class="pbCardprofileimg">                                                    ' +
                        '                     <img src="' + ImageURL + '" alt="" title="" ></div >                              ' +
                        '                     </div>                                                                            ' +
                        '                     <div class="col-sm-9 pbCardinfo">                                                 ' +
                        '                     <div class="pbCardName">' + result[i].Name + '</div>';


                    var designation = result[i].Designation;
                    if (designation == "") {

                        var design = "<br/>";
                    }
                    else {
                        var design = '<span class="pbCardrole">' + result[i].Designation + '</span>';
                        //var design = "<span class='pbCardrole'>'" + result[i].Designation + "'</span>";
                    }
                    createTr = createTr + design;
                    createTr = createTr + '                                                                                     ' +
                        '                     <div class="pbCard_contctinfo">                                                   ' +
                        '                     <span class=""><i class="far fa-envelope"></i>' + result[i].EmailID + '</span>    ' +
                        '                     <span class=""><i class="fas fa-phone"></i> ' + result[i].Mobile + '</span>       ' +
                        '                     </div>                                                                            ' +
                        '                     </div>                                                                            ' +
                        '                     </div>                                                                            ' +
                        '                     <div class="clearfix"></div>                                                      ' +
                        '                     </div>';

                    createTr = createTr + '</div>';
                }
                $('#cardExternalDiv').append(createTr);
            }
            else {
                $('#cardInternalDiv').html('');
                showAlert('<%= MyBase.GetResourceString("C_No_Resource_for_this_Project") %>', 'alert-danger');
            }
        }


        function GetResourceInt(result) {
            if (result.length > 0) {
                var createTr = "";
                for (var i = 0; i < result.length; i++) {
                    var ImageURL = "";
                    if (result[i].Photo != "") {
                        ImageURL = result[i].Photo;
                    }
                    else {
                        ImageURL = " ../../../Images/Photo/no-photo.PNG";
                    }
                    createTr = createTr + '   <div class="col-sm-4">                                                            ' +
                        '                     <div class="pbCard">                                                              ' +
                        '                     <div class="pbCardtop row-eq-height">                                             ' +
                        '                     <div class="col-sm-3 pbCardprofile">                                              ' +
                        '                     <div class="pbCardprofileimg">                                                    ' +
                        '                     <img src="' + ImageURL + '" alt="" title="" /></div >                             ' +
                        '                     </div>                                                                            ' +
                        '                     <div class="col-sm-9 pbCardinfo">                                                 ' +
                        '                     <div class="pbCardName">' + result[i].Name + '</div>';


                    var designation = result[i].Designation;
                    if (designation == "") {

                        var design = "<br/>";
                    }
                    else {
                        var design = '<span class="pbCardrole">' + result[i].Designation + '</span>';
                    }
                    createTr = createTr + design;
                    createTr = createTr + '                                                                                     ' +
                        '                     <div class="pbCard_contctinfo">                                                   ' +
                        '                     <span class=""><i class="far fa-envelope"></i>' + result[i].EmailID + '</span>    ' +
                        '                     <span class=""><i class="fas fa-phone"></i> ' + result[i].Mobile + '</span>       ' +
                        '                     </div>                                                                            ' +
                        '                     </div>                                                                            ' +
                        '                     </div>                                                                            ' +
                        '                     <div class="clearfix"></div>                                                      ' +
                        '                     </div>';

                    createTr = createTr + '</div>';
                    createTr = createTr + '</div>';
                }
                $('#cardInternalDiv').append(createTr);
            }
            else {
                $('#cardExternalDiv').html('');
                showAlert('<%= MyBase.GetResourceString("C_No_Resource_for_this_Project") %>', 'alert-danger');
            }
        }


    </script>


    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        let ResourceCount = 0;
        window.onload = function GetSessionProject() {
             $.each($("#CboProjectView option"), function (index, option) {
                $(this).removeAttr("title");
            });
            let projectID = '<%= Request.QueryString("ProjectID")%>';
            var SessionProjectId = '<%= Session("intProjectID") %>';
            fillprojectname();
            if (projectID.length) {
                $("#CboProject").val(projectID, "External");
                GetResourcesExternalInternal(projectID, "External");
            }
            else if (SessionProjectId.length) {
                $("#CboProject").val(SessionProjectId, "External");
                GetResourcesExternalInternal(SessionProjectId, "External");
                $('#tabActive').css('tab-slider-trigger,.active');
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
            }
        }

        /**
        * Created Date   :   4 Sept 2019
        * Purpose        :   On View Change Same Project Selected
        * Author         :   Imran Mulla
         * */
        function ChangeView() {

            var viewName = $('#CboProjectView').find(":selected").text();
            if (viewName.toUpperCase() == "RACI VIEW") {
                
                var selectedProject = $('#CboProject').val();
                
                window.location.href = "PM_racichart.aspx?ProjectID=" + selectedProject;

            }
            else if (viewName == "List View") {
                var selectedProject = $('#CboProject').val();
                window.location.href = "PM_stakeholders.aspx?ProjectID=" + selectedProject;

            }
            else if (viewName == "Card View") {
                var selectedProject = $('#CboProject').val();
                window.location.href = "PM_project_card_view.aspx?ProjectID=" + selectedProject;

            }
            else if (viewName == "Metrix View") {
                var selectedProject = $('#CboProject').val();
                window.location.href = "stakebubblechart.html";
                Response.redirect("stakebubblechart.html");
            }
        }


        /**
       * Created Date   :   27 Aug 2019
       * Purpose        :   For Internal Resources
       * Author         :   Imran Mulla
       **/

        function onClickInternal() {
            $('#cardInternalDiv').html('');
            $('#cardInternal').addClass('active');
            $('#cardExternal').removeClass('active');
            var projectID = $("#CboProject").val();
            var type = "Internal";
            if (type == "Internal") {
                GetResourcesExternalInternal(projectID, type);
            }
        }

        /**
         * Created Date   :   27 Aug 2019
         * Purpose        :   For External Resources
         * Author         :   Imran Mulla
         **/

        function onClickExternal() {
            $('#cardExternalDiv').html('');
            $('#cardExternal').addClass('active');
            $('#tabActive').css('tab-slider-trigger,.active');
            $('#cardInternal').removeClass('active');
            var projectID = $("#CboProject").val();
            var type = "External";
            if (type == "External") {
                GetResourcesExternalInternal(projectID, type);
            }
        }

        /**
      * Created Date     :   22 Aug 2019
      * Purpose          :   DownloadReport
      * Author           :   Chanrashekhar Salagar.       
      * @param ReportFormat
      */
        function DownloadReport(ReportFormat) {

            var Type = "";
            if ($('#ExternalBtn').attr('class') == "active") {
                Type = "External";
            }
            else {
                Type = "Internal";
            }
            var projectCardReportParameters = {
                ReportFormat: ReportFormat,
                projectID: $("#CboProject").val(),
                ContractType: Type

            }
            $.ajax({
                url: strUrl + '/api/PM_ProjectCard/ExportDocument',
                type: "POST",
                data: JSON.stringify(projectCardReportParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (projectCardReportParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(projectCardReportParameters) ? projectCardReportParameters : JSON.stringify(projectCardReportParameters)));
                    }
                },
                success: function (data) {

                    //alert("Success");
                    if (data == "") {
                        showAlert('<%= MyBase.GetResourceString("C_Records_are_not_available to_download_report") %>', 'alert-danger');

                    }
                    else {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");
                    }


                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }


        //#region Alerts
        function showAlert(Msg, className, id) {

            $('.ClosaeblealertMsg').show();
            if (id != undefined) {
                $('#' + id).prop("disabled", true);
            }
            if (className == 'alert-danger') {
                $('#CloseableAlert').removeClass("alert-success");
                $('#CloseableAlert').addClass("alert-danger");
            }
            else if (className == 'alert-success') {
                $('#CloseableAlert').removeClass("alert-danger");
                $('#CloseableAlert').addClass("alert-success");
            }
            $('#alertMsg').html(Msg);
            $('.ClosaeblealertMsg').delay(2000).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }
        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }
        //endregion

        function fillprojectname() {
            var defaultFilterParameters = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                ProjectID: encodeURI('<%= Session("intProjectID") %>')
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Stakeholders/GetProjectDropDown',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {

                    $("#CboProject").empty();
                    $.each(result, function () {
                        $("#CboProject").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));
                       
                    });

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

    </script>

    <%--added by Vishal Mahajan 12-11-2019--%>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <%--end--%>
</body>
</html>

