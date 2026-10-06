<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectSLADashBoard.aspx.vb" Inherits="PbNIT.ProjectSLADashBoard" %>

<!DOCTYPE html>
<html>
         <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("Project Dashboard")%>
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=4">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/project-dashboard.css">
 
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
  
</head>
      <style>
     /*   table.dataTable thead .sorting:after {
    content: "\f0dc";
    font-family: "Font Awesome 5 Free";
    font-size: 16px;
    top: 18px;
    color: #999;
    opacity: 0.8;
}
         table.dataTable thead .sorting:before {
    content: "\f0dc";
    font-family: "Font Awesome 5 Free";
    font-size: 16px;
    top: 18px;
    color: #999;
    opacity: 0.8;
}*/
        .ClsNote {
            float: right;
            font-size: 12px;
            color: red;
        }
        .inline-block {
            display: inline-block
        }

        .headertopp ul {
            align-items: center;
            margin: 0;
            padding: 0;
            vertical-align: middle
        }

            .headertopp ul li .custom_radio {
                margin-top: 6px
            }

        .defayltbox .box-header {
            background: #e7edf0;
            padding: 10px
        }

        .box.defayltbox.chartbox {
            border: 1px solid #eee
        }

        .custom_chckbox label:before {
            margin-right: 0
        }


        body .ProjectHelathTbl tr:hover, body .ProjectHelathTbl tr:focus {
            background: #eef9ff;
        }

        .SLAactions a {
            margin: 0 3px;
        }

        span.usernameshort {
            width: 30px;
            height: 30px;
            line-height: 30px;
            margin: 0 auto;
            font-size: 14px;
        }

        body .ProjectSLAtbl tr td:nth-child(2) {
            text-align: center !important;
        }

        body .ProjectSLAtbl tr:hover, body .ProjectSLAtbl tr:focus {
            background: #eef9ff;
        }

        /*.SLAcounts {border: 1px solid #eee;}*/
        .SLAcounttext {
            font-size: 14px;
            font-weight: 500;
            margin-top: 5px;
            min-height: 40px;
        }

        .SLAcountbox {
            border: 1px solid #eee;
            text-align: center;
            margin: 0px 0 0px;
            background: #f0f1f5;
            padding: 12px;
        }

        .SLAcountNumber {
            font-weight: 400;
            font-size: 84px;
            margin-top: 3px;
        }

        .pr0 {
            margin-right: 0;
        }

        .SLAcounts .col-sm-3 {
            padding: 0 0 0 15px;
        }

        .ProjectSLAtbl th:first-child::after {
            display: none;
        }

        table.dataTable thead th {
            position: relative;
        }

            table.dataTable thead th:after {
                position: absolute;
                right: 5px;
            }

        table.dataTable thead .sorting_asc, table.dataTable thead .sorting_desc, table.dataTable thead .sorting {
            padding-right: 15px;
        }

        .ProjectSLAtbl tr th:last-child {
            min-width: 100px;
        }

        .ProjectSLAtbl tr th:not(:first-child) {
            min-width: 120px;
        }

        .ProjectSLAtbl tr th:nth-child(4) {
            min-width: 240px;
        }

        table.dataTable thead th:first-child {
            padding-right: 10px;
        }

        /*.ProjectSLAtbl th:nth-child(4), .ProjectSLAtbl th:nth-child(6), .ProjectSLAtbl th:nth-child(8), .ProjectSLAtbl th:nth-child(9), .ProjectSLAtbl th:nth-child(10){min-width:130px;}*/
        .ProjectSLAtbl th:last-child {
            min-width: 80px;
        }
        /*.content{height: calc(100vh - 168px);}*/
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        table.dataTable thead > tr > th.sorting:after, table.dataTable thead > tr > th.sorting_asc:after, table.dataTable thead > tr > th.sorting_desc:after, table.dataTable thead > tr > th.sorting_asc_disabled:after, table.dataTable thead > tr > th.sorting_desc_disabled:after, table.dataTable thead > tr > td.sorting:after, table.dataTable thead > tr > td.sorting_asc:after, table.dataTable thead > tr > td.sorting_desc:after, table.dataTable thead > tr > td.sorting_asc_disabled:after, table.dataTable thead > tr > td.sorting_desc_disabled:after {
            top: 50%;
            content: "\f0dc";
            OPACITY: 1;
        }

        table.dataTable thead .sorting:after {
            content: "\f0dc";
            font-family: "Font Awesome 5 Free";
            font-size: 16px;
            top: 18px;
            color: #999;
            opacity: 0.8;
        }


        body {
            background: #fff;
        }

        .content-wrapper, .right-side {
            background: #fff;
        }

        /*custome radio button*/
        .radio [type="radio"]:checked, .radio [type="radio"]:not(:checked) {
            position: absolute;
            left: -9999px;
        }

            .radio [type="radio"]:checked + label, .radio [type="radio"]:not(:checked) + label {
                position: relative;
                padding-left: 28px;
                cursor: pointer;
                line-height: 20px;
                display: inline-block;
                color: #464a4c;
                font-weight: 500;
            }

                .radio [type="radio"]:checked + label:before, .radio [type="radio"]:not(:checked) + label:before {
                    content: '';
                    position: absolute;
                    left: 0;
                    top: 0;
                    width: 16px;
                    height: 16px;
                    border: 1px solid #464a4c;
                    border-radius: 100%;
                    background: transparent;
                }

                .radio [type="radio"]:checked + label:after, .radio [type="radio"]:not(:checked) + label:after {
                    content: '';
                    width: 10px;
                    height: 10px;
                    background: #464a4c;
                    position: absolute;
                    top: 3px;
                    left: 3px;
                    border-radius: 100%;
                    -webkit-transition: all .2s ease;
                    transition: all .2s ease
                }

                .radio [type="radio"]:not(:checked) + label:after {
                    opacity: 0;
                    -webkit-transform: scale(0);
                    transform: scale(0)
                }

                .radio [type="radio"]:checked + label:after {
                    opacity: 1;
                    -webkit-transform: scale(1);
                    transform: scale(1)
                }

        .headertopp li .radio {
            margin-right: 30px;
        }
        /*custome radio button end*/
        .widget_category_panelbody {
            background: #fff;
            border-bottom: 1px solid #ddd;
        }

        .widgetcatbox:hover {
            background: #f5f5f5;
            box-shadow: 5px 3px 8px 1px #ccc;
            color: #464a4c;
        }

        .SLAcountbox.active {
            background: #1359a6;
            color: #fff;
        }

            .SLAcountbox.active .SLAcountNumber {
                color: #fff!important;
            }

        .selpro .dropdown-menu {
            max-height: 400px !important;
            overflow-y: auto;
        }

         /*Added By Dipali V On 12th Aug 2020 For Loader Issues*/
   /*.preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;*/
            /* border: 3px solid #ababab; */
            /* box-shadow: 1px 1px 10px #ababab; */
            /*border-radius: 15px;
            background: #ddd;*/
            /* background-color: white; */
            /*background: url(../../../Whizible2.0/dist/img/loading.gif) 100% 100% no-repeat;*/
            /* background: url(../../../Whizible2.0/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat; */
            /*width: 100px;
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

        .SLAcountNumber {
            cursor:pointer!important;
        }*/

    /*End of Added By Dipali V On 12th Aug 2020 For Loader Issues*/
    table.dataTable thead .sorting:after{display:none}
    .text-warning {color: #8a6d3b!important;}
    </style>
                                                                                                                                                                    
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bdySLADashboard">
    <!-- Content Wrapper. Contains page content -->
         <!-- Content Wrapper. Contains page content -->
   <%-- Added By Dipali V On 12th Aug 2020 for  loader issues--%>
       <div id="divSLADashboard" class="preloader">
      
         <div class="clsShowHide" id="maindiv">
    <%-- End of Added By Dipali V On 12th Aug 2020 for  loader issues--%>
    <div class="">        
        <div class="bgwhite container-fluid pt-1 pb-1">
            <div class="row">
                <div class="col-sm-9 form-inline selpro">
                    <% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-control'", False,,,,, True) %>

                    <% CommonFunctions.HTMLControls.DrawComboBox("CboUser", "usp_Whizible2_SLADashboard_DepartmentHRM_UserList " & Session("intUserID"),,, "class='form-control'", False,,,,,) %>
                    </div>
                <div class="col-sm-3 form-inline">
                    <span class="ClsNote">Note:- Only Open tickets will get displayed </span>
                </div>
            </div>
        </div>

        

       <%--Comment and added by imran on 18-01-2022--%>
       <%-- <div class="content bgwhite">--%>
        <div class="content bgwhite" id="chartcontainer">
       <%--End of Comment by imran on 18-01-2022--%>
            <div class="chartcontainer">
                <div class="row">
                    <div class="col-sm-9">
                        <div class="SLAcounts">
                            <div class="row row-eq-heights">
                                <div class="col-sm-3 pl-1">
                                    <div class="SLAcountbox">
                                        <div class="SLAcounttext"><%= MyBase.GetResourceString("C_SLALikelyToMiss") %></div>
                                        <div id="SLALikelyToMiss" class="SLAcountNumber text-warning"></div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="SLAcountbox">
                                        <div class="SLAcounttext"><%= MyBase.GetResourceString("C_SLAMissed") %></div>
                                        <div id="SLAMissed" class="SLAcountNumber text-red"></div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="SLAcountbox">
                                        <div class="SLAcounttext"><%= MyBase.GetResourceString("C_MySLATicketsInActive") %></div>
                                        <div id="MySLATicketsInActive" class="SLAcountNumber text-primary"></div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="SLAcountbox" id="clsSLATabActive">
                                        <div class="SLAcounttext"><%= MyBase.GetResourceString("C_TotalActiveTickets") %></div>
                                        <div id="TotalActiveTickets" class="SLAcountNumber text-primary"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="box defayltbox chartbox">
                            <div class="box-header with-border">
                                <h3 class="box-title"><%= MyBase.GetResourceString("C_TicketDistribution") %> <span style="font-size:9px!important">(Priority)</span></h3>
                            </div>
                            <div class="box-body">
                                <canvas id="PriorityProjects" width="220" height="110"></canvas>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="clearfix"></div>
            </div>

            <table class="table table-bordered ProjectSLAtbl" style="width: 100%">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("C_ID") %></th>
                        <th><%= MyBase.GetResourceString("C_Status") %></th>
                        <th><%= MyBase.GetResourceString("C_Subject") %></th>
                        <th><%= MyBase.GetResourceString("C_Priority") %></th>
                        <th><%= MyBase.GetResourceString("C_RequestType") %></th>
                        <th><%= MyBase.GetResourceString("C_Requestor") %></th>
                        <th><%= MyBase.GetResourceString("C_RequestedOn") %></th>
                        <th><%= MyBase.GetResourceString("C_LastUpdated") %></th>
                        <th><%= MyBase.GetResourceString("C_AssignedTo") %></th>
                    </tr>
                </thead>
                <tbody id="tbodyProjectData">
                </tbody>
            </table>
            <div class="SLAcounttext" style="text-align: center" id="lblMessage"></div>
        </div>
    </div>
    <!-- /.content -->
     <%-- Added By Dipali V On 12th Aug 2020 for  loader issues--%>
       </div>
      </div>
    <%-- End of Added By Dipali V On 12th Aug 2020 for  loader issues--%>


     <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->

    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../General/CommonValidations.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script type="text/javascript">
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        //close widget
        $(".dashclosewidget").click(function () {
            $(".widget_category_panel").removeClass("in");
        });
        
        //display email template
        function emailtemp() {
            var myWindow = window.open("email_template.html", "", "width=650,height=600");
        }

        $("[data-bs-toggle='tooltip']").tooltip();
        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".chcktbl").click(function () {
            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }
        });
        
        //Popover script start here
        $(window).on("load", function () {   
            $('.user').each(function () {
                var $this = $(this);
                $this.popover({
                    trigger: 'hover',
                    placement: 'right',//left
                    html: true,
                    content: $this.find('.userInfo').html()
                });
            });
        });
        //Popover script end here

        //Added By Nilesh For Active Count Tab 
        $(".col-sm-3 .SLAcountbox").click(function (e) {
            e.preventDefault();
            $(this).addClass("active");
            $(".col-sm-3 .SLAcountbox").not($(this)).removeClass("active");
            var flagval = 0
            if (e.target.id == "SLALikelyToMiss")
                flagval = 1;
            else if (e.target.id == "SLAMissed")
                flagval = 2;
            else if (e.target.id == "MySLATicketsInActive")
                flagval = 3;
            else if (e.target.id == "TotalActiveTickets")
                flagval = 4;
            getSLADetailsGridOfTabClick(flagval);
        });

        //Added By Vishal M 05-03-2020
        var ProjectID = 0;
        var LoginId = 0
        LoginId = '<%= Session("intUserID") %>';
        $(document).ready(function () {
           /*Added & Commented By Dipali V On 12th Aug 2020 For Loader Issues*/
               $("#divSLADashboard").removeClass("center");
               $("#divSLADashboard").removeClass("preloader");
               $("#maindiv").removeClass('clsShowHide');
           /*End of Added & Commented By Dipali V On 12th Aug 2020 For Loader Issues*/
            
            StartLoader("#bdySLADashboard");
             // Commented & added By Dipali V on 11th  Oct 2021 For check User already exsist
            // $('#CboUser').val(LoginId);
            var exists = false;
            $('#CboUser option').each(function () {
                if (this.value == LoginId) {
                    exists = true;
                    return false;
                }
            });
            if (exists == true) {
                $('#CboUser').val(LoginId);
            }
            // End of Comented & added By Dipali V on 11th  Oct 2021 For check User already exsist

            getSLADetails();
            $("#BtnMyPulse").click(function () {
                getSLADetails();
            });
           
            //if ($('#CboUser option').length == 2)
            if ($('#CboUser option').length <= 2)
                $('#CboUser').prop("disabled", true);
            else
                $('#CboUser').prop("disabled", false);

            $(".col-sm-3 .SLAcountbox").removeClass("active");
            $("#clsSLATabActive").removeClass("SLAcountbox").addClass("SLAcountbox active");
            StopAjaxLoader("#bdySLADashboard");
        });


        function DownloadReport(ReportFormat) {
            StartLoader("#bdySLADashboard");
            if ($('#CboUser').val() != 0) {
                var taskparameters = {
                    Filter: "",
                    ReportFormat: ReportFormat,
                    UserID: $('#CboUser').val() //'<%= Session("intUserID") %>'
                }
                console.log(JSON.stringify(taskparameters));
                console.log('bearer ' + sessionStorage.getItem("access_token-I"));
                $.ajax({
                    url: strUrl + '/api/PM_SLADashboard/ExportDocument',
                    type: "POST",
                    data: JSON.stringify(taskparameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (taskparameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                        }
                    },
                    success: function (data) {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })
                StopAjaxLoader("#bdySLADashboard");
            }

        }

        /*
      * Created Date     :   05 March 2020
      * Purpose          :   Fill Projects
      * Author           :   Vishal Mahajan
      * **/
        function fillprojectname() {
            var defaultFilterParameters = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                ProjectID: encodeURI('<%= Session("intProjectID") %>')
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_SLADashboard/GetProjectDropDown',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {
                },
                error: function (ER) {
                    alert(ER);
                }
            });
        }

        $("#CboUser").change(function () {
            StartLoader("#bdySLADashboard");//Added By  Dipali V On 21st Aug 2020 For Loader Issues
            getSLADetails();
            StopAjaxLoader("#bdySLADashboard");//Added By  Dipali V On 21st Aug 2020 For Loader Issues
            $(".col-sm-3 .SLAcountbox").removeClass("active");

            $("#clsSLATabActive").removeClass("SLAcountbox").addClass("SLAcountbox active");
        });


        function FillUsers() {
            $("#CboUser").html("");
            $("#CboUser").append('<option value="0">--Select User--</option>');
            var defaultFilterParameters = {
                ProjectID: ProjectID
            };

           // alert(ProjectID);
            if (ProjectID != "0") {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_SLADashboard/GetProjectUserDropDown',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(defaultFilterParameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (defaultFilterParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        $.each(result, function () {
                            $("#CboUser").append($("<option></option>").val(this['EmployeeID']).html(this['EmployeeName']));
                        });
                    },
                    error: function (ER) {
                        alert(ER);
                    }
                });
            }
        }

        //get data as per tab click
        function getSLADetailsGridOfTabClick(pf)
        {
            StartLoader("#bdySLADashboard");
            if (LoginId == null) {
                LoginId = 0;
            }
            var paramitersForSLADDashboardFilter = {
                ProjectFilter: pf,
                ProjectID: ProjectID,
                UserID: $("#CboUser").val(),
                LoginID: LoginId
            }           
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_SLADashboard/GetGridSLATicketsDataOnTabClick',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForSLADDashboardFilter),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (paramitersForSLADDashboardFilter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForSLADDashboardFilter) ? paramitersForSLADDashboardFilter : JSON.stringify(paramitersForSLADDashboardFilter)));
                    }
                },
                success: function (result) {
                    getProjectData(result, 2);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bdySLADashboard");
        }

        //start get all SLADetails
        function getSLADetails()
        {
            if (LoginId == null) {
                LoginId = 0;
            }           
            //Added by imran on 18-01-2022
            if ($("#CboUser").val() != 0) {
                var paramitersForSLADDashboardFilter = {
                    ProjectFilter: $("#chkAllProjects").is(":checked") ? "A" : "P",
                    ProjectID: ProjectID,
                    UserID: $("#CboUser").val(),
                    LoginID: LoginId
                }

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_SLADashboard/GetSLADetails',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    data: JSON.stringify(paramitersForSLADDashboardFilter),
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (paramitersForSLADDashboardFilter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(paramitersForSLADDashboardFilter) ? paramitersForSLADDashboardFilter : JSON.stringify(paramitersForSLADDashboardFilter)));
                        }
                    },
                    success: function (result) {
                        if (result != null || result != undefined) {
                            $("#SLALikelyToMiss").text(result.SLALikelyToMiss);
                            $("#SLAMissed").text(result.SLAMissed);
                            $("#MySLATicketsInActive").text(result.MySLATicketsInActive);
                            $("#TotalActiveTickets").text(result.TotalActiveTickets);
                        } else {
                            $("#SLALikelyToMiss").text('0');
                            $("#SLAMissed").text('0');
                            $("#MySLATicketsInActive").text('0');
                            $("#TotalActiveTickets").text('0');
                        }
                        getTicketDistribution(result);
                        getProjectData(result, 1);
                    },
                    error: function (err) {

                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            //Added by imran on 18-01-2022
            else {
                //$("#chartcontainer").hide();
                $('.ProjectSLAtbl').DataTable().destroy();
                $('#tbodyProjectData').html('');
                $('.ProjectSLAtbl').DataTable({
                    "paging": true,
                   /* "ordering": true,*/
                    "pageLength": 5,
                    "bRetrieve": true,
                    "scrollX": true,
                    "searching": false,
                    "lengthChange": false,
                    "columnDefs": [{ orderable: true, targets: [0] }]
                });
                setTimeout(function () {
                    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                }, 350);
            } 
            //End Of Comment by imran on 18-01-2022
        }
        //end get all SLADetails

        //start Priority Projects ends here
        var myTicketDistributionChart;
        function getTicketDistribution(data) {

            var getTicketDistributionObj;
            if (data != null || data != undefined) {
                getTicketDistributionObj = data.TicketDistribution;
            } else {
                getTicketDistributionObj = null;
            }
            var TicketDistribution = document.getElementById("PriorityProjects");
            var TicketDistributiondata;

            if (getTicketDistributionObj != null) {
                TicketDistributiondata = {
                    labels: getTicketDistributionObj.Type,
                    datasets: [{
                        label: '# of Tomatoes',
                        data: getTicketDistributionObj.TypeData,
                        backgroundColor: getTicketDistributionObj.ColorCode,//getBackgoundColorForTicketDistribution(getTicketDistributionObj.Type),
                        borderColor: getTicketDistributionObj.ColorCode,//getBackgoundColorForTicketDistribution(getTicketDistributionObj.Type),
                        borderWidth: 1,
                    }]
                };
            } else {
                TicketDistributiondata = {
                    labels: [],
                    datasets: [{
                        label: '# of Tomatoes',
                        data: [],
                        backgroundColor: [],
                        borderColor: [],
                        borderWidth: 1,
                    }]
                };
            }
            if (myTicketDistributionChart != undefined && myTicketDistributionChart != null) {
                myTicketDistributionChart.destroy();
            }
            myTicketDistributionChart = new Chart(TicketDistribution, {
                //type: 'pie',
                type:'doughnut',
                data: TicketDistributiondata,
                options: {
                    cutout: 45,
                    responsive: false,
                    plugins: {
                       
                        legend: {
                            display: true,
                            position: 'right',                            
                            labels: {
                                fontColor: "#000080",
                                boxWidth: 15,
                            }
                        },
                    },
                    
                }
            });
        }
        //end Priority Projects ends here

        //start bind SLA project data into table
        function getProjectData(data, val) {
            var projectList;
            if ((data != null || data != undefined) && val == 1) {
                projectList = data.ProjectData;
            } else if ((data != null || data != undefined) && val == 2) {
                projectList = data;
            } else {
                projectList = null;
            }
            $('.ProjectSLAtbl').DataTable().destroy();
            $('#tbodyProjectData').html('');

            var Body = "";

            if (projectList != null) {
                if (projectList.length != 0) {
                    $('.ProjectSLAtbl').show();
                    $('#lblMessage').hide();
                    $.each(projectList, function (index, item) {
                        //Commented & added By Dipali V On 12th Aug 2020 To remove selection
                        //var tr = '<tr><td>' +
                        //    '<div class="custom_chckbox">' +
                        //    '<input type="checkbox" id="chk' + item.ID + '" class="chcktbl">' +
                        //    '<label for="chk' + item.ID + '"></label>' +
                        //    '</div></td>';
                        var tr = '<tr>';
                        //End of Commented By Dipali V On 12th Aug 2020 To remove selection
                        tr += '<td class="text-left dropdown PRrolename">' + item.ID + '</td>';
                        //tr += '<td><button type="button" class="btn btn-primary">' + item.Status + '</button></td>';
                        tr += '<td>' + item.Status + '</td>';
                        tr += '<td>' + item.Subject + '</td>';
                        tr += '<td>' + item.Priority + '</td>';
                        tr += '<td>' + item.RequestType + '</td>';
                        tr += '<td>' + item.Requestor + '</td>';
                        tr += '<td class="scheduleprogress">' + item.RequestedOn + '</td>';
                        tr += '<td>' + item.LastUpdated + '</td>';
                        if (item.AssignedToFullName == "-") {
                            tr += '<td></td>';
                        } else {
                            var assignedTo = '<td>' +
                                '<span class="usernameshort circle-bggreen" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" data-bs-original-title="' + item.AssignedToFullName + '">' + item.AssignedTo + '</span></td>' +
                                '</td>';
                            tr += assignedTo;
                        }

                        var SLAactions = '<td class="SLAactions"><div class="">';
                        var mail = '<a href="javascript:;" onclick="emailtemp()">' +
                            '<img src="../../../Whizible2.0/dist/img/mail.svg" width="16px" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-title="mail"></a>';
                        var flag = '<a href="javascript:;">' +
                            '<img src="../../../Whizible2.0/dist/img/flag.svg" width="16px" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-title=""></a>';
                        var edit = '<a href="javascript:;">' +
                            '<img src="../../../Whizible2.0/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-title="Edit"></a>';
                        SLAactions += mail;
                        SLAactions += flag;
                        SLAactions += edit;
                        SLAactions += ' </div></td>';
                        tr += '</tr>';
                        Body += tr;
                    });


                    $('#tbodyProjectData').append(Body);
                    $('.ProjectSLAtbl').DataTable({
                        "paging": true,
                        "ordering": true,
                        "pageLength": 5,
                        "bRetrieve": true,
                        "scrollX": true,
                        "searching": false,
                        "lengthChange": false,
                        "columnDefs": [{ orderable: true, targets: [0] }]
                    });
                    setTimeout(function () {

                        $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                    }, 350);

                    $('[data-bs-toggle="tooltip"]').tooltip();
                    $('[data-bs-toggle="popover"]').popover();
                }
                else {
                     
                    <%--$('.ProjectSLAtbl').hide();
                    $('#lblMessage').show();
                    $('#lblMessage').html("<%= MyBase.GetResourceString("C_NoData") %>")--%>
                    $('#tbodyProjectData').append(Body);
                    $('.ProjectSLAtbl').DataTable({
                        "paging": true,
                        "ordering": true,
                        "pageLength": 5,
                        "bRetrieve": true,
                        "scrollX": false,
                        "searching": false,
                        "lengthChange": false,
                        "columnDefs": [{ orderable: true, targets: [0] }]
                    });
                }
            } else {

                $('#tbodyProjectData').append(Body);
                $('.ProjectSLAtbl').DataTable({
                    "paging": true,
                    "ordering": true,
                    "pageLength": 5,
                    "bRetrieve": true,
                    "scrollX": false,
                    "searching": false,
                    "lengthChange": false,
                    "columnDefs": [{ orderable: true, targets: [0] }]
                });
            }
        }
        //end bind SLA project data into table


        function getBackgoundColorForTicketDistribution(data) {

            if (data.length > 0) {
                var colors = [];
                var i = 0;
                var length = data.length;
                while (i < length) {
                    colors[i] = getColorByText(data[i]);
                    i++;
                }
                return colors;
            } else {
                return [];
            }
        }

        function getColorByText(text) {
            
            if (text != undefined && text != null) {
                if (Trim(text).toLowerCase() == 'high' || Trim(text).toLowerCase() == 'critical') {
                    return 'rgba(235, 28, 36, 1)';
                }
                else if (Trim(text).toLowerCase() == 'medium' || Trim(text).toLowerCase() == 'penalty') {
                    return 'rgba(54, 162, 235, 1)';
                }
                else if (Trim(text).toLowerCase() == 'low' || Trim(text).toLowerCase() == 'low priority') {
                    return 'rgba(255, 206, 86, 1)';
                }
                else {
                    return '';
                }
            } else {
                return '';
            }
        }
         //end by Vishal M 
    </script>



</body>
</html>
