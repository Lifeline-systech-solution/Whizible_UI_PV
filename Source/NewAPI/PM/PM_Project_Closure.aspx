<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Project_Closure.aspx.vb" Inherits="PbNIT.PM_Project_Closure" %>

<!DOCTYPE html>

<html>
    <!-- Commented by Madhuri.K On 09-08-2024 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project Closure")%>

<head runat="server">

    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="X-UA-Compatible" content="IE=11">
    <!--Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
     
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">

    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0.1">

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.7">

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
</head>
    
    <style type="text/css">
        .loadingoverlay_progress_bar {
            position: absolute!important;
            inset: 50px 100% 25px 600px!important;
            height: 90px!important;
            background: url(../../../Whizible2.0-new/dist/img/KloaderImage.gif) 100% 100% no-repeat rgba(255, 255, 255, 0.8)!important;
            width: 90px!important;
            margin: auto;
            border-radius: 15px!important;
        }
                .pagination {
                    float: right;
                    margin: 0;
                }

                .dataTables_paginate {
                    text-align: right;
                    margin-top: 0;
                    margin-bottom: 15px;
                }

                .popover {
                    max-width: 400px;
                }

                #popover-content-searchresource > * {
                    background-color: #ff0000 !important;
                }

                .slimScrollDiv {
                    height: 100% !important;
                }

                #resourcenamelist li a {
                    padding-left: 50px; border:1px solid #ddd;border-radius: 0px;
                }

                .timenoinput {
                    text-decoration: underline;
                }

                #step5 .dataTables_paginate, #step5 .dataTables_info {
                    position: static;
                }
              
                #step5 .dataTables_paginate, #step5 .dataTables_info {
                    position: static;
                }

                .dataTables_scrollBody table {
                    margin-left: 0px;
                }

                .taskclosurtbl thead tr th {
                    min-width: 100px;
                }

                body .alert.alert-warning {
                    color: #856404 !important;
                    background-color: #fff3cd !important;
                    border-color: #ffeeba !important;
                    font-weight: 400;
                }

                .projectlist:last-child {
                    margin: 0;
                    border-bottom: none;
                    padding-bottom: 0;
                }

                table.table td .cancelrowvalue {
                    display: none;
                }

                .taskclosurtbl thead tr th {
                    min-width: 120px;
                    vertical-align: middle;
                }

                .custom_chckbox input[type=checkbox][disabled] + label:before {
                    margin-right: 15px;
                    cursor: not-allowed;
                }

                .chcklistwarningmsg {
                    position: absolute;
                    top: 70px;
                    bottom: 0;
                    left: auto;
                    right: auto;
                    text-align: center;
                    margin: 0 auto;
                    width: 98.5%;
                    height: 100%;
                }

                    .chcklistwarningmsg .alert-warning {
                        height: 100px;
                        line-height: 60px;
                    }

                #tempdata tr, #cnttblStatisticsReview tr {
                    background: #ccc;
                }

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

                .ProjectList {
                    float: right;
                    padding: 32px;
                    cursor: pointer;
                }

                /*css added by pradip for table layout*/
                .resizeblock {
                    position: relative;
                }

                .dataTables_scrollFoot {
                    MARGIN: 0 0 10px;
                }

                .dataTables_scrollBody thead tr[role="row"] {
                    visibility: collapse !important;
                }

                .ts_headerbot li button.btn.ml-1 {
                    margin-left: 0;
                    padding: 4px 16px;
                    font-size: 14px;
                }


                #IdProjectName {
                    font-size: 15px;
                    text-decoration: underline;
                }

                #tblbdylessonlearttbl .dataTables_empty {
                    text-align: center;
                }

                #taskclosurtblbdy .dataTables_empty {
                    text-align: center;
                }

                #Checklist {
                    margin: -13px;
                }

                #NegativeResponceNote {
                    margin-left: 16px;
                }

                .tooltip-inner {
                    word-wrap: break-word;
                    white-space: pre-line;
                    width: auto;
                }

                #resourcenamelist li {
                    cursor: pointer;
                }

                .lessonlearttbl tbody tr td:last-child .custom_chckbox label:before {
                    margin-right: 0;
                }
                /*Added By Omkar T on 6 Dec */
                #tblCheckList > tbody > tr > td > div:nth-child(1), #tblCheckList > tbody > tr > td > div:nth-child(4), #tblCheckList > tbody > tr > td > div:nth-child(7), #tblCheckList > tbody > tr > td > div:nth-child(11), #tblCheckList > tbody > tr > td > div:nth-child(14) {
                    padding-left: 0px;
                    margin-left: 0px;
                }

                .checkbox-inline, .radio-inline {
                    vertical-align: top;
                    margin-bottom: 5px;
                }

                    .checkbox-inline:last-child, .radio-inline:last-child {
                        margin-bottom: 0px;
                    }
                /*End of additon by Omkar T.*/
                /*New css added by pradip on 09-12-2019*/
                .practicesettinglist ul li a {
                    padding-right: 35px;
                }

                .practicesettinglist ul li .resourceinfo {
                    position: absolute;
                    top: 10px;
                    right: 15px;
                }

                textarea.exandonfocus {
                    min-height: 80px;
                }

                /* .resizeblock.resizeblock_lessonlrnt {
                    overflow-x: hidden;
                }*/

                .notewrap {
                    text-align: right;
                    font-size: 13px;
                    padding: 4px 8px;
                }

                .alertform {
                    border: 1px solid #eee;
                    padding: 20px;
                    background: #f5f5f5;
                    overflow: hidden;
                }

                /*New css Added by pradip on 12-12-2019*/
                .lessonlearttbl tr th:not(:last-child) {
                    text-align: left !important;
                }

                .lessonlearttbl tbody tr td:last-child {
                    text-align: center !important;
                }

                .skillupdatetbl td:last-child {
                    min-width: 30px;
                }
                /*End of addition by pradip on 12-12-2019*/

                /*.add_llrow td.tdSaveLessonLearnt {width: 10.5%!important;}*/
                .taskclosurtbl thead tr th:after {
                    margin-left: 8px;
                }
                /*New style end*/

                .newpreject_steps.closuresteps .wizard li.Compltedstep a.active .completeicon {
                    display: block;
                }

                /*Add by Omkar 16/12/2019 */
                .no-sort::after {
                    display: none !important;
                }

                .no-sort {
                    pointer-events: none !important;
                    cursor: default !important;
                }
                /*New style end*/


                .lessonlearttbl thead tr th {
                    min-width: 120px;
                }
                /*Added By Usha Pandit On 26.03.2020 For adding attachment during update */
                .clsAttachment {
                    display: none;
                }
                /*End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update */
                /*Added By Usha Pandit On 23.04.2020 For showing ban-circle for disabled attachments*/
                .clsCursorNotAllowed {
                    cursor: not-allowed !important;
                }

                .Clsnote {
                    font-size: 11px !important;
                    color: red !important;
                }
                /*End Of Added By Usha Pandit On 23.04.2020 For showing ban-circle for disabled attachments*/


                .dataTables_scrollBody thead tr {
                    visibility: collapse !important;
                }

                .wizard .wizardmaintabs > li {
                    position: relative;
                }

                    .wizard .wizardmaintabs > li > a {
                        display: block;
                        z-index: 1;
                    }

                span.round-tab {
                    top: 0px;
                }

                .practicesteeting_right .righttopheading {
                    justify-content: space-between; margin:0 -15px;
                }

                .wizard .wizardmaintabs > li > a {
                    position: relative;
                }

                .wizard li a.active span.round-tab {
                    background: #4263c1;
                }

                    .wizard li a.active span.round-tab .nonactiveimg {
                        display: none;
                        margin: 10px auto;
                    }

                .wizard .wizardmaintabs > li > a.active, .wizard .wizardmaintabs > li > a.active:hover, .wizard .wizardmaintabs > li > a.active:focus {
                    color: #555;
                    cursor: default;
                    border: 0;
                    border-bottom-color: transparent;
                }

                button#add_row {
                    font-size: 12px !important;
                    padding: 4px 10px;
                }

                .statustext li {
                    margin-right: 3px;
                }

                .introductionbox {
                    padding: 10px;
                }

                #ProjectClosureBody {
                    overflow: hidden;
                }

                .wizard li a.active span.round-tab .activeimg {
                    display: block;
                    margin: 10px auto;
                }

