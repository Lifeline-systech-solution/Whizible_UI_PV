<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectDashBoardNew.aspx.vb" Inherits="PbNIT.ProjectDashBoardNew" %>

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

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />


    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/project-dashboard.css">



    <!-- alertify -->
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>



   


</head>
     <style>
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

        body .ProjectHelathTbl tr th:nth-child(2) {
            min-width: 280px
        }

        body .ProjectHelathTbl tr th:nth-child(10) {
            min-width: 110px
        }

        .ProjectHelathTbl tr th {
            vertical-align: middle !important
        }

        .statusIndicator {
            background: #f5f5f5;
            width: 30px;
            height: 30px;
            line-height: 30px;
            border-radius: 50%;
            font-weight: 500;
            margin: 0 auto
        }

            .statusIndicator.statusIndicator_yellow {
                background: #ffc533
            }

            .statusIndicator.statusIndicator_red {
                background: #eb1c24;
                color: #fff
            }

            .statusIndicator.statusIndicator_green {
                background: #9dd824;
                color: #fff
            }

            .statusIndicator.statusIndicator_orange {
                background: #fbb03b;
                color: #ffffff
            }

            .statusIndicator.statusIndicator_nocolor {
                background: #eeeeee;
            }





        .progress {
            background: #ccc
        }

        body .ProjectHelathTbl tr td.scheduleprogress {
            min-width: 300px
        }

        .scheduleprogress .progress-bar-danger {
            background: #eb1c24
        }

        .scheduleprogress .progress-bar-warning {
            background: #ffc533
        }

        .scheduleprogress .progress-bar-success {
            background: #9dd824
        }

        .scheduleprogress .progress-bar {
            line-height: 16px
        }

        .ProjectHelathTbl tr th:not(:first-child), .ProjectHelathTbl tr td:not(:first-child) {
            min-width: 100px
        }

        /*.addwidgetlink {
            font-weight: 500
        }*/

        .userInfo {
            display: none;
            min-width: 300px
        }

        .PRrolename .popover {
            min-width: 300px
        }

        .userInfo h4 {
            margin: 0;
            font-weight: 700
        }

        .PL_statusline {
            position: absolute;
            right: 10px;
            height: 20px;
            top: 5px
        }

        /*added by vidhi form combobox*/
        select.bs-select-hidden, select.selectpicker {
            display: block !important;
            width: 100px;
        }
        /*End added by vidhi form combobox*/



        .PL_statuslineHigh {
            background: #eb1c24;
            position: absolute;
            right: 10px;
            height: 20px;
            top: 5px
        }

        .PL_statuslineMedium {
            background: #ffc533;
            position: absolute;
            right: 10px;
            height: 20px;
            top: 5px
        }

        .PL_statuslineLow {
            background: #9dd824;
            position: absolute;
            right: 10px;
            height: 20px;
            top: 5px
        }



        body .ProjectHelathTbl tr:hover, body .ProjectHelathTbl tr:focus {
            background: #eef9ff;
        }

        .selpro .dropdown-menu {
            max-height: 400px !important;
            overflow-y: auto;
        }

        table.dataTable thead th:first-child::after {
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

        .scheduleprogress .progress {
            position: relative;
            height: 16px;
        }

            .scheduleprogress .progress > .progress-type {
                position: absolute;
                left: 0px;
                font-weight: 800;
                font-size: 11px;
                padding: 0px 30px 0px 5px;
                color: #FFF;
                /*background-color: rgba(25, 25, 25, 0.2);*/
                background: #9dd824;
            }

            .scheduleprogress .progress > .progress-completed {
                position: absolute;
                right: 0px;
                font-weight: 800;
                color: #000;
                padding: 0px 10px 1px;
            }

        .scheduleprogress .progress-type {
            top: 1px;
        }

        .scheduleprogress .progress-completed {
            font-size: 12px;
        }

        .progressbar_current {
            background: #ffc533;
        }

        table.dataTable thead th:first-child {
            padding-right: 8px;
        }
        /**/
        ul.scheduleprogress {
            margin: 0;
            padding: 0;
            text-align: left;
        }

            ul.scheduleprogress label {
                font-size: 12px;
                margin: 0;
                float: left;
                width: 50px;
            }

        .table tr td ul.scheduleprogress .progress {
            margin-top: 5px;
            float: left;
            width: 80%;
        }

        ul.scheduleprogress .progress {
            height: 5px;
            margin-bottom: 16px;
            background: #f5f5f5;
            margin-top: 0;
        }

        .table tr td .progress {
            margin-top: 0;
        }

        .scheduleprogress li {
            margin-bottom: 3px;
            display: block;
            clear: both;
        }

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

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

        .widget_category_panelbody {
            background: #fff;
            border-bottom: 1px solid #ddd;
        }

        .widgetcatbox:hover {
            background: #f5f5f5;
            box-shadow: 5px 3px 8px 1px #ccc;
            color: #464a4c;
        }

        .progress-bar.progress-bar-gray {
            background: #ccc;
        }

        .progress-bar.progress-bar-info {
            background: #008bcc;
        }


        /*Added By Vidhi for alert*/
        .alertify-notifier {
            z-index: 99999;
        }

        /*End by Vidhi*/



        /*Added By Dipali V On 12th Aug 2020 For Loader Issues*/
/*        .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
             border: 3px solid #ababab; 
             box-shadow: 1px 1px 10px #ababab; 
            border-radius: 15px;
            background: #ddd;
             background-color: white; 
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
             background: url(../../../Whizible2.0-new/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat; 
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }*/

       /* .clsShowHide {
            display: none !important;
        }*/


        .ClsNoData {
            text-align: center !important;
        }

        added form priority project window
        .arrowdisabled {
            cursor: no-drop;
        }

            .arrowdisabled a {
                pointer-events: none;
            }

        .custmodal .custom_chckbox label:before {
            border-color: #464a4c;
            margin-right: 0;
        }

        .input-sm button.btn.dropdown-toggle {
            height: 30px;
        }

        #PreProjecttbl tr td:nth-child(2n) {
            text-align: left;
        }



        /*End of Added By Dipali V On 12th Aug 2020 For Loader Issues*/


        #PreProjecttbl tr th:nth-child(3), #PreProjecttbl tr th:nth-child(4) {
            min-width: 100px;
        }

        /*.alertify-notifier {
            z-index: 99999 !important;
        }*/

        /*simple pagination style*/
        .simple-pagination {
            display: inline-block;
            padding-left: 0;
            margin-top: 1rem;
            margin-bottom: 1rem;
            border-radius: .25rem
        }

            .simple-pagination li {
                display: inline
            }

            .simple-pagination .page-link, .simple-pagination .ellipse, .simple-pagination .current {
                display: inline-block;
                position: relative;
                float: left;
                padding: .5rem .75rem;
                margin-left: -1px;
                color: #0275d8;
                text-decoration: none;
                background-color: #fff;
                border: 1px solid #ddd
            }

            .simple-pagination li:first-child .page-link {
                margin-left: 0;
                border-bottom-left-radius: .25rem;
                border-top-left-radius: .25rem
            }

            .simple-pagination li:last-child .page-link {
                border-bottom-right-radius: .2rem;
                border-top-right-radius: .2rem
            }

            .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                z-index: 2;
                color: #fff;
                cursor: default;
                background-color: #0275d8;
                border-color: #0275d8
            }

                .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                    background: #1359ac;
                }
        /*End of pagination style*/
        #PreProModalpopup .modal-dialog {
            width: 840px;
        }

        #PreProjecttbl tr th:last-child {
            min-width: 100px;
        }

        #PreProjecttbl tr th {
            min-width: 84px;
        }

        /*Added By Dipali V On 13th Oct 2021 For Align Issue*/
        #CboBGInSideMPopUP {
            width:124px!important;
        }

         #CboOUInSideMPopUP {
            width:124px!important;
        }
       /*End of Added By Dipali V On 13th Oct 2021 For Align Issue*/
   
     .dataTables_scrollBody thead .sorting:after {display: none;}   
    </style>


