<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_racichart.aspx.vb" Inherits="PbNIT.racichart" %>

<!DOCTYPE html>

<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->

<head runat="server">

   <%-- <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1" />

    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" />--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <!--bootstrap multiselect---->
    <link href="../../../Whizible2.0-new/dist/css/bootstrap-multiselect.css" rel="stylesheet" />

</head>

    <style type="text/css">
        /*        CSS added by Madhuri.K content 30-Aug-2024*/
        .main_graybgtbs.nav-tabs>li>a:hover, .main_graybgtbs.nav-tabs>li.active>a:hover, .main_graybgtbs.nav-tabs>li>a:focus, .main_graybgtbs.nav-tabs>li.active>a {
    background: #1359a6;
    color: #fff !important;
}
        /*        CSS added by Madhuri.K content 30-Aug-2024*/
        .JStableOuter > table > thead > tr > th {
            min-width: 200px;
            max-width: 200px;
        }

        .JStableOuter.racitbl > table > tbody > tr > td {
            width: 100vw;
            vertical-align: middle;
        }
            /*.JStableOuter.racitbl > table > tbody > tr > td:last-child{ width:100%;}*/
            .JStableOuter.racitbl > table > tbody > tr > td:nth-child(1) {
                text-align: left;
            }


        .disabledbutton {
            pointer-events: none;
            opacity: 0.7;
        }

        .raciveview .nodrop:hover .multiselect-native-select::before {
            background: #fff url(../../../Whizible2.0-new/dist/img/ban.svg) 0 0 no-repeat;
            width: 16px;
            position: absolute;
            content: "";
            width: 20px;
            height: 16px;
            top: 0px;
            background-size: 16px;
            right: -4px;
            opacity: 0.8;
            z-index: 1;
        }


        /*BS5 changes*/
        /*button.multiselect::after{ display:none;}*/
        .raciviewsection .main_graybgtbs.nav-tabs > li > a {
            display: block;
        }

        .dividerline {
            top: 33px;
            transform: rotate(199deg);
        }

        select#wbsvalueExt {
            margin-top: 0px;
            position: relative;
            top: -5px;
            left: -5px;
        }

        .JStableOuter.racitbl > table > tbody > tr > td:nth-child(1) {
            line-height: 22px;
        }

        .filedownload .dropdown-toggle::after {
            display: none;
        }

        .raciviewsection { /*background: #fff; min-height: calc(100vh - 140px);*/
            padding-bottom: 0;
        }

        .racitbl .multiselect {
            min-height: 24px;
            border: 1px solid #ddd;
        }

        .multiselect span.caret {
            color: #666;
            position: absolute;
            height: auto;
            line-height: normal;
            right: 10px;
            top: 10px;
        }

        .multiselect-container > li > a {
            padding: 0;
            display: block;
            text-align: left;
        }

            .multiselect-container > li > a > label {
                padding: 3px 10px;
            }

        .raciviewsection .multiselect-container > li > a.multiselect-all label {
            padding-left: 10px;
        }

        .multiselect-container {
            background: #f5f5f5;
            border: 1px solid #ddd;
        }
        /*BS5 Changes End*/
        /*Added ruby Dipali V on 24th March 2023 For Alert Issue*/
        #CloseableAlert .close {
            float: right;
            border: none;
        }
        /*End of Added ruby Dipali V on 24th March 2023  For Alert Issue*/
        .form-select {
            padding: 0.375rem 2.375rem 0.375rem 0.375rem !important;
        }

        #CboProjectView {
            width: 150px;
            float: right;
        }
        /*Added by Riddhesh Patil on 8th May 2023 for UI Issue in dropdown*/
        .racitbl .multiselect {
            text-align: left;
        }
         /*End of Added by Riddhesh Patil on 8th May 2023 for UI Issue in dropdown*/
    </style>