.filedownload .dropdown-toggle::after{ display:none;}
.practicesettinglist ul li:hover a{ border:none;}
section#ProjectClosureSectionID {min-height: 100vh;background: #fff;}
.popover-body {min-width: 300px;font-size: 12px;}
.popover-body .skrresourcename {font-size: 14px;}
.popover-body p {font-size: 12px;color: #464a4c;}

.resize_wrapper {
    height: 100%;
}

   #CloseableAlert .close {
            float: right;
            border: none;
        }

        #CloseAllTask {
            font-size:12px;
        }

        /* Added By Gauri On 09th Sep 2024 For Alignment Issue */
        .introductionbox .dataTables_paginate {
            float: none;
        }
        #resourcenamelist li a:hover
        /* .practicesettinglist .nav-tabs>li.active>a */
        {background: #1359ac;color: #fff !important;}
        /* End of Added By Gauri On 09th Sep 2024 For Alignment Issue */


    </style>

<body id="ProjectClosureBody" class="hold-transition skin-blue-light sidebar-mini fixed">
    <div class="bgwhite clearfix">
        <!-- Main content -->
        <section class="content" id="ProjectClosureSectionID">
            <div class="projectmodulewarp_main wizradstagewrap">
                <div class="newpreject_steps closuresteps">
                    <div class="wizard">
                        <div class="wizard-inner">
                            <div class="connecting-line">
                               
                            </div>
                            <ul class="nav nav-tabs wizardmaintabs" role="tablist">

                                <li role="presentation" class="nav-item">
                                    <a href="#step1" class="nav-link active" data-bs-toggle="tab" aria-controls="step1" role="tab" title="Skill Update" data-bs-placement="bottom">
                                        <span class="round-tab">
                                            <img class="nonactiveimg" src="../../../Whizible2.0-new/dist/img/skill-update.svg" width="40" alt="Project">
                                            <img class="activeimg" src="../../../Whizible2.0-new/dist/img/skill-update-white.svg" width="40" alt="Project">
                                        </span>
                                    </a>
                                    <div class="completeicon1">
                                        <%-- <img class="" src="../../../Whizible2.0-new/dist/img/tick-green.svg" width="40" alt="Project">--%>
                                    </div>
                                    <span class="wizardiconlabel"><%= MyBase.GetResourceString("C_Skill_Update") %> </span>
                                </li>

                                <li role="presentation" class="nav-item disabled">
                                    <a href="#step2" class="nav-link" data-bs-toggle="tab" aria-controls="complete" role="tab" title="Lesson Learnt" data-bs-placement="bottom">
                                        <span class="round-tab">
                                            <img class="nonactiveimg" src="../../../Whizible2.0-new/dist/img/lesson-learnt.svg" width="40" alt="Commercials">
                                            <img class="activeimg" src="../../../Whizible2.0-new/dist/img/lesson-learnt-white.svg" width="40" alt="Commercials">
                                        </span>
                                    </a>
                                    <div class="completeicon1">
                                        <%-- <img class="" src="../../../Whizible2.0-new/dist/img/tick-green.svg" width="40" alt="Project">--%>
                                    </div>
                                    <span class="wizardiconlabel"><%= MyBase.GetResourceString("C_Lesson_Learnt") %></span>
                                </li>

                                <li role="presentation" class="nav-item disabled" data-bs-placement="bottom">
                                    <a href="#step3" class="nav-link" data-bs-toggle="tab" aria-controls="step2" role="tab" title="Task Closure" data-bs-placement="bottom">
                                        <span class="round-tab">
                                            <img class="nonactiveimg" src="../../../Whizible2.0-new/dist/img/task-closure.svg" width="40" alt="Commercials">
                                            <img class="activeimg" src="../../../Whizible2.0-new/dist/img/task-closure-white.svg" width="40" alt="Commercials">
                                        </span>
                                    </a>
                                    <div class="completeicon1">
                                        <%--<img class="" src="../../../Whizible2.0-new/dist/img/tick-green.svg" width="40" alt="Project">--%>
                                    </div>
                                    <span class="wizardiconlabel"><%= MyBase.GetResourceString("C_Task_Closure") %></span>
                                </li>
                                <li role="presentation" class="nav-item disabled">
                                    <a href="#step4" class="nav-link" data-bs-toggle="tab" aria-controls="step3" role="tab" data-bs-placement="bottom" title="Check List">
                                        <span class="round-tab">
                                            <img class="nonactiveimg" src="../../../Whizible2.0-new/dist/img/checklist.svg" width="40" alt="budget">
                                            <img class="activeimg" src="../../../Whizible2.0-new/dist/img/checklist-white.svg" width="40" alt="budget">
                                        </span>.
                                    </a>
                                    <div class="completeicon1">
                                        <%-- <img class="" src="../../../Whizible2.0-new/dist/img/tick-green.svg" width="40" alt="Project">--%>
                                    </div>
                                    <span class="wizardiconlabel"><%= MyBase.GetResourceString("C_Check_List") %></span>
                                </li>

                                <li role="presentation" class="nav-item disabled">
                                    <%--                                <a href="#step4" class="nav-link" data-bs-toggle="tab" aria-controls="step3" role="tab" data-bs-placement="bottom" title="Check List">
                                        --%>
                                        <a href="#step5" data-bs-toggle="tab" aria-controls="complete" role="tab" data-bs-placement="bottom" title="Project Summary">
                                            <span class="round-tab">
                                                <img class="nonactiveimg" src="../../../Whizible2.0-new/dist/img/project-summary.svg" width="40" alt="Commercials">
                                                <img class="activeimg" src="../../../Whizible2.0-new/dist/img/project-summary-white.svg" width="40" alt="Commercials">
                                            </span>
                                        </a>
                                        <div class="completeicon1">
                                            <%--<img class="" src="../../../Whizible2.0-new/dist/img/tick-green.svg" width="40" alt="Project">--%>
                                        </div>
                                        <span class="wizardiconlabel"><%= MyBase.GetResourceString("C_Project_Summary") %></span>
                                </li>

                            </ul>
                        </div>


                        <div class="tab-content">
                            <!--first step start here-->
                            <div class="tab-pane pt-0 show active" role="" id="step1">
                                <div class="">
                                    <div class="row-eq-height">

                                        <div class="col-sm-3 projectsidebar">
                                            <div class="practicesettinglist">
                                                <h4>
                                                    <%= MyBase.GetResourceString("C_Resource") %>
                                                    <%-- Commented and added by Chetan M. on 9th Dec 2019 --%>
                                                    <%--<img class="float-end" src="../../../Whizible2.0-new/dist/img/Searchblue.svg" width="16px">--%>
                                                    <%-- <img class="float-end" src="../../../Whizible2.0-new/dist/img/Searchblue.svg" width="16px" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Search Resource">--%>
                                                    <%-- End of addition by Chetan M. on 9th Dec 2019 --%>
                                                    <a data-bs-toggle="collapse" data-bs-target="#searchresource" href="javascript:;" class="collapsed" aria-expanded="false" id="searchResource">
                                                        <img class="float-end" src="../../../Whizible2.0-new/dist/img/Searchblue.svg" width="16px" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Search Resource">
                                                    </a>

                                                </h4>

                                                <div id="searchresource" class="form-group mb-0 collapse" aria-expanded="false" style="height: 20px;">
                                                    <div class="input-group" id="searchsetting">
                                                        <input id="resourcesearch" onkeyup="rsearch()" type="text" class="form-control" placeholder="Search for resources">
                                                        <span class="input-group-addon">
                                                            <button type="submit" class="nostylebtn">
                                                                <!--<span class="glyphicon glyphicon-search"></span>-->
                                                                <%= MyBase.GetResourceString("C_Search") %>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </div>



                                                <!--  <div id="popover-content-skresourceinfo" class="hide">
                                                 <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
                                                </div> -->

                                                <ul id="resourcenamelist" class="nav-tabs slim-scroll">
                                                </ul>
                                            </div>
                                        </div>


                                        <div class="col-sm-9 practicesteeting_right">
                                            <div class="d-flex righttopheading graybg">
                                                <h6 class="float-start m-0 pt-Onehalf"><%= MyBase.GetResourceString("C_Update_Resource_Skill") %></h6>
                                                <div class="pname"><span><b>Project Name : </b></span><span id="IdProjectName"></span></div>
                                                  <div class="topbtn">
                                                    <button type="button" id="btnNextLessonLearnt" onclick="FuncbtnNextLessonLearnt()" class="btn btnyellow ml-1 float-end"><%= MyBase.GetResourceString("C_Next") %></button>
                                                   <%--Added By Dipali V On 24th Sep 2025 For Align Issue based--%>
                                                  </div>
                                                 <%--End of Added By Dipali V On 24th Sep 2025 For Align Issue based--%>
                                                    <% If m_PM_ProjectClosureblnAddAccess = True Or m_PM_ProjectClosureblnEditAccess = True Then %>
                                                  <div>    
                                                <button id="saveskill" type="button" class="btn btnyellow ml-1 float-end" onclick="saveskillfun()"><%= MyBase.GetResourceString("C_Save") %></button>
                                               <%-- Added By Dipali V On 24th Sep 2025 For Align Issue based--%>
                                                  </div>
                                                 <%--Added By Dipali V On 24th Sep 2025 For Align Issue based--%>
                                                <%End If %>
                                            </div>

                                            <div class="tab-content practicesettinglist">
                                                <div class="tab-pane pt-0 show active" id="RSupdate1">

                                                    <div class="row">
                                                        <div class="col-sm-6 practicelisting_colmn">
                                                            <div class="slim-scroll">
                                                                <table class="table table-stripped skillupdatetbl" id="tblSkillsInfo">
                                                                </table>
                                                            </div>

                                                        </div>
                                                        <div class="col-sm-6">
                                                            <table class="table table-stripped skillupdatetbl lessonlearttbllist">
                                                                <thead>
                                                                    <tr>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Skills") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Year_s") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Month_s") %></strong></td>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="tbodytblAddNewSkill">
                                                                </tbody>
                                                                <tfoot>
                                                                    <tr>
                                                                        <td class="shortpadding">
                                                                            <button class="btn borderbtn btn-xs" id="add_row" onclick="addrowbtn();" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Add New Skill"><%= MyBase.GetResourceString("C_Add_New_Skill") %></button>
                                                                        </td>
                                                                        <td>
                                                                            <div class="">&nbsp;</div>
                                                                        </td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="shortpadding" colspan="3">
                                                                            <%-- Commented and added by Chetan M on 13 May 2021 for note change issue--%>
                                                                            <%--<span class="Clsnote">Note: Skill is Applicable Only,If Daily Activity Present on the Selected Resources </span>--%>
                                                                            <span class="Clsnote">Note: Skill is Applicable Only,If Daily Activity Present for the Selected Resources </span>
                                                                            <%-- End of Commented and added by Chetan M on 13 May 2021 for note change issue--%>
                                                                        </td>
                                                                    </tr>

                                                                </tfoot>

                                                            </table>
                                                            <datalist id="myskillDropdownsearchlist">
                                                                <option value="Something"></option>
                                                                <option value="Something Else"></option>
                                                                <option value="Another One"></option>
                                                                <option value="Alpha"></option>
                                                                <option value="Bravo"></option>
                                                                <option value="Charlie"></option>
                                                                <option value="Delta"></option>
                                                                <option value="Echo"></option>
                                                                <option value="Foxtrot"></option>
                                                                <option value="Gamma"></option>
                                                            </datalist>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="tab-pane pt-0" id="RSupdate2">

                                                    <div class="row">
                                                        <div class="col-sm-6 practicelisting_colmn">
                                                            <div class="slim-scroll">
                                                                <table class="table table-stripped skillupdatetbl">
                                                                    <tr>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Skills") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Year_s") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Month_s") %></strong></td>
                                                                    </tr>

                                                                </table>
                                                            </div>

                                                        </div>
                                                        <div class="col-sm-6">
                                                            <table class="table table-stripped skillupdatetbl lessonlearttbllist">
                                                                <tbody>
                                                                    <tr>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Skills") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Year_s") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Month_s") %></strong></td>

                                                                    </tr>
                                                                </tbody>
                                                                <tfoot>
                                                                    <tr>
                                                                        <td class="shortpadding">
                                                                            <button class="btn borderbtn btn-xs" id="add_row"><%= MyBase.GetResourceString("C_Add_New_Skill") %></button>
                                                                        </td>
                                                                        <td>
                                                                            <div class="">&nbsp;</div>
                                                                        </td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td class="shortpadding" colspan="3">
                                                                            <span class="Clsnote">Note: Skill is Applicable Only,If Daily Activity Present on the Selected Resources </span>
                                                                        </td>
                                                                    </tr>
                                                                </tfoot>

                                                            </table>
                                                            <datalist id="myskillDropdownsearchlist">
                                                                <option value="Something"></option>
                                                                <option value="Something Else"></option>
                                                                <option value="Another One"></option>
                                                                <option value="Alpha"></option>
                                                                <option value="Bravo"></option>
                                                                <option value="Charlie"></option>
                                                                <option value="Delta"></option>
                                                                <option value="Echo"></option>
                                                                <option value="Foxtrot"></option>
                                                                <option value="Gamma"></option>
                                                            </datalist>
                                                            <div class="skillupdatetbl_tfoot">
                                                                <div class="clearfix"></div>
                                                                <p><small><%= MyBase.GetResourceString("C_Once_Project_is_closed_resource_will_be_release_as_per_workflow") %> </small></p>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="tab-pane pt-0" id="RSupdate3">

                                                    <div class="row">
                                                        <div class="col-sm-6 practicelisting_colmn">
                                                            <div class="slim-scroll">
                                                                <table class="table table-stripped skillupdatetbl">
                                                                    <tr>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Skills") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Year_s") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Month_s") %></strong></td>
                                                                    </tr>


                                                                </table>
                                                            </div>

                                                        </div>
                                                        <div class="col-sm-6">


                                                            <table class="table table-stripped skillupdatetbl lessonlearttbllist">
                                                                <tbody>
                                                                    <tr>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Skills") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Year_s") %></strong></td>
                                                                        <td class="tblsubheading"><strong><%= MyBase.GetResourceString("C_Month_s") %></strong></td>

                                                                    </tr>
                                                                </tbody>
                                                                <tfoot>
                                                                    <tr>
                                                                        <td class="shortpadding">
                                                                            <button class="btn borderbtn btn-xs" id="add_row"><%= MyBase.GetResourceString("C_Add_New_Skill") %></button>
                                                                        </td>
                                                                        <td>
                                                                            <div class="">&nbsp;</div>
                                                                        </td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>


                                                                    <tr>
                                                                        <td class="shortpadding" colspan="3">
                                                                            <span class="Clsnote">Note: Skill is Applicable Only,If Daily Activity Present on the Selected Resources </span>
                                                                        </td>
                                                                    </tr>
                                                                </tfoot>
                                                            </table>
                                                            <datalist id="myskillDropdownsearchlist">
                                                                <option value="Something"></option>
                                                                <option value="Something Else"></option>
                                                                <option value="Another One"></option>
                                                                <option value="Alpha"></option>
                                                                <option value="Bravo"></option>
                                                                <option value="Charlie"></option>
                                                                <option value="Delta"></option>
                                                                <option value="Echo"></option>
                                                                <option value="Foxtrot"></option>
                                                                <option value="Gamma"></option>
                                                            </datalist>
                                                            <div class="skillupdatetbl_tfoot">
                                                                <div class="clearfix"></div>
                                                                <p><small><%= MyBase.GetResourceString("C_Once_Project_is_closed_resource_will_be_release_as_per_workflow") %> </small></p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--first step end here-->
                            <!--second steps start here-->

                            <div class="tab-pane pt-0" role="tabpanel" id="step2">
                                <div class="col-sm-12 righttopheading pt-1 pb-1 px-3">
                                    <h6 class="float-start m-0 pt-Onehalf"><%= MyBase.GetResourceString("C_Lesson_Learnt_Heading") %></h6>

                                    <!-- Add by omkar 13/12/2019 -->
                                    <button type="button" id="btnNextTaskClosure"  class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_Next") %></button> <%--onclick="FunbtnNextStep3()"--%>
                                    <!-- end -->
                                    <a href="#step1" data-bs-toggle="tab" aria-controls="step1" role="tab" type="button" class="btn borderbtn prevtab float-end" aria-expanded="true"><%= MyBase.GetResourceString("C_Back") %></a>
                                    <div class="clearfix"></div>
                                </div>


                                <div class="clearfix"></div>

                                <div class="resizeblock resizeblock_lessonlrnt">
                                    <div class="resize_wrapper">
                                        <table id="lessonlearttbl" class="table table-bordered lessonlearttbl" style="width: 100%">
                                            <thead>
                                                <!--add by omkar 13/12/2019 -->
                                                <tr>
                                                    <th><%= MyBase.GetResourceString("C_Tags_Problem_Type") %></th>
                                                    <th class="no-sort"><%= MyBase.GetResourceString("C_Problem_Description") %></th>
                                                    <th class="no-sort"><%= MyBase.GetResourceString("C_Solution") %></th>
                                                    <th class="no-sort"><%= MyBase.GetResourceString("C_Preventive_Action") %></th>
                                                    <%-- Commented and added by Chetan M on 7th Dec 2019 --%>
                                                    <th id="theadReferredDocument" class="no-sort"><%= MyBase.GetResourceString("C_Reffered_Document") %></th>
                                                    <%--
                                                    <th id="theadBlank">&nbsp;</th>--%>
                                                    <%-- End of added by Chetan M. --%>
                                                    <th class="no-sort">&nbsp;</th>
                                                    <!--end-->
                                            </thead>
                                            <tbody id="tblbdylessonlearttbl">
                                            </tbody>
                                            <tfoot>
                                                <tr class="">
                                                    <td>
                                                        <button class="btn borderbtn nobtnstyle-xs add-new" data-bs-toggle="tooltip" id="btnAddLessonLearnt" title="Add Lesson Learnt"><%= MyBase.GetResourceString("C_Add_Lesson_Learnt") %></button>
                                                    </td>
                                                    <%-- Commented by Chetan M on 7th Dec 2019 --%>
                                                    <%--
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td class="actioncolumn"></td>--%>
                                                    <%-- End of commented by Chetan M on 7th Dec 2019 --%>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>


                            <!--second steps end here-->
                            <!--third steps start here-->
                            <div class="tab-pane pt-0" role="tabpanel" id="step3">
                                <div class="container-fluid bgwhite ts_headerbot">
                                    <div class="row">                                        
                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                            <ul class="statustext hidden-xs">
                                                <li id="liall" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="redstatuslbl active" data-original-title="All Tasks"><a id="lnkall" href="javascript:;" onclick="staticfilter(this.id)"><span id="spnAll" class="statustextno">23</span><%= MyBase.GetResourceString("C_All") %></a></li>
                                                <li id="liassigned" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="greenstatuslbl" data-original-title="Assigned Task"><a id="lnkassigned" href="javascript:;" onclick="staticfilter(this.id)"><span id="spnAssigned" class="statustextno">23</span><%= MyBase.GetResourceString("C_Assigned_Task") %></a></li>
                                                <li id="limpp" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="overdue" data-original-title="MPP Task"><a id="lnkmpp" href="javascript:;" onclick="staticfilter(this.id)"><span id="spnMPP" class="statustextno">10</span><%= MyBase.GetResourceString("C_MPP_Task") %></a></li>
                                                <li id="lirisk" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="criticle" data-original-title="Risks Task"><a id="lnkrisk" href="javascript:;" onclick="staticfilter(this.id)"><span id="spnRisk" class="statustextno">08</span><%= MyBase.GetResourceString("C_Risks") %></a></li>
                                                <li id="liissue" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="graystatuslbl" data-original-title="Issues Task"><a id="lnkissue" href="javascript:;" onclick="staticfilter(this.id)"><span id="spnIssue" class="statustextno">03</span><%= MyBase.GetResourceString("C_Issues") %></a></li>
                                                <li id="linotstarted" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" class="pending" data-original-title="Not Started Task"><a id="lnknotstarted" href="javascript:;" onclick="staticfilter(this.id)"><span id="spnNotStarted" class="statustextno">03</span><%= MyBase.GetResourceString("C_Not_Started") %></a></li>

                                            </ul>
                                        </div>
                                        <div class="col-md-3 col-sm-3 col-xs-12 float-end">
                                            <ul class="float-end btnlistinline">
                                                <li class="hidden-xs">
                                                    <a href="#step2" data-bs-toggle="tab" aria-controls="step2" role="tab" type="button" class="btn borderbtn prevtab" aria-expanded="true"><%= MyBase.GetResourceString("C_Back") %></a>
                                                    <%If m_PM_ProjectClosureblnEditAccess = True Then%>
                                                    <button id="btntaskclosersave" type="button" class="btn btnyellow" onclick="btntaskclosersaveclick()"><%= MyBase.GetResourceString("C_Save") %></button>
                                                    <%End If %>

                                                    <button id="btntaskclosernext" type="button" class="btn btnyellow" onclick="btntaskclosernextclick()"><%= MyBase.GetResourceString("C_Next") %></button>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>


                                <div class="table-outer resizeblock resizeblock_tskclosure ">
                                    <div class="resize_wrapper">

                                        <table id="taskclosurtbl" class="table table-bordered taskclosurtbl" style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th id="sortclosuretask"><%= MyBase.GetResourceString("C_Task_Name") %></th>
                                                    <th id="sortresourfce"><%= MyBase.GetResourceString("C_Resource") %> </th>
                                                    <th id="sortplandate">Planned Start Date</th>
                                                    <th id="sortenddate">Planned End Date</th>

                                                    <th><%= MyBase.GetResourceString("C_Baseline_Start_Date") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Baseline_End_Date") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Actual_Start_Date") %></th>
                                                    <%--
                                                    <th><%= MyBase.GetResourceString("C_Actual_End_Date") %></th>--%>
                                                    <%--
                                                    <th><%= MyBase.GetResourceString("C_Actual_End_Date") %></th>--%>
                                                    <th>Actual End Date</th>
                                                    <th id="sortplanwork"><%= MyBase.GetResourceString("C_Planned_Work_Hrs") %></th>
                                                    <th>Actual Work (Hrs)</th>

                                                    <th><%= MyBase.GetResourceString("C_Percent_Work_Completed") %></th>
                                                    <th id="closeall">
                                                        <%= MyBase.GetResourceString("C_Close_Void") %>
                                                        <div class="custom_chckbox inline clearfix">
                                                            <%-- Added By Dipali V On 25th May 2026 - Purpose:-Selects only tasks on the current grid page (not all 2000 rows). See checkAllCheckBox(). --%>
                                                            <input type="checkbox" id="checkboxcloseall" class="chckHead" onchange="checkAllCheckBox()">
                                                            <label for="checkboxcloseall"></label>
                                                        </div>

                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody id="taskclosurtblbdy">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>
                            <!--third steps end here-->
                            
                            <!--fourth steps start here-->
                            <div class="tab-pane pt-0" role="tabpanel" id="step4">
                                <div class="righttopheading pt-1 pb-1">
                                    <h6 class="float-start m-0 pt-Onehalf col-sm-9"><span id="Checklist">Checklist Name : </span>&nbsp&nbsp <span id="ChecklistName"></span></h6>
                                    <div class="col-sm-3 pr0 float-end">
                                        <button type="button" id="btnNextProjectSummary" class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_Next") %></button>
                                        <%If m_PM_ProjectClosureblnEditAccess = True Then%>
                                        <button type="button" id="btnSaveCheckList" class="btn btnyellow float-end ml-1" onclick="SaveCheckListResponse()"><%= MyBase.GetResourceString("C_Confirm") %></button>
                                        <%End If %>

                                        <a href="#step3" data-bs-toggle="tab" aria-controls="step3" role="tab" type="button" class="btn borderbtn prevtab mr-1 float-end" aria-expanded="true"><%= MyBase.GetResourceString("C_Back") %></a>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <small id="NegativeResponceNote"><strong>Note:</strong> <em><%= MyBase.GetResourceString("C_Responses_in_bold_characters_represent_negative_responses") %></em></small>

                                <div class="clearfix"></div>
                                <div class="table-responsive table-outer">
                                    <table class="table table-bordered taskQAtbl" id="tblCheckList">
                                        <%-- Commented by Chetan M on 6 Dec 2019 --%>
                                        <%--<thead id="tblChecklistThead">
                                            <tr>
                                                <th width="40%"><%= MyBase.GetResourceString("C_CheckList_Item") %></th>
                                                <th width="30%"><%= MyBase.GetResourceString("C_Responces") %></th>
                                                <th><%= MyBase.GetResourceString("C_Remark") %></th>
                                            </tr>
                                        </thead>--%>
                                        <%-- End of comment by Chetan M. --%>
                                    </table>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <!--fourth steps end here-->
                            <!--fifth steps start here-->
                            <div class="tab-pane" role="tabpanel" id="step5">
                                <div class="col-sm-12 righttopheading pt-1 pb-1">
                                    <h6 class="float-start m-0 pt-Onehalf"><%= MyBase.GetResourceString("C_Closure_Report") %></h6>

                                    <%--<a href="#step4" data-bs-toggle="tab" aria-controls="step4" role="tab" type="button" class="btn btnyellow skillsavebtn prevtabfirst float-end ml-1" aria-expanded="true">Save</a>--%>
                                    <button type="button" class="btn borderbtn float-end ml-1" data-bs-toggle="modal" data-bs-target="#reopenModal" id="btnreopenprojectcolser">Re-open Project</button>
                                    <button type="button" class="btn borderbtn float-end ml-1" id="btnsendmailprojectcolser">Send Project Closure Email</button>
                                    <button type="button" class="btn borderbtn float-end ml-1" id="btncloseproject"><%= MyBase.GetResourceString("C_Close_Project") %></button>
                                    <%--<button type="button" class="btn borderbtn float-end ml-1" id="btnReopenProject" hidden="hidden">Reopen Project</button>--%>
                                    <a href="#step4" data-bs-toggle="tab" aria-controls="step1" role="tab" type="button" class="btn borderbtn prevtab float-end" aria-expanded="true"><%= MyBase.GetResourceString("C_Back") %></a>
                                    <div class="dropdown filedownload float-end mt-onehalf">
                                        <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" autocomplete="off"><i class="fas fa-download" data-bs-toggle="tooltip" data-bs-placement="bottom" data-original-title="Download"></i></button>

                                        <ul class="dropdown-menu" id="fas-download">
                                            <li>
                                                <a href="#" onclick="Export_Click('PDF')">
                                                    <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px"><%= MyBase.GetResourceString("C_Pdf") %>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" onclick="Export_Click('EXCEL')">
                                                    <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px"><%= MyBase.GetResourceString("C_Xlsx") %>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" onclick="Export_Click('XML')">
                                                    <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px"><%= MyBase.GetResourceString("C_Xml") %>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" onclick="Export_Click('TEXT')">
                                                      <%--Commented & Added By Dipali V On 21st March 2023 For Doc should be text--%>
                                                    <%--<img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px"><%= MyBase.GetResourceString("C_Doc") %>--%>
                                                    <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Text
                                                      <%--End of Commented & Added By Dipali V On 21st March 2023 For Doc should be text--%>
                                                </a>
                                            </li>

                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="clearfix"></div>
                                <div class="col-sm-12">
                                    <div class="introductionbox">
                                        <div class="Iheading">1.0 <%= MyBase.GetResourceString("C_Overview") %></div>
                                        <div class="introductionboxbody">
                                            <!--project 1-->
                                            <div class="projectlist">
                                                <div class="Isubheading">1.1 <%= MyBase.GetResourceString("C_Project_Overview") %></div>
                                                <div class="row introductionlist">
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Project_Name") %> : </label>
                                                        <span id="spnPROJECTNAME"></span>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Project_Code") %> : </label>
                                                        <span id="spnPROJECTCODE"></span>
                                                    </div>
                                                </div>

                                                <div class="row introductionlist">
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Description") %> : </label>
                                                        <span id="spnDESCRIPTION"></span>
                                                    </div>
                                                    <!-- Add by omkar 5/12/2019-->
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Status") %> : </label>
                                                        <span id="spnOver"></span>
                                                    </div>
                                                    <!-- end Add by omkar 5/12/2019-->
                                                </div>

                                                <div class="row introductionlist">
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Customer") %> : </label>
                                                        <span id="spnCUSTOMERNAME"></span>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Organisation_Unit") %> : </label>
                                                        <span id="spnLOCATION"></span>
                                                    </div>
                                                </div>

                                                <div class="clearfix"></div>
                                            </div>


                                        </div>
                                    </div>

                                    <!--introductionbox2-->
                                    <div class="introductionbox">
                                        <div class="Iheading">2.0 <%= MyBase.GetResourceString("C_Summary") %></div>
                                        <div class="introductionboxbody">
                                            <!--project 1-->
                                            <div class="projectlist">
                                                <div class="Isubheading">2.1 <%= MyBase.GetResourceString("C_Size_Of_the_Project") %></div>
                                                <div class="row introductionlist">
                                                    <div class="col-sm-6">
                                                        <%--<label><%= MyBase.GetResourceString("C_Expected_Start_Date") %> : </label>--%>
                                                        <label><%= MyBase.GetResourceString("C_PlannedStart") %> : </label>
                                                        <span id="spnPLANNEDSTARTDATE"></span>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <%--  <label><%= MyBase.GetResourceString("C_Expected_End_Date") %> : </label>--%>
                                                        <label><%= MyBase.GetResourceString("C_PlannedEnd") %> : </label>
                                                        <span id="spnPLANNEDENDDATE"></span>
                                                    </div>
                                                </div>
                                                <div class="row introductionlist">
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Actual_Start_Date") %> : </label>
                                                        <span id="spnACTUALSTARTDATE"></span>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label>Actual End Date : </label>
                                                        <span id="spnACTUALENDDATE"></span>
                                                    </div>
                                                </div>
                                                <div class="row introductionlist">
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Actual_Duration") %> : </label>
                                                        <span id="spnACTUALDURATION"></span>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Planed_Duration") %> : </label>
                                                        <span id="spnDURATION"></span>
                                                    </div>
                                                </div>
                                                <div class="row introductionlist">
                                                    <div class="col-sm-6">
                                                        <%--<label><%= MyBase.GetResourceString("C_Duration_Variance") %> : </label>--%>
                                                        <label><%= MyBase.GetResourceString("C_Duration_Variance1") %> : </label>
                                                        <span id="spnDURATIONVARIANCE"></span>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Effort_Variance") %> : </label>
                                                        <span id="spnEFFORTVARIANCE"></span>
                                                    </div>
                                                </div>
                                                <div class="row introductionlist">
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Planned_Efforts") %> : </label>
                                                        <span id="spnPLANNEDEFFORTS"></span>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Actual_Effort") %> : </label>
                                                        <span id="spnWORK"></span>
                                                    </div>
                                                </div>

                                                <div class="row introductionlist">
                                                    <div class="col-sm-6">
                                                        <label><%= MyBase.GetResourceString("C_Total_Resources") %> : </label>
                                                        <span id="spnRESOURCES"></span>
                                                    </div>

                                                </div>
                                                <div class="clearfix"></div>

                                            </div>

                                            <div class="projectlist">
                                                <div class="Isubheading">2.2 <%= MyBase.GetResourceString("C_Project_Parameters_Planned_vs_Actual") %></div>
                                                <%-- <table id="tblPlannedvsActual" class="table table-bordered summurytbl" style="width: 100%">
                                                    --%>
                                                    <table id="tblPlannedvsActual" class="table table-bordered " style="width: 100%">
                                                        <thead>
                                                        <th width="20%"><%= MyBase.GetResourceString("C_Task_Type") %></th>
                                                        <th><%= MyBase.GetResourceString("C_Start_Date") %></th>
                                                        <th><%= MyBase.GetResourceString("C_Actual_Start_Date") %></th>
                                                        <th><%= MyBase.GetResourceString("C_Duration_Days") %></th>
                                                        <th><%= MyBase.GetResourceString("C_Actual_Duration_Days") %></th>
                                                        <th width="12%"><%= MyBase.GetResourceString("C_Work_Hrs") %></th>
                                                        <th width="12%"><%= MyBase.GetResourceString("C_Actual_Work_Hrs") %></th>
                                                        </thead>
                                                        <tbody id="tblbodyPlannedvsActual">
                                                        </tbody>

                                                    </table>
                                                    <div id="tblPlannedvsActualafterdiv">
                                                        <br />
                                                        <table id='tempdata' class='table table-bordered'>
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <div class="clearfix"></div>

                                            </div>

                                            <!--project 1 end-->
                                            <%--<div class="projectlist">
                                                --%>
                                                <%--  Commented and added by Chetan M on 9th Dec 2019 --%>
                                                <%--<div class="Isubheading">2.4 <%= MyBase.GetResourceString("C_Defect_Statistics") %></div>--%>
                                                <%--<div class="Isubheading">2.3 <%= MyBase.GetResourceString("C_Defect_Statistics") %></div>--%>
                                                <%--End of addition by Chetan M. on 9th Dec 2019.--%>
                                                <%--<div class="review_statistics">
                                                    <div class="col-sm-4">
                                                        <div class="rstatbox"></div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="rstatbox"></div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="rstatbox"></div>
                                                    </div>

                                                </div>
                                                <div class="clearfix"></div>

                                            </div>--%>



                                            <div class="projectlist">
                                                <%--  Commented and added by Chetan M on 9th Dec 2019 --%>
                                                <%--<div class="Isubheading">2.4 <%= MyBase.GetResourceString("C_Defect_Statistics") %></div>--%>
                                                <div class="Isubheading">2.3 <%= MyBase.GetResourceString("C_Review_Statistics") %></div>
                                                <%--End of addition by Chetan M. on 9th Dec 2019.--%>

                                                <table id="tblStatisticsReview" class="table table-bordered " style="width: 100%">
                                                    <thead>
                                                    <th width="60%"><%= MyBase.GetResourceString("C_Review_Type") %></th>
                                                    <th width="13%"><%= MyBase.GetResourceString("C_No_Of_Reviews") %></th>
                                                    <th width="13%"><%= MyBase.GetResourceString("C_Review_Efforts") %></th>
                                                    <th width="13%"><%= MyBase.GetResourceString("C_No_Of_Defects") %></th>

                                                    </thead>
                                                    <tbody id="tbltblStatisticsReviewbody">
                                                    </tbody>

                                                </table>
                                                <div id="tblStatisticsReviewafterdiv">
                                                    <br />
                                                    <table id='cnttblStatisticsReview' class='table table-bordered'>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="clearfix"></div>

                                            </div>




                                            <div class="projectlist">
                                                <div class="Isubheading">2.4 <%= MyBase.GetResourceString("C_Effort_Distribution") %></div>

                                                <table id="tblEffortDistribution" class="table table-bordered" style="width: 100%">
                                                    <thead>
                                                    <th><%= MyBase.GetResourceString("C_Task_Type") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Work") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Actual_Work") %></th>
                                                    <th>% Variance</th>
                                                    <th><%= MyBase.GetResourceString("C_Work_Hrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Actual_Work_Hrs") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Variance_hrs") %></th>
                                                    </thead>
                                                    <tbody id="tblEffortDistributionTbody">
                                                    </tbody>
                                                </table>
                                                <div class="clearfix"></div>

                                            </div>

                                        </div>
                                    </div>

                                    <!--introductionbox2_end-->
                                    <!--introduyctionbox3_start_here-->
                                    <div class="introductionbox">
                                        <div class="Iheading">3.0 <%= MyBase.GetResourceString("C_Process_Repositary_Items") %></div>
                                        <div class="introductionboxbody">
                                            <div class="projectlist">
                                                <div class="Isubheading">3.1 <%= MyBase.GetResourceString("C_Lessons_Learned") %></div>

                                                <div class="clearfix"></div>

                                                <table id="tblLessonsLearned" class="table table-bordered" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th><%= MyBase.GetResourceString("C_Tags_Problem_Type") %></th>
                                                            <th><%= MyBase.GetResourceString("C_Problem_Description") %></th>
                                                            <th><%= MyBase.GetResourceString("C_Solution") %></th>
                                                            <th><%= MyBase.GetResourceString("C_Preventive_Action") %></th>
                                                            <th><%= MyBase.GetResourceString("C_Reffered_Document") %></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblLessonsLearnedTbody">
                                                    </tbody>
                                                </table>
                                                <div class="clearfix"></div>

                                            </div>

                                            <div class="projectlist">
                                                <%-- Added by Chetan M. on 17th Dec 2019 --%>
                                                <div class="Isubheading">3.2 <%= MyBase.GetResourceString("C_Reusable_Items") %></div>
                                                <div class="clearfix"></div>
                                                <table id="tblReusableItems" class="table table-bordered" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th>Title</th>
                                                            <th>Prerequisites</th>
                                                            <th>Tool</th>
                                                            <th>Category</th>
                                                            <th>Appliances</th>
                                                            <th>Date</th>
                                                            <th>Contributor</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblReusableItemsTbody">
                                                    </tbody>
                                                </table>
                                                <%-- end of addition by Chetan M. on 17th Dec 2019 --%>
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <!--introduyctionbox3_end_here-->
                                    <!--introduyctionbox4_start_here-->
                                    <div class="introductionbox">
                                        <div class="Iheading">4.0 <%= MyBase.GetResourceString("C_Tools_Used") %></div>
                                        <div class="introductionboxbody">

                                            <div class="projectlist">

                                                <div class="clearfix"></div>
                                                <table id="tblToolUsed" class="table table-bordered" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th width="60%"><%= MyBase.GetResourceString("C_Tool_Type") %></th>
                                                            <th><%= MyBase.GetResourceString("C_Tool") %></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblToolUsedTbody">
                                                    </tbody>
                                                </table>
                                                <div class="clearfix"></div>

                                            </div>
                                        </div>
                                    </div>


                                    <!--introduyctionbox4_end_here-->
                                    <!--introduyctionbox5_start_here-->
                                    <div class="introductionbox">
                                        <div class="Iheading">5.0 <%= MyBase.GetResourceString("C_Hardware_Used") %></div>
                                        <div class="introductionboxbody">
                                            <div class="projectlist">

                                                <div class="clearfix"></div>
                                                <table id="tblHardwareUsed" class="table table-bordered" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th><%= MyBase.GetResourceString("C_Machine_Name") %></th>
                                                            <th><%= MyBase.GetResourceString("C_Configuration") %></th>
                                                            <th><%= MyBase.GetResourceString("C_Used_As") %></th>
                                                            <th><%= MyBase.GetResourceString("C_Person_Using") %></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblHardwareUsedTbody">
                                                    </tbody>
                                                </table>
                                                <div class="clearfix"></div>

                                            </div>
                                        </div>
                                    </div>

                                    <!--introduyctionbox5_end_here-->
                                    <!--introduyctionbox6_start_here-->
                                    <div class="introductionbox">
                                        <div class="Iheading">6.0 <%= MyBase.GetResourceString("C_Project_Team") %></div>
                                        <div class="introductionboxbody">
                                            <div class="projectlist">

                                                <div class="clearfix"></div>
                                                <table id="tblProjectTeam" class="table table-bordered" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 15%"><%= MyBase.GetResourceString("C_Name") %></th>
                                                            <th style="width: 20%"><%= MyBase.GetResourceString("C_Role") %></th>
                                                            <th style="width: 15%"><%= MyBase.GetResourceString("C_Start_Date") %></th>
                                                            <th style="width: 15%"><%= MyBase.GetResourceString("C_End_Date") %></th>
                                                            <th style="width: 10%"><%= MyBase.GetResourceString("C_Work_Hrs") %></th>
                                                            <th style="width: 10%"><%= MyBase.GetResourceString("C_Actual_Work_Hrs") %></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tblProjectTeamTbody">
                                                    </tbody>
                                                </table>
                                                <div class="clearfix"></div>

                                            </div>
                                        </div>
                                    </div>

                                    <!--introduyctionbox6_end_here-->

                                </div>
                            </div>

                            <div class="clearfix"></div>

                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>

                </div>
            </div>
        </section>
        <%--
    </div>--%>

    <!-- /.content-wrapper -->
    <!--closemodal_start_here-->
    <div class="modal custmodal" id="closemodal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><%= MyBase.GetResourceString("C_Close_Task") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                </div>
                <div class="modal-body">
                    <h4 class="text-center"><%= MyBase.GetResourceString("C_Are_you_sure_want_to_close_task") %></h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal" onclick="cancelTask('Cancel')"><%= MyBase.GetResourceString("C_Cancel") %></button>
                    <button type="button" class="btn btnyellow" data-bs-dismiss="modal" onclick="CloseTask()"><%= MyBase.GetResourceString("C_Yes") %></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal custmodal" id="reopenModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Re-open Project</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <%-- Commented & Added By Dipali V On 10th Dec 2020 For Madatory sign missing--%>
                        <%-- <label>Remark</label>--%>
                        <label class="control-label required">Remark</label>
                        <%-- End ofCommented & Added By Dipali V On 10th Dec 2020 For Madatory sign missing--%>
                        <textarea id="reopenRemark" class="form-control"></textarea>
                    </div>
                </div>
                <div class="modal-footer">

                    <%-- <button type="button" class="btn borderbtn" data-bs-dismiss="modal" onclick="ReopenProject()">Re-open</button>
                    --%>
                    <button type="button" class="btn borderbtn" onclick="ReopenProject()">Re-open</button>

                </div>
            </div>
        </div>
    </div>

    <%--    </* For Close All Task*/>--%>
    <div class="modal custmodal" id="closeAllTaskmodal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Close All / Void Tasks</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                </div>
                <div class="modal-body">
                    <h4 class="text-center"><span id="CloseAllTask"></span></h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal" onclick="CloseTask()">Yes</button>
                    <button type="button" class="btn btnyellow" data-bs-dismiss="modal" onclick="cancelTask('No')">No</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal custmodal" id="DivCloseProjectDate" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Close Project</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                </div>
                <div class="notewrap col-sm-12 graybg"><small>[Actual End Date displayed is last Timesheet entry date/Todays date.]</small></div>
                <div class="clearfix"></div>
                <div class="modal-body">
                    <h4 class="text-center pb-1" style="font-size:14px">Are you sure you want to close project ? </h4><!--modified and added by pradip on 11-4-2023-->
                    

                    <%--<div class="alertform col-sm-8 col-sm-offset-2">--%>
                        <div class="alertform col-sm-8 offset-md-2"><!--commented and added by pradip on 11-4-2023-->
                        
                        <label class="control-label" id="lbltxtProjectActualEnddate">Actual End Date </label>
                        <span style='color: red;'>*</span>
                        <div class="input-group datefielddiv">

                            <% CommonFunctions.HTMLControls.DrawTextBox("txtProjectActualEnddate", "txtProjectActualEnddate", "form-control",,,,,,, True, "white",, "autocomplete='off'",,, True,,,, True) %>
                            <span class="input-group-btn">
                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                            </span>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                    <div class="text-center">
                        <button type="button" class="btn borderbtn" onclick="SaveDate()">Save</button>
                        <button type="button" class="btn btnyellow" data-bs-dismiss="modal" onclick="Closemodal('')">Cancel</button>
                    </div>
                </div>

            </div>
        </div>
    </div>




    <!--closemodal_end_here-->
    <!-- DELETE Modal Start here-->
    <div id="deleteinfomodal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <%--<button type="button" class="close" data-bs-dismiss="modal">&times;</button>--%>
                    <button type="button" class="close" data-bs-dismiss="modal" onclick="cancelDelted()">&times;</button>
                    <h4 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h4>
                </div>

                <div class="modal-body">

                    <span id="DeleteId"></span>
                    <%-- <%= MyBase.GetResourceString("C_Do_you_want_to_Delete") %>--%>
                    <p align="center">Are you sure, you want to delete the selected records ?</p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" onclick="cancelDelted()"><%= MyBase.GetResourceString("C_No") %></button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" onclick="DeleteData()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <%--<div id="NoProjectDivID" hidden="hidden">
        <h4>You have not selected any project, please select the project.</h4>
    </div>--%>
    <div id="NoProjectDivID" hidden="hidden">
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>Session Project is applicable for Project Closure, Please select the project from Project listing page for closing the Project.</h4>
        <%-- <div class="ProjectList"><a onclick="List_onclick()">List Of Projects</a></div>--%>
    </div>


    <div id="DivNotView" class="tab-pane" style="height: 587px; display: none">
        <div style="text-align: center; padding: 275px" class="box box-solid">
            <p>You are not authorized to view this record. </p>
        </div>
    </div>

    <!-- DELETE Modal end here-->
    <!--bootstrap_Alertify-->
    <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" >  <%--hidden="hidden"--%>
        <button type="button" onclick="CloseShowAlert()" class="close">×</button>
        <p id="alertMsg"></p>
    </div>



    <div class="modal custmodal" id="idSkillConformation" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                </div>
                <div class="modal-body">
                    <h5 class="text-center">Data will be automatically saved , Do you want to continue?</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal" onclick="MoveToLL()">Yes</button>
                    <button type="button" class="btn btnyellow" data-bs-dismiss="modal" onclick="CancelToLL()">No</button>
                </div>
            </div>
        </div>
    </div>

    <!-- add by omkar 13/12/2019 -->
    <!-- Lessonlearnt model start-->
    <div class="modal custmodal" id="ConformationLL" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                </div>
                <div class="modal-body">
                    <h5 class="text-center">Data will be automatically saved , Do you want to continue?</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal" onclick="MoveToTC()">Yes</button>
                    <button type="button" class="btn btnyellow" data-bs-dismiss="modal" onclick="cancelToTC('No')">No</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Lessonlearnt model end-->
    <!-- end-->
    <%-- Added by Chetan M. on 13th Dec 2019 --%>
    <div class="modal custmodal" id="ConformationChecklistNext" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                </div>
                <div class="modal-body">
                    <h5 class="text-center">Data will be automatically saved,Do you want to continue?</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal" onclick="YesButtonChecklistPopupClick()">Yes</button>
                    <button type="button" class="btn btnyellow" data-bs-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>


    <!-- DELETE Modal Start here-->
    <div id="deletelessonlearnt" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Delete</h4>
                </div>

                <div class="modal-body">
                    <p align="center">Are you sure you want to delete selected document ?</p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="cancellessdocumentsdelete()">No</button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" onclick="DeleteLessonLearntDocument()" data-bs-dismiss="modal">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <!-- DELETE Modal End here-->
    <%-- End of addition by Chetan M. on 13th Dec 2019 --%>


    <div class="modal custmodal" id="ConformationUpdateSkill" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirmation</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                </div>
                <div class="modal-body">
                    <h5 class="text-center" style="font-size:12px">Would you like to update skills for other resource? if you want then click on 'Yes' else click on No</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal" onclick="UpdateSkill('All')">Yes</button>
                    <button type="button" class="btn btnyellow" data-bs-dismiss="modal" onclick="UpdateSkill('Specific')">No</button>
                </div>
            </div>
        </div>
    </div>

    <!--bootstrap_Alertify-->
    <!-- ./wrapper -->
    </div>


    <!-- REQUIRED JS SCRIPTS -->
        <!-- Commented by Madhuri.K On 09-08-2024 for JQuery and Bootstrap version upgrade -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>

    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>--%>
    
    <script src="../../../Whizible2.0-new/plugins/slimScroll/jquery.slimscroll.min.js"></script>

    <!--style-custome-->
    <!--<script src="dist/js/style_custom.js"></script>-->

    <%--<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.scrollResize.min.js"></script>

    <!-- Bootstrap WYSIHTML5 -->

    <script src="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 --> 
    <!-- <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/moment-2.30.1.js"></script>
    <!-- End of Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 -->
    <!-- <script src="../../../Whizible2.0-new/dist/js/bootstrap-datepicker.min.js"></script> -->
    <script src="../../General/CommonValidations.js?v=1"></script>
    <!--autofilter-->
    <%--
    <script src="../../../Whizible2.0-new/dist/js/autocomplete/tabcomplete.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/autocomplete/livefilter.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/autocomplete/bootstrap-select-autocomplete.js"></script>--%>
    <!-- stickytable js -->
    <!--<script src="../../../Whizible2.0-new/dist/js/table-fixed-header.js"></script>-->

    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js?v=1.5"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js?v=1.5"></script>

    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1.6"></script>
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

   
    <script type="text/javascript">

        //Initialize bootstrap tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, {
                trigger: 'hover'
            });
        });
        //Remove tooltip
        $('body').on('click', function () {
            $('.tooltip').remove();
        });

        //Added By Rehan C To check validation for Special characters  on 15th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
       // var LoginType = '<%= Session("LoginType") %>';

        var ProjectID = '<%= m_ProjectID %>';
        //alert(ProjectID);
        var m_PM_ProjectClosureblnAddAccess = '<%= m_PM_ProjectClosureblnAddAccess %>';
        var m_PM_ProjectClosureblnDeleteAccess = '<%= m_PM_ProjectClosureblnDeleteAccess %>';
        var m_PM_ProjectClosureblnEditAccess = '<%= m_PM_ProjectClosureblnEditAccess %>';
        var m_PM_ProjectClosureblnViewAccess = '<%= m_PM_ProjectClosureblnViewAccess %>';

        var LoggedPerson = "<%= Session("strUserName").ToString() %>";
        var LoggedPersonID = "<%= Session("intUserID").ToString() %>";
        var LoggedPersonRoleID = "<%= Session("intPostID").ToString() %>";
        var gRunningID = 0;
        var TotalCurrentExpDay = '';
        var TotalExpMonth = '';
        var TotalExpYr = '';
        var Day = '';
        var Month = '';
        var TotalExpYr1 = '';
        var intEmployeeDays = '';
        var intEmployeeMonths = 0;
        var intEmployeeYears = 0;
        var Year = '';
        var TotalExpDay = '';
        Skills = new Array;
        Dayarray = new Array;
        Montharray = new Array;
        Yeararray = new Array;
        var UserId = '';
        var NoOfSkill = '';
        var GetMaxDate = '';
        var ProjectStartDate = '';
        var millisecondsPerDay = '';
        var DayDifference = '';
        var millisBetween = '';
        var EmployeeID = 0;
        arr1 = new Array;
        var v1 = '';
        var v2 = '';
        var v3 = '';
        var CurrentDays2 = '';
        var EmployeeID2 = '';
        var removecounter;
        var skillname = '';
        var skillyear = '';
        var skillmnth = '';
        newarrayskill = new Array;
        newarrayyearexp = new Array;
        newarraymonthexp = new Array;
        var ParameterId = '';
        var Version = '';
        var PercentageUtilization = '';
        var CustomerSupplied = '';
        var Critical = '';
        var Procured = '';
        var BriefDescription = '';
        var NumberOfCopies = '';
        var PlannedInDate = '';
        var PlannedOutDate = '';
        var Toolid = '';
        var Toolid2 = '';
        var CreateBy = '';
        UpdateYearExpArray = new Array;
        UpdateMonthExpArray = new Array;
        DBToolIDArray = new Array;
        var UpdateYear = '';
        var UpdateMonth = '';
        var counterforButton = 0;
        var counter1 = 0;
        ToolID2 = new Array;
        ToolID3 = new Array;
        SkillName2 = new Array;
        var SkillLength = '';
        var vActualStartDate = '';
        var vActualEndDate = '';
        var counter = '';
        var SessionProjectName = ''
        var lngTempUsed = 0;
        var m_intYearsToBeShown = 0;
        var m_intMonthsToBeShown = 0;
        var TotalDays = 0;

        //Checklist Global Variable Declaration
        var strQuestionWithOption = "";
        var strShowComment = "";
        var lngTempQuestionID = "";
        var strBtnName = "";
        var GblDescription = "";
        var GblCheckListItemName = "";
        var GblSingleSelection;
        var GblJval;
        var GblResponseval = 0;
        //End of the Checklist global variable declaration.
        var ResourceIDArray = new Array();
        var closeproject;
        var ViewAccess = 0;
        var SelectedEmpMonth = "";
        var SelectedEmpYear = "";
        var SelectedEmployeeID = "";
        var ProjectOver = 0;
        var NODA = 0;
        var IsSkillAdd = 0;
        var SelectProjectActualEndate = "";
        var SelectedCurrentdate = "";
        var IsNodata = 0;
        var Nochecklist = 0;
        var IsDAFillornot = 0;
        $(document).ready(function () {

            $('.btn, a, button, span').tooltip({ trigger: 'hover' });
            new bootstrap.Tooltip(document.body, {
                selector: '[data-bs-toggle="tooltip"]'
            });

            Date.prototype.toShortFormat = function () {

                var month_names = ["Jan", "Feb", "Mar",
                    "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep",
                    "Oct", "Nov", "Dec"];

                var day = this.getDate();
                var month_index = this.getMonth();
                var year = this.getFullYear();

                return "" + day + " " + month_names[month_index] + " " + year;
            }
            SelectedCurrentdate = new Date();

            $($.fn.dataTable.tables(true)).css('width', '100%'); $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
            //$('body').tooltip({
            //    selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
            //    trigger: 'hover',
            //    container: 'body'
            //}).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
            //    $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            //});


            if (ProjectID == 0) {
                $("#ProjectClosureSectionID").hide();

                $("#NoProjectDivID").show();
            }
            else {

                StartLoader("#ProjectClosureBody");
                removecounter = 0;

                if (m_PM_ProjectClosureblnAddAccess == "False") {
                    $("#saveskill").hide();
                    $("#add_row").attr("disabled", true);
                }
                //  alert(m_PM_ProjectClosureblnViewAccess);
                if (m_PM_ProjectClosureblnViewAccess == "False") {
                    $("#DivNotView").css("display", "block")
                    $("#ProjectClosureSectionID").css("display", "none")

                    ViewAccess = 0;

                } else {
                    ViewAccess = 1;
                    $("#DivNotView").css("display", "none")
                    $("#ProjectClosureSectionID").css("display", "block")
                }

                $('.slim-scroll').slimScroll({
                    //your options
                    opacity: 0
                }).mouseover(function () {
                    $(this).next('.slimScrollBar').css('opacity', 0.4);
                });

                if (ViewAccess == 1) {
                    CheckProjectOver(ProjectID);
                    Get_PM_MinDate(ProjectID);
                    Get_PM_MaxDate(ProjectID);

                    GetAllInfoAboutProject(ProjectID);
                    GetEmployeeToAllocateProject(ProjectID);
                    CalculationOfTotalDays(ProjectStartDate, GetMaxDate);
                    //debugger;
                    Get_PM_ProjectTools(ProjectID, SelectedEmployeeID, ProjectOver);
                    // TotalExpCal(CurrentDays2, EmployeeID2);
                    GetPublishedCheckList(ProjectID);
                    //tblSkillsInfo
                    GetProjectOverview(ProjectID);
                    // alert(ProjectOver);

                    /// alert(NoResource);
                  // debugger;
                    if (ProjectOver != 1) {
                        if (NoResource == 1) {
                            $("#add_row").attr("disabled", true);
                            $("#saveskill").attr("disabled", true);
                            //add by omkar 12/12/2019
                            // $("div>#searchresource").css("display", 'none');
                            //end

                        }
                        else {
                            $("#add_row").attr("disabled", false);
                            $("#saveskill").attr("disabled", false);
                            //add by omkar 12/12/2019
                            //$("div>#searchresource").css("display", 'inline');
                            //end

                        }
                    } else {
                        $("#add_row").attr("disabled", true);
                        $("#saveskill").attr("disabled", true);
                    }
                    //debugger;
                    //Commmented and Modified by Nikhil A on 19-Apr-2021
                    //if (NODA == 1 || ProjectOver == 1 || NoResource == 1)
                    if (NODA == 1 || ProjectOver == 1 || NoResource ==1 ) {
                       // $('#tblSkillsInfo .timenoinput').prop('disabled', true);
                        $('#saveskill').prop('disabled', false);
                        $("#add_row").attr("disabled", false);
                        $("#tblSkillsInfo tr td").attr("disabled", true);
                        $("#tblSkillsInfo tr td").css("cursor", "not-allowed");
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        //$("#saveskill").attr("data-original-title", "");
                        //$("#saveskill").attr("data-original-title", "Selected resource");
                        //$("#saveskill").attr('data-bs-toggle', 'tooltip');
                        //$("#saveskill").attr('data-bs-placement', 'bottom');


                    } else {
                        if (NoResource == 1) {
                            $("#add_row").attr("disabled", true);
                            $("#saveskill").attr("disabled", true);
                            //add by omkar 12/12/2019
                            //$("div>#searchResource").css("display", 'none');
                            //end

                        } else {
                            $('#tblSkillsInfo .timenoinput').prop('disabled', false);
                            $('#saveskill').prop('disabled', false);
                            $("#add_row").attr("disabled", false);
                            $("#tblSkillsInfo tr td").css("cursor", "");
                            $('[data-bs-toggle="tooltip"]').tooltip();
                            //$("#saveskill").attr("data-original-title", "");
                            //$("#saveskill").attr("data-original-title", "");
                            //$("#saveskill").attr('data-bs-toggle', '');
                            //$("#saveskill").attr('data-bs-placement', '');
                        }
                    }

                }
                // CheckProjectOver(ProjectID);
               // debugger;
                //if (IsNodata == 0) {
                //    $('#saveskill').attr('disabled', true);
                //    //$("#add_row").attr("disabled", true);
                //} else {
                //    $('#saveskill').attr('disabled', false);
                //   // $("#add_row").attr("disabled", false);
                //}
                $('.popper').popover({
                    placement: 'right',
                    container: 'body',
                    html: true,
                    content: function () {
                        return $(this).next('.popper-content').html();
                    }
                });
            }
            $("#searchResource").tooltip();

            StopAjaxLoader("#ProjectClosureBody");
        });






        $('.prevtab').on('click', function () {
            StartLoader("#ProjectClosureBody");
            refresh();

            arrSkillnewControlID = [];
            IsSkillAdd = 0;
            StopAjaxLoader("#ProjectClosureBody");
            $('.wizard .wizard-inner .nav-tabs li.active').prev('li').removeClass('Compltedstep');
            $($.fn.dataTable.tables(true)).css('width', '100%');
            $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
             $("#tbodytblAddNewSkill").html("");
        });

        //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
            if (WebConfigSpecialCharacters != '') {
                var regularExpression = WebConfigSpecialCharacters;
                regularExpression += '"';
                var isSpecialCharacter = 0;
                for (var i = 0; i < regularExpression.length; i++) {
                    if (value.indexOf(regularExpression[i]) != -1) {
                        isSpecialCharacter = 1
                    }
                }
                if (isSpecialCharacter == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }
        }

        function refresh() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });


            if (ProjectID == 0) {
                $("#ProjectClosureSectionID").hide();

                $("#NoProjectDivID").show();
            }
            else {

                //StartLoader("#ProjectClosureBody");
                removecounter = 0;

                if (m_PM_ProjectClosureblnAddAccess == "False") {
                    $("#saveskill").hide();
                    $("#add_row").attr("disabled", true);
                }
                //  alert(m_PM_ProjectClosureblnViewAccess);
                if (m_PM_ProjectClosureblnViewAccess == "False") {
                    $("#DivNotView").css("display", "block")
                    $("#ProjectClosureSectionID").css("display", "none")

                    ViewAccess = 0;

                } else {
                    ViewAccess = 1;
                    $("#DivNotView").css("display", "none")
                    $("#ProjectClosureSectionID").css("display", "block")
                }

                $('.slim-scroll').slimScroll({
                    //your options
                    opacity: 0
                }).mouseover(function () {
                    $(this).next('.slimScrollBar').css('opacity', 0.4);
                });

                if (ViewAccess == 1) {
                    CheckProjectOver(ProjectID);
                    Get_PM_MinDate(ProjectID);
                    Get_PM_MaxDate(ProjectID);

                    GetAllInfoAboutProject(ProjectID);
                    GetEmployeeToAllocateProject(ProjectID);
                    CalculationOfTotalDays(ProjectStartDate, GetMaxDate);
                    //debugger;
                   // CheckProjectOver(ProjectID);
                    Get_PM_ProjectTools(ProjectID, SelectedEmployeeID, ProjectOver);
                    $("#checkboxcloseall").attr('disabled', false);
                    $("#checkboxcloseall").prop('checked', false);
                    getProjectCloserDetails("all");
                    // TotalExpCal(CurrentDays2, EmployeeID2);
                    //Commented by Chetan M. on 13th Dec 2019
                    GetPublishedCheckList(ProjectID);
                    //End of commented by Chetan M. on 13th Dec 2019
                    //tblSkillsInfo
                    GetProjectOverview(ProjectID);
                    GetProjectTeamData(ProjectID);
                    GetHardwareUsed(ProjectID);
                    GetToolsUsed(ProjectID);
                    //Added by Chetan M. on 17th Dec 2019
                    GetReusableItems(ProjectID);
                    //end of addition by Chetan M. on 17th Dec 2019
                    GetLessonsLearned(ProjectID);
                    GetEffortDistribution(ProjectID);
                    GetProjectActualEndDate(ProjectID);
                    // alert(ProjectOver);

                    /// alert(NoResource);
                    // debugger;
                    if (ProjectOver != 1) {
                        if (NoResource == 1) {
                            $("#add_row").attr("disabled", true);
                            $("#saveskill").attr("disabled", true);
                            $("#searchResource").css("display", 'none');

                        }
                        else {
                            $("#add_row").attr("disabled", false);
                            $("#saveskill").attr("disabled", false);
                            $("#searchResource").css("display", 'inline');

                        }
                    } else {
                        $("#add_row").attr("disabled", true);
                        $("#saveskill").attr("disabled", true);
                    }
                    // debugger;
                    //if (NODA == 1 || IsNodata == 0 || ProjectOver==1) {
                    //Added and Modified By Nikhil A on 19-Apr-2021
                    //if (NODA == 1 || ProjectOver == 1 || NoResource == 1)
                     if (NODA == 1 || ProjectOver==1 ||NoResource ==1){
                        //$('#tblSkillsInfo .timenoinput').prop('disabled', true);
                        $('#saveskill').prop('disabled', true);
                        $("#add_row").attr("disabled", true);
                        $("#tblSkillsInfo tr td").attr("disabled", true);
                        $("#tblSkillsInfo tr td").css("cursor", "not-allowed");
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        //$("#saveskill").attr("data-original-title", "");
                        //$("#saveskill").attr("data-original-title", "Selected resource");
                        //$("#saveskill").attr('data-bs-toggle', 'tooltip');
                        //$("#saveskill").attr('data-bs-placement', 'bottom');


                    } else {
                        if (NoResource == 1) {
                            $("#add_row").attr("disabled", true);
                            $("#saveskill").attr("disabled", true);
                            $("#searchResource").css("display", 'none');

                        } else {
                            $('#tblSkillsInfo .timenoinput').prop('disabled', false);
                            $('#saveskill').prop('disabled', false);
                            $("#add_row").attr("disabled", false);
                            $("#tblSkillsInfo tr td").css("cursor", "");
                            $('[data-bs-toggle="tooltip"]').tooltip();
                            //$("#saveskill").attr("data-original-title", "");
                            //$("#saveskill").attr("data-original-title", "");
                            //$("#saveskill").attr('data-bs-toggle', '');
                            //$("#saveskill").attr('data-bs-placement', '');
                        }
                    }


                    if (NODA == 1) {
                        $('#saveskill').prop('disabled', false);
                        $('#add_row').prop('disabled', false);
                    }

                }


                //debugger;
                //if (IsNodata == 0)
                //{
                //    $('#saveskill').attr('disabled', true);
                //    //$("#add_row").attr("disabled", true);
                // } else {
                //     if ($("#add_row").prop("disabled") == true) {
                //         $('#saveskill').attr('disabled', true);
                //     }
                //     else {
                //          $('#saveskill').attr('disabled', false);
                //     }

                //   // $("#add_row").attr("disabled", false);
                //}
                $('.popper').popover({
                    placement: 'right',
                    container: 'body',
                    html: true,
                    content: function () {
                        return $(this).next('.popper-content').html();
                    }
                });
                arrTaskIds = [];
                formdata = new FormData();
                deletedFileCnt = [];
            }
            //$(document).on("click", "#addnewSkillDelete", function () {

            //});

            //function addnewSkillDelete() {
            //    alert();
            //    $(this).parents("tr").remove();
            //    checkvalidation = 0;
            //    IsSkillAdd = 0;
            //}

            // StopAjaxLoader("#ProjectClosureBody");
        }

        $(".round-tab").on('click', function () {
             $(".popover").removeClass('show');
            refresh();
            //StopAjaxLoader("#ProjectClosureBody");
        });
        var ResourceCounter = 0;
        var NoResource = 0;
        function ResourceData(data) {
            var strHTML = "";
            //debugger;
            $("#resourcenamelist").empty();
            //  debugger;
            if (data.length == 0) {
                strHTML += '<li id="NotResource"> Resorces are not assigned for this project.</li>'
                $("#add_row").attr('disabled', true);

            }
            else {
                for (var i = 0; i < data.length; i++) {
                    //debugger;
                    //Check as Per ProjectStatus Active Rersource
                    if (ProjectOver == 0) {
                        var ForActiveProjectResource = (data[i].ActualEndDate == "");
                    } else {
                        var ForActiveProjectResource = (data[i].ActualEndDate != "");
                    }
                    //End of Check as Per ProjectStatus Active Rersource

                    //  debugger;
                    if (ForActiveProjectResource == true) {
                        ResourceCounter = ResourceCounter + 1;
                        var Responsibility = data[i].Responsibility;
                        // alert(Responsibility);
                        if (Responsibility != null) {
                            Responsibility = Responsibility;
                        }
                        else {
                            Responsibility = "NA";

                        }
                        // NoResource = 1;

                        strHTML = "";
                        strHTML += '<li class="nav-item" id="liName' + i + '_' + data[i].EmployeeID + '"> <a href="#RSupdate1" class="nav-link active" onclick=TotalExpCal2(' + data[i].CurrentDays + ',' + data[i].EmployeeID + ','+ i +'); data-bs-toggle="tab" role="tab" aria-expanded="true"><span class="resprofile"><img src="../../../Images/Photo/' + data[i].SystemFilename + '" width="30" alt="user progfile" onerror=this.src="../../../Images/Photo/no-photo.png" title=""></span><span id="spnEmployeeName' + i + '">' + data[i].UserName + '</span>'

                        strHTML += '<span class="resourceinfo popper" data-bs-toggle="popover">&nbsp;</span>'
                        strHTML += '<div class="popper-content hide">'
                        strHTML += '<h5 class="skrresourcename"><strong><span id="spnEmployeeName">' + data[i].UserName + '</span></strong></h5>'
                        strHTML += '<p>' + data[i].RoleDescription + '</p>'

                        strHTML += '<p><strong>Start Date :</strong> ' + data[i].ExpectedStartDate + '<br /> <strong>End Date:</strong> ' + data[i].ExpectedEndDate + '</p>'
                        if (data[i].ResourcePercentage != "" && data[i].ResourcePercentage != null && data[i].ResourcePercentage != undefined) {
                            strHTML += '<p><strong>% Allocation :</strong> ' + data[i].ResourcePercentage.toFixed(2) + '</p>'
                        }
                        else {
                            strHTML += '<p><strong>% Allocation :</strong> 00.00</p>'
                        }
                        strHTML += '<p><strong>Responsibility :</strong> ' + Responsibility + '</p>'
                        strHTML += '</div >'
                        strHTML += '</li>'
                        //strHTML += '<li id="filterNodata" style="display:none"></li>'
                        $("#resourcenamelist").append(strHTML);
                        //$("#add_row").prop("disabled", false);
                    }
                }
            }

            if (strHTML == "") {
                NoResource = 1;
                strHTML += '<li id="NotResource" style="text-align: center;"> Resorces are not assigned for this project.</li>'
                $("#resourcenamelist").append(strHTML);
                $("#add_row").attr('disabled', true);
            }

            if ($("#resourcenamelist li").length == 0 && NoResource == 1) {
                $("#resourcenamelist").append('<li id="filterNodata" style="text-align:center">There is no such record found</li>');
            } else {
                $("#resourcenamelist").append('<li id="filterNodata" style="display:none;text-align:center">There is no such record found</li>');
            }
            
            var LiID = $("ul#resourcenamelist li:first").attr("id").find('a');
            
            $("#" + LiID).addClass("active");
            
            var Result = LiID.split("_");
            SelectedEmployeeID = Result[1];
            EmployeeID = SelectedEmployeeID;
            //alert(EmployeeID);
            // alert(SelectedEmployeeID);
        }





        //start script - Name lenght of task closure step
        function textAbstract(el, maxlength) {
            maxlength = maxlength = 100;
            let txt = $(el).text();
            if (el == null) {
                return "";
            }
            if (txt.length <= maxlength) {
                return txt;
            }
            let t = txt.substring(0, maxlength);
            let re = /\s+\S*$/;
            let m = re.exec(t);
            t = t.substring(0, m.index);
            return t + "...";
        }
        var maxlengthwanted = 100;
        //$('.tskclsrnametext span').each(function (index, element) {
        //    $(element).text(textAbstract(element, maxlengthwanted, " "));
        //});
        //End script - Name lenght of task closure step

        //$(window).load(function () {
        //    //$(document).ready(function () {
        //    //var table = $('#wbsMStbl').DataTable();
        //    //table.columns.adjust().draw();
        //    //});
        //});

        $(".summurytbl").DataTable({
            "scrollY": 150,
            "scrollCollapse": false,
            "scrollX": true,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
            $('table').resize();


        });

        //closemodal
        $('.closemodal').change(function () {
            $('#closemodal').modal();
        });

        // $(document).ready(function () {
        //start script - dynamically set height
        function resizeSection(tag) {
            var skill = $(window).height();
            $('.practicesettinglist .tab-pane .row .col-sm-6 .slim-scroll').css({ 'height': skill - 172 });


            var lesonlearnt = $(window).height();
            $('#step2').css({ 'height': lesonlearnt - 125, "overflow-y": "auto" });

            var closure = $(window).height();
            $('#step3').css({ 'height': closure - 125, "overflow-y": "auto" });

            var lesonlearnt = $(window).height();
            $('#step4').css({ 'height': lesonlearnt - 125, "overflow-y": "auto" });

            var closurestepsheight = $(window).height();
            $('#step5').css({ 'height': closurestepsheight - 125, "overflow-y": "auto" });

            var rskilllist = $(window).height();
            $('#resourcenamelist').css({ 'height': rskilllist - 235 });


            //lesson learn table height
            var height = $(window).height();
            $(".resizeblock_lessonlrnt").css("height", height - 200);




            var tabpaneheight = $(window).height();
            $('.wizard .tab-pane').css({ 'height': tabpaneheight - 125, "overflow-y": "auto" });

        }


        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });
        //End script - dynamically set height



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
        $(".chcktbl").on('click', function () {
            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }
        });
        //checkbox-checkAll-endsave

        //Update Resource task
        var counter = 0;

        //var i = "1";
        //var j = "1";

         //Added by Chetan M. on 16th Dec 2019
        var SkillChangeFlag = 0;
        var SkillUpdateFlag = 0;
        //End of addition by Chetan m. on 16th Dec 2019

        var skillCount = "1";
        var addarray = new Array;
       // $("#add_row").on("click", function () {

       
        function addrowbtn() {
            gRunningID ++;
             
            //Added by Chetan M. on 16th Dec 2019
            SkillChangeFlag = 1;
            //End of addition by Chetan m. on 16th Dec 2019
            $("#btnNextLessonLearnt").prop("disabled", true);
            counterforButton = 0;
            var strhtmlNew = "";
            UpdateMonthExpArray.length = 0;
            //Commented and added by Chetan M on 13th Dec 2019
            var newRow = "";
            //$("#tbodytblAddNewSkill").html("");
            //End of added by Chetan M. on 13th Dec 2019
            var newRow = $("<tr id='trskill" + gRunningID + "'>");
            var cols = "";

            //cols += '<td class="dropdown myskilldropdown"><input id="sklllistfield' + skillCount + '" type="text" onkeyup="rsearch()" class="form-control skillfields" name="name' + counter + '" placeholder="Skill Name" autocomplete="OFF" /></td>';
            strhtmlNew = '<%=CommonFunctions.HTMLControls.DrawComboBox("sklllistfield_FieldName_EmployeeID", "select ''", , , "onchange='GetMonthYear(FieldName)' class='form-control clsMandatoryFields'", True, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
            strhtmlNew = strhtmlNew.replace(/FieldName/g, skillCount);
            strhtmlNew = strhtmlNew.replace(/EmployeeID/g, EmployeeID);
            cols += '<td class="dropdown myskilldropdown">';
            cols += strhtmlNew;
            cols += '</td>';
            cols += '<td><input id="yearfield_' + skillCount + '_' + EmployeeID + '" type="text" class="form-control clsMandatoryFields" name="mail' + counter + '"  placeholder="Years(s)" autocomplete="OFF" onkeypress="return restrictAlphabets(event, &quot;weekdays&quot;)" Maxlength="4"/></td>';
            cols += '<td><input id="monthfield_' + skillCount + '_' + EmployeeID + '" type="text" class="form-control clsMandatoryFields" name="mail' + counter + '"  placeholder="Month(s)" autocomplete="OFF" onkeypress="return restrictAlphabets(event, &quot;weekdays&quot;)" style="width: 86px;" Maxlength="2"/></td>';

            //Commented and Added by Chetan M. on 12th Dec 2019 to add close button for add new skill row
            cols += '<td><a id="addnewSkillDelete' + gRunningID + '" class="nostylebtn " onclick="addnewSkillDelete(' + gRunningID +')"><img class="" src="../../../Whizible2.0-new/dist/img/close-gray.svg" width="16" alt="" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Remove Row"></a></td>';
            //cols += '<td><a id="addnewSkillDelete" class="nostylebtn " onclick=""><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Remove Row"></i></a></td>';
            //End of addition by Chetan M on 9th Dec 2019

            newRow.append(cols);
            //$("table.lessonlearttbllist").append(newRow);
            //Commented and added by Chetan M on 13th Dec 2019
            //$("#tbodytblAddNewSkill").html(newRow);
            $("#tbodytblAddNewSkill").append(newRow);
            //End of added by Chetan M. on 13th Dec 2019
            GetSkillDropDown("sklllistfield_" + skillCount + '_' + EmployeeID);
            //i++;
            //j++;
            skillCount++;
            counter++;
            counter1++;
           // if (IsNodata == 0) {
           //     $("#saveskill").attr("disabled", false);
           // }
           ////
            // addarray.push($("#sklllistfield + 'i'").val() + ',' + $("#yearfield + ' j'").val() + ',' + $("#mnthfield + ' k'").val());

        }







        $(document).on("click", "#add_row", function () {


        });

        //Added by Chetan M. on 9th Dec 2019
        $(document).on("click", ".clsRowDelete", function () {
            $(this).parents("tr").remove();

            $("#lessonlearttbl_wrapper .dataTables_paginate a").css({ "pointer-events": "auto", "cursor": "pointer!important" });
            $("#lessonlearttbl_wrapper .dataTables_paginate a:hover").css({ "pointer-events": "auto", "cursor": "pointer!important" });
            $("#lessonlearttbl_wrapper .dataTables_paginate").css("cursor", "pointer");

            $("#lessonlearttbl_wrapper .dataTables_paginate a").mouseover(function () {
                $(this).css("cursor", "pointer");
            });
            $(".actioncolumn").css("cursor", "pointer");
            $(".actioncolumn a").css("pointer-events", "auto");
            //add by omkar 16/12/2019
            editflag = false;
        })


        //$(document).on("click", "#addnewSkillDelete", function () {
        //$(document).on("#addnewSkillDelete", function () {
        //$("#addnewSkillDelete").click(function () {
        //    alert('tet');
        //});

        //addnewSkillDelete = function (el) {
        //    $(el).parents("tr").remove()
        //}


        // addnewSkillDelete = function (el) {
        function addnewSkillDelete(RowID) {
           
            /*$("trskill" + RowID).css('border','1px solid #000');*/
            $("#addnewSkillDelete" + RowID).parents("tr").remove();


            checkvalidation = 0;
            IsSkillAdd = 0;


            //Added by Chetan M. on 17th Dec 2019
            var rowCount = $('#tbodytblAddNewSkill tr').length;
            if (rowCount == 0) {
                SkillChangeFlag = 0;
                // $("#saveskill").attr("disabled", true);
            }
            //End of addition by Chetan M. on 17th Dec 2019
            var cntActiveSkills = 0;
            $('*[id*=sklllistfield]').each(function () {
                cntActiveSkills = cntActiveSkills + 1;
            });
            if (cntActiveSkills == 0) {
                $("#btnNextLessonLearnt").prop("disabled", false);
            }
        }


        //End of addition by Chetan M on 9th Dec 2019
        //Added By Dipali V On For Skill Depend Month & year should come

        function GetMonthYear(ControlID) {
            checkvalidation = 0;
            //alert(IsDAFillornot);
            if (SelectedEmpYear == null || SelectedEmpYear == "") {
                SelectedEmpYear = 0;
            }
            if (SelectedEmpMonth == null || SelectedEmpMonth == "") {
                SelectedEmpMonth = 0;
            }
            //Added By Dipali V On 20th April 2021 For Get Max Experience
            if (globalmaxYearsOfExperience != SelectedEmpYear) {
                SelectedEmpYear = globalmaxYearsOfExperience;
            }
             if (globalMaxMonthsOfExperience != SelectedEmpMonth) {
                SelectedEmpMonth = globalMaxMonthsOfExperience;
            }
              //End of Added By Dipali V On 20th April 2021 For Get Max Experience
            $("#yearfield_" + ControlID + "_" + EmployeeID).val(SelectedEmpYear);
            $("#monthfield_" + ControlID + "_" + EmployeeID).val(SelectedEmpMonth);

            //arrSkillYearnewControlID.push("yearfield_" + ControlID + "_" + EmployeeID);
            //arrSkillMonthnewControlID.push("monthfield_" + ControlID + "_" + EmployeeID);
            //arrSkillnewControlID.push(ControlID);
            //debugger;
            if ($("#yearfield_" + ControlID + "_" + EmployeeID).length == 1 || $("#monthfield_" + ControlID + "_" + EmployeeID).length == 1) {
                IsSkillAdd = 1;
            } else {
                IsSkillAdd = 0;
            }

            if (IsDAFillornot == 1) {
                $("#yearfield_" + ControlID + "_" + EmployeeID).attr("disabled", true);
                $("#monthfield_" + ControlID + "_" + EmployeeID).attr("disabled", true);
            } else {
                $("#yearfield_" + ControlID + "_" + EmployeeID).attr("disabled", false);
                $("#monthfield_" + ControlID + "_" + EmployeeID).attr("disabled", false);

            }
            //debugger;
            //Get_PM_ProjectTools(ProjectID, EmployeeID, ProjectOver);

        }



        function GetSkillDropDown(ControlID) {
            var Parameters = {
                ProjectID: ProjectID,

            };
            //alert(ControlID);
            if (ProjectID != "" && ProjectID != undefined) {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectClosure/GetSkillDropDown',
                    method: 'Post',
                    data: JSON.stringify(Parameters),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    success: function (strResult) {
                        if (strResult != "") {
                            //debugger;
                            var objCbo1 = document.getElementById(ControlID);

                            $("#" + ControlID + " option").remove();

                            for (var i = 0; i < strResult.length; i++) {
                                // debugger;
                                var Objresult = strResult[i];
                                var objOption = document.createElement("OPTION");
                                objCbo1.options.add(objOption);

                                objOption.value = Objresult.ToolID;
                                objOption.text = Objresult.Description == 0 ? '' : Objresult.Description;

                            }
                        }
                        $('select option')
                            .filter(function () {
                                return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                            })
                            .remove();
                    },

                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }
        }

        var SaveSkillDataArray = new Array();


        function PostPM_SkillsExperiance(ProjectID, EmployeeID, Toolid, pYearExp, pMonthExp, blnAddToExistingExperience) {
            var ExperianceAttribute = {
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID),
                ToolID: encodeURI(Toolid),
                YearsOfExperience: encodeURI(pYearExp),
                MonthsOfExperience: encodeURI(pMonthExp),
                blnAddToExistingExperience: encodeURI(blnAddToExistingExperience)
            };

            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/PostSkillExperiance',
                method: 'Post',
                data: JSON.stringify(ExperianceAttribute),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    //if (ExperianceAttribute) {
                    //    xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                    //}
                },
                success: function (result) {
                    // alert(result);
                    //  Get_PM_ProjectTools(ProjectID);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        //added By Dipali V On 18th Nov 2019 For Validate & Update Skill
        var arrtoolID = new Array();
        var arryear = new Array();
        var arrmonth = new Array();
        var arrIsNewExiting = new Array();
        var arrtool = "";
        var arrID = "";
        var arrYear = "";
        var arrYearID = "";
        var arrMonth = "";
        var arrMonthID = "";
       // $("#saveskill").click(function () {
        
        function saveskillfun() {
            
            var ControlID = "";
            //debugger;
            var Isnew = 0;
            var Flag = "";
            checkvalidation = 0;
            //if (IsNodata == 1) {
            if (Validation() == true) {
                if (IsSkillAdd != 1) {
                    $("#ConformationUpdateSkill").modal('show');
                } else {
                    UpdateSkill("Specific");

                }

                IsSkillAdd = 0;

                ////Added by Chetan M. on 16th Dec 2019
                SkillUpdateFlag = 0;
                SkillChangeFlag = 0;
                ////End of addition by Chetan M. on 16th Dec 2019
                //$("#btnNextLessonLearnt").prop("disabled", false);
            }
            else {
                SkillUpdateFlag = 1;
            }

        }
       // });

        var Selected = 0;
        function UpdateSpecific() {
            var Flag = 0;
            arrtoolID = [];
            arryear = [];
            arrmonth = [];
            $("#RSupdate1 input:hidden.clsMandatoryFields,select.clsMandatoryFields,input:text.clsMandatoryFields").each(function () {
                //$(".tbodylevelActivity input[name='textActivityHr").each(function () {
                //debugger;
                var ControlID = this.id;
                var ToolID = ControlID.replace("skillyear", "");
                var ToolID = $("#SkillsName" + ToolID).val();
                if (ToolID != undefined) {
                    arrtoolID.push(ToolID);
                    arrIsNewExiting.push(0);
                }

                if (ControlID.indexOf('year') > -1) {
                    arryear.push($("#" + ControlID).val());
                }

                if (ControlID.indexOf('month') > -1) {
                    arrmonth.push($("#" + ControlID).val());
                }

                if (ControlID.indexOf('sklllistfield') > -1) {
                    arrtoolID.push($("#" + ControlID).val());
                    arrIsNewExiting.push(1);
                }
            });


            for (i = 0; i <= arrmonth.length - 1; i++) {
                //StartLoader("#ProjectClosureBody");
                var ExperianceAttribute = {
                    ProjectID: encodeURI(ProjectID),
                    EmployeeID: encodeURI(EmployeeID),
                    ToolID: encodeURI(arrtoolID[i]),
                    YearsOfExperience: encodeURI(arryear[i]),
                    MonthsOfExperience: encodeURI(arrmonth[i]),
                    blnAddNewSkill: encodeURI(arrIsNewExiting[i])
                };
                $.ajax({
                    url: strUrl + '/api/PM_ProjectClosure/PostSkillExperiance',
                    method: 'Post',
                    data: JSON.stringify(ExperianceAttribute),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        //if (ExperianceAttribute) {
                        //    xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                        //}
                    },
                    success: function (result) {
                        //debugger;
                        if (result != "") {
                            // alert(Flag);
                            if (Flag != 1) {
                                Flag = result[0].flag;
                            }
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
               // return Flag;
            }

            Selected = Flag;

            arrtoolID = [];
            arryear = [];
            arrmonth = [];
            arrIsNewExiting = [];
            arrID = "";
            arrYear = "";
            arrYearID = "";
            arrMonth = "";
            arrMonthID = "";
            IsSkillAdd = 0;

            //return Flag;

        }


        function UpdateSkill(flag) {
            var Flag = 0;
            if (flag == "Specific") {
                arrtoolID = [];
                arryear = [];
                arrmonth = [];
                $("#RSupdate1 input:hidden.clsMandatoryFields,select.clsMandatoryFields,input:text.clsMandatoryFields").each(function () {
                    //$(".tbodylevelActivity input[name='textActivityHr").each(function () {
                    //debugger;
                    var ControlID = this.id;
                    var ToolID = ControlID.replace("skillyear", "");
                    var ToolID = $("#SkillsName" + ToolID).val();
                    if (ToolID != undefined) {
                        arrtoolID.push(ToolID);
                        arrIsNewExiting.push(0);
                    }

                    if (ControlID.indexOf('year') > -1) {
                        arryear.push($("#" + ControlID).val());
                    }

                    if (ControlID.indexOf('month') > -1) {
                        arrmonth.push($("#" + ControlID).val());
                    }

                    if (ControlID.indexOf('sklllistfield') > -1) {
                        arrtoolID.push($("#" + ControlID).val());
                        arrIsNewExiting.push(1);
                    }
                });


                for (i = 0; i <= arrmonth.length - 1; i++) {
                    StartLoader("#ProjectClosureBody");
                    var ExperianceAttribute = {
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(EmployeeID),
                        ToolID: encodeURI(arrtoolID[i]),
                        YearsOfExperience: encodeURI(arryear[i]),
                        MonthsOfExperience: encodeURI(arrmonth[i]),
                        blnAddNewSkill: encodeURI(arrIsNewExiting[i])
                    };
                    $.ajax({
                        url: strUrl + '/api/PM_ProjectClosure/PostSkillExperiance',
                        method: 'Post',
                        data: JSON.stringify(ExperianceAttribute),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            //if (ExperianceAttribute) {
                            //    xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                            //}
                        },
                        success: function (result) {
                            //debugger;
                            if (result != "") {
                                // alert(Flag);
                                if (Flag != 1) {
                                    Flag = result[0].flag;
                                }
                            }
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
                StopAjaxLoader("#ProjectClosureBody");

                    if (Flag != 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("Experience Updated  Successfully.");


                    } else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("New Skill Added Successfully.");
                    }

                 globalMaxMonthsOfExperience = "";
                globalmaxYearsOfExperience = "";
                arrtoolID = [];
                arryear = [];
                arrmonth = [];
                arrIsNewExiting = [];
                arrID = "";
                arrYear = "";
                arrYearID = "";
                arrMonth = "";
                arrMonthID = "";
                IsSkillAdd = 0;

                StartLoader("#ProjectClosureBody");
                Get_PM_ProjectTools(ProjectID, EmployeeID, ProjectOver);
                $("#tbodytblAddNewSkill").html("");
                StopAjaxLoader("#ProjectClosureBody");

                //Added by Chetan M. on 16th Dec 2019
                SkillUpdateFlag = 0;
                SkillChangeFlag = 0;
                //End of addition by Chetan M. on 16th Dec 2019
                $("#btnNextLessonLearnt").prop("disabled", false);
            }
            else {

                UpdateSpecific();
                //alert(EmployeeID);
                 var ExperianceAttribute = {
                     ProjectID: encodeURI(ProjectID),
                      EmployeeID: encodeURI(EmployeeID),

                    };
                $.ajax({
                    url: strUrl + '/api/PM_ProjectClosure/PostAllResourceSkillExperiance',
                    method: 'Post',
                    data: JSON.stringify(ExperianceAttribute),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ExperianceAttribute) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                        }
                    },
                    success: function (result) {
                        //debugger;

                        if (result != "") {

                            if (Flag != 1) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success("Experience Updated  Successfully.");
                            }

                        }
                         Get_PM_ProjectTools(ProjectID, EmployeeID, ProjectOver);
                    }
                });

            }
        }



        function restrictAlphabets(e, flag) {
            //debugger;
            checkvalidation = 0;
            var x = e.which || e.keycode;
            //Commented And Added By Usha Pandit On 18.06.2020 For restricting special characters
            //if ((x >= 48 && x <= 57) || x == 8 ||
            //    (x >= 35 && x <= 40)) //|| x == 46)
            //    return true;
            //else
            //    return false;

            if ((x >= 48 && x <= 57) || x == 8 ||
                x == 46)
                return true;
            else
                return false;

            //End Of Added By Usha Pandit On 18.06.2020 For restricting special characters
        }


        var arrControlID = new Array();
        var checkvalidation = 0;
        function Validation() {
            var ControlID = "";
            $("#RSupdate1 input:hidden.clsMandatoryFields,select.clsMandatoryFields,input:text.clsMandatoryFields").each(function () {
              //  debugger;
                ControlID = this.id;
                if (ControlID.indexOf('year') > -1) {
                    arryear.push($("#" + ControlID).val());
                    arrControlID.push(ControlID);
                }

                if (ControlID.indexOf('month') > -1) {
                    arrmonth.push($("#" + ControlID).val());
                    arrControlID.push(ControlID);
                }
            });

            //Added By Usha Pandit On 26.03.2020 For not allowing blank skill to be inserted
            //var skilllistid = ControlID.toString().replace("monthfield","sklllistfield");
            //alert(skilllistid);
            //if ($("#" + skilllistid + " " + "option:selected").val() == 0) {
            //    checkvalidation = 1;
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.error("Please select skill name");
            //    $("#" + skilllistid).focus();
            //}
            //$('*[id*=tr_]').each(function () {
            //    $(this).remove();
            //});
            var blnSkillsExist = false;;
            $('*[id*=sklllistfield]').each(function () {
                blnSkillsExist = true;
                var skilllistid = $(this).attr("id");
                if ($("#" + skilllistid + " " + "option:selected").val() == 0) {
                    checkvalidation = 1;
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please select skill name");
                    $("#" + skilllistid).focus();
                    return false;
                }
            });

            //Added By Usha Pandit On 08.07.2020 For validating skills added before save
            if (blnSkillsExist == false && ControlID == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select atleast one skill");
                return false;
            }
            //End Of Added By Usha Pandit On 08.07.2020 For validating skills added before save

            if (ControlID == null || ControlID == undefined || ControlID == "") {
                return true;
            }
            var curControlID = ControlID;
            //End Of Added By Usha Pandit On 26.03.2020 For not allowing blank skill to be inserted
            //"sklllistfield_" + skillCount + '_' + EmployeeID

            //  debugger;
            //Added By Usha Pandit On 26.03.2020 for validation of selecting skill
            if (arryear.length == 0) {
                checkvalidation = 1;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please add atleast one skill");
            }
            //End Of Added By Usha Pandit On 26.03.2020 for validation of selecting skill
            // alert(ControlID)
            // return;
            for (i = 0; i <= arryear.length - 1; i++) {

                if (checkvalidation == 0) {
                    // debugger
                    var ExperianceAttribute = {

                        EmployeeID: EmployeeID,
                        ProjectID: ProjectID,
                        YearsOfExperience: encodeURI(arryear[i]),
                        MonthsOfExperience: encodeURI(arrmonth[i])
                    };
                    $.ajax({
                        url: strUrl + '/api/PM_ProjectClosure/GetMonthYearValidation',
                        method: 'Post',
                        data: JSON.stringify(ExperianceAttribute),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (ExperianceAttribute) {
                                xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                            }
                        },
                        success: function (result) {
                            //debugger;
                            if (result != "") {
                                checkvalidation = 1;
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(result);
                                var ControlID = [i] * 2;
                                // alert(ControlID);
                                $("#" + arrControlID[ControlID]).focus();
                                arrControlID = [];
                                arrtoolID = [];
                                arryear = [];
                                arrmonth = [];
                            }
                            //Added By Usha Pandit On 26.03.2020 For validation regarding non zero month/year validation
                            if (result == "") {
                                if (arrmonth[i] == "") {
                                    var curyearval = curControlID.toString().replace("monthfield", "yearfield");
                                    var curmonthval = curControlID.toString().replace("yearfield", "monthfield");
                                    if (curControlID.toString().indexOf("field") != -1) {
                                        //Added By Usha Pandit On 19.05.2020 For validating skill month/years
                                        if ($("#" + curyearval).val() == "00" || $("#" + curyearval).val() == "000" || $("#" + curyearval).val() == "0000") {
                                            $("#" + curyearval).val("0");
                                        }
                                        if (arrmonth[i] == "00") {
                                            arrmonth[i] = "0";
                                        }
                                        //End Of Added By Usha Pandit On 19.05.2020 For validating skill month/years

                                        //Added By Usha pandit On 18.06.2020 For correct validation
                                        if (arrmonth[i] == "") {
                                            arrmonth[i] = "0";
                                        }
                                        if ($("#" + curyearval).val() == "") {
                                            $("#" + curyearval).val("0");
                                        }
                                        //End Of Added By Usha pandit On 18.06.2020 For correct validation

                                        if (arrmonth[i] == "" || $("#" + curyearval).val() == "") {
                                            checkvalidation = 1;
                                            alertify.set('notifier', 'position', 'top-right');
                                            if ($("#" + curyearval).val() == "") {
                                                alertify.error('Year can not be left blank');
                                            }
                                            //else if ($("#" + curyearval).val() == "0" && arrmonth[i] != "0") {
                                            else if ($("#" + curmonthval).val() == "" && $("#" + curyearval).val() == "") {
                                                if (IsDAFillornot == 0) {
                                                    alertify.error('Please enter Year or Month should not be left blank');
                                                   // $("#" + arrControlID[ControlID]).focus();
                                                } else {
                                                    checkvalidation = 0;
                                                }
                                            }
                                            else if ($("#" + curyearval).val() == "0" && $("#" + curmonthval).val() == "0") {
                                                if (IsDAFillornot == 0) {
                                                    alertify.error('Please enter Year greater than 0 or Month greater than 0');
                                                    $("#" + arrControlID[ControlID]).focus();
                                                } else {
                                                    checkvalidation = 0;
                                                }

                                            }
                                            else if (arrmonth[i] == "") {
                                                if ($("#" + curyearval).val() == "0") {
                                                    alertify.error('Month can not be left blank');
                                                }
                                                //Added By Usha pandit On 18.06.2020 For correct validation
                                                else {
                                                    checkvalidation = 0;
                                                }
                                                //End Of Added By Usha pandit On 18.06.2020 For correct validation
                                            }
                                            else if (arrmonth[i] == "0") {
                                                //Commented And Added By Usha pandit On 18.06.2020 For correct validation
                                                //alertify.error('Please enter Month greater than 0');
                                                //if ($("#" + curmonthval).val() == "0") {
                                                //    alertify.error('Please enter Month greater than 0');
                                                //}
                                                //else {
                                                    checkvalidation = 0;
                                                //}
                                                //End Of Added By Usha pandit On 18.06.2020 For correct validation
                                            }
                                            //Added By Dipali V On 25th May 2020 For month should be less than 12
                                            else if (arrmonth[i] >= "12") {
                                                alertify.error('Month should be less then 12 Months');
                                            }
                                            //Added By Dipali V On 25th May 2020 For month should be less than 12
                                            //Added By Usha pandit On 18.06.2020 For correct validation
                                            else {
                                                checkvalidation = 0;
                                            }
                                            //End Of Added By Usha pandit On 18.06.2020 For correct validation
                                            var ControlID = [i] * 2;
                                            if (arrmonth[i] == "0") {
                                                $("#" + arrControlID[ControlID]).focus();
                                            }
                                            if ($("#" + curyearval).val() == "0") {
                                                $("#" + curyearval).focus();
                                            }
                                            arrControlID = [];
                                            arrtoolID = [];
                                            arryear = [];
                                            arrmonth = [];
                                        }
                                    }
                                }
                                if (checkvalidation == 0) {
                                    if (arrmonth[i] == 0) {
                                        var curyearval = curControlID.toString().replace("monthfield", "yearfield");
                                         var curmonthval = curControlID.toString().replace("yearfield", "monthfield");
                                        if (curControlID.toString().indexOf("field") != -1) {
                                            //Added By Usha Pandit On 19.05.2020 For validating skill month/years
                                            if ($("#" + curyearval).val() == "00" || $("#" + curyearval).val() == "000" || $("#" + curyearval).val() == "0000") {
                                                $("#" + curyearval).val("0");
                                            }
                                            if (arrmonth[i] == "00") {
                                                arrmonth[i] = "0";
                                            }
                                            //End Of Added By Usha Pandit On 19.05.2020 For validating skill month/years
                                            //Added By Usha pandit On 18.06.2020 For correct validation
                                            if (arrmonth[i] == "") {
                                                arrmonth[i] = "0";
                                            }
                                            if ($("#" + curyearval).val() == "") {
                                                $("#" + curyearval).val("0");
                                            }
                                            //End Of Added By Usha pandit On 18.06.2020 For correct validation

                                            if (arrmonth[i] == 0 || $("#" + curyearval).val() == 0) {
                                                checkvalidation = 1;
                                                alertify.set('notifier', 'position', 'top-right');
                                                if ($("#" + curyearval).val() == "") {
                                                    alertify.error('Year can not be left blank');
                                                }
                                                else if ($("#" + curmonthval).val() == "" && $("#" + curyearval).val() == "") {
                                                    if (IsDAFillornot == 0) {
                                                        alertify.error('Please enter Year or Month should not be left blank');
                                                       // $("#" + arrControlID[ControlID]).focus();
                                                    } else {
                                                        checkvalidation = 0;
                                                    }
                                                }
                                               // else if ($("#" + curyearval).val() == "0" && arrmonth[i] == "0") {
                                                 else if ($("#" + curyearval).val() == "0" && $("#" + curmonthval).val() == "0") {
                                                if (IsDAFillornot == 0) {
                                                        alertify.error('Please enter Year greater than 0 or Month greater than 0');
                                                    } else {
                                                        checkvalidation = 0;
                                                    }                                                }
                                                else if (arrmonth[i] == "") {
                                                    if ($("#" + curyearval).val() == "0") {
                                                        alertify.error('Month can not be left blank');
                                                    }
                                                    //Added By Usha pandit On 18.06.2020 For correct validation
                                                    else {
                                                        checkvalidation = 0;
                                                    }
                                                    //End Of Added By Usha pandit On 18.06.2020 For correct validation
                                                }
                                                else if (arrmonth[i] == "0") {
                                                    //Commented And Added By Usha pandit On 18.06.2020 For correct validation
                                                    //alertify.error('Please enter Month greater than 0');
                                                    ////if ($("#" + curmonthval).val() == "0") {
                                                    //    alertify.error('Please enter Month greater than 0');
                                                    //}
                                                    //else {
                                                        checkvalidation = 0;
                                                    //}
                                                    //End Of Added By Usha pandit On 18.06.2020 For correct validation
                                                }
                                                //Added By Usha pandit On 18.06.2020 For correct validation
                                                else {
                                                    checkvalidation = 0;
                                                }
                                                //End Of Added By Usha pandit On 18.06.2020 For correct validation
                                                var ControlID = [i] * 2;
                                                // alert(ControlID);
                                                if (arrmonth[i] == "0") {
                                                    $("#" + arrControlID[ControlID]).focus();
                                                }
                                                if ($("#" + curyearval).val() == "0") {
                                                    $("#" + curyearval).focus();
                                                }
                                                arrControlID = [];
                                                arrtoolID = [];
                                                arryear = [];
                                                arrmonth = [];
                                            }
                                        }
                                    }
                                }
                            }
                            //End Of Added By Usha Pandit On 26.03.2020 For validation regarding non zero month/year validation
                        },


                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }

                    });
                }
                // }
            }

            if (checkvalidation == 1) {
                //checkvalidation = 1;
                return false;


            } else {
                // checkvalidation = 0;
                return true;

            }
        }




        function GetAllInfoAboutProject(ProjectId) {
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/GetAllInfoAboutProject',
                method: 'Post',
                data: JSON.stringify(encodeURI(ProjectId)),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                    }
                },
                success: function (result) {
                    vActualStartDate = result[0].StartDate;
                    vActualEndDate = result[0].EndDate;
                    SessionProjectName = result[0].ProjectName;

                    if (SessionProjectName != "") {
                        if (SessionProjectName.length > 40) {
                            var str = SessionProjectName.substring(0, 40);
                            $("#IdProjectName").text(str + "....");
                        }
                        else {
                            $("#IdProjectName").text(SessionProjectName);
                        }
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $("#IdProjectName").attr("data-original-title", "");
                        $("#IdProjectName").attr("data-original-title", SessionProjectName);
                        $("#IdProjectName").attr('data-bs-toggle', 'tooltip');
                        $("#IdProjectName").attr('data-bs-placement', 'bottom');

                    }
                    // CalculationOfTotalDays(vActualStartDate, vActualEndDate);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }


        var EmpData;
        function GetEmployeeToAllocateProject(ProjectId) {
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/GetEmployeeToAllocateProject',
                method: 'Post',
                data: JSON.stringify(encodeURI(ProjectId)),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                    }
                },
                success: function (result) {
                    //alert(result);
                    for (var i = 0; i < result.length; i++) {
                        ResourceIDArray.push(result[i].EmployeeID);
                    }
                    EmpData = result;
                    if (result.length == 0) {
                        $("#add_row,#saveskill").hide();
                    }
                    ResourceData(result);
                    if (result.length > 0) {
                        CurrentDays2 = result[0].CurrentDays;
                        TotalDays = result[0].TotalDays;
                        EmployeeID2 = result[0].EmployeeID;
                    }

                    //Getdata(result);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        var globalMaxMonthsOfExperience = "", globalmaxYearsOfExperience = "";
        function Get_PM_ProjectTools(ProjectID, EmployeeID, IsProjectOver) {
            var GetExperianceAttribute = {
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID),
                IsProjectOver: encodeURI(IsProjectOver),

            };

            if (EmployeeID != undefined) {
                $.ajax({
                    url: strUrl + '/api/PM_ProjectClosure/Get_PM_ProjectTools',
                    method: 'Post',
                    data: JSON.stringify(GetExperianceAttribute),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (GetExperianceAttribute) {
                            xhr.setRequestHeader("Params", encryptString(isJson(GetExperianceAttribute) ? GetExperianceAttribute : JSON.stringify(GetExperianceAttribute)));
                        }
                    },
                    success: function (data) {
                        //alert(data);
                        var strHTML = "";

                        $("#tblSkillsInfo").html("");
                        strHTML += '<tr>'
                        strHTML += '    <td class="tblsubheading"><strong>Skills</strong></td>'
                        strHTML += '    <td class="tblsubheading"><strong>Year(s)</strong></td>'
                        strHTML += '    <td class="tblsubheading"><strong>Month(s)</strong></td>'
                        strHTML += ' </tr>'

                        for (var i = 0; i < data.length; i++) {
                            //debugger;
                            var MonthsOfExperience, YearsOfExperience;
                            if (data[i].ToolID != null) {
                                IsNodata = 1;
                                ToolID3.push(data[i].ToolID)
                                SkillName2.push(data[i].Description);

                                // debugger;
                                if (data[i].NotDA != undefined) {
                                    NODA = data[i].NotDA;
                                    IsDAFillornot = data[i].NotDA;
                                } else {
                                    NODA = 0;
                                    IsDAFillornot = 0;
                                }
                                 //Added By Dipali V On 20th April 2021 for get Max Month Experience
                                if (globalMaxMonthsOfExperience != "") {
                                    if (data[i].MonthsOfExperience > globalMaxMonthsOfExperience) {
                                        globalMaxMonthsOfExperience = data[i].MonthsOfExperience;
                                    }
                                    else {
                                        globalMaxMonthsOfExperience = globalMaxMonthsOfExperience;

                                    }
                                } else {
                                    globalMaxMonthsOfExperience = data[i].MonthsOfExperience;
                                }

                                 //Endof Added By Dipali V On 20th April 2021 for get Max Month Experience

                                //Added By Dipali V On 20th April 2021 for get Max Year Experience
                                 if (globalmaxYearsOfExperience != "") {
                                    if (data[i].MonthsOfExperience > globalmaxYearsOfExperience) {
                                        globalmaxYearsOfExperience = data[i].YearsOfExperience;
                                    }
                                    else {
                                        globalmaxYearsOfExperience = globalmaxYearsOfExperience;

                                    }
                                } else {
                                    globalmaxYearsOfExperience = data[i].YearsOfExperience;
                                }
                                 //End of Added By Dipali V On 20th April 2021 for get Max Month Experience

                                //globalmaxYearsOfExperience = data[i].YearsOfExperience;

                                if (data[i].MonthsOfExperience == null || data[i].MonthsOfExperience == "") {
                                    MonthsOfExperience = "00";

                                } else {
                                    MonthsOfExperience = data[i].MonthsOfExperience;
                                }
                                if (data[i].YearsOfExperience == "" || data[i].YearsOfExperience == null) {
                                    YearsOfExperience = "00";

                                } else {
                                    YearsOfExperience = data[i].YearsOfExperience;
                                }


                                strHTML += '<tr>'
                                //debugger;
                                if (data[i].Description.length < 25) {
                                    strHTML += '<td id="Skills' + i + '" value="' + data[i].ToolID + '" class="clsmandatoryfields" ><span data-bs-toggle="tooltip"  data-bs-container="body" title="' + data[i].Description + '">' + data[i].Description + '</span></td>'
                                }
                                else {
                                    var str = data[i].Description.substring(0, 25);
                                    //strHTML += '<td data-bs-toggle="tooltip"  data-bs-container="body" title="' + data.Description + '"> ' + str + '....</td>'
                                    strHTML += '<td id="Skills' + i + '" value="' + data[i].ToolID + '" class="clsmandatoryfields" data-bs-toggle="tooltip"  data-bs-container="body" title="' + data[i].Description + '">' + str + '....</td>'
                                }
                                //  strHTML += '<td id="Skills' + i + '" value="' + data[i].ToolID + '" class="clsmandatoryfields" data-bs-toggle="tooltip"  data-bs-container="body" title="' + data[i].Description + '">' + data[i].Description + '</td>'
                                strHTML += '<input type="hidden" class="clsmandatoryfields" value="' + data[i].ToolID + '" id="SkillsName' + i + '"/>';
                                strHTML += '<td>'
                                strHTML += '<div class="">'
                                strHTML += '<input id="skillyear' + i + '" type="text" class="timenoinput inputYear clsMandatoryFields" name="' + data[i].ToolID + '" placeholder="0000" onchange="enableTxt(this)" Maxlength="4" value="' + YearsOfExperience + '" onkeypress="return restrictAlphabets(event, &quot;weekdays&quot;)">'
                                strHTML += '</div>'
                                strHTML += '</td>'
                                strHTML += '<td>'
                                strHTML += '<div class="">'
                                strHTML += '<input id="skillmonth' + i + '" type="text" class="timenoinput inputMonth clsMandatoryFields" name="' + data[i].ToolID + '" placeholder="00" onchange="enableTxt2(this)"  Maxlength="2" value="' + MonthsOfExperience + '" onkeypress="return restrictAlphabets(event, &quot;weekdays&quot;)">'
                                strHTML += '</div>'
                                strHTML += '</td>'
                                strHTML += '</tr >'
                            } else {
                                SelectedEmpMonth = data[i].MonthsOfExperience;
                                SelectedEmpYear = data[i].YearsOfExperience;
                                //Added By Dipali V On 16th April 2021 For Newly Create Project allow to fill DA
                                NODA = data[i].NotDA;
                                if (data[i].NotDA != undefined) {
                                    IsDAFillornot = data[i].NotDA;
                                }
                                else {
                                    IsDAFillornot = 0;
                                }
                                //End of Added By Dipali V On 16th April 2021 For Newly Create Project allow to fill DA
                            }
                        }

                        if (IsNodata == 0) {

                            strHTML += ' <tr><td colspan="3" style="text-align:center">No data available in table</td></tr>'
                        }
                        $("#tblSkillsInfo").html(strHTML);

                        //debugger;
                        if (ProjectOver == 1) {
                            $('#tblSkillsInfo .timenoinput').prop('disabled', true);

                        } else {
                            $('#tblSkillsInfo .timenoinput').prop('disabled', false);
                        }
                        //  alert(NODA);
                        //debugger;
                        if (NODA == 1) {
                            //$('#tblSkillsInfo .timenoinput').prop('disabled', true);
                            //$('#saveskill').prop('disabled', true);
                            //Commented By Nikhil A on 19-Apr-2021
                            //$('#add_row').prop('disabled', true);
                            //End of Commented By Nikhil A
                            $("#tblSkillsInfo tr td").attr("disabled", true);
                            $("#tblSkillsInfo tr td").css("cursor", "not-allowed");

                        } else {
                            $('#tblSkillsInfo .timenoinput').prop('disabled', false);
                            $('#saveskill').prop('disabled', false);
                            $('#add_row').prop('disabled', false);
                            $("#tblSkillsInfo tr td").attr("disabled", false);
                            $("#tblSkillsInfo tr td").css("cursor", "");
                        }


                    }
                });
            } else {
                // debugger;
                var strHTML = "";
                strHTML += '<tr>'
                strHTML += '    <td class="tblsubheading"><strong>Skills</strong></td>'
                strHTML += '    <td class="tblsubheading"><strong>Year(s)</strong></td>'
                strHTML += '    <td class="tblsubheading"><strong>Month(s)</strong></td>'
                strHTML += ' </tr>'
                strHTML += ' <tr><td colspan="3" style="text-align:center">No data available in table</td></tr>'

                $("#tblSkillsInfo").html(strHTML);


            }
        }



        function CheckProjectOver(ProjectID) {
            // alert(pid);

            var ExperianceAttribute = {
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID),

            };
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/CheckProjectOver',
                type: 'POST',
                data: JSON.stringify(ExperianceAttribute),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ExperianceAttribute) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                    }
                },
                success: function (result) {
                    //    alert(result);
                    ProjectOver = result;
                    if (ProjectOver == 1) {

                        $("#saveskill").prop("onclick", null).off("click");
                        // $("#saveskill").prop('disabled',true);
                        //$('#copylink').css('pointer-events', 'none');
                        $('#saveskill').attr('data-original-title', 'Selected Project was over,You can not take any action');
                        $("#saveskill").attr('data-bs-toggle', 'tooltip');
                        $("#saveskill").attr('data-bs-placement', 'bottom');
                        $("#btnAddLessonLearnt,.add,#lessonLeanrtdelete,#lessonLeanrtEdit,#saveskill,#btntaskclosersave,#btnSaveCheckList,#add_row").attr('disabled', true);//#btnAddLessonLearnt
                        $("#tblbdylessonlearttbl>tr>td>a.nostylebtn.edit").attr('disabled', true);
                        $("#add_row").attr("disabled", true);
                        $("#lessonLeanrtdelete,#lessonLeanrtEdit").css("display", "none");
                         $('#saveskill').prop('disabled', true);
                         $('#add_row').prop('disabled', true);

                    }
                    else if (ProjectOver == 0) {
                        $('#saveskill').removeAttr('data-original-title', '');
                        $("#lessonLeanrtdelete,#lessonLeanrtEdit").css("display", "inline");
                         $("#saveskill").attr('disabled', false);
                        $("#add_row").attr("disabled", false);
                        $(".add,#lessonLeanrtdelete,#lessonLeanrtEdit,#saveskill,#btnAddLessonLearnt,#btntaskclosersave,#btnSaveCheckList,#add_row").attr('disabled', false);
                        $("#tblbdylessonlearttbl>tr>td>a.nostylebtn.edit").attr('disabled', false);
                         $('#saveskill').prop('disabled', false);
                         $('#add_row').prop('disabled', false);

                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });
        }

        //End of Added by Dipali V On 18th Nov 2019

        // in that fun cal total experiance in day month year
        function TotalExpCal(CurrentDays, EmpID) {
            EmployeeID = EmpID;
            Userday = CurrentDays;
            TotalCurrentDay = Userday;
            TotalExpYr = (TotalCurrentDay / 365).toFixed(0);
            TotalExpDay = TotalCurrentDay % 365;
            if (TotalExpDay == 365) {
                Month = 12;
                Day = 0;
            }
            else if (TotalExpDay >= 334) {
                Month = 11;
                Day = TotalExpDay - 334;
            }
            else if (TotalExpDay >= 304) {
                Month = 10;
                Day = TotalExpDay - 304;
            }
            else if (TotalExpDay >= 273) {
                Month = 9;
                Day = TotalExpDay - 273;
            }
            else if (TotalExpDay >= 243) {
                Month = 8;
                Day = TotalExpDay - 243;
            }
            else if (TotalExpDay >= 181) {
                Month = 6;
                Day = TotalExpDay - 181;
            }
            else if (TotalExpDay >= 151) {
                Month = 5;
                Day = TotalExpDay - 151;
            }
            else if (TotalExpDay >= 120) {
                Month = 4;
                Day = TotalExpDay - 120;
            }
            else if (TotalExpDay >= 90) {
                Month = 3;
                Day = TotalExpDay - 90;
            }
            else if (TotalExpDay >= 59) {
                Month = 2;
                Day = TotalExpDay - 59;
            }
            else if (TotalExpDay >= 31) {
                Month = 1;
                Day = TotalExpDay - 31;
            }
            else {
                Month = 0;
                Day = TotalExpDay;
            }
            //Get_PM_ProjectTools(ProjectID,SelectedEmployeeID);
            Get_PM_UpdatedExpInfo1(ProjectID, EmployeeID)

            globalMaxMonthsOfExperience = "";
            globalmaxYearsOfExperience = "";
        }

        function Get_PM_MinDate(ProjectID) {
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/Get_PM_MinDate',
                method: 'Post',
                data: JSON.stringify(encodeURI(ProjectID)),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    //if (ProjectID) {
                    //    xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    //}
                },
                success: function (result) {
                    ProjectStartDate = result.StartDate;
                    m_intMonthsToBeShown = result.m_intMonthsToBeShown;
                    m_intYearsToBeShown = result.m_intYearsToBeShown;
                },
                error: function (err) {
                    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }


        function Get_PM_MaxDate(ProjectID) {
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/Get_PM_MaxDate',
                method: 'Post',
                data: JSON.stringify(encodeURI(ProjectID)),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    }
                },
                success: function (result) {
                    GetMaxDate = result[0].MaxDate;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }


        function CalculationOfTotalDays(vActualStartDate, vActualEndDate) {

            var date1 = new Date(vActualEndDate);
            var date2 = new Date(vActualStartDate);
            DayDifference = (date1 - date2) / (1000 * 60 * 60 * 24);
            //TotalExperiance(DayDifference);
            // alert(TotalDays);
            TotalExperiance(TotalDays);
        }

        $(".add-new").on('click', function () {

        });

        function TotalExpCal2(CurrentDays, EmpID,count) {
           

            $("#resourcenamelist li").removeClass('active');
            $("#resourcenamelist li a").removeClass('active');
            $("#liName" + count + "_" + EmpID +"").addClass('active');
           
            //Added By Usha Pandit On 18.06.2020 For enabling Next button navigating through resources
            $("#btnNextLessonLearnt").prop("disabled", false);
            //End Of Added By Usha Pandit On 18.06.2020 For enabling Next button navigating through resources

            StartLoader("#ProjectClosureBody");
            $("#liName0").css("background-color", "");
            $("#spnEmployeeName0").css("color", "");
            EmployeeID = EmpID;

            if (EmployeeID != "") {
                EmployeeID = EmployeeID;
            } else {
                EmployeeID = SelectedEmployeeID;
            }

            //debugger;
            ///alert(ProjectOver);

             globalmaxYearsOfExperience = "";
            globalMaxMonthsOfExperience = "";
            Get_PM_ProjectTools(ProjectID, EmployeeID, ProjectOver);
           // GetMonthYear
            // Get_PM_UpdatedExpInfo1(ProjectID, EmployeeID);
            //Commented and Added BY Nikhil A on 19-Apr-2021
            if (NODA == 1 || ProjectOver==1 ||NoResource ==1)
             {
               // $('#tblSkillsInfo .timenoinput').prop('disabled', true);
                $('#saveskill').prop('disabled', true);
                $('#add_row').prop('disabled', true);
                $("#tblSkillsInfo tr td").attr("disabled", true);
                $("#tblSkillsInfo tr td").css("cursor", "not-allowed");

            } else {
                $('#tblSkillsInfo .timenoinput').prop('disabled', false);
                $('#saveskill').prop('disabled', false);
                $('#add_row').prop('disabled', false);
                $("#tblSkillsInfo tr td").attr("disabled", false);
                $("#tblSkillsInfo tr td").css("cursor", "");
            }


            if (NODA == 1) {
                 $('#saveskill').prop('disabled', false);
                $('#add_row').prop('disabled', false);
            }
             //  debugger;
             //if (IsNodata == 0) {
             //       $('#saveskill').attr('disabled', true);
             //       //$("#add_row").attr("disabled", true);
             //   } else {
             //       $('#saveskill').attr('disabled', false);
             //      // $("#add_row").attr("disabled", false);
             //   }

            //Added by Chetan M. on 17th Dec 2019
                SkillChangeFlag = 0;
            //End of addition by Chetan M. on 17th Dec 2019
            $("#tbodytblAddNewSkill").html("");

            StopAjaxLoader("#ProjectClosureBody");
        }

        //function GetSkillsName(data) {
        //    SkillLength = data.length;
        //    var strHTML = "";
        //    $("#tblSkillsInfo").empty();

        //    strHTML += '<tr>'
        //    strHTML += '    <td class="tblsubheading"><strong>Skills</strong></td>'
        //    strHTML += '    <td class="tblsubheading"><strong>Year(s)</strong></td>'
        //    strHTML += '    <td class="tblsubheading"><strong>Month(s)</strong></td>'
        //    strHTML += ' </tr>'
        //    SkillName2.length = 0;
        //    ToolID3.length = 0;
        //    if (ResourceCounter > 0) {
        //        for (var i = 0; i < data.length; i++) {
        //            // alert(data.length);
        //            //SelectedEmpMonth = data[i].MonthsOfExperience;
        //           // SelectedEmpYear = data[i].YearsOfExperience;

        //            ToolID3.push(data[i].ToolID)
        //            SkillName2.push(data[i].Description);

        //            strHTML += '<tr>'
        //            strHTML += '<td id="Skills' + i + '" data-bs-toggle="tooltip"  data-bs-container="body" title="' + data[i].Description + '">' + data[i].Description + ' class=''</td>'

        //            strHTML += '<div class="">'
        //            strHTML += '<input id="skillyear1' + i + '" type="text" class="timenoinput inputYear" name="' + data[i].ToolID + '" placeholder="0000" onchange="enableTxt(this)" value="' + data[i].YearsOfExperience +'">'
        //            strHTML += '</div>'
        //            strHTML += '</td>'
        //            strHTML += '<td>'
        //            strHTML += '<div class="">'
        //            strHTML += '<input id="skillmonth1' + i + '" type="text" class="timenoinput inputMonth" name="' + data[i].ToolID + '" placeholder="00" onchange="enableTxt2(this)"  value="' + data[i].MonthsOfExperience +'">'
        //            strHTML += '</div>'
        //            strHTML += '</td>'
        //            strHTML += '</tr >'



        //        }
        //    }
        //    $("#tblSkillsInfo").html(strHTML);
        //}

        function PostPM_Skills(pSkillsName, LoggedPerson, pIsSkill) {
            var SkillAttribute = {
                Description: encodeURI(pSkillsName),
                loggedPerson: encodeURI(LoggedPerson),
                IsSkill: encodeURI(pIsSkill)
            };

            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/PostPM_Skills',
                method: 'Post',
                data: JSON.stringify(SkillAttribute),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (SkillAttribute) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SkillAttribute) ? SkillAttribute : JSON.stringify(SkillAttribute)));
                    }
                },
                success: function (result) {
                    Toolid2 = (result[0].ToolID);
                    Toolid = (result[0].ToolID).toString();
                    Toolid = Toolid + ',';
                    Toolid = "'" + Toolid + "'";
                    var GetMin = "'" + ProjectStartDate + "'";
                    var GetMax = "'" + GetMaxDate + "'";
                    //Allocate skill to project
                    PostPM_SkillsAllocateToProject(ProjectID, "''", "''", "''", "''", "''", "''", "''", "''", GetMin, GetMax, Toolid, "''");
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
            return Toolid2;
        }





        //function Get_PM_UpdatedExpInfo(ProjectID, EmployeeID) {
        //    var GetExperianceAttribute = { ProjectID: ProjectID, EmployeeID: EmployeeID };

        //    $.ajax({
        //        url: strUrl + '/api/PM_ProjectClosure/GetExperianceUpdated',
        //        method: 'Post',
        //        data: JSON.stringify(GetExperianceAttribute),
        //        dataType: 'json',
        //        async: false,
        //        contentType: "application/json",
        //        beforeSend: function (xhr) {
        //            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
        //        },
        //        success: function (result) {
        //            if (result.length == 0) {
        //                for (var k = 0; k < ToolID3.length; k++) {
        //                    if (TotalExpYr == 0) {
        //                        $("#skillyear1" + k).hide();
        //                    }
        //                    else {
        //                        $("#skillyear1" + k).val(TotalExpYr1);
        //                    }
        //                    if (Day > 0) {
        //                        $("#skillmonth1" + k).val(intEmployeeMonths + 1);
        //                    }
        //                    else {
        //                        $("#skillmonth1" + k).val(intEmployeeMonths);
        //                    }
        //                    //}
        //                }
        //            }
        //            else {
        //                var count1 = '';
        //                NoOfSkill = result.length;
        //                // GetSkills(result);
        //                DBToolIDArray.length = 0;
        //                for (var j = 0; j < result.length; j++) {
        //                    if (result[j].YearsOfExperience == 0) {
        //                        $("#skillyear1" + j).hide();
        //                    }
        //                    var YearExp = result[j].YearsOfExperience;
        //                    var MonthExp = result[j].MonthsOfExperience;
        //                    // var SkillsName = result[j].Description;
        //                    DBToolIDArray.push(result[j].ToolID);

        //                    //if (result[j].ToolID != ToolID3[j]) {
        //                    //    GlbToolID = ToolID3[j + 1];
        //                    //}

        //                    if (result[j].ToolID == ToolID3[j]) {
        //                        if (YearExp == 0) {
        //                            $("#skillyear1" + j).hide();
        //                        }
        //                        else {
        //                            $("#skillyear1" + j).val(YearExp);
        //                        }
        //                        $("#skillmonth1" + j).val(MonthExp);
        //                        count1++;
        //                    }
        //                    else {
        //                        //alert("Some Thing wrong");
        //                    }
        //                }
        //                for (var i = count1; i < ToolID3.length; i++) {
        //                    if (TotalExpYr1 == 0) {
        //                        $("#skillyear1" + i).hide();
        //                    }
        //                    else {
        //                        $("#skillyear1" + i).val(TotalExpYr1);
        //                    }
        //                    if (Day > 0) {
        //                        $("#skillmonth1" + i).val(intEmployeeMonths + 1);
        //                    }
        //                    else {
        //                        $("#skillmonth1" + i).val(intEmployeeMonths);
        //                    }
        //                }
        //            }
        //        },
        //        error: function (err) {
        //            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
        //        }
        //    });
        //}


        //function Get_PM_UpdatedExpInfo1(ProjectID, EmployeeID) {

        //    for (var i = 0; i < ToolID3.length; i++) {
        //        //for (var j = 0; j < EmpData.length; j++) {
        //        //    if (EmployeeID == EmpData[j].EmployeeID) {
        //        //        TotalExperiance(EmpData[j].TotalDays);
        //        //    }
        //        //}
        //        var GetExperianceAttribute = {
        //            ProjectID: encodeURI(ProjectID),
        //            EmployeeID: encodeURI(EmployeeID),
        //            ToolID: encodeURI(ToolID3[i])
        //        };
        //        $.ajax({
        //            url: strUrl + '/api/PM_ProjectClosure/GetEmployeeSkillMatrixDetails',
        //            method: 'Post',
        //            data: JSON.stringify(GetExperianceAttribute),
        //            dataType: 'json',
        //            async: false,
        //            contentType: "application/json",
        //            beforeSend: function (xhr) {
        //                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
        //            },
        //            success: function (result) {
        //                if (result.length == 0) {
        //                    for (var k = 0; k < ToolID3.length; k++) {
        //                        for (var j = 0; j < EmpData.length; j++) {
        //                            if (EmployeeID == EmpData[j].EmployeeID) {
        //                                TotalExperiance(EmpData[j].TotalDays);
        //                            }
        //                        }
        //                        if (intEmployeeDays > 0) {
        //                            intEmployeeMonths = intEmployeeMonths + 1;
        //                        }
        //                        if (intEmployeeMonths >= 12) {
        //                            intEmployeeYears = intEmployeeYears + 1;
        //                        }

        //                        if (TotalExpYr == "") {
        //                            TotalExpYr = 0;
        //                        }
        //                        if (intEmployeeMonths == "") {
        //                            intEmployeeMonths = 0;
        //                        }
        //                        if (m_intYearsToBeShown == 0) {
        //                            //$("#skillyear1" + i).hide();
        //                            $("#skillyear1" + i).val(m_intYearsToBeShown);
        //                        }
        //                        else {
        //                            $("#skillyear1" + i).val(TotalExpYr1);
        //                        }

        //                        for (var l = 0; l <= m_intMonthsToBeShown; l++) {
        //                            if (intEmployeeMonths == l) {
        //                                $("#skillmonth1" + i).val(l);
        //                                break;
        //                            }
        //                            else {
        //                                $("#skillmonth1" + i).val(0);
        //                            }
        //                        }
        //                        //if (Day > 0) {
        //                        //    $("#skillmonth1" + i).val(intEmployeeMonths);
        //                        //}
        //                        //else {
        //                        //    $("#skillmonth1" + i).val(intEmployeeMonths);
        //                        //}
        //                        //}
        //                    }
        //                }
        //                else {
        //                    var count1 = '';
        //                    DBToolIDArray.length = 0;
        //                    for (var j = 0; j < result.length; j++) {
        //                        if (m_intYearsToBeShown == 0) {
        //                            //$("#skillyear1" + j).hide();
        //                            $("#skillyear1" + i).val(m_intYearsToBeShown);
        //                        }
        //                        var YearExp = result[j].YearsOfExperience;
        //                        var MonthExp = result[j].MonthsOfExperience;
        //                        // var SkillsName = result[j].Description;
        //                        DBToolIDArray.push(result[j].ToolID);

        //                        if (m_intYearsToBeShown == 0) {
        //                            //$("#skillyear1" + i).hide();
        //                            $("#skillyear1" + i).val(m_intYearsToBeShown);
        //                        }
        //                        else {
        //                            $("#skillyear1" + i).val(YearExp);
        //                        }
        //                        for (var l = 0; l <= m_intMonthsToBeShown; l++) {
        //                            if (MonthExp == l) {
        //                                $("#skillmonth1" + i).val(l);
        //                                break;
        //                            }
        //                            else {
        //                                $("#skillmonth1" + i).val(0);
        //                            }
        //                        }
        //                        //$("#skillmonth1" + i).val(MonthExp);
        //                        count1++;
        //                    }
        //                }
        //            }
        //        })
        //    }
        //}


        var GblEmployeeExpYear = 0;
        var GblEmployeeExpMonth = 0;

        function Get_PM_UpdatedExpInfo1(ProjectID, EmployeeID) {

            // GetExperienceYearMonth(ProjectID, EmployeeID);

            for (var i = 0; i < ToolID3.length; i++) {
                //for (var j = 0; j < EmpData.length; j++) {
                //    if (EmployeeID == EmpData[j].EmployeeID) {
                //        TotalExperiance(EmpData[j].TotalDays);
                //    }
                //}
                var GetExperianceAttribute = {
                    ProjectID: encodeURI(ProjectID),
                    EmployeeID: encodeURI(EmployeeID),
                    ToolID: encodeURI(ToolID3[i])
                };
                $.ajax({
                    url: strUrl + '/api/PM_ProjectClosure/GetEmployeeSkillMatrixDetails',
                    method: 'Post',
                    data: JSON.stringify(GetExperianceAttribute),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (GetExperianceAttribute) {
                            xhr.setRequestHeader("Params", encryptString(isJson(GetExperianceAttribute) ? GetExperianceAttribute : JSON.stringify(GetExperianceAttribute)));
                        }
                    },
                    success: function (result) {
                        //for (var i = 0; i < ToolID3.length; i++) {
                        $("#skillyear1" + i).val(GblEmployeeExpYear);
                        $("#skillmonth1" + i).val(GblEmployeeExpMonth);
                        // }
                    }
                })
            }
        }


        function GetExperienceYearMonth(ProjectID, EmployeeID) {
            var ExperianceAttribute = {
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID)
            };

            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/GetExperienceYearMonth',
                method: 'Post',
                data: JSON.stringify(ExperianceAttribute),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ExperianceAttribute) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                    }
                },
                success: function (result) {
                    // alert(result.m_intYearsToBeShown);
                    //   alert(result.m_intMonthsToBeShown);
                    GblEmployeeExpYear = result.m_intYearsToBeShown;
                    GblEmployeeExpMonth = result.m_intMonthsToBeShown;

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function enableTxt(elem) {
            //Added by Chetan M. on 16th Dec 2019
            SkillUpdateFlag = 1;
            //End of addition by Chetan M. on 16th Dec 2019
            var id = $(elem).attr("id");
            if (id.indexOf("year") > -1) {
                var MonthID = id.replace("year", "month");
                UpdateMonth = $("#" + MonthID).val();
                if (UpdateMonth == "") {
                    UpdateMonth = 0;
                }
            }
            var ToolID = $(elem).attr("name");
            UpdateYear = $("#" + id).val();
            var TextboxID = "#" + id;
            var ToolIdAndYear = ToolID + ":" + UpdateYear + ":" + UpdateMonth + ":" + TextboxID;
            UpdateYearExpArray.push(ToolIdAndYear);
            counterforButton++;
            counter1++;
        }

        function enableTxt2(elem) {
             //Added by Chetan M. on 16th Dec 2019
            SkillUpdateFlag = 1;
            //End of addition by Chetan M. on 16th Dec 2019
            var id = $(elem).attr("id");
            if (id.indexOf("month") > -1) {
                var YearID = id.replace("month", "year");
                UpdateYear = $("#" + YearID).val();
                if (UpdateYear == "") {
                    UpdateYear = 0;
                }
            }
            var ToolID = $(elem).attr("name");
            UpdateMonth = $("#" + id).val();
            var TextboxID = "#" + id;
            var ToolIdAndMonth = ToolID + ":" + UpdateYear + ":" + UpdateMonth + ":" + TextboxID;
            UpdateMonthExpArray.push(ToolIdAndMonth);
            counterforButton++;
            counter1++;
        }

        function TotalExperiance(DayDifference) {
            TotalExpYr1 = (DayDifference / 365).toFixed(0);
            var intDays = DayDifference % 365;
            if (intDays == 365) {
                intEmployeeMonths = 12;
                intEmployeeDays = 0;
            }
            else if (intDays >= 334) {
                intEmployeeMonths = 11;
                intEmployeeDays = intDays - 334;
            }
            else if (intDays >= 304) {
                intEmployeeMonths = 10;
                intEmployeeDays = intDays - 304;
            }
            else if (intDays >= 273) {
                intEmployeeMonths = 9;
                intEmployeeDays = intDays - 273;
            }
            else if (intDays >= 243) {
                intEmployeeMonths = 8;
                intEmployeeDays = intDays - 243;
            }
            else if (intDays >= 181) {
                intEmployeeMonths = 6;
                intEmployeeDays = intDays - 181;
            }
            else if (intDays >= 151) {
                intEmployeeMonths = 5;
                intEmployeeDays = intDays - 151;
            }
            else if (intDays >= 120) {
                intEmployeeMonths = 4;
                intEmployeeDays = intDays - 120;
            }
            else if (intDays >= 90) {
                intEmployeeMonths = 3;
                intEmployeeDays = intDays - 90;
            }
            else if (intDays >= 59) {
                intEmployeeMonths = 2;
                intEmployeeDays = intDays - 59;
            }
            else if (intDays >= 31) {
                intEmployeeMonths = 1;
                intEmployeeDays = intDays - 31;
            }
            else {
                intEmployeeMonths = 0;
                intEmployeeDays = intDays;
            }
        }



        function PostPM_SkillsAllocateToProject(ProjectID, ParameterId, Version, PercentageUtilization, CustomerSupplied, Critical, Procured, BriefDescription, NumberOfCopies, PlannedInDate, PlannedOutDate, Toolid, CreateBy) {
            var SkillAllocateAttribute = {
                ProjectID: encodeURI(ProjectID),
                ParameterId: encodeURI(ParameterId),
                Version: encodeURI(Version),
                PercentageUtilization: encodeURI(PercentageUtilization),
                IsCustomerSupplied: encodeURI(CustomerSupplied),
                IsCritical: encodeURI(Critical),
                IsProcured: encodeURI(Procured),
                BriefDescription: encodeURI(BriefDescription),
                NumberOfCopies: encodeURI(NumberOfCopies),
                PlannedInDate: encodeURI(PlannedInDate),
                PlannedOutDate: encodeURI(PlannedOutDate),
                ToolIDS: encodeURI(Toolid),
                CreatedBy: encodeURI(CreateBy)
            };

            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/PostSkillsAllocateToProject',
                method: 'Post',
                data: JSON.stringify(SkillAllocateAttribute),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (SkillAllocateAttribute) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SkillAllocateAttribute) ? SkillAllocateAttribute : JSON.stringify(SkillAllocateAttribute)));
                    }
                },
                success: function (result) {
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        //Start script - Add,edit,delete row
        $('[data-bs-toggle="tooltip"]').tooltip();
        var LessonLearntIndex;
        // var actions = $("#lessonlearttbl td.actioncolumn").html();
        // Append table with add row form on add new button click
       // $(".add-new").click(function () {
            $(".add-new").on('click', function () {

            //Added By Usha Pandit On 14.04.2020 For save issue
            formdata = new FormData();
            //End Of Added By Usha Pandit On 14.04.2020 For save issue

            $(this).attr("disabled", "disabled");
            var index = $("#lessonlearttbl tbody tr:last-child").index();
            LessonLearntIndex = $("#lessonlearttbl tbody tr:last-child").index();

            var row = '<tr class="add_llrow" id="trIdAddLessonLearnt' + index + '">' +
                '<td class="text-start"><select id="cboType' + index + '" class="form-control"> <option value="0">Select Type</option></select><span style="color:red;">*</span></td>' +
                '<td class="text-start"><textarea rows="1" cols="50" class="form-control exandonfocus" name="problemdesc" id="problemdesc" autocomplete="OFF" Maxlength="1000" placeholder="Problem Description(Maxlength 1000 Char)"></textarea><span style="color:red;">*</span></td>' +
                '<td><textarea rows="1" cols="50" class="form-control exandonfocus" name="lesonsolution" id="lesonsolution" autocomplete="OFF" Maxlength="1500" placeholder="Solution(Maxlength 1500 Char)"></textarea><span style="color:red;">*</span></td>' +
                '<td><textarea rows="1" cols="50" class="form-control exandonfocus" name="preventiveaction" id="preventiveaction" autocomplete="OFF" Maxlength="1000" placeholder="Preventive Action(Maxlength 1000 Char)"></textarea><span style="color:red;">*</span></td>' +

                //modified by pradip on 13-12-2019
                '<td id="dataUploadDoc"><div class="rdname"><ul></ul></div></td>' +

                '<td class="tdSaveLessonLearnt">' +
                '<a class="nostylebtn attach" href="javascript:;" title="">' +
                '<label class="uploadBtnWrap" for="thefile">' +
                //'<input type="file" id="thefile"  onchange="alertFilename1()"  multiple>' +
                '<input type="file" id="thefile"  onchange="alertFilename1(this)"  multiple>' +   //Input File added by Ajit L on 21/11/2024
                '<span class="nostylebtn" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Upload Documents">' +
                '<img src="../../../Whizible2.0-new/dist/img/attachment.svg" width="16px"></span>' +
                '</label>' +
                '</a>&nbsp;&nbsp;' +
                '<a href = "javascript:;" onclick = "SaveLessonLearnt()"  title = "Save" data-bs-toggle="tooltip" data - container="body" > ' +
                '<img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>&nbsp;&nbsp;' +
                //Commented and Added By RehanC for Tooltip Issue on 23rd Mar 2023
                //'<div class="custom_chckbox inline"><input  type="checkbox" name="" class="nostylebtn check checkhead" id="checkPublish" ><label for="checkPublish" data-bs-toggle="tooltip" data-bs-placement="top"  data-bs-container="body" data-original-title="Publish to Knowledge"></label></div>&nbsp;&nbsp;' +
                '<div class="custom_chckbox inline"><input  type="checkbox" name="" class="nostylebtn check checkhead" id="checkPublish" ><label for="checkPublish" data-bs-toggle="tooltip" data-bs-placement="top"  data-bs-container="body" title="Publish to Knowledge"></label></div>&nbsp;&nbsp;' +
                //'<a class="nostylebtn delete clsRowDelete"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Remove Row"></i></a></td>' +
                '<a class="nostylebtn delete clsRowDelete"><i class="far fa-trash-alt" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Remove Row"></i></a></td>' +
                //End of Comment By RehanC for Tooltip Issue on 23rd Mar 2023
                '</tr>';
            $("#lessonlearttbl").append(row);

            $("#lessonlearttbl_wrapper .dataTables_paginate a").css({ "pointer-events": "none", "cursor": "not-allowed!important" });
            $("#lessonlearttbl_wrapper .dataTables_paginate a:hover").css({ "pointer-events": "none", "cursor": "not-allowed!important" });
            $("#lessonlearttbl_wrapper .dataTables_paginate").css("cursor", "not-allowed");
           //ADDED BY DIPALI V on 26th Dec 2019 For Focus Issues
            $("#cboType" + index).focus();
            //End of ADDED BY DIPALI V on 26th Dec 2019 For Focus Issues
            $("#lessonlearttbl_wrapper .dataTables_paginate a").mouseover(function () {
                $(this).css("cursor", "not-allowed");
            });
            $(".actioncolumn").css("cursor", "not-allowed");
            $(".actioncolumn a").css("pointer-events", "none");

              $(".actioncolumn").css("cursor", "no-drop");


            //Added by Chetan M. on 7th Dec 2019
            //  $("#dataUploadDoc").hide();
            $(".tdSaveLessonLearnt").css("text-align", "center");
            // $("#theadReferredDocument").attr('colspan', 2);
            $("#theadBlank").hide();
            //End of addded by Chetan M.
            $("#lessonlearttbl tbody tr").eq(index + 1).find(".add, .edit").toggle();
            GetLessonLeanProblemTypes('cboType' + index);
            $('[data-bs-toggle="tooltip"]').tooltip();
            var cnt = $("#tblbdylessonlearttbl > tr.odd > td.dataTables_empty").length;
            if (cnt > 0) {

               // alert();
                $(".tdSaveLessonLearnt").css("width", "10.5%");
            }
              editflag = true;

        });

        //Cancel row value
        $(document).on("click", "#lessonlearttbl .cancelrowvalue", function () {
            //add by omkar 9/12/2019
            var rowid = $(this).parents("tr").attr('id');
            var rowno = rowid.replace("r", '');
            //Added By Usha Pandit On 26.03.2020 For adding attachment during update
            var tdid = $('#r' + rowno + ' > td:nth-child(5)>div.rdname>ul');
            //Commented And Added By Usha Pandit On 23.04.2020 For removing new attachment on cancel, not saved one
            //if ($(tdid) != undefined && $(tdid) != null) {
            //    $(tdid).empty();
            //}
            $(tdid).find("li").each(function () {
                var curattach = $(this).find("button");
                if ($(curattach).hasClass("clscurrentattchfile")) {
                    $(this).addClass("clsTobeRemoved");
                }
            });
            $(tdid).find("li").each(function () {
                if ($(this).hasClass("clsTobeRemoved")) {
                    $(this).remove();
                }
            });
            //End Of Added By Usha Pandit On 23.04.2020 For removing new attachment on cancel, not saved one

            //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update
            var LessonsLearnedDetails = CopyLessonsLearnedData;
            var problemType = LessonsLearnedDetails[rowno]["ProblemType"];
            var Problemdescription = LessonsLearnedDetails[rowno]["ProblemDescription"];
            var PreventiveAction = LessonsLearnedDetails[rowno]["PreventiveAction"];
            var LessonId = LessonsLearnedDetails[rowno]["LessonId"];
            var Solution = LessonsLearnedDetails[rowno]["Solution"];
            var ReferedDocument = LessonsLearnedDetails[rowno]["ReferedDocument"];
            var PKTM = LessonsLearnedDetails[rowno]["PublishToKM"];
         <%If m_PM_ProjectClosureblnAddAccess = True Then%>
            $(".lessonlearttbl .add-new").removeAttr("disabled");

         <%End If%>

            var empty = false;
            var input = $(this).parents("tr").find('input[type="text"]');
            var select = $(this).parents("tr").find('select');
            var textarea = $(this).parents("tr").find('textarea');

            input.each(function () {
                $(this).parent("td").html($(this).html());
                $(this).parent("td").html();
            });
            //  select.each(function(){
            //   $(this).parent("td").html($(this).val());
            //});
            // textarea.each(function(){
            //   $(this).parent("td").html($(this).val());
            // });

            $("#" + rowid + "c0").html(problemType);
            $("#" + rowid + "c1").html(Problemdescription);
            $("#" + rowid + "c2").html(Solution);
            $("#" + rowid + "c3").html(PreventiveAction);
            //end

            $(this).parents("tr").find(".add, .edit").toggle();
            $(this).parents("tr").find(".delete, .cancelrowvalue").toggle();
            //Added By Usha Pandit On 26.03.2020 For adding attachment during update
            $(this).parents("tr").find(".clsAttachment").toggle();
            //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update
            $(this).parents("tr").find(".check").css("display", "none");
            //add by omkar 9/12/2019
            var rowid = $(this).parents("tr").attr('id');
            var chkbxid = "#" + rowid + " > td.actioncolumn > div>input";
            chkbxid = $(chkbxid).attr('id');
            // if (ArrLessonsLearnedPublishToKM.indexOf(rowid)!=-1) {
            if (PKTM == "1" || PKTM == true) {
                $("#" + rowid + " > td.actioncolumn > div>input#" + chkbxid).prop('checked', true);
            } else {
                $("#" + rowid + " > td.actioncolumn > div>input#" + chkbxid).prop('checked', false);
            }
            //end
            //add by omkar 6/12/2019
            editflag = false;

            //added by Dipali V On 16th Dec 2019
            //$(".actioncolumn").css("cursor", "auto");
            $(".actioncolumn a.delete,a.edit").removeAttr("disabled");
            //$(".actioncolumn a").css("cursor", "not-allowed");
            //$(".actioncolumn a.edit").css("cursor", "not-allowed");
            $(".actioncolumn a.delete, a.edit").css("cursor", "auto");
            // $(".actioncolumn a.edit").css("pointer-events", "none");
            $(".actioncolumn a.delete,a.edit").css("pointer-events", "auto");
            $("#lessonlearttbl_paginate").css("pointer-events", "auto");
            // $("#lessonlearttbl_paginate").css("cursor", "not-allowed");

           $(".actioncolumn").css("cursor", "pointer");

            $("#tblbdylessonlearttbl .dataTables_paginate").css("cursor", "auto");
            //$(".actioncolumn").css("cursor", "auto");
            $(".actioncolumn").removeAttr("cursor");
            $("#lessonlearttbl_paginate a").css("pointer-events", "auto");
            $("#lessonlearttbl_paginate a").css("cursor", "pointer");

            //end of added by Dipali V On 16th Dec 2019
             //add by omkar 17/12/2019
            EditLessonLearntId = "";
            EditRowNo = "";
            //added by omkar 26/3/2020 issue id 23457
            $("#" + rowid + "c4").attr("disabled", true);

            //Added By Usha Pandit On 23.04.2020 For showing ban-circle for disabled attachments
            var tcurdid = $('#' + rowid + ' > td:nth-child(5)>div.rdname>ul');

            $(tcurdid).find("li").each(function () {
                var curattach = $(this).find("button");

                if (!$(curattach).hasClass("clsCursorNotAllowed")) {
                    $(curattach).addClass("clsCursorNotAllowed");
                    $(curattach).attr("disabled", true);
                }
            });
            //End Of Added By Usha Pandit On 23.04.2020 For showing ban-circle for disabled attachments
            //end of add ed by omkar 26/3/2020 issue id 23457
        });
         //add by omkar 17/12/2019
        var EditLessonLearntId;
        var EditRowNo;

        $(document).on("click", "#lessonlearttbl .edit", function () {
            var cnt = 0;
            //added by Dipali V On 16th Dec 2019
            //debugger
            var controlid = this.id;
              //add by omkar 17/12/2019
           EditLessonLearntId = $("#" + controlid).attr("Value");
            var ID = controlid.split("_");
            var selectedid = ID[1];
            //add by omkar 17/12/2019
             EditRowNo=ID[1];
            disabled(selectedid);
            //end of added by Dipali V On 16th Dec 2019

            //add by omkar 6/12/2019
            //if (editflag == false) {
            editflag = true;
            //end
             var id = this.id;

                $(this).parents("tr").find("td:not(:last-child)").each(function () {

                    // alert(id1);
                    if (cnt == 2) {
                        //  debugger;
                        var solution = $(this).text();
                        // var ToolTip = $(this.id).attr("tooltip");
                        // alert(ToolTip);
                        //Commented And Added By Usha Pandit On 16.06.2020 For setting max legnth for lessons learnt fields
                        //$(this).html('<textarea  class="form-control">' + solution + '</textarea><span style="color:red;">*</span>');
                        $(this).html('<textarea  class="form-control" maxlength="1500">' + solution + '</textarea><span style="color:red;">*</span>');
                        //End Of Added By Usha Pandit On 16.06.2020 For setting max legnth for lessons learnt fields
                        cnt++;
                    }
                    else if (cnt == 3) {
                        //Commented And Added By Usha Pandit On 16.06.2020 For setting max legnth for lessons learnt fields
                        //$(this).html('<textarea class="form-control">' + $(this).text() + '</textarea><span style="color:red;">*</span>');
                        $(this).html('<textarea class="form-control" maxlength="1000">' + $(this).text() + '</textarea><span style="color:red;">*</span>');
                        //End Of Added By Usha Pandit On 16.06.2020 For setting max legnth for lessons learnt fields
                        cnt++;
                    }
                    else if (cnt == 1) {
                        //Commented And Added By Usha Pandit On 16.06.2020 For setting max legnth for lessons learnt fields
                        //$(this).html('<textarea class="form-control">' + $(this).text() + '</textarea><span style="color:red;">*</span>');
                        $(this).html('<textarea class="form-control" maxlength="1000">' + $(this).text() + '</textarea><span style="color:red;">*</span>');
                        //End Of Added By Usha Pandit On 16.06.2020 For setting max legnth for lessons learnt fields
                        cnt++;
                    }
                    else if (cnt == 5) {
                        $(this).html();
                        cnt++;
                    } else if (cnt == 0) {
                        var problemtype = $(this).text();
                        //add by omkar 6/12/2019
                        var id1 = $(this).parents("tr").attr('id');
                        //end
                        $(this).html('<select id="cbo' + cnt + '" class="form-control"> <option value="0">Select Type</option></select><span style="color:red;">*</span>');
                        GetLessonLeanProblemTypes1(id1, 'cbo' + cnt);
                        // $("#tblbdylessonlearttbl > tr#"+Rowid+" > td:nth-child(1)>select#" + cboId).html(selHTML);
                        //add by omkar 6/12/2019
                        $('#tblbdylessonlearttbl > tr#' + id1 + ' > td:nth-child(1)>select#cbo' + cnt).find("option[value='" + problemtype + "']").attr('selected', 'selected');
                        //end
                        cnt++;
                    }
                });
                $(this).parents("tr").find(".add, .edit").toggle();
                var alllessonleartPages = $("#lessonlearttbl").dataTable().fnGetNodes();
                //$(alllessonleartPages).find("a#lessonLeanrtEdit").toggle();
                $(this).parents("tr").find(".delete, .cancelrowvalue").toggle();
                $(".add-new").attr("disabled", "disabled");

                //$("#checkPublish").css("display", "inline");
                //add by omkar 6/12/2019
                var rowid = $(this).parents("tr").attr('id');
                //end
                //Added By Usha Pandit On 26.03.2020 For adding attachment during update
                deletedcurrentFileCnt = [];
		//Added By Usha Pandit On 14.04.2020 For save issue
            formdata = new FormData();
            //End Of Added By Usha Pandit On 14.04.2020 For save issue
                $(this).parents("tr").find(".clsAttachment").toggle();
                //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update

                $(this).parents("tr").find(".check").css("display", "inline-block");
                //add by omkar 9/12/2019 for issue 20562
                var lblid = "#" + rowid + " > td.actioncolumn > div > label";
                var chkbxid = "#" + rowid + " > td.actioncolumn > div>input";
                chkbxid = $(chkbxid).attr('id');
            //Added By Usha Pandit On 23.04.2020 For showing ban-circle for disabled attachments
            var tcurdid = $('#' + rowid + ' > td:nth-child(5)>div.rdname>ul');

            $(tcurdid).find("li").each(function () {

                var curattach = $(this).find("button");

                if ($(curattach).hasClass("clsCursorNotAllowed")) {
                    $(curattach).removeClass("clsCursorNotAllowed");
                    $(curattach).attr("disabled", false);
                }
            });
            //End Of Added By Usha Pandit On 23.04.2020 For showing ban-circle for disabled attachments
            // console.log(chkbxid); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                // $(lblid).attr("for",chkbxid);
                $(lblid).attr({
                    'for': chkbxid,

                });
                //end
                // CloneArray.push("1");
                // }

            // }
        });


        // Delete row on delete button click
        $(document).on("click", ".delete", function () {
            $(this).parents("tr").remove();
            $(".add-new").removeAttr("disabled");
            //Added by Chetan M. on 7th Dec 2019
            $("#theadReferredDocument").removeAttr('colspan', 2);
            $("#theadBlank").show();
            //End of addition by Chetan M.
        });

        // $(document).ready(function () {
        //Start script for previous steps
        //$('.prevtab').click(function () {
            $(".prevtab").on('click', function () {
             $(".popover").removeClass('show');
            $('.nav-tabs > .active').prev('li').find('a').trigger('click');
                $($.fn.dataTable.tables(true)).css('width', '100%'); $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();

                resizeSection();
        });//End script for previous steps


        //open table row
        //$('.toggler').click(function () {
            $(".toggler").on('click', function () {
            $(this).toggleClass('toggleropen');
            $(this).closest('tr').toggleClass('tropen');
        });

        //$('.removerow').click(function () {
        //    // $(this).closest('tr').hide();
        //});

       // $('.ratecarddropdown .dropdown-menu li span').click(function () {
        $('.ratecarddropdown .dropdown-menu li span').on('click', function () {
            $('#selected').text($(this).text());
        });

        //steps
        //Initialize tooltips
        $('.nav-tabs > li a[title]').tooltip();

        //Wizard
        $('.wizard a[data-bs-toggle="tab"]').on('show.bs.tab', function (e) {
            var $target = $(e.target);
            if ($target.parent().hasClass('disabled')) {
                return false;
            }
        });

        //$(".next-step").click(function (e) {
        $(".next-step").on('click', function () {
              $(".popover").removeClass('show');
            var $active = $('.wizard .wizard-inner .nav-tabs li a.active');
            $active.next().removeClass('disabled');
            nextTab($active);

            //$('.wizard .nav-tabs li.active').prev('li').addClass('Compltedstep');
            //refresh();

            GetProjectLessonsLearnedDetails(ProjectID);
            getProjectCloserDetails("all");
            $('.wizard .wizard-inner .nav-tabs li a.active').prev('li').addClass('Compltedstep');
        });

        var arrSkillnewControlID = new Array();
        var arrSkillYearnewControlID = new Array();
        var arrSkillMonthnewControlID = new Array();

        function FuncbtnNextLessonLearnt() {
            if ($("#saveskill").attr("disabled") == "disabled" || (SkillChangeFlag == 0 && SkillUpdateFlag == 0)) {
                //End of addition By Chetan M. on 16th Dec 2019.
              
                StartLoader("#ProjectClosureBody");
                var active = $('.wizard .wizard-inner .nav-tabs li a.active');
                var nextTab1 = active.parents('li').next('li');
                var prevTab1 = active.parents('li');
                nextTab1.removeClass('disabled');
                nextTab1.find('a').tab('show');
                prevTab1.addClass('Compltedstep');
                nextTab(prevTab1);
                GetProjectLessonsLearnedDetails(ProjectID);
                getProjectCloserDetails("all");
                
                StopAjaxLoader("#ProjectClosureBody");
            }
            else if (SkillChangeFlag == 1 || SkillUpdateFlag == 1) {
                $("#idSkillConformation").modal('show');
            }
            //End of addition By Chetan M. on 16th Dec 2019.

        }


        //$(document).on("click", "#btnNextLessonLearnt", function () {
             
        //});

        function MoveToLL() {
           // debugger
            //checkvalidation = 0;
            StartLoader("#ProjectClosureBody");
            if (IsSkillAdd == 1 && $("#saveskill").attr("disabled") != "disabled") {
                $("#saveskill").click();
            }
            //$( "#target" ).click();
            //debugger;
            //alert(checkvalidation);
            if (Validation() == true) {
                //Added By Chetan M. on 16th Dec 2019
                if (SkillUpdateFlag == 1) {
                    $('#saveskill').trigger('click');
                }
                SkillUpdateFlag = 0;
                SkillChangeFlag = 0;
                //End of addition By Chetan M. on 16th Dec 2019

                var $active = $('.wizard .wizard-inner .nav-tabs li a.active');
                $active.next().removeClass('disabled');
                nextTab($active);
                getProjectCloserDetails("all");
                // $("#step3 > div.container-fluid.bgwhite.ts_headerbot > div > div.col-md-4.col-sm-4.col-xs-5.float-end > ul > li > a").click(function () {
                // StartLoader("#ProjectClosureBody");
                GetProjectLessonsLearnedDetails(ProjectID);
                // StopAjaxLoader("#ProjectClosureBody");

                //});
            } else {
                checkvalidation = 0;
            }

            $('.wizard .wizard-inner .nav-tabs li a.active').prev('li').addClass('Compltedstep');

            StopAjaxLoader("#ProjectClosureBody");

            //Add by omkar 9/12/2019

        }
        function cancellessdocumentsdelete() {
        }
        function CancelToLL() {

            var $active = $('.wizard .wizard-inner .nav-tabs li a.active');
            //  $active.next().removeClass('disabled');
            prevTab($active);
            $('.wizard .wizard-inner .nav-tabs li a.active').prev('li').removeClass('Compltedstep');

            //$('.wizard .nav-tabs li.active').prev('li').addClass('Compltedstep');

        }


        //$("#btnNextProjectSummary").click(function () {
            $("#btnNextProjectSummary").on('click', function () {
            //alert(Nochecklist);
            //Commented and added by Chetan M on 13th Dec 2019 for show the confirmation modal popup
            if ($("#btnSaveCheckList").attr("disabled") == "disabled" || Nochecklist == 1)
            {
                StartLoader("#ProjectClosureBody");
                //var $active = $('.wizard .wizard-inner .nav-tabs li a.active');
                //$active.next().removeClass('disabled');
                //nextTab($active);
                var active = $('.wizard .wizard-inner .nav-tabs li a.active');
                var nextTab1 = active.parents('li').next('li');
                var prevTab1 = active.parents('li');
                nextTab1.removeClass('disabled');
                nextTab1.find('a').tab('show');
                prevTab1.addClass('Compltedstep');
                nextTab(prevTab1);


                // GetProjectLessonsLearnedDetails(ProjectID);
                // getProjectCloserDetails("assigned");
                GetProjectOverview(ProjectID);
                // alert(closeproject);
                if (closeproject == false) {
                    $("#btnsendmailprojectcolser").attr('disabled', true);

                }
                else if (closeproject == true) {
                    $("#btnsendmailprojectcolser").attr('disabled', false);
                }
                GetProjectTeamData(ProjectID);
                GetHardwareUsed(ProjectID);
                GetToolsUsed(ProjectID);
                //Added by Chetan M. on 17th Dec 2019
                GetReusableItems(ProjectID);
                //end of addition by Chetan M. on 17th Dec 2019
                GetLessonsLearned(ProjectID);
                GetEffortDistribution(ProjectID);
                GetProjectActualEndDate(ProjectID);
                $('#txtprojectactualenddate').datepicker({
                    autoclose: true,
                    changemonth: true,
                    dateformat: 'dd m yy'

                });

                $('.wizard .wizard-inner .nav-tabs li a.active').prev('li').addClass('Compltedstep');
                StopAjaxLoader("#ProjectClosureBody");

                //Add by omkar 9/12/2019



            } else {
                $("#ConformationChecklistNext").modal('show');
            }

            //    startloader("#projectclosurebody");
            //    getprojectoverview(ProjectID);
            //   // alert(closeproject);
            //    if (closeproject == false) {
            //        $("#btnsendmailprojectcolser").attr('disabled', true);

            //    }
            //    else if (closeproject == true) {
            //        $("#btnsendmailprojectcolser").attr('disabled', false);
            //    }
            //    GetProjectTeamData(ProjectID);
            //    GetHardwareUsed(ProjectID);
            //    GetToolsUsed(ProjectID);
            //    GetLessonsLearned(ProjectID);
            //    GetEffortDistribution(ProjectID);
            //    GetProjectActualEndDate(ProjectID);
            //      $('#txtprojectactualenddate').datepicker({
            //    autoclose: true,
            //    changemonth: true,
            //    dateformat: 'dd m yy'

            //});
            //    stopajaxloader("#projectclosurebody");

            //end of addition by Chetan M. on 13th Dec 2019.
        })


        //added by Chetan M on 13th Dec 2019
        function YesButtonChecklistPopupClick() {
            var flag = SaveCheckListResponse();
            if (flag == 0) {

                var $active = $('.wizard .wizard-inner .nav-tabs li a.active');
                $active.next().removeClass('disabled');
                nextTab($active);

                //$("#step3 > div.container-fluid.bgwhite.ts_headerbot > div > div.col-md-4.col-sm-4.col-xs-5.float-end > ul > li > a").click(function () {
                GetProjectOverview(ProjectID);
                // alert(closeproject);
                if (closeproject == false) {
                    $("#btnsendmailprojectcolser").attr('disabled', true);

                }
                else if (closeproject == true) {
                    $("#btnsendmailprojectcolser").attr('disabled', false);
                }
                GetProjectTeamData(ProjectID);
                GetHardwareUsed(ProjectID);
                GetToolsUsed(ProjectID);
                //added by Chetan M. on 17th Dec 2019
                GetReusableItems(ProjectID);
                //End of by Chetan M. addition on 17th Dec 2019
                GetLessonsLearned(ProjectID);
                GetEffortDistribution(ProjectID);
                GetProjectActualEndDate(ProjectID);
                $('#txtprojectactualenddate').datepicker({
                    autoclose: true,
                    changemonth: true,
                    dateformat: 'dd m yy'

                });

                $('.wizard .wizard-inner .nav-tabs li a.active').prev('li').addClass('Compltedstep');
                //});
            }
            else if (flag == 1) {
                $("#ConformationChecklistNext").modal('hide');
            }
            StopAjaxLoader("#ProjectClosureBody");
        }
        //end of addition by Chetan M. on 13th Dec 2019.


        //add by omkar 13/12/2019
        var formdata = new FormData();
        $("#btnNextTaskClosure").on('click', function () {
     
            if (editflag == false) {
                MoveToTC();
            } else {
                // add by omkar 17/12/2019
                if (EditRowNo.length != 0 && EditLessonLearntId.length != 0) {
                     EidtCheckValiationLessonLearnt(EditRowNo, EditLessonLearntId);

                }else if ($("#lessonlearttbl_wrapper > div > div > div > div.dataTables_scrollFoot > div > table > tfoot > tr > td>button.add-new").attr("disabled") == "disabled") {
                    //StartLoader("#ProjectClosureBody");
                    if (LessonLearntIndex >= 0) {
                        Flag = true;
                       // var formdata = new FormData();
                        var LoginType = '<%= Session("LoginType") %>';
                        var UserName = '<%= Session("strUserName") %>';
                        var UserID = '<%= Session("intUserID") %>';

                        var AttachedFileData = new Array();
                        var Files = new Array();
                        var d = new Date();
                        var ProblemType;
                        var Description;
                        var Solution;
                        var PreventiveAction;
                        var Flag = true;
                        $('#tblbdylessonlearttbl > tr.add_llrow').each(function (index, value) {
                            Flag = true;
                            var Description = "";
                            var File;
                            var Date = "";
                            var allColumns = $(this).find('td');

                            $(allColumns).each(function (i, v) {

                                if (i == 1) {
                                    Description = $(this).find('textarea').val();
                                    if ($.trim(Description).length == 0) {
                                        showAlert('Description should not be blank', 'alert-danger');
                                        $(this).find('textarea').focus();
                                        Flag = false;
                                        return false;
                                    }
                                }
                                if (i == 4) {
                                    var idpath = "#tblbdylessonlearttbl > tr.add_llrow > td > a.nostylebtn.attach > label.uploadBtnWrap>input#thefile";
                                    var ele = document.getElementById($(idpath).attr('id'));
                                    var tdid = $('#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(5)>ul');
                                    var rdname = $(idpath).closest('li').html('');
                                    var result = ele.files;
                                    if (result.length == 0) {
                                        //showAlert('Please attach the Reffered Document.', 'alert-danger');
                                        // Flag = false;
                                        // return false;
                                    }
                                    else {
                                        //Flag = ValidateAttachment('thefile', '#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(6)>a>label>input#thefile');
                                        //for (var x = 0; x < result.length; x++) {
                                        //    var gerfileName = result[x];
                                        //    formdata.append("file" + index, gerfileName);
                                        //}
                                    }
                                }
                                if (i == 0) {
                                    ProblemType = $("#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(1)>select> option:selected").text();

                                    var ProblemTypeval = $("#tblbdylessonlearttbl > tr.add_llrow  > td:nth-child(1)>select> option:selected").val();

                                    if (ProblemTypeval == 0) {
                                        showAlert('Please Select Problem Type ', 'alert-danger');
                                        $("#tblbdylessonlearttbl > tr.add_llrow  > td:nth-child(1)>select> option:selected").focus();
                                        Flag = false;
                                        return false;
                                    }

                                }
                                if (i == 2) {
                                    Solution = $(this).find('textarea').val();
                                    if ($.trim(Solution).length == 0) {
                                        showAlert('Solution should not be blank', 'alert-danger');
                                        $(this).find('textarea').focus();
                                        Flag = false;
                                        return false;
                                    }

                                }
                                if (i == 3) {
                                    PreventiveAction = $(this).find('textarea').val();
                                    if ($.trim(PreventiveAction).length == 0) {
                                        showAlert('Preventive Action should not be blank', 'alert-danger');
                                        $(this).find('textarea').focus();
                                        Flag = false;
                                        return false;
                                    }

                                }
                            });

                            //if (Flag == false) {
                            //    showAlert('Lessson learnt is not entered.', 'alert-danger');
                            //     $("#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(6) > a.nostylebtn.delete > i").parents("tr").remove();
                            //    $(".add-new").removeAttr("disabled");
                            //}
                        })
                        if (Flag == false) {
                            //showAlert('Lessson Learnt is not Completed.', 'alert-danger');
                            //$("#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(6) > a.nostylebtn.delete > i").parents("tr").remove();
                            // $(".add-new").removeAttr("disabled");

                        } else {
                            $("#ConformationLL").modal('show');
                        }
                    } else {
                        $("#ConformationLL").modal('show');
                    }
                    // CheckProjectOver(ProjectID);
                    //getProjectCloserDetails("all")
                    //StopAjaxLoader("#ProjectClosureBody");
                } else {
                    $("#ConformationLL").modal('show');
                }
            }
        });
        //end


        //Project Closure click
        $("#btncloseproject").on('click', function () {

            //  debugger;
            var TaskData = GetTaskDataOfProject(ProjectID);
            //alert(TaskData.TasksForCompletion.length);
            if (TaskData.TasksForCompletion.length != 0 || TaskData.TasksForVoiding.length != 0 || TaskData.TasksForMPPing.length != 0) {
                showAlert('Please Close all the tasks before closing the Project.', 'alert-danger');
            }
            else {
                //for (var i = 0; i < ResourceIDArray.length; i++) {
                //    for (var j = 0; j < ToolID3.length; j++) {
                //        // UpdateExperienceOfResourceOnClosureOfProject(ProjectID, ResourceIDArray[i], ToolID3[j], 0, 0, false);
                //    }
                //}
                var LoggedPersonEmailID = GetLoggedPersonInfo(LoggedPersonID);
                //debugger;
                if (CheckSkillHasOrNOt(ProjectID) == true) {

                    $("#DivCloseProjectDate").modal('show');
                    $("#txtProjectActualEnddate").val(SelectProjectActualEndate);
                    //return;

                }
            }

        });

        function SaveDate() {
            var checkval = 0;
            if ($("#txtProjectActualEnddate").val() == "") {
                showAlert('Project Actual End Date should not be blank', 'alert-danger');
                checkval = 1;
                return false;
            }
            if (checkval != 1) {
                if ($("#txtProjectActualEnddate").val() != "") {
                    //alert(actualEndate);
                    var currentdate = $("#txtProjectActualEnddate").val();
                    var actualEndate = SelectProjectActualEndate;
                    var TodaysDate = SelectedCurrentdate.toShortFormat();

                    //  if (Date.parse(actualEndate) > Date.parse(currentdate))
                    if (Date.parse(currentdate) < Date.parse(actualEndate)) {
                        showAlert('Project Actual End Date should not be less than ' + actualEndate, 'alert-danger');
                        checkval = 1;
                        //return false;
                    }
                    else if (Date.parse(currentdate) > Date.parse(TodaysDate)) {
                        showAlert('Project Actual End Date should not be greater than Todays date ' + TodaysDate, 'alert-danger');
                        checkval = 1;
                        //return false;
                    }

                }
                // return;
            }
            if (checkval == 0) {
                StartLoader("#ProjectClosureBody");
                var LoggedPersonEmailID = GetLoggedPersonInfo(LoggedPersonID);
                //return;
                CloseProject(ProjectID, LoggedPersonEmailID);
                $("#DivCloseProjectDate").modal("hide");
                StopAjaxLoader("#ProjectClosureBody");
            }
            else {


            }
        }



        function CheckSkillHasOrNOt(ProjectID) {
            var CheckHasSkill = "";
            var ExperianceAttribute = {
                ProjectID: encodeURI(ProjectID),

            };
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/CheckSkillHasOrNOt',
                type: 'POST',
                data: JSON.stringify(ExperianceAttribute),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ExperianceAttribute) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                    }
                },
                success: function (result) {
                    //debugger;
                    CheckHasSkill = result;
                    if (CheckHasSkill == 0) {

                        showAlert('Please Update skills against all resources of selected project', 'alert-danger')
                        CheckHasSkill = false;
                    }
                    else {

                        CheckHasSkill = true;
                    }

                }
            });

            return CheckHasSkill
        }



        $("#btnsendmailprojectcolser").on('click', function () {
            // debugger;
            //start by Vishal Mahajan 10-12-2019
            AddToAttachment('PDF');
            //end by Vishal Mahajan 10-12-2019
            //window.open("../Email/SendEmail.aspx?WhichFlag=CloseProject&MessageID=17&ProjectID=" + ProjectID + "&EmployeeID=" + LoggedPersonID + "&RoleID=" + LoggedPersonRoleID + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
        });
        //start by Vishal Mahajan 10-12-2019
        function AddToAttachment(ReportFormat) {
            ///debugger;
            var PMReportParameter = {
                ProjectId: encodeURI(ProjectID),
                ReportFormat: encodeURI(ReportFormat)
            }
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/ExportToReport',
                method: 'Post',
                data: JSON.stringify(PMReportParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMReportParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMReportParameter) ? PMReportParameter : JSON.stringify(PMReportParameter)));
                    }
                },
                success: function (result) {
                    if (result != "0") {
                        //  alert(result);
                        window.open("../Email/SendEmail.aspx?WhichFlag=CloseProject&MessageID=17&ProjectID=" + ProjectID + "&EmployeeID=" + LoggedPersonID + "&RoleID=" + LoggedPersonRoleID + "" + "&FileName=" + result + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        //end by Vishal Mahajan 10-12-2019

        $(".prev-step").click(function (e) {
            var $active = $('.wizard .wizard-inner .nav-tabs li a.active');
            prevTab($active);
            $('.wizard .wizard-inner .nav-tabs li a.active').prev('li').removeClass('Compltedstep');
            $($.fn.dataTable.tables(true)).css('width', '100%'); $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
        });

        // });

        function nextTab(elem) {
          
            //$(elem).next().find('a[data-bs-toggle="tab"]').click();
            //$(elem).next('li').find('a[data-bs-toggle="tab"]').click();
            var whichtab = $(elem).next('li').find('a').attr('href');
            $('.wizard>.tab-content>.tab-pane').removeClass('active');
            $('.wizard>.tab-content>.tab-pane').removeClass('show');
            $(whichtab).addClass('active');
            $(whichtab).addClass('show');
           
        }

        function prevTab(elem) {
            $(elem).prev().find('a[data-bs-toggle="tab"]').click();
            $($.fn.dataTable.tables(true)).css('width', '100%'); $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
        }

        $(".prevtab").on('click', function () {
          
            //$('.wizard .wizard-inner .nav-tabs li a.active').removeClass('Compltedstep');
            //var prev1 = $('.wizard .wizard-inner .nav-tabs li a.active');
            //prev1.prev('li').find('a').trigger("click");

            var active = $('.wizard .wizard-inner .nav-tabs li a.active');
            var prevTab1 = active.parents('li');
            var whichtab = $(prevTab1).prev('li').find('a').attr('href');
            $('.wizard>.tab-content>.tab-pane').removeClass('active');
            $('.wizard>.tab-content>.tab-pane').removeClass('show');
            $(whichtab).addClass('active');
            $(whichtab).addClass('show');
            $(".wizard .wizard-inner .nav-tabs li").removeClass('Compltedstep');
            $(".wizard .wizard-inner .nav-tabs li a").removeClass('active');
            prevTab1.addClass('Compltedstep');
            $(prevTab1).prev('li').find('a').addClass('active');

            $($.fn.dataTable.tables(true)).css('width', '100%'); $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
        });
        //steps_end

        //comment box textarea
        $(function () {
            $('.textarea').wysihtml5();
        }); //End script of comment box textarea

        //Start script - attached reffred document in Lesson learnt
         var FilesName = new Array();
        async function alertFilename1(file) {
            //$("#dataUploadDoc").show();
            //var idpath = "#tblbdylessonlearttbl > tr.add_llrow > td > a.nostylebtn.attach > label.uploadBtnWrap>input#thefile";
            //var ele = document.getElementById($(idpath).attr('id'));
            //var tdid = $('#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(5)>div.rdname>ul');
            //var rdname = $(idpath).closest('li').html('');
            //var result = ele.files;
            //FilesName.push(ele.files);



            ////for (var x = 0; x < result.length; x++) {
            // for (var x = 0; x < result.length; x++) {
            //    var fle = result[x];
            //    // var fle = FilesName[x];
            //    //$("#rdname ul").append("<li>" + fle.name + "(TYPE: " + fle.type + ", SIZE: " + fle.size + ")</li>");
            //     // $(tdid).append("<li><a cleass='filedownload' href='javascript:;' download>" + fle[x].name + "</a><button class='clsattchfile nostylebtn'>X</button></li>");
            //    $(tdid).append("<li><a cleass='filedownload' href='javascript:;' download>" + fle.name + "</a><button class='clsattchfile nostylebtn'>X</button></li>");
            //}  

            //Added by Ajit L on 21/11/2024
            try {
               
                if (!file) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please Select File");
                    return
                }
                var objFile = file;
                var fileName = objFile.files[0].name;
                var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();
                isValidTypeExeCheck = false;
                //Commented and Added by Aditya J. on 25-11-2024
                //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
                var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
                //End of comment Added by Aditya J. on 25-11-2024
                isValidTypeExeCheck = ValidExtsExe.includes(extension);
                if (isValidTypeExeCheck) {
                    const file = objFile.files[0];
                    //await checkFileForExe(file);
                    await validateDocFileForExe(file)
                        .then(() => {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("File is valid and ready to upload.");
                            //alert("File is valid and ready to upload.");
                        })
                        .catch(error => {
                            //Added by Ajit L on 21/11/2024
                            var fileInput = objFile;
                            var fileNameInput = $(fileInput).closest('td').find('[id^="thefile"]');
                            // Before clearing:
                            // console.log("Selected files before clearing:", fileInput.files); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            $(fileInput).val(""); // Clear the file input
                            fileNameInput.val(""); // Clear the file name text input
                            //End of Added by Ajit L on 21/11/2024
                            // console.log(error); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                            //alert("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                            isValidTypeExeCheck = false;
                            // console.log($(objFile).val); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            $(file).val("");
                            // console.log($(file).val); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            /*$(objFileName).attr("placeholder", "Upload File");*/
                            //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                            return;
                        });
                    if (!isValidTypeExeCheck) {
                        return;
                    }
                }
            }
            catch (ex) {
                //alert(ex.message);
            }
             //End of Added by Ajit L on 21/11/2024

            $("#dataUploadDoc").show();
            var idpath = "#tblbdylessonlearttbl > tr.add_llrow > td > a.nostylebtn.attach > label.uploadBtnWrap>input#thefile";
            var ele = document.getElementById($(idpath).attr('id'));
            var tdid = $('#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(5)>div.rdname>ul');
            var fileindex1 = $("#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(5)>div.rdname>ul>li").length;
            fileindex1 = fileindex1 + 1;
            var rdname = $(idpath).closest('li').html('');
            var result = ele.files;
            for (var x = 0; x < result.length; x++) {
                var fle = result[x];
                //$("#rdname ul").append("<li>" + fle.name + "(TYPE: " + fle.type + ", SIZE: " + fle.size + ")</li>");
                $(tdid).append("<li><a cleass='filedownload' href='javascript:;' download>" + fle.name + "</a><button class='clsattchfile nostylebtn' id=" + fileindex1 + ">X</button></li>");
                fileindex1++;
            }
            var fileindex = $("#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(5)>div.rdname>ul>li").length;
            Flag = ValidateAttachment('thefile', '#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(6)>a>label>input#thefile');
            for (var x = 0; x < result.length; x++) {
                var gerfileName = result[x];
                formdata.append("file" + fileindex, gerfileName);
            }
        }

        $('#tblbdylessonlearttbl > tr.add_llrow > td > a.nostylebtn.attach > label.uploadBtnWrap>input#thefile').change(function () {

            var ele = document.getElementById($(this).attr('id'));
            var tdid = $(this).closest('td');
            var rdname = $(this).closest('li').html('');
            var result = ele.files;
            for (var x = 0; x < result.length; x++) {
                var fle = result[x];
                //$("#rdname ul").append("<li>" + fle.name + "(TYPE: " + fle.type + ", SIZE: " + fle.size + ")</li>");
                $(tdid).append("<li><a class='filedownload' href='javascript:;' download>" + fle.name + "<button class='clsattchfile nostylebtn'>X</button></a></li>");
            }

        });
        $('.uploadBtnWrap input#thefile').change(function () {
            var ele = document.getElementById($(this).attr('id'));
            var rdname = $(this).closest('li').html('');
            var result = ele.files;
            for (var x = 0; x < result.length; x++) {
                var fle = result[x];
                //$("#rdname ul").append("<li>" + fle.name + "(TYPE: " + fle.type + ", SIZE: " + fle.size + ")</li>");
                $("#rdname_1 ul").append("<li><a class='filedownload' href='javascript:;' download>" + fle.name + "</a><button class='clsattchfile nostylebtn'>X</button></li>");
            }
        });

        $('.uploadBtnWrap input#thefile_2').change(function () {
            var ele = document.getElementById($(this).attr('id'));

            var rdname = $(this).closest('li').html('');
            var result = ele.files;
            for (var x = 0; x < result.length; x++) {
                var fle = result[x];
                $("#rdname_2 ul").append("<li><a class='filedownload' href='javascript:;' download>" + fle.name + "</a><button class='clsattchfile nostylebtn'>X</button></li>");
            }

        });

        $('.uploadBtnWrap input#thefile_3').change(function () {
            var ele = document.getElementById($(this).attr('id'));
            var rdname = $(this).closest('li').html('');
            var result = ele.files;
            for (var x = 0; x < result.length; x++) {
                var fle = result[x];
                $("#rdname_3 ul").append("<li><a class='filedownload' href='javascript:;' download>" + fle.name + "</a><button class='clsattchfile nostylebtn'>X</button></li>");
            }
        });

        //End script - attached reffred document in Lesson learnt

        //Start script - closed attached document(reffered document)
        //$(document).on('click', '.clsattchfile', function () {
        //    debugger;
        //   // $(this).closest('li').html('');
        //    var id = this.id;
        //    id = parseInt(id);
        //   // formdata.delete(id);
        //   $(this).closest('li').html('');

        //    formdata.forEach(function (val, key, fD) {
        //      var key1 = key.replace('file', "");
        //      // key = 'file' + id;
        //        debugger;
        //       //  here you can add filtering conditions
        //        for (i = 1; i <= key1; i++) {
        //            if (id == [i]) {
        //                key = "file" + [i];
        //                formdata.delete(key);
        //            }
        //        }
        //    });


        //}); //End script - closed attached document(reffered document)
         var deletedFileCnt = [];
        $(document).on('click', '.clsattchfile', function () {
            if (globalLessonID != "") {
                var id = this.id;
                id = parseInt(id);
                // formdata.delete(id);

               // $(this).closest('li').html('');

                deletedFileCnt.push(id);
            } else {
                 $(this).closest('li').html('');
            }



        }); //End script - closed attached document(reffered document)

        //Added By Usha Pandit On 26.03.2020 For adding attachment during update
        var deletedcurrentFileCnt = [];
        $(document).on('click', '.clscurrentattchfile', function () {

            if (editLessonID != "") {
                var id = this.name;
                id = parseInt(id);
                deletedcurrentFileCnt.push(id);

                $(this).closest('li').html('');
            }
        }); //End script - closed attached document(reffered document)
        //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update

        //omkar code start
        //project summary
        function GetProjectOverview(ProjectId) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectClosure/GetProjectViewData',
                method: 'Post',
                data: JSON.stringify(encodeURI(ProjectId)),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                    }
                },
                success: function (result) {
                    //var abcd = $("#tblbdylessonlearttbl").find("td:eq(5)");
                    //abcd.attr('disabled', true);
                    closeproject = result.CloseProject;
                    if (closeproject == true) {
                        $("#btncloseproject").hide();
                        $("#btnreopenprojectcolser").show();
                        //$("#tblbdylessonlearttbl .edit").attr('disabled', true);
                        $("#btnAddLessonLearnt,#btntaskclosersave,#btnSaveCheckList,#add_row").attr('disabled', true);//#btnAddLessonLearnt
                        $("#tblbdylessonlearttbl>tr>td>a.nostylebtn.edit").hide();
                    } else {
                        $("#btnreopenprojectcolser").hide();
                        if (m_PM_ProjectClosureblnAddAccess == "False") {
                            //$("#btncloseproject").show();
                            //Added By Usha Pandit On 18.06.2020 For hiding close project button if only view access is set
                            if (m_PM_ProjectClosureblnAddAccess == "False" && m_PM_ProjectClosureblnEditAccess == "False" && m_PM_ProjectClosureblnDeleteAccess == "False") {
                                $("#btncloseproject").hide();
                            }
                            //End Of Added By Usha Pandit On 18.06.2020 For hiding close project button if only view access is set
                            $("#saveskill,#btnAddLessonLearnt,#btnSaveCheckList,#add_row").attr('disabled', true);//#btntaskclosersave
                        }
                        else {
                            $("#btncloseproject").show();
                            $("#saveskill,#btnAddLessonLearnt,#btnSaveCheckList,#add_row").attr('disabled', false);//#btntaskclosersave
                        }
                    }
                    var Projectoverview = result.ProjectOverview;
                    spandatabind(Projectoverview);

                    var ProjectSize = result.ProjectSize;
                    spandatabind(ProjectSize);
                    var ProjectPlannedVsActual = result.ProjectPlannedVsActual;
                    tablBind("tblPlannedvsActual", "tblbodyPlannedvsActual", ["VALUE"], ProjectPlannedVsActual);
                    strHTML = "";
                    //ADDED & Commented by dipali V On 24th Dec 2019 Data binding issues
                    var SumOfWork = "";
                    var SumOfActualWork = "";
                  //  debugger
                    for (i = 0; i <= ProjectPlannedVsActual.length - 1; i++) {
                       // debugger;
                        SumOfActualWork = ProjectPlannedVsActual[i]["SUM ACTUAL EFFORTS"];

                        SumOfWork = ProjectPlannedVsActual[i]["SUM ESTIMATED EFFORTS"]

                    }

                    if (ProjectPlannedVsActual != "") {
                        // strHTML = "<tr role='row'><td width='156px'><span>&nbsp;&nbsp;  </span></td><td width='143px'><span>&nbsp;&nbsp;    </span></td><td width='145px'><span>&nbsp;&nbsp;    </span></td><td width='105px'><span>&nbsp;&nbsp;    </span></td><td width='183px'><span><b>Total</b>   </span></td><td width='126px'><span>" + result.SumOfWork + "</span></td><td width='207px'><span>" + result.SumOfActualWork + "</span></td></tr>";
                        if (SumOfWork!= "" || SumOfWork != null || SumOfActualWork != "" || SumOfActualWork != null) {
                            strHTML = "<tr role='row'><td colspan=5>Total</td><td style='width: 134px;'><span>" + SumOfWork + "</span></td><td width='196px'><span>" + SumOfActualWork + "</span></td></tr>";
                        }

                    }

                     //End of ADDED & Commented by dipali V On 24th Dec 2019 Data binding issues
                    $("#tempdata tbody").empty();
                    $("#tempdata tbody").html(strHTML);
                    //debugger;
                    var ProjectReviewStatistics = result.ProjectReviewStatistics;
                   // alert(ProjectReviewStatistics);
                    tablBind("tblStatisticsReview", "tbltblStatisticsReviewbody", ["VALUE ", "PROJECTPHASE"], ProjectReviewStatistics);
                    strHTML = "";
                    //ADDED & Commented by dipali V On 24th Dec 2019 Data binding issues
                    var SumOfDefects = ""
                    var SumOfReivew = "";
                     for (i = 0; i <= ProjectReviewStatistics.length - 1; i++) {
                       // debugger;
                        SumOfReivew = ProjectReviewStatistics[i]["SUMREVIEWEFFORT"];

                        SumOfDefects = ProjectReviewStatistics[i]["NOOFDEFECTS"]

                    }
                   //debugger

                    if (ProjectReviewStatistics != "") {
                        //strHTML = "<tr role='row'><td width='23%'><span><b>Total</b>  </span></td><td width='271px'><span>" + result.SumOfReivew + "   </span></td><td width='276px'><span>" + result.SumOfReviewEfforts + "</span></td><td width='277px'><span>" + result.SumOfDefects + "</span></td></tr>";
                        if (SumOfReivew != "" ||SumOfReivew  != null  ||SumOfDefects != "" || SumOfDefects != null) {
                            strHTML = "<tr role='row'><td width='23%'><span><b>Total</b>  </span></td><td width='287px'><span></span></td><td width='289px'><span>" + SumOfReivew + "</span></td><td width='279px'><span>" + SumOfDefects+ "</span></td></tr>";
                        }
                    }
                    //end of added & Commented by dipali V On 24th Dec 2019 Data binding issues
                    $("#cnttblStatisticsReview tbody").empty();
                    $("#cnttblStatisticsReview tbody").html(strHTML);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        function PaginationSum(PageID) {
            $("#" + PageID).dataTable().fnDestroy();

            $("#" + PageID).DataTable({
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": true,
                "responsive": true,
                "retrieve": true
            });
        }

        function spandatabind(jsondata) {
            //var data = jsondata;
            for (var i = 0; i < jsondata.length; i++) {
                var data = jsondata[i];
                $.each(data, function (key, value) {

                    var id = key;
                    id = id.replace(/\s/g, '');
                    id = "spn" + id;
                    if ($("#" + id).length) {
                        $("#" + id).text('');
                        if (value == "" || value == null) {
                            //value = "Not Specified";
                        }
                        //Commented and added by Chetan M. on 9th Dec 2019
                        // $("#" + id).text(value);
                        if (id == "spnWORK") {
                            if (value != null) {
                                $("#" + id).text(value);
                            }
                        }
                        else if (id == "spnEFFORTVARIANCE") {
                            if (value != null) {
                                $("#" + id).text(value);
                            }
                        }
                        else {
                            $("#" + id).text(value);
                        }
                        //End of addition by Chetan M. on 9th Dec 2019

                    }
                });
            }
        }

        function tablBind(tblid, tblbdyid, removecol, GridData) {
            var strHTML = "";
            $("#" + tblbdyid).empty();
            $("#" + tblbdyid).html(strHTML);
            var data = GridData;
            for (var i = 0; i < data.length; i++) {
                var tbldata = data[i];
                strHTML += "<tr>"
                $.each(tbldata, function (key, value) {
                    ///  debugger;
                    //added by dipali V on 24th Dec 2019 For Summary display issue
                    var set = 0;
                      //added by dipali V on 24th Dec 2019 For Summary display issue
                    if (removecol.indexOf(key) == -1) {
                        //if (value != null || value != "") {
                        //debugger;
                        if (tblbdyid == "tblbodyPlannedvsActual") {
                            //debugger;
                            if (key == "ESTIMATED EFFORTS") {
                                if (value != "") {
                                    value = value;
                                }
                            }

                            if (key == "ACTUAL EFFORTS") {
                                if (value != "") {
                                    value = value;
                                }
                            }
                             if (key == "SUM ESTIMATED EFFORTS") {

                                 set = 1;
                            }

                             if (key == "SUM ACTUAL EFFORTS") {

                                 set = 1;
                            }
                        }
                        else if (tblbdyid == "tbltblStatisticsReviewbody") {
                            // debugger;
                            if (key == "REVIEWEFFORT") {
                                if (value != "") {
                                    value = value;
                                }
                            }

                           if (key == "SUMREVIEWEFFORT") {

                                 set = 1;
                            }
                        }
                        if (value == "" || value == null)
                        {
                            //value = "00:00"
                        }
                          //added by dipali V on 24th Dec 2019 For Summary display issue
                        if (set != 1) {
                              //End of added by dipali V on 24th Dec 2019 For Summary display issue
                            strHTML += "<td>" + value + "</td>"
                        }
                        //}
                    }
                });
                strHTML += "</tr>"
            }
            $("#" + tblbdyid).html(strHTML);
            PaginationSum(tblid);
            var tblId = "#" + tblid;
            if (tblId == "#tblPlannedvsActual") {
                if (strHTML == "") {
                    Setcolspan(tblId, 7);
                }
                set = 0;
            }
            if (tblId == "#tblStatisticsReview") {
                if (strHTML == "") {
                    Setcolspan(tblId, 4);
                }
            }
        }


        var taskids = [];
        function getProjectCloserDetails(LocationType) {
            var projectcloser = {
                ProjectId: encodeURI(ProjectID),
                LocationType: encodeURI(LocationType)
            }
            $("#taskclosurtbl").dataTable().fnDestroy();
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectClosure/GetProjectCloserData',
                method: 'Post',
                data: JSON.stringify(projectcloser),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (projectcloser) {
                        xhr.setRequestHeader("Params", encryptString(isJson(projectcloser) ? projectcloser : JSON.stringify(projectcloser)));
                    }
                },
                success: function (result) {

                    //debugger;
                    spandatabind(result.ProjectClosureCount);
                    taskids = [];
                    // Added By Dipali V On 25th May 2026 - Purpose:-Clear prior selections when task grid is reloaded (filter/tab change).
                    arrTaskIds = [];
                    var ProjectClosureDetails = result.ProjectClosureDetails;
                    $("#taskclosurtblbdy").empty();
                    var strHTML = "";
                    if (ProjectClosureDetails.length == 0) {
                        $("#checkboxcloseall").removeAttr('checked');
                        $("#checkboxcloseall").attr('disabled', true);
                        $("#btntaskclosersave").attr('disabled', true);
                    }
                    else {
                         //$("#taskclosurtbl").dataTable().fnDestroy();
                        $("#btntaskclosersave").attr('disabled', false);
                        $("#checkboxcloseall").attr('disabled', false);
                        for (var i = 0; i < ProjectClosureDetails.length; i++) {
                            //alert(ProjectClosureDetails.length);
                            var ActualEndDate = ProjectClosureDetails[i]["Actual End Date"];
                            var ActualStartDate = ProjectClosureDetails[i]["Actual Start Date"];
                            var ActualPercentComplete = ProjectClosureDetails[i]["ActualPercentComplete"];
                            var ActualWork = ProjectClosureDetails[i]["ActualWork"];
                            var BaselineStartDate = ProjectClosureDetails[i]["Baseline Start Date"];
                            var BaselineEndDate = ProjectClosureDetails[i]["Baseline End Date"];
                            var BaselineWork = ProjectClosureDetails[i]["Baseline Work"];
                            var EmployeeName = ProjectClosureDetails[i]["EmployeeName"];
                            //var EndDate = ProjectClosureDetails[i]["End Date"];
                            var Planned = ProjectClosureDetails[i]["Planned"];
                            var EndDate = ProjectClosureDetails[i]["End Date"];
                            var StartDate = ProjectClosureDetails[i]["Start Date"];
                            var TaskID = ProjectClosureDetails[i]["TaskID"];
                            var TaskName = ProjectClosureDetails[i]["TaskName"];
                            //if (ActualPercentComplete == 0) {
                            //    ActualPercentComplete = "No";

                            //} else {

                            //    ActualPercentComplete = "Yes";
                            //}
                            if (EmployeeName != null) {
                                var str = EmployeeName;
                                var matches = str.match(/\b(\w)/g);
                                var acronym = matches.join('');
                                if (acronym.length == 1) {
                                    acronym = acronym + acronym;
                                }
                            } else {
                                EmployeeName = "";
                                var acronym = "";
                            }


                              if (StartDate == "") {

                                StartDate = "Not Specified";
                            } else {

                                StartDate = StartDate;
                            }


                            if (EndDate == "") {

                                EndDate = "Not Specified";
                            } else {

                                EndDate = EndDate;
                            }


                             if (BaselineStartDate == "") {

                                BaselineStartDate = "Not Specified";
                            } else {

                                BaselineStartDate = BaselineStartDate;
                            }


                            if (BaselineEndDate == "") {

                                BaselineEndDate = "Not Specified";
                            } else {

                                BaselineEndDate = BaselineEndDate;
                            }

                            if (ActualStartDate == "") {

                                ActualStartDate = "Not Specified";
                            } else {

                                ActualStartDate = ActualStartDate;
                            }


                            if (ActualEndDate == "") {

                                ActualEndDate = "Not Specified";
                            } else {

                                ActualEndDate = ActualEndDate;
                            }

                            //if (BaselineWork == "" || BaselineWork != null) {

                            //    BaselineWork = "00.00";
                            //} else {

                            //    BaselineWork = BaselineWork.toFixed(2);
                            //}

                            ////Commented and added by Chetan M. on 12th Dec 2019
                            //if (Planned == "" || Planned == 0) {
                            //    Planned = "00.00";
                            //} else {
                            //    Planned = Planned.toFixed(2);
                            //}
                            ////if (ActualWork == "" || ActualWork!=null) {

                            ////     ActualWork = "00.00";
                            //// } else {
                            //if (ActualWork == "" || ActualWork == 0) {
                            //    ActualWork = "00.00";
                            //} else {
                            //    //End of addtion by Chetan M. on 12th Dec 2019

                            //    ActualWork = ActualWork.toFixed(2);;
                            //}


                            if (ActualEndDate != "") {
                                strHTML += '<tr>'
                                strHTML += ' <td>'
                                strHTML += '<div class="tskclsrnametext"><span data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top">' + TaskName + '</span></div>'
                                strHTML += '</td>'
                                strHTML += ' <td><span data-bs-toggle="tooltip" data-bs-container="body" title="' + EmployeeName + '" class="usernameshort circle-bggreen usernamecirclesmall">' + acronym + '</span></td>'
                                strHTML += '<td>'
                                strHTML += '     <label>' + StartDate + '</label></td>'
                                strHTML += ' <td>'
                                strHTML += '     <label>' + EndDate + '</label></td>'
                                //strHTML += ' <td>'
                                //strHTML += '     <label>' + Planned + '</label></td>'
                                strHTML += ' <td>'
                                strHTML += '     <label>' + BaselineStartDate + '</label></td>'
                                strHTML += ' <td>'
                                strHTML += '     <label>' + BaselineEndDate + '</label></td>'
                                //strHTML += ' <td>'
                                //strHTML += '     <label>' + BaselineWork + '</label></td>'
                                //strHTML += ' <td>'
                                strHTML += '<td>'
                                strHTML += '     <label>' + ActualStartDate + '</label></td>'
                                strHTML += '<td>'
                                strHTML += '     <label>' + ActualEndDate + '</label></td>'

                                strHTML += ' <td>'
                                strHTML += '     <label>' + Planned + '</label></td>'

                                strHTML += ' <td>'
                                strHTML += '     <label id="plannedwork1">' + ActualWork + '</label></td>'
                                strHTML += ' <td>'
                                strHTML += '     <label id="actualwork1">' + ActualPercentComplete + '</label></td>'

                                strHTML += ' <td>'

                                if (ActualEndDate != "") {
                                    strHTML += '      <div class="custom_chckbox"  >'
                                    strHTML += '         <input type="checkbox" id="chk' + TaskID + '" class="chckHead closemodal" onchange = "chkbxclickevent(this.id)">'
                                    taskids.push(TaskID);
                                } else {
                                    strHTML += '      <div class="custom_chckbox"  style="opacity: 0.2; cursor:no-drop;">'
                                    strHTML += '         <input type="checkbox" id="chk' + TaskID + '" class="chckHead closemodal" disabled>'
                                }
                                strHTML += '         <label for="chk' + TaskID + '"></label>'
                                strHTML += '     </div>'
                                strHTML += ' </td>'
                                strHTML += '</tr>'
                            }
                        }
                    }

                    $("#taskclosurtblbdy").html(strHTML);
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    $("#taskclosurtbl").DataTable({
                        "sScrollY": ($(window).height() - 300),
                        "scrollX": true,
                        // "scrollXInner": true,
                        "scrollResize": true,
                        "scrollCollapse": true,
                        "pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": true,
                        "responsive": true,
                        "retrieve": true,
                        'columnDefs': [{
                            'targets': [4, 5, 6, 7, 8, 9, 10, 11], // column index (start from 0)
                            'orderable': false, // set orderable false for selected columns
                        }],
                        // "aoColumnDefs": [{'bSortable': false, 'aTargets': [ -1 ]}]

                    });







                    $('#taskclosurtbl').DataTable().draw();
                    // Added By Dipali V On 25th May 2026 - Purpose:-Keep row/header checkboxes in sync when user changes DataTable page.
                    $('#taskclosurtbl').off('draw.dt.taskClosePageSelect').on('draw.dt.taskClosePageSelect', function () {
                        syncTaskCloseCurrentPageCheckboxesFromSelection();
                    });
                    $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {

                        //$($.fn.dataTable.tables(true)).DataTable()
                        //    .columns.adjust();
                        //$('#taskclosurtbl').DataTable().fnAdjustColumnSizing();
                       // $('#taskclosurtbl').DataTable().draw();

                    });

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        var Type = "";
        function staticfilter(lnkid) {
            // debugger;
            var id = lnkid.replace("lnk", "");
            Type = id;
            getProjectCloserDetails(id);
            //Modified by pradip on 13-12-2019
            //$("#step3 > div.container-fluid.bgwhite.ts_headerbot > div > div.col-md-8.col-sm-8.col-xs-7 > ul >li.active").removeClass(" active");
            var classprop = $("#li" + id).attr("class");
            $(".statustext li").removeClass("active");
            $("#li" + id).attr("class", classprop + " active");
        }



        var arrTaskIds = [];
        var GetCheckCount = 0;

        // Added By Dipali V On 25th May 2026 - Purpose:-Header "Close All / Void" checkbox selects only the current DataTable page (pageLength 10), not all tasks across pagination.
        function getTaskCloseAllHeaderCheckbox() {
            return $("#taskclosurtbl_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr>th#closeall>div #checkboxcloseall");
        }

        // Added By Dipali V On 25th May 2026 - Purpose:-Return enabled task IDs on the current page only (used for page-wise select-all).
        function getTaskCloseCurrentPageTaskIds() {
            var pageTaskIds = [];
            var table = $('#taskclosurtbl').DataTable();
            if (!table || !table.rows) {
                return pageTaskIds;
            }
            table.rows({ page: 'current' }).every(function () {
                var $chk = $(this.node()).find("input[type='checkbox'].closemodal").not(":disabled");
                if ($chk.length) {
                    pageTaskIds.push(parseInt($chk.attr('id').replace("chk", ""), 10));
                }
            });
            return pageTaskIds;
        }

        // Added By Dipali V On 25th May 2026 - Purpose:-True when every selectable task on the current page is in arrTaskIds (sync header checkbox).
        function areAllCurrentPageTaskCloseCheckboxesSelected() {
            var pageTaskIds = getTaskCloseCurrentPageTaskIds();
            if (pageTaskIds.length === 0) {
                return false;
            }
            for (var i = 0; i < pageTaskIds.length; i++) {
                if (arrTaskIds.indexOf(pageTaskIds[i]) === -1) {
                    return false;
                }
            }
            return true;
        }

        // Added By Dipali V On 25th May 2026 - Purpose:-After page change/sort, reflect arrTaskIds on visible row checkboxes and update header state.
        function syncTaskCloseCurrentPageCheckboxesFromSelection() {
            var table = $('#taskclosurtbl').DataTable();
            if (!table || !table.rows) {
                return;
            }
            table.rows({ page: 'current' }).every(function () {
                var $chk = $(this.node()).find("input[type='checkbox'].closemodal").not(":disabled");
                if ($chk.length) {
                    var taskid = parseInt($chk.attr('id').replace("chk", ""), 10);
                    $chk.prop('checked', arrTaskIds.indexOf(taskid) !== -1);
                }
            });
            getTaskCloseAllHeaderCheckbox().prop('checked', areAllCurrentPageTaskCloseCheckboxesSelected());
        }

        function chkbxclickevent(chkbxid) {
            var taskid = chkbxid.replace("chk", "");
            taskid = parseInt(taskid);

            var value = $("#" + chkbxid).is(':checked');
            if (value == true) {
                if (arrTaskIds.indexOf(taskid) == -1) {
                    arrTaskIds.push(taskid);
                }

                // Added By Dipali V On 25th May 2026 - Purpose:-Check header only when all tasks on the current page are selected (not entire grid).
                if (areAllCurrentPageTaskCloseCheckboxesSelected()) {
                    getTaskCloseAllHeaderCheckbox().prop('checked', true);
                }
            } else {
                taskid = parseInt(taskid);
                if (arrTaskIds.indexOf(taskid) != -1) {

                    arrTaskIds = jQuery.grep(arrTaskIds, function (value) {
                        return value != taskid;
                    });
                    if (getTaskCloseAllHeaderCheckbox().is(':checked')) {
                        getTaskCloseAllHeaderCheckbox().prop('checked', false);
                    }
                }
            }
        }

        var Fromsave = 0;
        function btntaskclosersaveclick() {
            if (arrTaskIds.length == 0) {
                showAlert('Please  Select  At least One Task', 'alert-danger')
            }
            else {
                  Fromsave = 1;
                //Added By Dipali V On 20nd Nov 2019 For Conformation For Void all Task
                if ($("#closeall > div.custom_chckbox #checkboxcloseall").is(':checked') == true) {
                    if ((arrTaskIds.length) >= $("#taskclosurtbl").find("input[type='checkbox']:checked").length) {
                        //debugger;
                        //Fromsave = 1;
                        $("#CloseAllTask").text("");
                        $("#CloseAllTask").text("You have selected multiple tasks for closure. Do you wish to close/Void all selected task(s)");
                        $("#closeAllTaskmodal").modal('show');

                    }
                    //End of Added By Dipali V On 20nd Nov 2019 For Conformation For Void all Task
                } else {

                    ProjectTaskCloseOrVoid(arrTaskIds);
                    var value1 = $("#taskclosurtbl_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr>th#closeall>div #checkboxcloseall").is(':checked');
                    if (value1 == true) {
                        $("#taskclosurtbl_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr>th#closeall>div #checkboxcloseall").prop('checked', false);
                    }
                }


            }
        }

        function btntaskclosernextclick() {
          
            StartLoader("#ProjectClosureBody");
            Fromsave = 0;
            //debugger;
            //Added By Dipali V On 20nd Nov 2019 For Conformation For Void all Task
            if ($("#closeall > div.custom_chckbox #checkboxcloseall").is(':checked') == true) {
                if ((arrTaskIds.length) >= $("#taskclosurtbl").find("input[type='checkbox']:checked").length) {
                    $("#CloseAllTask").text("");
                    $("#CloseAllTask").text("You have selected multiple tasks for closure.but you do not have take any action of close/Void task.Do you wish to close all selected task(s)");
                    $("#closeAllTaskmodal").modal('show');
                }
                //End of Added By Dipali V On 20nd Nov 2019 For Conformation For Void all Task
            } else {
                if (arrTaskIds.length == 0) {
                    nexttaskclosertab();
                } else {
                    $("#closemodal").modal("show");
                }
            }
            StopAjaxLoader("#ProjectClosureBody");
        }

        function cancelTask(Flag) {
            var allPages = $("#taskclosurtbl").dataTable().fnGetNodes();
            $(allPages).find("input[type='checkbox']").not(":disabled").prop('checked', false);

            arrTaskIds = [];
            var value1 = $("#taskclosurtbl_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr>th#closeall>div #checkboxcloseall").is(':checked');

            if (value1 == true) {

                $("#taskclosurtbl_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr>th#closeall>div #checkboxcloseall").prop('checked', false);

            }
            //debugger;
            //Added By Dipali V On 20nd Nov 2019 For Conformation For Void all Task
            if (Flag == 'Cancel') {
                if (arrTaskIds.length == 0) {
                    nexttaskclosertab();
                }
            } else if (Flag == 'No')
            {
                if ($("#CloseAllTask").text().indexOf("close/Void") > -1)
                {
                    if (arrTaskIds.length == 0)
                    {
                        if (Fromsave != 1)
                        {
                            nexttaskclosertab();
                            Flag = "";

                        }

                    }

                }

            }
            //End of Added By Dipali V On 20nd Nov 2019 For Conformation For Void all Task
        }



        // Added By Dipali V On 20th May 2026 - Purpose:-Save stays on task tab with loader until all batches finish; Next navigates only after close/void completes.
        function CloseTask() {
            var navigateAfterComplete = (Fromsave != 1);
            ProjectTaskCloseOrVoid(arrTaskIds, function () {
                $("#closeAllTaskmodal").modal("hide");
                $("#closemodal").modal("hide");
                if (navigateAfterComplete) {
                    nexttaskclosertab();
                }
            });
        }
        /* Commented By Dipali V On 20th May 2026 - Purpose:-Previous code navigated to next tab immediately while API was still running (mixed task list / delayed alert).
        function CloseTask() {
            ProjectTaskCloseOrVoid(arrTaskIds);
            nexttaskclosertab();
            arrTaskIds = [];
        }
        */

        function nexttaskclosertab() {
            //var $active = $('.wizard .wizard-inner .nav-tabs li a.active');
            //$active.next().removeClass('disabled');
            //nextTab($active);
            //$('.wizard .wizard-inner .nav-tabs li a.active').prev('li').addClass('Compltedstep');
            var active = $('.wizard .wizard-inner .nav-tabs li a.active');
            var nextTab1 = active.parents('li').next('li');
            var prevTab1 = active.parents('li');
            nextTab1.removeClass('disabled');
            nextTab1.find('a').tab('show');
            prevTab1.addClass('Compltedstep');
            nextTab(prevTab1);


        }

        // Added By Dipali V On 20th May 2026 - Purpose:-Delegate to batch close/void; arrTaskIds cleared after all batches complete in runProjectTaskCloseOrVoidBatches.
        function closeandvoidtask() {
            ProjectTaskCloseOrVoid(arrTaskIds);
        }
        /* Commented By Dipali V On 20th May 2026 - Purpose:-Previous code cleared selection before async close/void finished.
        function closeandvoidtask() {
            ProjectTaskCloseOrVoid(arrTaskIds);
            arrTaskIds = [];
        }
        */

        // Modified By Dipali V On 25th May 2026 - Purpose:-Header checkbox selects/deselects only tasks on the current DataTable page (avoids selecting 2000 tasks and slow Save).
        function checkAllCheckBox() {
            var table = $('#taskclosurtbl').DataTable();
            var value = $("#closeall > div.custom_chckbox #checkboxcloseall").is(':checked');
            var currentPageNodes = table.rows({ page: 'current' }).nodes();
            var $pageCheckboxes = $(currentPageNodes).find("input[type='checkbox'].closemodal").not(":disabled");

            if (value == true) {
                $pageCheckboxes.each(function () {
                    var taskid = parseInt(this.id.replace("chk", ""), 10);
                    if (arrTaskIds.indexOf(taskid) == -1) {
                        arrTaskIds.push(taskid);
                    }
                    $(this).prop('checked', true);
                });
            } else {
                $pageCheckboxes.each(function () {
                    var taskid = parseInt(this.id.replace("chk", ""), 10);
                    arrTaskIds = jQuery.grep(arrTaskIds, function (id) {
                        return id != taskid;
                    });
                    $(this).prop('checked', false);
                });
            }
        }

        // Added By Dipali V On 20th May 2026 - Purpose:-Batch close/void in chunks of 200; loader + disable Save/Next until all batches complete.
        // Added By Dipali V On 20th May 2026 - Purpose:-One API/SP call with all selected TaskIds (0 = no chunking). Set e.g. 500 only if IIS timeout on 2000+ tasks.
        var TASK_CLOSE_VOID_BATCH_SIZE = 0;
        var __taskCloseVoidInProgress = false;

        // Added By Dipali V On 20th May 2026 - Purpose:-Show loader on #ProjectClosureBody and disable Save/Next while task close/void is in progress.
        function setProjectTaskCloseVoidBusy(isBusy) {
            __taskCloseVoidInProgress = !!isBusy;
            $("#btntaskclosersave, #btntaskclosernext").prop("disabled", __taskCloseVoidInProgress);
            if (__taskCloseVoidInProgress) {
                StartLoader("#ProjectClosureBody");
            } else {
                StopAjaxLoader("#ProjectClosureBody");
            }
        }

        // Added By Dipali V On 20th May 2026 - Purpose:-Build unique numeric task ID list for batch close/void API.
        function normalizeProjectClosureTaskIds(taskIds) {
            var ids = [];
            var seen = {};
            if (!taskIds || !taskIds.length) {
                return ids;
            }
            for (var i = 0; i < taskIds.length; i++) {
                var tid = parseInt(taskIds[i], 10);
                if (!isNaN(tid) && tid > 0 && !seen[tid]) {
                    seen[tid] = true;
                    ids.push(tid);
                }
            }
            return ids;
        }

        // Added By Dipali V On 20th May 2026 - Purpose:-Split task IDs only when TASK_CLOSE_VOID_BATCH_SIZE > 0; otherwise one chunk = all IDs in one SP call.
        function chunkProjectClosureTaskIds(taskIds, size) {
            var chunks = [];
            if (!taskIds || !taskIds.length) {
                return chunks;
            }
            var batchSize = parseInt(size, 10);
            if (isNaN(batchSize) || batchSize <= 0 || taskIds.length <= batchSize) {
                chunks.push(taskIds);
                return chunks;
            }
            for (var i = 0; i < taskIds.length; i += batchSize) {
                chunks.push(taskIds.slice(i, i + batchSize));
            }
            return chunks;
        }

        // Added By Dipali V On 20th May 2026 - Purpose:-Start batch close/void with loader; optional onComplete after all chunks (Save vs Next).
        function ProjectTaskCloseOrVoid(Taskids, onComplete, isBusyAlreadySet) {
            // Added By Dipali V On 20th May 2026 - Purpose:-Allow API flow when loader already set by caller; block only true duplicate clicks.
            if (__taskCloseVoidInProgress && !isBusyAlreadySet) {
                return;
            }
            var projectId = parseInt(ProjectID, 10);
            var ids = normalizeProjectClosureTaskIds(Taskids);
            if (isNaN(projectId) || projectId <= 0 || ids.length === 0) {
                showAlert('Please Select At least One Task', 'alert-danger');
                return;
            }
            var batches = chunkProjectClosureTaskIds(ids, TASK_CLOSE_VOID_BATCH_SIZE);
            if (!isBusyAlreadySet) {
                setProjectTaskCloseVoidBusy(true);
            }
            runProjectTaskCloseOrVoidBatches(projectId, batches, 0, onComplete);
        }

        // Added By Dipali V On 20th May 2026 - Purpose:-Call batch API per chunk; refresh grid and alert only after last chunk; then run onComplete callback.
        function runProjectTaskCloseOrVoidBatches(projectId, batches, batchIndex, onComplete) {
            if (!batches || batchIndex >= batches.length) {
                setProjectTaskCloseVoidBusy(false);
                showAlert('Project Tasks Closed/Void Successfully.', 'alert-success');
                $("#checkboxcloseall").removeAttr('checked');
                arrTaskIds.length = 0;
                getProjectCloserDetails("all");
                arrTaskIds = [];
                if (typeof onComplete === "function") {
                    onComplete();
                }
                return;
            }

            var projectcloser = {
                ProjectId: projectId,
                TaskIdsCsv: batches[batchIndex].join(",")
            };
            // Added By Dipali V On 20th May 2026 - Purpose:-Do not put TaskIdsCsv in Params header (600+ IDs caused HTTP 400 Request headers too long).
            var paramsHeaderOnly = { ProjectId: projectId };

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectClosure/ProjectTaskCloseOrVoid',
                method: 'Post',
                data: JSON.stringify(projectcloser),
                dataType: 'json',
                async: true,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    xhr.setRequestHeader("Params", encryptString(JSON.stringify(paramsHeaderOnly)));
                },
                success: function () {
                    runProjectTaskCloseOrVoidBatches(projectId, batches, batchIndex + 1, onComplete);
                },
                error: function (err) {
                    setProjectTaskCloseVoidBusy(false);
                    var errMsg = (err && err.responseText) ? err.responseText : err;
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + errMsg;
                }
            });
        }

        /* Commented By Dipali V On 20th May 2026 - Purpose:-Previous single sync AJAX with full Taskids array; timed out / crashed when 600+ tasks selected.
        function ProjectTaskCloseOrVoid(Taskids) {
            var projectcloser = {
                ProjectId: encodeURI(ProjectID),
                Taskids: Taskids
            };
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectClosure/ProjectTaskCloseOrVoid',
                method: 'Post',
                data: JSON.stringify(projectcloser),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (projectcloser) {
                        xhr.setRequestHeader("Params", encryptString(isJson(projectcloser) ? projectcloser : JSON.stringify(projectcloser)));
                    }
                },
                success: function (result) {
                    showAlert('Project Tasks Closed/Void Successfully.', 'alert-success');
                    $("#checkboxcloseall").removeAttr('checked');
                    arrTaskIds.length = 0;
                    getProjectCloserDetails("all");
                    arrTaskIds = [];
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        */
        //add by omkar 9/12/2019
        var ArrLessonsLearnedPublishToKM = [];
        var CopyLessonsLearnedData = {};
        //end

        function GetProjectLessonsLearnedDetails(ProjecId) {
            //debugger
            var ProjectId = encodeURI(ProjecId);
            $("#lessonlearttbl").dataTable().fnDestroy();
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectClosure/GetProjectLessonsLearnedDetails',
                method: 'Post',
                data: JSON.stringify(ProjectId),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                    }
                },
                success: function (result)
                {
                    //debugger;
                    CopyLessonsLearnedData = {};
                    var LessonsLearnedDetails = result.LessonLearntData;
                    CopyLessonsLearnedData = LessonsLearnedDetails;
                    var LessonLearntDocument = result.LessonLearntDocument;
                    ArrLessonsLearnedPublishToKM = [];
                      //add by omkar 17/12/2019
                     EditLessonLearntId = "";
                     EditRowNo = "";


                    var strHTML = "";
                    for (var i = 0; i < LessonsLearnedDetails.length; i++) {
                       // alert(LessonsLearnedDetails.length);
                        var problemType = LessonsLearnedDetails[i]["ProblemType"];
                        var Problemdescription = LessonsLearnedDetails[i]["ProblemDescription"];
                        var PreventiveAction = LessonsLearnedDetails[i]["PreventiveAction"];
                        var LessonId = LessonsLearnedDetails[i]["LessonId"];
                        var Solution = LessonsLearnedDetails[i]["Solution"];
                        var ReferedDocument = LessonsLearnedDetails[i]["ReferedDocument"];
                        var PKTM = LessonsLearnedDetails[i]["PublishToKM"];
                        // alert(PKTM);

                        strHTML += " <tr id='r" + i + "'>"
                        strHTML += " <td id='r" + i + "c0'>" + problemType + "</td>"
                        // if (Problemdescription.length < 30) {
                        strHTML += " <td id='r" + i + "c1'><span  data-bs-toggle='tooltip' title='' data-bs-placement='top' data-bs-container='body'>" + Problemdescription + "</span></td>"
                        //  }
                        //else {
                        //    var str = Problemdescription.substring(0, 30);
                        //    strHTML += " <td id='r" + i + "c1' ><span data-bs-toggle='tooltip' title='" + Problemdescription +"' data-bs-placement='top' data-bs-container='body'>" + str + "...</span></td>"

                        //}

                        //if (Solution.length < 30) {
                        strHTML += " <td id='r" + i + "c2' ><span data-bs-toggle='tooltip' title='' data-bs-placement='top' data-bs-container='body'>" + Solution + "</span></td>"
                        //}
                        //else {
                        //    var str = Solution.substring(0, 30);
                        //    strHTML += " <td id='r" + i + "c2' ><span data-bs-toggle='tooltip' title='" + Solution +"' data-bs-placement='top' data-bs-container='body'>" + str + "...</span></td>"

                        //}

                        // if (PreventiveAction.length < 30) {
                        strHTML += " <td id='r" + i + "c3' ><span data-bs-toggle='tooltip' title='' data-bs-placement='top' data-bs-container='body'>" + PreventiveAction + "</span></td>"
                        //  }
                        //else {
                        //    var str = PreventiveAction.substring(0, 30);
                        //    strHTML += " <td id='r" + i + "c3' ><span data-bs-toggle='tooltip' title='" + PreventiveAction +"' data-bs-placement='top' data-bs-container='body'>" + str + "...</span></td>"

                        //}

                        //strHTML += " <td id='r" + i + "c2'>" + Solution + "</td>"
                        //strHTML += " <td id='r" + i + "c3'>" + PreventiveAction + "</td>"
                        //Commented And Added By Usha Pandit On 26.03.2020 For adding attachment during update
                         //strHTML += " <td>"
                         strHTML += " <td id='dataUploadDoc'>"
                         //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update
                        strHTML += " <div id='rdname' class='rdname'>"
                        strHTML += "<ul>"
                        var strFile = "";
                        var currentlessoncount = 0;
                        for (var j = 0; j < LessonLearntDocument.length; j++) {

                            var Lessonid = LessonLearntDocument[j]["LessonId"];
                            var DocumentID = LessonLearntDocument[j]["DocumentID"];
                            var filename = LessonLearntDocument[j]["OriginalFileName"];
                            //debugger;
                            if (Lessonid == LessonId) {
                                currentlessoncount = currentlessoncount + 1;
                                //strHTML += "<li>"+filename+"</li>"

                                if (filename.length < 30) {
                                    strHTML += "<li><a href='#' onclick ='DownloadAttachedFile(" + Lessonid + "," + DocumentID + ")' data-bs-toggle='tooltip' title='" + filename + "' data-bs-placement='bottom'>" + filename + "</a>"
                                }
                                else {
                                    var str = filename.substring(0, 30);
                                    strHTML += "<li><a href='#' onclick ='DownloadAttachedFile(" + Lessonid + "," + DocumentID + ")' data-bs-toggle='tooltip' title='" + filename + "' data-bs-placement='bottom'>" + str + "...</a>"

                                }


                                if (m_PM_ProjectClosureblnDeleteAccess == "True") {

                                    if (closeproject == true) {
                                        strHTML += "<button class='clsattchfile nostylebtn' onclick = 'DeleteLessonLearntDocumentalert(" + Lessonid + "," + DocumentID + ")' disabled data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Delete Attachment'>X</button>"
                                    }
                                    else {
                                        //added and commented by omkar 26/3/2020 issue id 23457
                                        //strHTML += "<button class='clsattchfile nostylebtn' onclick = 'DeleteLessonLearntDocumentalert(" + Lessonid + "," + DocumentID + ")' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Delete Attachment'>X</button>"
                                        //Commented And Added By Usha Pandit On 23.04.2020 For showing ban-circle for disabled attachments
                                        //strHTML += "<button id='r" + i + "c4' class='clsattchfile nostylebtn' onclick = 'DeleteLessonLearntDocumentalert(" + Lessonid + "," + DocumentID + ")' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Delete Attachment' disabled='disabled'>X</button>"
                                        strHTML += "<button id='r" + i + "c4' class='clsattchfile nostylebtn clsCursorNotAllowed' onclick = 'DeleteLessonLearntDocumentalert(" + Lessonid + "," + DocumentID + ")' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Delete Attachment' disabled='disabled'>X</button>"
                                        //End Added By Usha Pandit On 23.04.2020 For showing ban-circle for disabled attachments
                                        //end of added and commentd by omkar 26/3/2020 issue id 23457
                                    }
                                }
                                strHTML += "</li > "
                                // strHTML += "<li><a href='javascript: var objChild= window.open(&quot;../../PM/PM_ViewDocument.aspx?MasterTagID=39&amp;FromWhere=PM&amp;DocumentID=" + DocumentID + "&quot;,&quot;&quot;,&quot;left=&quot; + (window.screen.width-500)/2 + &quot;,top=&quot; + (window.screen.height-400)/2 + &quot;,width=500,height=300&quot;);'>" + filename + "</a></li>"
                            }
                            // strFile = "";
                        }
                        strHTML += "</ul></div>"
                        strHTML += "</td>"
                        strHTML += " <td class='actioncolumn' id=actioncolumn_" + i +">"
                        //Added By Usha Pandit On 26.03.2020 For adding attachment during update
                        strHTML += '<a class="nostylebtn attach clsAttachment" href="javascript:;" title="" data-original-title=""><label class="uploadBtnWrap" for="thefileEdit_' + i + '"><input type="file" onchange="UploadCurrentFile(this,' + i + ',' + LessonId + ',' + currentlessoncount + ')" id="thefileEdit_' + i + '" ><span class="nostylebtn" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="" data-original-title="Upload Documents"><img src="../../../Whizible2.0-new/dist/img/attachment.svg" width="16px"></span></label></a>';
                        //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update
                        strHTML += "<a  href='javascript:;'  class='add' onclick='UpdateLessonLearnt(" + i + "," + LessonId + ")' title='Save' data-bs-toggle='tooltip' data-bs-container='body' >"
                        strHTML += "<img class='material-icons' src='../../../Whizible2.0-new/dist/img/save.svg' alt='' width='16px' ></a>"
                        if (m_PM_ProjectClosureblnEditAccess == "True" && ProjectOver == 0) {
                            //add by omkar 17/12/2019
                            //strHTML += "<a id='lessonLeanrtEdit_" + i + "' class='nostylebtn edit' href='javascript:;' title='' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Edit'>"
                            strHTML += "<a id='lessonLeanrtEdit_" + i + "' class='nostylebtn edit' href='javascript:;' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' title='Edit' value="+LessonId+">"
                            strHTML += "<img src='../../../Whizible2.0-new/dist/img/edit.svg' width='16px'></a>"
                        }

                        if (PKTM == "1" || PKTM == true) {
                            //add by omkar 9/12/2019
                            var rid = "r" + i;
                            ArrLessonsLearnedPublishToKM.push(rid);
                            strHTML += "<div class='custom_chckbox inline check' style='display:none'><input  type='checkbox' name='' class='nostylebtn chckHead' id='checkPublish_" + i + "' checked><label for='checkPublish_" + i + "' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Publish to Knowledge' > </label></div>";
                            //end
                        } else {
                            //add by omkar 9/12/2019
                            strHTML += "<div class='custom_chckbox inline check' style='display:none'><input  type='checkbox' name='' class='nostylebtn chckHead' id='checkPublish_" + i + "' ><label for='checkPublish_" + i + "' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Publish to Knowledge'></label></div>";
                            //end
                        }

                        //strHTML += '<a class="nostylebtn attach" href="javascript:;" title="">'
                        //strHTML += '<label class="uploadBtnWrap" for="thefile">'
                        //strHTML += '<input type="file" id="thefile"  onchange="alertFilename1()"  multiple>'
                        //strHTML += '<span class="nostylebtn" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Click here to Upload your document">'
                        //strHTML += '<img src="../../../Whizible2.0-new/dist/img/attachment.svg" width="16px"></span>'
                        //strHTML += '</label>'
                        //strHTML += '</a>&nbsp;&nbsp;'
                        if (m_PM_ProjectClosureblnDeleteAccess == "True" && ProjectOver == 0) {
                            strHTML += "<a id='lessonLeanrtdelete_" + i + "' class='nostylebtn delete' onclick='DeleteLessonLearnt(" + LessonId + ")'><i class='far fa-trash-alt' title='Delete' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Delete'></i></a><a class='nostylebtn cancelrowvalue'><i class='fas fa-times' title='Cancel' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body'></i></a>"
                        }


                        // strHTML += "</td>"
                        //strHTML += "<td>"
                        //strHTML += "<input  type='checkbox' name='' class='nostylebtn check' id='checkPublish' style='display:none' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Publish to Knowledge'>"
                        strHTML += "</td></tr>"


                    }
                    $("#tblbdylessonlearttbl").html(strHTML);
                    //add by omkar 16/12/2019
                    $("#lessonlearttbl").DataTable({
                        "scrollY": true,
                        "scrollX": '100',
                        "scrollResize": true,
                        "pageLength": 2,
                        "lengthChange": false,
                        "bFilter": false,
                        "ordering": true,
                        "responsive": true,
                        "scrollCollapse": true,
                        "dom": "<'row'<'col-sm-12 dtscroll'tr>>" + "<'row'<'col-sm-4'i><'col-sm-1'f><'col-sm-7 searchStyle'p>>",

                    });

                    $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                        $($.fn.dataTable.tables(true)).DataTable()
                            .columns.adjust();

                    });
                    $($.fn.dataTable.tables(true)).css('width', '100%'); $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();

                    //added by pradip on 13-12-2019 for adjust add new colum if no data.
                    //alert(strHTML);
                    if (LessonsLearnedDetails.length == 0) {
                       // debugger;
                        //alert();
                        $(".add_llrow td.tdSaveLessonLearnt").css("width", "10.5%!important");
                    }

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        //Added By Usha Pandit On 26.03.2020 For adding attachment during update
        async function UploadCurrentFile(file, curid, currentlessonid, currentfilecount) {
            try {
                //added by Parth Godshelwar
                if (!file) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Please Select File");
                    return
                }
                var objFile = file;
                var fileName = objFile.files[0].name;
                var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();
                isValidTypeExeCheck = false;
                const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
                isValidTypeExeCheck = ValidExtsExe.includes(extension);
                if (isValidTypeExeCheck) {
                    const file = objFile.files[0];
                    //await checkFileForExe(file);
                    await validateDocFileForExe(file)
                        .then(() => {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success("File is valid and ready to upload.");
                            //alert("File is valid and ready to upload.");
                        })
                        .catch(error => {
                            //Added by Ajit L on 21/11/2024
                            var fileInput = objFile;
                            var fileNameInput = $(fileInput).closest('td').find('[id^="FileName"]');
                            // Before clearing:
                            // console.log("Selected files before clearing:", fileInput.files); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            $(fileInput).val(""); // Clear the file input
                            fileNameInput.val(""); // Clear the file name text input                          
                            //End of Added by Ajit L on 21/11/2024
                            // console.log(error); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                            //alert("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                            isValidTypeExeCheck = false;
                            // console.log($(objFile).val); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            $(file).val("");
                            // console.log($(file).val); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            /*$(objFileName).attr("placeholder", "Upload File");*/
                            //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                            return;
                        });



                    if (!isValidTypeExeCheck) {
                        return;
                    }
                }


                //Ended by Parth Godshelwar

                var trid = curid;
                trid = trid.toString().replace("thefileEdit_", "");

                $("#dataUploadDoc").show();
                var idpath = "#r" + trid + " > td > a.nostylebtn.attach > label.uploadBtnWrap>input#thefileEdit_" + trid;

                var ele = document.getElementById($(idpath).attr('id'));

                var tdid = $('#r' + trid + ' > td:nth-child(5)>div.rdname>ul');

                var fileindex1 = $("#r" + trid + " > td:nth-child(5)>div.rdname>ul>li").length;

                fileindex1 = fileindex1 + 1;
                var result = ele.files;

                for (var x = 0; x < result.length; x++) {
                    var fle = result[x];
                    var fileid = fileindex1 - currentfilecount;
                    //$("#rdname ul").append("<li>" + fle.name + "(TYPE: " + fle.type + ", SIZE: " + fle.size + ")</li>");
                    $(tdid).append("<li><a cleass='filedownload' href='javascript:;' download>" + fle.name + "</a><button class='clscurrentattchfile nostylebtn' onclick = 'DeleteCurrentLessonLearnt(" + currentlessonid + "," + fileindex1 + ")' name=" + fileid + " id=" + fileindex1 + ">X</button></li>");
                    fileindex1++;
                }
                var fileindex = $("#r" + trid + " > td:nth-child(5)>div.rdname>ul>li").length;
                Flag = ValidateAttachment('thefileEdit_' + trid, '#r' + trid + ' > td:nth-child(6)>a>label>input#thefileEdit_' + trid);
                for (var x = 0; x < result.length; x++) {
                    var gerfileName = result[x];
                    formdata.append("file" + fileindex, gerfileName);
                }
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update

        //*********************************************************************************************************
        //Attachment download code starts from here
        var PKToken = '';
        function DownloadAttachedFile(Lessonid, DocumentID) {
            PKToken = GetToken(39, DocumentID, Lessonid, ProjectID);
            var strTemp = '../../NewAPI/PM/PM_ViewAttachment.aspx?FromWhere=LessonLearntDocument&MasterTagID=39&DocumentID=' + DocumentID + '&PKToken=' + PKToken + '&ProjectID=' + ProjectID + '&LessonID=' + Lessonid;
            window.open(strTemp);
        }

        function GetToken(TagID, DocumnetID, Lessonid, ProjectID) {
            var TokenParameter =
            {
                TagID: TagID,
                DocumnetID: DocumnetID,
                LessonID: Lessonid,
                ProjectID: ProjectID
            }
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/GetToken',
                type: "POST",
                data: JSON.stringify(TokenParameter),
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (TokenParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(TokenParameter) ? TokenParameter : JSON.stringify(TokenParameter)));
                    }
                },
                async: false,
                success: function (result) {
                    PKToken = result
                },
                error: function (xhr, status, error) {
                }
            });
            return PKToken;
        }
        //Attachment Download code ends here.
        //*********************************************************************************************************

        function GetLessonLeanProblemTypes(cboId) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectClosure/GetLessonLeanProblemTypes',
                method: 'Post',
                data: JSON.stringify(),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (strResult) {
                    $("#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(1)>select#" + cboId).empty();
                    if (strResult != undefined) {
                        var selHTML = "";
                        selHTML += "<option  value=0  >Select Problem Type</option>";
                        for (var i = 0; i < strResult.length; i++) {
                            var d = strResult[i];
                            var Description = d.Description;
                            selHTML += "<option  value='" + Description + "'  >" + Description + "</option>";
                        }
                        $("#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(1)>select#" + cboId).html(selHTML);
                    }
                    $('[data-bs-toggle="tooltip"]').tooltip();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        //function GetLessonLeanProblemTypes1(cboId) {
        //    $.ajax({
        //        url: encodeURI(strUrl) + '/api/PM_ProjectClosure/GetLessonLeanProblemTypes',
        //        method: 'Post',
        //        data: JSON.stringify(),
        //        dataType: 'json',
        //        async: false,
        //        contentType: "application/json",
        //        beforeSend: function (xhr) {
        //            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
        //        },
        //           success: function (strResult) {
        //            $("#tblbdylessonlearttbl > tr#"+Rowid+" > td:nth-child(1)>select#" + cboId).empty();
        //            if (strResult != undefined) {
        //                var selHTML = "";
        //                selHTML += "<option  value=0  >Select Problem Type</option>";
        //                for (var i = 0; i < strResult.length; i++) {
        //                    var d = strResult[i];
        //                    var Description = d.Description;
        //                    selHTML += "<option  value='" + Description + "'  >" + Description + "</option>";
        //                }
        //                $("#tblbdylessonlearttbl > tr#"+Rowid+" > td:nth-child(1)>select#" + cboId).html(selHTML);
        //            }
        //            $('[data-bs-toggle="tooltip"]').tooltip();
        //        },
        //        error: function (err) {
        //            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
        //        }
        //    });
        //}

        function GetLessonLeanProblemTypes1(Rowid, cboId) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectClosure/GetLessonLeanProblemTypes',
                method: 'Post',
                data: JSON.stringify(),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (strResult) {
                    $("#tblbdylessonlearttbl > tr#" + Rowid + " > td:nth-child(1)>select#" + cboId).empty();
                    if (strResult != undefined) {
                        var selHTML = "";
                        selHTML += "<option  value=0  >Select Problem Type</option>";
                        for (var i = 0; i < strResult.length; i++) {
                            var d = strResult[i];
                            var Description = d.Description;
                            selHTML += "<option  value='" + Description + "'  >" + Description + "</option>";
                        }
                        $("#tblbdylessonlearttbl > tr#" + Rowid + " > td:nth-child(1)>select#" + cboId).html(selHTML);
                    }
                    $('[data-bs-toggle="tooltip"]').tooltip();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function SaveLessonLearnt() {
            //add by omkar 13/12/2019
            Flag = true;
           // var formdata = new FormData();
            var LoginType = '<%= Session("LoginType") %>';
            var UserName = '<%= Session("strUserName") %>';
            var UserID = '<%= Session("intUserID") %>';
            var AttachedFileData = new Array();
            var Files = new Array();
            var d = new Date();
            var ProblemType;
          /*  var Description;*/
            var Solution='';
            var PreventiveAction='';
            var Flag = true;
            $('#tblbdylessonlearttbl > tr.add_llrow').each(function (index, value) {
                var Description = "";
                var File;
                var Date = "";
                var allColumns = $(this).find('td');
                // var TRID = $(this).find('tr');
                // alert(TRID.id);
                 /*debugger;*/
                $(allColumns).each(function (i, v) {
                    /* debugger;*/
                    if (i == 1) {

                        Description = $(this).find('textarea').val();
                        //if (Description.length == 0) {
                        if ($.trim(Description).length == 0) {
                            showAlert('Description should not be blank', 'alert-danger');
                            $(this).find('textarea').focus();
                            Flag = false;
                            return false;
                        }
                        //Added By Rehan C To add Validator for Special characters on 15th Nov 2022
                        if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Problem Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                            $(this).find('textarea').focus();
                            Flag = false;
                            return false;
                        }

                    }
                    //if (i == 4) {
                    //    debugger;
                    //    var idpath = "#tblbdylessonlearttbl > tr.add_llrow > td > a.nostylebtn.attach > label.uploadBtnWrap>input#thefile";
                    //    var ele = document.getElementById($(idpath).attr('id'));
                    //    //var tdid = $('#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(5)>ul');
                    //    var tdid = $('#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(5) > ul');
                    //    var UlIl = $("#dataUploadDoc .rdname ul li").length;
                    //    var rdname = $(idpath).closest('li').html('');
                    //    var result = ele.files;
                    //     // FilesName.push(ele.files);
                    //    //var result = FilesName;
                    //   // alert(FilesName);
                    //  //debugger;
                    //    if (result.length == 0) {
                    //        //showAlert('Please attach the Reffered Document.', 'alert-danger');
                    //        //Flag = false;
                    //        // return false;
                    //    }
                    //    else {
                    //        Flag = ValidateAttachment('thefile', '#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(6)>a>label>input#thefile');
                    //        for (var x = 0; x < result.length; x++) {
                    //            var gerfileName = result[x];
                    //            //formdata.append("file" + index, gerfileName);
                    //             formdata.append("file" + index, gerfileName);
                    //        }
                    //    }
                    //}

                    if (i == 4) {
                        var idpath = "#tblbdylessonlearttbl > tr.add_llrow > td > a.nostylebtn.attach > label.uploadBtnWrap>input#thefile";
                        var ele = document.getElementById($(idpath).attr('id'));
                        var tdid = $('#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(5)>ul');
                        var rdname = $(idpath).closest('li').html('');
                        var result = ele.files;
                        //Added BY Rutuja D. On 30 Dec 2020 For Validate Attachment Before Saving
                        Flag = ValidateAttachment('thefile', '#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(6)>a>label>input#thefile');
                        //End Added BY Rutuja D. On 30 Dec 2020 For Validate Attachment Before Saving

                        if (result.length == 0) {
                            //showAlert('Please attach the Reffered Document.', 'alert-danger');
                            //Flag = false;
                            // return false;
                        }
                        else {
                            //Flag = ValidateAttachment('thefile', '#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(6)>a>label>input#thefile');
                            //for (var x = 0; x < result.length; x++) {
                            //    var gerfileName = result[x];
                            //    formdata.append("file" + index, gerfileName);
                            //}
                        }
                    }


                    if (i == 0) {
                        ProblemType = $("#tblbdylessonlearttbl > tr.add_llrow > td:nth-child(1)>select> option:selected").text();
                        var ProblemTypeval = $("#tblbdylessonlearttbl > tr.add_llrow  > td:nth-child(1)>select> option:selected").val();

                        if (ProblemTypeval == 0) {
                            showAlert('Please Select Problem Type ', 'alert-danger');
                            //$("#tblbdylessonlearttbl > tr.add_llrow  > td:nth-child(1)>select> option:selected").focus();
                            $(this).find('select').focus();
                            Flag = false;
                            return false;
                        }

                    }
                    if (i == 2) {
                        Solution = $(this).find('textarea').val();
                        if ($.trim(Solution).length == 0) {
                            showAlert('Solution should not be blank', 'alert-danger');
                            $(this).find('textarea').focus();
                            Flag = false;
                            return false;
                        }
                        //Added By Rehan C To add Validator for Special characters on 15th Nov 2022
                        if (checkSpecialCharacter(Solution, WebConfigSpecialCharacters) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Solution should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                            $(this).find('textarea').focus();
                            Flag = false;
                            return false;
                        }
                    }
                    if (i == 3) {
                        PreventiveAction = $(this).find('textarea').val();
                        if ($.trim(PreventiveAction).length == 0) {
                            showAlert('Preventive Action should not be blank', 'alert-danger');
                            $(this).find('textarea').focus();
                            Flag = false;
                            return false;
                        }
                        //Added By Rehan C To add Validator for Special characters on 15th Nov 2022
                        if (checkSpecialCharacter(PreventiveAction, WebConfigSpecialCharacters) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Preventive Action should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                            $(this).find('textarea').focus();
                            Flag = false;
                            return false;
                        }
                    }
                });
                //Added By Rehan C for Add Leasson Learnt Issue on 17th Nov 2022
                if (Flag == true)
                {
                    if ($("#checkPublish")[0].checked) {
                        var PTKM = "1";
                    }
                    else {
                        var PTKM = "0";
                    }

                    var item =
                    {
                        //Description: encodeURI(Description),
                        //ProblemType: encodeURI(ProblemType),
                        //Solution: encodeURI(Solution),
                        //PreventiveAction: encodeURI(PreventiveAction),
                        //PTKM: encodeURI(PTKM),
                        //CreatedBy: encodeURI(UserName),
                        //ProjectId: encodeURI(ProjectID),
                        //UserID: encodeURI(UserID),
                        //LoginType: encodeURI(LoginType)
                        Description: Description,
                        ProblemType: encodeURI(ProblemType),
                        Solution: Solution,
                        PreventiveAction: PreventiveAction,
                        PTKM: encodeURI(PTKM),
                        CreatedBy: UserName,
                        ProjectId: encodeURI(ProjectID),
                        UserID: encodeURI(UserID),
                        LoginType: encodeURI(LoginType),
                        deletedFileCnt: deletedFileCnt
                    }
                    AttachedFileData.push(item);
                    formdata.append("AttachedFileData", JSON.stringify(AttachedFileData));
                    // console.log(JSON.stringify(AttachedFileData)) //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                }
            });
            //End of comment by Rehan C
            if (Flag == true) {
                $.ajax({
                    url: strUrl + '/api/PM_ProjectClosure/SaveLessonLearnt',
                    type: "POST",
                    dataType: "json",
                    data: formdata,
                    contentType: false,
                    processData: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (result) {
                       //alert(result)
                        if (result != "") {
                            //debugger;
                            //Added By Dipali V On 8th July 2020 For Error alert should be come in red
                            if (result.indexOf("save") != -1) {
                                showAlert(result, 'alert-success');

                            } else {
                                showAlert(result, 'alert-danger');
                            }
                            //End of Added By Dipali V On 8th July 2020 For Error alert should be come in red
                        }
                        //showAlert('Lesson Learnt Added Successfully', 'alert-success');
                        $("#theadReferredDocument").removeAttr('colspan', 2);
                        $("#theadBlank").show();
                        FilesName = [];
                        formdata = new FormData();
                        deletedFileCnt = [];

                        //formdata.forEach(function (val, key, fD)
                        //{
                        //    formdata.delete(key)
                        //});
                        //$("#theadBlank").show();
                       // debugger;
                        GetProjectLessonsLearnedDetails(ProjectID);
                        $('.add-new').attr('disabled', false);
                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            //end
          
            $('table').resize();
        }
        var ID = new Array();
        var LoginType1 = '<%= Session("LoginType") %>';
        var UserName1 = '<%= Session("strUserName") %>';
        var UserID1 = '<%= Session("intUserID") %>';
        var PreventiveAction1;
        var ProblemType1;
        var Solution1;
        var Description1;
        var Flag1 = true;
        var lesson1;

        function clear() {
            PreventiveAction1 = "";
            ProblemType1 = "";
            Description1 = "";
            Solution1 = "";
        }
        //add by omkar 6/12/2019
        var editflag = false;
        var selectedRow = "";
        //end
        function UpdateLessonLearntold(row, LessonId) {
            selectedRow = row;
            //add by omkar 13/12/2019
            Flag1 = true;

            $('.edit').each(function () {
                ID.push(this.id);

            });
             // debugger;
            for (var i = 0; i < ID.length; i++) {
                if ($("#lessonLeanrtEdit_" + row == ID[i])) {
                    $("#lessonLeanrtEdit_" + ID[i]).prop("disabled", false);
                      $("#lessonLeanrtdelete_" + ID[i]).prop("disabled", false);
                } else {
                    $("#lessonLeanrtEdit_" + ID[i]).prop("disabled", true);
                    $("#lessonLeanrtdelete_" + ID[i]).prop("disabled", true);
                }
            }


            alertify.set('notifier', 'position', 'top-right');

            var ProblemType = $("#r" + row + "c0> select#cbo0 option:selected").text();
            var ProblemTypeval = $("#r" + row + "c0> select#cbo0 option:selected").val();
            var Description = $("#r" + row + "c1> textarea").val();
            var Solution = $("#r" + row + "c2> textarea").val();
            var PreventiveAction = $("#r" + row + "c3> textarea").val();
            var PublishToKM = $(".actioncolumn #checkPublish_" + row);
            if (PublishToKM[0].checked) {
                var PTKM = "1";
            }
            else {
                var PTKM = "0";
            }


            if (ProblemTypeval == 0) {
                showAlert('Please Select Problem Type', 'alert-danger');
                $("#r" + row + "c0> select#cbo0").focus();
                Flag1 = false;
                return false;
            }
            if ($.trim(Description).length == 0) {
                showAlert('Description should not be blank.', 'alert-danger');
                $("#r" + row + "c1> textarea").focus();
                Flag1 = false;
                return false;
            }

            if ($.trim(Solution).length == 0) {
                showAlert('Solution should not be blank.', 'alert-danger');
                $("#r" + row + "c2> textarea").focus();
                Flag1 = false;
                return false;
            }
            if ($.trim(PreventiveAction).length == 0) {
                showAlert('Preventive Action should not be blank.', 'alert-danger');
                $("#r" + row + "c3> textarea").focus();
                Flag1 = false;
                return false;
            }

            if (Flag1 == true) {
                var lesson = {
                    Description: encodeURI(Description),
                    ProblemType: encodeURI(ProblemType),
                    Solution: encodeURI(Solution),
                    PreventiveAction: encodeURI(PreventiveAction),
                    // PreventiveAction: encodeURI(PreventiveAction),
                    PTKM: encodeURI(PTKM),
                    CreatedBy: encodeURI(UserName1),
                    ProjectId: encodeURI(ProjectID),
                    UserID: encodeURI(UserID1),
                    LoginType: encodeURI(LoginType1),
                    LessonId: encodeURI(LessonId)
                }
                StartLoader("#ProjectClosureBody");
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectClosure/InsertOrUpdateLessonLearnt',
                    method: 'Post',
                    data: JSON.stringify(lesson),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (strResult) {
                        StopAjaxLoader("#ProjectClosureBody");
                        showAlert('Lesson Learnt Updated Successfully.', 'alert-success');
                        GetProjectLessonsLearnedDetails(ProjectID);
                        $(".add-new").removeAttr("disabled");
                        //add by omkar 6/12/2019
                        editflag = false;
                        //end
                    },
                    error: function (err) {
                        StopAjaxLoader("#ProjectClosureBody");
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            //end
        }

        function UpdateLessonLearnt(row, LessonId) {
            try {
                //add by omkar 13/12/2019
                Flag1 = true;

                $('.edit').each(function () {
                    ID.push(this.id);

                });
                // debugger;
                for (var i = 0; i < ID.length; i++) {
                    if ($("#lessonLeanrtEdit_" + row == ID[i])) {
                        $("#lessonLeanrtEdit_" + ID[i]).prop("disabled", false);
                        $("#lessonLeanrtdelete_" + ID[i]).prop("disabled", false);
                    } else {
                        $("#lessonLeanrtEdit_" + ID[i]).prop("disabled", true);
                        $("#lessonLeanrtdelete_" + ID[i]).prop("disabled", true);
                    }
                }


                alertify.set('notifier', 'position', 'top-right');

                var ProblemType = $("#r" + row + "c0> select#cbo0 option:selected").text();
                var ProblemTypeval = $("#r" + row + "c0> select#cbo0 option:selected").val();
                var Description = $("#r" + row + "c1> textarea").val();
                var Solution = $("#r" + row + "c2> textarea").val();
                var PreventiveAction = $("#r" + row + "c3> textarea").val();
                var PublishToKM = $(".actioncolumn #checkPublish_" + row);
                if (PublishToKM[0].checked) {
                    var PTKM = "1";
                }
                else {
                    var PTKM = "0";
                }


                if (ProblemTypeval == 0) {
                    showAlert('Please Select Problem Type', 'alert-danger');
                    $("#r" + row + "c0> select#cbo0").focus();
                    Flag1 = false;
                    return false;
                }
                if ($.trim(Description).length == 0) {
                    showAlert('Description should not be blank.', 'alert-danger');
                    $("#r" + row + "c1> textarea").focus();
                    Flag1 = false;
                    return false;
                }
                //Added By Rehan C To add Validator for Special characters on 15th Nov 2022
                if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Problem Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#r" + row + "c1> textarea").focus();
                    Flag = false;
                    return false;
                }
                if ($.trim(Solution).length == 0) {
                    showAlert('Solution should not be blank.', 'alert-danger');
                    $("#r" + row + "c2> textarea").focus();
                    Flag1 = false;
                    return false;
                }
                //Added By Rehan C To add Validator for Special characters on 15th Nov 2022
                if (checkSpecialCharacter(Solution, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right'); Solution
                    alertify.error('Solution should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#r" + row + "c2> textarea").focus();
                    Flag = false;
                    return false;
                }
                //if (checkSpecialCharacter(Solution, WebConfigSpecialCharacters) == true) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error('Solution should contain any of these ' + WebConfigSpecialCharacters + ' characters');
                //    $("#lesonsolution").focus();
                //    Flag = false;
                //    return false;
                //}
                if ($.trim(PreventiveAction).length == 0) {
                    showAlert('Preventive Action should not be blank.', 'alert-danger');
                    $("#r" + row + "c3> textarea").focus();
                    Flag1 = false;
                    return false;
                }
                //Added By Rehan C To add Validator for Special characters on 15th Nov 2022
                if (checkSpecialCharacter(PreventiveAction, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Preventive Action should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#r" + row + "c3> textarea").focus();
                    Flag = false;
                    return false;
                }
                //if (checkSpecialCharacter(PreventiveAction, WebConfigSpecialCharacters) == true) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error('Preventive Action should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                //    $("#prevntiveaction").focus();
                //    Flag = false;
                //    return false;
                //}

                if (Flag1 == true) {
                    var lesson = {
                        Description: encodeURI(Description),
                        ProblemType: encodeURI(ProblemType),
                        Solution: encodeURI(Solution),
                        PreventiveAction: encodeURI(PreventiveAction),
                        // PreventiveAction: encodeURI(PreventiveAction),
                        PTKM: encodeURI(PTKM),
                        CreatedBy: encodeURI(UserName1),
                        ProjectId: encodeURI(ProjectID),
                        UserID: encodeURI(UserID1),
                        LoginType: encodeURI(LoginType1),
                        LessonId: encodeURI(LessonId),
                        //2020
                        deletedFileCnt: deletedcurrentFileCnt
                        //2020
                    }
                    //2020
                    var AttachedFileData = new Array();
                    AttachedFileData.push(lesson);
                    formdata.append("AttachedFileData", JSON.stringify(AttachedFileData));
                    //2020
                    StartLoader("#ProjectClosureBody");
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectClosure/InsertOrUpdateLessonLearnt',
                        type: "POST",
                        dataType: "json",
                        data: formdata,
                        async: false,
                        contentType: false,
                        processData: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        },
                        success: function (result) {
                            StopAjaxLoader("#ProjectClosureBody");
                            showAlert('Lesson Learnt Updated Successfully.', 'alert-success');
                            GetProjectLessonsLearnedDetails(ProjectID);
                            $(".add-new").removeAttr("disabled");
                            //add by omkar 6/12/2019
                            editflag = false;
                            //end
                        },
                        error: function (ER) {
                            StopAjaxLoader("#ProjectClosureBody");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });

                    //$.ajax({
                    //    url: encodeURI(strUrl) + '/api/PM_ProjectClosure/InsertOrUpdateLessonLearnt',
                    //    method: 'Post',
                    //    //2020
                    //    //data: JSON.stringify(lesson),
                    //    data: formdata,
                    //    //2020
                    //    dataType: 'json',
                    //    async: false,
                    //    //2020
                    //    //contentType: "application/json",
                    //    contentType: false,
                    //    processData: false,
                    //    //2020
                    //    beforeSend: function (xhr) {
                    //        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    //    },
                    //    success: function (strResult) {
                    //        StopAjaxLoader("#ProjectClosureBody");
                    //        showAlert('Lesson Learnt Updated Successfully.', 'alert-success');
                    //        GetProjectLessonsLearnedDetails(ProjectID);
                    //        $(".add-new").removeAttr("disabled");
                    //        //add by omkar 6/12/2019
                    //        editflag = false;
                    //        //end
                    //    },
                    //    error: function (err) {
                    //        StopAjaxLoader("#ProjectClosureBody");
                    //        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    }
                    //});
                }
                //end
            }
            catch (ex) {
                alert(ex.message);
            }
        }
         var arrControlEnabled = new Array();
        function disabled(id) {

            $("#tblbdylessonlearttbl .edit").each(function (obj) {
                // debugger;
                var controlid = this.id;
                var ID = controlid.split("_");
                // alert(ID[1]);
                // alert(ID[0]);
                if (ID[1] != id) {

                    // $(".actioncolumn a.edit").attr("disabled", "disabled");
                    $(".actioncolumn a.delete,a.edit").attr("disabled", "disabled");
                    //$(".actioncolumn a").css("cursor", "not-allowed");
                    //$(".actioncolumn a.edit").css("cursor", "not-allowed");
                    $(".actioncolumn a.delete, a.edit").css("cursor", "not-allowed");
                    // $(".actioncolumn a.edit").css("pointer-events", "none");
                    $(".actioncolumn a.delete,a.edit").css("pointer-events", "none");
                   // $("#lessonlearttbl_paginate").css("pointer-events", "none");
                   // $("#lessonlearttbl_paginate").css("cursor", "no-drop");
                    // $("#lessonlearttbl_paginate").css("cursor", "not-allowed");
                    //$(".actioncolumn").css("cursor", "no-drop");
                    $("#actioncolumn_" + ID[1]).css("cursor", "no-drop");
                   // $("#tblbdylessonlearttbl .dataTables_paginate").css("cursor", "no-drop");
                    $(".cancelrowvalue").removeAttr("cursor");
                    $(".cancelrowvalue").css("cursor", "pointer");
                    $("#lessonlearttbl_wrapper .dataTables_paginate a").css({ "pointer-events": "none", "cursor": "not-allowed!important" });
                    $("#lessonlearttbl_wrapper .dataTables_paginate a:hover").css({ "pointer-events": "none", "cursor": "not-allowed!important" });
                    $("#lessonlearttbl_wrapper .dataTables_paginate").css("cursor", "not-allowed");

                    $("#lessonlearttbl_wrapper .dataTables_paginate a").mouseover(function () {
                        $(this).css("cursor", "not-allowed");
                    });
                }
                else {
                   // alert(ID);
                    //added by omkar 26/3/2020 issue id 23457
                    $("#r" + ID[1] + "c4").removeAttr("disabled");
                    //end of added by omkar 26/3/2020 issue id 23457
                    //$(".actioncolumn a").prop("disabled", false);
                     //$(".actioncolumn").css("cursor", "pointer");
                    //$(".actioncolumn a.edit,a.delete").css("cursor", "auto");
                    ////$(".actioncolumn a.delete").css("cursor", "auto");
                    //$(".actioncolumn a.edit").removeAttr("disabled");
                    //$(".actioncolumn a.delete").removeAttr("disabled");
                    //$(".actioncolumn a.edit,a.delete").css("pointer-events", "auto");
                    //$("#lessonlearttbl_paginate").css("pointer-events", "auto");
                    //$("#lessonlearttbl_paginate").css("cursor", "none");


                }

            });
        }

        function DeleteLessonLearnt(LessonId) {
            $('#DeleteId').attr('value', LessonId);
            $("#deleteinfomodal").modal("show");
        }

        function DeleteData() {
            var deleteid = $("#DeleteId").attr("value");
            if (deleteid.length != 0) {
                DeleteLessonLearntData(deleteid);
                $("#DeleteId").removeAttr("value");
            }
        }

        function cancelDelted() {
            var deleteid = $("#DeleteId").attr("value");
            if (deleteid.length != 0) {
                $("#deleteinfomodal").modal("hide");
                $("#DeleteId").removeAttr("value");
                GetProjectLessonsLearnedDetails(ProjectID);
            }

            //Commented By Usha Pandit On 30.06.2020 For javascript error on cancel button click
            //$("#tblbdylessonlearttbl .edit").each(function (obj) {
            //    // debugger;
            //    var controlid = $(this.id);
            //    var ID = controlid.split("_");
            //    $("#" + controlid).prop("disabled", false);
            //   // $("#" + controlid).prop("disabled", true);
            //});
            //End Of Commented By Usha Pandit On 30.06.2020 For javascript error on cancel button click
        }

        function DeleteLessonLearntData(LessonId) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectClosure/ProjectLessonsLearnedDelete',
                method: 'Post',
                data: JSON.stringify(LessonId),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (LessonId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(LessonId) ? LessonId : JSON.stringify(LessonId)));
                    }
                },
                success: function (strResult) {
                    showAlert('Lesson Learnt Deleted Successfully.', 'alert-success');
                    GetProjectLessonsLearnedDetails(ProjectID);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function ValidateAttachment(fileid, filePath) {
            var ValidateAttachmentFlag = true;
            var objFileName = document.getElementById(fileid);
            if (objFileName != null) {
                if (disallowSpecialCharacters(objFileName, 'Special character # is not allowed', true, '#')) { ValidateAttachmentFlag = false; return false; }

                if (disallowSpecialCharacters(objFileName, 'Single quotation mark is not allowed in file name', true, "'")) { ValidateAttachmentFlag = false; return false; }

                var countOfDot, FileNameCharCount;
                var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>';
                intMinFileSize = parseInt(intMinFileSize);

                //Commented & Added By Rutuja D. on 30 Dec 2020 For Check Max File Size
                //var intActualFileSize = (objFileName.files['0'].size);
                //intActualFileSize = parseInt(intActualFileSize) / 1024;
                 var intMaxFileSize = '<%=ConfigurationManager.AppSettings("MaxFileSize")%>'
                 //End of Commented & Added By Rutuja D. on 30 Dec 2020 For Check Max File Size
                var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>';
                var validateExtensions;

                 //Commented & Added By Rutuja D. on 30 Dec 2020 For Validate Multiple Attachment File

                //if (objFileName.files['0'].name != '')
                //    var countOfDot = objFileName.files['0'].name.split(".").length - 1;

                //if (countOfDot > 1) {
                //    showAlert('File with two or more extensions is not allowed!', 'alert-danger');
                //    ValidateAttachmentFlag = false;
                //    return false;
                //}
                //if (objFileName.files['0'].name != '')
                //    FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

                //if (FileNameCharCount > 120) {
                //    showAlert('File name should not exceed 120 characters!', 'alert-danger');
                //    ValidateAttachmentFlag = false;
                //    return false;
                //}

                //if (intActualFileSize > intMinFileSize) {
                //    showAlert('File size should not be greater than or equal to ' + intMinFileSize + ' KB !', 'alert-danger');
                //    ValidateAttachmentFlag = false;
                //    return false;
                //}
                for (var i = 0; i < objFileName.files.length; i++) {
                    var intActualFileSize = (objFileName.files[i].size);
                    if (objFileName.files[i].name != '')
                        var countOfDot = objFileName.files[i].name.split(".").length - 1;

                    if (objFileName.files[i].name != '')
                        var countOfDot = objFileName.files[i].name.split(".").length - 1;

                    if (countOfDot > 1) {
                        showAlert('File with two or more extensions is not allowed!', 'alert-danger');
                        ValidateAttachmentFlag = false;
                        return false;
                    }
                    if (objFileName.files[i].name != '')
                        FileNameCharCount = objFileName.files[i].name.split(".")[0].length;

                    if (FileNameCharCount > 120) {
                        showAlert('File name should not exceed 120 characters!', 'alert-danger');
                        ValidateAttachmentFlag = false;
                        return false;
                    }

                    if (intActualFileSize < intMinFileSize) {
                        showAlert('File size should be greater than or equal to ' + intMinFileSize + ' KB !', 'alert-danger');
                        ValidateAttachmentFlag = false;
                        return false;

                    }

                    if (intMaxFileSize < intActualFileSize) {
                        showAlert('File size should not be greater than or equal to ' + intMaxFileSize + ' bytes !', 'alert-danger');
                        ValidateAttachmentFlag = false;
                        return false;

                    }
                }
                 //End Of Commented & Added By Rutuja D. on 30 Dec 2020 For Validate Multiple Attachment File
            }
            return ValidateAttachmentFlag;
        }



        //omkar code end



        //*********************************************************************************************************************
        //Chetan Muley code starts from here

        //Get the team data of the project
        function GetProjectTeamData(ProjectID) {
            var param = JSON.stringify(encodeURI(ProjectID));
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetProjectTeamData", param, false);
            $("#tblProjectTeamTbody").html('');
            var strHTML = "";
            $("#tblProjectTeam").dataTable().fnDestroy();
            for (var i = 0; i < strResult.length; i++) {
                var EmployeeName = strResult[i].EMPLOYEENAME;
                var RoleDescription = strResult[i].ROLEDESCRIPTION;
                var StartDate = strResult[i].FROMDATE;
                var EndDate = strResult[i].TODATE;
                //if (EmployeeName == null) {
                //    EmployeeName = "Not Specified";
                //}
                //if (RoleDescription == null) {
                //    RoleDescription ="Not Specified";
                //}
                //if (StartDate == null) {
                //    StartDate="Not Specified";
                //}
                //if (EndDate == null) {
                //    EndDate = "Not Specified";
                //}

                if (EmployeeName == null) {
                    EmployeeName = "";
                }
                if (RoleDescription == null) {
                    RoleDescription = "";
                }
                if (StartDate == null) {
                    StartDate = "";
                }
                if (EndDate == null) {
                    EndDate = "";
                }
                //End of addition by Chetan M. on 9th Dec 2019.

                //Added By Dipali V On 20th Nov 2019 For Work Hrs Should Display Prorperly
                var Hrs
                if (strResult[i].ESTHOURS == 0 || strResult[i].ESTHOURS == null) {
                    Hrs = "00.00";

                } else {
                    Hrs = strResult[i].ESTHOURS;
                }

                var AHrs
                if (strResult[i].ACTUALHOURS == 0 || strResult[i].ACTUALHOURS == null) {
                    AHrs = "00.00";

                } else {
                    AHrs = strResult[i].ACTUALHOURS;
                }

                //End of Added By Dipali V On 20th Nov 2019 For Work Hrs Should Display Prorperly
                strHTML += '<tr>'
                strHTML += '<td> ' + EmployeeName + '</td>'
                strHTML += '<td> ' + RoleDescription + '</td>'
                strHTML += '<td> ' + StartDate + '</td>'
                strHTML += '<td> ' + EndDate + '</td>'
                strHTML += '<td> ' + Hrs + '</td>'
                strHTML += '<td> ' + AHrs + '</td>'
                strHTML += '</tr>'
            }
            $("#tblProjectTeamTbody").html("");
            $("#tblProjectTeamTbody").append(strHTML);
            Pagination("#tblProjectTeam");
            if (strHTML == "") {
                Setcolspan("#tblProjectTeam", 6);
                // $("#tblProjectTeam tbody tr td").prop("colspan", 6);
            }
        }


        //Get the Hardware data for the project
        function GetHardwareUsed(ProjectID) {
            var param = JSON.stringify(encodeURI(ProjectID));
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetHardwareUsed", param, false);
            $("#tblHardwareUsedTbody").html('');
            $("#tblHardwareUsed").dataTable().fnDestroy();
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                //Added By Dipali V On 20th Nov 2019 For Null value Should Display Properly
                var MachineName, Configuration, UsedAs, EmployeeName;
                if (strResult[i].MachineName == null) {
                    MachineName = "Not Specified";
                }
                else {
                    MachineName = strResult[i].MachineName;
                }

                if (strResult[i].Configuration == null) {
                    Configuration = "Not Specified";
                }
                else {
                    Configuration = strResult[i].Configuration;
                }
                if (strResult[i].UsedAs == null) {
                    UsedAs = "Not Specified";
                }
                else {
                    UsedAs = strResult[i].UsedAs;
                }

                if (strResult[i].EmployeeName == null) {
                    EmployeeName = "Not Specified";
                }
                else {
                    EmployeeName = strResult[i].EmployeeName;
                }
                //End of Added By Dipali V On 20th Nov 2019 For Null value Should Display Properly
                strHTML += '<tr>'
                strHTML += '<td> ' + strResult[i].MachineName + '</td>'
                strHTML += '<td> ' + Configuration + '</td>'
                strHTML += '<td> ' + UsedAs + '</td>'
                strHTML += '<td> ' + EmployeeName + '</td>'
                strHTML += '</tr>'
            }
            $("#tblHardwareUsedTbody").html("");
            $("#tblHardwareUsedTbody").append(strHTML);
            Pagination("#tblHardwareUsed");
            if (strHTML == "") {
                Setcolspan("#tblHardwareUsed", 4);
                //$("#tblHardwareUsed tbody tr td").prop("colspan", 4);
            }
        }

        //Get the Tools which is used for the project.
        function GetToolsUsed(ProjectID) {
            var param = JSON.stringify(encodeURI(ProjectID));
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetToolsUsed", param, false);
            $("#tblToolUsedTbody").html('');
            $("#tblToolUsed").dataTable().fnDestroy();
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                strHTML += '<tr>'
                strHTML += '<td> ' + strResult[i].ToolType + '</td>'
                strHTML += '<td> ' + strResult[i].Tool + '</td>'
                strHTML += '</tr>'
            }
            $("#tblToolUsedTbody").html("");
            $("#tblToolUsedTbody").append(strHTML);
            Pagination("#tblToolUsed");
            if (strHTML == "") {
                Setcolspan("#tblToolUsed", 2);
                //$("#tblToolUsed tbody tr td").prop("colspan", 2);
            }
        }

        //Added by Chetan M. on 17th Dec 2019
        function GetReusableItems(ProjectID) {
            var param = JSON.stringify(encodeURI(ProjectID));
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetReusableItems", param, false);
            $("#tblReusableItemsTbody").html('');
            $("#tblReusableItems").dataTable().fnDestroy();
            var strHTML = "";
            var PROCEDURECOMMENT, PROCEDUREPRESET, CATEGORYDESCRIPTION, PROCEDUREAPPLIANCES;
            for (var i = 0; i < strResult.length; i++) {
                if (strResult[i].PROCEDURECOMMENT == null) {
                    PROCEDURECOMMENT = "Not Specified";
                }
                else {
                    PROCEDURECOMMENT = strResult[i].PROCEDURECOMMENT;
                }

                if (strResult[i].PROCEDUREPRESET == null) {
                    PROCEDUREPRESET = "Not Specified";
                }
                else {
                    PROCEDUREPRESET = strResult[i].PROCEDUREPRESET;
                }

                if (strResult[i].CATEGORYDESCRIPTION == null) {
                    CATEGORYDESCRIPTION = "Not Specified";
                }
                else {
                    CATEGORYDESCRIPTION = strResult[i].CATEGORYDESCRIPTION;
                }
                if (strResult[i].PROCEDUREAPPLIANCES == null) {
                    PROCEDUREAPPLIANCES = "Not Specified";
                }
                else {
                    PROCEDUREAPPLIANCES = strResult[i].PROCEDUREAPPLIANCES;
                }

                strHTML += '<tr>'
                strHTML += '<td> ' + strResult[i].PROCEDURETITLE + '</td>'
                strHTML += '<td> ' + PROCEDURECOMMENT + '</td>'
                strHTML += '<td> ' + PROCEDUREPRESET + '</td>'
                strHTML += '<td> ' + CATEGORYDESCRIPTION + '</td>'
                strHTML += '<td> ' + PROCEDUREAPPLIANCES + '</td>'
                strHTML += '<td> ' + strResult[i].DATECREATED + '</td>'
                strHTML += '<td> ' + strResult[i].EMPLOYEENAME + '</td>'
                strHTML += '</tr>'
            }
            $("#tblReusableItemsTbody").html("");
            $("#tblReusableItemsTbody").append(strHTML);
            Pagination("#tblReusableItems");
            if (strHTML == "") {
                Setcolspan("#tblReusableItems", 7);
                //$("#tblToolUsed tbody tr td").prop("colspan", 2);
            }
        }
        //End of addition by Chetan M. on 17th Dec 2019

        //Get the lessions learned data for the project.
        function GetLessonsLearned(ProjectID) {
            var param = JSON.stringify(encodeURI(ProjectID));
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetProjectLessonsLearnedDetails", param, false);
            $("#tblLessonsLearnedTbody").html('');
            $("#tblLessonsLearned").dataTable().fnDestroy();
            var strHTML = "";
            var LessonsLearnedDetails = strResult.LessonLearntData;
            var LessonLearntDocument = strResult.LessonLearntDocument;
            for (var i = 0; i < LessonsLearnedDetails.length; i++) {
                var LessonId = LessonsLearnedDetails[i].LessonId;
                strHTML += '<tr>'
                strHTML += '<td> ' + LessonsLearnedDetails[i].ProblemType + '</td>'
                strHTML += '<td> ' + LessonsLearnedDetails[i].ProblemDescription + '</td>'
                strHTML += '<td> ' + LessonsLearnedDetails[i].Solution + '</td>'
                strHTML += '<td> ' + LessonsLearnedDetails[i].PreventiveAction + '</td>'
                //strHTML += '<td> ' + strResult[i].ReferedDocument + '</td>'
                var strFile = "";
                for (var j = 0; j < LessonLearntDocument.length; j++) {
                    //  debugger;
                    var Lessonid = LessonLearntDocument[j]["LessonId"];
                    var DocumentID = LessonLearntDocument[j]["DocumentID"];
                    var filename = LessonLearntDocument[j]["OriginalFileName"];
                    if (Lessonid == LessonId) {
                        if (strFile == "") {
                            strFile = filename;
                        }
                        else {

                            strFile = strFile + "," + filename;
                        }
                        //} else {
                        //    strFile = 'Not Specified';
                        //}
                    }
                }

                strHTML += '<td> ' + strFile + '</td>'
                strHTML += '</tr>'
            }

            $("#tblLessonsLearnedTbody").html("");
            $("#tblLessonsLearnedTbody").append(strHTML);
            Pagination("#tblLessonsLearned");
            if (strHTML == "") {
                Setcolspan("#tblLessonsLearned", 5);
                //$("#tblLessonsLearned tbody tr td").prop("colspan", 5);
            }
        }

        //Get effort distribution data for the project.
        function GetEffortDistribution(ProjectID) {
            //alert(ProjectID);
            var param = JSON.stringify(encodeURI(ProjectID));
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetEffortDistribution", param, false);
            $("#tblEffortDistributionTbody").html('');
            $("#tblEffortDistribution").dataTable().fnDestroy();
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var ActualEffort, EstEffortHours, ActualEffortHours, Effort;
                //  debugger;
                if (strResult[i].ActualEffort != null || strResult[i].ActualEffort != "" || strResult[i].ActualEffort != "0") {
                    ActualEffort = strResult[i].ActualEffort;
                    //ActualEffort = strResult[i].ActualEffort;

                }
                else {
                    ActualEffort = "00:00";

                }


                if (strResult[i].EstEffortHours != null || strResult[i].EstEffortHours != "" || strResult[i].EstEffortHours != "0") {
                    // EstEffortHours = strResult[i].EstEffortHours.toFixed(2);
                    EstEffortHours = strResult[i].EstEffortHours;

                }
                else {
                    EstEffortHours = "00:00";

                }

                if (strResult[i].ActualEffortHours != null || strResult[i].ActualEffortHours != "" || strResult[i].ActualEffortHours != "0") {
                    ActualEffortHours = strResult[i].ActualEffortHours;
                    //ActualEffortHours = strResult[i].ActualEffortHours;

                }
                else {
                    ActualEffortHours = "00:00";

                }


                if (strResult[i].VarianceHours != null || strResult[i].VarianceHours != "" || strResult[i].VarianceHours != "0") {
                    //VarianceHours = strResult[i].VarianceHours.toFixed(2);
                    VarianceHours = strResult[i].VarianceHours;

                }
                else {
                    VarianceHours = "00:00";

                }


                if (strResult[i]["Est.Effort"] != null || strResult[i]["Est.Effort"] != "" || strResult[i]["Est.Effort"] != "0") {
                    Effort = strResult[i]["Est.Effort"];

                }
                else {
                    Effort = "00:00";

                }


                strHTML += '<tr>'
                strHTML += '<td> ' + strResult[i].ModuleName + '</td>'
                strHTML += '<td> ' + Effort + '</td>'
                strHTML += '<td> ' + ActualEffort + '</td>'
                strHTML += '<td> ' + strResult[i].Variance + '</td>'
                strHTML += '<td> ' + EstEffortHours + '</td>'
                strHTML += '<td> ' + ActualEffortHours + '</td>'
                strHTML += '<td> ' + VarianceHours + '</td>'
                strHTML += '</tr>'
            }
            $("#tblEffortDistributionTbody").html("");
            $("#tblEffortDistributionTbody").append(strHTML);
            Pagination("#tblEffortDistribution");
            if (strHTML == "") {
                Setcolspan("#tblEffortDistribution", 7);
                //$("#tblEffortDistribution tbody tr td").prop("colspan", 5);
            }
        }

        //Function for set the pagination to the table
        function Pagination(TblId) {
            $(TblId).DataTable({
                "pageLength": 5,
                "scrollY": 150,
                "scrollCollapse": false,
                "scrollX": true,
                "lengthChange": false,
                "bFilter": false,
                "ordering": true,
                "responsive": true,
            });
        }

        // Function to set the colspan if table is empty.
        function Setcolspan(tblId, ColumnNo) {
            var Selector = tblId + " tbody tr td";
            $(Selector).prop("colspan", ColumnNo);
        }

        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl + url),
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
                },
                error: function (err) {
                    ajaxResult = undefined;
                }
            });
            return ajaxResult;
        }

        //Function for show the alert.
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
            $('.ClosaeblealertMsg').delay(3500).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }

        //Function for close the alert popup.
        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }

        //Function for get the checklist data for current project.
        var ProjectCheckListID;
        function GetPublishedCheckList(ProjectID) {
            var param = JSON.stringify(encodeURI(ProjectID));
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetPublishedCheckList", param, false);
            if (strResult.length == 0) {
                Nochecklist = 1;
                $("#Checklist").css("display", "none");
                if (ProjectOver == 0) {
                    $("#ChecklistName").html("<div class='chcklistwarningmsg'><div class='alert alert-warning fade show alert-dismissible'>Checklist was not defined for selected project.</div></div>");
                }
                else {
                    $("#ChecklistName").html("<div class='chcklistwarningmsg'><div class='alert alert-warning fade show alert-dismissible'>Checklist data was not available for selected project.</div></div>");
                }

                //Commented and added by Chetan M. on 6th Dec 2019
                //$("#NegativeResponceNote,#tblChecklistThead,#btnSaveCheckList").hide();
                $("#NegativeResponceNote,#btnSaveCheckList").hide();
                if (m_PM_ProjectClosureblnAddAccess == "False") {
                    $("#btnSaveCheckList").hide();
                }
                //End of addition By Chetan M.

                $("#NegativeResponceNote,#tblChecklistThead,#btnSaveCheckList").hide();
            }
            else {
                ProjectCheckListID = strResult[0].ProjectCheckListID;
                var CheckListName = strResult[0].CheckListShortName;
                if (CheckListName.length < 40) {
                    $("#ChecklistName").html(CheckListName);
                    $("#ChecklistName").attr("data-original-title", "");
                    $("#ChecklistName").attr("data-original-title", CheckListName);
                    $("#ChecklistName").attr('data-bs-toggle', 'tooltip');
                    $("#ChecklistName").attr('data-bs-placement', 'bottom');
                }
                else {
                    var str = CheckListName.substring(0, 40);
                    $("#ChecklistName").html(str);
                    $("#ChecklistName").attr("data-original-title", "");
                    $("#ChecklistName").attr("data-original-title", CheckListName);
                    $("#ChecklistName").attr('data-bs-toggle', 'tooltip');
                    $("#ChecklistName").attr('data-bs-placement', 'bottom');
                }
                PloatChecklist(ProjectCheckListID);
            }
        }


        //Function for to get the All data for ploating the Checklist.
        function PloatChecklist(ProjectCheckListID) {
            var ClosureParameter = {
                ProjectCheckListId: encodeURI(ProjectCheckListID),
                ContextID: encodeURI(ProjectID),
                RespondedBy: encodeURI(LoggedPerson)
            }
            var param = JSON.stringify(ClosureParameter);
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetCheckListData", param, false);
            var strHTML = "";

            //Commented And Added By Usha Pandit On 02.07.2020 For crash if checklist data not exists
            //GblDescription = strResult[0].Description;
            //GblCheckListItemName = strResult[0].CheckListItemName;
            //GblSingleSelection = strResult[0].SingleSelection;
            //lngTempQuestionID = strResult[0].ProjectChecklistItemId;

            if (strResult.length > 0) {
                GblDescription = strResult[0].Description;
                GblCheckListItemName = strResult[0].CheckListItemName;
                GblSingleSelection = strResult[0].SingleSelection;
                lngTempQuestionID = strResult[0].ProjectChecklistItemId;
            }
            //End Of Added By Usha Pandit On 02.07.2020 For crash if checklist data not exists

            //strHTML += '<thead width="100%"><tr><th style="background-color:white">' + GblDescription + '</th></tr></thead>';
            // Added By Chetan M. on 6 Dec 2019
            $("#tblCheckList").empty();
            theadHTML = '';
            theadHTML += '<thead>'
            theadHTML += '<tr>'

            //Commented and added by Chetan M. on 12th Dec 2019 for align the Checklist header proper
            <%--theadHTML += '<th class="text-start" width="40%"><%= MyBase.GetResourceString("C_CheckList_Item")%></th>'--%>
            theadHTML += '<th width="40%" class="text-start"><%= MyBase.GetResourceString("C_CheckList_Item")%></th>'
            //End of commented and added by Chetan M. on 12th Dec 2019

            theadHTML += '<th width="30%" class="text-start"><%= MyBase.GetResourceString("C_Responces")%></th>'
            theadHTML += '<th class="text-start"><%= MyBase.GetResourceString("C_Remark")%></th>'
            theadHTML += '</tr>'
            theadHTML += '</thead>'
            $("#tblCheckList").append(theadHTML);
            // End of Addition By Chetan M.

            //Commented and added By Chetan M. on 6 Dec 2019
            //strHTML += '<thead width="100%"><tr><th style="background-color:white">' + GblDescription + '</th></tr></thead>';
            strHTML += '<thead width="100%"><tr><th colspan="3" class="text-start">' + GblDescription + '</th></tr></thead>';
            //End of addition by Chetan M.
            for (var i = 0; i < strResult.length; i++) {
                if (strResult != "" && strResult != undefined) {
                    var Description = strResult[i].Description;
                    var CheckListItemName = strResult[i].CheckListItemName;
                    if (GblDescription != Description) {
                        if (Description != "") {
                            GblDescription = Description;

                            //Commented and added By Chetan M. on 6 Dec 2019
                            //strHTML += '<thead width="100%"><tr><th style="background-color:white">' + Description + '</th></tr></thead>';
                            strHTML += '<thead width="100%"><tr><th colspan="3" class="text-start">' + Description + '</th></tr></thead>';
                            //End of addition by Chetan M.
                        }
                    }

                    if (GblCheckListItemName != CheckListItemName) {
                        if (CheckListItemName != "") {
                            if (strResult[i].Compulsory == true) {
                                strHTML += '<tr>';
                                strHTML += '<td><div class="cl_question" id="' + strResult[i].ProjectChecklistItemId + '"><span style="color: red;">* </span>' + CheckListItemName + '</div></td>';
                            }
                            else {
                                strHTML += '<tr>';
                                strHTML += '<td><div class="cl_question" id="' + strResult[i].ProjectChecklistItemId + '">' + CheckListItemName + '</div></td>';
                            }
                            for (var j = 0; j < strResult.length; j++) {
                                if (lngTempQuestionID == strResult[j].ProjectChecklistItemId) {
                                    GblJval = j;
                                    if (strResult[j].MultipleSelection == true) {
                                        strBtnName = "chkOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;
                                        strQuestionWithOption += '<div class="custom_chckbox">';
                                        var Responses = strResult[j].Responses;
                                        Responses = Responses.substring(1, Responses.length);
                                        Responses = Responses.substring(0, Responses.length - 1)
                                        var ArrResponce = Responses.split(',');
                                        for (var k = 0; k < ArrResponce.length; k++) {
                                            Responses = ArrResponce[k];
                                            if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses) {
                                                GblResponseval = Responses;
                                                strQuestionWithOption += '<input type="checkbox" id="' + strBtnName + '" class="" value="' + strResult[j].QuestionnaireOptionID + '" checked>';
                                            }
                                        }
                                        if (strResult[j].QuestionnaireOptionID != GblResponseval) {
                                            strQuestionWithOption += '<input type="checkbox" id="' + strBtnName + '" class="" value="' + strResult[j].QuestionnaireOptionID + '">';
                                        }
                                        strQuestionWithOption += '<label for="' + strBtnName + '"><span></span>' + strResult[j].OptionDescription + '</label></div>';

                                    }
                                    if (strResult[j].SingleSelection == true) {



                                        strBtnName = "optOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;

                                        strQuestionWithOption += '<div class="checkbox-inline custom_radio">';
                                        var Responses = strResult[j].Responses;
                                        Responses = Responses.replace(/,/g, "");
                                        if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses) {
                                            strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" checked>';
                                        }
                                        else {
                                            strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '">';
                                        }
                                        if (strResult[j].IsNegative == true) {
                                            strQuestionWithOption += '<label for="' + strBtnName + '"><span></span><b>' + strResult[j].OptionDescription + '</b></label></div>';
                                        }
                                        else {
                                            strQuestionWithOption += '<label for="' + strBtnName + '"><span></span>' + strResult[j].OptionDescription + '</label></div>';
                                        }
                                    }
                                }
                                else {

                                }
                            }
                            if (strResult[i].ShowComment == true) {
                                if (strResult[i].Remarks != null) {
                                    if (strResult[i].SingleSelection == true) {
                                        strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="10" autocomplete="off">' + strResult[i].Remarks + '</textarea></td>';
                                    }
                                    if (strResult[i].MultipleSelection == true) {
                                        strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="200" autocomplete="off">' + strResult[i].Remarks + '</textarea></td>';
                                    }
                                }
                                else {
                                    if (strResult[i].SingleSelection == true) {
                                        strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="10" autocomplete="off"></textarea></td>';
                                    }
                                    if (strResult[i].MultipleSelection == true) {
                                        strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="200" autocomplete="off"></textarea></td>';
                                    }
                                }
                            }
                        }
                        if (GblJval + 1 < strResult.length) {
                            lngTempQuestionID = strResult[GblJval + 1].ProjectChecklistItemId;
                        }
                    }
                    else {
                        if (GblCheckListItemName != "") {
                            if (strResult[i].Compulsory == true) {
                                strHTML += '<tr>';
                                strHTML += '<td><div class="cl_question" id="' + strResult[i].ProjectChecklistItemId + '"><span style="color: red;">* </span>' + GblCheckListItemName + '</div></td>';
                            }
                            else {
                                strHTML += '<tr>';
                                strHTML += '<td><div class="cl_question" id="' + strResult[i].ProjectChecklistItemId + '">' + GblCheckListItemName + '</div></td>';
                            }

                            for (var j = 0; j < strResult.length; j++) {
                                if (lngTempQuestionID == strResult[j].ProjectChecklistItemId) {
                                    GblJval = j;
                                    if (strResult[j].MultipleSelection == true) {
                                        strBtnName = "chkOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;
                                        strQuestionWithOption += '<div class="custom_chckbox">';

                                        var Responses = strResult[j].Responses;
                                        Responses = Responses.substring(1, Responses.length);
                                        Responses = Responses.substring(0, Responses.length - 1)
                                        var ArrResponce = Responses.split(',');
                                        for (var k = 0; k < ArrResponce.length; k++) {
                                            Responses = ArrResponce[k];
                                            if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses) {
                                                GblResponseval = Responses;
                                                strQuestionWithOption += '<input type="checkbox" id="' + strBtnName + '" class="" value="' + strResult[j].QuestionnaireOptionID + '" checked>';
                                            }
                                        }
                                        if (strResult[j].QuestionnaireOptionID != GblResponseval) {
                                            strQuestionWithOption += '<input type="checkbox" id="' + strBtnName + '" class="" value="' + strResult[j].QuestionnaireOptionID + '">';
                                        }
                                        strQuestionWithOption += '<label for="' + strBtnName + '"><span></span>' + strResult[j].OptionDescription + '</label></div>';
                                    }
                                    if (strResult[j].SingleSelection == true) {
                                        // strBtnName = "optOption" + strResult[j].OptionDescription + strResult[j].ProjectChecklistItemId;
                                        //Commented and Added By Chetan M. on 6 Dec 2019
                                        //strBtnName = "optOption" + strResult[j].OptionDescription + strResult[j].ProjectChecklistItemId;
                                        strBtnName = "optOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;
                                        //End of the Adiition By Chetan M.
                                        strQuestionWithOption += '<div class="checkbox-inline custom_radio">';
                                        var Responses = strResult[j].Responses;
                                        Responses = Responses.replace(/,/g, "");
                                        if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses) {
                                            strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" checked>';
                                        }
                                        else {
                                            strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '">';
                                        }
                                        if (strResult[j].IsNegative == true) {
                                            strQuestionWithOption += '<label for="' + strBtnName + '"><span></span><b>' + strResult[j].OptionDescription + '</b></label></div>';
                                        }
                                        else {
                                            strQuestionWithOption += '<label for="' + strBtnName + '"><span></span>' + strResult[j].OptionDescription + '</label></div>';
                                        }
                                    }
                                }
                                else {

                                }
                            }
                            if (strResult[i].ShowComment == true) {
                                if (strResult[i].Remarks != null) {
                                    if (strResult[i].SingleSelection == true) {
                                        strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="10">' + strResult[i].Remarks + '</textarea></td>';
                                    }
                                    if (strResult[i].MultipleSelection == true) {
                                        strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="200">' + strResult[i].Remarks + '</textarea></td>';
                                    }
                                }
                                else {
                                    if (strResult[i].SingleSelection == true) {
                                        strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="10"></textarea></td>';
                                    }
                                    if (strResult[i].MultipleSelection == true) {
                                        strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="200"></textarea></td>';
                                    }
                                }
                            }
                        }
                        if (GblJval + 1 < strResult.length) {
                            lngTempQuestionID = strResult[GblJval + 1].ProjectChecklistItemId;
                        }
                    }
                    if (strHTML != "" && strQuestionWithOption != "") {
                        strHTML += '<td>' + strQuestionWithOption + '</td>' + strShowComment + '</tr>';
                        $("#tblCheckList").append(strHTML);
                        strHTML = '';
                        strQuestionWithOption = '';
                        strShowComment = '';
                        GblResponseval = 0;
                    }
                }
            }
        }


        var ProjectCheckListItemID = new Array();
        var AllSelectedval = "";
        //Added by Chetan M. on 13th Dec 2019
        var ChecklistFlag = 0;
        //End of addition by Chetan M. on 13th Dec 2019
        //Function for save the Checklist Responses.
        function SaveCheckListResponse() {

            ProjectCheckListItemID.length = 0;
            var TableRows = $('#tblCheckList > tbody > tr');
            for (var i = 0; i < TableRows.length; i++) {
                var RowData = TableRows[i].innerHTML;
                var Td = $(RowData).first();

                var QuestionID = Td[0].childNodes[0].id;

                var ResponsesLength = Td.prevObject[1].childNodes.length;

                if (RowData.indexOf('type="radio"') > -1) {
                    AllSelectedval = "";
                    for (var j = 0; j < ResponsesLength; j++) {

                        var RadioButtonId = Td.prevObject[1].childNodes[j].childNodes[1].id;
                        if ($("#" + RadioButtonId).is(':checked')) {
                            var Selectedval = $("#" + RadioButtonId).val();
                            AllSelectedval += ',' + Selectedval + '';
                        }
                    }
                    if (RowData.indexOf('style="color: red;"') > -1) {
                        if (AllSelectedval == "") {
                            //Commented by Chetan M. on 13th Dec 2019
                            //StopAjaxLoader("#ProjectClosureBody");
                            //end of commented by Chetan M. on 13th Dec 2019
                            showAlert('Please respond to all mandatory checklist items.', 'alert-danger');
                            //Added by Chetan M. on 13th Dec 2019
                            ChecklistFlag = 1;
                            //End of addition by Chetan M. on 13th Dec 2019
                            ProjectCheckListItemID.length = 0;
                            break;
                        }
                    }
                    if (AllSelectedval != "") {
                        var TextboxVal = $("#txt" + QuestionID).val();
                        var FinalData = QuestionID + "=" + AllSelectedval + "=" + TextboxVal;
                        ProjectCheckListItemID.push(FinalData);
                    }
                }
                else {
                    AllSelectedval = "";
                    for (var j = 0; j < ResponsesLength; j++) {
                        var CheckBoxId = Td.prevObject[1].childNodes[j].childNodes[0].id;
                        if ($("#" + CheckBoxId).is(':checked')) {
                            var Selectedval = $("#" + CheckBoxId).val();
                            AllSelectedval += ',' + Selectedval + '';
                        }
                    }
                    if (RowData.indexOf('style="color: red;"') > -1) {
                        if (AllSelectedval == "") {
                            //Commented by Chetan M. on 13th Dec 2019
                            //StopAjaxLoader("#ProjectClosureBody");
                            showAlert('Please respond to all mandatory checkList items.', 'alert-danger');
                            //Added by Chetan M. on 13th Dec 2019
                            ChecklistFlag = 1;
                            //End of addition by Chetan M. on 13th Dec 2019
                            ProjectCheckListItemID.length = 0;
                            break;
                        }
                    }
                    if (AllSelectedval != "") {
                        var TextboxVal = $("#txt" + QuestionID).val();
                        var FinalData = QuestionID + "=" + AllSelectedval + "=" + TextboxVal;
                        ProjectCheckListItemID.push(FinalData);
                    }
                }
            }

            if (ProjectCheckListItemID.length != 0) {
                //Added by Chetan M. on 13th Dec 2019
                StartLoader("#ProjectClosureBody");
                ChecklistFlag = 0;
                //End of addition by Chetan M. on 13th Dec 2019
                DeleteCheckListeResponses();
                for (var i = 0; i < ProjectCheckListItemID.length; i++) {
                    var ObjChekListItem = ProjectCheckListItemID[i];
                    var CheckListResponseData = ObjChekListItem.split("=");
                    var ProjectChecklistItemId = CheckListResponseData[0];
                    var ResponseId = CheckListResponseData[1];

                    ResponseId = ResponseId.substring(1, ResponseId.length);
                    var Remark = CheckListResponseData[2];
                    var ArrResponce = ResponseId.split(',');
                    for (var j = 0; j < ArrResponce.length; j++) {
                        var ClosureParameter = {
                            ContextID: encodeURI(ProjectID),
                            ProjectCheckListId: encodeURI(ProjectChecklistItemId),
                            ResponseID: encodeURI(ArrResponce[j]),
                            RespondedBy: encodeURI(LoggedPerson),
                            Remarks: encodeURI(Remark)
                        }
                        var param = JSON.stringify(ClosureParameter);
                        var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/SaveCheckListResponse", param, false);
                    }
                    StopAjaxLoader("#ProjectClosureBody");
                    if (i == ProjectCheckListItemID.length - 1 && strResult == null) {
                        //Commented And Added by Usha Pandit On 14.07.2020 to prevent alert disappearing soon
                        //showAlert("Saved Responses Successfully.", 'alert-success');
                        setTimeout(function () {
                            showAlert("Saved Responses Successfully.", 'alert-success');
                        }, 500);
                        //End Of Added by Usha Pandit On 14.07.2020 to prevent alert disappearing soon
                        //Added By Chetan M. on 6 Dec 2019
                        GetPublishedCheckList(ProjectID);
                        //End of addition by Chetan M.
                    }
                }
            }
            //Added By Usha Pandit On 02.07.2020 For validating checklist response
            else {
                if (TableRows.length > 0) {
                    showAlert('Please select checklist response.', 'alert-danger');
                    ChecklistFlag = 1;
                }
            }
            //End Of Added By Usha Pandit On 02.07.2020 For validating checklist response

            //Added by Chetan M. on 13th Dec 2019
            return ChecklistFlag;
            StopAjaxLoader("#ProjectClosureBody");
            //End of addition by Chetan M. on 13th Dec 2019
        }

        //Function for delete the checklist responses.
        function DeleteCheckListeResponses() {
            var ClosureParameter = {
                ContextID: encodeURI(ProjectID),
                RespondedBy: encodeURI(LoggedPerson)
            }
            var param = JSON.stringify(ClosureParameter);
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/DeleteCheckListeResponses", param, false);
        }


        function UpdateExperienceOfResourceOnClosureOfProject(ProjectID, EmployeeID, Toolid, pYearExp, pMonthExp, blnAddToExistingExperience) {
            var ExperianceAttribute = {
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID),
                ToolID: encodeURI(Toolid),
                YearsOfExperience: encodeURI(pYearExp),
                MonthsOfExperience: encodeURI(pMonthExp),
                blnAddToExistingExperience: encodeURI(blnAddToExistingExperience)
            };

            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/PostSkillExperiance',
                method: 'Post',
                data: JSON.stringify(ExperianceAttribute),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    //if (ExperianceAttribute) {
                    //    xhr.setRequestHeader("Params", encryptString(isJson(ExperianceAttribute) ? ExperianceAttribute : JSON.stringify(ExperianceAttribute)));
                    //}
                },
                success: function (result) {

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        function GetTaskDataOfProject(ProjectID) {
            //debugger;
            var param = JSON.stringify(encodeURI(ProjectID));
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetTaskDataOfPRoject", param, false);
            return strResult;
        }


        function GetLoggedPersonInfo(EmployeeID) {
            var param = JSON.stringify(encodeURI(EmployeeID));
            var strResult = AJAXCallWithResult("/api/PM_ProjectClosure/GetLoggedPersonInfo", param, false);
            var LoggedPersonEmailID = strResult[0].EmailID;
            return LoggedPersonEmailID;
        }

        function CloseProject(ProjectID, LoggedaPersonEmailID) {
            StartLoader("#ProjectClosureBody");
            var ActualEndate = $("#txtProjectActualEnddate").val()
            var ClosureParameter = {
                ProjectID: encodeURI(ProjectID),
                LoggedaPersonEmailID: encodeURI(LoggedaPersonEmailID),
                LoggedPersonID: encodeURI(LoggedPersonID),
                ActualEndate: encodeURI(ActualEndate)
            }
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/CloseProject',
                method: 'Post',
                data: JSON.stringify(ClosureParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ClosureParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ClosureParameter) ? ClosureParameter : JSON.stringify(ClosureParameter)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        StopAjaxLoader("#ProjectClosureBody");
                        showAlert('Project Closed Successfully.', 'alert-success');
                        GetProjectOverview(ProjectID);
                        GetProjectActualEndDate(ProjectID);
                        $("#btnsendmailprojectcolser").attr('disabled', false);
                        $('.wizard .wizard-inner .nav-tabs li a.active').prev('li').addClass('Compltedstep');
                        $("#btnAddLessonLearnt,.add,#saveskill,#btntaskclosersave,#btnSaveCheckList,#add_row").attr('disabled', true);//#btnAddLessonLearnt
                        $("#tblbdylessonlearttbl>tr>td>a.nostylebtn.edit").attr('disabled', true);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        function ReopenProject() {

            if ($("#reopenRemark").val() == "") {
                showAlert('Please enter remark.', 'alert-danger');
                $("#reopenRemark").focus();//Added By Dipali V On 10th Dec 2020 For Focust to control
                return;
            }


            var reOpenProject = {
                ProjectId: ProjectID,
                Comment: $("#reopenRemark").val(),
                UserId: LoggedPersonID,
            }
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/ReopenProject',
                method: 'Post',
                data: JSON.stringify(reOpenProject),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reOpenProject) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reOpenProject) ? reOpenProject : JSON.stringify(reOpenProject)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        var Comment = $("#reopenRemark").val();
                        $("#reopenModal").modal('hide');//Added By Dipali V On 10th Dec 2020 For After saving pop up should close
                        window.open("../Email/SendEmail.aspx?MessageID=470&Comment=" + Comment, "_blank", "resizable = yes, scrollbars = no, toolbar = no, statusbar = no, left =" + (window.screen.width - 600) / 2 + ", top =" + (window.screen.height - 500) / 2 + ", width = 600, height = 500");
                        showAlert('Reopened project Successfully.', 'alert-success');
                        refresh();

                       $("#btnsendmailprojectcolser").attr('disabled', true);


                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        function Export_Click(ReportFormat) {
            var PMReportParameter = {
                ProjectId: encodeURI(ProjectID),
                ReportFormat: encodeURI(ReportFormat)
            }
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/ExportToReport',
                method: 'Post',
                data: JSON.stringify(PMReportParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMReportParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMReportParameter) ? PMReportParameter : JSON.stringify(PMReportParameter)));
                    }
                },
                success: function (result) {
                    if (result != "0") {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + result, "_report", "");
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        //added by dipali V On 26th Dec 2019 For Conformation pop up for delete documets
        var globalLessonID = "";
        //Added By Usha Pandit On 26.03.2020 For adding attachment during update
        var editLessonID = "";
        //var editAttachmentID = "";
        //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update
        var globalDocumntID = "";
        function DeleteLessonLearntDocumentalert(LessonID, DocumntID) {
            $("#deletelessonlearnt").modal('show');
            globalLessonID = LessonID;
            globalDocumntID = DocumntID;

        }

        //Added By Usha Pandit On 26.03.2020 For adding attachment during update
        function DeleteCurrentLessonLearnt(LessonID, AttachmentID) {
            editLessonID = LessonID;
            //editAttachmentID = AttachmentID;
        }
        //End Of Added By Usha Pandit On 26.03.2020 For adding attachment during update

        function DeleteLessonLearntDocument() {
            var LessonParameter = {
                LessonId: encodeURI(globalLessonID),
                DocumentID: encodeURI(globalDocumntID),
                ProjectID: encodeURI(ProjectID)
            }

            //alert(EditRowNo);
            //return;
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/DeleteLessonLearntDocument',
                method: 'Post',
                data: JSON.stringify(LessonParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (LessonParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(LessonParameter) ? LessonParameter : JSON.stringify(LessonParameter)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        //add by omkar 13/12/2019
                        showAlert('Document Deleted Successfully.', 'alert-success');
                        GetProjectLessonsLearnedDetails(ProjectID);
                       ///debugger;
                        EidtCheckValiationLessonLearnt(EditRowNo, globalLessonID);
                        $(".add-new").removeAttr("disabled");
                        globalLessonID = "";
                        globalDocumntID= "";
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
         //End of added by dipali V On 26th Dec 2019 For Conformation pop up for delete documets
        //Chetan Muley Code ends here

        //Added By Usha Pandit On 30.06.2020 For javascript error
        function Closemodal() {

        }
        //End Of Added By Usha Pandit On 30.06.2020 For javascript error
//***************************************************************************************************************************

    </script>

    <!--filter-table-->
    <script>
        $('#sortclosuretask').on('click', function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });
        $('#sortresourfce').on('click', function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });
        $('#sortplandate').on('click', function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });
        $('#sortenddate').on('click', function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        $('#sortplanwork').on('click', function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        $('.sortclm').on('click', function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });


        function comparer(index) {
            return function (a, b) {
                var valA = getCellValue(a, index),
                    valB = getCellValue(b, index)
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB)
            }
        }

        function getCellValue(row, index) {
            return $(row).children('td').eq(index).text()
        }
    </script>
    <!--filter-table-->

    <script>
        //script for pophover
        $("[data-bs-toggle=popover]").each(function (i, obj) {
            $(this).popover({
                html: true,
                "trigger": "click",
                content: function () {
                    var id = $(this).attr('id')
                    return $('#popover-content-' + id).html();
                }
            });
        });

        $('body').on('click', function (e) {
            $('[data-bs-toggle="popover"]').each(function () {
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
                    $(this).popover('hide');
                }
            });
        });

        //end script for popover

        //// Start script for search resource
        //function rsearch() {
        //    var Isdata = 0;
        //    var input, filter, ul, li, a, i, txtValue;
        //    input = document.getElementById("resourcesearch");
        //    filter = input.value.toUpperCase();
        //    ul = document.getElementById("resourcenamelist");
        //    li = ul.getElementsByTagName("li");
        //    for (i = 0; i < li.length; i++) {
        //        a = li[i].innerText;
        //        // txtValue = a.textContent || a.innerText;
        //        if (a.toUpperCase().indexOf(filter) > -1) {
        //            li[i].style.display = "";
        //            Isdata = 0;
        //             //  $("#resourcenamelist #filterNodata").css('display', 'none');
        //        } else {
        //            li[i].style.display = "none";
        //            Isdata = 1;
        //          //  $("#resourcenamelist #filterNodata").css('display', 'block');
        //        }
        //    }
        //    //   debugger;
        //    if (Isdata == 1) {
        //        $("#resourcenamelist #filterNodata").css('display', 'block');

        //    } else {
        //          $("#resourcenamelist #filterNodata").css('display', 'none');

        //    }

        //}
        // End script for search resource
        function rsearch() {
            // debugger
            var Isdata = 0;
            var input, filter, ul, li, a, i, txtValue;
            input = document.getElementById("resourcesearch");
            filter = input.value.toUpperCase();
            ul = document.getElementById("resourcenamelist");
            li = ul.getElementsByTagName("li");
            //var cloneData = $("div>#resourcenamelist #filterNodata").clone();
            for (i = 0; i < li.length; i++) {
                a = li[i].innerText;
                // txtValue = a.textContent || a.innerText;
                //add by omkar 12/12/2019
                if (a != "There is no such record found") {


                    if (a.toUpperCase().indexOf(filter) > -1) {
                        li[i].style.display = "";
                        Isdata = 0;
                        //$("div>#resourcenamelist #filterNodata").css('display', 'none');
                    } else {
                        li[i].style.display = "none";

                        Isdata = 1;


                        //  $("div>#resourcenamelist #filterNodata").css('display', 'block');
                    }
                }
                //end
            }
            //  debugger;
            //add by omkar 12/12/2019
            //add by omkar 16/12/2019
            var numOfVisibleli = $('div>ul#resourcenamelist li:visible').not("#filterNodata").length;
            if (numOfVisibleli == 0) {
                $("div>#resourcenamelist #filterNodata").css('display', 'block');
            } else {
                $("div>#resourcenamelist #filterNodata").css('display', 'none');
            }
            //end
            //if (Isdata == 1) {
            //    $("div>#resourcenamelist #filterNodata").css('display', 'block');

            //} else {
            //      $("div>#resourcenamelist #filterNodata").css('display', 'none');

            //}

        } // End script for search resource

        //Start script for table data input digits
        var inputyear = document.getElementsByClassName('inputYear'); //Get all elements with class "time"
        for (var i = 0; i < inputyear.length; i++) { //Loop trough elements
            inputyear[i].addEventListener('keyup', function () { //Add event listener to every element
                var reg = /[0-9]/;
                if (this.value.length == 4 && reg.test(this.value)) this.value = this.value + ""; //Add colon if string length > 2 and string is a number
                if (this.value.length > 4) this.value = this.value.substr(0, this.value.length - 1); //Delete the last digit if string length > 5
            });
        }

        var inputmonth = document.getElementsByClassName('inputMonth'); //Get all elements with class "time"
        for (var i = 0; i < inputmonth.length; i++) { //Loop trough elements
            inputmonth[i].addEventListener('keyup', function () { //Add event listener to every element
                var reg = /[0-9]/;
                if (this.value.length == 2 && reg.test(this.value)) this.value = this.value + ""; //Add colon if string length > 2 and string is a number
                if (this.value.length > 2) this.value = this.value.substr(0, this.value.length - 1); //Delete the last digit if string length > 5
            });
        }
        //End script for table data input digits

        //tooltip disappear
        $('[data-bs-toggle="tooltip"]').on('click', function () {
            $(".tooltip").hide();
        })


        function List_onclick() {
            window.location.href = "../PM/PM_ProjectList.aspx";

        }

        function GetProjectActualEndDate(ProjectID) {
            $.ajax({
                url: strUrl + '/api/PM_ProjectClosure/GetProjectActualEndDate',
                method: 'Post',
                data: JSON.stringify(ProjectID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                    }
                },
                success: function (result) {
                    SelectProjectActualEndate = result;
                    $("#spnACTUALENDDATE").text("");
                    $("#spnACTUALENDDATE").text(result);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        $('#txtProjectActualEnddate').datepicker({
            autoclose: true,
            changeMonth: true,
            dateFormat: 'dd M yy'

        });
        //add by omkar 13/12/2013
        function MoveToTC() {
            // debugger;
            StartLoader("#ProjectClosureBody");
            
            var cnt = $(".add_llrow").length;
            if (cnt > 0) {
                SaveLessonLearnt();
                //add by omkar 17/12/2019
            }
            else if (EditLessonLearntId != undefined || EditRowNo != undefined) {
                if (EditLessonLearntId.length != 0 && EditRowNo.length != 0) {
                    UpdateLessonLearnt(EditRowNo, EditLessonLearntId);
                } else {
                    GetProjectLessonsLearnedDetails(ProjectID);
                }
            }
            //var active = $('.wizard .wizard-inner .nav-tabs li a.active');
            //active.next().removeClass('disabled');
            //nextTab($active);
            //debugger;

            var active = $('.wizard .wizard-inner .nav-tabs li a.active');
            var nextTab1 = active.parents('li').next('li');
            var prevTab1 = active.parents('li');
            nextTab1.removeClass('disabled');
            nextTab1.find('a').tab('show');
            prevTab1.addClass('Compltedstep');
            nextTab(prevTab1);

            getProjectCloserDetails("all");
            //$('.wizard .wizard-inner .nav-tabs li a.active').prev('li').addClass('Compltedstep');
            StopAjaxLoader("#ProjectClosureBody");

        }

        function cancelToTC(str) {

            // var $active = $('.wizard .nav-tabs li.active');
            //  $active.next().removeClass('disabled');
            // prevTab($active);
            //$('.wizard .nav-tabs li.active').prev('li').removeClass('Compltedstep');

            //$('.wizard .nav-tabs li.active').prev('li').addClass('Compltedstep');

        }

        //add by omkar 17/12/2019
        function EidtCheckValiationLessonLearnt(row, LessonId) {
            selectedRow = row;
            //add by omkar 13/12/2019
            Flag1 = true;

            $('.edit').each(function () {
                ID.push(this.id);

            });
            // debugger;
            for (var i = 0; i < ID.length; i++) {
                if ($("#lessonLeanrtEdit_" + row == ID[i])) {
                    $("#lessonLeanrtEdit_" + ID[i]).prop("disabled", false);
                    $("#lessonLeanrtdelete_" + ID[i]).prop("disabled", false);
                } else {
                    $("#lessonLeanrtEdit_" + ID[i]).prop("disabled", true);
                    $("#lessonLeanrtdelete_" + ID[i]).prop("disabled", true);
                }
            }


            alertify.set('notifier', 'position', 'top-right');

            var ProblemType = $("#r" + row + "c0> select#cbo0 option:selected").text();
            var ProblemTypeval = $("#r" + row + "c0> select#cbo0 option:selected").val();
            var Description = $("#r" + row + "c1> textarea").val();
            var Solution = $("#r" + row + "c2> textarea").val();
            var PreventiveAction = $("#r" + row + "c3> textarea").val();
            var PublishToKM = $(".actioncolumn #checkPublish_" + row);
            if (PublishToKM[0].checked) {
                var PTKM = "1";
            }
            else {
                var PTKM = "0";
            }


            if (ProblemTypeval == 0) {
                showAlert('Please Select Problem Type', 'alert-danger');
                $("#r" + row + "c0> select#cbo0").focus();
                Flag1 = false;
                return false;
            }
            if ($.trim(Description).length == 0) {
                showAlert('Description should not be blank.', 'alert-danger');
                $("#r" + row + "c1> textarea").focus();
                Flag1 = false;
                return false;
            }
            if ($.trim(Solution).length == 0) {
                showAlert('Solution should not be blank.', 'alert-danger');
                $("#r" + row + "c2> textarea").focus();
                Flag1 = false;
                return false;
            }
            if ($.trim(PreventiveAction).length == 0) {
                showAlert('Preventive Action should not be blank.', 'alert-danger');
                $("#r" + row + "c3> textarea").focus();
                Flag1 = false;
                return false;
            }
            if (Flag1 = true) {
                $("#ConformationLL").modal('show');
            }
        }
        //end


        //start script - dynamically set height
        function resizeSection(tag) {
            var skill = $(window).height();
            $('.practicesettinglist .tab-pane .row .col-sm-6 .slim-scroll').css({ 'height': skill - 172 });


            var lesonlearnt = $(window).height();
            $('#step2').css({ 'height': lesonlearnt - 125, "overflow-y": "auto" });

            var closure = $(window).height();
            $('#step3').css({ 'height': closure - 125, "overflow-y": "auto" });

            var lesonlearnt = $(window).height();
            $('#step4').css({ 'height': lesonlearnt - 125, "overflow-y": "auto" });

            var closurestepsheight = $(window).height();
            $('#step5').css({ 'height': closurestepsheight - 125, "overflow-y": "auto" });

            var rskilllist = $(window).height();
            $('#resourcenamelist').css({ 'height': rskilllist - 235 });


            //lesson learn table height
            var height = $(window).height();
            $(".resizeblock_lessonlrnt").css("height", height - 200);

            var tskclosureTbl = $(window).height();
            $("#taskclosurtbl_wrapper .dataTables_scrollBody").css("height", tskclosureTbl - 280);




            ////var tabpaneheight = $(window).height();
            ////$('.wizard .tab-pane').css({ 'height': tabpaneheight - 185, "overflow-y": "auto" });

        }


        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });
        //End script - dynamically set height

        //Added by Parth.G
        //commented by Aditya J. on 25-11-2024
        //function validateDocFileForExe(file) {

        //    return new Promise((resolve, reject) => {
        //        //debugger;

        //        const reader = new FileReader();

        //        reader.onload = function (e) {
        //            const arrayBuffer = e.target.result;
        //            const uint8 = new Uint8Array(arrayBuffer);

        //            // Function to search for a specific byte sequence
        //            const containsSignature = (signature) => {
        //                for (let i = 0; i < uint8.length - signature.length + 1; i++) {
        //                    let found = true;
        //                    for (let j = 0; j < signature.length; j++) {
        //                        if (uint8[i + j] !== signature[j]) {
        //                            found = false;
        //                            break;
        //                        }
        //                    }
        //                    if (found) return true;
        //                }
        //                return false;
        //            };

        //            // Check for 'MZ' signature (common for Windows EXE files)
        //            const mzSignature = [0x4D, 0x5A]; // 'M' 'Z'
        //            if (containsSignature(mzSignature)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // Additional checks can be added here (e.g., searching for .exe strings)
        //            // Example: Check for ".exe" string in ASCII
        //            const exeString = [0x2E, 0x65, 0x78, 0x65]; // '.' 'e' 'x' 'e'
        //            if (containsSignature(exeString)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // If no signatures are found, the file is considered safe
        //            resolve();
        //        };

        //        reader.onerror = function () {
        //            reject("Error reading the file. Please try again.");
        //        };

        //        // Read the file as an ArrayBuffer
        //        reader.readAsArrayBuffer(file);
        //    });
        //}
        //End of commented by Aditya J. on 25-11-2024
        //Ended by Parth.G

        function StartLoader(bodyID) {

            var progress2 = new LoadingOverlayProgress({
                bar: {
                    "background": "#ddd",
                    "top": "50px",
                    "left": "0px",
                    "right": "0px",
                    "height": "90px",
                    "width": "90px",
                    "margin": "auto",
                    "border-radius": "15px",
                    "background": " url('../../../Whizible2.0-new/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
                },

            });
            $(bodyID).LoadingOverlay("show", {
                custom: progress2.Init()
            });
        }

        function StopLoader(bodyID) {
            jQuery(window).load(function () {
                // This gets executed when the content is loaded
                $(bodyID).LoadingOverlay("hide", {

                });
            });
        }

        function StopAjaxLoader(bodyID) {
            // This gets executed when the content is loaded
            $(bodyID).LoadingOverlay("hide", {

            });

        }

    </script>
</body>
</html>
