<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectDashBoard.aspx.vb" Inherits="PbNIT.ProjectDashBoard" %>

<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project Dashboard")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/project-dashboard.css?v=0.6">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
 
</head>

    <style type="text/css">
        .widgetcategory_Action span {
            min-height: 100%;
            line-height: 8vh
        }

        .widgetcatbox:hover p {
            color: #fff
        }

        .widgetcategory_Action {
            border-left: 1px solid #eee
        }

        .widgetcatbox.selected:hover {
            color: #464a4c
        }

            .widgetcatbox.selected:hover p {
                color: #999
            }

        .widget_category_panelbody {
            background: #fff;
            box-shadow: 0 0 3px 1px #ccc
        }

        .chartbox .box-tools {
            clear: both;
            width: 100%;
            background: #fff;
            padding: 10px;
            margin: 0px 0px 0px;
            position: static;
            border-bottom: 1px solid #ddd;
        }

        .col-sm-12 > .chartbox .clsMandatoryFields {
            width: 49.5% !important;
        }

        .widget_category_panelbody {
            background: #fff;
            box-shadow: 0px 0px 3px 1px #ccc;
        }

        .widget_category_panelbody {
            position: relative;
        }

        .widget_category_panelbody {
            padding: 30px;
        }

        .box-body {
            min-height: 222px;
        }

        .week-slt-box {
            width: 120px !important;
        }
        /*Added by Pradip on 08-01-2020*/
        .clsMandatoryFields {
            background: #fff;
        }

        /*Added by Omkar T on 08-01-2020*/
        #projectpulse > div.col-sm-12.form-inline.pt-1.pb-1.boxsubheader > div:nth-child(2) > div, #Metrics > div.col-sm-12.form-inline.pt-1.pb-1.boxsubheader > div.form-group.week-slt-dropdown > div, #Commercials > div.col-sm-12.form-inline.pt-1.pb-1.boxsubheader > div.form-group.week-slt-dropdown > div {
            margin-right: 1px;
        }

        .slt-proj-dropdown {
            width: 220px;
        }

            .week-slt-dropdown ul.dropdown-menu.inner, .slt-proj-dropdown ul.dropdown-menu.inner {
                max-height: 300px !important;
            }

        @media screen and (max-width:1200px) {
            .box-tools .clsMandatoryFields {
                width: 49% !important;
            }

            #projectpulse .col-sm-12 div.box.chartbox > div.box-tools select, #Metrics .col-sm-12 div.box.chartbox > div.box-tools select, #Commercials .col-sm-12 div.box.chartbox > div.box-tools select {
                width: 49.4% !important;
            }
        }

        @media screen and (max-width:1100px) {
            .box-tools .clsMandatoryFields {
                width: 48.9% !important;
            }

            #projectpulse .col-sm-12 div.box.chartbox > div.box-tools select, #Metrics .col-sm-12 div.box.chartbox > div.box-tools select, #Commercials .col-sm-12 div.box.chartbox > div.box-tools select {
                width: 49.4% !important;
            }
        }

        .riskmatrixtbl tr:last-child td {
            vertical-align: top !important;
            width: 86px;
            padding: 6px 4px !important;
        }

        .widgetcategory_Action span .fas {
            font-size: 17px;
        }

        .box-header, .box-body {
            padding: 10px !important;
        }
        /*Added css by pradip .p on 18-01-2020 */
        .row-eq-height {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            flex-wrap: wrap;
        }

            .row-eq-height > [class*='col-'] {
                display: flex;
                flex-direction: column;
            }

        .box.chartbox {
            border: none;
            height: 100%;
        }

        .box-body.pl-0 {
            padding-left: 0 !important;
        }

        /*End Added css by pradip .p on 18-01-2020 */

        .form-inline .form-control{width:150px}
    </style>