<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bdyNewProjectDashBoard">

    <!-- Content Wrapper. Contains page content -->
    <%-- Added By Dipali V On 12th Aug 2020 for  loader issues--%>
    <div id="divProjectDashboard" class="preloader">

        <div class="clsShowHide" id="maindiv">
            <%-- End of Added By Dipali V On 12th Aug 2020 for  loader issues--%>
            <div class="">
                <!-- Content Header (Page header) -->
                <!-- Main content -->
                <div class="graybg container-fluid pt-1 pb-1 headertopp clearfix">
                    <ul class="float-start">
                        <li class="inline-block">
                            <div class="radio">
                                <input type="radio" id="chkPremiumProjects" name="radio-group" value="P" checked="checked">
                                <label for="chkPremiumProjects">Premium Projects</label>

                            </div>
                        </li>
                        <li class="inline-block">
                            <div class="radio">
                                <input type="radio" id="chkAllProjects" name="radio-group" value="A">
                                <label for="chkAllProjects">All</label>
                            </div>
                        </li>
                    </ul>
                    <ul class="float-end">
                        <li class="">
                            <%--<a href="javascript:;" data-bs-toggle="collapse" data-bs-target="#dashwidget" class="btn nostylebtn"><i class="fas fa-plus-square"></i>Add Widget</a>
                            --%>
                        </li>
                    </ul>
                </div>

                <!--widget wrapper start here-->
                <div class="widget_category_panel collapse" id="dashwidget">
                    <div class="widget_category_panelbody">
                        <button type="button" class="btn btn-box-tool dashclosewidget">
                            <img src="../../../Whizible2.0-new/dist/img/close-gray.svg" width="16px" alt="" title="" />
                        </button>

                        <div class="widgetheader">
                            <h4>Widget category title</h4>
                        </div>
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="widgetcatbox">
                                    <div class="widgetcat_title">Milestone One</div>
                                    <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                    <div class="widgetcategory_Action">
                                        <span class="selectwidget"><i class="fas fa-check"></i></span>
                                        <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                    </div>

                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="widgetcatbox selected">
                                    <div class="widgetcat_title">Milestone two</div>
                                    <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                    <div class="widgetcategory_Action">
                                        <span class="selectwidget"><i class="fas fa-check"></i></span>
                                        <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="widgetcatbox">
                                    <div class="widgetcat_title">Milestone three</div>
                                    <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                    <div class="widgetcategory_Action">
                                        <span class="selectwidget"><i class="fas fa-check"></i></span>
                                        <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="widgetcatbox">
                                    <div class="widgetcat_title">Milestone four</div>
                                    <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                    <div class="widgetcategory_Action">
                                        <span class="selectwidget"><i class="fas fa-check"></i></span>
                                        <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="widgetcatbox">
                                    <div class="widgetcat_title">Milestone five</div>
                                    <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                    <div class="widgetcategory_Action">
                                        <span class="selectwidget"><i class="fas fa-check"></i></span>
                                        <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="widgetcatbox">
                                    <div class="widgetcat_title">Milestone six</div>
                                    <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                    <div class="widgetcategory_Action">
                                        <span class="selectwidget"><i class="fas fa-check"></i></span>
                                        <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
                <!--widget wrapper end here-->


                <div class="bgwhite container-fluid pt-1 pb-1">
                    <div class="row">
                        <div class="col-sm-6 form-inline selpro">
                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-control'", False,, ) %>--%>

                            <% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "Select  'Select Project' ", 200,, "class='form-select'", False,, ) %>
                           <%-- <% CommonFunctions.HTMLControls.DrawComboBox("txtRAFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-select"" onChange=""FillFilterOUForFilter(this.value)""",,,, ,)%>--%>

                            <%--<select class="form-control" id="CboUser" name="CboUser">
                        <option value="0">Select User</option>
                    </select>--%>
                            <%--<button data-bs-toggle="tooltip" data-bs-placement="bottom" id="BtnMyPulse" title="MY Pulse" class="btn borderbtn">My Pulse</button>--%>
                        </div>
                        <div class="col-sm-6 form-inline text-end">
                            <%--<button data-bs-toggle="tooltip" data-bs-placement="bottom" title="Generate Report" class="btn borderbtn float-end">Generet Report</button>--%>
                            <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#PreProModalpopup" onclick="LoadAllAccessibleProject()">Set Premium / Priority</a>
                        </div>

                    </div>
                </div>


                <div class="content bgwhite">
                    <div class="chartcontainer">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="box defayltbox chartbox">
                                    <div class="box-header with-border">
                                        <h3 class="box-title">Priority Projects</h3>
                                    </div>
                                    <div class="box-body">
                                        <canvas id="PriorityProjects" width="250" height="250"></canvas>
                                    </div>

                                </div>
                            </div>
                            <div class="col-sm-8">
                                <div class="box defayltbox chartbox">
                                    <div class="box-header with-border">
                                        <h3 class="box-title">Profitability %</h3>
                                        <span class="float-end"><i class="fas fa-angle-double-left" id="IDNetPrev" onclick="GetPrevNextData('5','Prev')" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Previous Records"></i><i class="fas fa-angle-double-right" id="IDNetNext" onclick="GetPrevNextData('5','Next')" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Next Records"></i></span>
                                    </div>

                                    <div class="box-body" id="bdynet">
                                        <canvas id="NetProfitability" width="700" height="320"></canvas>
                                    </div>
                                    <div id="NOData" style="height: 262px!important"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                    <table class="table table-bordered ProjectHelathTbl bgwhite" id="tblProjectData">
                        <thead>
                            <tr>
                                <th width="3%">
                                    <div class="custom_chckbox">
                                        <%--<input type="checkbox" id="HPAll" class="chckHead">
                                    <label for="HPAll"></label>--%>
                                    </div>
                                </th>
                                <th>Project List</th>
                                <th>Staff turnover</th>
                                <th>Scope CR request</th>
                                <th>Defect Density</th>
                                <th>Risk</th>
                                <th>Schedule</th>
                                <th>Schedule Variance</th>
                                <th>Cost Variance</th>
                                <th>Billing<span><small>Actual Planned</small></span></th>
                                <th>Profitability Percentage</th>

                            </tr>
                        </thead>
                        <tbody id="tbodyProjectData">
                        </tbody>
                    </table>
                </div>

                    <div class="clearfix"></div>
                </div>

                

            </div>
            <%-- Added By Dipali V On 12th Aug 2020 for  loader issues--%>
        </div>




    </div>
    <%-- End of Added By Dipali V On 12th Aug 2020 for  loader issues--%>

    <!-- /.content -->
    <!-- Add Certification Modal start here-->
    <div class="modal custmodal fade" id="PreProModalpopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Premium Project</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="Refresh()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body" style="padding: 30px;">
                    <div class="premiumProListwrap">
                        <div class="pb-1">
                            <div class="row">
                                <div class="col-sm-2">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboBGInSideMPopUP", "Select  'Select BG' ", ,, "class='form-select'", False,, ) %>


                                    <%--<select class="selectpicker form-control">
                                                <option>Select BG</option>
                                                <option>Business Group 1</option>
                                                <option>Business Group 2</option>
                                                <option>Business Group 3</option>
                                                <option>Business Group 4</option>
                                            </select>--%>
                                </div>
                                <div class="col-sm-2">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboOUInSideMPopUP", "Select  'Select OU' ", ,, "class='form-select'", False,, ) %>
                                    <%--<select class="selectpicker form-control">
                                                <option>Select OU</option>
                                                <option>Organization Unit 1</option>
                                                <option>Organization Unit 2</option>
                                                <option>Organization Unit 3</option>
                                                <option>Organization Unit 4</option>
                                            </select>--%>
                                </div>
                                <div class="col-sm-3">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboProjectInSideMPopUP", "Select  'Select Project' ", ,, "class='form-select'", False,, ) %>
                                    <%-- <select class="form-control selectpicker">
                                                <option>Whizible</option>
                                                <option>Timesheet</option>
                                                <option>HelpDesk</option>
                                            </select>--%>
                                </div>
                                <div class="col-sm-3">
                                    <div class="input-group">
                                        <input id="srchPPlist" type="text" class="search-query form-control" placeholder="Search" onkeyup="mysearchFunction()">
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button" style="height: 30px;">
                                                <span class=" glyphicon fa fa-search"></span>
                                            </button>
                                        </span>
                                    </div>
                                </div>

                                <div class="col-sm-1">
                                    <button class="btn btnyellow" onclick="CallInsertionFun()">Save</button>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive" style="max-height: 260px;">
                            <table id="PreProjecttbl" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Project Name</th>
                                        <th>Description</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Premium</th>
                                        <th>Priority</th>
                                    </tr>
                                </thead>
                                <tbody id="tbltbodyPreProjecttbl">

                                    <%--<div class="custom_chckbox">
                                                         <% CommonFunctions.HTMLControls.DrawCheckBox("PPcheckbox", "PPcheckbox") %>
                                                       
                                                        <label for="PPcheckbox"></label>
                                                        
                                                    </div> --%>
                                </tbody>
                            </table>

                            <div id="pagination" class="float-end"></div>



                        </div>

                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!-- Add Certification Modal End here-->

   <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->

    <!-- REQUIRED JS SCRIPTS -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>

    <%--<script src="../../../Whizible2.0-new/plugins/chartjs/chartjs-plugin-datalabels.js"></script>--%>