<body id="bodyracichart" class="hold-transition sidebar-mini">


    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper-nomarginleft">
        <div class="graybg container-fluid pt-1 pb-1 statckmainheader">
            <div class="row">
                <div class="col-sm-3">
                    <% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-control' onChange='javascript:CboProject_OnChange(this.value);'", False,, ) %>
                    <% 'CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_Stakeholders " & Session("intUserID"),,, "class='form-control' onChange='javascript:CboProject_OnChange(this.value);'", True,, ) %>
                </div>
                <div class="col-sm-9 form-inline text-end">
                    <div class="form-group dropdown">
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboProjectView", "usp_Whizible2_Sel_Views",,, "class='form-select' onChange='javascript:ChangeView(this.value);'", False,, ) %>
                    </div>
                    <div class="form-group">
                        <%-- <a href="#"><strong><%= MyBase.GetResourceString("C_ClearAll") %></strong></a>--%>
                    </div>
                    <div class="form-group">
                    </div>
                </div>
            </div>
        </div>
        <div class="timesheetrow container-fluid bgwhite pt-1 pb-1 Stack_headerbot">
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-7">
                    <ul class="statustext hidden-xs">
                        <li><strong><%= MyBase.GetResourceString("C_RResponsible") %></strong></li>
                        <li><strong><%= MyBase.GetResourceString("C_RAccountable") %></strong></li>
                        <li><strong><%= MyBase.GetResourceString("C_RConsulted") %></strong></li>
                        <li><strong><%= MyBase.GetResourceString("C_RInformed") %></strong></li>
                    </ul>
                </div>
                <div id="divracichartdownload" class="col-md-6 col-sm-6 col-xs-5 float-end">
                    <ul class="float-end btnlistinline">
                        <li class="ml-1"></li>
                        <li>
                            <div class="dropdown filedownload">
                                <button id="btnRaciChartDownload" class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" autocomplete="off"><i class="fas fa-download" data-bs-toggle="tooltip" data-bs-placement="top" data-original-title="Download"></i></button>

                                <ul class="dropdown-menu" id="fas-download">
                                    <li>
                                        <a href="#" onclick="DownloadReport('PDF')">
                                            <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px" />Pdf</a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('EXCEL')">
                                            <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px" />Xlsx</a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('XML')">
                                            <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px" />Xml</a>
                                    </li>
                                    <li>
                                        <a href="#" onclick="DownloadReport('TEXT')">
                                            <%-- Commented & added By dipali V On 24th March 2023 For Change Doc to Text--%>
                                            <%-- <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px" />Doc</a>--%>
                                            <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px" />Text</a>
                                        <%--End of Commented & added By dipali V On 24th March 2023 For Change Doc to Text--%>
                                    </li>

                                </ul>
                            </div>

                        </li>
                        <li class="hidden-xs">
                            <a id="editresourcedetail" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Click here to edit" href="javascript:;" class="btn borderbtn nobtnstyle-xs"><%= MyBase.GetResourceString("C_EditButton") %></a>
                            <button id="saveresourcedetail" class="btn btnyellow nobtnstyle-xs hides" onclick="SaveRaciData()"><%= MyBase.GetResourceString("C_SaveButton") %></button>
                        </li>
                        <%--  <li class="hidden-xs">
                            </li>--%>
                    </ul>
                    <!--bootstrap_Alertify-->
                    <%--  /* Added & Commented By Dipali V on 24th March 2023 For Alert Issue*/ --%>
                    <%--<div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" hidden="hidden">--%>
                    <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg">
                        <button type="button" onclick="CloseShowAlert()" class="close">×</button>
                        <p id="alertMsg"></p>
                    </div>
                    <%--/*End of Added & Commented By Dipali V on 24th March 2023 For Alert Issue*/--%>
                    <!--bootstrap_Alertify-->
                </div>
                <div class="clearfix"></div>
            </div>
        </div>

        <!-- Main content -->
        <section id="sectionracichartmain" class="content">

            <div class="bgwhitewrap p1 raciviewsection">

                <ul class="nav nav-tabs main_graybgtbs">
                    <li class="active" id="ExternalBtn"><a href="#raciTableExternalDiv" data-bs-toggle="tab" onclick="onClickExternal()" id="External"><%= MyBase.GetResourceString("C_ExternalButton") %></a></li>
                    <li id="InternalBtn"><a href="#raciTableInternalDiv" data-bs-toggle="tab" onclick="onClickInternal()" id="Internal">Internal</a></li>
                </ul>
                <br />

                <div class="tab-content">

                    <!--External Section-->
                    <div role="tabpanel" class="tab-pane active" id="divExternal">
                        <div class="JStableOuter racitbl" id="raciTableExternalDiv">
                            <table class="table bgwhite table-bordered raciveview" id="tblExternalView">
                            </table>
                        </div>
                    </div>
                    <!--External Section END-->

                    <!--Internal section-->
                    <div role="tabpanel" class="tab-pane" id="divInternal">
                        <div class="JStableOuter racitbl racitblInternal" id="raciTableInternalDiv">
                            <table class="table bgwhite table-bordered raciveview" id="tblInternalView">
                            </table>
                        </div>
                    </div>
                    <!--Internal Section END-->

                    <div class="clearfix"></div>
                </div>

            </div>
        </section>
    </div>
    <!-- /.content-wrapper -->


    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->


    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/bootstrap-multiselect.js" type="text/javascript"></script>
    <%--added by vishal Mahajan 12-11-2019--%>
    <%--<script src="../../../Whizible2.0-new/dist/js/custom.js"></script>--%>
    <%--end--%>
    <%--<script src="../../General/CommonValidations.js?v=1"></script>--%>
    <script>
        //$('.raciveview td').addClass('nodrop');


        $('.JStableOuter > table').scroll(function (e) {
            $('.JStableOuter > table > thead').css("left", -$(".JStableOuter > tbody").scrollLeft());
            $('.JStableOuter > table > thead > tr th:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft() - 0);
            $('.JStableOuter > table > tbody > tr td:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft());
            $('.JStableOuter.racitbl table thead').css("top", -$(".JStableOuter.racitbl tbody").scrollTop());
            $('.JStableOuter.racitbl table thead tr th').css("top", $(".JStableOuter.racitbl table").scrollTop());
        });

        $(".raciviewsection .main_graybgtbs li a[href='#Internalresrc']").click(function () {
            $('.JStableOuter.racitblInternal > table').scroll(function (e) {
                $('.JStableOuter.racitblInternal > table > thead').css("left", -$(".JStableOuter.racitblInternal > tbody").scrollLeft());
                $('.JStableOuter.racitblInternal > table > thead > tr th:nth-child(1)').css("left", $(".JStableOuter.racitblInternal > table").scrollLeft() - 0);
                $('.JStableOuter.racitblInternal > table > tbody > tr td:nth-child(1)').css("left", $(".JStableOuter.racitblInternal > table").scrollLeft());
                $('.JStableOuter.racitbl.racitblInternal table thead').css("top", -$(".JStableOuter.racitbl.racitblInternal tbody").scrollTop());
                $('.JStableOuter.racitbl.racitblInternal table thead tr th').css("top", $(".JStableOuter.racitbl.racitblInternal table").scrollTop());
            });

        });

        function DesignTable() {

            if ($('.JStableOuter > table tr td').length > 6) {
                $('.JStableOuter > table').css('display', 'block');
            }
            else if ($('.JStableOuter > table tr td').length < 6) {
                $('.JStableOuter > table').css('display', '');
                $('.JStableOuter > table').css('display', 'table-block');
            }
            else {
                $('.JStableOuter > table').css('display', 'block');
            }
        }



        //dynamically set height
        function resizeSection(tag) {
            var tblhieghtraci = $(window).height();
            $('.JStableOuter.racitbl > table').css({
                'height': tblhieghtraci - 222,
                "overflow-y": "auto"
            });


        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });


        /*
              * Add collapse and remove events to boxes
              */
        $("[data-widget='collapse']").click(function () {
            //Find the box parent
            var box = $(this).parents(".box").first();
            //Find the body and the footer
            var bf = box.find(".box-body, .box-footer");
            if (!box.hasClass("collapsed-box")) {
                box.addClass("collapsed-box");
                bf.slideUp();
            } else {
                box.removeClass("collapsed-box");
                bf.slideDown();
            }
        });


        //loader   editresourcedetail

        $('#editresourcedetail').click(function () {
            $('.raciveview .multiselect-native-select').css('pointer-events', 'auto');
            $('.raciveview td').removeClass('nodrop');
            $('#editresourcedetail').hide();
            $('#saveresourcedetail').show();

            EditFlag = true;
        });
        $('#saveresourcedetail').click(function () {
            $('.raciveview .multiselect-native-select').css('pointer-events', 'none');
            $('#editresourcedetail').show();
            $('#saveresourcedetail').hide();
        });

    </script>

    <script>

        //checkall_filter_section
        $(".filterpanelwrap .chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(this).closest(".col-sm-2").find("ul .chcktbl").each(function () {
                    $(this).prop("checked", true);

                });
            } else {
                $(this).closest(".col-sm-2").find("ul .chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".filterpanelwrap .chcktbl").click(function () {

            if ($(this).closest(".col-sm-2").find("ul .chcktbl").length == $(this).closest(".col-sm-2").find(".chcktbl:checked").length) {
                $(this).closest(".col-sm-2").find(".chckHead").prop("checked", true);

            } else {
                $(this).closest(".col-sm-2").find("ul .chckHead").removeAttr("checked");
            }

        });


        //checkall for table

        $(".corporateroles table .chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".corporateroles table .chcktbl").each(function () {
                    $(this).prop("checked", true);

                });
            } else {
                $(".corporateroles table .chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".corporateroles .chcktbl").click(function () {

            if ($(".corporateroles table .chcktbl").length == $(".corporateroles table .chcktbl:checked").length) {
                $(".corporateroles table .chckHead").prop("checked", true);

            } else {
                $(".corporateroles table .chckHead").removeAttr("checked");
            }

        });


    </script>

    <script>

        /**
        * Created Date   :   16 Aug 2019
        * Purpose        :   On View Change Same Project Selected
        * Author         :   Imran Mulla
        * @param viewName
        */

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
        * Purpose        :   Working on Project Onchange
        * Author         :   Imran Mulla
        * @param projectID
        * @param type
        */


        function CboProject_OnChange(projectID) {

            enableDisabledControls(projectID);
            var IntClass = $('#InternalBtn').attr('class');
            var ExtClass = $('#ExternalBtn').attr('class');

            if ($('#InternalBtn').hasClass("active")) {
                var type = "Internal";
                if (type == "Internal") {
                    GetResourcesInternal(projectID, type);
                }
            }
            else if ($('#ExternalBtn').hasClass("active")) {
                var type = "External";
                GetResourcesExternal(projectID, type);
            }
        }


        function enableDisabledControls(projectID) {
            if (projectID == '' || projectID == '0') {
                $.each($("#divracichartdownload").find("li,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $.each($("#sectionracichartmain").find("select,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $("#CboProjectView").addClass("disabledbutton");
            } else {
                $.each($("#divracichartdownload").find("li,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $.each($("#sectionracichartmain").find("select,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $("#CboProjectView").removeClass("disabledbutton");
            }

        }

        /**
        * Created Date   :   27 Aug 2019
        * Purpose        :   For Internal Resources
        * Author         :   Imran Mulla
        **/

        function onClickInternal() {

            $('#divInternal').addClass('active');
            $('#divExternal').removeClass('active');
            $('#editresourcedetail').show();
            $('#saveresourcedetail').hide();

            var projectID = $("#CboProject").val();
            var type = "Internal";
            if (type == "Internal") {
                GetResourcesInternal(projectID, type);
                $('#InternalBtn').addClass('active');
                $('#ExternalBtn').removeClass('active');
                WBSChange($("#wbsvalueInt").val());
                //WBSChange("Milestone");
            }
        }

        /**
         * Created Date   :   27 Aug 2019
         * Purpose        :   For External Resources
         * Author         :   Imran Mulla
         **/

        function onClickExternal() {

            $('#divExternal').addClass('active');
            $('#divInternal').removeClass('active');
            $('#editresourcedetail').show();
            $('#saveresourcedetail').hide();
            var projectID = $("#CboProject").val();
            var type = "External";

            GetResourcesExternal(projectID, type);
            $('#ExternalBtn').addClass('active');
            $('#InternalBtn').removeClass('active');
            WBSChange($("#wbsvalueExt").val());

        }

        /**
         * Created Date   :   27 Aug 2019
         * Purpose        :   For WBS Internal Resources Thead data
         * Author         :   Imran Mulla
         * @param projectID
         * @param type
         */


        function GetResourcesInternal(projectID, type) {
            StartLoader("#bodyracichart");
            var paramitersForGrid = {
                projectID: encodeURI(projectID),
                type: encodeURI(type)

            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_RaciChart/GetRaciChartProjectContact',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForGrid),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (paramitersForGrid) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForGrid) ? paramitersForGrid : JSON.stringify(paramitersForGrid)));
                    }
                },
                success: function (result) {
                    if (result.length > 0) {

                        var type = "Internal";
                        if (type == "Internal") {

                            getTableResoureDataForInternal(result);

                            GetResourceRoleInternal(projectID, "Internal");

                        }
                    }
                    else {
                        $("#tblInternalView thead th").remove();
                        $('#raciTableInternalDiv table tbody').not(function () { return !!$(this).has('th').length; }).remove();
                        if (!(projectID == '' || projectID == '0'))
                        	//Commented And Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                            //showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                            if (maindataexists == false) {
                                showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                            }
                        //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                    }
                    StopAjaxLoader("#bodyracichart")
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        /**
         * Created Date   :   28 Aug 2019
         * Purpose        :   For WBS Internal Resources Tbody data
         * Author         :   Imran Mulla 
         * @param result
         */

        function getTableResoureDataForInternal(result) {
            if (result.length > 0) {
                var InternalResourcesHead = "";
                $('#tblInternalView').html("");
                ResourceCount = result.length;
                Resources = result;
                count = ResourceCount;
                for (var i = 0; i < result.length; i++) {
                    InternalResourcesHead = InternalResourcesHead + ' <th>' + result[i].Name + '<span style="font-weight:normal">' + result[i].Designation + '</span><input type="hidden" value="' + result[i].ProjectContactID + '" id="hdnStakeholderResources"></th>  ';
                }
                var tableHeadDesignIntern = '<thead> <tr style="border-top:none;top: 0;">  ' +
                    '               <th style="border-bottom:none;text-align:right; left: 0; class="text-end">Resource<span style="font-weight:normal">Role</span>  ' +
                    '                   <div class="dividerline"></div><div class="clearfix"></div>  ' +
                    '                   <select class="roleresourcedropdown float-start" id="wbsvalueInt" onchange="WBSChange(this.value);" >  ' +
                    '                   <option>Milestone</option>  ' +
                    '                   <option>Phase</option>  ' +
                    '                   <option>Sub projects</option>  ' +
                    '                   <option>Deliverables</option>  ' +
                    '                   <option>Module</option>  ' +
                    '              </select>  ' +
                    '               </th>  ' +
                    '          ' + InternalResourcesHead +
                    '           </tr> ' +
                    '            </thead> ';

                $('#tblInternalView').html(tableHeadDesignIntern);

            }
            else {
                $("#tblInternalView thead th").remove();
                $('#raciTableExternalDiv table tbody').not(function () { return !!$(this).has('th').length; }).remove();
				//Commented And Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                //showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                if (maindataexists == false) {
                    showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                }
                //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
            }
        }

        /**
         * Created Date   :   27 Aug 2019
         * Purpose        :   For WBS Internal Resources Success Function
         * Author         :   Imran Mulla
         * @param projectId
         * @param type
         */

        function GetResourceRoleInternal(projectId, type) {

            StartLoader("#bodyracichart");
            var objMilstones = {
                projectID: encodeURI(projectId),
                type: encodeURI(type)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_RaciChart/GetProjectMilstones',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(objMilstones),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (objMilstones) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objMilstones) ? objMilstones : JSON.stringify(objMilstones)));
                    }
                },
                success: function (result) {

                    //getTbodyResourceRoleInternal(result);
                    StopAjaxLoader("#bodyracichart")
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        /**
         * Created Date   :   27 Aug 2019
         * Purpose        :   For WBS Internal Resources for Tbody
         * Author         :   Imran Mulla
         * @param result
         */

        function getTbodyResourceRoleInternal(result) {

            if (result.length > 0) {
                $("#tblExternalView tr").detach();
                var count = result.length;
                var tbodysesign = "";
                $("#tbodyIds").remove();
                tbodysesign = '<tbody id="tbodyIds">';
                var createTr = "";
                for (var i = 0; i < result.length; i++) {

                    createTr = createTr + '<tr><td class="nodrop"><input type="hidden" value="' + result[i].ID + '" id="hdnWBS">' + result[i].Name + '</td>';
                    for (var j = 0; j < ResourceCount; j++) {

                        createTr = createTr + '   <td class="nodrop"><span class="multiselect-native-select">' +
                            '	<select id="RACIMultiSelect' + i + j + '" multiple="multiple" class="form-control multiselectdropdown" title="">' +
                            '		<option value="1">R</option>' +
                            '		<option value="2">A</option>' +
                            '		<option value="3">C</option>' +
                            '		<option value="4">I</option>' +
                            '	</select>' +
                            '</td>';
                    }
                    $("RACIMultiSelect").find("option[value=1").prop("selected", "selected");

                    createTr = createTr + '</tr>'
                }
                tbodysesign = tbodysesign + createTr + '</tbody>';
                $('#tblInternalView').append(tbodysesign);
                AutoGenerateCheckbox();
                SelectCheckbox(result, 'tblInternalView');

            }
            else {
                $("#tbodyIds").remove();
                var tbodysesigned = "";
                tbodysesigned = '<tbody id="tbodyIds">';
                var createTrtd = "";
                createTrtd = createTrtd + '<tr><td style="font-weight: bold"></td>';
                for (var j = 0; j < ResourceCount; j++) {

                    createTrtd = createTrtd + '   <td></td > ';
                }
                createTrtd = createTrtd + '</tr>'
                tbodysesigned = tbodysesigned + createTrtd + '</tbody>';
                $('#tblInternalView').append(tbodysesigned);
                //Commented And Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                //showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                if (maindataexists == false) {
                    showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                }
                //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
            }
            AutoGenerateCheckbox();
            // $(".multiselect-native-select .multiselect").prop('data-bs-toggle', dropdown);
        }

        /**
         * Created Date   :   27 Aug 2019
         * Purpose        :   For WBS External Resources for Head Data
         * Author         :   Imran Mulla
         * @param result
         */

        function getTableResoureDataForExternal(result) {
            if (result.length > 0) {
                var externalResourcesHead = "";
                $('#tblExternalView').html("");
                ResourceCount = result.length;
                for (var i = 0; i < result.length; i++) {
                    externalResourcesHead = externalResourcesHead + ' <th>' + result[i].Name + '<span style="font-weight:normal">' + result[i].Designation + '</span><input type="hidden" value="' + result[i].ProjectContactID + '" id="hdnStakeholderResources"></th>  ';
                }

                var tableHeadDesign = '<thead> <tr style="border-top:none;top: 0;">  ' +
                    '               <th style="border-bottom:none;text-align:right; left: 0; class=" text-end">Resource<span style="font-weight:normal">Role</span>  ' +
                    '                   <div class="dividerline"></div><div class="clearfix"></div>  ' +
                    '                   <select class="roleresourcedropdown float-start" id="wbsvalueExt" onchange="WBSChange(this.value);" >  ' +
                    '                   <option>Milestone</option>  ' +
                    '                   <option>Phase</option>  ' +
                    '                   <option>Sub projects</option>  ' +
                    '                   <option>Deliverables</option>  ' +
                    '                   <option>Module</option>  ' +
                    '              </select>  ' +
                    '               </th>  ' +
                    '          ' + externalResourcesHead +
                    '           </tr> ' +
                    '            </thead> ';
                $('#tblExternalView').append(tableHeadDesign);
            }
            else {
                $("#tbodyIds").remove();
                var tbodysesigned = "";
                tbodysesigned = '<tbody id="tbodyIds">';
                var createTrtd = "";
                createTrtd = createTrtd + '<tr><td style="font-weight: bold"></td>';
                for (var j = 0; j < ResourceCount; j++) {
                    createTrtd = createTrtd + '   <td></td > ';
                }
                createTrtd = createTrtd + '</tr>'
                tbodysesigned = tbodysesigned + createTrtd + '</tbody>';
                $('#tblExternalView').append(tbodysesigned);
                //Commented And Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                //showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                if (maindataexists == false) {
                    showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                }
                //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
            }
        }

        /**
         * Created Date   :   27 Aug 2019
         * Purpose        :   For WBS External Resources TBody Data
         * Author         :   Imran Mulla
         * @param result
         */

        function getTbodyResourceRole(result) {


            if (result.length > 0) {
                $("#tblInternalView tr").detach();
                $("#tbodyIds").remove();
                var tbodysesign = "";
                tbodysesign = '<tbody id=tbodyIds>';
                var createTr = "";
                for (var i = 0; i < result.length; i++) {
                    createTr = createTr + '<tr><td class="nodrop"><input type="hidden" value="' + result[i].ID + '" id="hdnWBS">' + result[i].Name + '</td>';
                    for (var j = 0; j < ResourceCount; j++) {
                        createTr = createTr + '   <td class="nodrop"><span class="multiselect-native-select">' +
                            '	<select id="RACIMultiSelect' + i + j + '" multiple="multiple" class="form-control multiselectdropdown" title="">' +
                            '<option value="1">R</option>' +
                            '<option value="2">A</option>' +
                            '<option value="3">C</option>' +
                            '<option value="4">I</option>' +
                            '	</select>' +
                            '</td>';
                    }
                    createTr = createTr + '</tr>'
                }
                tbodysesign = tbodysesign + createTr + '</tbody>';
                $('#tblExternalView').append(tbodysesign);
                AutoGenerateCheckbox();
                SelectCheckbox(result, 'tblExternalView');
            }

            else {
                $("#tbodyIds").remove();
                var tbodysesigned = "";
                tbodysesigned = '<tbody id="tbodyIds">';
                var createTrtd = "";
                createTrtd = createTrtd + '<tr><td style="font-weight: bold"></td>';
                for (var j = 0; j < ResourceCount; j++) {
                    createTrtd = createTrtd + '   <td></td > ';
                }
                createTrtd = createTrtd + '</tr>'
                tbodysesigned = tbodysesigned + createTrtd + '</tbody>';
                $('#tblExternalView').append(tbodysesigned);
                //Commented And Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                //showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                if (maindataexists == false) {
                    showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                }
                //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
            }
            AutoGenerateCheckbox();
        }

        /**
         * Created Date   :   27 Aug 2019
         * Purpose        :   For WBS External Resources
         * Author         :   Imran Mulla
         * @param projectId
         * @param type
         */

        function GetResourceRole(projectId, type) {

            var objMilstones = {
                projectID: encodeURI(projectId),
                type: encodeURI(type)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_RaciChart/GetProjectMilstones',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(objMilstones),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (objMilstones) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objMilstones) ? objMilstones : JSON.stringify(objMilstones)));
                    }
                },
                success: function (result) {

                    if (type == "External") {
                        getTbodyResourceRole(result);
                    }
                    else {
                        //Added By Dipali V On 11th May 2023 
                        getTbodyResourceRoleInternal(result);
                    }

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        /**
         * Created Date   :   27 Aug 2019
         * Purpose        :   For WBS External Resources
         * Author         :   Imran Mulla
         * @param projectID
         * @param type
         */

        function GetResourcesExternal(projectID, type) {
            StartLoader("#bodyracichart");
            var paramitersForGrid = {
                projectID: encodeURI(projectID),
                type: encodeURI(type)

            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_RaciChart/GetRaciChartProjectContact',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForGrid),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (paramitersForGrid) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForGrid) ? paramitersForGrid : JSON.stringify(paramitersForGrid)));
                    }
                },
                success: function (result) {
                    StopAjaxLoader("#bodyracichart")
                    if (result.length > 0) {
                        var type = "External";
                        if (type == "External") {
                            getTableResoureDataForExternal(result);
                            GetResourceRole(projectID, "External");

                        }
                    }
                    else {
                        $("#tblExternalView thead th").remove();
                        $('#raciTableExternalDiv table tbody').not(function () { return !!$(this).has('th').length; }).remove();
                        //Commented And Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                       <%-- if (!(projectID == '' || projectID == '0'))
                            showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');--%>
                        if (!(projectID == '' || projectID == '0')) {

                            if (maindataexists == false) {
                                showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                            }
                        }
                        //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        /**
        * Created Date   :   26 Aug 2019
        * Purpose        :   On View Change Same Project Selected With Different WBS On Internal and External Resources
        * Author         :   Imran Mulla
        * @param Value
        */


        $(document).ready(function () {
            $.each($("#CboProjectView option"), function (index, option) {
                $(this).removeAttr("title");
            });
            $('#RACIMultiSelect').multiselect();
            // $('.multiselect').attr('data-bs-toggle');


            StartLoader("#bodyracichart");
            DesignTable();
            var projectID = '<%= Request.QueryString("ProjectID")%>';
            var SessionProjectId = '<%= Session("intProjectID") %>';
            var UserName = User;
            EditFlag = false;
            var count;

            //Comment removed by imran on 24-12-2021 if prject is closed that time  project combo cannot get that particular project which is closed
            fillprojectname();
            // End comment by imran on 24-12-2021

            if (projectID.length) {
                $("#CboProject").val(projectID);
                GetResourcesExternal(projectID, "External");
            }
            else if (SessionProjectId.length) {
                $("#CboProject").val(SessionProjectId);
                GetResourcesExternal(SessionProjectId, "External");
                //$('#tabActive').css('tab-slider-trigger,.active');
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
            }
        });

        function WBSChange(value) {

            var Value;

            StartLoader("#bodyracichart");
            var Type = "";
            var IntClass = $('#InternalBtn').attr('class');
            var ExtClass = $('#ExternalBtn').attr('class');
            $('#editresourcedetail').show();
            $('#saveresourcedetail').hide();

            if (IntClass == "active") {
                if (value != undefined) {
                    Value = value;
                } else {
                    Value = $("#wbsvalueInt").val();
                }

                var type = "Internal";
                $('#raciTableInternalDiv table tbody').not(function () { return !!$(this).has('th').length; }).remove();
                $("#tblExternalView tr").detach();

                var ProcedureName = "";
                if (Value == "Module") {
                    ProcedureName = "usp_Whizible2_sel_tbl_ModuleRaciView";
                    Type = "Module";
                }
                else if (Value == "Sub projects") {

                    ProcedureName = "usp_Whizible2_sel_tbl_SubProjectRaciView";
                    Type = "Subprojects";
                }
                else if (Value == "Milestone") {

                    ProcedureName = "usp_Whizible2_sel_tbl_MilestonesRaciView";
                    Type = "Milestone";
                }
                else if (Value == "Phase") {

                    ProcedureName = "usp_Whizible2_sel_tbl_PhaseRaciView";
                    Type = "Phase";
                }
                else if (Value == "Deliverables") {

                    ProcedureName = "usp_Whizible2_sel_tbl_DeliverableRaciView";
                    Type = "Deliverables";
                }
                else {
                    $("#tbodyIds").remove();
                    StopAjaxLoader("#bodyracichart");
                    return;
                }
                let projectId = $('#CboProject').val();
                var paramitersForGrid = {
                    projectID: encodeURI(projectId),
                    ProcedureName: encodeURI(ProcedureName),
                    Type: encodeURI(Type),
                    StakeholderType: encodeURI('Internal')

                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_RaciChart/GetWBSProjects',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    data: JSON.stringify(paramitersForGrid),
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (paramitersForGrid) {
                            xhr.setRequestHeader("Params", encryptString(isJson(paramitersForGrid) ? paramitersForGrid : JSON.stringify(paramitersForGrid)));
                        }
                    },
                    success: function (result) {
                        StopAjaxLoader("#bodyracichart");
                        var tbodysesign = "";
                        if (result.length > 0) {
                            $("#tbodyIds").remove();
                            tbodysesign = '<tbody id="tbodyIds">';
                            var createTr = "";
                            for (var i = 0; i < result.length; i++) {

                                createTr = createTr + '<tr><td class="nodrop"><input type="hidden" value="' + result[i].ID + '" id="hdnWBS">' + result[i].Name + '</td>';
                                for (var j = 0; j < ResourceCount; j++) {
                                    createTr = createTr + '   <td class="nodrop"><span class="multiselect-native-select">' +
                                        '	<select id="RACIMultiSelect' + i + j + '" multiple="multiple" class="form-control multiselectdropdown" title="">' +
                                        '		<option value="1">R</option>' +
                                        '		<option value="2">A</option>' +
                                        '		<option value="3">C</option>' +
                                        '		<option value="4">I</option>' +
                                        '	</select>' +
                                        '</td>';

                                }
                                createTr = createTr + '</tr>'
                            }
                            tbodysesign = tbodysesign + createTr + '</tbody>';
                            $('#tblInternalView').append(tbodysesign);
                            AutoGenerateCheckbox();
                            SelectCheckbox(result, 'tblInternalView');
                        }
                        else {
                            $("#tbodyIds").remove();
                            var tbodysesigned = "";
                            tbodysesigned = '<tbody id="tbodyIds">';
                            var createTrtd = "";
                            createTrtd = createTrtd + '<tr><td style="font-weight: bold"></td>';
                            for (var j = 0; j < ResourceCount; j++) {
                                createTrtd = createTrtd + '   <td></td > ';
                            }
                            createTrtd = createTrtd + '</tr>'
                            tbodysesigned = tbodysesigned + createTrtd + '</tbody>';
                            $('#tblInternalView').append(tbodysesigned);
                            //Commented And Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                            //showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                            if (maindataexists == false) {
                                showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                            }
                            //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }


                });


            }
            else if (ExtClass == "active") {

                if (value != undefined) {
                    Value = value;
                } else {
                    Value = $("#wbsvalueExt").val();
                }
                var WBSType = "";
                var type = "External";
                $('#raciTableExternalDiv table tbody').not(function () { return !!$(this).has('th').length; }).remove();
                $("#tblInternalView tr").detach();

                var ProcedureName = "";
                if (Value == "Module") {
                    ProcedureName = "usp_Whizible2_sel_tbl_ModuleRaciView";
                    WBSType = "Module";
                }
                else if (Value == "Sub projects") {
                    ProcedureName = "usp_Whizible2_sel_tbl_SubProjectRaciView";
                    WBSType = "Subprojects";
                }
                else if (Value == "Milestone") {
                    ProcedureName = "usp_Whizible2_sel_tbl_MilestonesRaciView";
                    WBSType = "Milestone";
                }
                else if (Value == "Phase") {
                    ProcedureName = "usp_Whizible2_sel_tbl_PhaseRaciView";
                    WBSType = "Phase";
                }
                else if (Value == "Deliverables") {
                    ProcedureName = "usp_Whizible2_sel_tbl_DeliverableRaciView";
                    WBSType = "Deliverables";
                }
                else {
                    $("#tbodyIds").remove();
                    StopAjaxLoader("#bodyracichart");
                    return;
                }
                let projectId = $('#CboProject').val();
                var paramitersForGrid = {
                    projectID: encodeURI(projectId),
                    ProcedureName: encodeURI(ProcedureName),
                    Type: encodeURI(WBSType),
                    StakeholderType: encodeURI('External')

                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_RaciChart/GetWBSProjects',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    data: JSON.stringify(paramitersForGrid),
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (paramitersForGrid) {
                            xhr.setRequestHeader("Params", encryptString(isJson(paramitersForGrid) ? paramitersForGrid : JSON.stringify(paramitersForGrid)));
                        }
                    },
                    success: function (result) {
                        //$('#raciTableExternalDiv tr').not(function () { return !!$(this).has('th').length; }).remove();
                        StopAjaxLoader("#bodyracichart");
                        var tbodysesign = "";
                        if (result.length > 0) {
                            $("#tbodyIds").remove();
                            tbodysesign = '<tbody id="tbodyIds">';
                            var createTr = "";
                            for (var i = 0; i < result.length; i++) {
                                createTr = createTr + '<tr><td class="nodrop"><input type="hidden" value="' + result[i].ID + '" id="hdnWBS">' + result[i].Name + '</td>';
                                for (var j = 0; j < ResourceCount; j++) {

                                    createTr = createTr + '   <td class="nodrop"><span class="multiselect-native-select">' +
                                        '	<select id="RACIMultiSelect' + i + j + '" multiple="multiple" class="form-control multiselectdropdown" title="">' +
                                        '		<option value="1">R</option>' +
                                        '		<option value="2">A</option>' +
                                        '		<option value="3">C</option>' +
                                        '		<option value="4">I</option>' +
                                        '	</select>' +
                                        '</td>';
                                }
                                createTr = createTr + '</tr>'
                            }

                            tbodysesign = tbodysesign + createTr + '</tbody>';
                            $('#tblExternalView').append(tbodysesign);
                            AutoGenerateCheckbox();
                            SelectCheckbox(result, 'tblExternalView');
                        }
                        else {
                            $("#tbodyIds").remove();
                            var tbodysesigned = "";
                            tbodysesigned = '<tbody id="tbodyIds">';
                            var createTrtd = "";
                            //for (var i = 0; i < result.length; i++) {
                            createTrtd = createTrtd + '<tr><td style="font-weight: bold"></td>';
                            for (var j = 0; j < ResourceCount; j++) {

                                createTrtd = createTrtd + '   <td></td > ';
                            }
                            createTrtd = createTrtd + '</tr>'
                            //}
                            tbodysesigned = tbodysesigned + createTrtd + '</tbody>';
                            $('#RACIMultiSelect').append(tbodysesigned);
                            //Commented And Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                            //showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                            if (maindataexists == false) {
                                showAlert('<%= MyBase.GetResourceString("C_No_data_for_this_Project") %>', 'alert-danger');
                            }
                            //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }

                });

            }


        }


    </script>

    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var AddAccess = '<%=m_AddAccess%>';
        var EditAccess = '<%=m_EditAccess%>';
        var DeleteAccess = '<%=m_DeleteAccess%>';
        var ViewAccess = '<%=m_ViewAccess%>';
        setUserAccess();

        let ResourceCount = 0;
        var Resources = new Array();
        var UserID = '<%= Session("intUserID") %>';
        var User ='<%= Session("strUserName") %>';
        window.onload = function GetSessionProject() {
            //Added By Reshma Chavan on 20th Dec 2021 to show closed project on RACI View
            $.each($("#CboProjectView option"), function (index, option) {
                $(this).removeAttr("title");
            });
            let projectID = '<%= Request.QueryString("ProjectID")%>';
            var SessionProjectId = '<%= Session("intProjectID") %>';
            fillprojectname();
            if (projectID.length) {
                $("#CboProject").val(projectID, "External");
                GetResourcesExternal(projectID, "External");
            }
            else if (SessionProjectId.length) {
                $("#CboProject").val(SessionProjectId, "External");
                GetResourcesExternal(SessionProjectId, "External");
                $('#tabActive').css('tab-slider-trigger,.active');
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
            }
            //End of Added By Reshma Chavan on 20th Dec 2021 to show closed project on RACI View

        }

        function setUserAccess() {
            if (AddAccess == 'False' && EditAccess == 'False' && DeleteAccess == 'False' && ViewAccess == 'False') {
                $("#btnRaciChartDownload").attr('title', 'You Dont have access to download');
                $("#btnRaciChartDownload").addClass("disabledbutton");
            }
            if (EditAccess == 'False') {
                $("#editresourcedetail").attr('title', 'You Dont have access to edit');
                $("#editresourcedetail").addClass("disabledbutton");
            }
        }
    </script>

    <script>
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
            $('.ClosaeblealertMsg').delay(6000).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }
        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }
        //#endregion

        /**
       * Created Date   :   8 Aug 2019
       * Purpose        :   Automatically checkbox generated on RACI check
       * Author         :   Imran Mulla
        * */
        $(".RACIMultiSelect option").click(function () {
            alert();
            var clickedOption = $(this);
        });
        function AutoGenerateCheckbox() {
            $('.multiselectdropdown').multiselect({
                select: [1],
                includeSelectAllOption: true,
                countSelectedText: false,
                nSelectedText: false,
                allSelectedText: false,
                selectAllJustVisible: false,
                numberDisplayed: 999999999999,
                templates: {
                    button: '<button type="button" class="multiselect dropdown-toggle" data-bs-toggle="dropdown"><span class="multiselect-selected-text"></span><span class="caret"></span></button>',
                },
                onSelectAll: function () {
                    $('button[class="multiselect"]').attr('title', false);
                },
                buttonClass: 'form-select',
                buttonTitle: function () { },
                //allSelectedText:false,
                //allSelectedText:false,
                nonSelectedText: ' ',
                delimiterText: '/ '
            }
            );
        }

        function SelectCheckbox(result, table) {

            $('#' + table + ' tbody tr').each(function () {

                var hdnWBSValue = "";
                var Stakeholder = "";
                var tr = $(this);
                $(this).find('td').each(function (index, Value) {
                    var $td = $(this);
                    if (index == 0) {
                        hdnWBSValue = $(this).find("input[type=hidden]").val();
                    }
                    else {


                        var th = $(this).closest('table').find('th').eq($(this).index());
                        Stakeholder = $(th).find("input[type=hidden]").val();
                        var getWBSValues = result.filter(function (item) {
                            return item.ID == hdnWBSValue;
                        });
                        var RACI = getWBSValues[0].listStakeholder;
                        if (RACI != null) {
                            var arrRACI = RACI.filter(function (item) {
                                return item.StakeholderID == Stakeholder;
                            });
                            if (arrRACI.length > 0) {
                                var getRACI = arrRACI[0].RACI;

                                if (getRACI != undefined) {
                                    var Multiselect = $(this).find('select').attr('id');
                                    for (var k in getRACI) {
                                        var optionVal = getRACI[k];

                                        $("#" + Multiselect).find("option[value=" + optionVal + "]").prop("selected", "selected");
                                    }
                                }
                            }
                        }
                    }
                });
            });
            $(".multiselectdropdown").multiselect('refresh');
        }

        /**
        * Created Date   :   14 Aug 2019
        * Purpose        :   Save RACI data into database
        * Author         :   Imran Mulla
     
         * */

        function SaveRaciData() {
            StartLoader("#bodyracichart");
            var Table = "";
            var Type = "";
            var IntClass = $('#InternalBtn').attr('class');
            var ExtClass = $('#ExternalBtn').attr('class');
            if (IntClass == "active") {
                Table = "tblInternalView";
                Type = $('#wbsvalueInt option:selected').text();
            }
            else {
                Table = "tblExternalView";
                Type = $('#wbsvalueExt option:selected').text();
            }
            if (Type == "Sub projects") {
                Type = "Subprojects";
            }


            var stakeholdersIDs = [];
            $("#" + Table).find("th").each(function (index, val) {
                if (index == 0) {
                    stakeholdersIDs.push('stakeholdersIDs');
                }
                else {
                    var resourceId = $(this).find('input').val();
                    var element = $(this);
                    stakeholdersIDs.push(resourceId);
                }

            });

            var rows = [];
            var WBSArray = new Array();
            var listRaci = new Array();
            var lisResources = new Array();
            var RacichartData = new Array();
            $("#" + Table + " tbody tr").each(function () {
                var SelectedRaci = "";
                var SelectedResource = "";
                var WBS = "";
                var Resource = "";
                $(this).find("td").each(function (i, v) {
                    if (i == 0) {
                        //rows.push($(this).find('input').val());
                        WBS = $(this).find('input').val();
                    }
                    else {

                        var th = $(this).closest('table').find('th').eq($(this).index());
                        var ResourceName = $(th).text().trim()
                        SelectedResource = $(th).find('input').val();
                        var ulElement = $(this).find('ul');
                        var liElement = $(ulElement).find('li');
                        $(liElement).each(function (INDEX) {
                            if (INDEX == 0) {

                            }
                            else {
                                if ($(this).hasClass('active')) {
                                    if (SelectedRaci == "") {
                                        SelectedRaci = '1';
                                    }
                                    else {
                                        SelectedRaci = SelectedRaci + ',' + '1';
                                    }
                                }
                                else {
                                    if (SelectedRaci == "") {
                                        SelectedRaci = '0';
                                    }
                                    else {
                                        SelectedRaci = SelectedRaci + ',' + '0';
                                    }
                                }
                            }
                        });
                        var raciItem = {
                            strRaci: SelectedRaci
                        }
                        listRaci.push(raciItem);
                        SelectedRaci = "";
                        var resourceItem = {
                            strResources: SelectedResource
                        }
                        lisResources.push(resourceItem);
                        SelectedResource = "";
                    }

                });
                var listRaciWbs = {
                    strWBS: WBS,
                    listRaci: listRaci,
                    lisResources: lisResources
                }
                listRaci = [];
                lisResources = [];
                RacichartData.push(listRaciWbs);
            });
            SaveRACIChart(RacichartData, Type)
        }

        /**
        * Created Date   :   14 Sept 2019
        * Purpose        :   Save RACI data into database using ajax function.
        * Author         :   Imran Mulla
        
         * @param RacichartData
         * @param Type
         */
        //Added By Usha Pandit On 09.12.2020 For getting correct validation alert
        var maindataexists = false;
        //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
        function SaveRACIChart(RacichartData, Type) {
            maindataexists = false;
            var res = "";
            $(".multiselectdropdown").each(function () {
                //Commented And Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                //res = res + " " + $(this).val();
                if ($(this).val() != null) {
                    res = res + " " + $(this).val();
                }
                //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
            });
            if (res == "") {
                showAlert('<%= MyBase.GetResourceString("C_No_data_available_for_this_WBS") %>', 'alert-danger');
            }
            else {
                var raciparameters = {
                    ProjectID: $('#CboProject').val(),
                    UserID: UserID,
                    UserName: User,
                    Type: Type,
                    listRaciWbs: RacichartData
                }
                $.ajax({

                    url: strUrl + '/api/PM_RaciChart/SaveRacichartProjectContacts',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(raciparameters),       // Parameters
                    dataType: "json",                                   //Retrun Type
                    contentType: "application/json; charset=utf-8",     //
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        //if (raciparameters) {
                        //     xhr.setRequestHeader("Params", encryptString(isJson(raciparameters) ? raciparameters : JSON.stringify(raciparameters)));
                        // }
                    },
                    success: function (result) {
                        //Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                        maindataexists = true;
                        //End Of Added By Usha Pandit On 09.12.2020 For getting correct validation alert
                        showAlert('<%= MyBase.GetResourceString("C_Save_successfully") %>', 'alert-success');


                        showAlert('<%= MyBase.GetResourceString("C_Save_successfully") %>', 'alert-success');
                        $.each($(".raciveview tr"), function (index, td) {

                            $.each($(this).find('td'), function (index, tdcontrol) {
                                $(this).addClass("nodrop");
                                $(this).addClass("nodrop");
                            });
                        });
                    },
                    error: function (ER) {
                        showAlert('<%= MyBase.GetResourceString("C_Data_not_saved") %>', 'alert-danger');
                    }
                });
            }
            var IntClass = $('#InternalBtn').attr('class');
            var ExtClass = $('#ExternalBtn').attr('class');
            var wbsInt = $("#wbsvalueInt").val();
            var wbsExt = $("#wbsvalueExt").val();

            if (IntClass == "active") {

                GetResourcesInternal($('#CboProject').val(), "Internal");
                if ($("#wbsvalueInt").val() != undefined) {
                    $("#wbsvalueInt").val(wbsInt);
                    WBSChange(wbsInt);
                }
            } else {

                GetResourcesExternal($('#CboProject').val(), "External");

                if ($("#wbsvalueExt").val() != undefined) {
                    $("#wbsvalueExt").val(wbsExt);
                    WBSChange(wbsExt);
                }
            }


            StopAjaxLoader("#bodyracichart");
        }


        function DownloadReport(ReportFormat) {
            var ddl = "";
            var type = "";
            var IntClass = $('#InternalBtn').attr('class');
            var ExtClass = $('#ExternalBtn').attr('class');

            if (IntClass == "active") {
                type = "Internal";
                ddl = $('#wbsvalueInt option:selected').text();
            }
            else {
                type = "External";
                ddl = $('#wbsvalueExt option:selected').text();
            }
            if (ddl == 'Sub projects')
                ddl = 'Subprojects';
            //Added by Chetan M on 17 Jun 2021 for handle when data is not present in grid
            if (ddl == "") {
                showAlert('<%= MyBase.GetResourceString("C_Records_are_not_available to_download_report") %>', 'alert-danger');
            }
            else {
                //End of Added by Chetan M on 17 Jun 2021 for handle when data is not present in grid
                var rptRacichart = {
                    projectID: $('#CboProject').val(),
                    StakeholderType: type,
                    Type: ddl,
                    ReportFormat: ReportFormat
                }

                $.ajax({
                    url: strUrl + '/api/PM_RaciChart/ExportDocument',
                    type: "POST",
                    data: JSON.stringify(rptRacichart),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (rptRacichart) {
                            xhr.setRequestHeader("Params", encryptString(isJson(rptRacichart) ? rptRacichart : JSON.stringify(rptRacichart)));
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
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
            }
        }

        $('[data-bs-toggle="tooltip"]').tooltip();

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
                    //.append('<option value=""></option>');
                    //$("#CboProject").empty().append('<option value=""></option>');
                    $.each(result, function () {
                        $("#CboProject").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));
                        //$("#CboProject").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));
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