<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bdyProjectDashboard">
    <div class="" style="height: 100vh; overflow-y: scroll;">
        <!-- Main content -->
        <div class="graybg container-fluid pt-1 pb-1 headertopp">
            <div class="projectmaintabs">
                <ul class="nav nav-tabs main_graybgtbs" role="tablist" id="ulProjectaccssibletabs">
                </ul>
            </div>
        </div>
        <div class="widget_category_panel collapse" id="dashwidget">
            <div class="widget_category_panelbody">
                <button type="button" class="btn btn-box-tool dashclosewidget">
                    <img src="../../../Whizible2.0-new/dist/img/close-gray.svg" width="16" alt="" title="" />
                </button>
                <div class="widgetheader">
                    <h4><%= MyBase.GetResourceString("C_Widget_categorytitle") %></h4>
                </div>
                <div class="row" id="DivWigdetDetails">
                </div>
            </div>
        </div>
        <div class="tab-content" id="divalltabs">
            <!--Start Project pulse tab from here-->
            <div id="projectpulse" class="tab-pane active">
                <div class="col-sm-12 form-inline pt-1 pb-1 boxsubheader">
                    <div class="form-group">
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboFinacialYear", "Select 0,''",,, "class='form-control ' onchange='GetWeekList(this.value,this)'",,, ) %>
                    </div>
                    <div class="form-group week-slt-dropdown">
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboFinacialWeek", "Select 0,''",,, "class='form-control week-slt-box' onchange='FinancialWeek_onChange(this)'",,, ) %>
                    </div>

                    <div class="form-group">
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectDashbaord", "Select 0,''",,, "onchange='Project_onChange(this)' class='form-control '",,, ) %>
                    </div>
                    <div class="form-group" id="divAccessRoleLevelWise" style="display: none">
                        <%--<a href="javascript:;" class="btn borderbtn"><%=MyBase.GetResourceString("C_MyPulse")%></a>--%>
                        <a href="javascript:;" class="btn borderbtn" onclick="MyPluseonclick(1)"><span id="spnMyPluse"><%=MyBase.GetResourceString("C_MyPulse")%></span></a>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="row-eq-height" id="Div_1_Graphs">
                </div>
            </div>
            <!--End Project pulse tab here-->
            <!--Start Matrix tab panel from here-->
            <div id="Metrics" class="tab-pane">
                <div class="col-sm-12 form-inline pt-1 pb-1 boxsubheader">
                    <div class="form-group">
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboMetricFinacialYear", "Select ''",,, "class='form-control ' onchange='GetWeekList(this.value,this)'",,, ) %>
                    </div>

                    <div class="form-group week-slt-dropdown">
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboMetricFinacialWeek", "Select ''",,, "class='form-control week-slt-box' onchange='FinancialWeek_onChange(this)'",,, ) %>
                    </div>
                    <div class="form-group slt-proj-dropdown">
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectMetricDashbaord", "Select ''",,, "onchange='Project_onChange(this)' class='form-control '",,, ) %>
                    </div>
                </div>
                <div class="row-eq-height" id="Div_2_Graphs">
                </div>
                <!--End Matrix tab panel from here-->
            </div>

            <!-------start Commercials tab panel here------>
            <div id="Commercials" class="tab-pane">
                <div class="col-sm-12 form-inline pt-1 pb-1 boxsubheader">
                    <div class="form-group">
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboCommercialFinacialYear", "Select ''",,, "class='form-control ' onchange='GetWeekList(this.value,this)'",,, ) %>
                    </div>
                    <div class="form-group week-slt-dropdown">
                        <% CommonFunctions.HTMLControls.DrawComboBox("CboCommercialFinacialWeek", "Select ''",,, "class='form-control week-slt-box' onchange='FinancialWeek_onChange(this)'",,, ) %>
                    </div>
                    <div class="form-group slt-proj-dropdown">
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectCommercialDashbaord", "Select ''",,, "onchange='Project_onChange(this)' class='form-control '",,, ) %>
                    </div>
                </div>
                <div class="" id="Div_3_Graphs">
                </div>
            </div>
            <!-------End Commercials tab panel here------>
            <div class="clearfix"></div>
        </div>
        <div id="NoDataDiv" class="tab-pane" style="height: 448px; display: none">
            <div style="text-align: center" class="box box-solid nodata">
                <p><%=MyBase.GetResourceString("C_GraphNotAccess")%></p>
            </div>
        </div>
        <div id="NoAceess" class="tab-pane" style="height: 448px; display: none">
            <div style="text-align: center" class="box box-solid nodata">
                <p><%=MyBase.GetResourceString("C_AuthToView")%></p>
            </div>
        </div>
    </div>
    <!-- /.wrapper -->
    <!-- REQUIRED JS SCRIPTS -->

    
   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.funnel.bundled.js"></script>
    <%--<script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>

        //Widget script
        $(".widgetcategory_Action").on('click', '.unselectwidget', function () {
            $(this).closest('.widgetcatbox').toggleClass('');
            $(this).closest('.widgetcatbox').removeClass('selected');
        });

        //script added for select widget
        $(".widgetcategory_Action .selectwidget").click(function () {
            $(this).closest('.widgetcatbox').toggleClass('selected');
        });

        //active widget button stytle
        $("button[data-bs-target='#dashwidget']").click(function () {
            $(this).toggleClass("dashwidgetactive");
        });
        $(".dashclosewidget").click(function () {
            $(".widget_category_panel").removeClass("show");

        });

    </script>

    <script>

        //Added By Dipali V On 2nd Dec 2019 For Role Wise Tab
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        var selectedRoleID = '<%= Session("intPostID") %>';
        var selectedProjectID = '<%= Session("intProjectID") %>';
        var SelectedTab = "";
        var ArrayAccessibleDivID = new Array();
        var IsMyPluse = 0;//Added By Dipali V On 15th Jan 2020 For LevelWise Graph Plotting
        $(document).ready(function () {
            //script modified by pradip - 07-12-2019
            StartLoader("#bdyProjectDashboard");
            $('#divalltabs').mouseover(function () {
                $(this).find('button').removeAttr('title');
                $(this).find('select').removeAttr('title');
                $(this).find('.selectpicker').removeAttr('title');
            });
           <%-- <%If m_ViewAccess = False Then %>
            $("#divalltabs").hide();
            $("#NoDataDiv").hide();
            $("#NoAceess").show();
            <%Else%>--%>
            $("#divalltabs").show();
            $("#NoDataDiv").hide();
            $("#NoAceess").hide();
            //$("#divAccessRoleLevelWise").show();
            GetYearList();
            GetTabAccess();
            cboId = ["cboProjectMetricDashbaord", "cboProjectDashbaord", "cboProjectCommercialDashbaord"]

            $(".widgetcategory_Action").on('click', '.unselectwidget', function () {
                $(this).closest('.widgetcatbox').toggleClass('');
                $(this).closest('.widgetcatbox').removeClass('selected');
            });
            //script added for select widget
            $(".widgetcategory_Action .selectwidget").click(function () {
                $(this).closest('.widgetcatbox').toggleClass('selected');
            });
           <%-- <%End if%>--%>

            $('[data-bs-toggle="tooltip"]').tooltip();
            clearTooltip();
            StopAjaxLoader("#bdyProjectDashboard");
        });

        var RoleLevel = "";
        var TabID = "";
        var IsData = 0;

        //function getRecentCreatedProject() {

        //}

        function GetTabAccess() {
            ArrayAccessibleDivID = [];
            var ProjectDashBaord = {
                RoleID: '<%= Session("intPostID") %>'
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/ProjectDashboard/GetProjectTabeAccess',
                type: 'POST',
                data: JSON.stringify(ProjectDashBaord),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectDashBaord) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectDashBaord) ? ProjectDashBaord : JSON.stringify(ProjectDashBaord)));
                    }
                },
                success: function (result) {
                    $("#ulProjectaccssibletabs").html("");
                    var TabstrHtml = "";
                    var CurrentTabId = "";

                    for (var i = 0; i < result.length; i++) {
                        IsData = 1;
                        var Description = result[i].Description;
                        var DashboardID = result[i].DashboardID;

                        var PageName = "";

                        if (Description == "<%=MyBase.GetResourceString("C_ProjectPulse")%>") {
                            PageName = "projectpulse";
                            RoleLevel = result[i].Level;
                            TabID = 1;
                        }
                        else if (Description == "<%=MyBase.GetResourceString("C_Metrics")%>") {
                            PageName = Description;
                            TabID = 2;
                        }
                        else if (Description == "<%=MyBase.GetResourceString("C_Commercials")%>") {
                            PageName = Description;
                            TabID = 3;
                        }
                        if (i == 0) {
                            CurrentTabId = TabID;
                            TabstrHtml += '<li><a href="#' + PageName + '" class="active" data-bs-toggle="tab" aria-controls="projectpulse" role="tab" onclick="getTabWiseWidget(' + TabID + ')">' + Description + '</a></li>';
                        } else {
                            TabstrHtml += '<li class=""><a href="#' + PageName + '" data-bs-toggle="tab" aria-controls="projectpulse" role="tab" onclick="getTabWiseWidget(' + TabID + ')">' + Description + '</a></li>';
                        }
                    }
                    if (IsData == 1) {
                        TabstrHtml += '<li class="float-end" style="margin-left:auto"><button data-bs-toggle="collapse" data-bs-target="#dashwidget" class="btn borderbtn float-end"><%=MyBase.GetResourceString("C_btnWidget")%></button></li>';
                        //TabstrHtml += '<li class="float-end"><button data-bs-toggle="collapse" id="btnWidget" data-bs-target="#dashwidget" class="btn borderbtn float-end"><%=MyBase.GetResourceString("C_btnWidget")%></button></li>';
                    }
                    if (RoleLevel != 3) {
                        IsMyPluse = 0;
                        $("#divAccessRoleLevelWise").show();
                    }
                    else {
                        IsMyPluse = 1;
                    }
                    $("#ulProjectaccssibletabs").html(TabstrHtml);
                    getTabWiseWidget(CurrentTabId);
                    if (IsData == 0) {
                        $("#divalltabs").hide();
                        $("#NoDataDiv").show();
                    } else {
                        $("#divalltabs").show();
                        $("#NoDataDiv").hide();
                    }
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    $(".widgetcategory_Action").on('click', '.unselectwidget', function () {
                        $(this).closest('.widgetcatbox').toggleClass('');
                        $(this).closest('.widgetcatbox').removeClass('selected');
                    });

                    //script added for select widget
                    $(".widgetcategory_Action .selectwidget").click(function () {
                        $(this).closest('.widgetcatbox').toggleClass('selected');
                    });

                    if (CurrentTabId == 1) {
                        ProjectControlID = "cboProjectDashbaord";
                    }
                    else if (CurrentTabId == 2) {
                        ProjectControlID = "cboProjectMetricDashbaord";
                    }
                    else if (CurrentTabId == 3) {
                        ProjectControlID = "cboProjectCommercialDashbaord";
                    }

                    //GetProjectList(ProjectControlID);
                    //GetAllGraphs();
                }
            });
        }
        //End of Added By Dipali V On 2nd Dec 2019 For Role Wise Tab 

        function GetProjectList(ControlID) {

            StartLoader("#bdyProjectDashboard");
            var sessionproj = 0;
            sessionproj = selectedProjectID;
            if (selectedProjectID == "") {
                sessionproj = 0;
            }
            var ProjectDashBaord = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                ProjectID: encodeURI(sessionproj),
                LoginType: encodeURI('<%= Session("LoginType") %>'),
                ControlID: encodeURI(ControlID),
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/ProjectDashboard/GetProjectList',
                method: 'Post',
                data: JSON.stringify(ProjectDashBaord),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectDashBaord) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectDashBaord) ? ProjectDashBaord : JSON.stringify(ProjectDashBaord)));
                    }
                },
                success: function (strResult) {
                    var LatestProject = 0;
                    if (strResult != "") {
                        var objCbo1 = document.getElementById(ControlID);
                        $("#" + ControlID + " option").remove();
                        for (var i = 0; i < strResult.length; i++) {
                            var Objresult = strResult[i];
                            var objOption = document.createElement("OPTION");
                            if (objOption != null) {
                                objCbo1.options.add(objOption);
                            }
                            objOption.value = Objresult.ProjectID;
                            objOption.text = Objresult.ProjectName == 0 ? '' : Objresult.ProjectName;
                            if (strResult[i].flag == "1" && LatestProject == 0) {
                                LatestProject = strResult[i].ProjectID;
                            }
                        }

                        if (ControlID == 'CboProject_34_1' || ControlID == 'CboProject_33_1' || ControlID == 'CboProject_3_3' || ControlID == 'CboProject_20_1' || ControlID == 'CboProject_22_1' || ControlID == 'CboProject_27_1' || ControlID == 'CboProject_28_1' || ControlID == 'CboProject_31_1' || ControlID == 'CboProject_32_1' || ControlID == 'CboProject_35_1' || ControlID == 'CboProject_36_1') {
                            if (selectedProjectID == "") {
                                $("#" + ControlID).val(LatestProject);
                            }
                            else {
                                $("#" + ControlID).val(sessionproj); //FOR THE SESSION PROJECT ID AS DEFAULT
                            }
                        }
                        else {
                            $("#" + ControlID).val(0); //DEFAULT "SELECT PROJECT" FOR REMAINING
                        }
                    }
                    $("#DivProject button[data-id='cboProjectDashbaord']").tooltip({ placement: 'bottom' });
                    $('select option')
                        .filter(function () {
                            return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                        })
                        .remove();

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            StopAjaxLoader("#bdyProjectDashboard");
        }

        function GetYearList() {
            StartLoader("#bdyProjectDashboard");
            $.ajax({
                url: encodeURI(strUrl) + '/api/ProjectDashboard/GetYearList',
                method: 'Post',
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                     
                },
                success: function (result) {
                    if (result != "") {
                        var objCbo1 = document.getElementById("CboFinacialYear");
                        $("#CboFinacialYear option").remove();
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption, 0);

                        var objCboMY = document.getElementById("CboMetricFinacialYear");
                        $("#CboMetricFinacialYear option").remove();
                        var objOptionMY = document.createElement("OPTION");
                        objCboMY.options.add(objOptionMY, 0);

                        var objCboCY = document.getElementById("CboCommercialFinacialYear");
                        $("#CboCommercialFinacialYear option").remove();
                        var objOptionCY = document.createElement("OPTION");
                        objCboCY.options.add(objOptionCY, 0);

                        for (var i = 0; i < result.length; i++) {
                            var Objresult = result[i];
                            if (result[i].IsCurrentFY == true) {
                                currentfy = i;//result[i].FinancialYearID
                            }
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.selectedIndex = i;
                            objOption.value = Objresult.FinancialYearID;
                            objOption.text = Objresult.Title;
                            var objOptionMY = document.createElement("OPTION");
                            objCboMY.options.add(objOptionMY);
                            objOptionMY.selectedIndex = i;
                            objOptionMY.value = Objresult.FinancialYearID;
                            objOptionMY.text = Objresult.Title;
                            var objOptionCY = document.createElement("OPTION");
                            objCboCY.options.add(objOptionCY);
                            objOptionCY.selectedIndex = i;
                            objOptionCY.value = Objresult.FinancialYearID;
                            objOptionCY.text = Objresult.Title;
                        }
                    }

                    $("#DivProject button[data-id='CboFinacialYear']").tooltip({ placement: 'bottom' });
                    $('select option')
                        .filter(function () {
                            return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                        })
                        .remove();

                    objCbo1.selectedIndex = currentfy;
                    objCboMY.selectedIndex = currentfy;
                    objCboCY.selectedIndex = currentfy;

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            StopAjaxLoader("#bdyProjectDashboard");
        }
        //Added by Swapnagandha k.

        function GetWeekList(objValue, obj)
        {
            var k = {
                FinancialYearID: objValue 
            }
            var param = JSON.stringify(k)

            $.ajax({
                url: encodeURI(strUrl) + '/api/ProjectDashboard/GetWeekList',
                method: 'Post',
                data: param,
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
                    var objID = obj.id;
                    if (objID == "CboFinacialYear") {
                        var objCbo1 = document.getElementById("CboFinacialWeek");
                        $("#CboFinacialWeek option").remove();
                    }
                    else if (objID == "CboMetricFinacialYear") {
                        var objCbo1 = document.getElementById("CboMetricFinacialWeek");
                        $("#CboMetricFinacialWeek option").remove();
                    }
                    else {
                        var objCbo1 = document.getElementById("CboCommercialFinacialWeek");
                        $("#CboCommercialFinacialWeek option").remove();
                    }
                    var objOption = document.createElement("OPTION");

                    var weekvalue = 0;
                    if (result != "") {
                        //Added By Nilesh on 11-01-2020
                        objCbo1.options.add(objOption, 0);
                        objCbo1.selectedIndex = 0;
                        objOption.value = "0";
                        objOption.text = "<%=MyBase.GetResourceString("C_SelectWeek")%>";
                        //End By Nilesh on 11-01-2020

                        for (var i = 0; i < result.length; i++) {

                            var Objresult = result[i];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            if (i == 0) {
                                //Commented By Nilesh Pingale on 13-01-2020
                                //weekvalue = Objresult.WeekNo;

                                //Added By Nilesh Pingale on 13-01-2020
                                weekvalue = Objresult.OrderNumber;
                            }
                            objOption.selectedIndex = i + 1;
                            //Commented By Nilesh Pingale on 13-01-2020
                            //objOption.value = Objresult.WeekNo;

                            //Added By Nilesh Pingale on 13-01-2020
                            objOption.value = Objresult.OrderNumber;
                            objOption.text = Objresult.WeekNo;
                        }
                        //Added By Nilesh to keep first record as selected on 11-01-2020
                        objCbo1.selectedIndex = 1;
                        //End By Nilesh to keep first record as selected on 11-01-2020

                    }
                    else {
                        objCbo1.options.add(objOption, 0);
                        objOption.value = "0";
                        objOption.text = "<%=MyBase.GetResourceString("C_SelectWeek")%>";
                        objCbo1.selectedIndex = 0;
                        weekvalue = 0;
                    }
                    $(".selectpicker").selectpicker('refresh');

                    //Commented By Nilesh Pingale on 14-01-2020
                    //$('.clsCboWeek').each(function (i, obj) {
                    //    $('#' + obj.id + '').html($('#CboFinacialWeek').html());
                    //    $('#' + obj.id + '').val(weekvalue);
                    //});

                    //Added By Nilesh Pingale on 14-1-2020
                    if (objID == "CboFinacialYear") {
                        $('.clsCboWeek').each(function (i, obj) {
                            $('#' + obj.id + '').html($('#CboFinacialWeek').html());
                            $('#' + obj.id + '').val(weekvalue);
                            $('#' + obj.id + '').trigger('change');
                        });
                    }
                    else if (objID == "CboMetricFinacialYear") {
                        $('.clsCboWeek').each(function (i, obj) {
                            $('#' + obj.id + '').html($('#CboMetricFinacialWeek').html());
                            $('#' + obj.id + '').val(weekvalue);
                            $('#' + obj.id + '').trigger('change');
                        });
                    }
                    else {
                        $('.clsCboWeek').each(function (i, obj) {
                            $('#' + obj.id + '').html($('#CboCommercialFinacialWeek').html());
                            $('#' + obj.id + '').val(weekvalue);
                            $('#' + obj.id + '').trigger('change');
                        });
                    }
                    //End By Nilesh Pingale on 14-1-2020

                },
                error: function (err) {
                    window.location.href = "../../Gexneral/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }
        //End Added by Swapnagandha k.
        var ProjectControlID = "";

        function getTabWiseWidget(TabID) {
            StartLoader("#bdyProjectDashboard");
            SelectedTab = TabID;
            var ProjectDashBaord = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                WhichTab: SelectedTab,
                IsMyPluse: IsMyPluse
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/ProjectDashboard/GetTabWidgetDetails',
                method: 'Post',
                data: JSON.stringify(ProjectDashBaord),
                dataType: 'json',
                async: true,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectDashBaord) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectDashBaord) ? ProjectDashBaord : JSON.stringify(ProjectDashBaord)));
                    }
                },
                success: function (result) {
                    if (result != "") {
                        $("#DivWigdetDetails").html("");

                        var WidgetDetails = "";
                        var Description = "";
                        for (var i = 0; i < result.length; i++) {
                            WidgetDetails += '<div class="col-sm-3 divclass" id=' + result[i].WID + '>'

                            if (result[i].Isaccssible == 1) {
                                WidgetDetails += ' <div class="widgetcatbox selected" id=' + result[i].WID + '>'
                            }
                            else {
                                WidgetDetails += ' <div class="widgetcatbox">'
                            }

                            if (result[i].Widget_Name.length < 20) {
                                WidgetDetails += ' <div class="widgetcat_title" data-bs-toggle="tooltip"  data-bs-container="body" title="' + result[i].Widget_Name + '">' + result[i].Widget_Name + '</div>'
                            }
                            else {
                                var str = result[i].Widget_Name.substring(0, 20);
                                WidgetDetails += ' <div class="widgetcat_title" data-bs-toggle="tooltip"  data-bs-container="body" title="' + result[i].Widget_Name + '">' + str + '...</div>'
                            }
                            if (result[i].Widget_Description.length < 20) {
                                WidgetDetails += ' <p><em data-bs-toggle="tooltip"  data-bs-container="body" title="' + result[i].Widget_Description + '">' + result[i].Widget_Description + '</em></p>'
                            }
                            else {
                                var str = result[i].Widget_Description.substring(0, 20);
                                WidgetDetails += ' <p><em data-bs-toggle="tooltip"  data-bs-container="body" title="' + result[i].Widget_Description + '">' + str + '....</em></p>'
                            }
                            WidgetDetails += '<div class="widgetcategory_Action ">'


                            if (result[i].Isaccssible == 1) {
                                WidgetDetails += '<span class="unselectwidget"><i class="fas fa-times" onclick="Makeselected(0,' + result[i].WID + ',1)"  data-bs-toggle="tooltip"  data-bs-container="body" title="<%=MyBase.GetResourceString("C_Applied")%>"></i></span>'
                                WidgetDetails += '<span class="selectwidget"><i class="fas fa-check" onclick="Makeselected(1,' + result[i].WID + ',1)" data-bs-toggle="tooltip"  data-bs-container="body" title="<%=MyBase.GetResourceString("C_Apply")%>"></i></span>'
                            }
                            else {
                                WidgetDetails += '<span class="selectwidget"><i class="fas fa-check" onclick="Makeselected(1,' + result[i].WID + ',1)" data-bs-toggle="tooltip"  data-bs-container="body" title="<%=MyBase.GetResourceString("C_Apply")%>"></i></span>'
                                WidgetDetails += '<span class="unselectwidget"><i class="fas fa-times" onclick="Makeselected(0,' + result[i].WID + ',1)" data-bs-toggle="tooltip"  data-bs-container="body" title="<%=MyBase.GetResourceString("C_Applied")%>"></i></span>'
                            }

                            WidgetDetails += '</div>'

                            WidgetDetails += '</div>'
                            WidgetDetails += '</div>'
                        }

                        $("#DivWigdetDetails").html(WidgetDetails);
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $(".widgetcategory_Action").on('click', '.unselectwidget', function () {
                            $(this).closest('.widgetcatbox').toggleClass('');
                            $(this).closest('.widgetcatbox').removeClass('selected');
                        });

                        //script added for select widget
                        $(".widgetcategory_Action .selectwidget").click(function () {
                            $(this).closest('.widgetcatbox').toggleClass('selected');
                        });
                        //$(".widget_category_panel").removeClass("in"); //Commented By Nilesh On 14-01-2020

                        if (SelectedTab == 1) {
                            ProjectControlID = "cboProjectDashbaord";
                            //IsMyPluse = 0;//Added By Dipali V On 15th JAn 2020 For Access Level Filter
                        }
                        else if (SelectedTab == 2) {
                            ProjectControlID = "cboProjectMetricDashbaord";
                            //IsMyPluse = 0;//Added By Dipali V On 15th JAn 2020 For Access Level Filter
                        }
                        else if (SelectedTab == 3) {
                            ProjectControlID = "cboProjectCommercialDashbaord";
                            //IsMyPluse = 0;//Added By Dipali V On 15th JAn 2020 For Access Level Filter
                        }
                        GetProjectList(ProjectControlID);
                        //if ($("#btnWidget").attr('aria-expanded') == "false" || $("#btnWidget").attr('aria-expanded') == undefined) {
                        GetAllGraphs();
                        //}
                    }
                }
            })
            StopAjaxLoader("#bdyProjectDashboard");
        }

        function Makeselected(Flag, WID, IsExpand) {
            StartLoader("#bdyProjectDashboard");
            var ProjectDashBaord = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                WID: encodeURI(WID),
                WhichTab: encodeURI(SelectedTab),
                IsEnabledDisabled: encodeURI(Flag),
                UserName: encodeURI('<%= Session("StrUserName") %>'),
                Isaccssible: encodeURI(Flag)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/ProjectDashboard/InsertAccessWiseWidg',
                method: 'Post',
                data: JSON.stringify(ProjectDashBaord),
                dataType: 'json',
                // async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectDashBaord) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectDashBaord) ? ProjectDashBaord : JSON.stringify(ProjectDashBaord)));
                    }
                },
                success: function (result) {
                    if (result != "") {

                        var Msg = "";
                        getTabWiseWidget(SelectedTab);
                        clearTooltip();
                        if (Flag == 0) {
                            Msg = "<%=MyBase.GetResourceString("A_Remove_Sucessfully")%>";
                        } else {
                            Msg = "<%=MyBase.GetResourceString("A_Apply_Sucessfully")%>";
                        }

                        alertify.set('notifier', 'position', 'top-right');
                        setTimeout(function () {
                            alertify.success(Msg);
                        }, 1000);
                        //alertify.notify(Msg, 'success', 5);
                        if (IsExpand == 1)
                            $(".widget_category_panel").addClass("in");
                    }
                }
            });
            ArrayDivID = [];
            ArrayUsedDivID = [];

            StopAjaxLoader("#bdyProjectDashboard");
        }

        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
        }

        var WIDArrayList = [];
        function GetAllGraphs() {
            //alert(IsMyPluse);
            StartLoader("#bdyProjectDashboard");
            ArrayAccessibleDivID = [];
            var ProjectDashBaord = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                WhichTab: SelectedTab,
                IsMyPluse: IsMyPluse//Added By Dipali V On 15th Jan 2020 for LevelWise GraphPlotting
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/ProjectDashboard/GetAllGraphs',
                method: 'Post',
                data: JSON.stringify(ProjectDashBaord),
                dataType: 'json',
                async: true,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectDashBaord) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectDashBaord) ? ProjectDashBaord : JSON.stringify(ProjectDashBaord)));
                    }
                },
                success: function (result) {
                    if (result != "") {
                        $("#Div_" + SelectedTab + "_Graphs").html("");
                        var GraphDetailsHtml = "";
                        var strProjecthtmlNew = "";
                        var strWeekhtmlNew = "";
                        WIDArrayList = [];
                        for (var i = 0; i < result.length; i++) {
                            ArrayAccessibleDivID.push('CboProject_' + result[i].WID + '_' + SelectedTab);
                            if (result[i].DivGraphWidth == 1) {
                                GraphDetailsHtml += '<div class="col-sm-6 mt-1" id="Div_' + SelectedTab + '_' + result[i].WID + '" >';
                            }
                            else {
                                GraphDetailsHtml += '<div class="col-sm-12 mt-1" id="Div_' + SelectedTab + '_' + result[i].WID + '" >';
                            }

                            GraphDetailsHtml += '<div class="box chartbox">';
                            GraphDetailsHtml += '<div class="box-header boxheaderblue with-border">';
                            if (result[i].DivGraphWidth == 1) {
                                if (result[i].Widget_Name.length < 50) {
                                    GraphDetailsHtml += '<h3 class="box-title" data-bs-toggle="tooltip"  data-bs-container="body" title="' + result[i].Widget_Name + '">' + result[i].Widget_Name + '</h3>';
                                } else {
                                    var str = result[i].Widget_Name.substring(0, 50);
                                    GraphDetailsHtml += '<h3 class="box-title" data-bs-toggle="tooltip"  data-bs-container="body" title="' + result[i].Widget_Name + '">' + str + '...</h3>';
                                }
                            }
                            else {
                                if (result[i].Widget_Name.length < 60) {
                                    GraphDetailsHtml += '<h3 class="box-title" data-bs-toggle="tooltip"  data-bs-container="body" title="' + result[i].Widget_Name + '">' + result[i].Widget_Name + '</h3>';
                                } else {
                                    var str = result[i].Widget_Name.substring(0, 60);
                                    GraphDetailsHtml += '<h3 class="box-title" data-bs-toggle="tooltip"  data-bs-container="body" title="' + result[i].Widget_Name + '">' + str + '...</h3>';
                                }
                            }
                            GraphDetailsHtml += '<button type="button" class="btn btn-box-tool boxclosebtn float-end"><i class="fa fa-times" onclick="Makeselected(0, ' + result[i].WID + ',0)" data-bs-toggle="tooltip"  data-bs-container="body" title="Remove"></i></button>';
                            GraphDetailsHtml += '</div>';
                            if (result[i].DivGraphWidth == 1) {
                                GraphDetailsHtml += '<div class="box-tools">';
                            }
                            else {
                                //GraphDetailsHtml += '<div class="box-tools col-sm-6">';
                                GraphDetailsHtml += '<div class="box-tools">'; //Edit by Omkar T on 09-01-20
                            }

                            strProjecthtmlNew = '<%=CommonFunctions.HTMLControls.DrawComboBox("CboProject_FieldName_SelectedTab", "Select 0,''", , , "class=""clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                            //strProjecthtmlNew = strProjecthtmlNew.replace('All Projects', '<%=MyBase.GetResourceString("C_SelectProject")%>');

                            strProjecthtmlNew = strProjecthtmlNew.replace(/FieldName/g, result[i].WID);
                            strProjecthtmlNew = strProjecthtmlNew.replace(/SelectedTab/g, SelectedTab);
                            GraphDetailsHtml += strProjecthtmlNew;

                            strWeekhtmlNew = '<%=CommonFunctions.HTMLControls.DrawComboBox("CboWeek_FieldName_SelectedTab", "select 0,'Select Week'", , , "class=""clsMandatoryFields clsCboWeek"" ", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                            strWeekhtmlNew = strWeekhtmlNew.replace('Select Week', '<%=MyBase.GetResourceString("C_SelectWeek")%>');
                            strWeekhtmlNew = strWeekhtmlNew.replace(/FieldName/g, result[i].WID);
                            strWeekhtmlNew = strWeekhtmlNew.replace(/SelectedTab/g, SelectedTab);
                            //if (result[i].WID != 4 && result[i].WID != 5 && result[i].WID != 6 && result[i].WID != 7 && result[i].WID != 10 && result[i].WID != 8 && result[i].WID != 9 && result[i].WID != 11) {
                            //    GraphDetailsHtml += strWeekhtmlNew;
                            //}
                            GraphDetailsHtml += strWeekhtmlNew;

                            GraphDetailsHtml += '</div>';
                            GraphDetailsHtml += '<div class="box-body" id="CanvasHolder_' + SelectedTab + '_' + result[i].WID + '">';
                            //if (result[i].WID == 15 || result[i].WID == 16) {
                            // GraphDetailsHtml += '<canvas id="DivGraph_' + SelectedTab + '_' + result[i].WID + '" height="100"></canvas>';
                            GraphDetailsHtml += '<canvas id="CanvasDashBoard_' + SelectedTab + '_' + result[i].WID + '" height="400"></canvas>';

                            //}
                            //else {
                            //     GraphDetailsHtml += '<canvas id="DivGraph_' + SelectedTab + '_' + result[i].WID + '" height="100"></canvas>';
                            //}
                            WIDArrayList.push(result[i].WID);
                            GraphDetailsHtml += '</div>';
                            GraphDetailsHtml += '</div>';
                            GraphDetailsHtml += '<div class="clearfix"></div>';
                            GraphDetailsHtml += '</div>';
                        }

                        $("#Div_" + SelectedTab + "_Graphs").html(GraphDetailsHtml);
                        if (SelectedTab == 1) { $("#CboFinacialYear").trigger('change'); }
                        else if (SelectedTab == 2) { $("#CboMetricFinacialYear").trigger('change'); }
                        else if (SelectedTab == 3) { $("#CboCommercialFinacialYear").trigger('change'); }

                        for (i = 0; i < ArrayAccessibleDivID.length; i++) {
                            GetProjectList(ArrayAccessibleDivID[i]);
                        }

                        for (var i = 0; i < WIDArrayList.length; i++) {

                            var DashboardID = "CanvasDashBoard_" + SelectedTab + "_" + WIDArrayList[i] + "";

                            if (WIDArrayList[i] == 1) {//FOR COMMERCIAL
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getMilestoneRevenueForecast('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getMilestoneRevenueForecast('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getMilestoneRevenueForecast(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 2) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getRevenueRecognizationAndRealizationTrend('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')");
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getRevenueRecognizationAndRealizationTrend('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')");
                                getRevenueRecognizationAndRealizationTrend(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 3) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectCompletionAndPaymentPercentage('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectCompletionAndPaymentPercentage('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getProjectCompletionAndPaymentPercentage(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse")
                            }
                            else if (WIDArrayList[i] == 4) { //FOR METRICS STARTED
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectSceduleVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'SVPercentAsOnDate')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectSceduleVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'SVPercentAsOnDate')")
                                getProjectSceduleVarienceGraph(DashboardID, SelectedTab, WIDArrayList[i], "SVPercentAsOnDate");
                            }
                            else if (WIDArrayList[i] == 5) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectSceduleVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'SVPercentWeek')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectSceduleVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'SVPercentWeek')")
                                getProjectSceduleVarienceGraph(DashboardID, SelectedTab, WIDArrayList[i], "SVPercentWeek");
                            }
                            else if (WIDArrayList[i] == 6) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectSPIGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'SPIAsOnDate')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectSPIGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'SPIAsOnDate')")
                                getProjectSPIGraph(DashboardID, SelectedTab, WIDArrayList[i], "SPIAsOnDate");
                            }
                            else if (WIDArrayList[i] == 7) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectSPIGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'SPIWeek')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectSPIGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'SPIWeek')")
                                getProjectSPIGraph(DashboardID, SelectedTab, WIDArrayList[i], "SPIWeek");
                            }
                            else if (WIDArrayList[i] == 8) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectEffortVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'EffortVarianceProjectLevel')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectEffortVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'EffortVarianceProjectLevel')")
                                getProjectEffortVarienceGraph(DashboardID, SelectedTab, WIDArrayList[i], "EffortVarianceProjectLevel")
                            }
                            else if (WIDArrayList[i] == 9) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectEffortVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'EffortVarianceWeek')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectEffortVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'EffortVarianceWeek')")
                                getProjectEffortVarienceGraph(DashboardID, SelectedTab, WIDArrayList[i], "EffortVarianceWeek")
                            }
                            else if (WIDArrayList[i] == 10) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectCostVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'CVPercentAsOnDate')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectCostVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'CVPercentAsOnDate')")
                                getProjectCostVarienceGraph(DashboardID, SelectedTab, WIDArrayList[i], "CVPercentAsOnDate");
                            }
                            else if (WIDArrayList[i] == 11) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectCostVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'CVPercentWeek')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectCostVarienceGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'CVPercentWeek')")
                                getProjectCostVarienceGraph(DashboardID, SelectedTab, WIDArrayList[i], "CVPercentWeek");
                            }
                            else if (WIDArrayList[i] == 12) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getRiskMatrix('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getRiskMatrix('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getRiskMatrix(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 13) {//FOR PROJECT PULSE STARTED
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectOverViewGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')");
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectOverViewGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getProjectOverViewGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 14) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectOverViewGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectOverViewGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getProjectOverViewGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 15) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOnTrackOverdueGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOnTrackOverdueGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getTaskOnTrackOverdueGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 16) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOnTrackOverdueGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOnTrackOverdueGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getTaskOnTrackOverdueGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 17) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOpenInprogressCloseGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOpenInprogressCloseGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getTaskOpenInprogressCloseGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 18) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOpenInprogressCloseGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOpenInprogressCloseGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getTaskOpenInprogressCloseGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 19) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverDueByResource('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverDueByResource('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getTaskOverDueByResource(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 20) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverDueByResource('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverDueByResource('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getTaskOverDueByResource(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 21) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverDueByDays('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverDueByDays('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getTaskOverDueByDays(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse")
                            }
                            else if (WIDArrayList[i] == 22) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverDueByDays('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverDueByDays('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getTaskOverDueByDays(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse")
                            }
                            else if (WIDArrayList[i] == 23) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTasksFunnelGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTasksFunnelGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getTasksFunnelGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 24) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTasksFunnelGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTasksFunnelGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getTasksFunnelGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 25) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverAging('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverAging('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getTaskOverAging(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 26) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverAging('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskOverAging('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getTaskOverAging(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 27) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskStatusByProject('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskStatusByProject('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getTaskStatusByProject(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 28) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskStatusByProject('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getTaskStatusByProject('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getTaskStatusByProject(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 29) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getOverDueTaskByPriorityGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getOverDueTaskByPriorityGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getOverDueTaskByPriorityGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 30) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getOverDueTaskByPriorityGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getOverDueTaskByPriorityGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getOverDueTaskByPriorityGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 31) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getEffortStatusGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getEffortStatusGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getEffortStatusGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 32) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getEffortStatusGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getEffortStatusGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getEffortStatusGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 33) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectTimeAndCostGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectTimeAndCostGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getProjectTimeAndCostGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 34) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectTimeAndCostGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getProjectTimeAndCostGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getProjectTimeAndCostGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 35) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getIssueStatusGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getIssueStatusGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getIssueStatusGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 36) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getIssueStatusGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getIssueStatusGraph('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getIssueStatusGraph(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            else if (WIDArrayList[i] == 37) {//SAME AS METRIX
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getRiskMatrix('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getRiskMatrix('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackMyPulse')")
                                getRiskMatrix(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackMyPulse");
                            }
                            else if (WIDArrayList[i] == 38) {
                                $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getRiskMatrix('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                $("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getRiskMatrix('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'ProjectTrackAllPulse')")
                                getRiskMatrix(DashboardID, SelectedTab, WIDArrayList[i], "ProjectTrackAllPulse");
                            }
                            //else if (WIDArrayList[i] == 37) {
                            //    getDefectDensity(DashboardID, SelectedTab, WIDArrayList[i], "DefectDensityProjectLevel");
                            //    $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getDefectDensity('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'DefectDensityProjectLevel')")
                            //    //$("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getDefectDensity('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'DefectDensityProjectLevel')")
                            //}
                            //else if (WIDArrayList[i] == 38) {
                            //    getDefectDensityWBSLevel(DashboardID, SelectedTab, WIDArrayList[i], "DefectDensityWBSLevel");
                            //    $("#CboProject_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getDefectDensityWBSLevel('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'DefectDensityWBSLevel')")
                            //    //$("#CboWeek_" + WIDArrayList[i] + "_" + SelectedTab + "").attr("onchange", "getDefectDensityWBSLevel('" + DashboardID + "', " + SelectedTab + "," + WIDArrayList[i] + ", 'DefectDensityWBSLevel')")
                            //}
                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $(".widgetcategory_Action").on('click', '.unselectwidget', function () {
                            $(this).closest('.widgetcatbox').toggleClass('');
                            $(this).closest('.widgetcatbox').removeClass('selected');
                        });

                        //script added for select widget
                        $(".widgetcategory_Action .selectwidget").click(function () {
                            $(this).closest('.widgetcatbox').toggleClass('selected');
                        });
                        //$(".widget_category_panel").removeClass("in"); //Commented By Nilesh On 14-01-2020

                    }
                    else {
                        $("#Div_" + SelectedTab + "_Graphs").html("");
                    }
                    $('[data-bs-toggle="tooltip"]').tooltip();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }

            });
            StopAjaxLoader("#bdyProjectDashboard");
        }

        function GetParameters(SelectedTab, SelectedDash, Command) {
            var ProjectID = $("#CboProject_" + SelectedDash + "_" + SelectedTab + " :selected").val();

            var YearID = $("#CboFinacialYear :selected").val();//.text().split("-")[0];
            //if (SelectedDash == 8) {
            //    var WeekNo = 0;
            //}
            //else {
            var WeekNo = $("#CboWeek_" + SelectedDash + "_" + SelectedTab + " :selected").val();//.split("-")[1];

            //}
            
            var GraphData = {
                ProjectID: ProjectID,
                YearID: YearID,
                WeekNo: WeekNo,
                Command: Command,
                EmployeeID: '<%= Session("intUserID") %>'
            };
            return GraphData;
        }

        function GetVarienceParameters(SelectedTab, SelectedDash, Command) {
            var ProjectID = $("#CboProject_" + SelectedDash + "_" + SelectedTab + " :selected").val();
            var YearID = $("#CboFinacialYear :selected").val();
            var WeekNo = $("#CboWeek_" + SelectedDash + "_" + SelectedTab + " :selected").val();//.split("-")[1];

            var GraphData = {
                ProjectID: ProjectID,
                YearID: YearID,
                WeekNo: WeekNo,
                Command: Command,
                EmployeeID: '<%= Session("intUserID") %>'
            };
            return GraphData;
        }

        function getProjectOverViewGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var ProjectID = $("#CboProject_" + SelectedDash + "_" + SelectedTab + " :selected").val();
            var YearID = $("#CboFinacialYear :selected").val();
            var WeekNo = $("#CboWeek_" + SelectedDash + "_" + SelectedTab + " :selected").val();//.split("-")[1];

            var GraphData = {
                ProjectID: ProjectID,
                YearID: YearID,
                WeekNo: WeekNo,
                Command: Command,
                EmployeeID: '<%= Session("intUserID") %>'
            };
            var arrData = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/GetProjectOverviewGraph", param, false);
            if (result != undefined && result != 0) {
                if (result[0].ack == "success") {
                    for (var i = 0; i < result.length; i++) {
                        arrData.push(result[i].OnTrack);
                        arrData.push(result[i].OffTrack);
                    }
                    $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                    $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                    var GraphLabels = ["On Track", "Off Track"];
                    piaGraph(DashboardID, arrData, GraphLabels);
                }
                else if (result[0].ack == "NoGraph") {
                    ifDataNotPresent(DashboardID, arrData);
                }
                else {
                    //Commented by Nilesh to keep graph specific alert on 11-Jan-2020
                    //ifDataNotPresent(DashboardID, arrData);
                    //Added by Nilesh to keep graph specific alert on 11-Jan-2020
                    if (arrData.length == 0) {
                        var ParentDiv = $("#" + DashboardID + "").parent().attr("id");
                        $("#" + ParentDiv + "").html("<h5><center><strong><%=MyBase.GetResourceString("C_NoTaskAssigned")%></strong></center></h5>");
                        $("#" + ParentDiv + "").css("text-align", "Center");
                    }
                    //End by Nilesh to keep graph specific alert on 11-Jan-2020
                }
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }

        function getTaskOnTrackOverdueGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/GetTaskOnTrackOverdueGraph", param, false);
            if (result != undefined && result != 0) {
                if (result[0].IsGraph1 == "Y") {
                    for (var i = 0; i < result.length; i++) {
                        arrData.push(result[i].OnTrack);
                        arrData.push(result[i].OverDue);
                    }
                    $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                    $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                    var GraphLabels = ["On Track", "Overdue"];
                    piaGraph(DashboardID, arrData, GraphLabels);
                } else {
                    ifDataNotPresent(DashboardID, arrData);
                }
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }

        function getTaskOpenInprogressCloseGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/GetTaskOnTrackOverdueGraph", param, false);
            if (result != undefined && result != 0) {
                if (result[0].IsGraph2 == "Y") {
                    for (var i = 0; i < result.length; i++) {
                        arrData.push(result[i].OpenTask);
                        arrData.push(result[i].InProgress);
                        arrData.push(result[i].ClosedTask);
                    }
                    $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                    $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                    var GraphLabels = ["Open", "In Progress", "Closed"];
                    piaGraph(DashboardID, arrData, GraphLabels);
                }
                else {
                    ifDataNotPresent(DashboardID, arrData);
                }
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }

        function getTasksFunnelGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            //LOGIC1
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getTasksFunnelGraph", param, false);
            if (result != undefined && result != 0) {
                for (var i = 0; i < result.length; i++) {
                    arrData.push(result[i].YetToStart.toString());
                    arrData.push(result[i].OnHold.toString());
                    arrData.push(result[i].InProgress.toString());
                    arrData.push(result[i].ClosedTask.toString());
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="170" width="300"></canvas>'); // then load chart. 
                var GraphLabels = ["Yet to Start", "On Hold", "In Progress", "Closed"];
                //arrData = ["0", "200", "300", "400"];
                //arrData = ["15", "0", "22", "2"];                
                FunnelGraph(DashboardID, arrData, GraphLabels);//FunnelGraph
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getOverDueTaskByPriorityGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            //var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/GetOverDueTaskByPriorityGraph", param, false);
            if (result != undefined && result != 0) {
                var arrPriority = [];
                var arrProject = [];
                var arrOverDueCount = [];
                var odsum = 0;
                for (var i = 0; i < result.length; i++) {
                    arrPriority.push(result[i].Priority);
                    arrOverDueCount.push(result[i].OverDueCount);
                    odsum = odsum + result[i].OverDueCount;
                    //GraphLabels.push(result[i].ProjectName);
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="200"></canvas>'); // then load chart. 
                if (odsum != 0) {
                    PriorityStackBarGraph(DashboardID, arrPriority, arrOverDueCount);
                } else {
                    ifDataNotPresent(DashboardID, arrData);
                }
                // PriorityStackBarGraph(DashboardID, arrPriority, arrOverDueCount);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }

        function getEffortStatusGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var arrPNTooltip = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getEffortStatusGraph", param, false);
            if (result != undefined && result != 0) {
                var arrPlannedEfforts = [];
                var arrActualEfforts = [];
                var arrProject = [];
                for (var i = 0; i < result.length; i++) {
                    arrPlannedEfforts.push(result[i].PlannedEffort);
                    arrActualEfforts.push(result[i].ActualEffort);
                    arrProject.push(result[i].ProjectID);
                    GraphLabels.push(result[i].ShortJobTitle);
                    arrPNTooltip.push(result[i].ProjectName);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="200"></canvas>'); // then load chart. 
                BarGraph(DashboardID, GraphLabels, arrPlannedEfforts, arrActualEfforts, arrProject, arrPNTooltip);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }

        function getIssueStatusGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var arrProjectName = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getIssueStatusGraph", param, false);
            if (result != undefined && result != 0) {

                var arrInRate = [];
                var arrOutRate = [];
                var arrOutstanding = [];
                for (var i = 0; i < result.length; i++) {
                    arrInRate.push(result[i].InRate);
                    arrOutRate.push(result[i].OutRate);
                    arrOutstanding.push(result[i].Outstanding);
                    arrProjectName.push(result[i].ProjectName);
                    GraphLabels.push(result[i].ShortJobTitle);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="300"></canvas>'); // then load chart. 
                //IssueStatusLineGraph(DashboardID, GraphLabels, arrInRate, arrOutRate, arrOutstanding);
                BarGraphIssueStatus(DashboardID, GraphLabels, arrInRate, arrOutRate, arrOutstanding, arrProjectName);

            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function BarGraphIssueStatus(DashboardID, GraphLabels, arrInRate, arrOutRate, arrOutstanding, arrPNToolTip) {
            var tooltipsLabel = arrPNToolTip;
            var ctx = document.getElementById("" + DashboardID + "").getContext("2d");
            var data = {
                labels: GraphLabels,
                datasets: [{
                    label: "In Rate",
                    text: "label",
                    backgroundColor: "#ffc000",
                    data: arrInRate
                }, {
                    label: "Out Rate",
                    backgroundColor: "#ed7d31",
                    data: arrOutRate
                }, {
                    label: "Outstanding",
                    backgroundColor: "#42b4ec",
                    data: arrOutstanding
                }]
            };
            var myBarChart = new Chart(ctx, {
                type: 'bar',
                data: data,
                options: {
                    title: {
                        display: true,
                        responsive: true,
                        //text: ''
                    },
                    //barValueSpacing: 20,
                    scales: {
                        xAxes: [{
                            maxBarThickness: 30,
                            barPercentage: 0.2,
                            ticks: {
                                autoSkip: false,
                                maxRotation: 90,
                                minRotation: 90
                            },
                        }],
                        yAxes: [{
                            maxBarThickness: 50,
                            barPercentage: 0.5,
                            ticks: {
                                max: this.max,//100, //max value 100 commented and this.max added by Nilesh Pingale on 13-01-2020
                                min: 0,
                                padding: 20,
                            },
                            //afterBuildTicks: function (pckBarChart) {
                            //    pckBarChart.ticks = pckBarChart.chart.data.datasets[0].data.flatMap(i => [
                            //        10 * (Math.floor(i / 10)), // lower 50
                            //        10 * (Math.ceil(i / 10)) // higer 50
                            //    ])
                            //},
                        },
                        
                        ]
                    },
                    responsive: true,
                    maintainAspectRatio: false,
                    tooltips: {
                        mode: 'single',//'index',
                        intersect: true,
                        callbacks: {
                            title: function (tooltipItem, data) {
                                return tooltipsLabel[tooltipItem[0].index];
                            }
                        }
                    }
                }
            });

        }
        function getProjectTimeAndCostGraph(DashboardID, SelectedTab, SelectedDash, Command) {

            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var arrProjectName = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getProjectTimeAndCostGraph", param, false);
            if (result != undefined && result != 0) {
                var arrPlannedEfforts = [];
                var arrActualEfforts = [];
                var arrPlannedCost = [];
                var arrActualCost = [];
                var arrProject = [];
                for (var i = 0; i < result.length; i++) {
                    arrPlannedEfforts.push(result[i].PlannedEffort);
                    arrActualEfforts.push(result[i].ActualEffort);
                    arrPlannedCost.push(result[i].PlannedCost);
                    arrActualCost.push(result[i].ActualCost);
                    arrProject.push(result[i].ProjectID);
                    GraphLabels.push(result[i].ShortJobTitle);
                    arrProjectName.push(result[i].ProjectName);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="300"></canvas>'); // then load chart. 
                ProjectTimeCostBarGraph(DashboardID, GraphLabels, arrProjectName, arrPlannedEfforts, arrActualEfforts, arrPlannedCost, arrActualCost, arrProject);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }

        }

        function getProjectEffortVarienceGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getProjectEffortVarienceGraph", param, false);
            if (result != undefined && result != 0) {
                var yAxis = [];
                var xAxis = [];
                var arrProject = [];
                for (var i = 0; i < result.length; i++) {
                    arrProject.push(result[i].ProjectID);
                    GraphLabels.push(result[i].ProjectName);
                    yAxis.push(result[i].EffortVariance);
                    xAxis.push(result[i].FWeek);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="300"></canvas>'); // then load chart. 
                if (Command == "EffortVarianceProjectLevel") {
                    //piaGraph(DashboardID, yAxis, xAxis);
                    BarGraphForPercent(DashboardID, arrData, xAxis, yAxis, "Effort Variance");
                }
                else {
                    VarienceGraph(DashboardID, xAxis, yAxis, "Effort Variance");
                }
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getProjectSceduleVarienceGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetVarienceParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getProjectSceduleVarienceGraph", param, false);
            if (result != undefined && result != 0) {
                var xAxis = [];
                var yAxis = [];
                var arrProject = [];
                for (var i = 0; i < result.length; i++) {
                    xAxis.push(result[i].WeekNo);
                    yAxis.push(result[i].SVPercent);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="300"></canvas>'); // then load chart. 
                if (Command == "SVPercentAsOnDate") {
                    //piaGraph(DashboardID, yAxis, xAxis);
                    BarGraphForPercent(DashboardID, arrData, xAxis, yAxis, "Schedule Variance");
                }
                else {
                    ScheduleVarienceGraph(DashboardID, xAxis, yAxis, "SV");
                    //BarGraphOverDue(DashboardID, arrData, GraphLabels, arrOverDue, "Task Overdue");
                    //BarGraphOverDue(DashboardID, arrData, xAxis, yAxis, "Schedule Variance");
                }
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }

        }

        function getProjectSPIGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetVarienceParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getProjectSPIGraph", param, false);
            if (result != undefined && result != 0) {
                var xAxis = [];
                var yAxis = [];
                var arrProject = [];
                for (var i = 0; i < result.length; i++) {
                    xAxis.push(result[i].WeekNo);
                    yAxis.push(result[i].SPIValue);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                if (Command == "SPIAsOnDate") {
                    //piaGraph(DashboardID, yAxis, xAxis);
                    BarGraphForPercent(DashboardID, arrData, xAxis, yAxis, "SPI Variance");
                }
                else {
                    ScheduleVarienceGraph(DashboardID, xAxis, yAxis, "SPI");
                }
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getProjectCostVarienceGraph(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetVarienceParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getProjectCostVarienceGraph", param, false);
            if (result != undefined && result != 0) {
                var xAxis = [];
                var yAxis = [];
                var arrProject = [];
                var CVPercent;
                for (var i = 0; i < result.length; i++) {
                    if (result[i].CVPercent.toString().indexOf('.') != -1) {
                        CVPercent = result[i].CVPercent.toFixed(2);
                    } else {
                        CVPercent = result[i].CVPercent;
                    }
                    xAxis.push(result[i].WeekNo);
                    //yAxis.push(result[i].CVPercent);
                    yAxis.push(CVPercent);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                if (Command == "CVPercentAsOnDate") {
                    //piaGraph(DashboardID, yAxis, xAxis);
                    BarGraphForPercent(DashboardID, arrData, xAxis, yAxis, "CV Variance");
                }
                else {
                    //ScheduleVarienceGraph(DashboardID, xAxis, yAxis, "Cost Variance");
                    CostVarienceGraph(DashboardID, xAxis, yAxis, "Cost Variance");
                }
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getProjectCompletionAndPaymentPercentage(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getProjectCompletionAndPaymentPercentage", param, false);
            if (result != undefined && result != 0) {
                var arrCountMilestone = [];
                var arrCompletionPercent = [];
                var arrPaymentPercent = [];
                var arrProject = [];
                var CountMileStone;
                var Sum_CompletionPercentage;
                var Sum_PaymentPercentage;
                for (var i = 0; i < result.length; i++) {
                    if (result[i].CountMileStone.toString().indexOf('.') != -1) {
                        CountMileStone = result[i].CountMileStone.toFixed(2);
                    } else {
                        CountMileStone = result[i].CountMileStone;
                    }
                    if (result[i].Sum_CompletionPercentage.toString().indexOf('.') != -1) {
                        Sum_CompletionPercentage = result[i].Sum_CompletionPercentage.toFixed(2);
                    } else {
                        Sum_CompletionPercentage = result[i].Sum_CompletionPercentage;
                    }
                    if (result[i].Sum_PaymentPercentage.toString().indexOf('.') != -1) {
                        Sum_PaymentPercentage = result[i].Sum_PaymentPercentage.toFixed(2);
                    } else {
                        Sum_PaymentPercentage = result[i].Sum_PaymentPercentage;
                    }
                    arrCountMilestone.push(CountMileStone);
                    arrCompletionPercent.push(Sum_CompletionPercentage);
                    arrPaymentPercent.push(Sum_PaymentPercentage);
                    arrProject.push(result[i].ProjectID);
                    GraphLabels.push(result[i].Projectname);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                ProjectCompletionGraph(DashboardID, GraphLabels, arrCountMilestone, arrCompletionPercent, arrPaymentPercent);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }

        function getRiskMatrix(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getRiskMatrix", param, false);
            if (result != undefined && result != 0) {
                var arrProbability = [];
                var arrImpact = [];
                var arrRiskCount = [];
                for (var i = 0; i < result.length; i++) {
                    arrProbability.push(result[i].Probability);
                    arrImpact.push(result[i].Impact);
                    arrRiskCount.push(result[i].RiskCount);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                RiskMatrixGraph(DashboardID, SelectedTab, SelectedDash, arrProbability, arrImpact, arrRiskCount);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getDefectDensity(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getDefectDensity", param, false);
            if (result != undefined && result != 0) {
                for (var i = 0; i < result.length; i++) {
                    GraphLabels.push(result[i].Type);
                    arrData.push(result[i].DefectPercent);
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                piaGraph(DashboardID, arrData, GraphLabels);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getDefectDensityWBSLevel(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = ["IssueCount", "DeliverableCount", "PhaseCount", "SprintCount"];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getDefectDensity", param, false);
            if (result != undefined && result != 0) {
                for (var i = 0; i < result.length; i++) {
                    arrData.push(result[i].IssueCount);
                    arrData.push(result[i].DeliverableCount);
                    arrData.push(result[i].PhaseCount);
                    arrData.push(result[i].SprintCount);
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 

                HirizontalBarGraph(DashboardID, arrData, GraphLabels);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getTaskOverDueByResource(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getTaskOverDueByResource", param, false);
            if (result != undefined && result != 0) {
                var arrEmployeeName = [];
                var arrOverDue = [];
                for (var i = 0; i < result.length; i++) {
                    GraphLabels.push(result[i].EmployeeName);
                    arrOverDue.push(result[i].OverDue)
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="200"></canvas>'); // then load chart. 
                BarGraphOverDue(DashboardID, arrData, GraphLabels, arrOverDue, "Task Overdue", GraphLabels);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getTaskOverDueByDays(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getTaskOverDueByDays", param, false);
            if (result != undefined && result != 0) {
                var arrEmployeeName = [];
                var arrOverDue = [];
                for (var i = 0; i < result.length; i++) {
                    GraphLabels.push(result[i].EmployeeName);
                    arrOverDue.push(result[i].OverDueDaysCount)
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                BarGraphOverDue(DashboardID, arrData, GraphLabels, arrOverDue, "Days", GraphLabels);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getTaskOverAging(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = ["<5", "5-10", "10-15", ">15"];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getTaskOverAging", param, false);
            if (result != undefined && result != 0) {
                var arrEmployeeName = [];
                var arrOverDue = [];
                for (var i = 0; i < result.length; i++) {
                    arrOverDue.push(result[i].GreaterThan5);
                    arrOverDue.push(result[i].Between5To10);
                    arrOverDue.push(result[i].Between10To15);
                    arrOverDue.push(result[i].Between15To30);
                    //arrOverDue.push(result[i].BetweenLessThan30);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="200"></canvas>'); // then load chart. 
                BarGraphOverDue(DashboardID, arrData, GraphLabels, arrOverDue, "Overdue Tasks", GraphLabels);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getTaskStatusByProject(DashboardID, SelectedTab, SelectedDash, Command) {

            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            //var GraphLabels = ["OnTrack", "OverDue", "OpenTask", "InProgress", "ClosedTask"];
            var GraphLabels = ["Yet to Start", "In Progress", "Completed"];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getTaskStatusByProject", param, false);//LOGIC SAME ADDED LIKE 

            if (result != undefined && result != 0) {
                var arrProject = [];
                //var OnTrackData = [];
                //var OverDueData = [];
                var OpenTaskData = [];
                var InProgressData = [];
                var ClosedTaskData = [];
                for (var i = 0; i < result.length; i++) {
                    arrProject.push(result[i].ProjectName);
                    //if (result[i].OnTrack) { OnTrackData.push(result[i].OnTrack) }
                    //if (result[i].OverDue) { OverDueData.push(result[i].OverDue) }
                    //if (result[i].OpenTask) { OpenTaskData.push(result[i].OpenTask) }
                    //if (result[i].InProgress) { InProgressData.push(result[i].InProgress) }
                    //if (result[i].ClosedTask) { ClosedTaskData.push(result[i].ClosedTask) }
                    if (result[i].YetToStart) { OpenTaskData.push(result[i].YetToStart) }
                    if (result[i].InProgress) { InProgressData.push(result[i].InProgress) }
                    if (result[i].ClosedTask) { ClosedTaskData.push(result[i].ClosedTask) }
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="200"></canvas>'); // then load chart. 
                TaskStatusByProStackBarGraph(DashboardID, GraphLabels, result);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getMilestoneRevenueForecast(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getMilestoneRevenueForecast", param, false);
            if (result != undefined && result != 0) {                
                var Quarter = [];
                var CommercialValue = [];
                var NoOfMilestone = [];
                var MonthName = [];
                for (var i = 0; i < result.length; i++) {
                    Quarter.push('Q' + result[i].QtrNo);
                    CommercialValue.push(result[i].CommercialValue);
                    NoOfMilestone.push(result[i].MilestoneCount);
                    MonthName.push(result[i].MonthName);
                    arrData = result;
                }
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                MileStoneRevenueGraph(DashboardID, Quarter, CommercialValue, NoOfMilestone, MonthName);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function getRevenueRecognizationAndRealizationTrend(DashboardID, SelectedTab, SelectedDash, Command) {
            var GraphData = GetParameters(SelectedTab, SelectedDash, Command);
            var arrData = [];
            var GraphLabels = [];
            var param = JSON.stringify(GraphData);
            var result = AJAXCallWithResult("/api/ProjectDashboard/getRevenueRecognizationAndRealizationTrend", param, false);

            if (result != undefined && result != 0) {
                var RevenueRecognized = [];
                var RevenueRealization = [];
                var Qtr = [];
                for (var i = 0; i < result.length; i++) {
                    RevenueRecognized.push(result[i].RevenueRecognized);
                    RevenueRealization.push(result[i].RevenueRealized);
                    Qtr.push(result[i].QtrNo);
                }
                arrData = result;
                $("CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").empty();
                $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html('<canvas id="CanvasDashBoard_' + SelectedTab + '_' + SelectedDash + '" height="100"></canvas>'); // then load chart. 
                RevenueRecognizationAndRealizationGraph(DashboardID, Qtr, RevenueRecognized, RevenueRealization);
            } else {
                ifDataNotPresent(DashboardID, arrData);
            }
        }
        function ifDataNotPresent(DashboardID, arrData) {
            if (arrData.length == 0) {
                var ParentDiv = $("#" + DashboardID + "").parent().attr("id");
                //$("#" + ParentDiv + "").html("<h4<center><%=MyBase.GetResourceString("C_NoData")%></center></h4>");
                $("#" + ParentDiv + "").html("<h5><%=MyBase.GetResourceString("C_NoData")%></h5>"); //Edit by Omkar T on 09-01-20
                $("#" + ParentDiv + "").css("text-align", "Center");
            }
        }
        //Added By Dipali V On 15th JAn 2020 For Access Level Filter
        function MyPluseonclick() {

            $("#spnMyPluse").text($("#spnMyPluse").text() == 'My Pulse' ? 'Overall' : 'My Pulse');
            if ($("#spnMyPluse").text() == "My Pulse") {
                IsMyPluse = 0;//For OverAll
            } else {
                IsMyPluse = 1;//For My Pulse
            }
            StartLoader("#bdyProjectDashboard");
            //GetAllGraphs();
            getTabWiseWidget(SelectedTab);

        }
        //End of Added By Dipali V On 15th JAn 2020 For Access Level Filter
        function piaGraph(DashboardID, arrData, labels) {
            var ctx = document.getElementById("" + DashboardID + "").getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    // labels: ["Positive Schedule Variance", "Positive Cost Variance"],
                    labels: labels,
                    datasets: [{
                        backgroundColor: [
                            "#ffc000",
                            "#ed7d31",
                            "#2ecc71",
                            "#ed9456",
                            "#a5cc2e",
                        ],
                        data: (arrData.length == 0 ? [0, 0] : arrData)
                    }]
                },
                // Configuration options go here
                options: {
                    legend: {
                        position: 'right',
                        labels: {
                            //fontColor: "white"
                        }
                    }
                }
            });
        }
        function BarGraphOverDue(DashboardID, arrData, GraphLabels, arrOverDue, Label, arrProjectName) {
            var tooltipsLabel = arrProjectName;
            new Chart(document.getElementById("" + DashboardID + ""), {
                type: 'bar',
                data: {
                    labels: GraphLabels,
                    datasets: [{
                        label: Label,
                        type: "bar",
                        backgroundColor: "rgba(13, 149, 211, 0.8)",
                        data: arrOverDue,
                    }
                    ]
                },
                options: {
                    responsive: true,

                    legend: { display: true },
                    scales: {
                        xAxes: [{
                            maxBarThickness: 50,
                            barPercentage: 0.6,
                            ticks: {
                                autoSkip: false,
                                maxRotation: 30,
                                minRotation: 30,
                                min: this.min,
                                max: this.max
                            },

                        }]

                    },
                    tooltips: {
                        mode: 'index',
                        intersect: true,
                        callbacks: {
                            title: function (tooltipItem, data) {
                                return tooltipsLabel[tooltipItem[0].index];
                            }
                        }
                    }
                }
            });
        }
        function BarGraphForPercent(DashboardID, GraphLabels, xAxis, yAxis, Label) {
            var ctx = document.getElementById("" + DashboardID + "").getContext("2d");
            var data = {
                labels: xAxis,//GraphLabels,
                datasets: [{
                    label: Label,
                    text: "label",
                    backgroundColor: "#ffc000",
                    data: yAxis
                }]
            };
            var myBarChart = new Chart(ctx, {
                type: 'bar',
                data: data,
                options: {
                    title: {
                        display: true,
                        responsive: true,
                        //text: ''
                    },
                    //barValueSpacing: 20,
                    scales: {
                        xAxes: [{
                            maxBarThickness: 50,
                            barPercentage: 0.6,
                            ticks: {
                                autoSkip: false,
                                maxRotation: 10,
                                minRotation: 10
                            },
                        }],
                        yAxes: [{
                            maxBarThickness: 20,
                            ticks: {
                                max: this.max,
                                min: this.min
                            }
                        }]
                    },
                    responsive: true,

                }
            });
        }


        //FunnelGraph
        function FunnelGraph(DashboardID, arrData, labels) {
            var ctx = document.getElementById("" + DashboardID + "").getContext("2d");
            var config = new Chart(ctx, {
                type: 'funnel',
                data: {
                    datasets: [{
                        data: arrData,
                        backgroundColor: [
                            "#afd037",
                            "#e11c25",
                            "#0d95d3",
                            "#d8e5fc"
                        ],
                        hoverBackgroundColor: [
                            "#afd037",
                            "#e11c25",
                            "#0d95d3",
                            "#d8e5fc"
                        ]
                    }],
                    labels: labels
                },
                options: {
                    responsive: true,
                    sort: 'desc',

                    tooltip: true,
                    // bottomPinch :300,
                    topWidth: 50,

                    //keep: 'left',
                    legend: {
                        position: 'top'
                    },
                    title: {
                        display: true,
                        //text: 'Chart.js Funnel Chart'
                    },
                    animation: {
                        animateScale: true,
                        animateRotate: true
                    },
                    //tooltips: {
                    //    mode: 'label',
                    //    intersect: true,
                    //    callbacks: {
                    //        title: function (tooltipItem, data) {
                    //            return arrData[tooltipItem[0].index];
                    //        }
                    //    }
                    //}
                }
            });
        }

        function HirizontalBarGraph(DashboardID, arrData, labels) {
            let xMap = ['', '0', '1', '2', '3', '4', '5'];
            let yMap = ['Issues', 'Deliverable', 'Phase', 'Sprint'];

            let mapNumeric = function (xValue) {
                return xMap.indexOf(xValue);
            };

            let ctxDD = document.getElementById('' + DashboardID + '').getContext('2d');

            var horizontalBar = new Chart(ctxDD, {
                type: 'horizontalBar',
                data: {
                    xLabels: xMap,
                    yLabels: yMap,
                    datasets: [{
                        data: arrData,
                        label: 'Proficiency',
                        // fill: false,
                        backgroundColor: "hsla(0, 75%, 40%, 0.60)",
                        borderColor: "hsla(0, 75%, 40%, .70)",
                        borderWidth: 3
                    }]
                },
                options: {
                    responsive: true,

                    legend: {
                        display: false,
                        position: 'top'
                    },
                    title: {
                        display: true,
                        // text: 'Chartjs Horizontal Bar Chart Playground'
                    },
                    tooltips: {
                        enabled: false
                    },
                    scales: {
                        yAxes: [{
                            barPercentage: .5,
                            type: 'category',
                            display: true,
                            scaleLabel: {
                                display: true,
                                // labelString: 'Tools',
                            },
                        }],
                        xAxes: [{
                            type: 'linear',
                            display: true,
                            scaleLabel: {
                                display: true,
                                // labelString: 'Proficiency'
                            },
                            ticks: {
                                min: 0,
                                max: xMap.length - 1,
                                callback: function (value) {
                                    return xMap[value];
                                },
                            }
                        }]
                    }
                }
            });
        }
        //Added by Nilesh Pingale on 09-01-2020
        function getRandomColor() {
            var letters = '0123456789ABCDEF';
            var color = '#';
            for (var i = 0; i < 6; i++) {
                color += letters[Math.floor(Math.random() * 16)];
            }
            return color;
        }
        //End by Nilesh Pingale on 09-01-2020
        function PriorityStackBarGraph(DashboardID, arrPriority, arrOverDueCount) {
            new Chart(document.getElementById("" + DashboardID + ""), {
                type: 'bar',
                data: {
                    labels: arrPriority,
                    datasets: [{
                        label: "Corporate Priority",
                        type: "bar",
                        backgroundColor: "#ed7d31",
                        data: arrOverDueCount,
                    }]
                },
                options: {
                    responsive: true,
                    legend: { display: false },
                    scales: {
                        xAxes: [{
                            maxBarThickness: 30,
                            barPercentage: 0.6,
                            ticks: {
                                autoSkip: false,
                                maxRotation: 30,
                                minRotation: 30,
                                min: 0,
                                max: this.max
                            },
                        }]
                    }

                }
            });
        }
        function TaskStatusByProStackBarGraph(DashboardID, GraphLabels, result) {
            var arrProject = [];
            var arrShortTitle = [];
            var OnTrackData = [];
            var OverDueData = [];
            var OpenTaskData = [];
            var InProgressData = [];
            var ClosedTaskData = [];
            for (var i = 0; i < result.length; i++) {
                arrProject.push(result[i].ProjectName);
                arrShortTitle.push(result[i].ShortJobTitle);
                //OnTrackData.push(result[i].OnTrack)
                //OverDueData.push(result[i].OverDue)
                OpenTaskData.push(result[i].YetToStart)
                InProgressData.push(result[i].InProgress)
                ClosedTaskData.push(result[i].ClosedTask)
            }
            var numberWithCommas = function (x) {
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            };
            var dates = arrShortTitle;
            var tooltipsLabel = arrProject;
            // Chart.defaults.global.elements.rectangle.backgroundColor = '#FF0000';
            var bar_ctx = document.getElementById('' + DashboardID + '');
            var bar_chart = new Chart(bar_ctx, {
                type: 'bar',
                data: {
                    labels: dates,
                    datasets: [
                        {
                            label: 'Yet to Start',
                            data: OpenTaskData,
                            backgroundColor: "rgb(12, 132, 227)",
                            hoverBackgroundColor: "rgb(10, 105, 180)",
                            hoverBorderWidth: 1,
                            hoverBorderColor: 'lightgrey'
                        }, {
                            label: 'In Progress',
                            data: InProgressData,
                            backgroundColor: "rgb(248, 225, 27)",
                            hoverBackgroundColor: "rgb(229, 209, 27)",
                            hoverBorderWidth: 1,
                            hoverBorderColor: 'lightgrey'
                        }, {
                            label: 'Completed',
                            data: ClosedTaskData,
                            backgroundColor: "rgb(26, 159, 31)",
                            hoverBackgroundColor: "rgb(6, 122, 11)",
                            hoverBorderWidth: 1,
                            hoverBorderColor: 'lightgrey'
                        }
                    ]
                },
                options: {
                    animation: {
                        duration: 20,
                    },
                    tooltips: {
                        mode: 'label',
                        callbacks: {
                            label: function (tooltipItem, data) {
                                return data.datasets[tooltipItem.datasetIndex].label + ": " + numberWithCommas(tooltipItem.yLabel);
                                //return tooltipsLabel[tooltipItem[0].index];
                            },
                            title: function (tooltipItem, data) {

                                return tooltipsLabel[tooltipItem[0].index];
                            }
                        }
                    },
                    scales: {
                        xAxes: [{
                            stacked: true,
                            gridLines: { display: false },
                            barPercentage: 0.2,
                            maxBarThickness: 30,
                            ticks: {
                                autoSkip: false,
                                maxRotation: 90,
                                minRotation: 90
                            },

                            //   maxBarThickness: 30,
                        }],
                        yAxes: [{
                            stacked: true,
                            maxBarThickness: 30,
                            barPercentage: 0.6,
                           
                            ticks: {
                                callback: function (value) { return numberWithCommas(value); },
                                padding: 20,
                            },
                        }],
                    }, // scales
                    legend: { display: true }
                } // options
            }
            );
        }

        function BarGraph(DashboardID, GraphLabels, arrPlannedEfforts, arrActualEfforts, arrProject, arrPNToolTip) {
            var tooltipsLabel = arrPNToolTip;
           
            var ctx = document.getElementById("" + DashboardID + "").getContext("2d");
            var data = {
                labels: GraphLabels,
                datasets: [{
                    label: "Planned Efforts",
                    text: "label",
                    backgroundColor: "#ffc000",
                    data: arrPlannedEfforts
                }, {
                    label: "Actual Efforts",
                    backgroundColor: "#ed7d31",
                    data: arrActualEfforts                   
                }]
            };
            var myBarChart = new Chart(ctx, {
                type: 'bar',
                data: data,
                options: {
                    title: {
                        display: true,
                        responsive: true,
                        //text: ''
                    },
                    responsive: true,

                    legend: { display: true },
                    scales: {
                        xAxes: [{
                            maxBarThickness: 50,
                            barPercentage: 0.6,
                            ticks: {
                                autoSkip: false,
                                maxRotation: 30,
                                minRotation: 30,
                                min: this.min,
                                max: this.max
                            },

                        }]
                    },
                    //Added By Usha Pandit On 29.07.2020 For getting tooltip for Efforts in HH:MM format
                    tooltips: {
                        callbacks: {
                            label: function (tooltipItems, data) {
                                //alert(data.label);
                                if (data.datasets[tooltipItems.datasetIndex].label == "Planned Efforts")
                                {
                                    var HMPlannedEfforts = tooltipItems.yLabel;
                                    HMPlannedEfforts = HMPlannedEfforts.toString().replace(".", ":");
                                    return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMPlannedEfforts;
                                }
                                if (data.datasets[tooltipItems.datasetIndex].label == "Actual Efforts")
                                {
                                    var HMActualEfforts = tooltipItems.yLabel;
                                    HMActualEfforts = HMActualEfforts.toString().replace(".", ":");
                                    return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMActualEfforts;
                                }
                                
                            }
                        }
                    },
                    //End Of Added By Usha Pandit On 29.07.2020 For getting tooltip for Efforts in HH:MM format
                    //barValueSpacing: 20,
                    scales: {
                        xAxes: [{
                            maxBarThickness: 30,
                            barPercentage: 0.2,
                            ticks: {
                                autoSkip: false,
                                maxRotation: 90,
                                minRotation: 90
                            },
                        }],
                        yAxes: [{
                            maxBarThickness: 20,
                            ticks: {
                                max: this.max,//100, //max value 100 commented and this.max added by Nilesh Pingale on 13-01-2020
                                min: 0
                            }
                        }]
                    },
                    responsive: true,
                    tooltips: {
                        mode: 'single',//'index',
                        intersect: true,
                        callbacks: {
                            title: function (tooltipItem, data) {
                                return tooltipsLabel[tooltipItem[0].index];
                            }
                        }
                    }
                }
            });

        }
        function IssueStatusLineGraph(DashboardID, GraphLabels, arrInRate, arrOutRate, arrOutstanding) {
            var canvas = document.getElementById('' + DashboardID + '');
            var tooltipsLabel = GraphLabels;
            var data = {
                labels: GraphLabels,
                datasets: [
                    {
                        label: "In Rate",
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "rgba(75,192,192,0.4)",
                        borderColor: "rgba(75,192,192,1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgba(75,192,192,1)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(75,192,192,1)",
                        pointHoverBorderColor: "rgba(220,220,220,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 5,
                        pointHitRadius: 10,
                        data: arrInRate,
                    }, {
                        label: "Out Rate",
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "#fcc3a1",//"rgb(249, 136, 67,0.5)",//modified by Pradip P on 14-01-2020
                        borderColor: "rgb(249, 136, 67)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgb(249, 136, 67)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgb(249, 136, 67)",
                        pointHoverBorderColor: "rgb(249, 136, 67)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 5,
                        pointHitRadius: 10,
                        data: arrOutRate,
                    }, {
                        label: "Outstanding",
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "#da5e5e",
                        borderColor: "#da5e5e",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "#da5e5e",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "#da5e5e",
                        pointHoverBorderColor: "#da5e5e",
                        pointHoverBorderWidth: 2,
                        pointRadius: 5,
                        pointHitRadius: 10,
                        data: arrOutstanding,
                    }
                ]
            };
            var option = {
                showLines: true
            };
            var myLineChart = Chart.Line(canvas, {
                data: data,
                options: option,
                tooltips: {
                    mode: 'single',//'index',
                    intersect: true,
                    callbacks: {
                        title: function (tooltipItem, data) {
                            return tooltipsLabel[tooltipItem[0].index];
                        }
                    }
                }
            });
        }
        function ProjectTimeCostBarGraph(DashboardID, GraphLabels, arrProjectName, arrPlannedEfforts, arrActualEfforts, arrPlannedCost, arrActualCost, arrProject) {
            var tooltipsLabel = arrProjectName;
            new Chart(document.getElementById("" + DashboardID + ""), {
                type: 'bar',
                data: {
                    labels: GraphLabels,
                    datasets: [
                        {
                            label: "Project Planned Effort",
                            type: "bar",
                            backgroundColor: "#eb1c24",
                            data: arrPlannedEfforts,
                            bezierCurve: false
                        }, {
                            label: "Project Actual Effort",
                            type: "bar",
                            backgroundColor: "#e6d935",
                            data: arrActualEfforts,
                            bezierCurve: false
                        }, {
                            label: "Project Planned Cost",
                            type: "bar",
                            backgroundColor: "rgba(175,208,55,1)",
                            data: arrPlannedCost,
                            bezierCurve: false
                        }, {
                            label: "Project Actual Cost",
                            type: "bar",
                            backgroundColor: "#3e95cd",
                            data: arrActualCost,
                            bezierCurve: false
                        }
                    ]
                },
                options: {
                    title: {
                        display: false,
                        responsive: true,
                        text: 'Population growth (millions): Europe & Africa'
                    },
                    legend: { display: true },
                    scales: {
                        xAxes: [{
                            maxBarThickness: 30,
                            ticks: {
                                autoSkip: false,
                                maxRotation: 90,
                                minRotation: 90
                            }

                        }],
                        yAxes: [{

                            gridLines: {
                                display: false
                            },

                            type: 'linear',
                            position: 'left',
                        }, {
                            type: 'linear',
                            position: 'right',
                            gridLines: {
                                display: true
                            },
                            ticks: {
                                max: this.max,
                                min: this.min
                            }
                        }],

                    },
                    tooltips: {
                        mode: 'single',//'index',
                        intersect: true,
                        callbacks: {
                            title: function (tooltipItem, data) {
                                return tooltipsLabel[tooltipItem[0].index];
                            }
                        }
                    }
                }
            });
        }
        function VarienceGraph(DashboardID, GraphLabels, yAxis, Label) {
            var canvas = document.getElementById('' + DashboardID + '');
            var data = {
                labels: GraphLabels,
                datasets: [
                    {
                        label: Label,
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "rgba(75,192,192,0.4)",
                        borderColor: "rgba(75,192,192,1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgba(75,192,192,1)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(75,192,192,1)",
                        pointHoverBorderColor: "rgba(220,220,220,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 3,
                        pointHitRadius: 3,
                        borderWidth: 1, // Specify bar border width
                        data: yAxis,
                    }
                ]
            };

            var option = {
                showLines: true,
                scales: {
                    yAxes: [
                        {
                            ticks: {
                                min: this.min,
                                max: this.max,// Your absolute max value
                                callback: function (value) {
                                    //return (value / this.max * 100).toFixed(0) + '%'; // convert it to percentage
                                    return (value) + '%';
                                },

                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Percentage',
                            },
                        },
                    ],
                },
            };
            var myLineChart = Chart.Line(canvas, {
                data: data,
                options: option
            });
        }
        function ScheduleVarienceGraph(DashboardID, xAxis, yAxis, label) {

            var canvas = document.getElementById('' + DashboardID + '');
            var data = {
                labels: xAxis,
                datasets: [
                    {
                        label: label,
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "rgba(75,192,192,0.4)",
                        borderColor: "rgba(75,192,192,1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgba(75,192,192,1)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(75,192,192,1)",
                        pointHoverBorderColor: "rgba(220,220,220,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 3,
                        pointHitRadius: 3,
                        borderWidth: 1, // Specify bar border width
                        data: yAxis,
                    },
                ]
            };

            var option = {
                showLines: true,
                scales: {
                    yAxes: [
                        {
                            ticks: {
                                min: this.min,//0,
                                max: this.max,//this.max, Your absolute max value
                                callback: function (value) {
                                    //return (value / this.max * 100).toFixed(0) + '%'; // convert it to percentage
                                    return value + '%';
                                },

                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Percentage',
                            },
                        },
                    ],
                },
            };
            var myLineChart = Chart.Line(canvas, {
                data: data,
                options: option
            });
        }
        function CostVarienceGraph(DashboardID, xAxis, yAxis, label) {

            var canvas = document.getElementById('' + DashboardID + '');
            var data = {
                labels: xAxis,
                datasets: [
                    {
                        label: label,
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "rgba(75,192,192,0.4)",
                        borderColor: "rgba(75,192,192,1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgba(75,192,192,1)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(75,192,192,1)",
                        pointHoverBorderColor: "rgba(220,220,220,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 3,
                        pointHitRadius: 3,
                        borderWidth: 1, // Specify bar border width
                        data: yAxis,
                    },
                ]
            };

            var option = {
                showLines: true,
                scales: {
                    yAxes: [
                        {
                            ticks: {
                                min: this.min,
                                max: this.max, //Your absolute max value
                                callback: function (value) {
                                    //return (value / this.max * 100).toFixed(0) + '%'; // convert it to percentage
                                    return value + '%';
                                },

                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Percentage',
                            },
                        },
                    ],
                },
            };
            var myLineChart = Chart.Line(canvas, {
                data: data,
                options: option
            });
        }
        function ProjectCompletionGraph(DashboardID, GraphLabels, arrCountMilestone, arrCompletionPercent, arrPaymentPercent) {
            //var maxSC = arrCompletionPercent.max();
            //var maxSC = arrCompletionPercent.max();
            var maxSC;
            var maxc = Math.max.apply(this, arrCompletionPercent);
            var maxp = Math.max.apply(this, arrPaymentPercent);
            var maxSC = Math.max(maxc, maxp) + 10;
            new Chart(document.getElementById("" + DashboardID + ""), {
                type: 'bar',
                data: {
                    labels: GraphLabels,
                    datasets: [{
                        lineTension: "0",
                        radius: "5",
                        label: "Sum Of Payment %",
                        type: "line",
                        borderColor: "#ccc",
                        data: arrPaymentPercent,
                        fill: false
                    },
                    {
                        lineTension: "0",
                        radius: "5",
                        label: "Sum Of Completion %",
                        type: "line",
                        backgroundColor: "rgba(75,192,192,0.4)",
                        borderColor: "rgba(75,192,192,1)",
                        data: arrCompletionPercent,
                        fill: false
                    }, {
                        label: "No. Of Milestone",
                        type: "bar",
                        backgroundColor: "rgba(13, 149, 211, 0.8)",
                        data: arrCountMilestone,
                    }
                    ]
                },
                options: {
                    responsive: true,
                    title: {
                        display: true,
                        responsive: true,
                        text: 'Project Completion and Payment %'
                    },
                    legend: { display: true },
                    scales: {
                        xAxes: [{
                            maxBarThickness: 30,
                            barPercentage: 0.6,
                        }],
                        yAxes: [{
                            maxBarThickness: 30,
                            barPercentage: 0.6,
                            bezierCurve: 'false',
                            id: 'A',
                            //type: 'linear',

                            position: 'left',
                            ticks: {
                                max: maxSC,//1.2,
                                min: this.min//0
                            }
                        }, {

                            id: 'B',
                            type: 'linear',
                            position: 'right',
                            ticks: {
                                max: 100,
                                min: 0
                            }
                        }]
                    }
                }
            });
        }
        function RiskMatrixGraph(DashboardID, SelectedTab, SelectedDash, arrProbability, arrImpact, arrRiskCount) {
            var strHTMLRiskMetrix = "";
            strHTMLRiskMetrix += '<div class="box-body pl-0">';
            strHTMLRiskMetrix += '<div class="riskmatrixtbl PPriskmatrixtbl" style="padding:0px;">';
            strHTMLRiskMetrix += '<table class="table table-bordered table-responsive mb-0" id="rMatrix">';
            strHTMLRiskMetrix += '<thead>';
            strHTMLRiskMetrix += '</thead>';
            strHTMLRiskMetrix += '<tbody>';
            strHTMLRiskMetrix += '<tr lh="5">';
            strHTMLRiskMetrix += '<td class="matrix_label lable-y">';
            strHTMLRiskMetrix += '5-Very Likely';
            strHTMLRiskMetrix += '</td>';
            strHTMLRiskMetrix += '<td class="M">' + arrRiskCount[0] + '</td>';
            strHTMLRiskMetrix += '<td class="H">' + arrRiskCount[1] + '</td>';
            strHTMLRiskMetrix += '<td class="H">' + arrRiskCount[2] + '</td>';
            strHTMLRiskMetrix += '<td class="VH">' + arrRiskCount[3] + '</td>';
            strHTMLRiskMetrix += '<td class="VH">' + arrRiskCount[4] + '</td>';
            strHTMLRiskMetrix += '</tr>';
            strHTMLRiskMetrix += '<tr lh="4">';
            strHTMLRiskMetrix += '<td class="matrix_label lable-y">4-Likely</td>';
            strHTMLRiskMetrix += '<td class="M">' + arrRiskCount[5] + '</td>';
            strHTMLRiskMetrix += '<td class="M">' + arrRiskCount[6] + '</td>';
            strHTMLRiskMetrix += '<td class="H">' + arrRiskCount[7] + '</td>';
            strHTMLRiskMetrix += '<td class="VH">' + arrRiskCount[8] + '</td>';
            strHTMLRiskMetrix += '<td class="VH">' + arrRiskCount[9] + '</td>';
            strHTMLRiskMetrix += '</tr>';
            strHTMLRiskMetrix += '<tr lh="3">';
            strHTMLRiskMetrix += '<td class="matrix_label lable-y">3-Possible</td>';
            strHTMLRiskMetrix += '<td class="L">' + arrRiskCount[10] + '</td>';
            strHTMLRiskMetrix += '<td class="M">' + arrRiskCount[11] + '</td>';
            strHTMLRiskMetrix += '<td class="M">' + arrRiskCount[12] + '</td>';
            strHTMLRiskMetrix += '<td class="H">' + arrRiskCount[13] + '</td>';
            strHTMLRiskMetrix += '<td class="H">' + arrRiskCount[14] + '</td>';
            strHTMLRiskMetrix += '</tr>';
            strHTMLRiskMetrix += '<tr lh="2">';
            strHTMLRiskMetrix += '<td class="matrix_label lable-y">';
            strHTMLRiskMetrix += '2-Unlikely'
            strHTMLRiskMetrix += '</td>';
            strHTMLRiskMetrix += '<td class="L">' + arrRiskCount[15] + '</td>';
            strHTMLRiskMetrix += ' <td class="L">' + arrRiskCount[16] + '</td>';
            strHTMLRiskMetrix += '<td class="M">' + arrRiskCount[17] + '</td>';
            strHTMLRiskMetrix += '<td class="M">' + arrRiskCount[18] + '</td>';
            strHTMLRiskMetrix += '<td class="H">' + arrRiskCount[19] + '</td>';
            strHTMLRiskMetrix += '</tr>';
            strHTMLRiskMetrix += '<tr>';
            strHTMLRiskMetrix += '<td class="matrix_label lable-y">1-Very Unlikely</td>';
            strHTMLRiskMetrix += ' <td class="L">' + arrRiskCount[20] + '</td>';
            strHTMLRiskMetrix += '<td class="L">' + arrRiskCount[21] + '</td>';
            strHTMLRiskMetrix += '<td class="L">' + arrRiskCount[22] + '</td>';
            strHTMLRiskMetrix += ' <td class="M">' + arrRiskCount[23] + '</td>';
            strHTMLRiskMetrix += ' <td class="M">' + arrRiskCount[24] + '</td>';
            strHTMLRiskMetrix += '</tr>';
            strHTMLRiskMetrix += ' <tr>';
            strHTMLRiskMetrix += '<td class="matrix_label">';
            strHTMLRiskMetrix += ' &nbsp;';
            strHTMLRiskMetrix += '</td>';
            strHTMLRiskMetrix += '<td class="matrix_label r-header">';
            strHTMLRiskMetrix += '1-Negligible';
            strHTMLRiskMetrix += '</td>';
            strHTMLRiskMetrix += '<td class="matrix_label">';
            strHTMLRiskMetrix += '2-Minor';
            strHTMLRiskMetrix += '</td>';
            strHTMLRiskMetrix += '<td class="matrix_label">';
            strHTMLRiskMetrix += '3-Moderate';
            strHTMLRiskMetrix += ' </td>';
            strHTMLRiskMetrix += ' <td class="matrix_label">';
            strHTMLRiskMetrix += '4-Significant';
            strHTMLRiskMetrix += ' </td>';
            strHTMLRiskMetrix += '<td class="matrix_label">';
            strHTMLRiskMetrix += '5-Severe';
            strHTMLRiskMetrix += '</td>';
            strHTMLRiskMetrix += '</tr>';
            strHTMLRiskMetrix += '</tbody>';
            strHTMLRiskMetrix += '</table >';
            strHTMLRiskMetrix += '</div >';
            strHTMLRiskMetrix += '</div>';
            $("#CanvasHolder_" + SelectedTab + "_" + SelectedDash + "").html(strHTMLRiskMetrix);
        }
        function MileStoneRevenueGraph(DashboardID, Quarter, CommercialValue, NoOfMilestone, MonthName) {
            new Chart(document.getElementById("" + DashboardID + ""), {
                type: 'bar',
                data: {
                    labels: Quarter,
                    datasets: [{
                        borderDash: [],
                        borderDashOffset: 0.0,
                        lineTension: 0.1,
                        radius: "5",
                        label: "Commercial Value",
                        type: "line",
                        borderColor: "rgba(75,192,192,0.8)",
                        data: CommercialValue,
                        fill: false
                    }, {
                        borderDash: [],
                        borderDashOffset: 0.0,
                        lineTension: 0.1,
                        label: "No. Of Milestone",
                        type: "line",
                        borderColor: "rgb(249, 136, 67,0.5)",
                        data: NoOfMilestone,
                        fill: false
                    },
                    ]
                },
                options: {
                    bezierCurve: false,
                    scales: {
                        xAxes: [{
                            maxBarThickness: 50,
                            barPercentage: 0.6,
                        }],
                        yAxes: [{
                            barPercentage: 0.2,
                            maxBarThickness: 20,
                            gridLines: { display: false },
                            id: 'A',
                            type: 'linear',
                            position: 'left',
                        }, {
                            barPercentage: 0.2,
                            maxBarThickness: 20,
                            id: 'B',
                            type: 'linear',
                            position: 'right',
                            gridLines: { display: true },
                            ticks: {
                                max: this.max,//100,
                                min: this.min//0
                            }
                        }]
                    }
                }
            });
        }
        function RevenueRecognizationAndRealizationGraph(DashboardID, Qtr, RevenueRecognized, RevenueRealization) {
            var canvas = document.getElementById('' + DashboardID + '');
            var data = {
                labels: Qtr,
                datasets: [
                    {
                        label: "Revenue Recognization",
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "rgba(75,192,192,0.4)",
                        borderColor: "rgba(75,192,192,1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgba(75,192,192,1)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(75,192,192,1)",
                        pointHoverBorderColor: "rgba(220,220,220,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 5,
                        pointHitRadius: 10,
                        data: RevenueRecognized,
                    }, {
                        label: "Revenue Realization",
                        fill: false,
                        lineTension: 0.1,
                        backgroundColor: "rgb(249, 136, 67,0.5)",
                        borderColor: "rgb(249, 136, 67)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgb(249, 136, 67)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgb(249, 136, 67)",
                        pointHoverBorderColor: "rgb(249, 136, 67)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 5,
                        pointHitRadius: 10,
                        data: RevenueRealization,
                    }
                ]
            };
            var option = {
                showLines: true
            };
            var myLineChart = Chart.Line(canvas, {
                data: data,
                options: option
            });
        }
        function Project_onChange(obj) {
            var MainProjectValue = obj.value;
            if (ArrayAccessibleDivID != null) {
                for (i = 0; i <= ArrayAccessibleDivID.length; i++) {
                    //Added By Nilesh Pingale on 12-01-2020
                    if (MainProjectValue == 0) {
                        //  debugger;
                        if (ArrayAccessibleDivID[i] != 'CboProject_34_1' && ArrayAccessibleDivID[i] != 'CboProject_33_1' && ArrayAccessibleDivID[i] != 'CboProject_3_3' && ArrayAccessibleDivID[i] != 'CboProject_20_1' && ArrayAccessibleDivID[i] != 'CboProject_22_1' && ArrayAccessibleDivID[i] != 'CboProject_27_1' && ArrayAccessibleDivID[i] != 'CboProject_28_1' && ArrayAccessibleDivID[i] != 'CboProject_31_1' && ArrayAccessibleDivID[i] != 'CboProject_32_1' && ArrayAccessibleDivID[i] != 'CboProject_35_1' && ArrayAccessibleDivID[i] != 'CboProject_36_1') {
                            $("#" + ArrayAccessibleDivID[i]).val(MainProjectValue);
                            $("#" + ArrayAccessibleDivID[i]).trigger('change');
                        }
                    }
                    else {
                        $("#" + ArrayAccessibleDivID[i]).val(MainProjectValue);
                        $("#" + ArrayAccessibleDivID[i]).trigger('change');
                    }
                    //End Added By Nilesh Pingale on 12-01-2020 
                    //Commented By Nilesh Pingale on 12-01-2020
                    //$("#" + ArrayAccessibleDivID[i]).val(MainProjectValue);
                    //$("#" + ArrayAccessibleDivID[i]).trigger('change');
                    //End Commented By Nilesh Pingale on 12-01-2020
                }
            }
        }
        function FinancialWeek_onChange(obj) {
            var SelectedWeek = $("#" + obj.id + " option:selected").val();
            $('.clsCboWeek').each(function (i, obj) {

                $("#" + obj.id).val(SelectedWeek);
                $("#" + obj.id).trigger('change');
            });
        }
        var ajaxResult;
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

                    ajaxResult = data;
                    $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");
                },
                error: function (err) {

                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }
    </script>
</body>
</html>