<%--	<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>

    <script src="../../General/CommonFunctions.js"></script>


<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <!--For Simple Pagination-->
    <script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>

    <!-- Alertify added by Vidhi-->
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

    <script type="text/javascript">
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        $("[data-bs-toggle='tooltip']").tooltip();
        $(".progress span, .progress div").hover(function () {
            $(this).parent().tooltip("disable");
        }, function () {
            $(this).parent().tooltip("enable");
        });

        //close widget
        $(".dashclosewidget").click(function () {
            $(".widget_category_panel").removeClass("in");
        });


        // Added By Vidhi to Refresh the page 
        function Refresh() {
            // alert("Refresh");
            window.location.reload(true);
        }
        // End of Added By Vidhi to Refresh the page 


        //check and uncheck checkbox
        // Check or Uncheck All checkboxes

        //$(".chckHead").change(function () {
        //    var checked = $(this).is(':checked');

        //    if (checked) {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", true);
        //        });
        //    } else {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", false);
        //        });
        //    }
        //});

        // Changing state of CheckAll checkbox
        //$(".chcktbl").click(function () {

        //    if ($(".chcktbl").length == $(".chcktbl:checked").length) {
        //        $(".chckHead").prop("checked", true);
        //    } else {
        //        $(".chckHead").removeAttr("checked");
        //    }

        //});



        //Added by Vidhi For checkbox 
        var premiumCheckboxValue;

        $("#tbltbodyPreProjecttbl").change(function () {
            // alert("ok");

            if ($('input[type="checkbox"]').is(":checked")) {
                premiumCheckboxValue = "1";

            } else if ($('input[type="checkbox"]').is(":not(:checked)")) {
                premiumCheckboxValue = "0";

            }

        });

        /// Ende of Added by Vidhi For checkbox 


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

        //Added by Dipali V on 10th Aug 2020 Tooltip 
        $('#tblProjectData tbody').on('mouseover', 'tr', function () {

            $('.user').each(function () {
                //debugger;
                var $this = $(this);
                var asc = $this.find('.userInfo').html();
                $this.popover({
                    trigger: 'hover',
                    placement: 'right',//left
                    html: true,
                    content: $this.find('.userInfo').html()

                });
            });
        });


        $('#tblProjectData tbody').on('mouseover', 'tr', function () {
            $('[data-bs-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                html: true
            });
        });
        //End of Added by Dipali V on 10th Aug 2020 Tooltip 



        //Search list
        function mysearchFunction() {
            var $rows = $('#PreProjecttbl tbody tr');
            $('#srchPPlist').keyup(function () {
                var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

                $rows.show().filter(function () {
                    var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                    return !~text.indexOf(val);
                    return !~text.indexOf(val);
                }).hide();
                $(".table").resize();
            });
        }
        //End Search list



        //Added By Vishal M 05-03-2020
        var selectedProjectDataDisplay = new Array();
        var selectedProjectDataDisplayInsidePopupWindow = new Array();
        var allSelectedDataInsidePopUpWindow = new Array();
        var deSelectionArray = new Array();
        var tempPremiumData;
        var tempAllData;
        var globalAction = "";
        var ProjectID = 0;
        var projectidInsidePop = 0;
        var stateofChk;
        var BusinessGroupIDG = 0;
        var LocationIDG = 0;
        var TempDataAfterBGSelected = new Array();
        var LoginId = '<%= Session("intLoginID") %>';

        $(document).ready(function () {
            //debugger;

            StartLoader("#bdyNewProjectDashBoard");
            $("#IDNetPrev").hide();
            globalAction = "";
            ListOfProject();
            getProjectDashboardDetails("0");
            /*Added & Commented By Dipali V On 12th Aug 2020 For Loader Issues*/
            $("#divProjectDashboard").removeClass("center");
            $("#divProjectDashboard").removeClass("preloader");
            $("#maindiv").removeClass('clsShowHide');
            /*End of Added & Commented By Dipali V On 12th Aug 2020 For Loader Issues*/
            //$("#BtnMyPulse").click(function () {
            //    getProjectDashboardDetails();
            //});

            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 350);




            StopAjaxLoader("#bdyNewProjectDashBoard");
        });




        $("#CboProject").on('change', function () {
            $('#tbodyProjectData').html('');
            globalAction = "";
            $("#IDNetPrev").hide();
            GlobalCount = "";
            selectedProjectDataDisplay = [];
            deSelectionArray = [];
            ProjectID = $("#CboProject").val();
            var ProjectFilter = document.querySelector('input[name="radio-group"]:checked').value;
            if (ProjectID == "0" || ProjectID == null) {
                ProjectID = "0";
            }
            // FillUsers();        
            getProjectDashboardDetails("0");
            if (ProjectID == 0) {
                // RemoveAllSelection(dataforsingleselection);
                if (ProjectFilter == 'A') {
                    getProjectData(allSelectedData);
                }
                else {
                    getProjectData(arrData);

                }
            } else {
                SelectedValueDisplay(dataforsingleselection);
            }
        });

        // added by Vidhi if user made selection from the drop down inside the pop up window


        $("#CboProjectInSideMPopUP").on('change', function () {
            $('#tbltbodyPreProjecttbl').html('');
            selectedProjectDataDisplayInsidePopupWindow = [];
            projectidInsidePop = [];
            ProjectID = $("#CboProjectInSideMPopUP").val();
            projectidInsidePop = ProjectID;
            //  StartLoader("#PreProModalpopup");

            if (ProjectID == "0" || ProjectID == null) {
                ProjectID = 0;
            }
            if (BusinessGroupIDG == 0) {
                //alert("NO")
                projectidInsidePop = [];
                projectidInsidePop = ProjectID;
                if (ProjectID == 0) {
                    DisplayProjectsInsidePopUpWindow(allSelectedDataInsidePopUpWindow);

                } else {

                    //StartLoader("#PreProModalpopup");
                    //test code
                    $("#pagination li").hide();
                    $("#pagination li.disabled, #pagination li.active, #pagination li:last-child").show();
                    //test code end
                    SelectedValueDisplayInsidePopupWindow(allSelectedDataInsidePopUpWindow);
                    // StopAjaxLoader("#PreProModalpopup");
                }
            }
            else {
                // alert(BusinessGroupIDG)BGOUFilterData

                if (LocationIDG == 0) {
                    // alert("NO");
                    projectidInsidePop = [];
                    projectidInsidePop = ProjectID;
                    if (ProjectID == 0) {
                        DisplayProjectsInsidePopUpWindow(DataAccordingToBG);

                    } else {
                        SelectedValueDisplayInsidePopupWindow(DataAccordingToBG);
                    }

                } else {
                    //  alert(LocationIDG);
                    //projectidInsidePop = [];
                    //projectidInsidePop = ProjectID;
                    if (ProjectID == 0) {
                        DisplayProjectsInsidePopUpWindow(BGOUFilterData);

                    } else {

                        SelectedValueDisplayInsidePopupWindow(BGOUFilterData);
                    }
                }


            }
            // StopAjaxLoader("#PreProModalpopup");

        });
        // End by Vidhi if user made selection from the drop down inside the pop up window

        // Added by vidhi for selecting BG inside the pop up window 
        $("#CboBGInSideMPopUP").on('change', function () {
            LoadAllOUInPopUP();
            selectedProjectDataDisplayInsidePopupWindow = [];
            // projectidInsidePop = [];
            BusinessGroupIDG = $("#CboBGInSideMPopUP").val();
            if (BusinessGroupIDG == "0" || BusinessGroupIDG == null) {
                BusinessGroupIDG = 0;
            }
            if (BusinessGroupIDG == 0) {
                $("#CboProjectInSideMPopUP").html("");
                $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                $.each(allSelectedDataInsidePopUpWindow, function () {
                    $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                });
                DisplayProjectsInsidePopUpWindow(allSelectedDataInsidePopUpWindow);
            } else {
                //test code
                // alert("testBG");
                $("#pagination li").hide();
                $("#pagination li.disabled, #pagination li.active, #pagination li:last-child").show();

                //test code end
                // write and call method which fetch data according to BG
                ListOfProjectAccordingToBGSelected();
            }
        });
        // End here by vidhi for selecting BG inside the pop up window

        //Added by Vidhi for selecting OU inside the pop up window
        $("#CboOUInSideMPopUP").on('change', function () {
            selectedProjectDataDisplayInsidePopupWindow = [];
            //projectidInsidePop = [];
            LocationIDG = $("#CboOUInSideMPopUP").val();
            if (LocationIDG == "0" || LocationIDG == null) {
                LocationIDG = 0;
            }
            if (LocationIDG == 0) {
                $("#CboProjectInSideMPopUP").html("");
                $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                $.each(DataAccordingToBG, function () {
                    $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                });
                DisplayProjectsInsidePopUpWindow(DataAccordingToBG);
            }
            else {
                //test code
                //  alert("testOU");
                $("#pagination li").hide();
                $("#pagination li.disabled, #pagination li.active, #pagination li:last-child").show();

                //test code end
                SelectedOUProjectDisplay(DataAccordingToBG);

            }
        });



        // End here by Vidhi for selecting OU inside the pop up window

        //function is for displaying selected value from drop down 
        function SelectedValueDisplay(data) {
            //alert("selected value");
            for (var j = 0; j <= data.length; j++) {
                var obj = data[j];
                var currentProjectID = obj.ProjectID;
                var selectedflag = obj.WhichType;
                var ProjectFilter = document.querySelector('input[name="radio-group"]:checked').value;
                if (ProjectID == currentProjectID) {
                    //debugger;                    
                    selectedProjectDataDisplay.push(obj);

                    //if (ProjectFilter == selectedflag) {
                    //    selectedProjectDataDisplay.push(obj);
                    //}
                }
                getProjectData(selectedProjectDataDisplay);
            }
        }
        //End  of function that remove the selection from dropdown and show all projects
        // Function added by Vidhi when user select one option from drop down inside the pop up window 
        function SelectedValueDisplayInsidePopupWindow(data) {

            for (var j = 0; j <= data.length; j++) {
                var obj = data[j];
                var currentProjectID = obj.ProjectID;
                //projectidInsidePop = [];
                //projectidInsidePop = currentProjectID;
                if (ProjectID == currentProjectID) {
                    selectedProjectDataDisplayInsidePopupWindow.push(obj);
                }

                DisplayProjectsInsidePopUpWindow(selectedProjectDataDisplayInsidePopupWindow);
                GetListOfProjectStatus(selectedProjectDataDisplayInsidePopupWindow);
            }

        }
        /// End of Function added by Vidhi when user select one option from drop down inside the pop up window 

        // added by Vidhi Function to fetch  project according to BG and OU
        var BGOUFilterData = new Array();
        function SelectedOUProjectDisplay(data) {
            for (var j = 0; j <= data.length; j++) {
                var obj = data[j];
                var locid = obj.LocationID;

                if (LocationIDG == locid) {
                    selectedProjectDataDisplayInsidePopupWindow.push(obj);
                }
                BGOUFilterData = selectedProjectDataDisplayInsidePopupWindow;

                if (selectedProjectDataDisplayInsidePopupWindow.length == 0) {
                    // alert("No data ");
                    var strHtml = "";

                    $('#tbltbodyPreProjecttbl').html('');
                    strHtml += '<tr>'
                    strHtml += '<td colspan="6">No data available in table</td>'
                    strHtml += '</tr>'
                    $("#tbltbodyPreProjecttbl").html("");
                    $("#tbltbodyPreProjecttbl").html(strHtml);

                } else {
                    $("#CboProjectInSideMPopUP").html("");
                    $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                    $.each(selectedProjectDataDisplayInsidePopupWindow, function () {
                        $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                    });

                    DisplayProjectsInsidePopUpWindow(selectedProjectDataDisplayInsidePopupWindow);
                    GetListOfProjectStatus(selectedProjectDataDisplayInsidePopupWindow);
                }
            }
        }
        /// End of added by Vidhi Function to fetch  project according to BG and OU

        function RemoveAllSelection(data) {
            for (var i = 0; i <= data.length; i++) {
                var obj = data[i];
                var selectedflag = obj.WhichType;
                var ProjectFilter = document.querySelector('input[name="radio-group"]:checked').value;
                if (ProjectFilter == selectedflag) {
                    deSelectionArray.push(obj);
                }
                getProjectData(deSelectionArray);
            }

        }

        $('input[name=radio-group]:radio').click(function () {
            GlobalCount = "";
            globalAction = "";
            selectedProjectDataDisplay = [];
            deSelectionArray = [];
            StartLoader("#bdyNewProjectDashBoard");
            $("#IDNetPrev").hide();
            var ProjectFilter = document.querySelector('input[name="radio-group"]:checked').value;
            if (ProjectFilter == 'P') {
                getProjectData(arrData);
                $("#CboProject").html("");
                $("#CboProject").append('<option value="0">Select Project</option>');
                $.each(arrData, function () {
                    $("#CboProject").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));
                });
            }
            else {
                getProjectData(allSelectedData);
                $("#CboProject").html("");
                $("#CboProject").append('<option value="0">Select Project</option>');
                $.each(allSelectedData, function () {
                    $("#CboProject").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                });
            }
            if (ProjectID != 0) {
                ProjectID = 0;
            }
            getProjectDashboardDetails("0");
            StopAjaxLoader("#bdyNewProjectDashBoard");
        });


        //Added by vidhi to access all the project inside the popup window
        function LoadAllAccessibleProject() {
            //StartLoader("#PreProModalpopup"); 
            ListOfProjectInsideThePopWindow();
            LoadAllBGInPopUP();
            // LoadAllOUInPopUP();
            GetListOfProjectStatus(allSelectedDataInsidePopUpWindow);
            // this  function is for pagination 
            $(function ($) {
                var items = $("#PreProjecttbl tbody tr.pgrow");

                var numItems = items.length;
                var perPage = 8;

                // Only show the first 2 (or first `per_page`) items initially.
                items.slice(perPage).hide();

                // Now setup the pagination using the `#pagination` div.
                $("#pagination").pagination({
                    items: numItems,
                    itemsOnPage: perPage,
                    cssStyle: "light-theme",

                    // This is the actual page changing functionality.
                    onPageClick: function (pageNumber) {
                        // We need to show and hide `tr`s appropriately.
                        var showFrom = perPage * (pageNumber - 1);
                        var showTo = showFrom + perPage;

                        // We'll first hide everything...
                        items.hide()
                            // ... and then only show the appropriate rows.
                            .slice(showFrom, showTo).show();
                    }
                });
            });
            // pagination code endede here

            //StopAjaxLoader("#PreProModalpopup");


        }
        // End by Vidhi to access all the project inside the popup window





        // Added by Vidhi to insert the selected value in table 
        function CallInsertionFun() {
            //debugger;
            var checkboxValues = new Array;
            var login = encodeURI('<%= Session("intUserID") %>');

            $('#tbltbodyPreProjecttbl input[Class=chcktbl]').map(function () {
                checkboxValues.push(this.id);
                // return this.id;
            }).get().join();

            var CheckBoxValueip;
            try {

                for (var i = 0; i < checkboxValues.length; i++) {

                    var s = checkboxValues[i];
                    CheckBoxID = s.replace("PPcheckbox", "");
                    //alert(CheckBoxID);


                    if ($("#" + s).prop("checked")) {
                        // alert("here");

                        CheckBoxValueip = 1;
                    } else {
                        CheckBoxValueip = 0;


                    }
                    //if ($("#" + s).change) {}


                    var priority = $("#CboPremiumCheckbox" + CheckBoxID).val();
                    if (priority == "High") {
                        priority = 1;
                    } if (priority == "Medium") {
                        priority = 2;
                    } if (priority == "Low") {
                        priority = 3;
                    }
                    //alert(CheckBoxID);
                    //alert(CheckBoxValueip);
                    //alert(priority);
                    var ListOfProjectParameter = {
                        ProjectID: CheckBoxID,
                        CreatedBy: login,
                        Priority: priority,
                        Premium: CheckBoxValueip,


                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/InsertDataIntoTable',// Path
                        type: "POST",                                       //HTTP TYPE get /post
                        data: JSON.stringify(ListOfProjectParameter),       // Parameters
                        dataType: "json",                                   //Retrun Type 
                        contentType: "application/json; charset=utf-8",     //
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (ListOfProjectParameter) {
                                xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                            }
                        },
                        async: false,
                        success: function (result) {
                            //debugger;
                            // alert("Saved Successfully");

                        },
                        error: function (ER) {
                            //alert(ER);
                            // alert(ER.responseText);
                        }
                    });




                }
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Saved Successfully.");
            }
            catch (ex) {
                // alert(ex.text);
            }



        }


        // End of  Added by Vidhi to insert the selected value in table 


        /*
     * Created Date     :   05 March 2020
     * Purpose          :   Fill Projects
     * Author           :   Vishal Mahajan
     * **/

        // function created by vidhi on 25-5-2020 to get the list of project depending on selection of radio button (A,P) added by vidhi

        var arrData = new Array();
        var allSelectedData = new Array();
        var dataforsingleselection;
        var ProjectFilter = document.querySelector('input[name="radio-group"]:checked').value;
        function ListOfProject() {
            // debugger;

            var ListOfProjectParameter = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                LoginID: encodeURI('<%= Session("intLoginID") %>'),
                // ProjectFilter: $('input[name="radio-group"]:checked').val(),
                Flag: ProjectID,

            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/DisplayGrid',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(ListOfProjectParameter),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ListOfProjectParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                    }
                },
                async: false,
                success: function (result) {
                    dataforsingleselection = result.ProjectData;
                    $("#tblProjectData").dataTable().fnDestroy();
                    $('#tbodyProjectData').html('');

                    allSelectedData = result.ProjectData;

                    $("#CboProject").empty();
                    $("#CboProject").append('<option value="0">Select Project</option>');
                    if (result != undefined) {

                        var Data = result.ProjectData;
                        for (var i = 0; i <= Data.length; i++) {

                            var obj = Data[i];
                            var selectedflag = obj.WhichType;
                            var ProjectName = obj.ProjectName;
                            var ProjectID = obj.ProjectID;
                            var ProjectFilter = document.querySelector('input[name="radio-group"]:checked').value;
                            if (ProjectFilter == selectedflag) {
                                $("#CboProject").append("<option value='" + ProjectID + "'>" + ProjectName + "</option>");
                                arrData.push(obj);
                            }
                        }
                    }
                },
                error: function (ER) {
                    //alert(ER);
                    //alert(ER.responseText);
                }
            });
            getProjectData(arrData);

        }

        // Added By Vidhi To Fetch the data for grid inside the pop up window

        function ListOfProjectInsideThePopWindow() {
            // debugger;
            /*if (Flag == undefined) { Flag=""}*/
            var ListOfProjectParameter = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                LoginID: encodeURI('<%= Session("intLoginID") %>'),
                Flag: ProjectID,

            }
            console.log(ListOfProjectParameter)
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/DisplayGridDataInsidePopUP',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(ListOfProjectParameter),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ListOfProjectParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                    }
                },
                async: false,
                success: function (result) {
                    //debugger; 
                    allSelectedDataInsidePopUpWindow = result;
                    $("#CboProjectInSideMPopUP").html("");
                    $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                    $.each(result, function () {
                        $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                    });

                    DisplayProjectsInsidePopUpWindow(result);

                },
                error: function (ER) {

                }
            });


        }
        // End Added By Vidhi To Fetch the data for grid inside the pop up window


        // Added by Vidhi to fetch data according to BG and bind to Grid inside the pop up window
        var DataAccordingToBG = new Array();

        function ListOfProjectAccordingToBGSelected() {
            // debugger;
            var ListOfProjectParameter = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                LoginID: encodeURI('<%= Session("intLoginID") %>'),
                BusinessGroupID: BusinessGroupIDG,

            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/FetchDataAccordingtoBG',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(ListOfProjectParameter),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ListOfProjectParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                    }
                },
                async: false,
                success: function (result) {
                    //debugger; 
                    DataAccordingToBG = result;
                    if (result.length == 0) {

                        var strHtml = "";

                        $('#tbltbodyPreProjecttbl').html('');
                        strHtml += '<tr>'
                        strHtml += '<td colspan="6">No data available in table</td>'
                        strHtml += '</tr>'
                        $("#tbltbodyPreProjecttbl").html("");
                        $("#tbltbodyPreProjecttbl").html(strHtml);


                    } else {


                        $("#CboProjectInSideMPopUP").html("");
                        $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                        $.each(result, function () {
                            $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                        });

                        DisplayProjectsInsidePopUpWindow(result);
                        GetListOfProjectStatus(result);
                    }

                },
                error: function (ER) {

                }
            });


        }

        // End of  Added by Vidhi to fetch data according to BG and bind to Grid inside the pop up window


        // Added by Vidhi to get the list of BG inside the pop up window
        function LoadAllBGInPopUP() {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/DisplayBG',// Path
                type: "POST",                                       //HTTP TYPE get /post             
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                async: false,
                success: function (result) {
                    //debugger;
                    $("#CboBGInSideMPopUP").html("");
                    $("#CboBGInSideMPopUP").append('<option value="0">Select BG</option>');
                    $.each(result, function () {
                        $("#CboBGInSideMPopUP").append($("<option></option>").val(this['BusinessGroupID']).html(this['BusinessGroup']));

                    });

                },
                error: function (ER) {
                    //alert(ER);
                    //alert(ER.responseText);
                }
            });

        }
        // End of  Added by Vidhi to get the list of BG inside the pop up window 

        //  Added by Vidhi to get the list of OU inside the pop up window 
        function LoadAllOUInPopUP() {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/DisplayOU',// Path
                type: "POST",                                       //HTTP TYPE get /post             
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                async: false,
                success: function (result) {
                    //debugger;
                    $("#CboOUInSideMPopUP").html("");
                    $("#CboOUInSideMPopUP").append('<option value="0">Select OU</option>');
                    $.each(result, function () {
                        $("#CboOUInSideMPopUP").append($("<option></option>").val(this['LocationID']).html(this['Location']));

                    });

                },
                error: function (ER) {
                    //alert(ER);
                    //alert(ER.responseText);
                }
            });

        }
        // End of Added by Vidhi to get the list of OU inside the pop up window 

        // Added by Vidhi to get the premium status of project
        var PremiumStatusHolder = new Array();
        var allSelectedDataInsidePopUpWindowProjectID = new Array();
        var NotPresentInNewTable = new Array();

        function GetListOfProjectStatus(Data) {

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/GetProjectStatus',// Path
                type: "POST",                                       //HTTP TYPE get /post             
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                async: false,
                success: function (result) {
                    //debugger;
                    PremiumStatusHolder = result;

                    for (var i = 0; i < Data.length; i++) {
                        // debugger;
                        var obj = Data[i];
                        var pid = obj.ProjectID;
                        for (var j = 0; j < PremiumStatusHolder.length; j++) {
                            var obj3 = PremiumStatusHolder[j];
                            var pppid = obj3.ProjectID;
                            var priostatus = obj3.Priority;
                            if (priostatus == "H") {
                                priostatus = 1;
                            } if (priostatus == "M") {
                                priostatus = 2;
                            } if (priostatus == "L") {
                                priostatus = 3;
                            }
                            if (priostatus == " ") {
                                priostatus = 0;
                            }

                            var statusP = obj3.Premium;
                            if (pid == pppid) {

                                if (statusP == true) {
                                    //$("#PPcheckbox" + pppid).prop("checked", true);
                                    //  $(this).attr("id", "#PPcheckbox" + pppid).prop('checked', true);                                  
                                    $("#PPcheckbox" + pppid).prop("checked", true);

                                }

                                //$("#CboPremiumCheck"  + pppid).val(2).attr("selected", "selected");
                                $("#CboPremiumCheckbox" + pppid + " option[value='" + priostatus + "']").prop('selected', true);
                                //$("#CboPremiumCheck" + pppid).val(priostatus).attr("selected", "selected");
                                // document.getElementById("#CboPremiumCheck" + pppid).value = priostatus

                            }

                        }


                    }


                },
                error: function (ER) {
                    //alert(ER);
                    //alert(ER.responseText);
                }
            });

        }



        // End by Vidhi to get the premium status of project




        // Added by vidhi for displaying thr users  currently this functionality is hide
       <%-- function FillUsers() {
            debugger;
            $("#CboUser").html("");
            $("#CboUser").append('<option value="0">Select User</option>');
            var userDataParameter = {
              // UserID: encodeURI('<%= Session("intUserID") %>'),
              // LoginID: encodeURI('<%= Session("intLoginID") %>'),
              // ProjectFilter: $('input[name="radio-group"]:checked').val(),
               Flag: ProjectID,
            };
            
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/GetProjectUserDropDown',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(userDataParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    },
                    async: false,
                    success: function (result) {
                        debugger;
                        $.each(result, function () {                       
                            $("#CboUser").append($("<option></option>").val(this['EmployeeID']).html(this['EmployeeName']));
                        });
                    },
                    error: function (ER) {
                        alert(ER);
                    }
                });
            
        }--%>


        //start get all ProjectDashboardDetails
        function getProjectDashboardDetails(Count) {
            
            StartLoader("#bdyNewProjectDashBoard");
            if (LoginId == null) {
                LoginId = 0;
            }
            if (Count == null) { Count=0 }
            var paramitersForSLADDashboardFilter = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                LoginID: encodeURI('<%= Session("intLoginID") %>'),
                ProjectFilter: $('input[name="radio-group"]:checked').val(),
                Flag: ProjectID,
                Rowcount: Count,
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/GetProjectDashboardDetails',
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
                    getPriorityProjects(result);
                    getNetProfitability(result);

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bdyNewProjectDashBoard");
        }



        //start Priority Projects ends here
        var mygetPriorityProjectsChart;
        function getPriorityProjects(data) {
            // debugger;
            var getPriorityProjectsObj;
            if (data != null || data != undefined) {
                getPriorityProjectsObj = data.PriorityProjects;
            } else {
                getPriorityProjectsObj = null;

            }
            var PriorityProjects = document.getElementById("PriorityProjects");
            var PriorityProjectsdata;
            // checking for null records when it is null display no data available message
            if (arrData.length == 0 && allSelectedData.length != 0) {
                if (document.querySelector('input[name="radio-group"]:checked').value == "P") {
                    mygetPriorityProjectsChart = new Chart(PriorityProjects, {
                        type: 'pie',
                        data: PriorityProjectsdata,
                        options: {
                            cutoutPercentage: 80,
                            responsive: false,
                            legend: {
                                display: true,
                                position: 'right',
                                labels: {
                                    fontColor: "#000080",
                                }
                            },
                        }
                    });
                }
                else {

                    if (getPriorityProjectsObj != null) {
                        PriorityProjectsdata = {
                            labels: getPriorityProjectsObj.Type,
                            datasets: [{
                                label: '# of Tomatoes',
                                data: getPriorityProjectsObj.TypeData,
                                backgroundColor: getBackgoundColorForPriorityProjects(getPriorityProjectsObj.Type),
                                borderColor: getBackgoundColorForPriorityProjects(getPriorityProjectsObj.Type),
                                borderWidth: 1,
                            }]
                        };
                    } else {
                        PriorityProjectsdata = {
                            labels: [],
                            datasets: [{
                                label: '# of Tomatoes',
                                data: [],
                                backgroundColor: [
                                ],
                                borderColor: [
                                ],
                                borderWidth: 1,
                            }]
                        };
                    }
                    if (mygetPriorityProjectsChart != undefined && mygetPriorityProjectsChart != null) {
                        mygetPriorityProjectsChart.destroy();
                    }
                    mygetPriorityProjectsChart = new Chart(PriorityProjects, {
                        type: 'pie',
                        data: PriorityProjectsdata,
                        options: {
                            cutoutPercentage: 80,
                            responsive: false,
                            legend: {
                                display: true,
                                position: 'right',
                                labels: {
                                    fontColor: "#000080",
                                }
                            },
                        }
                    });


                }
            }
            else {
                if (getPriorityProjectsObj != null) {
                    PriorityProjectsdata = {
                        labels: getPriorityProjectsObj.Type,
                        datasets: [{
                            label: '# of Tomatoes',
                            data: getPriorityProjectsObj.TypeData,
                            backgroundColor: getBackgoundColorForPriorityProjects(getPriorityProjectsObj.Type),
                            borderColor: getBackgoundColorForPriorityProjects(getPriorityProjectsObj.Type),
                            borderWidth: 1,
                        }]
                    };
                } else {
                    PriorityProjectsdata = {
                        labels: [],
                        datasets: [{
                            label: '# of Tomatoes',
                            data: [],
                            backgroundColor: [
                            ],
                            borderColor: [
                            ],
                            borderWidth: 1,
                        }]
                    };
                }
                if (mygetPriorityProjectsChart != undefined && mygetPriorityProjectsChart != null) {
                    mygetPriorityProjectsChart.destroy();
                }
                mygetPriorityProjectsChart = new Chart(PriorityProjects, {
                    type: 'pie',
                    data: PriorityProjectsdata,
                    options: {
                        cutoutPercentage: 80,
                        responsive: false,
                        legend: {
                            display: true,
                            position: 'right',
                            labels: {
                                fontColor: "#000080",
                            }
                        },
                    }
                });
            }


        }
        //end Priority Projects ends here

        //start Net Profitability
        var myNetProfitabilityChart;
        function getNetProfitability(data) {
            //debugger;

            var getNetProfitabilityObj;
            if (data != null || data != undefined) {
                //debugger;
                getNetProfitabilityObj = data.NetProfitability;

            } else {
                // debugger;
                getNetProfitabilityObj = null;

            }
            // for previous next logic on the graph 
            if (document.querySelector('input[name="radio-group"]:checked').value == "P") {
                if (arrData.length <= 5) {
                    $("#IDNetNext").hide();
                    $("#IDNetPrev").hide();
                } else {
                    if (globalAction <= 5) {
                        $("#IDNetNext").show();
                        $("#IDNetPrev").hide();
                    }
                    else {
                        $("#IDNetNext").show();
                        $("#IDNetPrev").show();
                    }

                }
                if (globalAction != "") {
                    Getshowhidebutton(arrData.length);
                }
            }
            if (document.querySelector('input[name="radio-group"]:checked').value == "A") {
                if (allSelectedData.length <= 5) {
                    $("#IDNetNext").hide();
                    $("#IDNetPrev").hide();
                } else {
                    if (globalAction <= 5) {
                        $("#IDNetNext").show();
                        $("#IDNetPrev").hide();
                    }
                    else {
                        $("#IDNetNext").show();
                        $("#IDNetPrev").show();
                    }

                }
                if (globalAction != "") {
                    Getshowhidebutton(allSelectedData.length);
                }
            }




            var NetProfitability = document.getElementById("NetProfitability").getContext("2d");
            var NetProfitabilitydata;
            //added by vidhi
            var globalTooltip;
            if (arrData.length == 0 && allSelectedData.length != 0) {
                if (document.querySelector('input[name="radio-group"]:checked').value == "P") {
                    $("#NOData").html("<p class='ClsNoData' style='margin: 77px 0 10px'>No data available in table</p>");
                    $("#NOData").css("display", "block");
                    $("#bdynet").css("display", "none");



                }
                else {

                    $("#NOData").html("");
                    $("#NOData").css("display", "none");
                    $("#bdynet").css("display", "block");
                    var globalTooltip = "";
                    if (getNetProfitabilityObj != null) {
                        //debugger;
                        NetProfitabilitydata = {
                            labels: getNetProfitabilityObj.Projects,
                            datasets: [
                                //    {
                                //    label: 'Profit Margin',
                                //    type: 'line',
                                //    data: getNetProfitabilityObj.ProfitRange,
                                //    backgroundColor: [
                                //        'transparent',
                                //    ],
                                //    tension: 0,
                                //    borderColor: [
                                //        '#999999',
                                //    ],
                                //    borderWidth: 1.5,
                                //    datalabels: {
                                //        display: false
                                //    }
                                //},
                                {
                                    label: 'Profit range',
                                    data: getNetProfitabilityObj.ProfitRange,
                                    backgroundColor: getBackgoundColorForNetProfitability(getNetProfitabilityObj.ProfitRange),
                                    borderColor: getBackgoundColorForNetProfitability(getNetProfitabilityObj.ProfitRange),
                                    borderWidth: 1
                                },
                            ]
                        };
                    } else {
                        // debugger;
                        NetProfitabilitydata = {
                            labels: [],
                            datasets: [
                                //    {
                                //    label: 'Profit Margin',
                                //    type: 'line',
                                //    data: [],
                                //    backgroundColor: [
                                //        'transparent',
                                //    ],
                                //    tension: 0,
                                //    borderColor: [
                                //        '#999999',
                                //    ],
                                //    borderWidth: 1.5,
                                //    datalabels: {
                                //        display: false
                                //    }

                                //},
                                {
                                    label: 'Profit range',
                                    data: [],
                                    backgroundColor: [
                                    ],
                                    borderColor: [
                                    ],
                                    borderWidth: 1
                                },
                            ]
                        };
                    }
                    //
                    if (myNetProfitabilityChart != undefined && myNetProfitabilityChart != null) {
                        myNetProfitabilityChart.destroy();
                    }


                    myNetProfitabilityChart = new Chart(NetProfitability, {
                        type: 'bar',
                        data: NetProfitabilitydata,
                        options: {
                            legend: {
                                display: true,

                            },
                            barValueSpacing: 100,
                            //Added By Dipali V On 12th Aug 2020 For ToolTip if X-axis value was more then it will short
                            scales: {
                                xAxes: [{
                                    ticks: {

                                        autoSkip: false,
                                        maxRotation: 20,
                                        minRotation: 10,

                                        callback: function (value) {
                                            //debugger;
                                            globalTooltip = value;
                                            if (value.length > 12) {
                                                value = value.substr(0, 20);
                                                return value + "...";
                                            } else {
                                                return value;
                                            }
                                            //truncate

                                        },
                                    },
                                    barPercentage: 1,
                                    barThickness: 20,
                                }],
                                yAxes: [{
                                    display: true,
                                    ticks: {
                                        suggestedMin: 10,
                                        suggestedMax: 100,
                                        callback: function (value) { return value + "%" }
                                    },
                                    scaleLabel: {
                                        display: true,
                                        labelString: "Percentage"
                                    }
                                }],

                            },
                            tooltips: {
                                enabled: true,
                                mode: 'label',
                                callbacks: {
                                    title: function (tooltipItems, data) {

                                        var idx = tooltipItems[0].index;
                                        return 'Project Name : ' + data.labels[idx];
                                        //return globalTooltip;
                                    },
                                    label: function (tooltipItems, data) {
                                        //;
                                        var idx = tooltipItems.datasetIndex;
                                        // return data.dataset[idx];
                                        return data.datasets[idx].label + " : " + tooltipItems.yLabel + "%";
                                    }
                                }
                            }
                            //End of Added By Dipali V On 12th Aug 2020 For ToolTip if X-axis value was more then it will short
                        },
                        plugins: {
                            datalabels: {
                                align: 'end',
                                anchor: 'end',
                                backgroundColor: function (context) {
                                    return context.dataset.backgroundColor;
                                },
                                borderRadius: 4,
                                color: 'white',
                                formatter: function (value) {
                                    return value + ' text ';
                                }
                            }
                        }
                    });
                }
            }//else part to dispaly message if data is not present in your system
            else {
                if (getNetProfitabilityObj != null) {
                    // debugger;
                    $("#NOData").html("");
                    $("#NOData").css("display", "none");
                    $("#bdynet").css("display", "block");
                    NetProfitabilitydata = {
                        labels: getNetProfitabilityObj.Projects,
                        datasets: [
                            //    {
                            //    label: 'Profit Margin',
                            //    type: 'line',
                            //    data: getNetProfitabilityObj.ProfitRange,
                            //    backgroundColor: [
                            //        'transparent',
                            //    ],
                            //    tension: 0,
                            //    borderColor: [
                            //        '#999999',
                            //    ],
                            //    borderWidth: 1.5,
                            //    datalabels: {
                            //        display: false
                            //    }
                            //},
                            {
                                label: 'Profit range',
                                data: getNetProfitabilityObj.ProfitRange,
                                backgroundColor: getBackgoundColorForNetProfitability(getNetProfitabilityObj.ProfitRange),
                                borderColor: getBackgoundColorForNetProfitability(getNetProfitabilityObj.ProfitRange),
                                borderWidth: 1
                            },
                        ]
                    };
                } else {
                    // debugger;


                    $("#NOData").css("display", "none");
                    $("#bdynet").css("display", "block");
                    $("#NOData").html("");


                    NetProfitabilitydata = {
                        labels: [],
                        datasets: [
                            //    {
                            //    label: 'Profit Margin',
                            //    type: 'line',
                            //    data: [],
                            //    backgroundColor: [
                            //        'transparent',
                            //    ],
                            //    tension: 0,
                            //    borderColor: [
                            //        '#999999',
                            //    ],
                            //    borderWidth: 1.5,
                            //    datalabels: {
                            //        display: false
                            //    }

                            //},
                            {
                                label: 'Profit range',
                                data: [],
                                backgroundColor: [
                                ],
                                borderColor: [
                                ],
                                borderWidth: 1
                            },
                        ]
                    };
                }
                //
                if (myNetProfitabilityChart != undefined && myNetProfitabilityChart != null) {
                    myNetProfitabilityChart.destroy();
                }


                myNetProfitabilityChart = new Chart(NetProfitability, {
                    type: 'bar',
                    data: NetProfitabilitydata,
                    options: {
                        categoryPercentage: 0.1,
                        legend: {
                            display: true,

                        },
                        barValueSpacing: 100,
                        //Added By Dipali V On 12th Aug 2020 For ToolTip if X-axis value was more then it will short
                        scales: {
                            xAxes: [{
                                ticks: {

                                    autoSkip: false,
                                    maxRotation: 20,
                                    minRotation: 10,

                                    callback: function (value) {
                                        //debugger;
                                        globalTooltip = value;
                                        if (value.length > 12) {
                                            value = value.substr(0, 20);
                                            return value + "...";
                                        } else {
                                            return value;
                                        }
                                        //truncate

                                    },
                                },
                                barPercentage: 1,
                                barThickness: 20,
                            }],
                            yAxes: [{
                                display: true,
                                ticks: {
                                    suggestedMin: 10,
                                    suggestedMax: 100,
                                    callback: function (value) { return value + "%" }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: "Percentage"
                                }
                            }],

                        },
                        tooltips: {
                            enabled: true,
                            mode: 'label',
                            callbacks: {
                                title: function (tooltipItems, data) {

                                    var idx = tooltipItems[0].index;
                                    return 'Project Name : ' + data.labels[idx];
                                    //return globalTooltip;
                                },
                                label: function (tooltipItems, data) {
                                    //;
                                    var idx = tooltipItems.datasetIndex;
                                    // return data.dataset[idx];
                                    return data.datasets[idx].label + " : " + tooltipItems.yLabel + "%";
                                }
                            }
                        }
                        //End of Added By Dipali V On 12th Aug 2020 For ToolTip if X-axis value was more then it will short
                    },
                    plugins: {
                        datalabels: {
                            align: 'end',
                            anchor: 'end',
                            backgroundColor: function (context) {
                                return context.dataset.backgroundColor;
                            },
                            borderRadius: 4,
                            color: 'white',
                            formatter: function (value) {
                                return value + ' text ';
                            }
                        }
                    }
                });

            }
        }
        //end Net Profitability

        //start bind project data into table


        function getProjectData(data) {
            //debugger;

            // StartLoader("#bdyNewProjectDashBoard");
            $("#tblProjectData").dataTable().fnDestroy();
            $('#tbodyProjectData').html('');

            var projectList;
            if (data != null || data != undefined) {
                projectList = data
            } else {
                projectList = null;
            }

            var curRed = "Red";
            var curYellow = "Yellow";
            var curGreen = "Dark Green";
            var curOrange = "Orange";
            // always destroy the grid before bind the new one

            var Body = "";
            var Isdata = 0;
            if (projectList != null) {
                //debugger;
                $.each(projectList, function (index, item) {
                    //debugger;
                    Isdata = "1";
                    var tr = '<tr><td>' +
                        //'<div class="custom_chckbox">' +
                        //'<input type="checkbox" id="chk' + item.ID + '" class="chcktbl">' +
                        '<label for="chk' + item.ID + '"></label>' +
                        '</td>';
                    var projectName = '<td class="text-start dropdown PRrolename">' + item.ProjectName + '<br>';
                    var efforts = '<div class="smallsubtext"><span class="float-start">Efforts</span>  <span class="float-end">' + item.PlannedEfforts + '/' + item.ActualEfforts + ' Hrs</span><div class="clearfix"></div></div>';
                    var progressEfforts = ' <div class="progress user" style="height: 10px;">' +
                        '<div class="progress-bar bg-success" role="progressbar" style="width: ' + item.EffortPercentage + '%"></div>' +
                        //'<div class="progress-bar bg-success"  role="progressbar"style="width:'+ item.EffortPercentage +'"></div>' +
                        '<div class="userInfo"> <h4>Project Details</h4>' +
                        '<p>' + replaceAllChar(item.ProjectDetails) + '</p></div></div>' +
                        '<div class="PL_statusline' + item.HealthIndicator + '" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Health Indicator">&nbsp;</div></td>';
                    //'<div class="PL_statusline high">&nbsp;</div></td>';
                    projectName += efforts;
                    projectName += progressEfforts;
                    tr += projectName;
                    tr += '<td>' + item.StaffTurnover + '</td>';
                    tr += '<td>' + item.ScopeCRRequest + '</td>';
                    tr += '<td>' + item.DefectDensity + '</td>';
                    //code for checking color added by vidhi 

                    if (item.Color == curRed) {
                        //debugger;
                        tr += '<td>  <div class="statusIndicator statusIndicator_red" ><span>' + item.Risks + '</span></div></td>';

                    }
                    if (item.Color == curYellow) {
                        tr += '<td>  <div class="statusIndicator statusIndicator_yellow"><span>' + item.Risks + '</span></div></td>';


                    }
                    if (item.Color == curGreen) {
                        tr += '<td>  <div class="statusIndicator statusIndicator_green"><span>' + item.Risks + '</span></div></td>';


                    }
                    if (item.Color == curOrange) {

                        tr += '<td>  <div class="statusIndicator statusIndicator_orange"><span>' + item.Risks + '</span></div></td>';
                    }
                    if (item.Color == "") {
                        tr += '<td>  <div class="statusIndicator statusIndicator_nocolor"><span>' + item.Risks + '</span></div></td>';

                    }
                    var scheduleProgress = '<td class="scheduleprogress"><ul class="scheduleprogress">';
                    var overallLi = '<li><label>Overall</label>' +
                        '<div class="progress md-progress">' +
                        '<div class="progress-bar progress-bar-gray" role="progressbar" style="width: ' + item.OverAllShedule + '%"></div>' +
                        '</div></li>';
                    var plannedLi = '<li><label>Planned</label>' +
                        '<div class="progress md-progress">' +
                        '<div class="progress-bar progress-bar-info" role="progressbar" style="width: ' + item.PlannedShedule + '%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>' +
                        '</div></li>';
                    var actualLi = '<li><label>Actual</label>' +
                        '<div class="progress md-progress">' +
                        '<div class="progress-bar" role="progressbar" style="width: ' + item.ActualShedule + '%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>' +
                        '</div></li>';
                    scheduleProgress += overallLi;
                    scheduleProgress += plannedLi;
                    scheduleProgress += actualLi + '</ul></td>';
                    tr += scheduleProgress;
                    tr += '<td>' + item.ScheduleVariance + '%</td>';
                    tr += '<td>' + item.CostVariance + '%</td>';
                    var billingActualPlanned = '<td><div class="progress text-end" style="height: 20px; border-radius: 2px;">' +
                        '<div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" style="width: ' + item.BillingActualPlanned + '%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">' + item.BillingActualPlanned + '%</div>' +
                        '</div></td>';
                    tr += billingActualPlanned;
                    tr += '<td>' + item.NetProfitability + '%</td>';
                    tr += '</tr>';
                    Body += tr;
                });
            }

            //
            //debugger;

            $('#tbodyProjectData').html("");
            $('#tbodyProjectData').append(Body);
            //alert(Body);
            $('#tblProjectData').dataTable({
                "sScrollY": 400,
                //"scrollY": true,
                // "scrollY": '50vh',
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": true,
                "responsive": true,
                "retrieve": true,
                "autoWidth": false,
                "autoHeight": true

            });


            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 350);
            //alert(Isdata);
            if (Isdata != "1") {
                $(".dataTables_empty").removeAttr("colspan");
                $(".dataTables_empty").attr("colspan", "11");
            }


            $('[data-bs-toggle="tooltip"]').tooltip();
            $('[data-bs-toggle="popover"]').popover();
            $('.user').each(function () {
                var $this = $(this);
                $this.popover({
                    trigger: 'hover',
                    placement: 'right',//left
                    html: true,
                    content: $this.find('.userInfo').html(),
                    container: 'body'
                });
            });

            //StopAjaxLoader("#bdyNewProjectDashBoard");
        }
        //end bind project data into table

        // Added by Vidhi to display projects on grid  in side the pop up window

        function DisplayProjectsInsidePopUpWindow(Data) {
            var strHtml = "";
            projectidInsidePop = [];// this array to hold the selected value from grid . here we clear array first
            //$("#PreProjecttbl").dataTable().fnDestroy();              
            $('#tbltbodyPreProjecttbl').html('');
            var Body = "";
            for (var i = 0; i < Data.length; i++) {

                var ProjectName = Data[i]["ProjectName"];
                var ProjectID = Data[i]["ProjectID"];
                var Description = Data[i]["Description"];
                var StartDate = Data[i]["StartDate"];
                var EndDate = Data[i]["EndDate"];
                projectidInsidePop = ProjectID;
                strHtml += ' <tr class="pgrow">'

                strHtml += ' <td>' + ProjectName + '</td>'
                strHtml += ' <td>' + Description + '</td>'
                strHtml += ' <td>' + StartDate + '</td>'
                strHtml += ' <td>' + EndDate + '</td>'
                // strHtml += '<td> <div class="custom_chckbox"><input id="PPcheckbox1" class="chcktbl" type="checkbox"> <label for="PPcheckbox1"></label></div> </td>'               
                strHtml += '<td>'
                strHtml += " <div class='custom_chckbox' id='PPCHK'>"
                strHtml += " <input type='checkbox' id='PPcheckbox" + ProjectID + "' class='chcktbl' >"
                // strHtml += " <input type='checkbox' id='PPcheckbox' value='" + ProjectID + "' class='chcktbl' >"                                           
                strHtml += "  <label for='PPcheckbox" + ProjectID + "'></label>"
                strHtml += " </div>"
                strHtml += '</td'
                strHtml += "<td>"
                //strHtml += '<td>  <select class="form-control selectpicker input-sm" id="PremiumCheckbox"> <option>High</option> <option>Medium</option> <option>Low</option> </select> </td>'
                strHtml += '<td>  <select class="form-select  input-sm" id= "CboPremiumCheckbox' + ProjectID + '" ><option value="0">Select</option><option value="1">High</option> <option value="2">Medium</option> <option value="3">Low</option> </select> </td>'
                strHtml += "</td>"
                strHtml += '</tr>'

            }
            //  Body += strHtml;
            $("#tbltbodyPreProjecttbl").html("");
            $("#tbltbodyPreProjecttbl").html(strHtml);



        }

        // End by Vidhi to display project on grid in side the pop up window






        //get Backgound Color For NetProfitability
        function getBackgoundColorForNetProfitability(data) {
            //debugger;
            if (data.length > 0) {
                var colors = [];
                var i = 0;
                var length = data.length;
                while (i < length) {
                    colors[i] = getColorByVal(data[i]);
                    i++;
                }
                return colors;
            } else {
                return [];
            }
        }

        function getColorByVal(val) {
            if (val > 0) {
                return 'rgba(175, 208, 55, 1)';
            } else {
                return 'rgba(235, 28, 36, 1)';
            }
        }


        function getBackgoundColorForPriorityProjects(data) {
            //debugger;
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

        //replace 
        function replaceAllChar(text, replacechar, replacewith) {
            //debugger;
            if (text == null || text == undefined) {
                return text;
            }
            var replacetext = '';
            var _replacechar = '';
            var _replacewith = '';
            var _special = '|';
            if (replacechar == undefined)
                _replacechar = "'";
            if (replacewith == undefined)
                _replacewith = "''";
            if (text != '') {
                var ch = '';
                for (var i = 0; i < text.length; i++) {
                    ch = text.charAt(i);
                    if (ch == _replacechar) {

                        replacetext = replacetext + _replacewith;
                    }
                    else if (ch == _special) {
                        replacetext = replacetext + "<br>";
                    }
                    else {
                        replacetext = replacetext + ch;

                    }
                }

            }

            return replacetext;
        }

        //end by Vishal M 

        //For Prev & Next Button should hide or show as per data available
        function Getshowhidebutton(RecordCount) {
            // debugger;
            if (Number(RecordCount) < 5) {
                $("NetProfitability").show();
                $("NetProfitability").hide();
            }
            else if (Number(RecordCount) > 5) {
                $("NetProfitability").show();
                $("NetProfitability").show();
            }
            else if (Number(RecordCount) == 5) {
                $("NetProfitability").show();
                $("NetProfitability").hide();
            }
        }
        //End of For Prev & Next Button should hide or show as per data available
        var GlobalCount = "";

        function GetPrevNextData(Count, Action) {
            // debugger;
            globalAction = Action;
            if (Action == "Prev") {
                if (GlobalCount != "") {
                    GlobalCount = Number(GlobalCount) - Number(Count);

                } else {
                    GlobalCount = Number(Count) + Number(5);
                }
            }
            else {
                if (GlobalCount != "") {
                    GlobalCount = Number(GlobalCount) + Number(Count);

                } else {
                    GlobalCount = Number(Count);
                }

            }
            if (Number(GlobalCount) > 5) {
                $("#IDPrev").removeAttr("display");
            } else {
                $("#IDPrev").prop("display", "none");
            }
            //alert(GlobalCount);
            getProjectDashboardDetails(GlobalCount);
        }







    </script>



</body>
</html>
