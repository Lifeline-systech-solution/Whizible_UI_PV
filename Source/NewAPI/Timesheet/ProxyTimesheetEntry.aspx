<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProxyTimesheetEntry.aspx.vb" Inherits="Whizible.ProxyTimesheetEntry" %>

<!DOCTYPE html>

<html>
    <%CommonFunctions.General.PlotPageHeadTag("Timesheet Entry")%> 
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%--<title>Timesheet Entry</title>--%>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet" type="text/css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css?date=<%=DateTime.Now %>">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <%--Added by Vishal Mane on 21/01/2025--%>    
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <%--Added by Vishal Mane on 21/01/2025--%>
    <%--<link href="../../../Whizible2.0-new/dist/css/custom.css?date=<%=DateTime.Now %>" rel="stylesheet" type="text/css" />--%>
    <link href="../../../Whizible2.0-new/dist/css/TimesheetEntry_custom.css?date=<%=DateTime.Now %>" rel="stylesheet" type="text/css" />
    <!-- custom style -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=1">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=6">
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />

    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">--%>
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">--%>
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">--%>
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">--%>
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">--%>
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
 
    <style>
        .accordion-button {
            background: none !important;
        }
        table.dataTable thead>tr>th.sorting_asc:before, 
        table.dataTable thead>tr>th.sorting_asc:after {
            content: "";
        }

        .showFiltersSec {
           /* background-color: #fff0e2;*/
            background-color: #fff9f4;
        }
        .white-text {
            color: white;
        }
        .green-text {
            color: green;
        }
        .statusNotSubmitted-text {
            color: #7f05c2;
        }
        .statusSubmitted-text {
            color: #00c0ef;
        }
        .sm_txt {
            font-size: 14px;            
        }

        .sm_txt_MT {
            font-size: 14px;
            text-align: center;
        }

        .custmodal .modal-content .modal-header .close {
            background: none;
        }

        .myApprovalTbl tbody tr:hover td {
            color: #122b95;
            font-weight: 500;
        }

        .btn-default, .btn-default:hover, .btn-default:active, .btn-default.hover {
            background-color: #e7e7e7;
        }

        .input_blu {
            color: #162cee;
        }

        .td_txt_bg {
            background-color: #f9f9f9cf !important;
        }

        .pro_text {
            color: #133ea1;
            font-size: 15px;
            font-weight: 500;
        }

        .txt-small {
            font-size: 9.5px;
        }

        .btn-check:checked + .btn, .btn.active, .btn.show, .btn:first-child:active, :not(.btn-check) + .btn:active {
            background-color: transparent;
        }

        .btn-check:checked + .btn, .btn.active, .btn.show, .btn:first-child:active, :not(.btn-check) + .btn:active {
            border: none;
        }

        .hist_icon {
            color: #848080de;
            font-weight: 600;
            font-size: 15px;
        }

        table thead tr th, tbody tr td {
            text-align: center;
            vertical-align: middle;
        }

        .form-control:disabled {
            background-color: #f7f7f7;
            opacity: 1;
        }

        .allTabsDivStructure .nav-tabs .nav-link {
            border-bottom: 1px solid #cdcdcd !important;
            color: #000;
            padding: 5px 25px;
        }
        .list-group {
            --bs-list-group-border-color: none;
            margin: 0px;
            padding-left: 20px;
        }

        .list-group-item::before {
            content: "?";
            margin-right: 0.75rem;
        }

        .btn-default, .btn-default:hover, .btn-default:active, .btn-default.hover {
            background-color: #eeeeee;
        }

        .btncalendar, .btncalendar:hover, .btncalendar:active, .btncalendar.hover {
            background-color: #eeeeee;
        }

        h2.accordion-header {
            min-width: 100%;
            min-height: 100%;
            line-height: 2.2;
        }

        .TaskList li {
            padding: 0;
        }

        .gc-calendar .gc-calendar-header button.prev {
            margin-left: 10px;
            position: static;
        }

        .gc-calendar .gc-calendar-header button.next {
            margin-left: 0px;
        }

        .gc-calendar .gc-calendar-header .gc-calendar-month-year {
            line-height: 0;
        }

        .gc-calendar table.calendar {
            width: 50%;
            margin: auto;
        }

        a.today {
            background-image: none;
        }

            a.today span {
                font-size: 13px !important;
                font-weight: 600 !important;
                color: #4263c1 !important;
            }

        .gc-calendar .gc-calendar-header {
            display: block;
        }
        /* .bootstrap-select>.dropdown-toggle{
        width: 110px;
    } */
        .weekly_calender .form-control {
            padding: 6px;
        }

        .TimesheetTbl tbody tr:last-child td {
            border-bottom: 1px solid #ddd !important;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 15px;
        }

        .slider:before {
            transform: translateX(-15px);
        }

        input:checked + .slider:before {
            transform: translateX(15px);
        }

        .switch2 {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 15px;
        }

        .slider2:before {
            /* transform: translateX(-20px); */
            transform: translateX(-35px);
        }

        input:checked + .slider2:before {
            /* transform: translateX(20px); */
            transform: translateX(3px);
        }

        #CopyPrevWeek[disabled] + span.slider {
            cursor: no-drop;
        }

        .popover-body {
            min-width: 300px;
            overflow-y: auto; /*Added by Ajit*/
        }

        .alertify-notifier {
            z-index: 99999 !important;
        }
        /*.custmodal .modal-content .modal-header .close{background: transparent; top:8px;}*/
        .bootstrap-select .dropdown-menu {
            max-width: 100%;
        }

        /*Added by Ajit*/
        .wordBreak {
            word-break: break-word;
        }

        .userStoryInput {
            border: none
        }

        .edtTimeInputStoryPoint {
            text-align: center;
        }

        .popover {
            max-height: 250px;
            max-width: 400px;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .btn-close {
            background: transparent url("../../../Whizible2.0-new/dist/img/close-black.svg") center/1em auto no-repeat;
            /*background-image: url("../../../Whizible2.0-new/dist/img/close-black.svg");*/
        }
        .SearchField label{
            word-break: break-word;
        }
        @media screen and (max-width: 767px) {
            .DWnoumber {
                width: 210px;
            }
        }
        body {
            overflow-y: auto !important;
            padding-right: 0 !important;
        }
        #TimesheetInfoTbl{
            border-collapse: separate;
            border-spacing: 0 0;
        }

        /*This style section refers to Unauthorized div added by Vishal Mane on 03/10/2025 */
        .container_Access {
            width: 100%;
            height: 100vh; /* full viewport height */
            display: flex;
            flex-direction: column;
            justify-content: center; /* center content vertically */
            align-items: center;     /* center content horizontally */
            background: #f9f9f9;     /* optional: light background */
            padding: 20px;
            box-sizing: border-box;
        }

        .icon-container {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
            position: relative;
        }

        .icon-circle {
            width: 5rem;
            height: 5rem;
            background: linear-gradient(135deg, #3b82f6, #6366f1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
            animation: float 3s ease-in-out infinite;
            position: relative;
            z-index: 2;
        }

        .icon-circle::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, #3b82f6, #6366f1);
            border-radius: 50%;
            animation: pulse-glow 2s ease-in-out infinite;
            opacity: 0.3;
            z-index: -1;
        }

        .icon-circle svg {
            width: 2.5rem;
            height: 2.5rem;
            color: white;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 0.75rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(226, 232, 240, 0.8);
            padding: 2rem;
        }

        .header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .header h1 {
            font-size: 1.875rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.75rem;
        }

        .header p {
            font-size: 1.125rem;
            color: #64748b;
            line-height: 1.75;
        }

        .instructions-section {
            background: rgba(248, 250, 252, 0.5);
            border-radius: 0.5rem;
            padding: 1.5rem;
            border: 1px solid #e2e8f0;
        }

        .instructions-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }

        .warning-icon {
            width: 2rem;
            height: 2rem;
            background: rgba(251, 191, 36, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .warning-icon svg {
            width: 1rem;
            height: 1rem;
            color: #f59e0b;
        }

        .instructions-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #0f172a;
        }

        .instructions-content {
            color: #64748b;
        }

        .instructions-content p {
            margin-bottom: 1rem;
            line-height: 1.75;
        }

        .access-box {
            background: rgba(255, 255, 255, 0.5);
            border-radius: 0.375rem;
            padding: 1rem;
            border: 1px solid rgba(226, 232, 240, 0.5);
            margin: 1rem 0;
        }

        .access-box p:first-child {
            font-weight: 500;
            color: #0f172a;
            margin-bottom: 0.5rem;
        }

        .contact-box {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
            padding: 1rem;
            background: rgba(59, 130, 246, 0.05);
            border-radius: 0.375rem;
            border: 1px solid rgba(59, 130, 246, 0.2);
            margin-top: 1rem;
        }

        .contact-box svg {
            width: 1.25rem;
            height: 1.25rem;
            color: #3b82f6;
            margin-top: 0.125rem;
            flex-shrink: 0;
        }

        .contact-content p:first-child {
            color: #0f172a;
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .contact-content p:last-child {
            font-size: 11.5px;
            /* Modified By Madhuri.K On 26-03-2026 */
            line-height: 1.75;
        }

        .config-path {
            font-weight: 600;
            color: #3b82f6;
        }

        .footer {
            margin-top: 1.5rem;
            text-align: center;
        }

        .footer p {
            font-size: 11.5px;
            color: #64748b;
            /* Modified By Madhuri.K On 26-03-2026 */
        }

        .support-link {
            color: #3b82f6;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .support-link:hover {
            color: #2563eb;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 20px rgba(59, 130, 246, 0.3); }
            50% { box-shadow: 0 0 30px rgba(59, 130, 246, 0.5); }
        }

        @media (max-width: 640px) {
            .card {
                padding: 1.5rem;
            }
    
            .header h1 {
                font-size: 1.5rem;
            }
    
            .header p {
                font-size: 1rem;
            }
    
            .contact-box {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
        /*End of This style section refers to Unauthorized div added by Vishal Mane on 03/10/2025 */

                .dropdown-menu {
                    z-index: 1050;
                }
 
.dropdown-menu textarea {
    background-color: #fff;
    z-index: 1051;
    position: relative;
}
 
.TaskDescDropdown {
    padding: 10px;
    min-width: 250px;
}
 
    </style>
</head>

<body class="hold-transition bgwhite sidebar-mini fixed">
    <%If m_blnViewAccess = True Then%>
      <div class="">
        <div class="container-fluid d-block px-0 mb-2">      
         <%--Added by Vishal Mane on 19/08/2025 to add proxy notes--%>
         <div class="graybg d-flex justify-content-between align-items-center px-3 py-2">
              <h4 class="HeaderTitle mb-0"><%=MyBase.GetResourceString("C_WeeklyPTS")%></h4>
              <div class="ms-auto p-2">
                <span id="proNotes" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true"
                        data-bs-content="
                            <div class='fnt-10'>
                                <%=MyBase.GetResourceString("C_ProxyNote1")%><br>
                                <b><%=MyBase.GetResourceString("C_Configuration")%></b>
                                <%=MyBase.GetResourceString("C_ProxyNote2")%> &rarr; <%=MyBase.GetResourceString("C_ProxyNote21")%> &rarr; <%=MyBase.GetResourceString("C_ProxyNote22")%>
                                <br>
                                <b><%=MyBase.GetResourceString("C_Usage")%></b>
                                <%=MyBase.GetResourceString("C_ProxyNote3")%>
                                <br>
                                <b><%=MyBase.GetResourceString("C_Benefit")%></b>
                                <%=MyBase.GetResourceString("C_ProxyNote4")%>
                            </div>">
                        <i class="far fa-lightbulb noteIcon me-1"></i>
                        <span class="text-right"><%=MyBase.GetResourceString("C_ProxyNotes")%></span>
                    </span>
              </div>
            </div>
         <%--End of Added by Vishal Mane on 19/08/2025 to add proxy notes--%>
        </div>
        <section class="px-3">
            <div class="TimesheetEntryDiv" id="WeeklyTimesheetSec">
                <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                <div class="TimesheetTopSec" id="WeeklyTimesheetTopSec">
                    <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                    <div class="row">
                        <div class="col-sm-3 p-2">
                            <span id="proNotes" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true"
                                data-bs-content="<div class='fnt-10'><%=MyBase.GetResourceString("C_ProNotes1")%>
                                <br><%=MyBase.GetResourceString("C_ProNotes2")%>
                                    <br><%=MyBase.GetResourceString("C_ProNotes3")%>
                                    <br> <%=MyBase.GetResourceString("C_ProNotes4")%> </div>">
                                <i class="far fa-lightbulb noteIcon me-1"></i>
                                <span><%=MyBase.GetResourceString("C_ProTips")%></span>
                            </span>
                        </div>
                        <div class="col-sm-6">
                            <div class="weekly_calender">
                                <!-- <button title="Previous Week" class="prevBtn" id="prev"><i class="fa-solid fa-angle-left"></i> Prev</button> -->
                                <div class="input-group-box">
                                    <div class="input-group" id="DateDemo">
                                        <input title="Select Week date" class="form-control" type="text" id="weekPicker2" />
                                        <%--<input title="Select week date" data-bs-animation='false' class="form-control" type="text" id="weekPicker2" autocomplete="off" />--%>
                                    </div>
                                </div>
                                <!-- <button id="next" title="Next Week" class="nextBtn">Next <i class="fa-solid fa-angle-right"></i></button> -->
                            </div>
                        </div>
                        <div class="col-sm-3  text-end">
                           
                            <%--Added By Vishal on 16/12/2024--%>
                            <%--<button class="btn" data-bs-toggle="collapse" data-bs-target="#TimesheetFilters" id="AdvanceFilterIcon" onclick="GetAssignedProjects();" style="display:none">--%>
                            <button class="btn" data-bs-toggle="collapse" data-bs-target="#TimesheetFilters" id="AdvanceFilterIcon" onclick="GetAssignedProjects();">
                                <i class="fas fa-filter" data-bs-toggle="tooltip" title="Filter"></i>
                            </button>
                            <%--Added By Vishal Mane to add MyTimesheet Tab on 20/01/2025--%>
                            <a href="javascript:;" id="MyTimesheetTab" data-bs-toggle="offcanvas" data-bs-target="#MyTimesheetOffcanvas" onclick="PlotMyTimesheetList(1);">
                                <img src="../../../Whizible2.0-new/dist/img/MyTimesheet.svg" alt="My Timesheet" class="TS_Icon me-3" data-bs-toggle="tooltip" title="My Timesheet"> 
                            </a>
                            <%--End of Added By Vishal Mane to add MyTimesheet Tab on 20/01/2025--%>
                             <%--<div class="text_pink fw-500 d-flex justify-content-end mb-2 pe-3">--%>
                            <div class="fw-500 d-flex justify-content-end mb-2 pe-3">
                                    <div class="" id="txtStatusDiv"><%=MyBase.GetResourceString("C_Status")%>:</div>
                                    <div class="ps-2" id="txtStatus"></div>
                                </div>
                        </div>
                    </div>

                    <!--filter panel start-->
                    <div id="TimesheetFilters" class="filterpanel collapse">
                        <div class="bglightgray container-fluid py-1 filterpanelheader">
                            <hr />
                            <div class="filterTitle mb-3"><%=MyBase.GetResourceString("C_SvFilter")%></div>
                            <div class="Fwrapper px-3">
                                <div class="filterpanelbody">
                                    <div class="row">
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="ProjectFilSec">
                                                    <div class="row SearchField mb-3">
                                                        <label class=""><%=MyBase.GetResourceString("C_Project")%></label>
                                                        <div class="searchRow">
                                                            <div class="input-group">
                                                                <input id="searchProjFilter" type="text" placeholder="Search Project.."
                                                                    onkeyup="searchProjInput(this)" class="form-control input-sm">
                                                                <div class="input-group-btn">
                                                                    <button class="btn btn-default srchBtn" type="submit">
                                                                        <i
                                                                            class="fas fa-search"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div id="ProjectFilterSec" class="mt-2">
                                                        
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="TaskTypeFilSec">
                                                    <label class=""><%=MyBase.GetResourceString("C_TaskType")%></label>
                                                    <div class="searchRow">
                                                        <div class="input-group">
                                                            <input id="searchTaskTypeFilter" type="text" placeholder="Search Task Type.."
                                                                onkeyup="searchTaskType(this)" class="form-control input-sm">
                                                            <div class="input-group-btn">
                                                                <button class="btn btn-default srchBtn" type="submit">
                                                                    <i
                                                                        class="fas fa-search"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div id="TaskTypeFilterSec" class="mt-2">
                                                    
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="TaskCatgoryFilSec">
                                                    <div class="row SearchField mb-3">
                                                        <label class=""><%=MyBase.GetResourceString("C_TaskCat")%></label>
                                                        <div class="searchRow">
                                                            <div class="input-group" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Select Task Type Assigned, MPP, Generic..">
                                                                <input id="searchTaskCatgryFilter" type="text" placeholder="Select Task Type Assigned, MPP, Generic.."
                                                                    onkeyup="searchTaskCatgryInput(this)" class="form-control input-sm">
                                                                <div class="input-group-btn">
                                                                    <button class="btn btn-default srchBtn" type="submit">
                                                                        <i class="fas fa-search"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div id="TaskCatgryFilterSec" class="mt-2">
                                                          
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="SubProjectFilSec">
                                                    <div class="row SearchField mb-3">
                                                        <label class=""><%=MyBase.GetResourceString("C_SubProject")%></label>
                                                        <div class="searchRow">
                                                            <div class="input-group">
                                                                <input id="searchSubProjFilter" type="text" placeholder="Search Sub Project.."
                                                                    onkeyup="searchSubProjInput(this)" class="form-control input-sm">
                                                                <div class="input-group-btn">
                                                                    <button class="btn btn-default srchBtn" type="submit">
                                                                        <i
                                                                            class="fas fa-search"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div id="SubProjectFilterSec" class="mt-2">
                                                          
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="TaskMilestoneFilSec">
                                                    <div class="row SearchField mb-3">
                                                        <label class=""><%=MyBase.GetResourceString("C_Milestone")%></label>
                                                        <div class="searchRow">
                                                            <div class="input-group">
                                                                <input id="searchMilestoneFilter" type="text" placeholder="Search Milestone.."
                                                                    onkeyup="searchMilestoneInput(this)" class="form-control input-sm">
                                                                <div class="input-group-btn">
                                                                    <button class="btn btn-default srchBtn" type="submit">
                                                                        <i
                                                                            class="fas fa-search"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div id="TaskMilestoneFilterSec" class="mt-2">
                                                          
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="DeliverableFilSec">
                                                    <label class=""><%=MyBase.GetResourceString("C_Deliverable")%></label>
                                                    <div class="searchRow">
                                                        <div class="input-group">
                                                            <input id="searchDeliverableFilter" type="text" placeholder="Search Deliverable.."
                                                                onkeyup="searchDeliverable(this)" class="form-control input-sm">
                                                            <div class="input-group-btn">
                                                                <button class="btn btn-default srchBtn" type="submit">
                                                                    <i
                                                                        class="fas fa-search"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div id="DeliverableFilterSec" class="mt-2">
                                                     
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="PhaseFilSec">
                                                    <label class=""><%=MyBase.GetResourceString("C_Phase")%></label>
                                                    <div class="searchRow">
                                                        <div class="input-group">
                                                            <input id="searchPhaseFilter" type="text" placeholder="Search Phase.."
                                                                onkeyup="searchPhaseInput(this)" class="form-control input-sm">
                                                            <div class="input-group-btn">
                                                                <button class="btn btn-default srchBtn" type="submit">
                                                                    <i
                                                                        class="fas fa-search"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div id="PhaseFilterSec" class="mt-2">
                                                     
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="TaskStatusFilSec">
                                                    <div class="row SearchField mb-3">
                                                        <label class=""><%=MyBase.GetResourceString("C_Status")%></label>
                                                        <div class="searchRow">
                                                            <div class="input-group">
                                                                <input id="searchTaskStatusFilter" type="text" placeholder="Search Status.."
                                                                    onkeyup="searchTaskStatusInput(this)" class="form-control input-sm">
                                                                <div class="input-group-btn">
                                                                    <button class="btn btn-default srchBtn" type="submit">
                                                                        <i
                                                                            class="fas fa-search"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div id="TaskStatusFilterSec" class="mt-2">
                                                         
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="TaskPriorityFilSec">
                                                    <div class="row SearchField mb-3">
                                                        <label class=""><%=MyBase.GetResourceString("C_Priority")%></label>
                                                        <div class="searchRow">
                                                            <div class="input-group">
                                                                <input id="searchTaskPriorityFilter" type="text" placeholder="Search Priority.."
                                                                    onkeyup="searchTaskPriorityInput(this)" class="form-control input-sm">
                                                                <div class="input-group-btn">
                                                                    <button class="btn btn-default srchBtn" type="submit">
                                                                        <i
                                                                            class="fas fa-search"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div id="TaskPriorityFilterSec" class="mt-2">
                                                          
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="col-12 col-sm-2 mb-3">
                                            <div class="row mb-3">
                                                <div class="TaskSOWCategoryFilSec">
                                                    <div class="row SearchField mb-3">
                                                        <label class=""><%=MyBase.GetResourceString("C_Billable")%></label>                                                        
                                                        <div id="chkBillable" class="mt-2">
                                                            <div class="row SearchField">
                                                                <div class="col-sm-1 col-1">
                                                                    <input type="checkbox" class="form-check checkAll" name="TaskBillable" value=1 id="TaskBillable1">
                                                                </div>
                                                                <div class="col-sm-10 col-10">
                                                                    <label for="TaskBillable1" class="form-label">Yes</label>
                                                                </div>
                                                                <div class="col-sm-1 col-1">
                                                                    <input type="checkbox" class="form-check checkAll" name="TaskBillable" value=0 id="TaskBillable0">
                                                                </div>
                                                                <div class="col-sm-10 col-10">
                                                                    <label for="TaskBillable0" class="form-label">No</label>
                                                                </div>
                                                            </div>
                                                         
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="text-center mb-3">
                                            <button class="btn borderbtn" id="SaveApplyFilterBtn" data-bs-toggle="tooltip" onclick="SaveFilter();" title="Save and Apply"><%=MyBase.GetResourceString("C_SaveandApply")%></button>
                                            <button class="btn btnyellow" id="ApplyFilterBtn" data-bs-toggle="tooltip" onclick="ApplyTSFilter();" title="Apply"><%=MyBase.GetResourceString("C_Apply")%></button>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <hr />
                            </div>
                        </div>
                    </div>
                    <!--end filter panel-->
                </div>

                <div class="TimesheetDetailsSec">
                    <div class="row mb-2">
                        <%--Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo--%> 
                        <%--Modified by Vishal Mane on 20/08/2025 to fix UI Issue for Proxy Dropdaon--%> 
                        <div class="col-sm-4 col-md-4 px-3">
                            <%--<div class="form-group row pt-1 mb-2" id="proxyResourceDiv">
                                <div class="d-flex align-items-center w-100">                                 
                                    <label for="cboProxyResource" class="mb-0 me-2"><%=MyBase.GetResourceString("C_SelectUserForTimesheet")%></label>
                                    <div class="flex-grow-1">
                                        <select class="selectpicker form-control" data-live-search="true" id="cboProxyResource" style="width: 100px;">
                                        </select>
                                    </div>
                                </div>
                            </div>--%>
                            <div class="row">
                                <label for="cboProxyResource" class="col-sm-12 col-md-4">Select User for Timesheet Entry:</label>
                                <div class="col-sm-12 col-md-8">
                                    <select class="selectpicker form-control" data-live-search="true" id="cboProxyResource" style="width: 70px;"></select>
                                </div>
                            </div>                            
                        </div>
                        <%--End of Modified by Vishal Mane on 20/08/2025 to fix UI Issue for Proxy Dropdaon--%>
                        <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                        <div class="col-sm-4 col-md-4 px-3" id="datePickerDiv">
                            <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                            <div class="d-flex justify-content-center gap-2 gx-1 pt-2">
                                <div class="actualExpHrsDiv d-flex">
                                    <div class="HrsTime" id="txtActualHrs"></div>
                                    <div class="HrsTxt">Actual Hours</div>
                                </div>
                                <div class="actualExpHrsDiv d-flex">
                                    <div class="HrsTime" id="txtExpectedHrs"></div>
                                    <div class="HrsTxt"><%=MyBase.GetResourceString("C_ExpectedHours")%></div> 
                                </div>
                            </div>
                        </div>
                        <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                        <div class="col-sm-4 col-md-4 text-end" id="buttonsDiv">
                            <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                            <button class="btn btnyellow mb-1" id="ResubmitTimesheetBtn" data-bs-toggle="tooltip" title="Resubmit" style="display: none" onclick="SubmitTS_OnClick();"><%=MyBase.GetResourceString("C_Resubmit")%></button>
                            <button class="btn btnyellow mb-1" id="SubmitTimesheetBtn" data-bs-toggle="tooltip" title="Submit" style="display: none" onclick="SubmitTS_OnClick();"><%=MyBase.GetResourceString("C_Submit")%></button>
                            <%If m_blnAddAccess = True Then%>
                            <button class="btn borderbtn mb-1" id="CreateTaskBtn" style="display: none" onclick="clearCreateTaskData()" data-bs-toggle="offcanvas" data-bs-target="#CreateTaskOffcanvas">
                                <span data-bs-toggle="tooltip" title="Create Task"><%=MyBase.GetResourceString("C_CreateTask")%></span>
                            </button>
                            <% End If %>

                            <%If m_blnEditAccess = True Then%>
                            <button class="btn borderbtn mb-1" id="txtEditTS" data-bs-toggle="tooltip" title="Edit" style="display: none" onclick="EditTimesheet()"><%=MyBase.GetResourceString("C_Edit")%></button>
                            <% End If %>

                            <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                            <button class="btn btnyellow me-3 mb-1" id="saveTimesheetBtn" data-bs-toggle="tooltip" title="Save" onclick="SaveTimesheet(this)"><%=MyBase.GetResourceString("C_Save")%></button>
                            <% End If %>

                            <div class="clearfix"></div>
                        </div>
                    </div>

                    <!-- Applied Filters Section Start here -->
                    <div class="showFiltersSec mt-2" id="filterSection" style="display:none">
                        <div class="row p-3">
                            <div class="col-sm-1">                              
                                <%--<p class="fnt-12 labelOrange text-end mt-2 mb-0" style="display:none"><%=MyBase.GetResourceString("C_AppliedFilters")%>-</p>--%>
                                <p class="fnt-12 labelOrange text-end mt-2 mb-0"><%=MyBase.GetResourceString("C_AppliedFilters")%>-</p>
                            </div>
                            <div class="col-sm-11 d-flex align-items-center flex-wrap gap-2" id="dvAppliedFilters">
                             
                            </div>
                        </div>
                    </div>
                    <!-- Applied Filters Section End here -->
                    <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                    <div class="table-responsive-wrapper" id="timesheetTableDiv">
                    <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                        <div class="table-responsive">
                            <table id="TimesheetInfoTbl" class="table table-bordered table-striped TimesheetTbl" style="width: 100%;">
                                <thead id="TimesheetInfoTbl_Header" class="stickyTSHeader">
                           
                                </thead>
                                <tbody id="TimesheetInfoTbl_Body">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                    <div class="load_btns d-flex gap-3" id="moreLessDiv">
                        <%--Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users--%>
                        <a href="javascript:;" id="loadMoreBtn" class="greyTxt" data-bs-toggle="tooltip" title="More Projects"><%=MyBase.GetResourceString("C_MoreProjects")%></a>
                        <a href="javascript:;" id="loadLessBtn" class="greyTxt" data-bs-toggle="tooltip" title="Less Projects"><%=MyBase.GetResourceString("C_LessProjects")%></a>
                    </div>
                </div>
            </div>
        </section>
        <!-- Create Task Offcanvas screen start here -->
        <div class="offcanvas offcanvas-50 offcanvas-end" data-bs-scroll="true" tabindex="-1" id="CreateTaskOffcanvas">
            <div class="offcanvas-body">
                <div class="graybg container-fluid py-1 mb-2">
                    <div class="row">
                        <div class="col-sm-6">
                            <h5 class="pgtitle mb-0"><%=MyBase.GetResourceString("C_CreateTask")%></h5>
                        </div>
                        <div class="col-sm-6 text-end">
                            <button type="button" class="btn-close" data-bs-toggle="tooltip" title="Close" data-bs-dismiss="offcanvas" aria-label="Close" id="btcClose"></button>
                        </div>
                    </div>
                </div>

                <div class="CreateTaskSec py-3">
                    <div class="row">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6 text-end">
                            <button class="btn borderbtn" id="ViewSaveTS_Btn" data-bs-toggle="tooltip" title="Save" onclick="CreateTask_Save_OnClick(1);"><%=MyBase.GetResourceString("C_Save")%></button>
                            <button class="btn btnyellow me-3" id="SaveCreateNewTS_Btn" data-bs-toggle="tooltip" title="Save & Create New" onclick="CreateTask_Save_OnClick(2);"><%=MyBase.GetResourceString("C_SaveAndNew")%></button>

                            <div class="clearfix"></div>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-sm-7">
                            <div class="form-group row pt-1 mb-2">
                                <label for="SelectDateInput" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_SelectDate")%> :</label>
                                <div class="col-sm-7">
                                    <div class="input-group">
                                        <input id="SelectDateInput" class="form-control" onkeypress='return restrictNumericFilters(event)' ondrag='return false' ondrop='return false' onpaste='return false' readonly>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button">
                                                <i class="fas fa-calendar-alt"></i>
                                            </button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row pt-1 mb-2">
                                <label for="SelectProjectName" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_SelectPro")%> :</label>
                                <div class="col-sm-7">
                                    <select class="selectpicker" data-live-search="true" id="SelectProjectName">
                                      
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row pt-1 mb-2">
                                <label for="TaskInput" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_Task")%> :</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="TaskInput" maxlength="255" placeholder="Enter Task Name">
                                </div>
                            </div>
                            <div class="form-group row pt-1 mb-2">
                                <label for="SelectTaskType" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_TaskType")%> :</label>
                                <div class="col-sm-7">
                                    <select class="selectpicker" data-live-search="true" id="SelectTaskType">
                                       
                                    </select>
                                </div>
                            </div>                           
                            <div class="form-group row pt-1 mb-2">
                                <label for="SelectPriority" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_Priority")%> :</label>
                                <div class="col-sm-7">
                                    <select class="selectpicker" data-live-search="true" id="SelectPriority">
                                       
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row pt-1 mb-2">
                                <label for="ActualTimeInput" class="col-sm-5 text-end required"><%=MyBase.GetResourceString("C_ActualTime")%> :</label>
                                <div class="col-sm-7">
                                    <input type="text" placeholder="00:00" id="ActualTimeInput" onkeypress="return isNumber(event,this.value,this)" maxlength="5" class="form-control sm_input text-center" ondrag='return false' ondrop='return false' onpaste='return false'>
                                </div>
                            </div>
                            <div class="form-group row pt-1 mb-2">
                                <label for="ActualComplete" class="col-sm-5 text-end"><%=MyBase.GetResourceString("C_ActualTimeper")%> :</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="ActualComplete" placeholder="Enter % Actual Complete" maxlength="5" ondrag='return false' ondrop='return false' onpaste='return false'>
                                </div>
                            </div>
                            <div class="form-group row pt-1 mb-2">
                                <label for="Desc_Input" class="col-sm-5 text-end"><%=MyBase.GetResourceString("C_Description")%> :</label>
                                <div class="col-sm-7">
                                    <%--Commented & Added by Ajit L on 03 Feb 2025 for Expleo Customization--%> 
                                    <%--<textarea class="form-control" id="Desc_Input" maxlength='2000' placeholder="Enter Description"></textarea>--%>
                                    <textarea class="form-control" id="Desc_Input" maxlength='2000' placeholder="Enter Description..."></textarea>
                                    <%--End of Commented & Added by Ajit L on 03 Feb 2025 for Expleo Customization--%>
                                 </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Create Task Offcanvas screen end here -->
        <!-- Task Description Modal start here-->
        <div class="modal custmodal fade" id="TaskDescriptionModal" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <div>
                            <textarea class="form-control" id="TaskDesc_Input" rows="5" placeholder="Enter Description..."></textarea>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Task Description Modal End here-->
        <!--Confirmation message Modal Added by Ajit L-->
        <div id="ConfirmMessageModalCreateTask" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Message")%></h4>
                    </div>
                    <div class="modal-body">
                        <p id="ConfirmationMsgCreateTask"></p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn float-start" data-bs-dismiss="modal" onclick="SendConfirmationResponseForCreateTask(0)"><%=MyBase.GetResourceString("C_No")%></button>
                        <button class="btn btnyellow" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="SaveCreateTask(1)"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--End of Confirmation message Modal modal Added by Ajit L-->

        <!--Confirmation message Modal added by Ajit-->
        <div id="ConfirmMessageModalLeave" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Message")%></h4>
                    </div>
                    <div class="modal-body">
                        <p id="ConfirmMessageModalLeaveDate"></p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn float-start" data-bs-dismiss="modal" onclick="ConfirmLeaveForCreateTask(0)"><%=MyBase.GetResourceString("C_No")%></button>
                        <button class="btn btnyellow" data-bs-toggle="modal" data-bs-dismiss="modal" onclick="ConfirmLeaveForCreateTask(1)"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--End of Confirmation message Modal added by Ajit-->

        <!--Confirmation message Modal Added By Vishal Mane -->
        <div id="ConfirmMessagemodalinfo" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" id="btnConfirmTaskNo1" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Message</h4>
                    </div>
                    <div class="modal-body">
                        <span class="sm_txt" id="ConfirmationMsg"></span>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" id="btnConfirmTaskNo">No</button>
                        <button class="btn btnyellow" data-bs-toggle="modal" data-bs-dismiss="modal" id="btnConfirmTaskYes">Yes</button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--End of Confirmation message Modal Added By Vishal Mane -->

        <!--Confirmation message Modal Added By Vishal Mane -->
        <div id="ValidationMessageModalinfo" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" id="btnValidationMessage" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Validation Message</h4>
                    </div>
                    <div class="modal-body">
                        <span class="sm_txt" id="txtValidationMessage"></span>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" id="btnClose">Close</button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--End of Confirmation message Modal Added By Vishal Mane -->

        <!-- Created By Gauri - Edit My Timesheet Tab Offcanvas Section Start Here -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="MyTimesheetOffcanvas">
            <div class="offcanvas-body">
                <div class="graybg container-fluid py-1 mb-2">
                    <div class="row">
                        <div class="col-sm-6">
                            <h5 class="pgtitle mb-0">My Timesheet</h5>
                        </div>
                        <div class="col-sm-6 text-end">
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close" id="btnCloseMyTimesheet"></button>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-3">
                        <label for="cboStatusMyTS"></label>
                        <select class="selectpicker" data-live-search="true" id="cboStatusMyTS" onchange="PlotMyTimesheetList();">
                            <option value="0">Select Status</option>
                            <option value="V">Approved</option>
                            <option value="J">Rejected</option>
                            <option value="R">Submitted</option>
                        </select>
                    </div>
                    <div class="col-sm-9 d-flex justify-content-end align-items-center gap-2">
                        <div class="dropdown filedownload">
                            <button class="nostylebtn dropdown-toggle me-2" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>
                            <%--<ul class="dropdown-menu" id="fas-download">
                                <li><a href="javascript:;" onclick="DownloadReport('PDF')">
                                    <img src="Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                <li><a href="javascript:;" onclick="DownloadReport('EXCEL')">
                                    <img src="Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                <li><a href="javascript:;" onclick="DownloadReport('XML')">
                                    <img src="Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                                <li><a href="javascript:;" onclick="DownloadReport('TEXT')">
                                    <img src="Whizible2.0-new/dist/img/doc.svg" width="18px">Text</a></li>

                            </ul>--%>

                            <ul class="dropdown-menu" id="fas-download">
                                    <li><a href="#" onclick="DownloadReport('PDF')" data-bs-toggle="tooltip" title="PDF">
                                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                    <li><a href="#" onclick="DownloadReport('EXCEL')" data-bs-toggle="tooltip" title="EXCEL">
                                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                    <li><a href="#" onclick="DownloadReport('XML')" data-bs-toggle="tooltip" title="XML">
                                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                                    <li><a href="#" onclick="DownloadReport('TEXT')" data-bs-toggle="tooltip" title="TEXT">
                                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Text</a></li>

                                </ul>
                            
                            <%--<button class="btn borderbtn" id="deleteMyTSBtn" data-bs-toggle="tooltip" title="Delete">Delete</button>--%>
                            <%If m_blnDeleteAccess = True Then%>
                            <button id="deleteMyTSBtn" class="btn btnRed" data-bs-toggle="tooltip" data-bs-target="" title="Delete">Delete</button>
                            <% End If %>
                            <button class="btn btnyellow" id="resubmitMyTSBtn" data-bs-toggle="tooltip" title="Resubmit">Resubmit</button>
                        </div>
                    </div>
                </div>

                <table id="MyTimesheetInfoTbl" class="table table-bordered table-striped myTimesheetTbl mt-2" style="width:100%;">
                    <thead class="stickyTSHeader">
                        <tr class="headerGrey">
                            <th width="20%" class="text-center">Submitted Date</th>
                            <th width="22%" class="text-center"><i class="fas fa-sort" id="PeriodHeader"></i>Period</th>
                            <th width="10%" class="text-center">Actual Hours</th>
                            <th width="15%" class="text-center">Status</th>
                            <th width="28%" class="text-center">Approve/Reject Comment</th>
                            <th width="5%" class="text-center">
                                <div class="custom_chckbox">
                                    <input id="TS_CheckAll" class="chckHead" type="checkbox" />
                                    <label for="TS_CheckAll"></label>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="MyTimesheetInfoTbl_Body">
                    
                    </tbody>
                </table>

                <!-- Show History Details Panel start here -->
                <div class="ShowHisDetailpanel mb-4">
                    <div class="pgdetailinner p-0">
                        <div class="HistorySec">
                            <ul class="nav nav-tabs detailsubtabs mt-4">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#MyTS_HistoryTab" data-bs-toggle="tab" id="">History</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <!-- History Tab -->
                                <div id="MyTS_HistoryTab" class="tab-pane active mt-2">
                                    <div class="container-fluid">
                                        <div class="form-inline hstryfltr pb-2">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="row">
                                                        <label class="mt-2">Timesheet Period: 
                                                            <span id="TS_Period" class="blueTxt">13 Jan 2025 to 20 Jan 2025</span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="d-flex justify-content-end gap-2">
                                                        <a href="javascript:;" class="btn borderbtn cancelEdtDetpanel"
                                                            id="BtnCancelHistory" data-bs-toggle="tooltip" title="Cancel">Cancel</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                
                                            <div class="table-responsive">
                                                <table id="GetMyTimesheetHistoryle" class="table table-bordered table-striped" style="width:100%;">
                                                    <thead class="">
                                                        <tr>
                                                            <%--<th class="text-center">Status</th>
                                                            <th class="text-center">Generation Date</th>
                                                            <th class="text-center">Updated Date</th>
                                                            <th class="text-center">Action Taken By</th>
                                                            <th class="text-center">Action Taken</th>
                                                            <th class="text-center">Approver Name</th>--%>

                                                            <th style="width: 78px!important;" class="text-center">Status</th>
                                                            <th style="width: 128px!important;" class="text-center">Generation Date</th>
                                                            <th style="width: 130px!important;" class="text-center">Updated Date</th>
                                                            <th style="width: 120px!important;" class="text-center">Action Taken By</th>
                                                            <th style="width: 160px!important;" class="text-center">Action Taken</th>
                                                            <th style="width: 116px!important;" class="text-center">Approver Name</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="GetMyTimesheetHistoryle_Body">
                                                                                                       
                                                    </tbody>
                                                </table>
                                            </div>
                                            <br />
                                    </div>
            
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Show History Details Panel end here -->
            </div>
        </div>

        <!--deletmodal-->
        <div id="deleteinfomodal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" id="" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>
                    <div class="modal-body">
                        <span class="sm_txt_MT" id="">You are about to delete the timesheet. Do you want to continue?</span>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                        <button class="btn btnyellow ml-1 float-end" onclick="DeleteData()">Yes</button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
       <!--deletmodalend-->

        <!--Resubmit Mytimesheet modal-->
        <div id="submitinfomodal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" id="" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Re-Submit</h4>
                    </div>
                    <div class="modal-body text-center" >
                        <span class="sm_txt_MT" id="">Are you sure you want to re-submit the timesheet?</span>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                        <button class="btn btnyellow ml-1 float-end" onclick="SubmitData()">Yes</button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
       <!--End of Resubmit Mytimesheet modal-->
        <!-- Created By Gauri - Edit My Timesheet Tab Offcanvas Section end Here -->
    </div>
    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <%--<div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess") %> </p>
        </div>--%>
          <div class="container_Access">
             <div class="content">
                 <!-- Floating icon with animation -->
                 <div class="icon-container">
                     <div class="icon-circle">
                         <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                             <path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"/>
                         </svg>
                     </div>
                 </div>

                 <!-- Main content card -->
                 <div class="card">
                     <!-- Header -->
                     <div class="header">
                         <h1><%=MyBase.GetResourceString("C_AccessRestricted")%></h1>
                         <p><%=MyBase.GetResourceString("C_NotAuthorised")%></p>
                     </div>

                     <!-- Instructions section -->
                     <div class="instructions-section">
                         <div class="instructions-header">
                             <div class="warning-icon">
                                 <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                     <path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/>
                                     <path d="M12 9v4"/>
                                     <path d="m12 17 .01 0"/>
                                 </svg>
                             </div>
                             <h3><%=MyBase.GetResourceString("C_InstructionsforAccess")%></h3>
                         </div>
                 
                         <div class="instructions-content">
                             <p><%=MyBase.GetResourceString("C_InstructionNote1")%></p>
                     
                             <div class="contact-box">
                                 <p><%=MyBase.GetResourceString("C_Togainaccess")%></p>
                                 <p><%=MyBase.GetResourceString("C_InstructionNote2")%></p>
                             </div>
                     
                             <div class="contact-box">
                                 <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                     <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                                     <circle cx="9" cy="7" r="4"/>
                                     <line x1="17" x2="22" y1="8" y2="13"/>
                                     <line x1="22" x2="17" y1="8" y2="13"/>
                                 </svg>
                                 <div class="contact-content">
                                     <p><%=MyBase.GetResourceString("C_ContactAdministrator")%></p>
                                     <%--<p>Please contact your administrator to request access 01. <span class="config-path">Configuration ? Group & Access ? Role</span> 02. <span class="config-path">Configuration ? Login ? Group & Access</span> and manage the employee mappings under the <span class="config-path">Configuration ? Proxy Timesheet ? Proxy User Mapping</span> section.</p>--%>
                                 <p>
                                    <%=MyBase.GetResourceString("C_InstructionNote3")%> 
                                </p>
                                <ul style="list-style-type: none; padding-left: 0;">
                                    <li>
                                        <strong>1.</strong> Navigate to <span class="config-path">Configuration ? Group & Access ? Role</span>.
                                    </li>
                                    <li>
                                        <strong>2.</strong> Navigate to <span class="config-path">Configuration ? Login ? Group & Access</span>.
                                    </li>
                                </ul>
                                <p>
                                    After this, manage employee mappings under the <span class="config-path">Configuration ? Proxy Timesheet ? Proxy User Mapping</span> section.
                                </p>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
    </div>
    <%End If %>
    <div class="clearfix"></div>
    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <%--Added by Vishal Mane on 21/01/2025--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <%--Added by Vishal Mane on 21/01/2025--%>

    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js?date=<%=DateTime.Now %>"></script>
    <!-- Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 --> 
    <!-- <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/moment-2.30.1.js"></script>
    <!-- End of Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1.6"></script>
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/weekPickerNew.js?date=<%=DateTime.Now %>"></script>
    <script src="../../General/CommonValidations.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

    <script>
        var intUserID;
        var strUserName;
        intUserID = '<%= Session("intUserID") %>';
        strUserName = '<%= Session("strUserName") %>';
        $(document).on("click", function () {
            $(".tooltip").remove();
        });
        $('#SelectDateInput').datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true,
            changeMonth: true,
            changeYear: true,
        });

        document.addEventListener("DOMContentLoaded", function () {
            const tableWrapper = document.querySelector(".table-responsive-wrapper");
            const thead = document.querySelector("#TimesheetInfoTbl thead");

            tableWrapper.addEventListener("scroll", function () {
                const scrollTop = tableWrapper.scrollTop;
                thead.style.transform = `translateY(${scrollTop - 7}px)`;
            });
        });

        //$(function () {
        //    $('[data-bs-toggle="tooltip"]').tooltip();
        //    $('body').on('click', function (e) {
        //        $('[data-bs-toggle=popover]').each(function () {
        //            // hide any open popovers when the anywhere else in the body is clicked
        //            if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
        //                $(this).popover('hide');
        //                $(this).removeClass('show');

        //            }
        //        });
        //        $('.task td:not(:first-child) [data-bs-toggle=dropdown]').each(function () {
        //            // hide any open popovers when the anywhere else in the body is clicked
        //            if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.task td:not(:first-child) .dropdown-menu').has(e.target).length === 0) {
        //                $(".task td:not(:first-child) .dropdown-menu").removeClass('show');

        //            }
        //        });
        //    });

        //    $(".crossIcn").on("click", function () {
        //        $(this).closest(".filterName").hide();
        //    });

        //    // When the parent checkbox is changed
        //    $('#TaskSelect11').on('change', function () {
        //        const isChecked = $(this).is(':checked');
        //        $('.subTasksRow1 .childCheckbox').prop('disabled', isChecked); // Disable child checkboxes if parent is checked
        //    });

        //    // When any child checkbox is changed
        //    $('.subTasksRow1 .childCheckbox').on('change', function () {
        //        const isChildChecked = $('.subTasksRow1 .childCheckbox:checked').length > 0;
        //        $('#TaskSelect11').prop('disabled', isChildChecked); // Disable parent checkbox if any child is checked
        //    });
        //    // When the parent checkbox is changed
        //    $('#TaskSelect12').on('change', function () {
        //        const isChecked = $(this).is(':checked');
        //        $('.subTasksRow2 .childCheckbox').prop('disabled', isChecked); // Disable child checkboxes if parent is checked
        //    });

        //    // When any child checkbox is changed
        //    $('.subTasksRow2 .childCheckbox').on('change', function () {
        //        const isChildChecked = $('.subTasksRow2 .childCheckbox:checked').length > 0;
        //        $('#TaskSelect12').prop('disabled', isChildChecked); // Disable parent checkbox if any child is checked
        //    });
        //});

        $(function () {

            $('[data-bs-toggle="tooltip"]').tooltip();

            $('body').on('click', function (e) {

                // Handle popovers

                $('[data-bs-toggle=popover]').each(function () {

                    // hide any open popovers when anywhere else in the body is clicked

                    if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {

                        $(this).popover('hide');

                        $(this).removeClass('show');

                    }

                });

                // Handle dropdown menus - IMPROVED: Check if clicking inside textarea or its container

                $('.task td:not(:first-child) [data-bs-toggle=dropdown]').each(function () {

                    var $dropdownContainer = $(this).closest('td').find('.dropdown-menu');

                    var $target = $(e.target);

                    // Check if click is inside the textarea or its parent dropdown container

                    var isInsideTextarea = $target.is('textarea') || $target.closest('textarea').length > 0;

                    var isInsideDropdownContainer = $target.closest('.dropdown-menu').length > 0;

                    var isInsideDescriptionContainer = $target.closest('.TaskDescDropdown').length > 0;

                    // Only close if clicking outside the dropdown menu AND not on textarea

                    if (!isInsideTextarea && !isInsideDropdownContainer && !isInsideDescriptionContainer) {

                        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $dropdownContainer.has(e.target).length === 0) {

                            $dropdownContainer.removeClass('show');

                        }

                    }

                });

            });

            // Add specific handler for textarea clicks to prevent dropdown from closing

            $(document).on('click', 'textarea.InputDescription', function (e) {

                e.stopPropagation(); // Stop event from bubbling up

                var $dropdown = $(this).closest('.dropdown-menu');

                if (!$dropdown.hasClass('show')) {

                    $dropdown.addClass('show');

                }

                return true;

            });

            // Keep dropdown open when clicking inside dropdown menu

            $(document).on('click', '.dropdown-menu', function (e) {

                e.stopPropagation();

            });

            $(".crossIcn").on("click", function () {

                $(this).closest(".filterName").hide();

            });

            // When the parent checkbox is changed

            $('#TaskSelect11').on('change', function () {

                const isChecked = $(this).is(':checked');

                $('.subTasksRow1 .childCheckbox').prop('disabled', isChecked);

            });

            // When any child checkbox is changed

            $('.subTasksRow1 .childCheckbox').on('change', function () {

                const isChildChecked = $('.subTasksRow1 .childCheckbox:checked').length > 0;

                $('#TaskSelect11').prop('disabled', isChildChecked);

            });

            // When the parent checkbox is changed

            $('#TaskSelect12').on('change', function () {

                const isChecked = $(this).is(':checked');

                $('.subTasksRow2 .childCheckbox').prop('disabled', isChecked);

            });

            // When any child checkbox is changed

            $('.subTasksRow2 .childCheckbox').on('change', function () {

                const isChildChecked = $('.subTasksRow2 .childCheckbox:checked').length > 0;

                $('#TaskSelect12').prop('disabled', isChildChecked);

            });

        });


        // More or less projects functionality start here
        //Added By Riddesh
        $("#weekPicker2").change(function () {
            setWeekCalendar($('#weekPicker2'), 'yes', '1', startingDayOfWeek, new Date(TodaysDate));
            GetTSSaveFilter();
            GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
            GetTaskData(SessionEmployeeId);
            timesheetEntries = [];
            //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
            EnableDisbaleDATextbox();
            //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
        });
        //End of Added By Riddesh
        // More or less projects functionality end here

        // Tab button click on Input fields functionality start here
        $(document).on('keydown', '.edtTimeInput', function (event) {
            const $currentInput = $(this);
            const currentRow = parseInt($currentInput.attr('data-row'));
            const currentCol = parseInt($currentInput.attr('data-col'));

            if (event.key === "ArrowDown") {
                const $nextInput = $(`.edtTimeInput[data-row="${currentRow + 1}"][data-col="${currentCol}"]`);
                if ($nextInput.length) {
                    $nextInput.focus();
                    event.preventDefault();
                }
            } else if (event.key === "ArrowUp") {
                const $prevInput = $(`.edtTimeInput[data-row="${currentRow - 1}"][data-col="${currentCol}"]`);
                if ($prevInput.length) {
                    $prevInput.focus();
                    event.preventDefault();
                }
            } else if (event.key === "ArrowRight") {
                const $nextInput = $(`.edtTimeInput[data-row="${currentRow}"][data-col="${currentCol + 1}"]`);
                if ($nextInput.length) {
                    $nextInput.focus();
                    event.preventDefault();
                }
            } else if (event.key === "ArrowLeft") {
                const $prevInput = $(`.edtTimeInput[data-row="${currentRow}"][data-col="${currentCol - 1}"]`);
                if ($prevInput.length) {
                    $prevInput.focus();
                    event.preventDefault();
                }
            }
        });
        // Tab button click on Input fields functionality end here

        $(document).ready(function () {            

            //Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            bindProxyUsers();
            //End of Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            $('#searchProjTblFilter').on('keyup', function () {
                var filter = $(this).val().toLowerCase(); // Convert filter to lowercase for case-insensitive search

                $("#TimesheetInfoTbl tbody tr.projectRow").each(function () {
                    var parent = $(this); // Current top-level list item
                    var matchesParent = parent.text().toLowerCase().indexOf(filter) > -1; // Check if parent matches
                    var foundInChildren = false; // Track if any child matches

                    // Loop through child `li` elements under the current parent
                    parent.find("tr.childRow").each(function () {
                        var child = $(this);
                        if (child.text().toLowerCase().indexOf(filter) > -1) {
                            child.show(); // Show matching child
                            foundInChildren = true; // Mark that a match was found in children
                        } else {
                            child.hide(); // Hide non-matching child
                        }
                    });

                    if (matchesParent || foundInChildren) {
                        parent.show(); // Show parent if it matches or if any child matches
                    } else {
                        parent.hide(); // Hide parent if no matches are found
                    }
                });

                // If the input is cleared, reset the sidebar to show all items
                if (filter === "") {
                    $("#TimesheetInfoTbl tbody tr.projectRow").show();
                    // $("#TimesheetInfoTbl tbody tr.projectRow ").show(); // Show all children
                }
            });

        });

        $("#ProjectFilterSec").hide();
        function searchProjInput(thisa) {

            // $("#ProjectFilterSec").show();
            //  $("#searchProjFilter").on("keyup", function () {
            var value = $(thisa).val().toLowerCase();
            $("#ProjectFilterSec .SearchField").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

            if (value.trim() !== "") {
                $("#ProjectFilterSec").show();
            } else {
                $("#ProjectFilterSec").hide();
            }
            //});
        }

        $("#TaskTypeFilterSec").hide();
        function searchTaskType(thisa) {
            // $("#TaskTypeFilterSec").show();
            //$("#searchTaskTypeFilter").on("keyup", function () {
            var value = $(thisa).val().toLowerCase();
            $("#TaskTypeFilterSec .SearchField").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

            if (value.trim() !== "") {
                $("#TaskTypeFilterSec").show();
            } else {
                $("#TaskTypeFilterSec").hide();
            }
            // });
        }

        $("#TaskCatgryFilterSec").hide();
        function searchTaskCatgryInput(thisa) {
            //$("#TaskCatgryFilterSec").show();
            //$("#searchTaskCatgryFilter").on("keyup", function () {
            var value = $(thisa).val().toLowerCase();
            $("#TaskCatgryFilterSec .SearchField").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

            if (value.trim() !== "") {
                $("#TaskCatgryFilterSec").show();
            } else {
                $("#TaskCatgryFilterSec").hide();
            }
            //});
        }

        $("#TaskStatusFilterSec").hide();
        function searchTaskStatusInput(thisa) {
            //$("#TaskStatusFilterSec").show();
            //$("#searchTaskStatusFilter").on("keyup", function () {
            var value = $(thisa).val().toLowerCase();
            $("#TaskStatusFilterSec .SearchField").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

            if (value.trim() !== "") {
                $("#TaskStatusFilterSec").show();
            } else {
                $("#TaskStatusFilterSec").hide();
            }
            // });
        }

        $("#TaskPriorityFilterSec").hide();
        function searchTaskPriorityInput(thisa) {
            //$("#TaskPriorityFilterSec").show();
            //$("#searchTaskPriorityFilter").on("keyup", function () {
            var value = $(thisa).val().toLowerCase();
            $("#TaskPriorityFilterSec .SearchField").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

            if (value.trim() !== "") {
                $("#TaskPriorityFilterSec").show();
            } else {
                $("#TaskPriorityFilterSec").hide();
            }
            // });
        }


        $("#TaskMilestoneFilterSec").hide();
        function searchMilestoneInput(thisa) {
            //$("#TaskMilestoneFilterSec").show();
            //$("#searchMilestoneFilter").on("keyup", function () {
            var value = $(thisa).val().toLowerCase();
            $("#TaskMilestoneFilterSec .SearchField").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

            if (value.trim() !== "") {
                $("#TaskMilestoneFilterSec").show();
            } else {
                $("#TaskMilestoneFilterSec").hide();
            }
            //});
        }

        $("#SubProjectFilterSec").hide();
        function searchSubProjInput(thisa) {
            //$("#SubProjectFilterSec").show();
            //$("#searchSubProjFilter").on("keyup", function () {
            var value = $(thisa).val().toLowerCase();
            $("#SubProjectFilterSec .SearchField").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

            if (value.trim() !== "") {
                $("#SubProjectFilterSec").show();
            } else {
                $("#SubProjectFilterSec").hide();
            }
            //});
        }

        $("#DeliverableFilterSec").hide();
        function searchDeliverable(thisa) {
            //$("#DeliverableFilterSec").show();
            //$("#searchDeliverableFilter").on("keyup", function () {
            var value = $(thisa).val().toLowerCase();
            $("#DeliverableFilterSec .SearchField").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

            if (value.trim() !== "") {
                $("#DeliverableFilterSec").show();
            } else {
                $("#DeliverableFilterSec").hide();
            }
            // });
        }

        $("#PhaseFilterSec").hide();
        function searchPhaseInput(thisa) {
            //$("#PhaseFilterSec").show();
            //$("#searchPhaseFilter").on("keyup", function () {
            var value = $(thisa).val().toLowerCase();
            $("#PhaseFilterSec .SearchField").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });

            if (value.trim() !== "") {
                $("#PhaseFilterSec").show();
            } else {
                $("#PhaseFilterSec").hide();
            }
            // });
        }
        function searchTS_Tasks(thisa) {
            // $("#serchTaskInput").on('keyup', function(event) {
            // $('#SearchTasksAcc').collapse('show'); // Opens the accordion
            const searchValue = $(thisa).val().trim();

            if (searchValue.length > 0) {
                $('#SearchTasksAcc').collapse('show');

                var value = $(this).val().toLowerCase();
                $("#TaskDetlsFilterSec .SearchField").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            } else {
                $('#SearchTasksAcc').collapse('hide');
            }
            //  });
        }

        //Added by Vishal Mane on 26/11/2024
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Timesheet").ToString%>';
        if (strUrl.endsWith("/")) {
            strUrl = strUrl.slice(0, -1);
        }
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
        var startingDayOfWeek;
        var FinancialYearStart;
        var TodaysDate;
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionLoginType = '<%=  Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';

        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        var AddAccess = '<%=m_blnAddAccess%>';
        var IsAllowToOverridePreviousWeekTask;

        function GetCompanyInformation() {
            var Result = AJAXCallWithResult("/api/Common/GetCompanyInformation", '', false);
            var d = Result[0];
            startingDayOfWeek = d.StartingDayOfWeek;
            FinancialYearStart = d.FinancialYearStart;
            TodaysDate = d.TodaysDate;
        }
        $(document).ready(function () {
            //debugger  
            //Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users
            //Added by Vishal Mane on 13/08/2025 to fix UI Issue as datepicker is not working
            GetCompanyInformation();
            setWeekCalendar($('#weekPicker2'), 'yes', '1', startingDayOfWeek, new Date(TodaysDate));
            //End of Added by Vishal Mane on 13/08/2025 to fix UI Issue as datepicker is not working
            $("#datePickerDiv, #buttonsDiv, #timesheetTableDiv, #moreLessDiv, #WeeklyTimesheetTopSec").hide();
            $("#loadMoreBtn").hide();
            $('#loadLessBtn').hide();            
            //GetTSSaveFilter();
            //GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
            //GetTaskData(SessionEmployeeId);
            //GetTimeSheetWeekHeaderDetails(0);
            //GetTaskData(0);
            //End of Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users
            $('#chkBillable').click(function () {
                //debugger
                let isShowSec = $(this).is(":checked");
                if (isShowSec) {                     
                    const tooltip1 = bootstrap.Tooltip.getInstance('span.slider')
                    tooltip1.setContent({ '.tooltip-inner': 'Yes' });
                }
                else {
                    const tooltip2 = bootstrap.Tooltip.getInstance('span.slider')
                    tooltip2.setContent({ '.tooltip-inner': 'No' });
                }
            });
            $("#btcClose").click();
        });
        //Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
        function bindProxyUsers() {
            var UserID = SessionEmployeeId;
            var Parameter = {                
                intEmployeeID: UserID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/bindProxyUsers", param, false);
            //if (Result.length > 0) {
            $("#proxyResourceDiv").show();
            var strHTML = "<option  selected  value=''>Select Resource</option>";
            for (var i = 0; i < Result.length; i++) {
                var ListComponent = Result[i];
                strHTML += "<option title='" + ListComponent.EmployeeName + "' value='" + ListComponent.OnSiteResourceID + "'>" + ListComponent.EmployeeName + "</option>";
            }
            $("#cboProxyResource").html(strHTML);
            //}            
            $(".selectpicker").selectpicker('refresh');
        }

        $("#cboProxyResource").on("change", function () {
            //debugger
            var ProxyResourceID = $("#cboProxyResource").val();
            //Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users
            <%--if (ProxyResourceID == 0) {
                SessionEmployeeId = '<%= Session("intUserId") %>';
                strUserName = '<%= Session("strUserName") %>';
            } else {
                SessionEmployeeId = ProxyResourceID;
                strUserName = $("#cboProxyResource").text();
            }--%>
            //Added and commented by Vishal Mane on 13/08/2025 to fix SessionEmployeeId issue
            SessionEmployeeId = ProxyResourceID;
            strUserName = $("#cboProxyResource").text();
            //End of Added and commented by Vishal Mane on 13/08/2025 to fix SessionEmployeeId issue
            if (ProxyResourceID == 0) {
                $("#datePickerDiv, #buttonsDiv, #timesheetTableDiv, #moreLessDiv,#WeeklyTimesheetTopSec").hide();
                $("#loadMoreBtn").hide();
                $('#loadLessBtn').hide();
            } else {
                $("#datePickerDiv, #buttonsDiv, #timesheetTableDiv, #moreLessDiv, #WeeklyTimesheetTopSec").show();
                $("#loadMoreBtn").show();
                $('#loadLessBtn').show();
                GFlag = 0;
                GetTSSaveFilter();
                GetTimeSheetWeekHeaderDetails(ProxyResourceID);
                GetTaskData(ProxyResourceID);
            }
            //End of Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users
            
            $(".selectpicker").selectpicker('refresh');
        });
        //End of Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
        //var strEnableDisable = '';
        var TimesheetStatus = "";
        var TotalHoliday = 0;
        var IsAllowToOverrideCopyTasks = 0; 
        function GetTimeSheetWeekHeaderDetails(ProxyResourceID) {
            
            TotalHoliday = 0;
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //var EmployeeID = '<%= Session("intUserID") %>';
            var EmployeeID = SessionEmployeeId;
            //Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //if (ProxyResourceID == 0)
            //    ProxyResourceID = EmployeeID;
            //else
            //    EmployeeID = ProxyResourceID;
            //End of Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users
            var taskParameters = {
                intEmployeeID: ProxyResourceID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US",{ timeZone: "Asia/Kolkata" }),   //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
            }
            var param = JSON.stringify(taskParameters);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/GetTimeSheetWeekHeaderDetails", param, false);
            var strHTMLHeader = "";
            var TimeSheetWeekHeader = Result["TimeSheetWeekHeader"];
            var TotalDaywiseEntry = Result["TimeSheetWeekHeader1"];
            //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
            TSSubmissionDetails = "";
            var FromDate = new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });
            var ToDate = new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });
            TSSubmissionDetails = Result["TimeSheetWeekHeader2"];
            HeaderResult = TotalDaywiseEntry;
            //handleTimesheetButtons(FromDate, ToDate);
            //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
            $("#txtActualHrs").text(formatTime(TotalDaywiseEntry[0].WeekTotal));
            $("#txtExpectedHrs").text(formatTime(TimeSheetWeekHeader[0].ExpectedHours));            
            $("#txtStatus").text(TotalDaywiseEntry[0].Status);
            IsAllowToOverrideCopyTasks = Result["IsAllowToOverride"];
            TimesheetStatus = TotalDaywiseEntry[0].Status;            
            $("#txtStatus").removeClass();
            if (TotalDaywiseEntry[0].Status == "Not Submitted") {
                $("#SubmitTimesheetBtn").show();
                $("#ResubmitTimesheetBtn").hide();
                $("#txtEditTS").hide();
                $("#CreateTaskBtn").show();
                $("#saveTimesheetBtn").show();
                $("#txtStatus").addClass("ps-2");
                $("#txtStatus").addClass("ps-2 statusNotSubmitted-text");
                //Commented and added by Vishal Mane on 28/05/2025 to fix customization issue to disable save button for Submitted Action for Expleo                
                $("#saveTimesheetBtn").prop("disabled", false);
                $("#CreateTaskBtn").prop("disabled", false);
                //End of Commented and added by Vishal Mane on 28/05/2025 to fix customization issue to disable save button for Submitted Action for Expleo
            }
            else if (TotalDaywiseEntry[0].Status == "Rejected") {
                $("#txtEditTS").show();
                $("#ResubmitTimesheetBtn").show();
                $("#SubmitTimesheetBtn").hide();
                $("#CreateTaskBtn").show();
                $("#txtStatus").addClass("ps-2 weekcolumnred");                
                IsGloabl = 0;
                $("#saveTimesheetBtn").hide();
                //Commented and added by Vishal Mane on 28/05/2025 to fix customization issue to disable save button for Submitted Action for Expleo                
                $("#saveTimesheetBtn").prop("disabled", false);
                $("#CreateTaskBtn").prop("disabled", false);
                //End of Commented and added by Vishal Mane on 28/05/2025 to fix customization issue to disable save button for Submitted Action for Expleo
            }
            //else if (TotalDaywiseEntry[0].Status == "Ready for approval") {
            else if (TotalDaywiseEntry[0].Status == "Ready for approval" || TotalDaywiseEntry[0].Status == "Submitted") {
                $("#txtStatus").text("Submitted");
                $("#ResubmitTimesheetBtn").hide();
                $("#SubmitTimesheetBtn").hide();
                $("#txtEditTS").hide();
                $("#CreateTaskBtn").show();
                $("#saveTimesheetBtn").show();
                //Commented and added by Vishal Mane on 28/05/2025 to fix customization issue to disable save button for Submitted Action for Expleo                
                $("#saveTimesheetBtn").prop("disabled", true);
                $("#CreateTaskBtn").prop("disabled", true);
                //End of Commented and added by Vishal Mane on 28/05/2025 to fix customization issue to disable save button for Submitted Action for Expleo          
                $("#txtStatus").addClass("ps-2");
                $("#txtStatus").addClass("ps-2 statusSubmitted-text");
            }
            else if (TotalDaywiseEntry[0].Status == "Approved") {
                $("#ResubmitTimesheetBtn").hide();
                $("#SubmitTimesheetBtn").hide();
                $("#txtEditTS").hide();
                $("#CreateTaskBtn").hide();
                $("#saveTimesheetBtn").hide(); 
                $("#txtStatus").addClass("ps-2 green-text");                
            }
            //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
            checkMultipleStatusRanges();
            //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
            strHTMLHeader += '<tr class="headerGrey">'
            strHTMLHeader += '<th class="projColumn">Projects / Tasks</th>'
            strHTMLHeader += '<th class="colWidth"><div class="topProjetcDetls"><div class="row gx-1 mb-2">'
            strHTMLHeader += '<label class=""><%=MyBase.GetResourceString("C_QuickEntry")%></label>'
            strHTMLHeader += '<div class="quickEntryRecord d-flex justify-content-center">'
            strHTMLHeader += '<input type="text" class="form-control text-center quickEntryInput" id="txtQuickEntry" data-bs-toggle="tooltip" placeholder = "00:00" title="Enter Your Effort in hh:mm format" maxlength="5" onkeypress="return isNumber(event,this.value,this)">'
            strHTMLHeader += '<button id="btnQuickEntry" onclick="QuickEntry_Click();"><i class="fas fa-check"></i></button></div></div></div></th>'
            for (var i = 0; i < TimeSheetWeekHeader.length; i++) {
                if (TimeSheetWeekHeader[i].IsWorking === 0) {
                    strHTMLHeader += '<th class="colWidth">' + TimeSheetWeekHeader[i].EntryDate + ', <span class="d-block">' + TimeSheetWeekHeader[i].DayName + '</span></th>'
                }
                else if (TimeSheetWeekHeader[i].IsWorking % 2 != 0) {
                    strHTMLHeader += '<th class="colWidth weekcolumnred">' + TimeSheetWeekHeader[i].EntryDate + ', <span class="d-block">' + TimeSheetWeekHeader[i].DayName + '</span></th>'
                } else {
                    strHTMLHeader += '<th class="colWidth">' + TimeSheetWeekHeader[i].EntryDate + ', <span class="d-block">' + TimeSheetWeekHeader[i].DayName + '</span></th>'
                }
            }            
            strHTMLHeader += '<th class="colWidth"><%=MyBase.GetResourceString("C_TaskComp")%></th>'
            strHTMLHeader += '<th class="colWidth"><%=MyBase.GetResourceString("C_Weeklytotal")%></th>'
            strHTMLHeader += '</tr>'
            strHTMLHeader += '<tr>'
            strHTMLHeader += '<th>Total work for a Day</th><th></th><th>'
            strHTMLHeader += '<label class="totalTxt" id="txtDailyTotal_1">' + formatTime(TotalDaywiseEntry[0].Total.toString().replace('.', ':')) + '</label></th><th>'
            strHTMLHeader += '<label class="totalTxt" id="txtDailyTotal_2">' + formatTime(TotalDaywiseEntry[1].Total.toString().replace('.', ':')) + '</label></th>'
            strHTMLHeader += '<th><label class="totalTxt" id="txtDailyTotal_3">' + formatTime(TotalDaywiseEntry[2].Total.toString().replace('.', ':')) + '</label></th>'
            strHTMLHeader += '<th><label class="totalTxt" id="txtDailyTotal_4">' + formatTime(TotalDaywiseEntry[3].Total.toString().replace('.', ':')) + '</label></th>'
            strHTMLHeader += '<th><label class="totalTxt" id="txtDailyTotal_5">' + formatTime(TotalDaywiseEntry[4].Total.toString().replace('.', ':')) + '</label></th>'
            strHTMLHeader += '<th><label class="totalTxt" id="txtDailyTotal_6">' + formatTime(TotalDaywiseEntry[5].Total.toString().replace('.', ':')) + '</label></th>'
            strHTMLHeader += '<th><label class="totalTxt" id="txtDailyTotal_7">' + formatTime(TotalDaywiseEntry[6].Total.toString().replace('.', ':')) + '</label></th>'
            strHTMLHeader += '<th></th>'
            strHTMLHeader += '<th><label class="totalTxt" id="txtWeeklyTotal">' + formatTime(TotalDaywiseEntry[0].WeekTotal) + '</label> </th>'
            strHTMLHeader += '</tr>'
            strHTMLHeader += '<tr>'
            strHTMLHeader += '<td class="row"><div class="col-md-7 col-sm-12"><div class="searchRow"><div class="input-group">'
            strHTMLHeader += '<input id="searchProjTblFilter" type="text" placeholder="Search Project..." onkeyup="searchProjTblInput()" class="form-control input-sm projectSearchbox">'
            strHTMLHeader += '<div class="input-group-btn"><button class="btn btn-default srchBtn" type="submit"><i class="fas fa-search"></i></button></div></div></div></div>'
            strHTMLHeader += '<div class="col-md-5 col-sm-12"><div class="row mt-2 gx-0"><div class="col-sm-3 d-flex justify-content-end">'
            strHTMLHeader += '<label class="switch"><input type="checkbox" id="CopyPrevWeek" onchange="PlotTaskDetails_OnCopy();"><span class="slider"></span></label></div>'
            strHTMLHeader += '<div class="col-sm-9 text-start"><label for="CopyPrevWeek" class="copyTxt fnt-11 flex-1 ps-2"><%=MyBase.GetResourceString("C_CVPweek")%></label></div></div></div></td>'
            strHTMLHeader += '<td colspan="10"></td>'
            strHTMLHeader += '</tr>'
            $("#TimesheetInfoTbl_Header").html(strHTMLHeader);
            var actualHours = 0;
            if (TotalDaywiseEntry[0].WeekTotal == 0) {
                actualHours = 0;
            } else {
                actualHours = timeToMinutes(formatTime(TotalDaywiseEntry[0].WeekTotal));
            } 
            var expectedHours = 0;
            if (TimeSheetWeekHeader[0].ExpectedHours == 0) {
                expectedHours = 0;
            }else {
                expectedHours = timeToMinutes(formatTime(TimeSheetWeekHeader[0].ExpectedHours));
            }            
            if (actualHours < expectedHours) {
                $("#txtActualHrs").removeClass("white-text").addClass("weekcolumnred");
            } else {
                $("#txtActualHrs").removeClass("weekcolumnred").addClass("white-text");
            }            
        }
        var isNotAllowQuickEntry = false;
        var totalEnteredNewHours = 0;
        var timesheetEntriesQuickEntry = [];
        //Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
        var timesheetQuickEntryExpand = [];
        //End of Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
        function QuickEntry_Click() {
            //debugger
            if (TimesheetStatus != "Approved" && TimesheetStatus != "Ready for approval") {
                alertify.set('notifier', 'position', 'top-right');
                isNotAllowQuickEntry = false;
                var objtxtQuickEntry;
                var objEntryDate;
                var quickflag = 0;
                var errorFlag = 0;
                var TotalAllocationDuration = 0;
                var TotalActualDurationhidden = 0;
                var objtxtQuickEntry = $("#txtQuickEntry").val();
                if (objtxtQuickEntry != null) {
                    if (objtxtQuickEntry == "") {
                        //alertify.error('Please enter numeric value !');
                        alertify.error('<%=MyBase.GetResourceString("A_Numeric")%>');
                        //<%=MyBase.GetResourceString("C_Status")%>
                        $("#txtQuickEntry").focus();
                        return false;
                    }
                    if (objtxtQuickEntry == 0 || objtxtQuickEntry == '00:00') {
                        //alertify.error('Please Enter More Than 0 Hours  !');
                        alertify.error('<%=MyBase.GetResourceString("A_MoreThanZero")%>');
                        $("#txtQuickEntry").focus();
                        return false;
                    }
                    var HourPrecision = objtxtQuickEntry.split(":")[0];
                    var precision = objtxtQuickEntry.split(":")[1];
                    //Added and Commented by Vishal Mane on 28/05/2025 to fix customization issue to allow 8 as single digit in quick entry for Expleo
                    if (precision == undefined) {
                        precision = 0;
                    }
                    if (precision > 60) {
                        //alertify.error('Please enter minutes in two decimal and less than 60.');
                        alertify.error('<%=MyBase.GetResourceString("A_MinutesLessThanSixty")%>');
                        $("#txtQuickEntry").focus();
                        return false;
                    }
                <%--if (!objtxtQuickEntry.includes(":")) {
                    //alertify.error('Please enter numeric values for duration proper in hh:mm format.');
                    alertify.error('<%=MyBase.GetResourceString("A_HHMMFormat")%>');
                    $("#txtQuickEntry").focus();
                    return false;
                }--%>
                    if (isNaN(HourPrecision) || isNaN(precision)) {
                        //alertify.error('Please enter numeric values for duration proper in hh:mm format.');
                        alertify.error('<%=MyBase.GetResourceString("A_HHMMFormat")%>');
                        $("#txtQuickEntry").focus();
                        return false;
                    }
                <%--if (CheckHHMMFormat(objtxtQuickEntry) == true) {
                    //alertify.error('Please enter numeric values for duration proper in hh:mm format.');
                    alertify.error('<%=MyBase.GetResourceString("A_HHMMFormat")%>');
                    $("#txtQuickEntry").focus();
                    return false;
                } --%>
                    //End of Commented by Vishal Mane on 28/05/2025 to fix customization issue to allow 8 as single digit in quick entry for Expleo
                    var DailyTotalMinutes = timeToMinutes(objtxtQuickEntry);
                    var maxMinutes = 1440;

                    if (DailyTotalMinutes > maxMinutes) {
                        //alertify.error("You can not enter more than 24.00 hours a day");
                        alertify.error('<%=MyBase.GetResourceString("A_MoreThan24")%>');
                        $("#txtQuickEntry").focus();
                        return false;
                    }

                    if (precision == 60) {
                        var durationParts = objtxtQuickEntry.split(':'); // Split into hours and minutes
                        var hours = parseInt(durationParts[0]); // Get the hours part
                        var minutes = parseInt(durationParts[1]); // Get the minutes part
                        hours = hours + 1;
                        objtxtQuickEntry = formatTime(hours);
                    }

                    var strTimesheetIDs;
                    strTimesheetIDs = $('input[name=chkQuickEntry]:checked').map(function () {
                        return this.id;
                    }).get().join(',');
                    if (strTimesheetIDs == "") {
                        //alertify.error('Please select atleast one task.');
                        alertify.error('<%=MyBase.GetResourceString("A_AtLeastOneTask")%>');
                        $("#txtQuickEntry").focus();
                        return false;
                    }
                    if (GlobalRestrictByMinHours == 1) {
                        if (GlobalHoursFlag == 1) {
                            var minutes = objtxtQuickEntry.split(':');
                            var p = minutes[0];
                            var dec = minutes[1];
                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);
                        }
                        else {
                            var d = objtxtQuickEntry;
                        }
                        if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                            alertify.error("Please enter hours complete in multiples of " + MinDAENtryDisplay);
                            $("#txtQuickEntry").focus();
                            return false;
                        }
                    }
                    var objQuickEntryDecimal = objtxtQuickEntry;
                    totalEnteredHours = 0;
                    totalEnteredDynamicHours = 0;
                    totalActualPreviousWeekHours = 0;
                    var arrQuickCheck = strTimesheetIDs.split(",");
                    //Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                    var QuickActualTotal = [];
                    //End of Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                    for (var i = 0; i < arrQuickCheck.length; i++) {
                        var arrTaskData = arrQuickCheck[i].split("_");
                        var ProjectID = arrTaskData[1];
                        var TaskID = arrTaskData[2];
                        var SubTaskTypeID = arrTaskData[3];
                        arrayWeekDays = ["mon", "tue", "wed", "thu", "fri"];
                        for (var k = 0; k < arrayWeekDays.length; k++) {
                            objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                            var RequestParameters = {
                                WorkHrs: encodeURI(objDuration.value),
                                Flag: encodeURI(2),
                            }
                            var param1 = JSON.stringify(RequestParameters);
                            var objDurationDynamicVal = AJAXCallWithResult("/api/TimesheetEntryNew/ConvertDecimalToHourViceVersa", param1, false);
                            totalEnteredDynamicHours = parseFloat(totalEnteredDynamicHours) + parseFloat(objDurationDynamicVal);
                            if ($("#chkQuickEntry_" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID).is(":checked")) {
                                var value = $("#lblWeeklyTotal_" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID).text();
                                var RequestParameters = {
                                    WorkHrs: encodeURI($("#TotalActualDynamicDurationhidden" + ProjectID + "_" + TaskID + "_" + SubTaskTypeID).val()),
                                    Flag: encodeURI(2),
                                }
                                var param4 = JSON.stringify(RequestParameters);
                                var DynamicDurationhiddenval = AJAXCallWithResult("/api/TimesheetEntryNew/ConvertDecimalToHourViceVersa", param4, false);
                                var RequestParameters = {
                                    WorkHrs: encodeURI(value),
                                    Flag: encodeURI(2),
                                }
                                var param5 = JSON.stringify(RequestParameters);
                                var Dynamicpro_Calculate_count = AJAXCallWithResult("/api/TimesheetEntryNew/ConvertDecimalToHourViceVersa", param5, false);
                                totalActualPreviousWeekHours = DynamicDurationhiddenval - Dynamicpro_Calculate_count;
                            }
                        }
                        //Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                        var ActualWeekEntry = {
                            ProjectID: ProjectID,
                            TaskID: TaskID,
                            SubTaskTypeID: SubTaskTypeID,
                            ActualtotalWeekHours: totalActualPreviousWeekHours
                        }
                        QuickActualTotal.push(ActualWeekEntry);
                        //End of Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                    }
                    for (var i = 0; i < arrQuickCheck.length; i++) {
                        //debugger
                        //Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                        totalEnteredHours = 0;
                        totalEnteredNewHours = 0;
                        //End of Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                        var arrTaskData = arrQuickCheck[i].split("_");
                        var ProjectID = arrTaskData[1];
                        var TaskID = arrTaskData[2];
                        var SubTaskTypeID = arrTaskData[3];
                        arrayWeekDays = ["mon", "tue", "wed", "thu", "fri"];
                        //Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                        var ActualtotalWeekHours = 0;
                        var entry = QuickActualTotal.find(function (item) {
                            return item.ProjectID === ProjectID &&
                                item.TaskID === TaskID &&
                                item.SubTaskTypeID === SubTaskTypeID;
                        });
                        if (entry) {
                            var ActualtotalWeekHours = entry.ActualtotalWeekHours;
                        }
                        //End of Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                        for (var k = 0; k < arrayWeekDays.length; k++) {
                            objDuration = document.getElementById('Duration_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + (k + 1));
                            TotalAllocationDuration = document.getElementById('TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            TotalActualDurationhidden = document.getElementById('TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID);
                            //Commented and Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                            var RequestParameters = {
                                WorkHrs: encodeURI(objQuickEntryDecimal),
                                Flag: encodeURI(2),
                            }
                            var objQuickEntryParam = JSON.stringify(RequestParameters);
                            var objQuickEntryDecimalValue = AJAXCallWithResult("/api/TimesheetEntryNew/ConvertDecimalToHourViceVersa", objQuickEntryParam, false);
                            
                            if (objDuration.value == "00:00" || objDuration.value == "00.00") {
                                totalEnteredHours = parseFloat(totalEnteredHours) + parseFloat(objQuickEntryDecimalValue);
                                var RequestParameters = {
                                    WorkHrs: encodeURI(totalEnteredHours),
                                    Flag: encodeURI(1),
                                }
                                var param = JSON.stringify(RequestParameters);
                                totalEnteredHours = AJAXCallWithResult("/api/TimesheetEntryNew/ConvertDecimalToHourViceVersa", param, false);
                                totalEnteredHours = totalEnteredHours.replace(':', '.');

                                //End of Commented and Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                            } else {
                                totalEnteredHours = parseFloat(totalEnteredHours) + parseFloat(objQuickEntryDecimalValue);
                                var RequestParameters = {
                                    WorkHrs: encodeURI(totalEnteredHours),
                                    Flag: encodeURI(1),
                                }
                                var param = JSON.stringify(RequestParameters);
                                totalEnteredHours = AJAXCallWithResult("/api/TimesheetEntryNew/ConvertDecimalToHourViceVersa", param, false);
                                totalEnteredHours = totalEnteredHours.replace(':', '.');
                            }
                            objNewtxtQuickEntry = objQuickEntryDecimal.toString().replace(':', '.');
                            objEntryDate = $("input[data-ProjectID-id='" + ProjectID + "'][data-TaskID-id='" + TaskID + "'][data-Day-id='" + (k + 1) + "']").data('entrydate-id');
                            if (objDuration.value == "00:00" || objDuration.value == "00.00") {
                                //Commented and Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                                //totalEnteredNewHours = parseFloat(totalEnteredNewHours) + parseFloat(objQuickEntryDecimal);
                                totalEnteredNewHours = parseFloat(totalEnteredNewHours) + parseFloat(objQuickEntryDecimalValue);
                                //End of Commented and Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                                var taskParameters = {
                                    intEmployeeID: parseInt(SessionEmployeeId),
                                    dtFromDate: objEntryDate,
                                    ProjectID: ProjectID,
                                    TaskID: TaskID,
                                    SubTaskTypeID: SubTaskTypeID,                                    
                                    Duration: parseFloat(objNewtxtQuickEntry),
                                    //Commented and Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                                    //TotalDuration: totalEnteredHours,
                                    //TotalDuration: ActualtotalWeekHours,
                                    TotalDuration: ActualtotalWeekHours + parseFloat(objQuickEntryDecimalValue),
                                    //End of Commented and Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo                                    
                                    IsTaskComplete: 0,
                                    Flag: "",
                                }
                                var param = JSON.stringify(taskParameters);
                                var data = AJAXCallWithResult("/api/TimesheetEntryNew/ValidateDA", param, false);
                                if (data == "") {
                                    var RequestParameters = {
                                        WorkHrs: encodeURI(TotalAllocationDuration.value),
                                        Flag: encodeURI(2),
                                    }
                                    var param2 = JSON.stringify(RequestParameters);
                                    var TotalAllocationDecimal = AJAXCallWithResult("/api/TimesheetEntryNew/ConvertDecimalToHourViceVersa", param2, false);
                                    if ($('#WhichTask_' + TaskID).val() != 'D') {
                                        //Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                                        //if (parseFloat(totalEnteredDynamicHours) + parseFloat(totalActualPreviousWeekHours) + parseFloat(totalEnteredNewHours) <= parseFloat(TotalAllocationDecimal)) {
                                        //if (parseFloat(totalEnteredDynamicHours) + parseFloat(ActualtotalWeekHours) + parseFloat(totalEnteredNewHours) <= parseFloat(TotalAllocationDecimal)) {
                                        //End of Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo 
                                        objDuration.value = objtxtQuickEntry.replace('.', ':');
                                        quickflag = 1;
                                        var entry = {
                                            TaskID: taskParameters.TaskID,
                                            ProjectID: taskParameters.ProjectID,
                                            EmployeeID: taskParameters.intEmployeeID,
                                            EntryDate: taskParameters.dtFromDate,
                                            Duration: taskParameters.Duration,
                                            SubTaskTypeID: taskParameters.SubTaskTypeID,
                                            TotalDuration: taskParameters.TotalDuration,
                                            IsTaskComplete: taskParameters.IsTaskComplete,
                                        };
                                        timesheetEntriesQuickEntry.push(entry);
                                        //Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                                        timesheetQuickEntryExpand.push(entry);
                                        SaveTimesheetQuickEntries();
                                        timesheetEntriesQuickEntry = [];
                                        //End of Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                                        //}
                                        //else {
                                        //    errorFlag = 1;
                                        //    objDuration.value = "00:00";
                                        //}
                                        //Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                                        ActualtotalWeekHours = ActualtotalWeekHours + parseFloat(objQuickEntryDecimalValue);
                                        //End of Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                                    }
                                    else {
                                        quickflag = 1;
                                        errorFlag = 0;
                                        objDuration.value = objtxtQuickEntry.replace('.', ':');
                                        var entry = {
                                            TaskID: taskParameters.TaskID,
                                            ProjectID: taskParameters.ProjectID,
                                            EmployeeID: taskParameters.intEmployeeID,
                                            EntryDate: taskParameters.dtFromDate,
                                            Duration: taskParameters.Duration,
                                            SubTaskTypeID: taskParameters.SubTaskTypeID,
                                            TotalDuration: taskParameters.TotalDuration,
                                            IsTaskComplete: taskParameters.IsTaskComplete,
                                        };
                                        timesheetEntriesQuickEntry.push(entry);
                                        //Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                                        timesheetQuickEntryExpand.push(entry);
                                        SaveTimesheetQuickEntries();
                                        timesheetEntriesQuickEntry = [];
                                        //End of Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo

                                        //Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                                        ActualtotalWeekHours = ActualtotalWeekHours + parseFloat(objQuickEntryDecimalValue);
                                        //End of Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                                    }
                                }
                                else {
                                    errorFlag = 1;
                                    objDuration.value = "00:00";
                                }
                            }
                            else
                            {
                                //Commented by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                var taskParameters = {
                                    intEmployeeID: parseInt(SessionEmployeeId),
                                    dtFromDate: objEntryDate,
                                    ProjectID: ProjectID,
                                    TaskID: TaskID,
                                    SubTaskTypeID: SubTaskTypeID,
                                    Duration: parseFloat(objNewtxtQuickEntry),
                                    //Commented and Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                                    //TotalDuration: totalEnteredHours,
                                    //TotalDuration: ActualtotalWeekHours,
                                    TotalDuration: ActualtotalWeekHours + parseFloat(objQuickEntryDecimalValue),
                                    //End of Commented and Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                                    IsTaskComplete: 0,
                                    Flag: "",
                                }
                                var param = JSON.stringify(taskParameters);                                
                                var IsValidEntry = AJAXCallWithResult("/api/TimesheetEntryNew/ValidateDA", param, false);
                                var IsDAFilled = AJAXCallWithResult("/api/TimesheetEntryNew/IsDailyActivityFilled", param, false);
                                if (IsDAFilled == "1" && IsValidEntry == "") {
                                    quickflag = 1;
                                    errorFlag = 0;
                                    objDuration.value = objtxtQuickEntry.replace('.', ':');
                                    var entry = {
                                        TaskID: taskParameters.TaskID,
                                        ProjectID: taskParameters.ProjectID,
                                        EmployeeID: taskParameters.intEmployeeID,
                                        EntryDate: taskParameters.dtFromDate,
                                        Duration: taskParameters.Duration,
                                        SubTaskTypeID: taskParameters.SubTaskTypeID,
                                        TotalDuration: taskParameters.TotalDuration,
                                        IsTaskComplete: taskParameters.IsTaskComplete,
                                    };
                                    timesheetEntriesQuickEntry.push(entry);                                    
                                    timesheetQuickEntryExpand.push(entry);
                                    SaveTimesheetQuickEntries();
                                    timesheetEntriesQuickEntry = [];
                                    //Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                                    ActualtotalWeekHours = ActualtotalWeekHours + parseFloat(objQuickEntryDecimalValue);
                                    //End of Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                                }
                                //End of Commented by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            }
                        }
                    }
                    if (errorFlag == 1) {
                        totalEnteredNewHours = 0;
                        setTimeout(function () {
                            //alertify.error('Some of the days are not allowed to fill DA for task.');
                            //alertify.error('Some of the days are not allowed to fill daily activity as they fall outside the allowed date range for this task.');
                            alertify.error('<%=MyBase.GetResourceString("A_QuickEntryGeneric")%>');
                        }, 2000);
                        $("#txtQuickEntry").focus();
                    }
                    if (quickflag == 1) {
                        //Commented and Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo
                        //SaveTimesheetQuickEntries();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('<%=MyBase.GetResourceString("A_DASaved")%>');

                        GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                        GetTaskData(SessionEmployeeId);
                        var QuickEntryPID = 0;
                        var processedProjectIDs = new Set();
                        for (var i = 0; i < timesheetQuickEntryExpand.length; i++) {
                            QuickEntryPID = timesheetQuickEntryExpand[i]["ProjectID"];
                            if (!processedProjectIDs.has(QuickEntryPID)) {
                                var thisElement = $('[data-bs-target=".superTab' + QuickEntryPID + '"]');
                                PlotTaskDetails(QuickEntryPID, SessionEmployeeId, thisElement);
                                $(`.superTab${QuickEntryPID}`).collapse('show');
                                processedProjectIDs.add(QuickEntryPID);
                            }
                        }
                        //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                        EnableDisbaleDATextbox();
                        //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature

                        //End of Commented and Added by Vishal Mane on 13/06/2025 to fix 24 hours validation issue for Expleo                    
                    }
                }
            }
            else if (TimesheetStatus == "Approved")
            {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Quick entry is not allowed for a approved timesheet.');
            }
            else if (TimesheetStatus == "Ready for approval")
            {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Quick entry is not allowed for a submitted timesheet.");
            }
        }

        function SaveTimesheetQuickEntries() {
            //debugger           
            $.ajax({
                url: strUrl + '/api/TimesheetEntryNew/SaveDailyActivity',
                type: "POST",
                data: { '': timesheetEntriesQuickEntry },
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    if (timesheetEntries) {
                        xhr.setRequestHeader("Params", encryptString(isJson(timesheetEntries) ? timesheetEntries : JSON.stringify(timesheetEntries)));
                    }
                },
                success: function (data) {
                    if (data == 1) {
                    } else if (data == 2) {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.success('Daily Activity updated successfully.');
                        alertify.success('<%=MyBase.GetResourceString("A_DAUpdated")%>');                        
                        var QuickEntryPID = 0;
                        var processedProjectIDs = new Set();
                        for (var i = 0; i < timesheetEntriesQuickEntry.length; i++) {
                            QuickEntryPID = timesheetEntriesQuickEntry[i]["ProjectID"];
                            if (!processedProjectIDs.has(QuickEntryPID)) {
                                var thisElement = $('[data-bs-target=".superTab' + QuickEntryPID + '"]');
                                PlotTaskDetails(QuickEntryPID, SessionEmployeeId, thisElement);
                                $(`.superTab${QuickEntryPID}`).collapse('show');
                                processedProjectIDs.add(QuickEntryPID);
                            }
                        }
                    }
                    timesheetEntriesQuickEntry = [];
                },
                error: function (err) {
                    //Commented by Vishal Mane on 11/08/2025 to fix issue of Transaction was deadlocked on lock resources with another process
                    //alertify.success('Error found');
                    console.log(err);
                    //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //End of Commented by Vishal Mane on 11/08/2025 to fix issue of Transaction was deadlocked on lock resources with another process
                }
            });
        }

        function formatTime(value) {
            if (!value) return '00:00'; // Handle empty or null values
            value = value.toString().replace('.', ':'); // Convert to string and replace decimal point with colon
            let parts = value.split(':');
            if (parts.length === 1) parts.push('00'); // Add minutes if missing
            let hours = parts[0].padStart(2, '0'); // Ensure hours are 2 digits
            let minutes = parts[1].padEnd(2, '0').slice(0, 2); // Ensure minutes are 2 digits
            return `${hours}:${minutes}`;
        }

        var itemsToShowInitially = 0;
        var itemsToShow = 0;
        var visibleItems = 0;
        //Commented by Vishal Mane on 10/01/2025 to expand all Approved Project Details
        function GetTaskData(ProxyResourceID) {
            //debugger
            $("#TimesheetInfoTbl_Body").empty();
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //var EmployeeID = '<%= Session("intUserID") %>'.toString();
            var EmployeeID = SessionEmployeeId;
            //Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //TotalHoliday = 0;
            //if (ProxyResourceID == 0)
            //    ProxyResourceID = EmployeeID;
            //else
            //    EmployeeID = ProxyResourceID;
            //End of Commented by Vishal Mane on 12/08/2025 to display the timesheet entry only for selected users
            var taskParameters = {
                intEmployeeID: ProxyResourceID,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),  //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                WhereClause: WhereClause
            }
            var param = JSON.stringify(taskParameters);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/GetTaskData", param, false);
            ProjectList = Result; //Added by Ajit L on 06/12/2024 
            var strHTML = "";
            for (var i = 0; i < Result.length; i++) {
                console.log(Result[i]["ResourcePercentage"]);
                strHTML += '<tr class="projectRow parentRow showDetails_' + Result[i]["ProjectID"] + '"><td class="py-0"><h2 class="accordion-header">';
                strHTML += '<button class="accordion-button NestedAccBtn collapsed" type="button" data-bs-toggle="collapse" data-bs-target=".superTab' + Result[i]["ProjectID"] + '" aria-expanded="true" onclick="PlotTaskDetails(' + Result[i]["ProjectID"] + ', ' + ProxyResourceID + ', this);">';
                strHTML += '<img src="../../../Whizible2.0-new/dist/img/Projects_icon_blue.svg" class="me-2" alt="Project Icon">';
                strHTML += '<span class="flex-grow-1 projTitle">' + Result[i]["ProjectName"] + '</span><i class="fas fa-chevron-down ms-auto"></i></button></h2></td>';
                strHTML += '<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>';
            }
            $("#TimesheetInfoTbl_Body").html(strHTML);              
            if (Result.length > 2) {
                $("#loadMoreBtn").show();
                itemsToShowInitially = 3;
                itemsToShow = 3;
                visibleItems = itemsToShowInitially;
                $('#TimesheetInfoTbl tbody tr.parentRow').hide();
                $('#TimesheetInfoTbl tbody tr.parentRow:lt(' + visibleItems + ')').show();
                if ($('#TimesheetInfoTbl tbody tr.parentRow:visible').length <= 3) {
                    $('#loadLessBtn').hide();
                }
                else {
                    $('#loadLessBtn').show();
                }
                if (Result.length <= 3) {
                    $("#loadMoreBtn").hide();
                    $('#loadLessBtn').hide();
                }
            } else {
                $("#loadMoreBtn").hide();
                $('#loadLessBtn').hide();
            }
            if (TimesheetStatus == "Approved") {
                if (Result.length <= 2) {
                    for (var i = 0; i < Result.length; i++) {
                        if (Result[i]["TimesheetStatusFlag"] == "V") {
                            var thisElement = $('[data-bs-target=".superTab' + Result[i]["ProjectID"] + '"]');
                            PlotTaskDetails(Result[i]["ProjectID"], SessionEmployeeId, thisElement);
                            $('#TimesheetInfoTbl tbody tr.showDetails_' + Result[i]["ProjectID"] + '').show();
                            $(`.superTab${Result[i]["ProjectID"]}`).collapse('show');
                        }
                    }
                }
                else {
                    for (var i = 0; i < 3; i++) {
                        if (Result[i]["TimesheetStatusFlag"] == "V") {
                            var thisElement = $('[data-bs-target=".superTab' + Result[i]["ProjectID"] + '"]');
                            PlotTaskDetails(Result[i]["ProjectID"], SessionEmployeeId, thisElement);
                            $('#TimesheetInfoTbl tbody tr.showDetails_' + Result[i]["ProjectID"] + '').show();
                            $(`.superTab${Result[i]["ProjectID"]}`).collapse('show');
                        }
                    }
                }
            }
            //Added by Vishal Mane on 30/05/2025 to expand projects where the daily activity has been filled 
            else {
                if (Result.length <= 2) {
                    for (var i = 0; i < Result.length; i++) {
                        if (Result[i]["IsDAFilled"] == "1") {
                            var thisElement = $('[data-bs-target=".superTab' + Result[i]["ProjectID"] + '"]');
                            PlotTaskDetails(Result[i]["ProjectID"], SessionEmployeeId, thisElement);
                            $('#TimesheetInfoTbl tbody tr.showDetails_' + Result[i]["ProjectID"] + '').show();
                            $(`.superTab${Result[i]["ProjectID"]}`).collapse('show');
                        }
                    }
                }
                else {
                    for (var i = 0; i < 3; i++) {
                        if (Result[i]["IsDAFilled"] == "1") {
                            var thisElement = $('[data-bs-target=".superTab' + Result[i]["ProjectID"] + '"]');
                            PlotTaskDetails(Result[i]["ProjectID"], SessionEmployeeId, thisElement);
                            $('#TimesheetInfoTbl tbody tr.showDetails_' + Result[i]["ProjectID"] + '').show();
                            $(`.superTab${Result[i]["ProjectID"]}`).collapse('show');
                        }
                    }
                }
            }
            //End of Added by Vishal Mane on 30/05/2025 to expand projects where the daily activity has been filled

        }
        //End of Commented by Vishal Mane on 10/01/2025 to expand all Approved Project Details
        $('#loadMoreBtn').click(function () {
            //debugger
            visibleItems += itemsToShow;
            $('#TimesheetInfoTbl tbody tr.parentRow').hide();
            $('#TimesheetInfoTbl tbody tr.parentRow:lt(' + visibleItems + ')').show();
            if (visibleItems >= $('#TimesheetInfoTbl tbody tr.parentRow').length) {
                $('#loadMoreBtn').hide();
            }
            $('#loadLessBtn').show();

        });
        $('#loadLessBtn').click(function () {
            // Collapse all child rows before hiding parent rows
            $('#TimesheetInfoTbl tbody tr.childRow').each(function () {
                if ($(this).hasClass('show')) {
                    $(this).removeClass('show'); // Collapse Bootstrap accordion
                }
            });
            // Hide and show parent rows based on updated visibleItems
            $('#TimesheetInfoTbl tbody tr.parentRow').hide();
            visibleItems -= itemsToShow;
            $('#TimesheetInfoTbl tbody tr.parentRow:lt(' + visibleItems + ')').show();

            if (visibleItems <= itemsToShowInitially) {
                $(this).hide();
            }
            $('#loadMoreBtn').show();
        });

        function isValidDate(date) {
            return !isNaN(new Date(date).getTime());
        }
        var counter = 0;
        function PlotTaskDetails(ProjectID, ProxyResourceID, button) {
            //debugger
            //var closestTr = $(this).closest('tr[data-bs-target="superTab9"]');
            var parentRow = $(button).closest('tr');
            var childRow = parentRow.next('.childRow');
            if (childRow.length) {
                if (childRow.hasClass('collapse')) {
                    childRow.collapse('show');
                } else {
                    childRow.collapse('hide');
                }
            }else {
                var taskParameters = {
                    intEmployeeID: ProxyResourceID,
                    dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                    dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                    ProjectID: ProjectID,
                    WhereClause: WhereClause
                }
                var param = JSON.stringify(taskParameters);
                var Result = AJAXCallWithResult("/api/TimesheetEntryNew/PlotTaskDetails", param, false);
                var strHTML = "";
                var dtFromDate1 = new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                var dtToDate1 = new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                var IsDisableCheckbox = 0;
                if (TimesheetStatus == "Approved") {
                    for (var i = 0; i < Result.length; i++) {
                        //Task Binding starts here 
                        IsDisableCheckbox = 0;
                        if (Result[i]["TaskID"] !== null) {
                            var task = Result[i];
                            var TaskID = task.TaskID;
                            var SubTaskTypeID = task.SubTaskTypeID;
                            var TaskName = task.TaskName;
                            var ProjectID = task.ProjectID;
                            var ProjectName = task.ProjectName;
                            var MonDAID = task.MonDAID || 0;
                            var TueDAID = task.TueDAID || 0;
                            var WedDAID = task.WedDAID || 0;
                            var ThuDAID = task.ThuDAID || 0;
                            var FriDAID = task.FriDAID || 0;
                            var SatDAID = task.SatDAID || 0;
                            var SunDAID = task.SunDAID || 0;
                            var Mon = formatTime(task.Mon);
                            var Tue = formatTime(task.Tue);
                            var Wed = formatTime(task.Wed);
                            var Thu = formatTime(task.Thu);
                            var Fri = formatTime(task.Fri);
                            var Sat = formatTime(task.Sat);
                            var Sun = formatTime(task.Sun);
                            var ActualWork = formatTime(task.ActualWork);
                            var TaskActualWork = formatTime(task.TaskActualWork);
                            var MonStoryPoint = task.MonStoryPoint ? task.MonStoryPoint : 0;
                            var TueStoryPoint = task.TueStoryPoint ? task.TueStoryPoint : 0;
                            var WedStoryPoint = task.WedStoryPoint ? task.WedStoryPoint : 0;
                            var ThuStoryPoint = task.ThuStoryPoint ? task.ThuStoryPoint : 0;
                            var FriStoryPoint = task.FriStoryPoint ? task.FriStoryPoint : 0;
                            var SatStoryPoint = task.SatStoryPoint ? task.SatStoryPoint : 0;
                            var SunStoryPoint = task.SunStoryPoint ? task.SunStoryPoint : 0;
                            var MonDescription = task.MonDescription;
                            var TueDescription = task.TueDescription;
                            var WedDescription = task.WedDescription;
                            var ThuDescription = task.ThuDescription;
                            var FriDescription = task.FriDescription;
                            var SatDescription = task.SatDescription;
                            var SunDescription = task.SunDescription;
                            var ActualPercentComplete = task.ActualPercentComplete;
                            var ResourcePercentComplete = task.ResourcePercentComplete;
                            var IsTaskComplete = task.IsTaskComplete;
                            if (IsTaskComplete == true) {
                                IsTaskComplete = 1;
                            } else if (IsTaskComplete == false || IsTaskComplete == null) {
                                IsTaskComplete = 0;
                            }
                            if (MonDAID != 0 || TueDAID != 0 || WedDAID != 0 || ThuDAID != 0 || FriDAID != 0 || SatDAID != 0 || SunDAID != 0 || IsTaskComplete == 1) {
                                IsDisableCheckbox = 1;
                            }
                            var WhichTask = task.WhichTask;
                            var SubTaskTypeID = task.SubTaskTypeID;
                            if (SubTaskTypeID == null) {
                                SubTaskTypeID = 0;
                            }
                            var IsProject = task.IsProject;
                            var Percentage = task.Percentage;
                            var IsAgileProject = task.IsAgileProject;
                            var ResourceLevelTaskCompletion = task.ResourceLevelTaskCompletion;
                            if (ResourceLevelTaskCompletion == true) {
                                ResourceLevelTaskCompletion = 1;
                            } else if (ResourceLevelTaskCompletion == false || ResourceLevelTaskCompletion == null) {
                                ResourceLevelTaskCompletion = 0;
                            }
                            var ApplyEffortDistribution = task.ApplyEffortDistribution;
                            var AllowActivityLevelDA = task.AllowActivityLevelDA;
                            var IsVerified = task.IsVerified;
                            var IsApprover = task.IsApprover;
                            var StatusFlag = task.StatusFlag; if (StatusFlag == null) { StatusFlag = ""; }
                            var MonStatusFlag = task.MonStatusFlag;
                            var TueStatusFlag = task.TueStatusFlag;
                            var WedStatusFlag = task.WedStatusFlag;
                            var ThuStatusFlag = task.ThuStatusFlag;
                            var FriStatusFlag = task.FriStatusFlag;
                            var SatStatusFlag = task.SatStatusFlag;
                            var SunStatusFlag = task.SunStatusFlag;

                            var MonAllowToResubmit = task.MonAllowToResubmit;
                            var TueAllowToResubmit = task.TueAllowToResubmit;
                            var WedAllowToResubmit = task.WedAllowToResubmit;
                            var ThuAllowToResubmit = task.ThuAllowToResubmit;
                            var FriAllowToResubmit = task.FriAllowToResubmit;
                            var SatAllowToResubmit = task.SatAllowToResubmit;
                            var SunAllowToResubmit = task.SunAllowToResubmit;
                            var TaskStatusFlag = task.TaskStatusFlag;
                            if(TimesheetStatus === "Rejected" && StatusFlag === "V"){
                                StatusFlag = "J";
                            }
                            var IsSubTaskFilled = task.IsSubTaskFilled;
                            var RestrictByMinHours = task.RestrictByMinHours;
                            GlobalRestrictByMinHours = RestrictByMinHours;
                            var ActualStartDate = task.ActualStartDate;
                            var ActualEndDate = task.ActualEndDate;
                            var Work = task.Work;
                            //Commented by Vishal Mane on 09/01/2024 to fix generic task issue
                            if (StatusFlag == "V") {
                                if (IsTaskComplete == 0) {
                                    strHTML += `<tr class="projectRow childRow accordion-collapse collapse  superTab${ProjectID} HideProjectDetails${ProjectID}" >
                                    <td class="">
                                        <div class="accordion-header d-flex justify-content-between px-2">
                                            <img src="../../../Whizible2.0-new/dist/img/task-icon.svg" alt="Task Image" class="taskIcn">
                                            <button class="accordion-button TaskAccBtn" type="button">
                                                ${Result[i]["TaskName"]}
                                            </button>
                                            <div data-bs-toggle="tooltip" title="Task Info">
                                                    <img src="../../../Whizible2.0-new/dist/img/info-circle.svg"
                                                            alt="More Info"
                                                            class="infoIcn cursorArrow ms-2"
                                                            onclick="showProjectTaskInfo(this, ${TaskID})"
                                                            tabindex="0">
                                                </div>
                                        </div>
                                    </td>
                                    <td>`
                                    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} />`
                                    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                    //End of Commented by Vishal Mane on 28/05/2025 to enable quickentry checkbox for all tasks for Expleo customization
                                    strHTML += `</td> <td><div class="d-flex align-items-center">`

                                    var dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }));             //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1" readonly>`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}" />`;
                                    }
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${MonDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${MonDescription ? MonDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (MonDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + MonDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 1));
                                    if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2" readonly>`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${TueAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}" />`;
                                    }
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${TueDAID}" placeholder="Enter Description..." maxlength='2000'>${TueDescription ? TueDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (TueDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + TueDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 2));
                                    if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}"  id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3" readonly>`                      //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${WedAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}" />`;
                                    }
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${WedDAID}" placeholder="Enter Description..." maxlength='2000'>${WedDescription ? WedDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (WedDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + WedDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 3));
                                    if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4" readonly>`               //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${ThuAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}" />`;
                                    }
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${ThuDAID}" placeholder="Enter Description..." maxlength='2000'>${ThuDescription ? ThuDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (ThuDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + ThuDAID + ',1)">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 4));
                                    if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5" readonly>`               //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${FriAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}" />`;
                                    }
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${FriDAID}" placeholder="Enter Description..." maxlength='2000'>${FriDescription ? FriDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (FriDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + FriDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 5));
                                    if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6" readonly>`               //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SatAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}" />`;
                                    }
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SatDAID}" placeholder="Enter Description..." maxlength='2000'>${SatDescription ? SatDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (SatDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SatDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 6));
                                    if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7" readonly>`           //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SunAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" />`;
                                    }
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5"  data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SunDAID}" placeholder="Enter Description..." maxlength='2000'>${SunDescription ? SunDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (SunDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SunDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    //if (WhichTask != 'D') {
                                    //    strHTML += `<td hidden>${ActualPercentComplete} %</td>`
                                    //} else {
                                    //    strHTML += `<td hidden></td>`
                                    //}
                                    if (WhichTask != 'D') {
                                        if (SubTaskTypeID == 0) {
                                            if (ResourceLevelTaskCompletion == 1) {
                                                strHTML += '<td>'
                                                strHTML += `<div class="">`
                                                if (IsTaskComplete == 1) {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl" checked disabled style="cursor:not-allowed!important;>'
                                                } else {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl">'
                                                }
                                                strHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            } else {
                                                strHTML += '<td>'
                                                strHTML += `<div class="custom_chckbox">N/A`
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            }
                                        } else {
                                            strHTML += '<td>'
                                            strHTML += `<div class="custom_chckbox">N/A`
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`
                                        }
                                    }
                                    else {
                                        strHTML += '<td>'
                                        strHTML += `<div class="custom_chckbox">`
                                        strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                        strHTML += `</div></td>`
                                    }
                                    strHTML += `<td><label class="totalTxt" name="pro_Calculate_count_${TaskID}" id="lblWeeklyTotal_${ProjectID}_${TaskID}_${SubTaskTypeID}">${ActualWork}</label>`
                                    strHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                                    strHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>'
                                    strHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input></td></tr>';

                                }
                                else if (IsTaskComplete == 1 && ActualStartDate != null && ActualEndDate != null && (
                                    (isValidDate(dtFromDate1) && isValidDate(ActualStartDate) && new Date(dtFromDate1) >= new Date(ActualStartDate) && new Date(dtFromDate1) <= new Date(dtToDate1)) ||
                                    (isValidDate(dtToDate1) && isValidDate(ActualEndDate) && new Date(dtToDate1) >= new Date(ActualEndDate) && new Date(dtFromDate1) <= new Date(ActualEndDate))
                                )) {
                                    strHTML += `<tr class="projectRow childRow accordion-collapse collapse  superTab${ProjectID} HideProjectDetails${ProjectID}" >
                                <td class="">
                                    <div class="accordion-header d-flex justify-content-between px-2">
                                        <img src="../../../Whizible2.0-new/dist/img/task-icon.svg" alt="Task Image" class="taskIcn">
                                        <button class="accordion-button TaskAccBtn" type="button">
                                            ${Result[i]["TaskName"]}
                                        </button>
                                        <div data-bs-toggle="tooltip" title="Task Info">
                                                <img src="../../../Whizible2.0-new/dist/img/info-circle.svg"
                                                        alt="More Info"
                                                        class="infoIcn cursorArrow ms-2"
                                                        onclick="showProjectTaskInfo(this, ${TaskID})"
                                                        tabindex="0">
                                            </div>
                                    </div>
                                </td>
                                <td>
                                    <input id="TaskSelect11" class="parentCheckbox me-2" type="checkbox" name="" />
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">`

                                    var dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }));         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1" readonly disabled>`             //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}" />`;
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${MonDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${MonDescription ? MonDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (MonDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + MonDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 1));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${TueAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2" readonly disabled>`         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}" />`;
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${TueDAID}" placeholder="Enter Description..." maxlength='2000'>${TueDescription ? TueDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (TueDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + TueDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 2));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${WedAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3" readonly disabled>`         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}" />`;
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${WedDAID}" placeholder="Enter Description..." maxlength='2000'>${WedDescription ? WedDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (WedDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + WedDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 3));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${ThuAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4" readonly disabled>`         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}" />`;
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${ThuDAID}" placeholder="Enter Description..." maxlength='2000'>${ThuDescription ? ThuDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (ThuDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + ThuDAID + ',1)">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 4));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${FriAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5" readonly disabled>`         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}" />`;
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${FriDAID}" placeholder="Enter Description..." maxlength='2000'>${FriDescription ? FriDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (FriDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + FriDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 5));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SatAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6" readonly disabled>`         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}" />`;
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    //strHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" value="' + SatAllowToResubmit + '" />';
                                    //strHTML += '<input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US",{ timeZone: "Asia/Kolkata" })) + '" name="">';     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    //strHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + SatDAID + '" name="">';
                                    //strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SatDAID}" placeholder="Enter Description..." maxlength='2000'>${SatDescription ? SatDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (SatDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SatDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 6));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SunAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7" readonly disabled>`          //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" />`;
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5"  data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SunDAID}" placeholder="Enter Description..." maxlength='2000'>${SunDescription ? SunDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (SunDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SunDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    //Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    //if (WhichTask != 'D') {
                                    //    strHTML += `<td>${ActualPercentComplete} %</td>`
                                    //} else {
                                    //    strHTML += `<td></td>`
                                    //}
                                    //End of Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    if (WhichTask != 'D') {
                                        if (SubTaskTypeID == 0) {
                                            if (ResourceLevelTaskCompletion == 1) {
                                                strHTML += '<td>'
                                                strHTML += `<div class="">`
                                                if (IsTaskComplete == 1) {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl" checked disabled style="cursor:not-allowed!important;>'
                                                } else {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl">'
                                                }
                                                strHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            } else {
                                                strHTML += '<td>'
                                                strHTML += `<div class="custom_chckbox">N/A`
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            }
                                        } else {
                                            strHTML += '<td>'
                                            strHTML += `<div class="custom_chckbox">N/A`
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`
                                        }
                                    }
                                    else {
                                        strHTML += '<td>'
                                        strHTML += `<div class="custom_chckbox">`
                                        strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                        strHTML += `</div></td>`
                                    }
                                    strHTML += `<td><label class="totalTxt" name="pro_Calculate_count_${TaskID}" id="lblWeeklyTotal_${ProjectID}_${TaskID}_${SubTaskTypeID}">${ActualWork}</label>`
                                    strHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                                    strHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>'
                                    strHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input></td></tr>';
                                }
                            }
                            else if (WhereClause != "") {
                                if (IsTaskComplete == 0) {
                                    strHTML += `<tr class="projectRow childRow accordion-collapse collapse  superTab${ProjectID} HideProjectDetails${ProjectID}" >
                                <td class="">
                                    <div class="accordion-header d-flex justify-content-between px-2">
                                        <img src="../../../Whizible2.0-new/dist/img/task-icon.svg" alt="Task Image" class="taskIcn">
                                        <button class="accordion-button TaskAccBtn" type="button">
                                            ${Result[i]["TaskName"]}
                                        </button>
                                        <div data-bs-toggle="tooltip" title="Task Info">
                                                <img src="../../../Whizible2.0-new/dist/img/info-circle.svg"
                                                        alt="More Info"
                                                        class="infoIcn cursorArrow ms-2"
                                                        onclick="showProjectTaskInfo(this, ${TaskID})"
                                                        tabindex="0">
                                            </div>
                                    </div>
                                </td>
                                <td>`
                                    //Commented by Vishal Mane on 28/05/2025 to enable quickentry checkbox for all tasks for Expleo customization
                                    //if (IsDisableCheckbox == 1) {
                                    //    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} disabled/>`
                                    //    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                    //} else {
                                    //    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} />`
                                    //    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                    //}
                                    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} />`
                                    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                    //End of Commented by Vishal Mane on 28/05/2025 to enable quickentry checkbox for all tasks for Expleo customization

                                    strHTML += `</td> <td><div class="d-flex align-items-center">`

                                    var dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }));     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1" readonly>`           //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}" />`;
                                    }
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${MonDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${MonDescription ? MonDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (MonDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + MonDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 1));
                                    if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2" readonly>`           //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${TueAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}" />`;
                                    }
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${TueDAID}" placeholder="Enter Description..." maxlength='2000'>${TueDescription ? TueDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (TueDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + TueDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 2));
                                    if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}"  id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3" readonly>`          //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${WedAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}" />`;
                                    }
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${WedDAID}" placeholder="Enter Description..." maxlength='2000'>${WedDescription ? WedDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (WedDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + WedDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 3));
                                    if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4" readonly>`           //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${ThuAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}" />`;
                                    }
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${ThuDAID}" placeholder="Enter Description..." maxlength='2000'>${ThuDescription ? ThuDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (ThuDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + ThuDAID + ',1)">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 4));
                                    if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5" readonly>`           //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${FriAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}" />`;
                                    }
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${FriDAID}" placeholder="Enter Description..." maxlength='2000'>${FriDescription ? FriDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (FriDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + FriDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 5));
                                    if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6" readonly>`               //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SatAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}" />`;
                                    }
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    //strHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" value="' + SatAllowToResubmit + '" />';
                                    //strHTML += '<input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US",{ timeZone: "Asia/Kolkata" })) + '" name="">';     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    //strHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + SatDAID + '" name="">';
                                    //strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SatDAID}" placeholder="Enter Description..." maxlength='2000'>${SatDescription ? SatDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (SatDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SatDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 6));
                                    if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7" readonly>`           //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SunAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" />`;
                                    }
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5"  data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SunDAID}" placeholder="Enter Description..." maxlength='2000'>${SunDescription ? SunDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (SunDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SunDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    //Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    //if (WhichTask != 'D') {
                                    //    strHTML += `<td>${ActualPercentComplete} %</td>`
                                    //} else {
                                    //    strHTML += `<td></td>`
                                    //}
                                    //End of Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    if (WhichTask != 'D') {
                                        if (SubTaskTypeID == 0) {
                                            if (ResourceLevelTaskCompletion == 1) {
                                                strHTML += '<td>'
                                                strHTML += `<div class="">`
                                                if (IsTaskComplete == 1) {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl" checked disabled style="cursor:not-allowed!important;>'
                                                } else {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl">'
                                                }
                                                strHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            } else {
                                                strHTML += '<td>'
                                                strHTML += `<div class="custom_chckbox">N/A`
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            }
                                        } else {
                                            strHTML += '<td>'
                                            strHTML += `<div class="custom_chckbox">N/A`
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`
                                        }
                                    }
                                    else {
                                        strHTML += '<td>'
                                        strHTML += `<div class="custom_chckbox">`
                                        strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                        strHTML += `</div></td>`
                                    }
                                    strHTML += `<td><label class="totalTxt" name="pro_Calculate_count_${TaskID}" id="lblWeeklyTotal_${ProjectID}_${TaskID}_${SubTaskTypeID}">${ActualWork}</label>`
                                    strHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                                    strHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>'
                                    strHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input></td></tr>';

                                }
                                else if (IsTaskComplete == 1 && ActualStartDate != null && ActualEndDate != null && (
                                    (isValidDate(dtFromDate1) && isValidDate(ActualStartDate) && new Date(dtFromDate1) >= new Date(ActualStartDate) && new Date(dtFromDate1) <= new Date(dtToDate1)) ||
                                    (isValidDate(dtToDate1) && isValidDate(ActualEndDate) && new Date(dtToDate1) >= new Date(ActualEndDate) && new Date(dtFromDate1) <= new Date(ActualEndDate))
                                )) {
                                    strHTML += `<tr class="projectRow childRow accordion-collapse collapse  superTab${ProjectID} HideProjectDetails${ProjectID}" >
                                <td class="">
                                    <div class="accordion-header d-flex justify-content-between px-2">
                                        <img src="../../../Whizible2.0-new/dist/img/task-icon.svg" alt="Task Image" class="taskIcn">
                                        <button class="accordion-button TaskAccBtn" type="button">
                                            ${Result[i]["TaskName"]}
                                        </button>
                                        <div data-bs-toggle="tooltip" title="Task Info">
                                                <img src="../../../Whizible2.0-new/dist/img/info-circle.svg"
                                                        alt="More Info"
                                                        class="infoIcn cursorArrow ms-2"
                                                        onclick="showProjectTaskInfo(this, ${TaskID})"
                                                        tabindex="0">
                                            </div>
                                    </div>
                                </td>
                                <td>
                                    <input id="TaskSelect11" class="parentCheckbox me-2" type="checkbox" name="" />
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">`

                                    var dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }));         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1" readonly disabled>`             //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}" />`;
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${MonDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${MonDescription ? MonDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (MonDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + MonDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 1));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${TueAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2" readonly disabled>`         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}" />`;
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${TueDAID}" placeholder="Enter Description..." maxlength='2000'>${TueDescription ? TueDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (TueDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + TueDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 2));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${WedAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3" readonly disabled>`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}" />`;
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${WedDAID}" placeholder="Enter Description..." maxlength='2000'>${WedDescription ? WedDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (WedDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + WedDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 3));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${ThuAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4" readonly disabled>`         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}" />`;
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${ThuDAID}" placeholder="Enter Description..." maxlength='2000'>${ThuDescription ? ThuDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (ThuDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + ThuDAID + ',1)">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 4));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${FriAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5" readonly disabled>`         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}" />`;
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${FriDAID}" placeholder="Enter Description..." maxlength='2000'>${FriDescription ? FriDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (FriDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + FriDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 5));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SatAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6" readonly disabled>`         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}" />`;
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    //strHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" value="' + SatAllowToResubmit + '" />';
                                    //strHTML += '<input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US",{ timeZone: "Asia/Kolkata" })) + '" name="">';     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    //strHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + SatDAID + '" name="">';
                                    //strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SatDAID}" placeholder="Enter Description..." maxlength='2000'>${SatDescription ? SatDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (SatDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SatDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 6));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SunAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7" readonly disabled>`          //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" />`;
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5"  data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SunDAID}" placeholder="Enter Description..." maxlength='2000'>${SunDescription ? SunDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (SunDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SunDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div>`
                                    if (IsAgileProject == 1) {
                                        strHTML += '<span class="timeno">'
                                        strHTML += '<span class="selecttimeno">'
                                        if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                        }
                                        else {
                                            strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                        }
                                        strHTML += '</span>';
                                        strHTML += '</span>';
                                    }
                                    strHTML += `</td>`
                                    //Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    //if (WhichTask != 'D') {
                                    //    strHTML += `<td>${ActualPercentComplete} %</td>`
                                    //} else {
                                    //    strHTML += `<td></td>`
                                    //}
                                    //End of Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    if (WhichTask != 'D') {
                                        if (SubTaskTypeID == 0) {
                                            if (ResourceLevelTaskCompletion == 1) {
                                                strHTML += '<td>'
                                                strHTML += `<div class="">`
                                                if (IsTaskComplete == 1) {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl" checked disabled style="cursor:not-allowed!important;>'
                                                } else {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl">'
                                                }
                                                strHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            } else {
                                                strHTML += '<td>'
                                                strHTML += `<div class="custom_chckbox">N/A`
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            }
                                        } else {
                                            strHTML += '<td>'
                                            strHTML += `<div class="custom_chckbox">N/A`
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`
                                        }
                                    }
                                    else {
                                        strHTML += '<td>'
                                        strHTML += `<div class="custom_chckbox">`
                                        strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                        strHTML += `</div></td>`
                                    }
                                    strHTML += `<td><label class="totalTxt" name="pro_Calculate_count_${TaskID}" id="lblWeeklyTotal_${ProjectID}_${TaskID}_${SubTaskTypeID}">${ActualWork}</label>`
                                    strHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                                    strHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>'
                                    strHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input></td></tr>';
                                }
                            }

                        }
                        //Task Binding ends here
                        counter++;
                    }
                    parentRow.after(strHTML);
                    $(`.superTab${ProjectID}`).collapse('show');
                    //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                    EnableDisbaleDATextbox();
                    //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
                }
                else {
                    for (var i = 0; i < Result.length; i++) {
                        //Task Binding starts here 
                        IsDisableCheckbox = 0;
                        if (Result[i]["TaskID"] !== null) {
                            var task = Result[i];
                            var TaskID = task.TaskID;
                            var SubTaskTypeID = task.SubTaskTypeID;
                            var TaskName = task.TaskName;
                            var ProjectID = task.ProjectID;
                            var ProjectName = task.ProjectName;
                            var MonDAID = task.MonDAID || 0;
                            var TueDAID = task.TueDAID || 0;
                            var WedDAID = task.WedDAID || 0;
                            var ThuDAID = task.ThuDAID || 0;
                            var FriDAID = task.FriDAID || 0;
                            var SatDAID = task.SatDAID || 0;
                            var SunDAID = task.SunDAID || 0;
                            var Mon = formatTime(task.Mon);
                            var Tue = formatTime(task.Tue);
                            var Wed = formatTime(task.Wed);
                            var Thu = formatTime(task.Thu);
                            var Fri = formatTime(task.Fri);
                            var Sat = formatTime(task.Sat);
                            var Sun = formatTime(task.Sun);
                            var ActualWork = formatTime(task.ActualWork);
                            var TaskActualWork = formatTime(task.TaskActualWork);

                            var MonStoryPoint = task.MonStoryPoint ? task.MonStoryPoint : 0;
                            var TueStoryPoint = task.TueStoryPoint ? task.TueStoryPoint : 0;
                            var WedStoryPoint = task.WedStoryPoint ? task.WedStoryPoint : 0;
                            var ThuStoryPoint = task.ThuStoryPoint ? task.ThuStoryPoint : 0;
                            var FriStoryPoint = task.FriStoryPoint ? task.FriStoryPoint : 0;
                            var SatStoryPoint = task.SatStoryPoint ? task.SatStoryPoint : 0;
                            var SunStoryPoint = task.SunStoryPoint ? task.SunStoryPoint : 0;
                            var MonDescription = task.MonDescription;
                            var TueDescription = task.TueDescription;
                            var WedDescription = task.WedDescription;
                            var ThuDescription = task.ThuDescription;
                            var FriDescription = task.FriDescription;
                            var SatDescription = task.SatDescription;
                            var SunDescription = task.SunDescription;
                            var ActualPercentComplete = task.ActualPercentComplete;
                            var ResourcePercentComplete = task.ResourcePercentComplete;
                            var IsTaskComplete = task.IsTaskComplete;
                            if (IsTaskComplete == true) {
                                IsTaskComplete = 1;
                            } else if (IsTaskComplete == false || IsTaskComplete == null) {
                                IsTaskComplete = 0;
                            }
                            if (MonDAID != 0 || TueDAID != 0 || WedDAID != 0 || ThuDAID != 0 || FriDAID != 0 || SatDAID != 0 || SunDAID != 0 || IsTaskComplete == 1) {
                                IsDisableCheckbox = 1;
                            }
                            var WhichTask = task.WhichTask;
                            var SubTaskTypeID = task.SubTaskTypeID;
                            if (SubTaskTypeID == null) {
                                SubTaskTypeID = 0;
                            }
                            var IsProject = task.IsProject;
                            var Percentage = task.Percentage;
                            var IsAgileProject = task.IsAgileProject;
                            var ResourceLevelTaskCompletion = task.ResourceLevelTaskCompletion;
                            if (ResourceLevelTaskCompletion == true) {
                                ResourceLevelTaskCompletion = 1;
                            } else if (ResourceLevelTaskCompletion == false || ResourceLevelTaskCompletion == null) {
                                ResourceLevelTaskCompletion = 0;
                            }
                            var ApplyEffortDistribution = task.ApplyEffortDistribution;
                            var AllowActivityLevelDA = task.AllowActivityLevelDA;
                            var IsVerified = task.IsVerified;
                            var IsApprover = task.IsApprover;
                            var StatusFlag = task.StatusFlag; if (StatusFlag == null) { StatusFlag = ""; } if (StatusFlag == null) { StatusFlag = ""; }
                            var MonStatusFlag = task.MonStatusFlag;
                            var TueStatusFlag = task.TueStatusFlag;
                            var WedStatusFlag = task.WedStatusFlag;
                            var ThuStatusFlag = task.ThuStatusFlag;
                            var FriStatusFlag = task.FriStatusFlag;
                            var SatStatusFlag = task.SatStatusFlag;
                            var SunStatusFlag = task.SunStatusFlag;

                            var MonAllowToResubmit = task.MonAllowToResubmit;
                            var TueAllowToResubmit = task.TueAllowToResubmit;
                            var WedAllowToResubmit = task.WedAllowToResubmit;
                            var ThuAllowToResubmit = task.ThuAllowToResubmit;
                            var FriAllowToResubmit = task.FriAllowToResubmit;
                            var SatAllowToResubmit = task.SatAllowToResubmit;
                            var SunAllowToResubmit = task.SunAllowToResubmit;
                            var TaskStatusFlag = task.TaskStatusFlag;
                            if(TimesheetStatus === "Rejected" && StatusFlag === "V"){
                                StatusFlag = "J";
                            }
                            var IsSubTaskFilled = task.IsSubTaskFilled;
                            var RestrictByMinHours = task.RestrictByMinHours;
                            GlobalRestrictByMinHours = RestrictByMinHours;
                            var ActualStartDate = task.ActualStartDate;
                            var ActualEndDate = task.ActualEndDate;
                            var Work = task.Work;

                            if (IsTaskComplete == 0) {
                                strHTML += `<tr class="projectRow childRow accordion-collapse collapse  superTab${ProjectID} HideProjectDetails${ProjectID}" >
                                    <td class="">
                                        <div class="accordion-header d-flex justify-content-between px-2">
                                            <img src="../../../Whizible2.0-new/dist/img/task-icon.svg" alt="Task Image" class="taskIcn">`
                                if (StatusFlag == 'J') {
                                    strHTML += `<button class="accordion-button TaskAccBtn weekcolumnred" type="button">
                                                ${Result[i]["TaskName"]}
                                            </button>`
                                } else {
                                    strHTML += `<button class="accordion-button TaskAccBtn" type="button">
                                                ${Result[i]["TaskName"]}
                                            </button>`
                                }
                                strHTML += `<div data-bs-toggle="tooltip" title="Task Info">
                                                    <img src="../../../Whizible2.0-new/dist/img/info-circle.svg"
                                                            alt="More Info"
                                                            class="infoIcn cursorArrow ms-2"
                                                            onclick="showProjectTaskInfo(this, ${TaskID})"
                                                            tabindex="0">
                                                </div>
                                        </div>
                                    </td>
                                    <td>`

                                //th class="colWidth weekcolumnred"                                
                                //Commented by Vishal Mane on 28/05/2025 to enable quickentry checkbox for all tasks for Expleo customization
                                //if (IsDisableCheckbox == 1) {
                                //    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} disabled/>`
                                //    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                //} else {
                                //    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} />`
                                //    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                //}
                                strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} />`
                                strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                //End of Commented by Vishal Mane on 28/05/2025 to enable quickentry checkbox for all tasks for Expleo customization

                                strHTML += `</td> <td><div class="d-flex align-items-center">`

                                var dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }));         //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                    if (StatusFlag == 'J' && IsGloabl == 1) {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}"  id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1">`           //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}"  id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1" readonly>`      //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}" />`;
                                    }
                                } else {
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}" />`;
                                }
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${MonDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${MonDescription ? MonDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                if (MonDAID != "") {
                                    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + MonDAID + ')">Save</button>'
                                }
                                //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 1));
                                if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                    if (StatusFlag == 'J' && IsGloabl == 1) {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}"  id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2">`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}"  id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2" readonly>`      //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}" />`;
                                    }
                                } else {
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${TueAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}" />`;
                                }
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${TueDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${TueDescription ? TueDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                if (TueDAID != "") {
                                    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + TueDAID + ')">Save</button>'
                                }
                                //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 2));
                                if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                    if (StatusFlag == 'J' && IsGloabl == 1) {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}"  id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3">`           //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}"  id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3" readonly>`    //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}" />`;
                                    }
                                    } else {
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${WedAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}" />`;
                                }
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${WedDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${WedDescription ? WedDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                if (WedDAID != "") {
                                    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + WedDAID + ')">Save</button>'
                                }
                                //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 3));
                                if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                    if (StatusFlag == 'J' && IsGloabl == 1) {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4">`            //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4" readonly>`           //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}" />`;
                                    }
                                    } else {
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${ThuAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`            //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}" />`;
                                }
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${ThuDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${ThuDescription ? ThuDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                if (ThuDAID != "") {
                                    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + ThuDAID + ',1)">Save</button>'
                                }
                                //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 4));
                                if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                    if (StatusFlag == 'J' && IsGloabl == 1) {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5">`            //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5" readonly>`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}" />`;
                                    }
                                    } else {
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${FriAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}" />`;
                                }
                                strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${FriDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${FriDescription ? FriDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                if (FriDAID != "") {
                                    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + FriDAID + ')">Save</button>'
                                }
                                //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 5));
                                if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                    if (StatusFlag == 'J' && IsGloabl == 1) {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6" readonly>`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}" />`;
                                    }
                                    } else {
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SatAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}" />`;
                                }
                                strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                //strHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" value="' + SatAllowToResubmit + '" />';
                                //strHTML += '<input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US",{ timeZone: "Asia/Kolkata" })) + '" name="">';     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                //strHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + SatDAID + '" name="">';
                                //strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SatDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${SatDescription ? SatDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                if (SatDAID != "") {
                                    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SatDAID + ')">Save</button>'
                                }
                                //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 6));
                                if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                    if (StatusFlag == 'J' && IsGloabl == 1) {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}"  class="form-control edtTimeInput taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7" readonly>`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" />`;
                                    }
                                    } else {
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SunAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" />`;
                                }
                                strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5"  data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SunDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${SunDescription ? SunDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                if (SunDAID != "") {
                                    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SunDAID + ')">Save</button>'
                                }
                                //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                //Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                //if (WhichTask != 'D') {
                                //    strHTML += `<td>${ActualPercentComplete} %</td>`
                                //} else {
                                //    strHTML += `<td></td>`
                                //}
                                //End of Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                if (WhichTask != 'D') {
                                    if (SubTaskTypeID == 0) {
                                        if (ResourceLevelTaskCompletion == 1) {
                                            strHTML += '<td>'
                                            strHTML += `<div class="">`
                                            if (IsTaskComplete == 1) {
                                                strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl" checked disabled style="cursor:not-allowed!important;>'
                                            } else {
                                                strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl">'
                                            }
                                            strHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`

                                        } else {
                                            strHTML += '<td>'
                                            strHTML += `<div class="custom_chckbox">N/A`
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`

                                        }
                                    } else {
                                        strHTML += '<td>'
                                        strHTML += `<div class="custom_chckbox">N/A`
                                        strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                        strHTML += `</div></td>`
                                    }
                                }
                                else {
                                    strHTML += '<td>'
                                    strHTML += `<div class="custom_chckbox">`
                                    strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                    strHTML += `</div></td>`
                                }
                                strHTML += `<td><label class="totalTxt" name="pro_Calculate_count_${TaskID}" id="lblWeeklyTotal_${ProjectID}_${TaskID}_${SubTaskTypeID}">${ActualWork}</label>`
                                strHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                                strHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>'
                                strHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input></td></tr>';

                            }
                            else if (IsTaskComplete == 1 && ActualStartDate != null && ActualEndDate != null && (
                                (isValidDate(dtFromDate1) && isValidDate(ActualStartDate) && new Date(dtFromDate1) >= new Date(ActualStartDate) && new Date(dtFromDate1) <= new Date(dtToDate1)) ||
                                (isValidDate(dtToDate1) && isValidDate(ActualEndDate) && new Date(dtToDate1) >= new Date(ActualEndDate) && new Date(dtFromDate1) <= new Date(ActualEndDate))
                            )) {
                                strHTML += `<tr class="projectRow childRow accordion-collapse collapse  superTab${ProjectID} HideProjectDetails${ProjectID}" >
                                    <td class="">
                                        <div class="accordion-header d-flex justify-content-between px-2">
                                            <img src="../../../Whizible2.0-new/dist/img/task-icon.svg" alt="Task Image" class="taskIcn">`
                                if (StatusFlag == 'J') {
                                    strHTML += `<button class="accordion-button TaskAccBtn weekcolumnred" type="button">
                                                ${Result[i]["TaskName"]}
                                            </button>`
                                } else {
                                    strHTML += `<button class="accordion-button TaskAccBtn" type="button">
                                                ${Result[i]["TaskName"]}
                                            </button>`
                                }                                
                                strHTML += `<div data-bs-toggle="tooltip" title="Task Info">
                                                    <img src="../../../Whizible2.0-new/dist/img/info-circle.svg"
                                                            alt="More Info"
                                                            class="infoIcn cursorArrow ms-2"
                                                            onclick="showProjectTaskInfo(this, ${TaskID})"
                                                            tabindex="0">
                                                </div>
                                        </div>
                                    </td>
                                    <td>`

                                //th class="colWidth weekcolumnred"
                                //Commented by Vishal Mane on 28/05/2025 to enable quickentry checkbox for all tasks for Expleo customization
                                //if (IsDisableCheckbox == 1) {
                                //    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} disabled/>`
                                //    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                //} else {
                                //    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} />`
                                //    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                //}
                                strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} />`
                                strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                //End of Commented by Vishal Mane on 28/05/2025 to enable quickentry checkbox for all tasks for Expleo customization

                                
                                strHTML += `</td> <td><div class="d-flex align-items-center">`

                                var dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }));     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1" readonly disabled>`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}" />`;
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${MonDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${MonDescription ? MonDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //if (MonDAID != "") {
                                //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + MonDAID + ')">Save</button>'
                                //}
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="1"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" type="text" oninput="validateInput(this)" value="${MonStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 1));
                                strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${TueAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2" readonly disabled>`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}" />`;
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${TueDAID}" placeholder="Enter Description..." maxlength='2000'>${TueDescription ? TueDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //if (TueDAID != "") {
                                //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + TueDAID + ')">Save</button>'
                                //}
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="2"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" type="text" oninput="validateInput(this)" value="${TueStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 2));
                                strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${WedAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3" readonly disabled>`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}" />`;
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${WedDAID}" placeholder="Enter Description..." maxlength='2000'>${WedDescription ? WedDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //if (WedDAID != "") {
                                //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + WedDAID + ')">Save</button>'
                                //}
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="3"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" type="text" oninput="validateInput(this)" value="${WedStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 3));
                                strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${ThuAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4" readonly disabled>`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}" />`;
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${ThuDAID}" placeholder="Enter Description..." maxlength='2000'>${ThuDescription ? ThuDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //if (ThuDAID != "") {
                                //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + ThuDAID + ',1)">Save</button>'
                                //}
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="4"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" type="text" oninput="validateInput(this)" value="${ThuStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 4));
                                strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${FriAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5" readonly disabled>`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}" />`;
                                strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${FriDAID}" placeholder="Enter Description..." maxlength='2000'>${FriDescription ? FriDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //if (FriDAID != "") {
                                //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + FriDAID + ')">Save</button>'
                                //}
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="5"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" type="text" oninput="validateInput(this)" value="${FriStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 5));
                                strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SatAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6" readonly disabled>`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}" />`;
                                strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                //strHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" value="' + SatAllowToResubmit + '" />';
                                //strHTML += '<input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US",{ timeZone: "Asia/Kolkata" })) + '" name="">';     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                //strHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + SatDAID + '" name="">';
                                //strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SatDAID}" placeholder="Enter Description..." maxlength='2000'>${SatDescription ? SatDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //if (SatDAID != "") {
                                //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SatDAID + ')">Save</button>'
                                //}
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="6"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" type="text" oninput="validateInput(this)" value="${SatStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                strHTML += `<td><div class="d-flex align-items-center">`
                                var NextDay = new Date();
                                dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 6));
                                strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SunAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" class="form-control edtTimeInput taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7" readonly disabled>`      //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" />`;
                                strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                                strHTML += `<div class="">
                                            <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                            <ul class="dropdown-menu TaskDescDropdown">`
                                strHTML += `<div><textarea class="form-control InputDescription" rows="5"  data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SunDAID}" placeholder="Enter Description..." maxlength='2000'>${SunDescription ? SunDescription : ''}</textarea></div>`
                                strHTML += `<div class="text-end mt-2">`
                                //if (SunDAID != "") {
                                //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SunDAID + ')">Save</button>'
                                //}
                                strHTML += `</div></div></ul></div></div>`
                                if (IsAgileProject == 1) {
                                    strHTML += '<span class="timeno">'
                                    strHTML += '<span class="selecttimeno">'
                                    if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V') {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" readonly autocomplete="off">`;
                                    }
                                    else {
                                        strHTML += `<input maxlength="2" data-IsAgileProject-id="${IsAgileProject}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-Day-id="7"  data-bs-toggle="tooltip" class="form-control edtTimeInputStoryPoint taskTxt userStoryInput" OnBlur=StoryPoint_OnChange(this);  id="StoryPoint_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" type="text" oninput="validateInput(this)" value="${SunStoryPoint}" placeholder=" " name="" data-bs-placement="bottom" title="Story Point" autocomplete="off">`;
                                    }
                                    strHTML += '</span>';
                                    strHTML += '</span>';
                                }
                                strHTML += `</td>`
                                //Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                //if (WhichTask != 'D') {
                                //    strHTML += `<td>${ActualPercentComplete} %</td>`
                                //} else {
                                //    strHTML += `<td></td>`
                                //}
                                //End of Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                if (WhichTask != 'D') {
                                    if (SubTaskTypeID == 0) {
                                        if (ResourceLevelTaskCompletion == 1) {
                                            strHTML += '<td>'
                                            strHTML += `<div class="">`
                                            if (IsTaskComplete == 1) {
                                                strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl" checked disabled style="cursor:not-allowed!important;>'
                                            } else {
                                                strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl">'
                                            }
                                            strHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`

                                        } else {
                                            strHTML += '<td>'
                                            strHTML += `<div class="custom_chckbox">N/A`
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`

                                        }
                                    } else {
                                        strHTML += '<td>'
                                        strHTML += `<div class="custom_chckbox">N/A`
                                        strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                        strHTML += `</div></td>`
                                    }
                                }
                                else {
                                    strHTML += '<td>'
                                    strHTML += `<div class="custom_chckbox">`
                                    strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                    strHTML += `</div></td>`
                                }
                                strHTML += `<td><label class="totalTxt" name="pro_Calculate_count_${TaskID}" id="lblWeeklyTotal_${ProjectID}_${TaskID}_${SubTaskTypeID}">${ActualWork}</label>`
                                strHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                                strHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>'
                                strHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input></td></tr>';
                            }

                        }
                        //Task Binding ends here
                        counter++;
                    }
                    parentRow.after(strHTML);
                    $(`.superTab${ProjectID}`).collapse('show');
                    //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                    //setTimeout(ApplyLockAfterRender, 100);
                    EnableDisbaleDATextbox();
                    //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
                }
            }
            $('[data-bs-toggle="tooltip"]').tooltip();

            
        }

        //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
        function ApplyLockAfterRender() {
            if ($('.taskTxt').length > 0 && HeaderResult && HeaderResult.length > 0) {
                EnableDisbaleDATextbox();
            }
        }
        var HeaderResult = "";
        var entryStatusMap = {};
        function EnableDisbaleDATextbox() {
            if (!HeaderResult || HeaderResult.length === 0) return;
            entryStatusMap = {};
            // Build date-status map
            HeaderResult.forEach(function (r) {
                var d = new Date(r.EntryDate);
                var key = d.getFullYear() + "-" +
                    ("0" + (d.getMonth() + 1)).slice(-2) + "-" +
                    ("0" + d.getDate()).slice(-2);
                entryStatusMap[key] = r.Status;
            });
            // ?? Reset all first
            $('.taskTxt').prop("readonly", false).removeClass("bg-light");
            // --------------------------------------------------
            // STEP 1: Find projectIds that should be enabled
            // --------------------------------------------------
            let enabledProjects = new Set();
            $('.taskTxt').each(function () {
                var input = $(this);
                var entryDateStr = input.attr('data-entrydate-id');
                if (!entryDateStr) return;
                var d = new Date(entryDateStr);
                var key = d.getFullYear() + "-" +
                    ("0" + (d.getMonth() + 1)).slice(-2) + "-" +
                    ("0" + d.getDate()).slice(-2);
                var status = entryStatusMap[key];
                if (!status) return;
                var statusFlag = (input.attr('data-statusflag-id') || "").toUpperCase();
                var projectId = input.attr('data-projectid-id');
                // If rejected + J ? enable whole project
                if (status === "Rejected" && statusFlag === "J") {
                    enabledProjects.add(projectId);
                }
            });
            // --------------------------------------------------
            // STEP 2: Apply final enable/disable
            // --------------------------------------------------
            $('.taskTxt').each(function () {
                var input = $(this);
                var entryDateStr = input.attr('data-entrydate-id');
                if (!entryDateStr) return;
                var d = new Date(entryDateStr);
                var key = d.getFullYear() + "-" +
                    ("0" + (d.getMonth() + 1)).slice(-2) + "-" +
                    ("0" + d.getDate()).slice(-2);
                var status = entryStatusMap[key];
                if (!status) return;
                var projectId = input.attr('data-projectid-id');
                // ?? If project marked enabled ? enable all tasks
                if (enabledProjects.has(projectId)) {
                    input.prop("readonly", false).removeClass("bg-light");
                    return;
                }
                // ?? Lock for approved/submitted
                if (
                    status === "Ready for approval" ||
                    status === "Approved" ||
                    status === "Submitted"
                ) {
                    input.prop("readonly", true).addClass("bg-light");
                    return;
                }
                // ?? Rejected but not J ? lock
                if (status === "Rejected") {
                    input.prop("readonly", true).addClass("bg-light");
                    return;
                }
                // ?? Others allow
                input.prop("readonly", false).removeClass("bg-light");
            });

            //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
            $('.edtTimeInput, .edtTimeInput1').each(function () {
                var $input = $(this);
                var $saveBtn = $input.closest('td').find('button[onclick*="SaveDescription_OnClick"]');
                if (!$saveBtn.length) return;
                if ($input.prop('readonly') || $input.prop('disabled')) {
                    $saveBtn.hide();
                } else {
                    $saveBtn.show();
                }
            });
            //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
        }
        function checkMultipleStatusRanges() {
            var fromDate = new Date($("#weekPicker2").attr("StartDate"));
            var toDate = new Date($("#weekPicker2").attr("EndDate"));
            fromDate.setHours(0, 0, 0, 0);
            toDate.setHours(0, 0, 0, 0);
            if (!TSSubmissionDetails || TSSubmissionDetails.length === 0) return;
            // Filter entries inside selected week
            let weekEntries = TSSubmissionDetails.filter(x => {
                let f = new Date(x.FromDate);
                let t = new Date(x.ToDate);
                f.setHours(0, 0, 0, 0);
                t.setHours(0, 0, 0, 0);
                return (f >= fromDate && t <= toDate);
            });
            if (weekEntries.length === 0) return;
            // ?? If more than 1 entry ? call function
            if (weekEntries.length > 1) {
                $("#ResubmitTimesheetBtn").hide();                
                $("#txtEditTS").hide();
                $("#CreateTaskBtn").show();
                $("#SubmitTimesheetBtn").show();
                $("#CreateTaskBtn").prop("disabled", true);
                $("#SubmitTimesheetBtn").prop("disabled", true);
                $("#txtStatus").hide();
                $("#txtStatusDiv").hide();                
                $("#saveTimesheetBtn").show();
                return;
            } else {
                $("#txtStatus").show();
                $("#txtStatusDiv").show();
                $("#CreateTaskBtn").prop("disabled", false);
                $("#SubmitTimesheetBtn").prop("disabled", false);
            }
            // ?? If only 1 entry ? check exact match with week
            let single = weekEntries[0];
            let f = new Date(single.FromDate);
            let t = new Date(single.ToDate);
            f.setHours(0, 0, 0, 0);
            t.setHours(0, 0, 0, 0);
            if (f.getTime() === fromDate.getTime() && t.getTime() === toDate.getTime()) {
                // exact same ? do nothing
                return;
            }            
        }
        //Added and commented by Vishal Mane on 11/08/2025 to fix description validation issue
        //Added By Dipali V On 21st Aug 2026 for handle apostrophe in description for SQL save
        function escapeDescriptionForSql(desc) {
            if (desc == null || desc === undefined) {
                return "";
            }
            // use char code so ASPX does not alter quote characters in script
            var q = String.fromCharCode(39);
            return String(desc).split(q).join(q + q);
        }
        //End of Added By Dipali V On 21st Aug 2026 for handle apostrophe in description for SQL save
        async function SaveDescription_OnClick(ProjectID, TaskID, MonDAID) {
            //debugger
            //Added and commented by Vishal Mane on 13/08/2025 to fix description validation issue
            if (timesheetEntries.length != 0) {
                var IsValidationDuration = await validateDailyEntry();
                if (IsValidationDuration == 0) {
                    timesheetEntries = timesheetEntries.filter(function (entry) {
                        return entry.IsCorrectEntry == 1;
                    });
                    timesheetEntriesUpdated = timesheetEntriesUpdated.filter(function (entry) {
                        return entry.IsCorrectEntry == 1;
                    });
                    timesheetEntriesUpdated = timesheetEntries.slice();
                }
                if (timesheetEntriesUpdated.length > 0) {
                    if (IsValidationDuration == 0) {
                        var InputDuration = $(`input[data-ProjectID-id="${ProjectID}"][data-TaskID-id="${TaskID}"][data-DAID-id="${MonDAID}"]`).val();
                        var InputDescription = $(`textarea[data-ProjectID-id="${ProjectID}"][data-TaskID-id="${TaskID}"][data-DAID-id="${MonDAID}"]`).val();
                        alertify.set('notifier', 'position', 'top-right');
                        //Added By Dipali V On 21st Aug 2026 for handle apostrophe in description for SQL save
                        var taskParameters = {
                            DailyActivityEntryID: parseInt(MonDAID, 10) || 0,
                            TaskID: parseInt(TaskID, 10) || 0,
                            ProjectID: parseInt(ProjectID, 10) || 0,
                            EmployeeID: parseInt(SessionEmployeeId, 10) || 0,
                            //Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                            ProxyResourceID: parseInt('<%= Session("intUserId") %>', 10) || 0,
                            //End of Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                            Duration: parseFloat((InputDuration || "0").replace(":", ".")),
                            Description: escapeDescriptionForSql(InputDescription),
                        };
                        //End of Added By Dipali V On 21st Aug 2026 for handle apostrophe in description for SQL save
                        var param = JSON.stringify(taskParameters);
                        //Added By Dipali V On 21st Aug 2026 for SaveDescription ajax Params omits Description
                        var data = AJAXCallWithResultSaveDescription("/api/TimesheetEntryNew/SaveDescription_OnClick", param, false);
                        //End of Added By Dipali V On 21st Aug 2026 for SaveDescription ajax Params omits Description
                        if (data == 1) {
                            //alertify.success('Daily Activity entered successfully.');
                            alertify.success('<%=MyBase.GetResourceString("A_DASaved")%>');
                        } else if (data == 2) {
                            //alertify.success('Daily Activity updated successfully.');
                            alertify.success('<%=MyBase.GetResourceString("A_DAUpdated")%>');
                        }
                        GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                        GetTaskData(SessionEmployeeId);
                        var thisElement = $('[data-bs-target=".superTab' + ProjectID + '"]');
                        PlotTaskDetails(ProjectID, SessionEmployeeId, thisElement);
                        $(`.superTab${ProjectID}`).collapse('show');
                    }
                    else {
                        $('[id^="Duration_"]').css({
                            'background-color': '',
                            'border': ''
                        });
                        var errorMessage = "";
                        var indicesToRemove = [];
                        var groupedAlerts = new Map();
                        validationAlerts.forEach(function (entry, index) {
                            var uniqueKey = entry.ProjectID + '-' + entry.TaskID;
                            if (!groupedAlerts.has(uniqueKey)) {
                                groupedAlerts.set(uniqueKey, {
                                    ProjectName: entry.ProjectName,
                                    TaskName: entry.TaskName,
                                    Alerts: new Set() // Set to store unique alerts
                                });
                            }
                            groupedAlerts.get(uniqueKey).Alerts.add(entry.Alert);
                            var inputIdHidden = `#DurationHidden_${entry.ProjectID}_${entry.TaskID}_${entry.SubTaskTypeID}_${entry.Day}`;
                            var HiddenValue = $(inputIdHidden).val();
                            if (parseFloat(HiddenValue) !== parseFloat(entry.Duration)) {
                                var inputId = `#Duration_${entry.ProjectID}_${entry.TaskID}_${entry.SubTaskTypeID}_${entry.Day}`;
                                $(inputId).css({
                                    'background-color': '#f8d7da',
                                    'border': '1px solid #f5c6cb'
                                });
                                $(inputId).val(HiddenValue);
                                indicesToRemove.push(index);
                            }
                        });
                        groupedAlerts.forEach(function (value) {
                            errorMessage += "<br><strong>Project : </strong>" + decodeURIComponent(value.ProjectName) + "<br>";
                            errorMessage += "<strong>Task : </strong> " + decodeURIComponent(value.TaskName) + "<br>";
                            if (value.Alerts.size > 1) {
                                var alertIndex = 1;
                                value.Alerts.forEach(function (alert) {
                                    errorMessage += `<strong>Message ${alertIndex} : </strong> ${alert}<br>`;
                                    alertIndex++;
                                });
                            } else {
                                value.Alerts.forEach(function (alert) {
                                    errorMessage += `<strong>Message : </strong> ${alert}<br>`;
                                });
                            }
                        });
                        if (indicesToRemove.length > 0) {
                            timesheetEntries = timesheetEntries.filter(function (entry) {
                                return entry.IsCorrectEntry !== 0;
                            });
                        }
                        if (errorMessage) {
                            $("#ValidationMessageModalinfo").modal("show");
                            //$("#txtValidationMessage").text(errorMessage);
                            $("#txtValidationMessage").empty();
                            $("#txtValidationMessage").append(errorMessage);
                            validationAlerts = [];
                        }
                        timesheetEntriesUpdated = [];
                    }
                }
            }
            //End of Added and commented by Vishal Mane on 13/08/2025 to fix description validation issue
            //Added and commented by Vishal Mane on 13/08/2025 to fix description validation issue
            else {
                var InputDuration = $(`input[data-ProjectID-id="${ProjectID}"][data-TaskID-id="${TaskID}"][data-DAID-id="${MonDAID}"]`).val();
                var InputDescription = $(`textarea[data-ProjectID-id="${ProjectID}"][data-TaskID-id="${TaskID}"][data-DAID-id="${MonDAID}"]`).val();
                alertify.set('notifier', 'position', 'top-right');
                //Added By Dipali V On 21st Aug 2026 for handle apostrophe in description for SQL save
                var taskParameters = {
                    DailyActivityEntryID: parseInt(MonDAID, 10) || 0,
                    TaskID: parseInt(TaskID, 10) || 0,
                    ProjectID: parseInt(ProjectID, 10) || 0,
                    EmployeeID: parseInt(SessionEmployeeId, 10) || 0,
                    //Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                    ProxyResourceID: parseInt('<%= Session("intUserId") %>', 10) || 0,
                    //End of Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                    Duration: parseFloat((InputDuration || "0").replace(":", ".")),
                    Description: escapeDescriptionForSql(InputDescription),
                };
                //End of Added By Dipali V On 21st Aug 2026 for handle apostrophe in description for SQL save
                var param = JSON.stringify(taskParameters);
                //Added By Dipali V On 21st Aug 2026 for SaveDescription ajax Params omits Description
                var data = AJAXCallWithResultSaveDescription("/api/TimesheetEntryNew/SaveDescription_OnClick", param, false);
                //End of Added By Dipali V On 21st Aug 2026 for SaveDescription ajax Params omits Description
                if (data == 1) {
                    //alertify.success('Daily Activity entered successfully.');
                    alertify.success('<%=MyBase.GetResourceString("A_DASaved")%>');
                        } else if (data == 2) {
                            //alertify.success('Daily Activity updated successfully.');
                    alertify.success('<%=MyBase.GetResourceString("A_DAUpdated")%>');
                }
                GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                GetTaskData(SessionEmployeeId);
                var thisElement = $('[data-bs-target=".superTab' + ProjectID + '"]');
                PlotTaskDetails(ProjectID, SessionEmployeeId, thisElement);
                $(`.superTab${ProjectID}`).collapse('show');
                //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                EnableDisbaleDATextbox();
                //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
            }
            //End of Added and commented by Vishal Mane on 13/08/2025 to fix description validation issue
        }
        <%--function SaveDescription_OnClick(ProjectID, TaskID, MonDAID) {
            var InputDuration = $(`input[data-ProjectID-id="${ProjectID}"][data-TaskID-id="${TaskID}"][data-DAID-id="${MonDAID}"]`).val();
            var InputDescription = $(`textarea[data-ProjectID-id="${ProjectID}"][data-TaskID-id="${TaskID}"][data-DAID-id="${MonDAID}"]`).val();
            alertify.set('notifier', 'position', 'top-right');
            var taskParameters = {
                DailyActivityEntryID: MonDAID,
                TaskID: TaskID,
                ProjectID: ProjectID,                
                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                //EmployeeID: '<%= Session("intUserId") %>',
                EmployeeID : SessionEmployeeId,
                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                Duration: InputDuration.replace(":", "."),
                Description: InputDescription.replace(/'/g, "''"),
            };
            var param = JSON.stringify(taskParameters);
            var data = AJAXCallWithResult("/api/TimesheetEntryNew/SaveDescription_OnClick", param, false);
            if (data == 1) {                
                //alertify.success('Daily Activity entered successfully.');
                alertify.success('<%=MyBase.GetResourceString("A_DASaved")%>');
            } else if (data == 2) {                
                //alertify.success('Daily Activity updated successfully.');
                alertify.success('<%=MyBase.GetResourceString("A_DAUpdated")%>');
            }
            GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
            GetTaskData(SessionEmployeeId);
            var thisElement = $('[data-bs-target=".superTab' + ProjectID + '"]');
            PlotTaskDetails(ProjectID, SessionEmployeeId, thisElement);
            $(`.superTab${timesheetEntries[i]["ProjectID"]}`).collapse('show');
        }--%>
        //End of Added and commented by Vishal Mane on 11/08/2025 to fix description validation issue

        var timesheetEntries = [];
        $("body").on("change", ".edtTimeInput", function () {
            //debugger            
            var $input = $(this);
            var $descriptionTextarea = $input.closest("td").find(".TaskDescDropdown textarea");
            var checkboxId = `#IsTaskComplete_${$input.data('projectid-id')}_${$input.data('taskid-id')}_${$input.data('subtasktypeid-id')}`;
            var $checkbox = $(checkboxId);
            var TaskComplete = $checkbox.is(':checked');
            var storypointId = `#StoryPoint_${$input.data('projectid-id')}_${$input.data('taskid-id')}_${$input.data('subtasktypeid-id')}_${$input.data('day-id')}`
            storypoint = $(storypointId).val() ? $(storypointId).val() : "0";
            var entry = {
                DailyActivityEntryID: $(this).data('daid-id'),
                TaskID: $(this).data('taskid-id'),
                ProjectID: $(this).data('projectid-id'),                
                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                //Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                ProxyResourceID: '<%= Session("intUserId") %>',
                //End of Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                EmployeeID : SessionEmployeeId,
                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                EntryDate: new Date($(this).data('entrydate-id')).toLocaleDateString('en-US'),
                //EntryDate: "27/11/2024",
                Duration: $(this).val().replace(":", "."),
                Description: $descriptionTextarea.val().replace(/'/g, "''"),
                SubTaskTypeID: $(this).data('subtasktypeid-id'),
                //IsDurationChange: txtDuChRow.value,
                IsTaskComplete: TaskComplete,
                //ActualPercentComplete: workComp,
                //bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                StoryPoint: storypoint,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                Day: $(this).data('day-id'),
                ConfirmFlag: 0,
                //Added By Dipali V On 19th Feb 2025 For Alert Issue
                IsAllowToFillDAAfterValidate: 0,
                //End of Added By Dipali V On 19th Feb 2025 For Alert Issue
                TaskName: $(this).data('taskname-id'),
                ProjectName: $(this).data('projectname-id'),
                IsAgileProject: $(this).data('isagileproject-id'),
                //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                IsCorrectEntry: 1,
                //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
            };
            var existingEntryIndex = timesheetEntries.findIndex(e => e.ProjectID == entry.ProjectID && e.TaskID == entry.TaskID && e.Day == entry.Day);
            if (existingEntryIndex !== -1) {
                timesheetEntries.splice(existingEntryIndex, 1);
            }
            if (parseFloat(entry.DailyActivityEntryID) > 0) {
                timesheetEntries.push(entry);
            } else {
                timesheetEntries.push(entry);
            }

        });
        // Handling checkbox change
        var timesheetEntriesForCheckBox = [];
        $("body").on("change", ".chcktbl", function () {            
            var $checkbox = $(this);
            var TaskID = $checkbox.data('taskid-id');
            var ProjectID = $checkbox.data('projectid-id');
            // Iterate over all timesheetEntries to find all matching TaskID and ProjectID
            if (timesheetEntries.length > 0) {
                timesheetEntries.forEach(function (entry) {
                    if (entry.ProjectID === ProjectID && entry.TaskID === TaskID) {
                        // Update the IsTaskComplete value for all matching entries
                        entry.IsTaskComplete = $checkbox.is(':checked');
                    }
                });
            } else {
                if ($checkbox.is(':checked') == true) {
                    var $row = $checkbox.closest("tr");
                    // Iterate over all the input textboxes within the same row related to the same TaskID and ProjectID
                    $("input.edtTimeInput", $row).each(function () {
                        var $input = $(this);
                        var $descriptionTextarea = $input.closest("td").find(".TaskDescDropdown textarea");
                        var checkboxId = `#IsTaskComplete_${$input.data('projectid-id')}_${$input.data('taskid-id')}_${$input.data('subtasktypeid-id')}`;
                        var $checkbox = $(checkboxId);
                        var TaskComplete = $checkbox.is(':checked');
                        var storypointId = `#StoryPoint_${$input.data('projectid-id')}_${$input.data('taskid-id')}_${$input.data('subtasktypeid-id')}_${$input.data('day-id')}`;
                        var storypoint = $(storypointId).val() ? $(storypointId).val() : "0";
                        // Create entry object with values from the input
                        var entry = {
                            DailyActivityEntryID: $input.data('daid-id'),
                            TaskID: $input.data('taskid-id'),
                            ProjectID: $input.data('projectid-id'),
                            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                            //Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                            ProxyResourceID: '<%= Session("intUserId") %>',
                            //End of Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                            EmployeeID : SessionEmployeeId,
                            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                            EntryDate: new Date($input.data('entrydate-id')).toLocaleDateString('en-US'),
                            Duration: $input.val().replace(":", "."),
                            Description: $descriptionTextarea.val().replace(/'/g, "''"),
                            SubTaskTypeID: $input.data('subtasktypeid-id'),
                            IsTaskComplete: TaskComplete,
                            StoryPoint: storypoint,
                            dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                            dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                            Day: $input.data('day-id'),
                            ConfirmFlag: 0,
                            //Added By Dipali V On 19th Feb 2025 For Alert Issue
                            IsAllowToFillDAAfterValidate: 0,
                            //End of Added By Dipali V On 19th Feb 2025 For Alert Issue
                            TaskName: $input.data('taskname-id'),
                            ProjectName: $input.data('projectname-id'),
                            IsAgileProject: $input.data('isagileproject-id'),
                        };
                        // Only add the entry if Duration is a valid number and greater than 0
                        if (parseFloat(entry.DailyActivityEntryID) > 0) {
                            timesheetEntriesForCheckBox.push(entry); // Add new entry if it's an update
                        } else {
                            if (!isNaN(parseFloat(entry.Duration)) && parseFloat(entry.Duration) != 0) {
                                timesheetEntriesForCheckBox.push(entry); // Add new entry if Duration is valid
                            }
                        }
                    });
                }
                else {
                    var $row = $checkbox.closest("tr");
                    $("input.edtTimeInput", $row).each(function () {
                        var $input = $(this);
                        var ProjectID = $input.data('projectid-id');
                        var TaskID = $input.data('taskid-id');
                        var Day = $input.data('day-id');
                        var existingEntryIndex = timesheetEntriesForCheckBox.findIndex(e => e.ProjectID == ProjectID && e.TaskID == TaskID && e.Day == Day);
                        if (existingEntryIndex !== -1) {
                            timesheetEntriesForCheckBox.splice(existingEntryIndex, 1);
                        }
                    });
                }
            }
        });

        $("body").on("change", ".InputDescription", function () {
            //debugger            
            var TaskID = $(this).data('taskid-id');
            var ProjectID = $(this).data('projectid-id');
            //Added by Dipali V on 20th Aug 2026 for Timesheet Description Display on approval page
            var Day = $(this).closest("td").find("input.edtTimeInput, input.edtTimeInput1").first().data("day-id");
            //End of Added by Dipali V on 20th Aug 2026 for Timesheet Description Display on approval page
            var newDescription = $(this).val().replace(/'/g, "''");
            // Iterate over all timesheetEntries to find all matching TaskID and ProjectID
            if (timesheetEntries.length > 0) {
                timesheetEntries.forEach(function (entry) {
                    //Commented by Dipali V on 20th Aug 2026 for Timesheet Description Display on approval page - matched only ProjectID+TaskID, so one day's description overwrote all days of that task
                    // if (entry.ProjectID === ProjectID && entry.TaskID === TaskID) {
                    //     // Update the Description value for all matching entries
                    //     entry.Description = newDescription;
                    // }
                    //Added by Dipali V on 20th Aug 2026 for Timesheet Description Display on approval page - also match Day so description remains daywise
                    if (entry.ProjectID === ProjectID && entry.TaskID === TaskID && entry.Day == Day) {
                        entry.Description = newDescription;
                    }
                    //End of Added by Dipali V on 20th Aug 2026 for Timesheet Description Display on approval page
                });
            }
        });

        $("body").on("change", ".edtTimeInputStoryPoint", function () {
            //debugger            
            var TaskID = $(this).data('taskid-id');
            var ProjectID = $(this).data('projectid-id');
            var StoryPoint = $(this).val();
            var Day = $(this).data('day-id');
            // Iterate over all timesheetEntries to find all matching TaskID and ProjectID
            if (timesheetEntries.length > 0) {
                timesheetEntries.forEach(function (entry) {
                    if (entry.ProjectID === ProjectID && entry.TaskID === TaskID && entry.Day == Day) {
                        // Update the StoryPoint value for all matching entries
                        entry.StoryPoint = StoryPoint;
                    }
                });
            }
        });
        async function SaveTimesheet(button) {
            //debugger
            button.disabled = true;
            if (timesheetEntries.length > 0) {                
                var IsValidationDuration = await validateDailyEntry();
                if (IsValidationDuration == 0) {
                    timesheetEntries = timesheetEntries.filter(function (entry) {
                        return entry.IsCorrectEntry == 1;
                    });
                    timesheetEntriesUpdated = timesheetEntriesUpdated.filter(function (entry) {
                        return entry.IsCorrectEntry == 1;
                    });
                    timesheetEntriesUpdated = timesheetEntries.slice();
                }
                if (timesheetEntriesUpdated.length > 0) {
                    if (IsValidationDuration == 0) {                        
                        $.ajax({
                            url: strUrl + '/api/TimesheetEntryNew/SaveDailyActivity',
                            type: "POST",
                            data: { '': timesheetEntriesUpdated },
                            //data: { 'timesheetEntriesUpdated': JSON.stringify(timesheetEntriesUpdated) },
                            dataType: "json",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                                //if (timesheetEntriesUpdated) {
                                //    xhr.setRequestHeader("Params", encryptString(isJson(timesheetEntriesUpdated) ? timesheetEntries : JSON.stringify(timesheetEntriesUpdated)));
                                //}
                            },
                            success: function (data) {
                                if (data == 1) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    //alertify.success('Daily Activity entered successfully.');
                                    alertify.success('<%=MyBase.GetResourceString("A_DASaved")%>');
                                    //showAlert('Daily Activity entered successfully.', 'alert-success', 'btnSave');e")%>');
                                    GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                                    GetTaskData(SessionEmployeeId);
                                    for (var i = 0; i < timesheetEntriesUpdated.length; i++) {
                                        var thisElement = $('[data-bs-target=".superTab' + timesheetEntriesUpdated[i]["ProjectID"] + '"]');
                                        PlotTaskDetails(timesheetEntriesUpdated[i]["ProjectID"], SessionEmployeeId, thisElement);
                                        //$('.superTab' + timesheetEntries[i]["ProjectID"]).collapse('show');
                                        $('#TimesheetInfoTbl tbody tr.showDetails_' + timesheetEntriesUpdated[i]["ProjectID"] + '').show();
                                        $(`.superTab${timesheetEntriesUpdated[i]["ProjectID"]}`).collapse('show');
                                    }
                                    timesheetEntries = [];
                                    timesheetEntriesUpdated = [];
                                    //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                                    EnableDisbaleDATextbox();
                                    //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature

                                } else if (data == 2) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    //alertify.success('Daily Activity updated successfully.');
                                    alertify.success('<%=MyBase.GetResourceString("A_DAUpdated")%>');
                                    GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                                    GetTaskData(SessionEmployeeId);
                                    for (var i = 0; i < timesheetEntriesUpdated.length; i++) {
                                        var thisElement = $('[data-bs-target=".superTab' + timesheetEntriesUpdated[i]["ProjectID"] + '"]');
                                        PlotTaskDetails(timesheetEntriesUpdated[i]["ProjectID"], SessionEmployeeId, thisElement);
                                        //$('.superTab' + timesheetEntries[i]["ProjectID"]).collapse('show');
                                        $('#TimesheetInfoTbl tbody tr.showDetails_' + timesheetEntriesUpdated[i]["ProjectID"] + '').show();
                                        $(`.superTab${timesheetEntriesUpdated[i]["ProjectID"]}`).collapse('show');
                                    }
                                    timesheetEntries = [];
                                    timesheetEntriesUpdated = [];
                                    IsTaskCopy = 0;
                                    GTaskID = 0;
                                    //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                                    EnableDisbaleDATextbox();
                                    //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
                                }
                            },
                            error: function (err) {
                                console.log(err);
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });                        
                    }
                    else {
                        //debugger;
                        $('[id^="Duration_"]').css({
                            'background-color': '',
                            'border': ''
                        });
                        var errorMessage = "";
                        var indicesToRemove = [];
                        var groupedAlerts = new Map();
                        validationAlerts.forEach(function (entry, index) {
                            var uniqueKey = entry.ProjectID + '-' + entry.TaskID;
                            // Initialize an array for new combinations of ProjectID and TaskID
                            if (!groupedAlerts.has(uniqueKey)) {
                                groupedAlerts.set(uniqueKey, {
                                    ProjectName: entry.ProjectName,
                                    TaskName: entry.TaskName,
                                    Alerts: new Set() // Set to store unique alerts
                                });
                            }
                            groupedAlerts.get(uniqueKey).Alerts.add(entry.Alert);
                            var inputIdHidden = `#DurationHidden_${entry.ProjectID}_${entry.TaskID}_${entry.SubTaskTypeID}_${entry.Day}`;
                            var HiddenValue = $(inputIdHidden).val();
                            if (parseFloat(HiddenValue) !== parseFloat(entry.Duration)) {
                                var inputId = `#Duration_${entry.ProjectID}_${entry.TaskID}_${entry.SubTaskTypeID}_${entry.Day}`;
                                $(inputId).css({
                                    'background-color': '#f8d7da',
                                    'border': '1px solid #f5c6cb'
                                });
                                $(inputId).val(HiddenValue);
                                indicesToRemove.push(index);
                              //  alert(errorMessage);
                            }
                        });
                        groupedAlerts.forEach(function (value) {
                            errorMessage += "<br><strong>Project : </strong>" + decodeURIComponent(value.ProjectName) + "<br>";
                            errorMessage += "<strong>Task : </strong> " + decodeURIComponent(value.TaskName) + "<br>";
                            if (value.Alerts.size > 1) {
                                var alertIndex = 1;
                                value.Alerts.forEach(function (alert) {
                                    errorMessage += `<strong>Message ${alertIndex} : </strong> ${alert}<br>`;
                                    alertIndex++;
                                });
                            } else {
                                // For a single alert, do not use the alertIndex
                                value.Alerts.forEach(function (alert) {
                                    errorMessage += `<strong>Message : </strong> ${alert}<br>`;
                                });
                            }
                        });
                        if (indicesToRemove.length > 0) {
                            //Commented and added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            //for (var i = indicesToRemove.length - 1; i >= 0; i--) {
                            //    timesheetEntries.splice(indicesToRemove[i], 1);
                            //}
                            //timesheetEntries.RemoveAll(entry => entry.ContainsKey("IsCorrectEntry") && Convert.ToInt32(entry["IsCorrectEntry"]) == 0);
                            timesheetEntries = timesheetEntries.filter(function (entry) {
                                return entry.IsCorrectEntry !== 0;
                            });
                            //End of Commented and added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                        }
                        if (errorMessage) {
                            $("#ValidationMessageModalinfo").modal("show");
                            //$("#txtValidationMessage").text(errorMessage);
                            $("#txtValidationMessage").empty();
                            $("#txtValidationMessage").append(errorMessage);
                            //alertify.error(errorMessage);
                            ////Added By Dipali V On 19th Feb 2025 For Copy task and Restrictions of Efforts filling checking on enabled that case efforts should clear
                            //if (IsTaskCopy == 1) {
                            //    timesheetEntriesUpdated.forEach(function (entry, index) {
                            //        var inputIdHidden = `#Duration_${entry.ProjectID}_${entry.TaskID}_${entry.SubTaskTypeID}_${entry.Day}`;
                            //        $(inputIdHidden).val('00:00');
                            //    });
                            //}
                            ////End of Added By Dipali V On 19th Feb 2025 For Copy task and Restrictions of Efforts filling checking on enabled that case efforts should clear
                            validationAlerts = [];
                        }
                        //Commented by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                        //timesheetEntries = [];
                        //End of Commented by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                        timesheetEntriesUpdated = [];                        
                    }
                }
            }
            else if (timesheetEntriesForCheckBox.length > 0) {
                $.ajax({
                    url: strUrl + '/api/TimesheetEntryNew/SaveDailyActivity',
                    type: "POST",
                    data: { '': timesheetEntriesForCheckBox },
                    dataType: "json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                        if (timesheetEntriesForCheckBox) {
                            xhr.setRequestHeader("Params", encryptString(isJson(timesheetEntriesForCheckBox) ? timesheetEntriesForCheckBox : JSON.stringify(timesheetEntriesForCheckBox)));
                        }
                    },
                    success: function (data) {
                        if (data == 1) {
                            alertify.set('notifier', 'position', 'top-right');
                            //alertify.success('Daily Activity entered and task completed successfully.');
                            alertify.success('<%=MyBase.GetResourceString("A_DAEntered")%>');
                            GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                            GetTaskData(SessionEmployeeId);
                            for (var i = 0; i < timesheetEntriesForCheckBox.length; i++) {
                                var thisElement = $('[data-bs-target=".superTab' + timesheetEntriesForCheckBox[i]["ProjectID"] + '"]');
                                PlotTaskDetails(timesheetEntriesForCheckBox[i]["ProjectID"], SessionEmployeeId, thisElement);
                                $(`.superTab${timesheetEntriesForCheckBox[i]["ProjectID"]}`).collapse('show');
                            }
                            timesheetEntriesForCheckBox = [];
                            //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                            EnableDisbaleDATextbox();
                            //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
                        } else if (data == 2) {
                            alertify.set('notifier', 'position', 'top-right');
                            //alertify.success('Daily Activity updated successfully.');
                            alertify.success('<%=MyBase.GetResourceString("A_DAUpdated")%>');
                            GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                            GetTaskData(SessionEmployeeId);
                            for (var i = 0; i < timesheetEntriesForCheckBox.length; i++) {
                                var thisElement = $('[data-bs-target=".superTab' + timesheetEntriesForCheckBox[i]["ProjectID"] + '"]');
                                PlotTaskDetails(timesheetEntriesForCheckBox[i]["ProjectID"], SessionEmployeeId, thisElement);
                                $(`.superTab${timesheetEntriesForCheckBox[i]["ProjectID"]}`).collapse('show');
                            }
                            timesheetEntriesForCheckBox = [];
                            //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                            EnableDisbaleDATextbox();
                            //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
                        }
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            else {
                $('[id^="Duration_"]').css({
                    'background-color': '',
                    'border': ''
                });
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error('Please fill daily activity.');
                alertify.error('<%=MyBase.GetResourceString("A_FillDA")%>');
            }
            button.disabled = false;
        }

        // Function to extract dates and generate the custom message
        function generateAlertMessage(alert) {
            var message = "";
            // Check if the alert message contains the pattern "Entry date for this task does not fall between"
            if (alert.includes("Entry date for this task does not fall between")) {
                // Use a regex to extract start date and end date from the alert message
                var datePattern = /\[([^\]]+)\]/g;
                var dates = [];
                var match;
                while ((match = datePattern.exec(alert)) !== null) {
                    dates.push(match[1]);
                }
                // Ensure we have both start and end dates
                if (dates.length === 2) {
                    var startDate = dates[0];
                    var endDate = dates[1];
                    message = `Message: Entry date for this task does not fall between the start date [${startDate}] and end date [${endDate}]`;
                }
            }
            return message;
        }
        var GConfirmFlag;        
        var timesheetEntriesUpdated = [];
        var validationAlerts = [];
        async function validateDailyEntry() {
            // debugger
            GConfirmFlag = 0;
            alertify.set('notifier', 'position', 'top-right');
            var Isvalid = 0;
            var IsTaskPrerequisitesDone = 0;
            timesheetEntriesUpdated = timesheetEntries.slice();
            for (var k = 0; k < timesheetEntries.length; k++) {
                var ProjectID = timesheetEntries[k]["ProjectID"]
                var Duration = timesheetEntries[k]["Duration"];
                var SubTaskTypeID = timesheetEntries[k]["SubTaskTypeID"];
                var TaskID = timesheetEntries[k]["TaskID"];
                var EntryDate = timesheetEntries[k]["EntryDate"];
                var Day = timesheetEntries[k]["Day"];
                var IsTaskCompleteCheck = timesheetEntries[k]["IsTaskComplete"];
                var HourPrecision = Duration.split(".")[0];
                var precision = Duration.split(".")[1];                            
                var ProjectName = timesheetEntries[k]["ProjectName"];
                var TaskName = timesheetEntries[k]["TaskName"];
                var StoryPoint = timesheetEntries[k]["StoryPoint"];
                var DailyActivityEntryID = timesheetEntries[k]["DailyActivityEntryID"];
                var IsAgileProject = timesheetEntries[k]["IsAgileProject"];
                if (precision > 60) {
                    var entry = {
                        TaskID: TaskID,
                        ProjectID: ProjectID,
                        SubTaskTypeID: SubTaskTypeID,
                        Day: Day,
                        Duration: Duration,
                        ProjectName: ProjectName,
                        TaskName: TaskName,
                        Alert: "Please enter minutes in two decimal and less than 60."
                    };
                    validationAlerts.push(entry);
                    Isvalid = 1;
                    IsTaskPrerequisitesDone = 1;
                    //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                    timesheetEntries[k]["IsCorrectEntry"] = 0;
                    //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                }
                if (precision == 60) {
                    var durationParts = Duration.split('.'); // Split into hours and minutes
                    var hours = parseInt(durationParts[0]); // Get the hours part
                    var minutes = parseInt(durationParts[1]); // Get the minutes part
                    hours = hours + 1;
                    Duration = formatTime(hours).replace(":", ".");
                    //Duration = minutesToTime(hours).replace(":", ".");
                    timesheetEntries[k]["Duration"] = Duration;
                }
                if (!timesheetEntries[k]["Duration"].replace(".", ":").includes(":")) {
                    var entry = {
                        TaskID: TaskID,
                        ProjectID: ProjectID,
                        SubTaskTypeID: SubTaskTypeID,
                        Day: Day,
                        Duration: Duration,
                        ProjectName: ProjectName,
                        TaskName: TaskName,
                        Alert: "Please enter numeric values for duration proper in hh:mm format."
                    };
                    validationAlerts.push(entry);
                    Isvalid = 1;
                    IsTaskPrerequisitesDone = 1;
                    //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                    timesheetEntries[k]["IsCorrectEntry"] = 0;
                    //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                }
                if (isNaN(HourPrecision) || isNaN(precision)) {
                    var entry = {
                        TaskID: TaskID,
                        ProjectID: ProjectID,
                        SubTaskTypeID: SubTaskTypeID,
                        Day: Day,
                        Duration: Duration,
                        ProjectName: ProjectName,
                        TaskName: TaskName,
                        Alert: "Please enter numeric values for duration proper in hh:mm format."
                    };
                    validationAlerts.push(entry);
                    Isvalid = 1;
                    IsTaskPrerequisitesDone = 1;
                    //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                    timesheetEntries[k]["IsCorrectEntry"] = 0;
                    //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                }
                if (CheckHHMMFormat(Duration) == true) {
                    var entry = {
                        TaskID: TaskID,
                        ProjectID: ProjectID,
                        SubTaskTypeID: SubTaskTypeID,
                        Day: Day,
                        Duration: Duration,
                        ProjectName: ProjectName,
                        TaskName: TaskName,
                        Alert: "Please enter numeric values for duration proper in hh:mm format."
                    };
                    validationAlerts.push(entry);
                    Isvalid = 1;
                    IsTaskPrerequisitesDone = 1;
                    //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                    timesheetEntries[k]["IsCorrectEntry"] = 0;
                    //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                }
                var DailyTotalId = `#txtDailyTotal_${Day}`;
                var DailyTotal = $(DailyTotalId).text();
                var DailyTotalMinutes = timeToMinutes(DailyTotal);                              
                var maxMinutes = 1440;

                var totalDurationMinutes = 0;
                var totalOldDurationMinutes = 0;
                var oldDailyDurationIdT = `#DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_${Day}`;
                var oldDailyDurationT = $(oldDailyDurationIdT).val();
                var oldDailyDurationMinutes = timeToMinutes(oldDailyDurationT);
                totalOldDurationMinutes = oldDailyDurationMinutes;

                for (var n = 0; n < timesheetEntries.length; n++) {
                    var entryDay = timesheetEntries[n]["Day"];
                    var duration = timesheetEntries[n]["Duration"];
                    if (entryDay == Day) {
                        var durationMinutes = timeToMinutes(duration.replace(".", ":"));
                        totalDurationMinutes += durationMinutes;
                    }
                }//Added by Vishal on 17/01/2024
                totalDurationMinutes = totalDurationMinutes - totalOldDurationMinutes;
                var Difference = DailyTotalMinutes - totalOldDurationMinutes;
               // debugger
                if ((totalDurationMinutes + Difference) > maxMinutes) {
                    var entry = {
                        TaskID: TaskID,
                        ProjectID: ProjectID,
                        SubTaskTypeID: SubTaskTypeID,
                        Day: Day,
                        Duration: Duration,
                        ProjectName: ProjectName,
                        TaskName: TaskName,
                        Alert: 'You can book only 24 hours in a day.'
                    };
                    validationAlerts.push(entry);
                    Isvalid = 1;
                    IsTaskPrerequisitesDone = 1;
                    //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                    timesheetEntries[k]["IsCorrectEntry"] = 0;
                    //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                }
                if (GlobalRestrictByMinHours != null) {
                    if (GlobalRestrictByMinHours == true) {
                        if (GlobalHoursFlag == 1) {
                            var minutes = Duration.split('.');
                            var p = minutes[0];
                            var dec = minutes[1];
                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);
                        }
                        else {
                            var d = Duration;
                        }
                        if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                            var entry = {
                                TaskID: TaskID,
                                ProjectID: ProjectID,
                                SubTaskTypeID: SubTaskTypeID,
                                Day: Day,
                                Duration: Duration,
                                ProjectName: ProjectName,
                                TaskName: TaskName,
                                Alert: 'Please specify the work (hours) in multiples of ' + MinDAENtryDisplay + ' hours.<br>This is necessary because the user can only fill a minimum of ' + MinDAENtryDisplay + ' hours in the timesheet',
                            };
                            validationAlerts.push(entry);
                            Isvalid = 1;
                            IsTaskPrerequisitesDone = 1;
                            //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            timesheetEntries[k]["IsCorrectEntry"] = 0;
                            //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                        }
                    }
                }
            }
            //If all the task prerequisites are proper then apply remaining validations
            var TotalWeekDurations = 0, GTaskID = 0;
            if (IsTaskPrerequisitesDone == 0) {
                //Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                var QuickActualTotal = [];
                for (var i = 0; i < timesheetEntries.length; i++) {
                    var ProjectID = timesheetEntries[i]["ProjectID"];
                    var SubTaskTypeID = timesheetEntries[i]["SubTaskTypeID"];
                    var TaskID = timesheetEntries[i]["TaskID"];
                    var WeeklyTotalId = `#TotalActualDurationhidden${ProjectID}_${TaskID}_${SubTaskTypeID}`;
                    var WeeklyTotal = $(WeeklyTotalId).val();
                    var RequestParameters = {
                        WorkHrs: encodeURI(WeeklyTotal),
                        Flag: encodeURI(2),
                    }
                    var param4 = JSON.stringify(RequestParameters);
                    var DynamicDurationhiddenval = AJAXCallWithResult("/api/TimesheetEntryNew/ConvertDecimalToHourViceVersa", param4, false);
                    var ActualWeekEntry = {
                        ProjectID: ProjectID,
                        TaskID: TaskID,
                        SubTaskTypeID: SubTaskTypeID,
                        ActualtotalWeekHours: parseFloat(DynamicDurationhiddenval),
                    };                    
                    var isDuplicate = QuickActualTotal.find(function (entry) {
                        return entry.ProjectID === ActualWeekEntry.ProjectID &&
                            entry.TaskID === ActualWeekEntry.TaskID &&
                            entry.SubTaskTypeID === ActualWeekEntry.SubTaskTypeID;
                    });
                    if (!isDuplicate) {
                        QuickActualTotal.push(ActualWeekEntry);
                    }
                }
                //End of Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo

                for (var i = 0; i < timesheetEntries.length; i++) {
                    var ProjectID = timesheetEntries[i]["ProjectID"]
                    var Duration = timesheetEntries[i]["Duration"];
                    var SubTaskTypeID = timesheetEntries[i]["SubTaskTypeID"];
                    var TaskID = timesheetEntries[i]["TaskID"];
                    var EntryDate = timesheetEntries[i]["EntryDate"];
                    var Day = timesheetEntries[i]["Day"];
                    var IsTaskCompleteCheck = timesheetEntries[i]["IsTaskComplete"];
                    var precision = Duration.split(".")[1];
                    var ProjectName = timesheetEntries[i]["ProjectName"];
                    var TaskName = timesheetEntries[i]["TaskName"];
                    var StoryPoint = timesheetEntries[i]["StoryPoint"];
                    var DailyActivityEntryID = timesheetEntries[i]["DailyActivityEntryID"];
                    var IsAgileProject = timesheetEntries[i]["IsAgileProject"];                                
                    if (IsTaskCompleteCheck == false) {
                        IsTaskCompleteCheck = 0;
                    }
                    else {
                        IsTaskCompleteCheck = 1;
                    }
                    var WeeklyTotalId = `#TotalActualDurationhidden${ProjectID}_${TaskID}_${SubTaskTypeID}`;
                    var WeeklyTotal = $(WeeklyTotalId).val();

                    var oldDurationId = `#DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_${Day}`;
                    var oldDuration = $(oldDurationId).val();

                    var weeklyTotalMinutes = timeToMinutes(WeeklyTotal);
                    if (TotalWeekDurations == 0) {
                        TotalWeekDurations = weeklyTotalMinutes;
                    }
                    if (TaskID != GTaskID) {
                        TotalWeekDurations = weeklyTotalMinutes;
                    }
                    var durationMinutes = timeToMinutes(Duration.replace(".", ":"));
                    var oldDurationMinutes = timeToMinutes(oldDuration);
                    var inputTotalDurationInMinutes;
                    if (durationMinutes > oldDurationMinutes) {
                        inputTotalDurationInMinutes = Math.abs(durationMinutes - oldDurationMinutes + weeklyTotalMinutes);
                    } else {
                        inputTotalDurationInMinutes = Math.abs(weeklyTotalMinutes - durationMinutes);
                    }
                    //Added By Dipali V On 14th Feb 2024 For If Try to copy efforts from Previous week then alert missing
                    if (IsTaskCopy == 1) {
                        // if (TaskID == GTaskID || GTaskID==0) {
                        if (weeklyTotalMinutes == TotalWeekDurations) {
                            inputTotalDurationInMinutes = Math.abs(weeklyTotalMinutes + durationMinutes);
                            TotalWeekDurations = inputTotalDurationInMinutes;
                        } else {
                            inputTotalDurationInMinutes = Math.abs(TotalWeekDurations + durationMinutes);
                            TotalWeekDurations += durationMinutes;
                        }
                    }
                    //End of Added By Dipali V On 14th Feb 2024 For If Try to copy efforts from Previous week then alert missing
                    //// Convert the result back to "HH:MM"
                    var inputTotalDuration = minutesToTime(inputTotalDurationInMinutes).replace(":", ".");
                    //Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                    var fltTotalDuration = 0;
                    var entry = QuickActualTotal.find(function (item) {
                        return item.ProjectID === ProjectID &&
                            item.TaskID === TaskID &&
                            item.SubTaskTypeID === SubTaskTypeID;
                    });
                    if (entry) {
                        fltTotalDuration = entry.ActualtotalWeekHours;
                    }
                    var RequestParameters = {
                        WorkHrs: encodeURI(Duration),
                        Flag: encodeURI(2),
                    }
                    var param = JSON.stringify(RequestParameters);
                    var fltDuration = AJAXCallWithResult("/api/TimesheetEntryNew/ConvertDecimalToHourViceVersa", param, false);
                    fltTotalDuration = fltTotalDuration + parseFloat(fltDuration);
                    //End of Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                    var taskParameters = {
                        intEmployeeID: parseInt(SessionEmployeeId),
                        dtFromDate: EntryDate,
                        ProjectID: ProjectID,
                        TaskID: TaskID,
                        SubTaskTypeID: SubTaskTypeID,
                        Duration: parseFloat(Duration),
                        //Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                        //TotalDuration: inputTotalDuration,
                        TotalDuration: fltTotalDuration,
                        //End of Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                        IsTaskComplete: IsTaskCompleteCheck,
                        Flag: "",
                    }
                    var param = JSON.stringify(taskParameters);
                    var data = AJAXCallWithResult("/api/TimesheetEntryNew/ValidateDA", param, false);
                    totalEnteredHours = 0;
                    //Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                    var existingEntry = QuickActualTotal.find(function (entry) {
                        //Commented and added by Vishal Mane on 30/07/2025 to fix Max Hours validation issue for Expleo
                        //return entry.ProjectID === ActualWeekEntry.ProjectID &&
                        //    entry.TaskID === ActualWeekEntry.TaskID &&
                        //    entry.SubTaskTypeID === ActualWeekEntry.SubTaskTypeID;
                        return entry.ProjectID === ProjectID &&
                            entry.TaskID === TaskID &&
                            entry.SubTaskTypeID === SubTaskTypeID;
                        //End of Commented and added by Vishal Mane on 30/07/2025 to fix Max Hours validation issue for Expleo
                    });
                    if (existingEntry) {
                        existingEntry.ActualtotalWeekHours = parseFloat(existingEntry.ActualtotalWeekHours) + parseFloat(Duration);
                    }
                    //End of Added by Vishal Mane on 01/07/2025 to fix Max Hours validation issue for Expleo
                    var Gsflag = 0;
                    if (data != "") {
                        if (data.indexOf('$$') >= 0) {
                            var arrValue = data.split('$$');
                            var entry = {
                                TaskID: TaskID,
                                ProjectID: ProjectID,
                                SubTaskTypeID: SubTaskTypeID,
                                Day: Day,
                                Duration: Duration,
                                ProjectName: ProjectName,
                                TaskName: TaskName,
                                Alert: arrValue[1],
                            };
                            validationAlerts.push(entry);
                            Isvalid = 1;
                            //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            timesheetEntries[i]["IsCorrectEntry"] = 0;
                            //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                        }
                        else if (data.indexOf('@@') >= 0) {
                            var arrValue = data.split('@@');
                            var entry = {
                                TaskID: TaskID,
                                ProjectID: ProjectID,
                                SubTaskTypeID: SubTaskTypeID,
                                Day: Day,
                                Duration: Duration,
                                ProjectName: ProjectName,
                                TaskName: TaskName,
                                Alert: arrValue[1],
                            };
                            validationAlerts.push(entry);
                            Isvalid = 1;
                            //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            timesheetEntries[i]["IsCorrectEntry"] = 0;
                            //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                        }
                        else if (data.indexOf('##') >= 0) {
                            var arrValue = data.split('##');
                            if (arrValue[0] == 1) {
                                var entry = {
                                    TaskID: TaskID,
                                    ProjectID: ProjectID,
                                    SubTaskTypeID: SubTaskTypeID,
                                    Day: Day,
                                    Duration: Duration,
                                    ProjectName: ProjectName,
                                    TaskName: TaskName,
                                    Alert: arrValue[1],
                                };
                                validationAlerts.push(entry);
                                Isvalid = 1;
                                //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                timesheetEntries[i]["IsCorrectEntry"] = 0;
                                //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            }
                            // else if (arrValue[0] == 0 && timesheetEntries[i]["ConfirmFlag"] == 0) {
                            //else if (arrValue[0] == 0 && timesheetEntries[i]["ConfirmFlag"] == 0 && timesheetEntries[i]["IsAllowToFillDAAfterValidate"] == 0) {
                            else if (arrValue[0] == 0 && timesheetEntries[i]["ConfirmFlag"] == 0) {
                                Gsflag = 1;
                                if (timesheetEntries[i]["IsAllowToFillDAAfterValidate"] == 0) {
                                    $("#ConfirmMessagemodalinfo").modal('show');
                                    $("#ConfirmationMsg").html(arrValue[1]);
                                    //Commented and added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                    //var inputId = `#Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_${Day}`;
                                    //$(inputId).css({
                                    //    'background-color': '#f8d7da',
                                    //    'border': '1px solid #f5c6cb'
                                    //});
                                    //End of Commented and added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                    await getConfirmationResponse().then(response => {
                                        GConfirmFlag = response;
                                        $("#ConfirmMessagemodalinfo").modal('dispose');
                                        $("#ConfirmMessagemodalinfo").css('display', 'none');
                                        $(inputId).css({
                                            'background-color': '',
                                            'border': ''
                                        });
                                    });
                                }                                
                                if (GConfirmFlag == 1) {
                                    //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                    var inputId = `#Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_${Day}`;
                                    $(inputId).css({
                                        'background-color': '',
                                        'border': ''
                                    });
                                    //End of added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                    var index = timesheetEntriesUpdated.findIndex(function (entry) {
                                        return entry.ProjectID == timesheetEntries[i]["ProjectID"] && entry.TaskID == timesheetEntries[i]["TaskID"] && entry.Day == timesheetEntries[i]["Day"];
                                    });
                                    if (index !== -1) {
                                        timesheetEntriesUpdated[index]["ConfirmFlag"] = GConfirmFlag;
                                    }
                                    //Added By Dipali V On 19th Feb 2025 For Alert of YES/NO should display one time only                                   
                                    for (let j = 0; j < timesheetEntriesUpdated.length; j++) {
                                        if (
                                            timesheetEntriesUpdated[j].ProjectID === timesheetEntries[i].ProjectID &&
                                            timesheetEntriesUpdated[j].TaskID === timesheetEntries[i].TaskID
                                        ) {
                                            timesheetEntriesUpdated[j]["IsAllowToFillDAAfterValidate"] = 1;
                                            //break; // Exit inner loop early since we found a match
                                        }                                       
                                    }                                   
                                    //End of Added By Dipali V On 19th Feb 2025 For Alert of YES/NO should display one time only
                                }
                                else {
                                    //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                    var inputId = `#Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_${Day}`;
                                    $(inputId).css({
                                        'background-color': '#f8d7da',
                                        'border': '1px solid #f5c6cb'
                                    });
                                    //End of added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                    var inputIdHidden = `#DurationHidden_${timesheetEntries[i]["ProjectID"]}_${timesheetEntries[i]["TaskID"]}_${timesheetEntries[i]["SubTaskTypeID"]}_${timesheetEntries[i]["Day"]}`;
                                    var HiddenValue = $(inputIdHidden).val();
                                    if (parseFloat(HiddenValue) !== parseFloat(timesheetEntries[i]["Duration"])) {
                                        var inputId = `#Duration_${timesheetEntries[i]["ProjectID"]}_${timesheetEntries[i]["TaskID"]}_${timesheetEntries[i]["SubTaskTypeID"]}_${timesheetEntries[i]["Day"]}`;
                                        $(inputId).val(HiddenValue);
                                    }
                                    //Added By Dipali V On 14th Feb 2024 For If Try to copy efforts from Previous week then alert missing
                                    if (IsTaskCopy == 1) {
                                        $(inputId).val("00:00");
                                    }
                                    //End of Added By Dipali V On 14th Feb 2024 For If Try to copy efforts from Previous week then alert missing
                                    var index = timesheetEntriesUpdated.findIndex(function (entry) {
                                        return entry.ProjectID == timesheetEntries[i]["ProjectID"] && entry.TaskID == timesheetEntries[i]["TaskID"] && entry.Day == timesheetEntries[i]["Day"];
                                    });
                                    if (index !== -1) {
                                        timesheetEntriesUpdated[index]["ConfirmFlag"] = GConfirmFlag;
                                    }
                                    //Added By Dipali V On 19th Feb 2025 For Alert of YES/NO should display one time only
                                    for (let j = 0; j < timesheetEntriesUpdated.length; j++) {
                                        if (timesheetEntriesUpdated[j].ProjectID === timesheetEntries[i].ProjectID && timesheetEntriesUpdated[j].TaskID === timesheetEntries[i].TaskID)
                                        {
                                            timesheetEntriesUpdated[j]["IsAllowToFillDAAfterValidate"] = 1;
                                            //break; // Exit inner loop early since we found a match
                                        }                                       
                                    }                                    
                                    //End of Added By Dipali V On 19th Feb 2025 For Alert of YES/NO should display one time only                                    

                                    //Commented and added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                    //timesheetEntriesUpdated.splice(index, 1);                                    
                                    timesheetEntriesUpdated[i]["IsCorrectEntry"] = 0;                                    
                                    timesheetEntries[i]["IsCorrectEntry"] = 0;
                                    //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                }
                            }
                        }
                        else if (data.indexOf('**') >= 0) {
                        }
                        else {
                            if (Duration != "00.00" && Duration != "00:00") {
                                var entry = {
                                    TaskID: TaskID,
                                    ProjectID: ProjectID,
                                    SubTaskTypeID: SubTaskTypeID,
                                    Day: Day,
                                    Duration: Duration,
                                    ProjectName: ProjectName,
                                    TaskName: TaskName,
                                    Alert: data,
                                };
                                validationAlerts.push(entry);
                                Isvalid = 1;
                                //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                timesheetEntries[i]["IsCorrectEntry"] = 0;
                                //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            }
                            else {

                                var entry = {
                                    TaskID: TaskID,
                                    ProjectID: ProjectID,
                                    SubTaskTypeID: SubTaskTypeID,
                                    Day: Day,
                                    Duration: Duration,
                                    ProjectName: ProjectName,
                                    TaskName: TaskName,
                                    Alert: data,
                                };
                                validationAlerts.push(entry);
                                Isvalid = 1;
                                //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                timesheetEntries[i]["IsCorrectEntry"] = 0;
                                //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            }
                        }
                    }

                    //Added for story point validation
                    if (IsAgileProject == 1) {
                        var taskParameters = {
                            TaskID: TaskID,
                            StoryPoint: StoryPoint,
                            dtFromDate: EntryDate,
                            DAID: DailyActivityEntryID,
                        }
                        var param = JSON.stringify(taskParameters);
                        var data = AJAXCallWithResult("/api/TimesheetEntryNew/ValidateStoryPoint", param, false);
                        if (data != "") {
                            //showAlert(data, 'alert-danger');
                            var entry = {
                                TaskID: TaskID,
                                ProjectID: ProjectID,
                                SubTaskTypeID: SubTaskTypeID,
                                Day: Day,
                                Duration: Duration,
                                ProjectName: ProjectName,
                                TaskName: TaskName,
                                Alert: data,
                            };
                            validationAlerts.push(entry);
                            Isvalid = 1;
                            //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            timesheetEntries[i]["IsCorrectEntry"] = 0;
                            //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                        }
                    }
                    //End of Added for story point validation
                    GTaskID = TaskID;
                }

                //End of If all the task prerequisites are proper then apply remaining 
                if (Gsflag == 1) {
                    var allConfirmedZero = true;
                    timesheetEntriesUpdated.forEach(function (entry) {
                        if (entry.ConfirmFlag !== 0) {
                            allConfirmedZero = false;
                        }
                    });
                    if (allConfirmedZero && Isvalid == 0) {
                        //Added by Dipali V On 17th Feb 2025 For Validate Efforts when Task Copy from Previous Week
                        if (IsTaskCopy == 0) {
                            //Commented by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            //timesheetEntries = [];
                            //End of Commented by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                            timesheetEntriesUpdated = [];
                        }
                        //End of Added by Dipali V On 17th Feb 2025 For Validate Efforts when Task Copy from Previous Week
                    }
                }
            }            
            return Isvalid;
        }

        // Helper function to convert time string "HH:MM" to minutes
        function timeToMinutes(time) {
            //debugger
            var parts = time.split(":");
            //var hours = parseInt(parts[0], 10);  // Extract hours and convert to integer
            //var minutes = parseInt(parts[1], 10);  // Extract minutes and convert to integer
            var hours = parts[0] ? parseInt(parts[0], 10) : 0; // Handle empty or invalid hours
            var minutes = parts[1] ? parseInt(parts[1], 10) : 0; // Handle empty or invalid minutes
            return ((hours * 60) + minutes);  // Convert the total time into minutes
        }

        // Helper function to convert minutes back to "HH:MM"
        function minutesToTime(minutes) {
            var hours = Math.floor(minutes / 60);
            var mins = minutes % 60;
            return (hours < 10 ? '0' : '') + hours + ':' + (mins < 10 ? '0' : '') + mins;
        }
        function getConfirmationResponse() {
            return new Promise(resolve => {
                $('#btnConfirmTaskYes').off('click').on('click', function () {
                    GConfirmFlag = 1;
                    resolve(GConfirmFlag);
                });

                $('#btnConfirmTaskNo').off('click').on('click', function () {
                    GConfirmFlag = 0;
                    resolve(GConfirmFlag);
                });

                $('#btnConfirmTaskNo1').off('click').on('click', function () {
                    GConfirmFlag = 0;                    
                    resolve(GConfirmFlag);
                });

            });
        }
        var GFlag = 0;
        var WhereClause = "";
        function GetTSSaveFilter() {
            //debugger            
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //var EmployeeID = '<%= Session("intUserID") %>'.toString();
            var EmployeeID = SessionEmployeeId;
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            var Parameters = {
                intEmployeeID: EmployeeID
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/GetTSSaveFilter", param, false);
            if (Result != "") {                
                var IsBillable = "";
                var ProjectList = "";
                var TaskTypeList = "";
                var TaskCategoriesList = "";
                var SubProjectList = "";
                var MilestoneList = "";
                var DeliverableList = "";
                var PhaseList = "";
                var TaskStatusList = "";
                var PriorityList = "";
                var BillableTaskList = "";   
                GFlag = 0;
                GetAssignedProjects();
                var filterValues;
                filterValues = jQuery.parseJSON(Result[0].FilterValues);
                filterValues = isJson(filterValues) ? JSON.parse(filterValues) : filterValues
                ProjectList = filterValues.strFilterProjectList.split(',');
                TaskTypeList = filterValues.strFilterTaskTypeList.split(',');
                TaskCategoriesList = filterValues.strFilterTaskCategories.split(',');
                SubProjectList = filterValues.strFilterSubProjectList.split(',');
                MilestoneList = filterValues.strFilterMilestoneList.split(',');
                DeliverableList = filterValues.strFilterDeliverableList.split(',');
                PhaseList = filterValues.strFilterPhaseList.split(',');
                TaskStatusList = filterValues.strFilterTaskStatus.split(',');
                PriorityList = filterValues.strFilterPriorityList.split(',');
                IsBillable = filterValues.strFilterBillable;
                BillableTaskList = filterValues.strFilterBillable.split(',');
                for (var i = 0; i < BillableTaskList.length; i++) {
                    $("#TaskBillable" + BillableTaskList[i]).prop("checked", true)
                }
                var ProjectNames = [];
                var TaskType = [];
                var TaskCategories = [];
                var SubProject = [];
                var Milestone = [];
                var Phase = [];
                var Deliverable = [];
                var TaskStatus = [];
                var Priority = [];
                //if (IsBillable == 1) {
                //    $("#chkBillable").prop("checked", true);
                //}
                //else {
                //    $("#chkBillable").prop("checked", false);
                //}
                /********************** Projects ********************/
                for (var i = 0; i < ProjectList.length; i++) {
                    $("#ProjectFil" + ProjectList[i]).prop("checked", true)
                    //ProjectNames = $('label[for="ProjectFil' + ProjectList[i] + '"]').text();
                }
                GetProjectsFilterDataset();
                var selector = ProjectList.map(id => `label[for="ProjectFil${id}"]`).join(',');
                var labels = $(selector);
                labels.each(function () {
                    ProjectNames.push($(this).html());
                });
                ProjectNames = ProjectNames.join(',');
                var strHTML = "";
                if (ProjectNames != "") {
                    strHTML += `<div  class="filterName" id="filterNamePrj">
                                    <span class="fw-600">Project:</span>
                                    <span>${ProjectNames}</span>
                                    <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Prj')"></i>
                                </div>`
                }
                for (var i = 0; i < TaskTypeList.length; i++) {
                    $("#TaskTypeFil" + TaskTypeList[i]).prop("checked", true)
                }
                var selector = TaskTypeList.map(id => `label[for="TaskTypeFil${id}"]`).join(',');
                var labels = $(selector);
                labels.each(function () {
                    TaskType.push($(this).html());
                });
                TaskType = TaskType.join(',');

                for (var i = 0; i < TaskCategoriesList.length; i++) {
                    $("#TaskCatgryFil" + TaskCategoriesList[i]).prop("checked", true)
                }
                var selector = TaskCategoriesList.map(id => `label[for="TaskCatgryFil${id}"]`).join(',');
                var labels = $(selector);
                labels.each(function () {
                    TaskCategories.push($(this).html());
                });
                TaskCategories = TaskCategories.join(',');

                for (var i = 0; i < SubProjectList.length; i++) {
                    $("#SubProjectFil" + SubProjectList[i]).prop("checked", true)
                }
                var selector = SubProjectList.map(id => `label[for="SubProjectFil${id}"]`).join(',');
                var labels = $(selector);
                labels.each(function () {
                    SubProject.push($(this).html());
                });
                SubProject = SubProject.join(',');

                for (var i = 0; i < MilestoneList.length; i++) {
                    $("#TaskMilestoneFil" + MilestoneList[i]).prop("checked", true)
                }
                var selector = MilestoneList.map(id => `label[for="TaskMilestoneFil${id}"]`).join(',');
                var labels = $(selector);
                labels.each(function () {
                    Milestone.push($(this).html());
                });
                Milestone = Milestone.join(',');

                for (var i = 0; i < DeliverableList.length; i++) {
                    $("#DeliverableFil" + DeliverableList[i]).prop("checked", true)
                }
                var selector = DeliverableList.map(id => `label[for="DeliverableFil${id}"]`).join(',');
                var labels = $(selector);
                labels.each(function () {
                    Deliverable.push($(this).html());
                });
                Deliverable = Deliverable.join(',');

                for (var i = 0; i < PhaseList.length; i++) {
                    $("#PhaseFil" + PhaseList[i]).prop("checked", true)
                }
                var selector = PhaseList.map(id => `label[for="PhaseFil${id}"]`).join(',');
                var labels = $(selector);
                labels.each(function () {
                    Phase.push($(this).html());
                });
                Phase = Phase.join(',');

                for (var i = 0; i < TaskStatusList.length; i++) {
                    $("#TaskStatusFil" + TaskStatusList[i]).prop("checked", true)
                }
                var selector = TaskStatusList.map(id => `label[for="TaskStatusFil${id}"]`).join(',');
                var labels = $(selector);
                labels.each(function () {
                    TaskStatus.push($(this).html());
                });
                TaskStatus = TaskStatus.join(',');

                for (var i = 0; i < PriorityList.length; i++) {
                    $("#TaskPriorityFil" + PriorityList[i]).prop("checked", true)
                }
                var selector = PriorityList.map(id => `label[for="TaskPriorityFil${id}"]`).join(',');
                var labels = $(selector);
                labels.each(function () {
                    Priority.push($(this).html());
                });
                Priority = Priority.join(',');
                if (TaskType != "") {

                    strHTML += `<div class="filterName" id="filterNameTaskType">
                                    <span class="fw-600">Task Type:</span>
                                    <span>${TaskType}</span>
                                    <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'TaskType')"></i>
                                </div>`
                }
                if (TaskCategories != "") {

                    strHTML += ` <div class="filterName" id="filterNameTaskCategories">
                                        <span class="fw-600">Task Category:</span>
                                        <span>${TaskCategories}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'TaskCategories')"></i>
                                    </div>`
                }
                if (SubProject != "") {

                    strHTML += ` <div class="filterName">
                                        <span class="fw-600">Sub Project:</span>
                                        <span>${SubProject}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'SubProject')"></i>
                                    </div>`
                }
                if (Milestone != "") {

                    strHTML += ` <div class="filterName" id="filterNameMilestone">
                                        <span class="fw-600">Milestone:</span>
                                        <span>${Milestone}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Milestone')"></i>
                                    </div>`
                }
                if (Deliverable != "") {

                    strHTML += ` <div class="filterName" id="filterNameDeliverable">
                                        <span class="fw-600">Deliverable:</span>
                                        <span>${Deliverable}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Deliverable')"></i>
                                  </div>`
                }
                if (Phase != "") {

                    strHTML += ` <div class="filterName" id="filterNamePhase">
                                        <span class="fw-600">Phase:</span>
                                        <span>${Phase}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Phase')"></i>
                                    </div>`
                }
                if (TaskStatus != "") {

                    strHTML += `  <div class="filterName" id="filterNameTaskStatus">
                                        <span class="fw-600">Status:</span>
                                        <span>${TaskStatus}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'TaskStatus')"></i>
                                    </div>`
                }
                if (Priority != "") {

                    strHTML += ` <div class="filterName" id="filterNamePriority">
                                        <span class="fw-600">Priority:</span>
                                        <span>${Priority}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Priority')"></i>
                                    </div>`
                }
                //if (SOWCategory != "") {

                //    strHTML += ` <div class="filterName" id="filterNameSOWCategory">
                //                        <span class="fw-600">SOW Category:</span>
                //                        <span>${SOWCategory}</span>
                //                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'SOWCategory')"></i>
                //                    </div>`
                //}
                //if (SOWParticular != "") {

                //    strHTML += `  <div class="filterName" id="filterNameSOWParticular">
                //                        <span class="fw-600">SOW Particular:</span>
                //                        <span>${SOWParticular}</span>
                //                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'SOWParticular')"></i>
                //                    </div>`
                //}
                if (IsBillable === "1") {

                    strHTML += `<div class="filterName" id="filterNameBillable">
                                        <span class="fw-600">Billable:</span>
                                        <span>Yes</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'BillableY')"></i>
                                    </div>`;
                }
                else if (IsBillable === "0"){

                    strHTML += `<div class="filterName" id="filterNameBillable">
                                        <span class="fw-600">Billable:</span>
                                        <span>No</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'BillableN')"></i>
                                    </div>`;
                }
                else if (IsBillable === "1,0") {

                    strHTML += `<div class="filterName" id="filterNameBillable">
                                        <span class="fw-500">Billable:</span>
                                        <span>Yes,No</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'BillableYN')"></i>
                                    </div>`;
                }
                $("#dvAppliedFilters").html(strHTML);
                $("#ProjectFilterSec").show();
                $("#TaskTypeFilterSec").show();
                $("#TaskCatgryFilterSec").show();
                $("#TaskStatusFilterSec").show();
                $("#TaskPriorityFilterSec").show();
                $("#TaskMilestoneFilterSec").show();
                $("#SubProjectFilterSec").show();
                $("#DeliverableFilterSec").show();
                $("#PhaseFilterSec").show();
                GFlag = 1;
                WhereClause = Result[0].FilterValues;
            }
            else {
                WhereClause = "";
            }
            if (WhereClause != "") {
                $("#filterSection").show();
            } else {
                $("#filterSection").hide();
            }

            return Result;
        }

        function ApplyTSFilter(ProjFlag, filterflag) {
            //debugger
            var ProjectIDList = "";
            var TaskTypeIDList = "";
            var TaskCategoriesIDList = "";
            var SubProjectIDList = "";
            var MilestoneIDList = "";
            var DeliverableIDList = "";
            var PhaseIDList = "";
            var TaskStatusIDList = "";
            var PriorityIDList = "";
            var IsBillable = ""; 
            var ProjectList = document.getElementsByName("ProjectList");
            var TaskTypeList = document.getElementsByName("TaskType");
            var TaskCategoriesList = document.getElementsByName("TaskCategory");
            var SubProjectList = document.getElementsByName("SubProject");
            var MilestoneList = document.getElementsByName("Milestone");
            var DeliverableList = document.getElementsByName("Deliverable");
            var PhaseList = document.getElementsByName("Phase");
            var TaskStatusList = document.getElementsByName("TaskStatus");
            var PriorityList = document.getElementsByName("Priorities");
            /********************** Projects ********************/
            for (var i = 0; i < ProjectList.length; i++) {
                if (ProjectList[i].checked == true) {
                    if (ProjectIDList == "") {
                        ProjectIDList += ProjectList[i].value;
                    }
                    else {
                        ProjectIDList += ',' + ProjectList[i].value;
                    }

                }
            }
            if (ProjFlag == 1) {
                GetTaskData(SessionEmployeeId);
            }
            else {
                if (ProjectIDList.length == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please select atleast one Project.');
                }
                else if (ProjectIDList.split(',').length <= 5) {
                    /********************** Task Type ********************/
                    for (var i = 0; i < TaskTypeList.length; i++) {

                        if (TaskTypeList[i].checked == true) {
                            if (TaskTypeIDList == "") {
                                TaskTypeIDList += TaskTypeList[i].value;
                            }
                            else {
                                TaskTypeIDList += ',' + TaskTypeList[i].value;
                            }

                        }
                    }

                    /********************** Task Categories ********************/
                    for (var i = 0; i < TaskCategoriesList.length; i++) {

                        if (TaskCategoriesList[i].checked == true) {
                            if (TaskCategoriesIDList == "") {
                                TaskCategoriesIDList += TaskCategoriesList[i].value;
                            }
                            else {
                                TaskCategoriesIDList += ',' + TaskCategoriesList[i].value;
                            }

                        }
                    }

                    /********************** Sub Project ********************/
                    for (var i = 0; i < SubProjectList.length; i++) {

                        if (SubProjectList[i].checked == true) {
                            if (SubProjectIDList == "") {
                                SubProjectIDList += SubProjectList[i].value;
                            }
                            else {
                                SubProjectIDList += ',' + SubProjectList[i].value;
                            }

                        }
                    }

                    /********************** Milestone ********************/
                    for (var i = 0; i < MilestoneList.length; i++) {

                        if (MilestoneList[i].checked == true) {
                            if (MilestoneIDList == "") {
                                MilestoneIDList += MilestoneList[i].value;
                            }
                            else {
                                MilestoneIDList += ',' + MilestoneList[i].value;
                            }

                        }
                    }

                    /********************** Deliverable ********************/
                    for (var i = 0; i < DeliverableList.length; i++) {

                        if (DeliverableList[i].checked == true) {
                            if (DeliverableIDList == "") {
                                DeliverableIDList += DeliverableList[i].value;
                            }
                            else {
                                DeliverableIDList += ',' + DeliverableList[i].value;
                            }

                        }
                    }

                    /********************** Phase ********************/
                    for (var i = 0; i < PhaseList.length; i++) {

                        if (PhaseList[i].checked == true) {
                            if (PhaseIDList == "") {
                                PhaseIDList += PhaseList[i].value;
                            }
                            else {
                                PhaseIDList += ',' + PhaseList[i].value;
                            }

                        }
                    }

                    /********************** Task Status ********************/
                    for (var i = 0; i < TaskStatusList.length; i++) {

                        if (TaskStatusList[i].checked == true) {
                            if (TaskStatusIDList == "") {
                                TaskStatusIDList += TaskStatusList[i].value;
                            }
                            else {
                                TaskStatusIDList += ',' + TaskStatusList[i].value;
                            }

                        }
                    }

                    /********************** Priority ********************/
                    for (var i = 0; i < PriorityList.length; i++) {

                        if (PriorityList[i].checked == true) {
                            if (PriorityIDList == "") {
                                PriorityIDList += PriorityList[i].value;
                            }
                            else {
                                PriorityIDList += ',' + PriorityList[i].value;
                            }

                        }
                    }                    
                    //Added and commented by Vishal Mane on 15/01/2025 to implement Billable dropdown functionality
                    var BillableList = document.getElementsByName("TaskBillable");
                    var BillableIDList = "";
                    for (var i = 0; i < BillableList.length; i++) {
                        if (BillableList[i].checked == true) {
                            if (BillableIDList == "") {
                                BillableIDList += BillableList[i].value;
                            }
                            else {
                                BillableIDList += ',' + BillableList[i].value;
                            }
                        }
                    }
                    if (BillableIDList === "1,0") {
                        IsBillable = "";
                    } else {
                        IsBillable = BillableIDList;
                    }
                    
                    var FilterClause = {
                        strFilterProjectList: ProjectIDList,
                        strFilterTaskTypeList: TaskTypeIDList,
                        strFilterTaskCategories: TaskCategoriesIDList,
                        strFilterSubProjectList: SubProjectIDList,
                        strFilterMilestoneList: MilestoneIDList,
                        strFilterDeliverableList: DeliverableIDList,
                        strFilterPhaseList: PhaseIDList,
                        strFilterTaskStatus: TaskStatusIDList,
                        strFilterPriorityList: PriorityIDList,
                        strFilterBillable: IsBillable
                    }

                    if (ProjectIDList == "" && TaskTypeIDList == "" && TaskCategoriesIDList == "" && SubProjectIDList == "" && MilestoneIDList == "" &&
                        DeliverableIDList == "" && PhaseIDList == "" && TaskStatusIDList == "" && PriorityIDList == "" && IsBillable == "") {
                        WhereClause = "";
                    }
                    else {
                        WhereClause = JSON.stringify(FilterClause);
                    }

                    if (WhereClause != "") {
                        $("#filterSection").show();
                    } else {
                        $("#filterSection").hide();
                    }

                    if (IsBillable == 1) {
                        $("#chkBillable").prop("checked", true);
                    }
                    else {
                        $("#chkBillable").prop("checked", false);
                    }

                    var ProjectNames = [];
                    var TaskType = [];
                    var TaskCategories = [];
                    var SubProject = [];
                    var Milestone = [];
                    var Phase = [];
                    var Deliverable = [];
                    var TaskStatus = [];
                    var Priority = [];
                    var selector = ProjectIDList.split(',').map(id => `label[for="ProjectFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        ProjectNames.push($(this).html());
                    });
                    ProjectNames = ProjectNames.join(',');

                    var selector = TaskTypeIDList.split(',').map(id => `label[for="TaskTypeFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        TaskType.push($(this).html());
                    });
                    TaskType = TaskType.join(',');

                    var selector = TaskCategoriesIDList.split(',').map(id => `label[for="TaskCatgryFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        TaskCategories.push($(this).html());
                    });
                    TaskCategories = TaskCategories.join(',');

                    var selector = SubProjectIDList.split(',').map(id => `label[for="SubProjectFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        SubProject.push($(this).html());
                    });
                    SubProject = SubProject.join(',');

                    var selector = MilestoneIDList.split(',').map(id => `label[for="TaskMilestoneFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        Milestone.push($(this).html());
                    });
                    Milestone = Milestone.join(',');

                    var selector = DeliverableIDList.split(',').map(id => `label[for="DeliverableFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        Deliverable.push($(this).html());
                    });
                    Deliverable = Deliverable.join(',');

                    var selector = PhaseIDList.split(',').map(id => `label[for="PhaseFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        Phase.push($(this).html());
                    });
                    Phase = Phase.join(',');

                    var selector = TaskStatusIDList.split(',').map(id => `label[for="TaskStatusFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        TaskStatus.push($(this).html());
                    });
                    TaskStatus = TaskStatus.join(',');

                    var selector = PriorityIDList.split(',').map(id => `label[for="TaskPriorityFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        Priority.push($(this).html());
                    });
                    Priority = Priority.join(',');
                    var strHTML = "";
                    if (ProjectNames != "") {
                        strHTML += `<div  class="filterName" id="filterNamePrj">
                                        <span class="fw-600">Project:</span>
                                        <span>${ProjectNames}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Prj')"></i>
                                    </div>`
                    }

                    if (TaskType != "") {

                        strHTML += `<div class="filterName" id="filterNameTaskType">
                                        <span class="fw-600">Task Type:</span>
                                        <span>${TaskType}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'TaskType')"></i>
                                    </div>`
                    }
                    if (TaskCategories != "") {

                        strHTML += ` <div class="filterName" id="filterNameTaskCategories">
                                        <span class="fw-600">Task Category:</span>
                                        <span>${TaskCategories}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'TaskCategories')"></i>
                                    </div>`
                    }
                    if (SubProject != "") {

                        strHTML += ` <div class="filterName">
                                        <span class="fw-600">Sub Project:</span>
                                        <span>${SubProject}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'SubProject')"></i>
                                    </div>`
                    }
                    if (Milestone != "") {

                        strHTML += ` <div class="filterName" id="filterNameMilestone">
                                        <span class="fw-600">Milestone:</span>
                                        <span>${Milestone}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Milestone')"></i>
                                    </div>`
                    }
                    if (Deliverable != "") {

                        strHTML += ` <div class="filterName" id="filterNameDeliverable">
                                        <span class="fw-600">Deliverable:</span>
                                        <span>${Deliverable}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Deliverable')"></i>
                                  </div>`
                    }
                    if (Phase != "") {

                        strHTML += ` <div class="filterName" id="filterNamePhase">
                                        <span class="fw-600">Phase:</span>
                                        <span>${Phase}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Phase')"></i>
                                    </div>`
                    }
                    if (TaskStatus != "") {

                        strHTML += `  <div class="filterName" id="filterNameTaskStatus">
                                        <span class="fw-600">Status:</span>
                                        <span>${TaskStatus}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'TaskStatus')"></i>
                                    </div>`
                    }
                    if (Priority != "") {

                        strHTML += ` <div class="filterName" id="filterNamePriority">
                                        <span class="fw-600">Priority:</span>
                                        <span>${Priority}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Priority')"></i>
                                    </div>`
                    }
                    
                    if (IsBillable === "1") {

                        strHTML += `<div class="filterName" id="filterNameBillable">
                                        <span class="fw-600">Billable:</span>
                                        <span>Yes</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'BillableY')"></i>
                                    </div>`;
                    }
                    else if (IsBillable === "0") {

                        strHTML += `<div class="filterName" id="filterNameBillable">
                                        <span class="fw-600">Billable:</span>
                                        <span>No</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'BillableN')"></i>
                                    </div>`;
                    }
                    //Added and commented by Vishal Mane on 15/01/2025 to implement Billable dropdown functionality
                    else if (BillableIDList === "1,0") {
                        strHTML += `<div class="filterName" id="filterNameBillable">
                                        <span class="fw-600">Billable:</span>
                                        <span>Yes,No</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'BillableYN')"></i>
                                    </div>`;
                    }
                    //End of Added and commented by Vishal Mane on 15/01/2025 to implement Billable dropdown functionality
                    $("#dvAppliedFilters").html(strHTML);
                    GetTaskData(SessionEmployeeId);
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.success('Filter applied successfully');
                    alertify.success('<%=MyBase.GetResourceString("A_FilterApplied")%>');
                    if (filterflag == 1) {

                    } else {
                        $("#AdvanceFilterIcon").click();
                    }
                    
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error('You can select only 5 projects at a time.');
                    alertify.error('<%=MyBase.GetResourceString("A_SelectFiveProjects")%>');
                }
            }
            
        }

        function ClearFilter(Properties, Val) {
            //debugger
            $("#CopyPrevWeek").off("change");
            $("#CopyPrevWeek").prop("disabled", false);
            $("#CopyPrevWeek").prop("checked", false);
            $("#CopyPrevWeek").on("change");

            $("#filterName" + Val).hide();
            var ProjectList = document.getElementsByName("ProjectList");
            var TaskTypeList = document.getElementsByName("TaskType");
            var TaskCategoriesList = document.getElementsByName("TaskCategory");
            var SubProjectList = document.getElementsByName("SubProject");
            var MilestoneList = document.getElementsByName("Milestone");
            var DeliverableList = document.getElementsByName("Deliverable");
            var PhaseList = document.getElementsByName("Phase");
            var TaskStatusList = document.getElementsByName("TaskStatus");
            var PriorityList = document.getElementsByName("Priorities");
            var BillableList = document.getElementsByName("TaskBillable");
            var ProjFlag = 0;
            if (Val == "Prj") {
                ProjFlag = 1;                
                Array.from(ProjectList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });

                Array.from(TaskTypeList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });

                Array.from(TaskCategoriesList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });

                Array.from(SubProjectList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });

                Array.from(MilestoneList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });

                Array.from(DeliverableList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });

                Array.from(PhaseList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });

                Array.from(TaskStatusList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });

                Array.from(PriorityList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
                Array.from(BillableList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
                $("#filterNameBillable").hide();
                WhereClause = "";
                if (WhereClause != "") {
                    $("#filterSection").show();
                } else {
                    $("#filterSection").hide();
                }
                //Added by Vishal Mane on 18/08/2025 to delete filter entry for that resourec if it is clicked on project tab of applied filter
                var Parameters = {
                    intEmployeeID: SessionEmployeeId,
                }
                var param = JSON.stringify(Parameters);
                var Result = AJAXCallWithResult("/api/TimesheetEntryNew/deleteFilter", param, false);
                GetTSSaveFilter();
                GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                GetTaskData(SessionEmployeeId);
                //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                EnableDisbaleDATextbox();
                //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
                //End of Added by Vishal Mane on 18/08/2025 to delete filter entry for that resourec if it is clicked on project tab of applied filter
            }

            if (Val == "TaskType") {
                Array.from(TaskTypeList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            }

            if (Val == "TaskCategories") {
                Array.from(TaskCategoriesList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            }

            if (Val == "SubProject") {
                Array.from(SubProjectList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            }

            if (Val == "Milestone") {
                Array.from(MilestoneList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            }

            if (Val == "Deliverable") {
                Array.from(DeliverableList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            }

            if (Val == "Phase") {
                Array.from(PhaseList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            }

            if (Val == "TaskStatus") {
                Array.from(TaskStatusList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            }

            if (Val == "Priority") {
                Array.from(PriorityList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            }
            //Added and commented by Vishal Mane on 15/01/2025 to implement Billable dropdown functionality            
            if (Val == "BillableN") {
                Array.from(BillableList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            } else if (Val == "BillableY") {
                Array.from(BillableList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            } else if (Val == "BillableYN") {
                Array.from(BillableList).forEach(function (checkbox) {
                    checkbox.checked = false;
                });
            }
            //End of Added and commented by Vishal Mane on 15/01/2025 to implement Billable dropdown functionality
            if (Val == "BillableN") {
                $("#filterNameBillable").hide();                
            }
            if (Val == "BillableY") {
                $("#filterNameBillable").hide();                
            }
            if (Val == "BillableYN") {
                $("#filterNameBillable").hide();                
            }

            //ApplyTSFilter(FltrFlag, ProjFlag);
            ApplyTSFilter(ProjFlag, 1);

            
        }
        function GetAssignedProjects() {
            //debugger
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //var EmployeeID = '<%= Session("intUserID") %>'.toString();
              var EmployeeID = SessionEmployeeId;
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            var Parameters = {
                intEmployeeID: EmployeeID
            }
            var param = JSON.stringify(Parameters);
            if (GFlag == 0) {
                var Result = AJAXCallWithResult("/api/TimesheetEntryNew/GetAssignedProjects", param, false);
                //console.log(Result);
                var strHtml = "";
                for (var i = 0; i < Result.length; i++) {
                    strHtml += `
                            <div class="row SearchField">
                                <div class="col-sm-1 col-1">
                                    <input type="checkbox" class="form-check checkAll" name='ProjectList' onchange='GetProjectsFilterDataset()' value=${Result[i].ProjectID} id="ProjectFil${Result[i].ProjectID}">
                                </div>
                                <div class="col-sm-10 col-10">
                                    <label for="ProjectFil${Result[i].ProjectID}" class="form-label">${Result[i].ProjectName}</label>
                                </div>
                            </div>
                        `;
                }
                $("#ProjectFilterSec").html(strHtml);
                //Added by Vishal Mane on 21/01/2025 to fix filter issue
                GFlag = 1;
                //End of Added by Vishal Mane on 21/01/2025 to fix filter issue
            }
        }

        function GetProjectsFilterDataset() {
            var ProjectIDList = "";
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //var EmployeeID = '<%= Session("intUserID") %>'.toString();
            var EmployeeID = SessionEmployeeId;
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            var ProjectList = document.getElementsByName("ProjectList");
            for (var i = 0; i < ProjectList.length; i++) {
                if (ProjectList[i].checked == true) {
                    if (ProjectIDList == "") {
                        ProjectIDList += ProjectList[i].value;
                    }
                    else {
                        ProjectIDList += ',' + ProjectList[i].value;
                    }
                }
            }
            var Parameters = {
                intEmployeeID: EmployeeID,
                ProjectIDs: ProjectIDList
            }
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/GetProjectsFilterDataset", param, false);
            //console.log(Result.Table);
            //console.log(Result.Table1);
            //console.log(Result.Table2);
            //console.log(Result.Table3);
            //console.log(Result.Table4);
            //console.log(Result.Table5);
            //console.log(Result.Table6);
            var TaskTypeData = Result.Table;
            var PhaseData = Result.Table1;
            var MileStoneData = Result.Table2;
            var SubProjectData = Result.Table3;
            var DeliverableData = Result.Table4;
            var ModuleData = Result.Table5;
            var PrioritiesData = Result.Table6;
            var TaskCategoryData = Result.Table7;
            var TaskStatusData = Result.Table8;
            //var SOWCategoryData = Result.Table9;
            //var SOWParticularsData = Result.Table10;
            var strHtml = "";
            var strHtml1 = "";
            var strHtml2 = "";
            var strHtml3 = "";
            var strHtml4 = "";
            var strHtml5 = "";
            var strHtml6 = "";
            var strHtml7 = "";
            var strHtml8 = "";
            var strHtml9 = "";
            var strHtml10 = "";
            for (var i = 0; i < TaskTypeData.length; i++) {
                strHtml += `
                            <div class="row SearchField">
                                <div class="col-sm-1 col-1">
                                    <input type="checkbox" class="form-check checkAll" name="TaskType" value=${TaskTypeData[i].TaskTypeID} id="TaskTypeFil${TaskTypeData[i].TaskTypeID}">
                                </div>
                                <div class="col-sm-10 col-10">
                                    <label for="TaskTypeFil${TaskTypeData[i].TaskTypeID}" class="form-label">${TaskTypeData[i].TaskType}</label>
                                </div>
                            </div>
                        `;

            }
            $("#TaskTypeFilterSec").html(strHtml);

            for (var i = 0; i < PhaseData.length; i++) {
                strHtml1 += `
                            <div class="row SearchField">
                                <div class="col-sm-1 col-1">
                                    <input type="checkbox" class="form-check checkAll" name="Phase" value=${PhaseData[i].PhaseID} id="PhaseFil${PhaseData[i].PhaseID}">
                                </div>
                                <div class="col-sm-10 col-10">
                                    <label for="PhaseFil${PhaseData[i].PhaseID}" class="form-label">${PhaseData[i].Phase}</label>
                                </div>
                            </div>
                        `;

            }
            $("#PhaseFilterSec").html(strHtml1);

            for (var i = 0; i < MileStoneData.length; i++) {
                strHtml2 += `
                            <div class="row SearchField">
                                <div class="col-sm-1 col-1">
                                    <input type="checkbox" class="form-check checkAll" name="Milestone" value=${MileStoneData[i].MileStoneId}  id="TaskMilestoneFil${MileStoneData[i].MileStoneId}">
                                </div>
                                <div class="col-sm-10 col-10">
                                    <label for="TaskMilestoneFil${MileStoneData[i].MileStoneId}" class="form-label">${MileStoneData[i].MileStone}</label>
                                </div>
                            </div>
                        `;

            }
            $("#TaskMilestoneFilterSec").html(strHtml2);

            for (var i = 0; i < SubProjectData.length; i++) {
                strHtml3 += `
                            <div class="row SearchField">
                                <div class="col-sm-1 col-1">
                                    <input type="checkbox" class="form-check checkAll" name="SubProject" value=${SubProjectData[i].SubProjectId} id="SubProjectFil${SubProjectData[i].SubProjectId}">
                                </div>
                                <div class="col-sm-10 col-10">
                                    <label for="SubProjectFil${SubProjectData[i].SubProjectId}" class="form-label">${SubProjectData[i].SubProjectName}</label>
                                </div>
                            </div>
                        `;

            }
            $("#SubProjectFilterSec").html(strHtml3);

            for (var i = 0; i < DeliverableData.length; i++) {
                strHtml4 += `
                            <div class="row SearchField">
                                <div class="col-sm-1 col-1">
                                    <input type="checkbox" class="form-check checkAll" name="Deliverable" value=${DeliverableData[i].DeliverableID} id="DeliverableFil${DeliverableData[i].DeliverableID}">
                                </div>
                                <div class="col-sm-10 col-10">
                                    <label for="DeliverableFil${DeliverableData[i].DeliverableID}" class="form-label">${DeliverableData[i].Title}</label>
                                </div>
                            </div>
                        `;

            }
            $("#DeliverableFilterSec").html(strHtml4);

            for (var i = 0; i < PrioritiesData.length; i++) {
                strHtml6 += `
                            <div class="row SearchField">
                                <div class="col-sm-1 col-1">
                                    <input type="checkbox" class="form-check checkAll" name="Priorities" value=${PrioritiesData[i].PriorityID} id="TaskPriorityFil${PrioritiesData[i].PriorityID}">
                                </div>
                                <div class="col-sm-10 col-10">
                                    <label for="TaskPriorityFil${PrioritiesData[i].PriorityID}" class="form-label">${PrioritiesData[i].Priority}</label>
                                </div>
                            </div>
                        `;

            }
            $("#TaskPriorityFilterSec").html(strHtml6);

            for (var i = 0; i < TaskCategoryData.length; i++) {
                strHtml7 += `
                            <div class="row SearchField">
                                <div class="col-sm-1 col-1">
                                    <input type="checkbox" class="form-check checkAll" name="TaskCategory" value=${TaskCategoryData[i].ID} id="TaskCatgryFil${TaskCategoryData[i].ID}">
                                </div>
                                <div class="col-sm-10 col-10">
                                    <label for="TaskCatgryFil${TaskCategoryData[i].ID}" class="form-label">${TaskCategoryData[i].Value}</label>
                                </div>
                            </div>
                        `;

            }
            $("#TaskCatgryFilterSec").html(strHtml7);

            for (var i = 0; i < TaskStatusData.length; i++) {
                strHtml8 += `
                            <div class="row SearchField">
                                <div class="col-sm-1 col-1">
                                    <input type="checkbox" class="form-check checkAll" name="TaskStatus" value=${TaskStatusData[i].StatusID} id="TaskStatusFil${TaskStatusData[i].StatusID}">
                                </div>
                                <div class="col-sm-10 col-10">
                                    <label for="TaskStatusFil${TaskStatusData[i].StatusID}" class="form-label">${TaskStatusData[i].Status}</label>
                                </div>
                            </div>
                        `;

            }
            $("#TaskStatusFilterSec").html(strHtml8);
        }

        function SaveFilter() {
            // var WhereClause = "";
            var ProjectIDList = "";
            var TaskTypeIDList = "";
            var TaskCategoriesIDList = "";
            var SubProjectIDList = "";
            var MilestoneIDList = "";
            var DeliverableIDList = "";
            var PhaseIDList = "";
            var TaskStatusIDList = "";
            var PriorityIDList = "";
            var IsBillable = "";
            var ProjectList = document.getElementsByName("ProjectList");
            var TaskTypeList = document.getElementsByName("TaskType");
            var TaskCategoriesList = document.getElementsByName("TaskCategory");
            var SubProjectList = document.getElementsByName("SubProject");
            var MilestoneList = document.getElementsByName("Milestone");
            var DeliverableList = document.getElementsByName("Deliverable");
            var PhaseList = document.getElementsByName("Phase");
            var TaskStatusList = document.getElementsByName("TaskStatus");
            var PriorityList = document.getElementsByName("Priorities");
            //  
            /********************** Projects ********************/
            for (var i = 0; i < ProjectList.length; i++) {
                if (ProjectList[i].checked == true) {
                    if (ProjectIDList == "") {
                        ProjectIDList += ProjectList[i].value;
                    }
                    else {
                        ProjectIDList += ',' + ProjectList[i].value;
                    }
                }
            }
            if (ProjectIDList.length == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select atleast one Project.');
            }
            else if (ProjectIDList.split(',').length <= 5) {
                /********************** Task Type ********************/
                for (var i = 0; i < TaskTypeList.length; i++) {

                    if (TaskTypeList[i].checked == true) {
                        if (TaskTypeIDList == "") {
                            TaskTypeIDList += TaskTypeList[i].value;
                        }
                        else {
                            TaskTypeIDList += ',' + TaskTypeList[i].value;
                        }

                    }
                }
                /********************** Task Categories ********************/
                for (var i = 0; i < TaskCategoriesList.length; i++) {

                    if (TaskCategoriesList[i].checked == true) {
                        if (TaskCategoriesIDList == "") {
                            TaskCategoriesIDList += TaskCategoriesList[i].value;
                        }
                        else {
                            TaskCategoriesIDList += ',' + TaskCategoriesList[i].value;
                        }

                    }
                }
                /********************** Sub Project ********************/
                for (var i = 0; i < SubProjectList.length; i++) {

                    if (SubProjectList[i].checked == true) {
                        if (SubProjectIDList == "") {
                            SubProjectIDList += SubProjectList[i].value;
                        }
                        else {
                            SubProjectIDList += ',' + SubProjectList[i].value;
                        }

                    }
                }
                /********************** Milestone ********************/
                for (var i = 0; i < MilestoneList.length; i++) {

                    if (MilestoneList[i].checked == true) {
                        if (MilestoneIDList == "") {
                            MilestoneIDList += MilestoneList[i].value;
                        }
                        else {
                            MilestoneIDList += ',' + MilestoneList[i].value;
                        }

                    }
                }
                /********************** Deliverable ********************/
                for (var i = 0; i < DeliverableList.length; i++) {

                    if (DeliverableList[i].checked == true) {
                        if (DeliverableIDList == "") {
                            DeliverableIDList += DeliverableList[i].value;
                        }
                        else {
                            DeliverableIDList += ',' + DeliverableList[i].value;
                        }

                    }
                }
                /********************** Phase ********************/
                for (var i = 0; i < PhaseList.length; i++) {

                    if (PhaseList[i].checked == true) {
                        if (PhaseIDList == "") {
                            PhaseIDList += PhaseList[i].value;
                        }
                        else {
                            PhaseIDList += ',' + PhaseList[i].value;
                        }

                    }
                }
                /********************** Task Status ********************/
                for (var i = 0; i < TaskStatusList.length; i++) {

                    if (TaskStatusList[i].checked == true) {
                        if (TaskStatusIDList == "") {
                            TaskStatusIDList += TaskStatusList[i].value;
                        }
                        else {
                            TaskStatusIDList += ',' + TaskStatusList[i].value;
                        }

                    }
                }
                /********************** Priority ********************/
                for (var i = 0; i < PriorityList.length; i++) {

                    if (PriorityList[i].checked == true) {
                        if (PriorityIDList == "") {
                            PriorityIDList += PriorityList[i].value;
                        }
                        else {
                            PriorityIDList += ',' + PriorityList[i].value;
                        }

                    }
                }
                //Added and commented by Vishal Mane on 15/01/2025 to implement Billable dropdown functionality
                var BillableList = document.getElementsByName("TaskBillable");
                var BillableIDList = "";
                for (var i = 0; i < BillableList.length; i++) {
                    if (BillableList[i].checked == true) {
                        if (BillableIDList == "") {
                            BillableIDList += BillableList[i].value;
                        }
                        else {
                            BillableIDList += ',' + BillableList[i].value;
                        }
                    }
                }
                IsBillable = BillableIDList;
                //End of Added and commented by Vishal Mane on 15/01/2025 to implement Billable dropdown functionality
                var FilterClause = {
                    strFilterProjectList: ProjectIDList,
                    strFilterTaskTypeList: TaskTypeIDList,
                    strFilterTaskCategories: TaskCategoriesIDList,
                    strFilterSubProjectList: SubProjectIDList,
                    strFilterMilestoneList: MilestoneIDList,
                    strFilterDeliverableList: DeliverableIDList,
                    strFilterPhaseList: PhaseIDList,
                    strFilterTaskStatus: TaskStatusIDList,
                    strFilterPriorityList: PriorityIDList,
                    strFilterBillable: IsBillable
                }
                var Parameters = {
                    //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                    //intEmployeeID: intUserID,
                      intEmployeeID: SessionEmployeeId,
                    //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                    CreatedBy: strUserName,
                    WhereClause: JSON.stringify(FilterClause)
                }
                var param = JSON.stringify(Parameters);
                var Result = AJAXCallWithResult("/api/TimesheetEntryNew/SaveFilter", param, false);
                if (Result != "") {
                    if (Result[0].strResult == "Inserted") {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.success('Filter saved successfully');
                        alertify.success('<%=MyBase.GetResourceString("A_FilterSaved")%>');
                        $("#AdvanceFilterIcon").click();
                    }
                    else if (Result[0].strResult == "Updated") {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.success('Filter updated successfully');
                        alertify.success('<%=MyBase.GetResourceString("A_FilterUpdated")%>');
                        $("#AdvanceFilterIcon").click();
                    }
                    var filterValues;
                    filterValues = jQuery.parseJSON(Result[0].FilterValues);
                    filterValues = isJson(filterValues) ? JSON.parse(filterValues) : filterValues
                    // console.log(filterValues, 'Riddhesh');

                    ProjectList = filterValues.strFilterProjectList.split(',');
                    TaskTypeList = filterValues.strFilterTaskTypeList.split(',');
                    TaskCategoriesList = filterValues.strFilterTaskCategories.split(',');
                    SubProjectList = filterValues.strFilterSubProjectList.split(',');
                    MilestoneList = filterValues.strFilterMilestoneList.split(',');
                    DeliverableList = filterValues.strFilterDeliverableList.split(',');
                    PhaseList = filterValues.strFilterPhaseList.split(',');
                    TaskStatusList = filterValues.strFilterTaskStatus.split(',');
                    PriorityList = filterValues.strFilterPriorityList.split(',');
                    IsBillable = filterValues.strFilterBillable;
                    var ProjectNames = [];
                    var TaskType = [];
                    var TaskCategories = [];
                    var SubProject = [];
                    var Milestone = [];
                    var Phase = [];
                    var Deliverable = [];
                    var TaskStatus = [];
                    var Priority = [];
                    if (IsBillable == 1) {
                        $("#chkBillable").prop("checked", true);
                    }
                    else {
                        $("#chkBillable").prop("checked", false);
                    }
                    /********************** Projects ********************/
                    for (var i = 0; i < ProjectList.length; i++) {
                        $("#ProjectFil" + ProjectList[i]).prop("checked", true)
                        //ProjectNames = $('label[for="ProjectFil' + ProjectList[i] + '"]').text();
                    }
                    var selector = ProjectList.map(id => `label[for="ProjectFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        ProjectNames.push($(this).html());
                    });
                    ProjectNames = ProjectNames.join(',');

                    for (var i = 0; i < TaskTypeList.length; i++) {
                        $("#TaskTypeFil" + TaskTypeList[i]).prop("checked", true)
                    }
                    var selector = TaskTypeList.map(id => `label[for="TaskTypeFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        TaskType.push($(this).html());
                    });
                    TaskType = TaskType.join(',');

                    for (var i = 0; i < TaskCategoriesList.length; i++) {
                        $("#TaskCatgryFil" + TaskCategoriesList[i]).prop("checked", true)
                    }
                    var selector = TaskCategoriesList.map(id => `label[for="TaskCatgryFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        TaskCategories.push($(this).html());
                    });
                    TaskCategories = TaskCategories.join(',');

                    for (var i = 0; i < SubProjectList.length; i++) {
                        $("#SubProjectFil" + SubProjectList[i]).prop("checked", true)
                    }
                    var selector = SubProjectList.map(id => `label[for="SubProjectFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        SubProject.push($(this).html());
                    });
                    SubProject = SubProject.join(',');

                    for (var i = 0; i < MilestoneList.length; i++) {
                        $("#TaskMilestoneFil" + MilestoneList[i]).prop("checked", true)
                    }
                    var selector = MilestoneList.map(id => `label[for="TaskMilestoneFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        Milestone.push($(this).html());
                    });
                    Milestone = Milestone.join(',');

                    for (var i = 0; i < DeliverableList.length; i++) {
                        $("#DeliverableFil" + DeliverableList[i]).prop("checked", true)
                    }
                    var selector = DeliverableList.map(id => `label[for="DeliverableFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        Deliverable.push($(this).html());
                    });
                    Deliverable = Deliverable.join(',');

                    for (var i = 0; i < PhaseList.length; i++) {
                        $("#PhaseFil" + PhaseList[i]).prop("checked", true)
                    }
                    var selector = PhaseList.map(id => `label[for="PhaseFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        Phase.push($(this).html());
                    });
                    Phase = Phase.join(',');

                    for (var i = 0; i < TaskStatusList.length; i++) {
                        $("#TaskStatusFil" + TaskStatusList[i]).prop("checked", true)
                    }
                    var selector = TaskStatusList.map(id => `label[for="TaskStatusFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        TaskStatus.push($(this).html());
                    });
                    TaskStatus = TaskStatus.join(',');

                    for (var i = 0; i < PriorityList.length; i++) {
                        $("#TaskPriorityFil" + PriorityList[i]).prop("checked", true)
                    }
                    var selector = PriorityList.map(id => `label[for="TaskPriorityFil${id}"]`).join(',');
                    var labels = $(selector);
                    labels.each(function () {
                        Priority.push($(this).html());
                    });
                    Priority = Priority.join(',');
                    var strHTML = "";
                    if (ProjectNames != "") {
                        strHTML += `<div  class="filterName" id="filterNamePrj">
                                        <span class="fw-500">Project:</span>
                                        <span>${ProjectNames}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Prj')"></i>
                                    </div>`
                    }

                    if (TaskType != "") {

                        strHTML += `<div class="filterName" id="filterNameTaskType">
                                        <span class="fw-500">Task Type:</span>
                                        <span>${TaskType}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'TaskType')"></i>
                                    </div>`
                    }
                    if (TaskCategories != "") {

                        strHTML += ` <div class="filterName" id="filterNameTaskCategories">
                                        <span class="fw-500">Task Category:</span>
                                        <span>${TaskCategories}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'TaskCategories')"></i>
                                    </div>`
                    }
                    if (SubProject != "") {

                        strHTML += ` <div class="filterName">
                                        <span class="fw-500">Sub Project:</span>
                                        <span>${SubProject}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'SubProject')"></i>
                                    </div>`
                    }
                    if (Milestone != "") {

                        strHTML += ` <div class="filterName" id="filterNameMilestone">
                                        <span class="fw-500">Milestone:</span>
                                        <span>${Milestone}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Milestone')"></i>
                                    </div>`
                    }
                    if (Deliverable != "") {

                        strHTML += ` <div class="filterName" id="filterNameDeliverable">
                                        <span class="fw-500">Deliverable:</span>
                                        <span>${Deliverable}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Deliverable')"></i>
                                  </div>`
                    }
                    if (Phase != "") {

                        strHTML += ` <div class="filterName" id="filterNamePhase">
                                        <span class="fw-500">Phase:</span>
                                        <span>${Phase}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Phase')"></i>
                                    </div>`
                    }
                    if (TaskStatus != "") {

                        strHTML += `  <div class="filterName" id="filterNameTaskStatus">
                                        <span class="fw-500">Status:</span>
                                        <span>${TaskStatus}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'TaskStatus')"></i>
                                    </div>`
                    }
                    if (Priority != "") {

                        strHTML += ` <div class="filterName" id="filterNamePriority">
                                        <span class="fw-500">Priority:</span>
                                        <span>${Priority}</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'Priority')"></i>
                                    </div>`
                    }
                    if (IsBillable === "1") {

                        strHTML += `<div class="filterName" id="filterNameBillable">
                                        <span class="fw-500">Billable:</span>
                                        <span>Yes</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'BillableY')"></i>
                                    </div>`;
                    }
                    else if (IsBillable === "0") {

                        strHTML += `<div class="filterName" id="filterNameBillable">
                                        <span class="fw-500">Billable:</span>
                                        <span>No</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'BillableN')"></i>
                                    </div>`;
                    }
                    else if (IsBillable === "1,0") {

                        strHTML += `<div class="filterName" id="filterNameBillable">
                                        <span class="fw-500">Billable:</span>
                                        <span>Yes,No</span>
                                        <i class="fas fa-times crossIcn greyIcn ms-3" onclick="ClearFilter(this,'BillableYN')"></i>
                                    </div>`;
                    }
                    $("#dvAppliedFilters").html(strHTML);
                }
                WhereClause = Result[0].FilterValues;
                GetTaskData(SessionEmployeeId);
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error('You can select only 5 projects at a time.');
                alertify.error('<%=MyBase.GetResourceString("A_SelectFiveProjects")%>');
            }
            if (WhereClause != "") {
                $("#filterSection").show();
            } else {
                $("#filterSection").hide();
            }
        }
        //AjaxCall Function start here 
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }

        //Added By Dipali V On 21st Aug 2026 for SaveDescription Params omits Description (ValidateHeaders)
        function AJAXCallWithResultSaveDescription(url, param, async) {
            var headerParam = "{}";
            try {
                var obj = (typeof param === "string") ? JSON.parse(param) : param;
                // Params header must match body fields for ValidateHeaders, but Description is omitted
                // (apostrophe / long text in Params causes ValidateHeaders decrypt failure)
                var headerObj = {
                    DailyActivityEntryID: obj.DailyActivityEntryID,
                    TaskID: obj.TaskID,
                    ProjectID: obj.ProjectID,
                    EmployeeID: obj.EmployeeID,
                    Duration: obj.Duration,
                    ProxyResourceID: (obj.ProxyResourceID != null ? obj.ProxyResourceID : 0)
                };
                headerParam = JSON.stringify(headerObj);
            } catch (e) {
                headerParam = "{}";
            }
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    xhr.setRequestHeader("Params", encryptString(headerParam));
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }
        //End of Added By Dipali V On 21st Aug 2026 for SaveDescription Params omits Description (ValidateHeaders)

        function AJAXCallWithResultSaveDA(url, param, async) {
            $.ajax({
                url: strUrl + url,
                type: "POST",
                data: { '': param },
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    //console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }
        

        //Added by Ajit L on 27/11/2024
        var chkISVALID = 0;
        var CTinvalidData = "";
        var actionOnDuration = false;
        var intMaxEntry = 24;
        var MinDAENtryDisplay = "";
        var MinDAEntry = <%=CommonFunctions.Application.MinHoursForDAEntry%>;
        var GlobalRestrictByMinHours = 0;
        //GlobalRestrictByMinHours = 1 //Added by ajit & has to remove when it get run time value
        var GlobalHoursFlag = 1;
        if (GlobalHoursFlag == 1) {
            if (MinDAEntry == 0.25) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:15"
            }
            else if (MinDAEntry == 0.50) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:30"
            }
            else if (MinDAEntry == 0.75) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:45"
            }
        }
        else {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = MinDAEntry
        }
        //Added by Ajit L on 28/11/2024
        function isNumber(evt, val, obj) {
            //debugger
            var Isvalid = 0;
            var legth = val.length;
            var objVal = obj.value;
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 58)) {
                Isvalid = 1;
                return false;
            }
            if (charCode == 58 && legth == 2) {                
                return true;
            } else if (legth == 2) {
                obj.value = objVal + ":";
            } else if (Isvalid == 0) {
                if (charCode == 58) {
                    return false;
                } else {
                    return true;
                }                
            } else {
                return false;
            }            
            return true;
        }

        //Ajit by Ajit L on 28/11/2024 for restricting key press input in datefield
        function restrictNumericFilters(e) {
            var key = e.key;
            if ((key >= '0' && key <= '9') || key == 'Backspace' || key == 'Delete' || key == 'ArrowLeft' || key == 'ArrowRight' || key == 'ArrowUp' || key == 'ArrowDown') {
                return false;
            } else {
                return true;
            }
        }

        //Added by Ajit L on 27/11/2024 for Special Char check
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
            if (isSpecialCharacter == 1) {
                return true;
            }
            else {
                return false;
            }
        }

        //Added by Ajit L on 27/11/2024
        function RestrictNonNumeric(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }

            var dofocus = (arguments.length > 1) ? arguments[1] : true;
            if (!isNumeric(getInputValue(obj))) {
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }
        // Added by Ajit L on 26/11/2024
        function BindPlaceholder() {
            $("#SelectDateInput").val('');
            var strHTML = "<option  selected  value=''>Select Project</option>";
            $("#SelectProjectName").html(strHTML);

            var strhtml = "<option  selected  value=''>Select Task Type</option>";
            $("#SelectTaskType").html(strhtml);

            var STRHTML = "<option  selected  value=''>Select Sub Task Type</option>";
            $("#SelectSubTaskType").html(STRHTML);

            BindPriority();

            $(".selectpicker").selectpicker('refresh');
        }

        // Added by Ajit L on 26/11/2024
        $("#SelectDateInput").on("change", function () {
            var SelectedDate = $("#SelectDateInput").val().trim();
            var UserID = SessionEmployeeId;
            var Parameter = {
                CTselectdate: SelectedDate,
                intEmployeeID: UserID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/BindProject", param, false);
            var strHTML = "<option  selected  value=''>Select Project</option>";
            for (var i = 0; i < Result.length; i++) {
                var ListComponent = Result[i];
                strHTML += "<option title='" + ListComponent.ProjectName + "' value='" + ListComponent.ProjectID + "'>" + ListComponent.ProjectName + "</option>";
            }
            $("#SelectProjectName").html(strHTML);
            $(".selectpicker").selectpicker('refresh');
        });


        // Added by Ajit L on 26/11/2024
        $("#SelectProjectName").on("change", function () {
            var ProjectID = $("#SelectProjectName").val();
            var Parameter = {
                ProjectID: ProjectID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/BindTaskType", param, false);

            var strhtml = "<option  selected  value=''>Select Task Type</option>";
            for (var i = 0; i < Result.length; i++) {
                var ListComponent = Result[i];
                strhtml += "<option title='" + ListComponent.TaskType + "' value='" + ListComponent.TaskTypeID + "'>" + ListComponent.TaskType + "</option>";
            }
            $("#SelectTaskType").html(strhtml);
            $(".selectpicker").selectpicker('refresh');
        });


        // Added by Ajit L on 26/11/2024
        $("#SelectTaskType").on("change", function () {
            var ProjectID = $("#SelectProjectName").val();
            var TaskTypeID = $("#SelectTaskType").val();
            var Parameter = {
                ProjectID: ProjectID,
                FilterTaskTypeID: TaskTypeID
            }
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/BindSubTaskType", param, false);

            var STRHTML = "<option  selected  value=''>Select Sub Task Type</option>";
            for (var i = 0; i < Result.length; i++) {
                var ListComponent = Result[i];
                STRHTML += "<option title='" + ListComponent.SubTaskType + "' value='" + ListComponent.SubTaskTypeID + "'>" + ListComponent.SubTaskType + "</option>";
            }
            $("#SelectSubTaskType").html(STRHTML);
            $(".selectpicker").selectpicker('refresh');
        });

        // Added by Ajit L on 26/11/2024
        function BindPriority() {
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/BindPriority", '', false);
            var STRHTML = "";
            for (var i = 0; i < Result.length; i++) {
                var ListComponent = Result[i];
                STRHTML += "<option title='" + ListComponent.Priority + "' value='" + ListComponent.PriorityID + "'>" + ListComponent.Priority + "</option>";
            }
            $("#SelectPriority").html(STRHTML);
            $(".selectpicker").selectpicker('refresh');
        }

        // Added by Ajit L on 27/11/2024
        var CreateTaskFlag = "";
        var MenuTags = "";
        function CreateTask_Save_OnClick(flag) {
            //debugger
            var chkFlag = "";
            chkFlag = ValidateCreateTask();
            if (chkFlag != false) {
                CreateTaskFlag = flag;
                ValidateLeaveFn();
                if (chkISVALID == 1) {
                    $("#ConfirmMessageModalLeave").modal('show');
                    if (CTinvalidData == 'Confirm') {
                        $("#ConfirmMessageModalLeaveDate").html("<%=MyBase.GetResourceString("A_Empleave")%>");
                    }
                    else if (CTinvalidData == 'OULESS') {
                        $("#ConfirmMessageModalLeaveDate").html("<%=MyBase.GetResourceString("A_OUHrLess")%>");
                    }
                }
                else if (chkISVALID == 0) {
                    // $('#ViewSaveTS_Btn').css("display", "none");
                    // $("#SaveCreateNewTS_Btn").css("display", "none");
                    SaveCreateTask(CreateTaskFlag);
                }
            }
        }

        // Added by Ajit L on 27/11/2024
        function ValidateCreateTask() {
            //debugger
            var objProject = $("#SelectProjectName")[0];
            var objtxtTaskName = $("#TaskInput")[0];
            var objTaskType = $("#SelectTaskType")[0];
            //var objSubTaskType = $("#SelectSubTaskType")[0];
            var objPriority = $("#SelectPriority")[0];
            var objtxtWorkHrs = $("#ActualTimeInput")[0];
            var objtxtActualComplete = $("#ActualComplete")[0];
            var objtxtDescription = $("#Desc_Input")[0];
            var objCTselectdate = $("#SelectDateInput")[0];
            var isValidCreateTask = 0;
            if (objCTselectdate != null) {
                if (objCTselectdate.value == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_SelDate")%>');
                    $("#SelectDateInput").focus();
                    return false;
                }
            }
            //Project Validation
            if (objProject != null) {
                if (objProject.value == "" || objProject.value == "0") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_SelProject")%>');
                    objProject.focus();
                    return false;
                }
            }

            if (objtxtTaskName != null) {
                if (objtxtTaskName.value.trim() == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_TaskBlank")%>');
                    objtxtTaskName.value = "";
                    objtxtTaskName.focus();
                    return false;
                }
            }
            if (objtxtTaskName != null) {
                if (checkSpecialCharacter(objtxtTaskName.value, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Task Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#TaskInput").focus();

                    return false;
                }
            }

            if (objTaskType != null) {
                if (objTaskType.value == "" || objTaskType.value == "0") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_TaskTypeBlank")%>');
                    objTaskType.focus();
                    return false;
                }
            }

            if (objPriority != null) {
                if (objPriority.value == "" || objPriority.value == "0") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_PriorityBlank")%>');
                    objPriority.focus();
                    return false;
                }
            }

            if (objtxtWorkHrs != null) {
                if (objtxtWorkHrs.value == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_ActTimeBlank")%>');
                    objtxtWorkHrs.focus();
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }
            }

            if (objtxtDescription != null) {

                if (checkSpecialCharacter(objtxtDescription.value, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#Desc_Input").focus();
                    return false;
                }
            }

            objtxtWorkHrs.value = objtxtWorkHrs.value.replace(/:/g, ".");
            var precision = objtxtWorkHrs.value.split(".")[1];
            if (precision > 60) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_twodeci")%>');
                objtxtWorkHrs.focus();
                Isvalid = 1;
                objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                return false;
            }
            if (precision == 60) {
                objtxtWorkHrs.value = (objtxtWorkHrs.value.split(".")[0] - 0) + 1;
            }
            if (objtxtWorkHrs != null) {
                if ((objtxtWorkHrs.value - 0) == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Timezero")%>');
                    objtxtWorkHrs.focus();
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }
            }

            if (objtxtActualComplete != null) {
                if (RestrictNonNumeric(objtxtActualComplete) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_PositiveNum")%>');
                    objtxtActualComplete.focus();
                    return false;
                }
                if ((objtxtActualComplete.value - 0) >= 0 && (objtxtActualComplete.value - 0) <= 100) {
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Actpercomp")%>');
                    objtxtActualComplete.focus();
                    return false;
                }
            }

            if (objtxtWorkHrs != null) {
                if (RestrictNonNumeric(objtxtWorkHrs) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_PositiveNum")%>');
                    objtxtWorkHrs.focus();

                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }
                if ((objtxtWorkHrs.value - 0) >= 0 && (objtxtWorkHrs.value - 0) <= 24) {
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_Morehours")%>');
                    objtxtWorkHrs.focus();

                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }

                if (GlobalRestrictByMinHours != null) {
                    if (GlobalRestrictByMinHours == 1) {
                        if (GlobalHoursFlag == 1) {
                            var minutes = objtxtWorkHrs.value.split('.');
                            var p = minutes[0];
                            var dec = minutes[1];
                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);
                        }
                        else {
                            var d = objtxtWorkHrs.value;
                        }
                        if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Please specify the work (hours) in multiples of ' + MinDAENtryDisplay + ' hours.\nThis is necessary because the user can only fill a minimum of ' + MinDAENtryDisplay + ' hours in the timesheet.');
                            objtxtWorkHrs.focus();
                            objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                            return false;
                        }
                    }
                }

                var taskParameters = {
                    dtFromDate: objCTselectdate.value,
                    ProjectID: objProject.value,
                    intEmployeeID: SessionEmployeeId
                }
                var param = JSON.stringify(taskParameters);
                var Result = AJAXCallWithResult("/api/TimesheetEntryNew/ValidateCreateTask", param, false);
                if (Result != "") {
                    if (Result == "Confirm") {

                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('' + Result + '');
                        isValidCreateTask = 1;
                        return false;
                    }
                }
                var taskParameters = {
                    ProjectID: encodeURI(objProject.value),
                    intEmployeeID: encodeURI(SessionEmployeeId),
                    Duration: encodeURI(objtxtWorkHrs.value),
                    TaskName: encodeURIComponent(objtxtTaskName.value.replace(/'/g, "''")),
                    CTselectdate: encodeURI(objCTselectdate.value),                    
                }
                var param = JSON.stringify(taskParameters);
                var Result = AJAXCallWithResult("/api/TimesheetEntryNew/ValidateCreateTask_Work", param, false);
                if (Result != "") {
                    if (Result.indexOf('$$') >= 0) {
                        var arrValue = Result.split('$$');
                        if (arrValue[0] == "1") {
                            $("#ConfirmMessageModalCreateTask").modal('show');
                            $("#ConfirmationMsgCreateTask").html(arrValue[1]);
                            isValidCreateTask = 1;
                        }
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('' + Result + '');
                        isValidCreateTask = 1;
                        return false;
                    }
                }
                if (isValidCreateTask == 1) {
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                    return false;
                }
                else {
                    objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
                }
            }
            objtxtWorkHrs.value = objtxtWorkHrs.value.replace(".", ":");
        }

        // Added by Ajit L on 27/11/2024
        function ValidateLeaveFn() {
            var objProject = $("#SelectProjectName")[0];
            var objCTselectdate = $("#SelectDateInput")[0];
            var objtxtWorkHrs = $("#ActualTimeInput")[0];
            var d = 0;
            objtxtWorkHrs.value = objtxtWorkHrs.value.replace(/:/g, ".");
            if (GlobalRestrictByMinHours != null) {
                if (GlobalRestrictByMinHours == 1) {
                    if (GlobalHoursFlag == 1) {
                        var minutes = objtxtWorkHrs.value.split('.');
                        var p = minutes[0];
                        var dec = minutes[1];
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);
                    }
                    else {
                        d = objtxtWorkHrs.value;
                    }
                }
            }
            var taskParameters = {
                dtFromDate: objCTselectdate.value,
                ProjectID: objProject.value,
                intEmployeeID: SessionEmployeeId,
                Duration: d
            }
            var param = JSON.stringify(taskParameters);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/ValidateCreateTask", param, false);
            if (Result != "") {
                if (Result == "Confirm" || Result == 'OULESS') {
                    chkISVALID = 1;
                    CTinvalidData = Result;
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('' + Result + '');
                }
                return false;
            }
            else {
                chkISVALID = 0;
            }
        }

        // Added by Ajit L on 27/11/2024
        function ConfirmLeaveForCreateTask(flag) {
            if (flag == 1) {
                SaveCreateTask(CreateTaskFlag);
            }
        }

        // Added by Ajit L on 27/11/2024
        function SaveCreateTask(flag) {
            //debugger
            var objProject = $("#SelectProjectName")[0];
            var objtxtTaskName = $("#TaskInput")[0];
            var objTaskType = $("#SelectTaskType")[0];
            //var objSubTaskType = $("#SelectSubTaskType")[0];
            var objPriority = $("#SelectPriority")[0];
            var objtxtWorkHrs = $("#ActualTimeInput")[0];
            var objtxtActualComplete = $("#ActualComplete")[0];
            var objtxtDescription = $("#Desc_Input")[0];
            var objCTselectdate = $("#SelectDateInput")[0];
            var ActualPercentage = 0;
            if (objtxtActualComplete.value == "") {
                ActualPercentage = 0;
            }
            else {
                ActualPercentage = objtxtActualComplete.value;
            }
            var taskParameters = {
                intEmployeeID: SessionEmployeeId,
                ProjectID: objProject.value,
                TaskName: objtxtTaskName.value.replace(/'/g, "''"),
                Duration: objtxtWorkHrs.value.replace(/:/g, "."),
                FilterTaskTypeID: objTaskType.value,
                //SubTasktypeID: objSubTaskType.value,
                CreatedBy: UserName,
                dtFromDate: objCTselectdate.value,
                PriorityID: objPriority.value,
                ActualPercentComplete: ActualPercentage,
                Description: objtxtDescription.value.replace(/'/g, "''"),
                bitFlag: flag
            }
            var param = JSON.stringify(taskParameters);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/SaveCreateTask", param, false);
            if (Result != '') {
                if (flag == 1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_TaskCreated")%>');
                    //GetTaskData(SessionEmployeeId);
                    //var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('CreateTaskOffcanvas'));
                    //myOffcanvas.hide();
                    $("#btcClose").click();
                    GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                    GetTaskData(SessionEmployeeId);
                    var thisElement = $('[data-bs-target=".superTab' + objProject.value + '"]');
                    PlotTaskDetails(objProject.value, SessionEmployeeId, thisElement);
                    $(`.superTab${objProject.value}`).collapse('show');
                    //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                    EnableDisbaleDATextbox();
                    //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature

                }
                else if (flag == 2) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('<%=MyBase.GetResourceString("A_TaskCreated")%>');
                    TaskIDList = Result;
                    IsDefault = 1;
                    GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                    GetTaskData(SessionEmployeeId);
                    var thisElement = $('[data-bs-target=".superTab' + objProject.value + '"]');
                    PlotTaskDetails(objProject.value, SessionEmployeeId, thisElement);
                    $(`.superTab${objProject.value}`).collapse('show');
                    //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                    EnableDisbaleDATextbox();
                    //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature

                    objCTselectdate.value = "";
                    objProject.value = "";
                    objtxtTaskName.value = "";
                    objTaskType.vale = "";
                    //objSubTaskType.value = "";
                    objPriority.value = "";
                    objtxtWorkHrs.value = "";
                    objtxtActualComplete.value = "";
                    objtxtDescription.value = "";
                    clearCreateTaskData();
                }
            }
        }
        // Added by Ajit L on 27/11/2024
        function clearCreateTaskData() {
            $("#SelectDateInput").val("");
            $("#TaskInput").val("");
            $("#ActualComplete").val("");
            $("#Desc_Input").val("");
            $('#ActualTimeInput').val("");
            // $("#ViewSaveTS_Btn,#SaveCreateNewTS_Btn").css("display", "inline-block");
            BindPlaceholder();
        }

        // Added by Ajit L on 27/11/2024
        function SendConfirmationResponseForCreateTask(response) {
            var objCreateTaskWorkHrs = $('#txtWorkHrs')[0];
            if (response == 0) {
                objCreateTaskWorkHrs.value = "";
            }
        }

        //Added by Ajit L on 06/12/2024
        var ProjectList = "";
        var TaskList = "";
        function searchProjTblInput() {
            var SearchedValue = $("#searchProjTblFilter").val().toLowerCase();
            // Filter Project List
            var FilterPrjList = ProjectList.filter(function (x) {
                return x.ProjectName.toLowerCase().indexOf(SearchedValue)
                    //|| x.TaskName.toLowerCase().indexOf(SearchedValue)
                    !== -1;
            });
            ReloadProjectList(FilterPrjList);
        }
        //Added by Ajit L on 06/12/2024
        function ReloadProjectList(ProjectList) {
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //var EmployeeID = '<%= Session("intUserID") %>'.toString();
            var EmployeeID = SessionEmployeeId;
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            var strHTML = "";
            var Result = ProjectList;
            $("#TimesheetInfoTbl_Body").html("");
            if (Result != null && Result.length > 0) {
                for (var i = 0; i < Result.length; i++) {
                    strHTML += '<tr class="projectRow parentRow"><td class="py-0"><h2 class="accordion-header">';
                    strHTML += '<button class="accordion-button NestedAccBtn collapsed" type="button" data-bs-toggle="collapse" data-bs-target=".superTab' + Result[i]["ProjectID"] + '" aria-expanded="true" onclick="PlotTaskDetails(' + Result[i]["ProjectID"] + ', ' + EmployeeID + ', this);">';
                    strHTML += '<img src="../../../Whizible2.0-new/dist/img/Projects_icon_blue.svg" class="me-2" alt="Project Icon">';
                    strHTML += '<span class="flex-grow-1 projTitle">' + Result[i]["ProjectName"] + '</span><i class="fas fa-chevron-down ms-auto"></i></button></h2></td>';
                    strHTML += '<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>';
                }
            }
            $("#TimesheetInfoTbl_Body").html(strHTML);
            if (Result.length > 2) {
                $("#loadMoreBtn").show();
                itemsToShowInitially = 3;
                itemsToShow = 3;
                visibleItems = itemsToShowInitially;
                $('#TimesheetInfoTbl tbody tr.parentRow').hide();
                $('#TimesheetInfoTbl tbody tr.parentRow:lt(' + visibleItems + ')').show();
                if ($('#TimesheetInfoTbl tbody tr.parentRow:visible').length <= 3) {
                    $('#loadLessBtn').hide();
                }
                else {
                    $('#loadLessBtn').show();
                }
                if (Result.length <= 3) {
                    $("#loadMoreBtn").hide();
                    $('#loadLessBtn').hide();
                }
            } else {
                $("#loadMoreBtn").hide();
                $('#loadLessBtn').hide();
            }
        }


        function showProjectTaskInfo(element, taskId) {
            //debugger
            var UserID = SessionEmployeeId
            var taskParameters = {
                intEmployeeID: UserID,
                TaskID: taskId
            }
            var param = JSON.stringify(taskParameters);
            var Result = AJAXCallWithResult("/api/TimesheetEntryNew/GetTaskDetails", param, false);
            console.log(Result);
            if (Result != null && Result != undefined) {
                var task = Result[0];
                let taskHTML = `
                    <div class='projecttaskinfo_tooltipbox'>
                        <div class='PTItooltipbox_hading'>
                            ${task.ProjectName}<br>
                            <span class='PTItooltipbox_hading'>${task.TaskName}</span>
                        </div>
                `;
                // Add Task Notes if it exists
                if (task.TaskNotes) {
                    taskHTML += `
                        <p class="taskdescription p-0 mb-3">${task.TaskNotes}</p>
                    `;
                }
                taskHTML +=                         
                        `<div class='projecttaskinfo_tooltipbox_schedule'>
                            <div class='row'>
                                <div class='col-sm-4'>Start Date:</div>
                                <div class='col-sm-8'>${task.StartDate ? task.StartDate : ''}</div>
                            </div>
                            <div class='row'>
                                <div class='col-sm-4'>End Date:</div>
                                <div class='col-sm-8'>${task.EndDate ? task.EndDate : ''}</div>
                            </div>
                            <div class='row'>
                                <div class='col-sm-4'>Allocated Work:</div>
                                <div class='col-sm-8'>${task.Work}</div>
                            </div>
                            <div class='row'>
                                <div class='col-sm-4'>Actual Work:</div>
                                <div class='col-sm-8'>${formatTime(task.ActualWork)}</div>
                            </div>
                        </div>
                        <hr>
                        <div class='projecttaskinfo_tooltipbox_schedule'>
                `;

                // Add conditional blocks
                if (task.Phase) {
                    taskHTML += `
                                    <div class='row'>
                                        <div class='col-sm-4'>Phase:</div>
                                        <div class='col-sm-8 wordBreak'>
                                            <span class='issuetext' title='${task.Phase}' data-bs-toggle='tooltip' data-bs-placement='top'>${task.Phase}</span>
                                        </div>
                                    </div>
                                `;
                }

                if (task.Milestone) {
                    taskHTML += `
                                <div class='row'>
                                    <div class='col-sm-4'>Milestone:</div>
                                    <div class='col-sm-8 wordBreak'>
                                        <span class='issuetext' title='${task.Milestone}' data-bs-toggle='tooltip' data-bs-placement='top'>${task.Milestone}</span>
                                    </div>
                                </div>
                            `;
                }

                if (task.SubProject) {
                    taskHTML += `
                                <div class='row'>
                                    <div class='col-sm-4'>Sub Project:</div>
                                    <div class='col-sm-8 wordBreak'>
                                        <span class='issuetext' title='${task.SubProject}' data-bs-toggle='tooltip' data-bs-placement='top'>${task.SubProject}</span>
                                    </div>
                                </div>
                            `;
                }

                if (task.Title) {
                    taskHTML += `
                                <div class='row'>
                                    <div class='col-sm-4'>Deliverable:</div>
                                    <div class='col-sm-8 wordBreak'>
                                        <span class='issuetext' title='${task.Title}' data-bs-toggle='tooltip' data-bs-placement='top'>${task.Title}</span>
                                    </div>
                                </div>
                            `;
                }

                if (task.Module) {
                    taskHTML += `
                                <div class='row'>
                                    <div class='col-sm-4'>Module:</div>
                                    <div class='col-sm-8 wordBreak'>
                                        <span class='issuetext' title='${task.Module}' data-bs-toggle='tooltip' data-bs-placement='top'>${task.Module}</span>
                                    </div>
                                </div>
                            `;
                }

                if (task.Issue) {
                    taskHTML += `
                                <div class='row'>
                                    <div class='col-sm-4'>Issue:</div>
                                    <div class='col-sm-8 wordBreak'>
                                        <span class='issuetext' title='${task.Issue}' data-bs-toggle='tooltip' data-bs-placement='top'>${task.Issue}</span>
                                    </div>
                                </div>
                            `;
                }

                // Close the parent div
                taskHTML += `
                                </div>
                            </div>
                        `;
                // Destroy any existing popover
                $(element).popover('dispose');

                // Initialize the popover
                $(element).popover({
                    html: true,
                    content: taskHTML,
                    trigger: 'focus',
                    placement: 'right'
                });

                // Show the popover immediately
                $(element).popover('show');
            }

        }

        var IsTaskCopy = 0;
        function PlotTaskDetails_OnCopy() {
            //debugger
            IsTaskCopy = 1;
            var FromDate = new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });      //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
            var ToDate = new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });      //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
            var PreviousWeekStartDate = new Date(FromDate);
            PreviousWeekStartDate.setDate(PreviousWeekStartDate.getDate() - 7); // Go back 7 days
            var PreviousWeekEndDate = new Date(ToDate);
            PreviousWeekEndDate.setDate(PreviousWeekEndDate.getDate() - 7); // Go back 7 days
            var PrevWeekStartDate = PreviousWeekStartDate.toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
            var PrevWeekEndDate = PreviousWeekEndDate.toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
            var taskParameters = {
                intEmployeeID: SessionEmployeeId,
                dtFromDate: PrevWeekStartDate,
                dtToDate: PrevWeekEndDate,
                WhereClause: WhereClause
            }
            var param = JSON.stringify(taskParameters);
            if (TimesheetStatus != "Approved" && TimesheetStatus != "Ready for approval" ) {
                var Result = AJAXCallWithResult("/api/TimesheetEntryNew/GetTaskDataOnCopy", param, false);
                //Added by Vishal to implement Override functionality
                var IsCopy = 0;
                for (var i = 0; i < Result.length; i++) {
                    var Flag = Result[i].PrevWeekFlag;;
                    if (Flag == 1) {
                        IsCopy = 1;
                        break;
                    }
                }
                var strHTML = "";
                var ProjectIdOld = 0;
                var IsDisableCheckbox = 0;
                if (Result.length > 0 && IsCopy == 1) {
                //End of Added by Vishal to implement Override functionality
                    var IsProjectValidData = 0;
                    for (var i = 0; i < Result.length; i++) {
                        var taskP = Result[i];
                        var ProjectIDlist = taskP.ProjectIDlist;
                        if (ProjectIDlist != null) {
                            IsProjectValidData = 1;
                            break;
                        }
                    }
                    if (IsProjectValidData == 1) {
                        $("#TimesheetInfoTbl_Body").html('');
                        for (var i = 0; i < Result.length; i++) {
                            //Task Binding starts here      
                            IsDisableCheckbox = 0;
                            if (Result[i]["TaskID"] !== null) {
                                var task = Result[i];
                                var TaskID = task.TaskID;
                                var Work = task.Work;
                                var PrevWeekFlag = task.PrevWeekFlag;
                                var SubTaskTypeID = task.SubTaskTypeID;
                                var TaskName = task.TaskName;
                                var ProjectID = task.ProjectID;
                                var ProjectIDlist = task.ProjectIDlist;//.split(',');
                                var ProjectName = task.ProjectName;
                                var MonDAID = task.MonDAID || 0;
                                var TueDAID = task.TueDAID || 0;
                                var WedDAID = task.WedDAID || 0;
                                var ThuDAID = task.ThuDAID || 0;
                                var FriDAID = task.FriDAID || 0;
                                var SatDAID = task.SatDAID || 0;
                                var SunDAID = task.SunDAID || 0;
                                if (MonDAID != 0 || TueDAID != 0 || WedDAID != 0 || ThuDAID != 0 || FriDAID != 0 || SatDAID != 0 || SunDAID != 0) {
                                    IsDisableCheckbox = 1;
                                }
                                var Mon = formatTime(task.Mon);
                                var Tue = formatTime(task.Tue);
                                var Wed = formatTime(task.Wed);
                                var Thu = formatTime(task.Thu);
                                var Fri = formatTime(task.Fri);
                                var Sat = formatTime(task.Sat);
                                var Sun = formatTime(task.Sun);
                                var ActualWork = formatTime(task.ActualWork);
                                var TaskActualWork = formatTime(task.TaskActualWork);
                                var MonStoryPoint = task.MonStoryPoint;
                                var TueStoryPoint = task.TueStoryPoint;
                                var WedStoryPoint = task.WedStoryPoint;
                                var ThuStoryPoint = task.ThuStoryPoint;
                                var FriStoryPoint = task.FriStoryPoint;
                                var SatStoryPoint = task.SatStoryPoint;
                                var SunStoryPoint = task.SunStoryPoint;
                                var MonDescription = task.MonDescription;
                                var TueDescription = task.TueDescription;
                                var WedDescription = task.WedDescription;
                                var ThuDescription = task.ThuDescription;
                                var FriDescription = task.FriDescription;
                                var SatDescription = task.SatDescription;
                                var SunDescription = task.SunDescription;
                                var ActualPercentComplete = task.ActualPercentComplete;
                                var ResourcePercentComplete = task.ResourcePercentComplete;
                                var IsTaskComplete = task.IsTaskComplete;
                                if (IsTaskComplete == true) {
                                    IsTaskComplete = 1;
                                } else if (IsTaskComplete == false || IsTaskComplete == null) {
                                    IsTaskComplete = 0;
                                }
                                var WhichTask = task.WhichTask;
                                var SubTaskTypeID = task.SubTaskTypeID;
                                if (SubTaskTypeID == null) {
                                    SubTaskTypeID = 0;
                                }
                                var IsProject = task.IsProject;
                                var Percentage = task.Percentage;
                                var IsAgileProject = task.IsAgileProject;
                                var ResourceLevelTaskCompletion = task.ResourceLevelTaskCompletion;
                                if (ResourceLevelTaskCompletion == true) {
                                    ResourceLevelTaskCompletion = 1;
                                } else if (ResourceLevelTaskCompletion == false || ResourceLevelTaskCompletion == null) {
                                    ResourceLevelTaskCompletion = 0;
                                }
                                var ApplyEffortDistribution = task.ApplyEffortDistribution;
                                var AllowActivityLevelDA = task.AllowActivityLevelDA;
                                var IsVerified = task.IsVerified;
                                var IsApprover = task.IsApprover;
                                var StatusFlag = task.StatusFlag; if (StatusFlag == null) { StatusFlag = ""; }
                                var MonStatusFlag = task.MonStatusFlag;
                                var TueStatusFlag = task.TueStatusFlag;
                                var WedStatusFlag = task.WedStatusFlag;
                                var ThuStatusFlag = task.ThuStatusFlag;
                                var FriStatusFlag = task.FriStatusFlag;
                                var SatStatusFlag = task.SatStatusFlag;
                                var SunStatusFlag = task.SunStatusFlag;

                                var MonAllowToResubmit = task.MonAllowToResubmit;
                                var TueAllowToResubmit = task.TueAllowToResubmit;
                                var WedAllowToResubmit = task.WedAllowToResubmit;
                                var ThuAllowToResubmit = task.ThuAllowToResubmit;
                                var FriAllowToResubmit = task.FriAllowToResubmit;
                                var SatAllowToResubmit = task.SatAllowToResubmit;
                                var SunAllowToResubmit = task.SunAllowToResubmit;
                                var TaskStatusFlag = task.TaskStatusFlag;
                                if(TimesheetStatus === "Rejected" && StatusFlag === "V"){
                                    StatusFlag = "J";
                                }
                                var IsSubTaskFilled = task.IsSubTaskFilled;
                                var RestrictByMinHours = task.RestrictByMinHours;
                                GlobalRestrictByMinHours = RestrictByMinHours;
                                var ActualStartDate = task.ActualStartDate;
                                var ActualEndDate = task.ActualEndDate;
                                if (ProjectIdOld != ProjectID) {
                                    if (ProjectIDlist.indexOf(ProjectID) <= -1) {
                                        strHTML += `<tr class="projectRow parentRow"><td class="py-0"><h2 class="accordion-header">
                        <button class="accordion-button NestedAccBtn collapsed" type="button" data-bs-toggle="collapse" data-bs-target=".superTab${ProjectID}" aria-expanded="true" onclick="PlotTaskDetails(${ProjectID},${SessionEmployeeId}, this);">
                        <img src="../../../Whizible2.0-new/dist/img/Projects_icon_blue.svg" class="me-2" alt="Project Icon">
                        <span class="flex-grow-1 projTitle">${Result[i]["ProjectName"]}</span><i class="fas fa-chevron-down ms-auto"></i></button></h2></td>
                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>`
                                    }
                                    else {
                                        strHTML += `<tr class="projectRow parentRow"><td class="py-0"><h2 class="accordion-header">
                        <button class="accordion-button NestedAccBtn collapsed" type="button" data-bs-toggle="collapse" data-bs-target=".superTab${ProjectID}" aria-expanded="true">
                        <img src="../../../Whizible2.0-new/dist/img/Projects_icon_blue.svg" class="me-2" alt="Project Icon">
                        <span class="flex-grow-1 projTitle">${Result[i]["ProjectName"]}</span><i class="fas fa-chevron-down ms-auto"></i></button></h2></td>
                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>`
                                    }
                                }
                                if (IsTaskComplete == 0) {
                                    strHTML += `<tr class="projectRow childRow accordion-collapse ExpsuperTab${PrevWeekFlag} collapse  superTab${ProjectID} HideProjectDetails_${ProjectID}" >
                                    <td class="">
                                        <div class="accordion-header d-flex justify-content-between px-2">
                                            <img src="../../../Whizible2.0-new/dist/img/task-icon.svg" alt="Task Image" class="taskIcn">
                                            <button class="accordion-button TaskAccBtn" type="button">
                                                ${Result[i]["TaskName"]}
                                            </button>
                                            <div data-bs-toggle="tooltip" title="Task Info">
                                                    <img src="../../../Whizible2.0-new/dist/img/info-circle.svg"
                                                            alt="More Info"
                                                            class="infoIcn cursorArrow ms-2"
                                                            onclick="showProjectTaskInfo(this, ${TaskID})"
                                                            tabindex="0">
                                                </div>
                                        </div>
                                    </td>
                                    <td>`
                                    //alt="More Info" data-bs-toggle="tooltip" title="Task Info"
                                    
                                    //Commented by Vishal Mane on 28/05/2025 to enable quickentry checkbox for all tasks for Expleo customization
                                    //if (IsDisableCheckbox == 1) {
                                    //    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} disabled/>`
                                    //    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                    //} else {
                                    //    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} />`
                                    //    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                    //}
                                    strHTML += `<input class="parentCheckbox me-2" type="checkbox" name="chkQuickEntry" id="chkQuickEntry_${ProjectID}_${TaskID}_${SubTaskTypeID}" value=${TaskID} />`
                                    strHTML += '   <input type="hidden" id="WhichTask_' + TaskID + '" value=' + WhichTask + '>'
                                    //End of Commented by Vishal Mane on 28/05/2025 to enable quickentry checkbox for all tasks for Expleo customization

                                    strHTML += `</td> <td><div class="d-flex align-items-center">`

                                    var dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }));     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    if (MonStatusFlag == 'R' || MonStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput1 taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1">`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="00:00" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="00:00" />`;
                                    }
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${MonDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${MonDescription ? MonDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (MonDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + MonDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 1));
                                    if (TueStatusFlag == 'R' || TueStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput1 taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2">`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="00:00" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${TueAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="00:00" />`;
                                    }
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${TueDAID}" placeholder="Enter Description..." maxlength='2000'>${TueDescription ? TueDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (TueDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + TueDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 2));
                                    if (WedStatusFlag == 'R' || WedStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput1 taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3">`   //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="00:00" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${WedAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`   //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="00:00" />`;
                                    }
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${WedDAID}" placeholder="Enter Description..." maxlength='2000'>${WedDescription ? WedDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (WedDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + WedDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 3));
                                    if (ThuStatusFlag == 'R' || ThuStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput1 taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4">`   //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="00:00" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${ThuAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`   //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="00:00" />`;
                                    }
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${ThuDAID}" placeholder="Enter Description..." maxlength='2000'>${ThuDescription ? ThuDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (ThuDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + ThuDAID + ',1)">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 4));
                                    if (FriStatusFlag == 'R' || FriStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput1 taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5">`   //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="00:00" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${FriAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`   //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="00:00" />`;
                                    }
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${FriDAID}" placeholder="Enter Description..." maxlength='2000'>${FriDescription ? FriDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (FriDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + FriDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 5));
                                    if (SatStatusFlag == 'R' || SatStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput1 taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6">`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="00:00" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SatAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="00:00" />`;
                                    }
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    //strHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" value="' + SatAllowToResubmit + '" />';
                                    //strHTML += '<input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US",{ timeZone: "Asia/Kolkata" })) + '" name="">';     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    //strHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + SatDAID + '" name="">';
                                    //strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SatDAID}" placeholder="Enter Description..." maxlength='2000'>${SatDescription ? SatDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (SatDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SatDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 6));
                                    if (SunStatusFlag == 'R' || SunStatusFlag == 'V' || StatusFlag == 'R' || StatusFlag == 'V' || StatusFlag == 'J') {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}"  data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7"  data-bs-auto-close="outside" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}"  class="form-control edtTimeInput1 taskTxt" type="text" data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7">`       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="00:00" />`;
                                    } else {
                                        strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SunAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7"  data-bs-toggle="tooltip" title="Enter Your Effort in hh:mm format"  placeholder = "00:00">`        //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                        strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="00:00" />`;
                                    }
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5"  data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SunDAID}" placeholder="Enter Description..." maxlength='2000'>${SunDescription ? SunDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    if (SunDAID != "") {
                                        strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SunDAID + ')">Save</button>'
                                    }
                                    //End of Added By Dipali V On 26th Aug 2026 for Description Save - render when DAID exists; hide/show with duration textbox readonly in EnableDisbaleDATextbox (Rejected stays editable so Save shows)
                                    strHTML += `</div></div></ul></div></div></td>`
                                    //Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    //if (WhichTask != 'D') {
                                    //    strHTML += `<td>${ActualPercentComplete} %</td>`
                                    //} else {
                                    //    strHTML += `<td></td>`
                                    //}
                                    //End of Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    if (WhichTask != 'D') {
                                        if (SubTaskTypeID == 0) {
                                            if (ResourceLevelTaskCompletion == 1) {
                                                strHTML += '<td>'
                                                strHTML += `<div class="">`
                                                if (IsTaskComplete == 1) {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl" checked disabled style="cursor:not-allowed!important;>'
                                                } else {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl">'
                                                }
                                                strHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            } else {
                                                strHTML += '<td>'
                                                strHTML += `<div class="custom_chckbox">N/A`
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            }
                                        } else {
                                            strHTML += '<td>'
                                            strHTML += `<div class="custom_chckbox">N/A`
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`
                                        }
                                    }
                                    else {
                                        strHTML += '<td>'
                                        strHTML += `<div class="custom_chckbox">`
                                        strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                        strHTML += `</div></td>`
                                    }
                                    strHTML += `<td><label class="totalTxt" name="pro_Calculate_count_${TaskID}" id="lblWeeklyTotal_${ProjectID}_${TaskID}_${SubTaskTypeID}">${ActualWork}</label>`
                                    strHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                                    strHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>'
                                    strHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input></td></tr>';

                                }
                                else if (IsTaskComplete == 1 && ActualStartDate != null && ActualEndDate != null && (
                                    (isValidDate(dtFromDate1) && isValidDate(ActualStartDate) && new Date(dtFromDate1) >= new Date(ActualStartDate) && new Date(dtFromDate1) <= new Date(dtToDate1)) ||
                                    (isValidDate(dtToDate1) && isValidDate(ActualEndDate) && new Date(dtToDate1) >= new Date(ActualEndDate) && new Date(dtFromDate1) <= new Date(ActualEndDate))
                                )) {
                                    strHTML += `<tr class="projectRow childRow accordion-collapse collapse  superTab${ProjectID} HideProjectDetails_${ProjectID}" >
                                    <td class="">
                                        <div class="accordion-header d-flex justify-content-between px-2">
                                            <img src="../../../Whizible2.0-new/dist/img/task-icon.svg" alt="Task Image" class="taskIcn">
                                            <button class="accordion-button TaskAccBtn" type="button">
                                                ${Result[i]["TaskName"]}
                                            </button>
                                            <div data-bs-toggle="tooltip" title="Task Info">
                                                    <img src="../../../Whizible2.0-new/dist/img/info-circle.svg"
                                                            alt="More Info"
                                                            class="infoIcn cursorArrow ms-2"
                                                            onclick="showProjectTaskInfo(this, ${TaskID})"
                                                            tabindex="0">
                                                </div>
                                        </div>
                                    </td>
                                    <td>
                                        <input id="TaskSelect11" class="parentCheckbox me-2" type="checkbox" name="" />
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">`

                                    var dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }));     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${MonDAID}" data-Day-id="1" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${MonAllowToResubmit}" data-EntryDate-id="${new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="${Mon}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="1" >`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_1" value="00:00" />`;
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${MonDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${MonDescription ? MonDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (MonDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + MonDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 1));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${TueDAID}" data-Day-id="2" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${TueAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="${Tue}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="2" >`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_2" value="00:00" />`;
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${TueDAID}" placeholder="Enter Description..." maxlength='2000'>${TueDescription ? TueDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (TueDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + TueDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 2));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${WedDAID}" data-Day-id="3" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${WedAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="${Wed}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="3" >`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_3" value="00:00" />`;
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${WedDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${WedDescription ? WedDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (WedDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + WedDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 3));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${ThuDAID}" data-Day-id="4" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${ThuAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="${Thu}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="4" >`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_4" value="00:00" />`;
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${ThuDAID}" placeholder="Enter Description..." maxlength='2000'>${ThuDescription ? ThuDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (ThuDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + ThuDAID + ',1)">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 4));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${FriDAID}" data-Day-id="5" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${FriAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="${Fri}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="5" >`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_5" value="00:00" />`;
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '5" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${FriDAID}" placeholder="Enter Numeric Values..." maxlength='2000'>${FriDescription ? FriDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (FriDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + FriDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 5));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SatDAID}" data-Day-id="6" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SatAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="${Sat}"  class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="6" >`     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_6" value="00:00" />`;
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    //strHTML += '<input type="hidden" name="txtAllowToResubmit" id="txtAllowToResubmit_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" value="' + SatAllowToResubmit + '" />';
                                    //strHTML += '<input id="Entry_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + (new Date(NextDay).toLocaleDateString("en-US",{ timeZone: "Asia/Kolkata" })) + '" name="">';     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    //strHTML += '<input id="DA_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="' + SatDAID + '" name="">';
                                    //strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '6" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5" data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SatDAID}" placeholder="Enter Description..." maxlength='2000'>${SatDescription ? SatDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (SatDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SatDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div></td>`
                                    strHTML += `<td><div class="d-flex align-items-center">`
                                    var NextDay = new Date();
                                    dtstartDate = new Date(new Date($("#weekPicker2").attr("StartDate")));
                                    NextDay = new Date(dtstartDate.setDate(dtstartDate.getDate() + 6));
                                    strHTML += `<input maxlength="5"  data-IsAgileProject-id="${IsAgileProject}"  data-StatusFlag-id="${StatusFlag}"  data-ProjectID-id="${ProjectID}" data-TaskID-id="${TaskID}" data-ProjectName-id="${encodeURIComponent(ProjectName)}"  data-TaskName-id="${encodeURIComponent(TaskName)}"  data-DAID-id="${SunDAID}" data-Day-id="7" data-SubTaskTypeID-id="${SubTaskTypeID}"  data-AllowToResubmit-id="${SunAllowToResubmit}" data-EntryDate-id="${new Date(NextDay).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" })}" data-bs-auto-close="outside" id="Duration_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="${Sun}" class="form-control edtTimeInput1 taskTxt" type="text" title="Enter Your Effort in hh:mm format" onkeypress="return isNumber(event,this.value,this)" data-row=${counter} data-col="7" >`      //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                    strHTML += `<input type="hidden" name="DurationHidden" id="DurationHidden_${ProjectID}_${TaskID}_${SubTaskTypeID}_7" value="00:00" />`;
                                    strHTML += '<input id="txtDuChRow_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '_' + '7" type="hidden" value="0" name="">';
                                    strHTML += `<div class="">
                                                <i class="fas fa-ellipsis-v ps-1" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"></i>
                                                <ul class="dropdown-menu TaskDescDropdown">`
                                    strHTML += `<div><textarea class="form-control InputDescription" rows="5"  data-ProjectID-id=${ProjectID} data-TaskID-id=${TaskID} data-DAID-id="${SunDAID}" placeholder="Enter Description..." maxlength='2000'>${SunDescription ? SunDescription : ''}</textarea></div>`
                                    strHTML += `<div class="text-end mt-2">`
                                    //if (SunDAID != "") {
                                    //    strHTML += '<button class="btn btnyellow" data-bs-toggle="tooltip" title="Save" onclick="SaveDescription_OnClick(' + ProjectID + ',' + TaskID + ',' + SunDAID + ')">Save</button>'
                                    //}
                                    strHTML += `</div></div></ul></div></div></td>`
                                    //Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    //if (WhichTask != 'D') {
                                    //    strHTML += `<td>${ActualPercentComplete} %</td>`
                                    //} else {
                                    //    strHTML += `<td></td>`
                                    //}
                                    //End of Commented by Vishal Mane on 13/01/2025 to remove Work Hour complete column
                                    if (WhichTask != 'D') {
                                        if (SubTaskTypeID == 0) {
                                            if (ResourceLevelTaskCompletion == 1) {
                                                strHTML += '<td>'
                                                strHTML += `<div class="">`
                                                if (IsTaskComplete == 1) {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl" checked disabled style="cursor:not-allowed!important;>'
                                                } else {
                                                    strHTML += '<input type="checkbox"  id="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" data-ProjectID-id="' + ProjectID + '" data-TaskID-id="' + TaskID + '" data-SubTaskTypeID-id=' + SubTaskTypeID + ' value="' + TaskID + '" class="chcktbl">'
                                                }
                                                strHTML += '<label for="IsTaskComplete_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '"></label>'
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            } else {
                                                strHTML += '<td>'
                                                strHTML += `<div class="custom_chckbox">N/A`
                                                strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                                strHTML += `</div></td>`

                                            }
                                        } else {
                                            strHTML += '<td>'
                                            strHTML += `<div class="custom_chckbox">N/A`
                                            strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                            strHTML += `</div></td>`
                                        }
                                    }
                                    else {
                                        strHTML += '<td>'
                                        strHTML += `<div class="custom_chckbox">`
                                        strHTML += '<input id="ResourceLevelTaskCompletion_' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ResourceLevelTaskCompletion + '" name="">';
                                        strHTML += `</div></td>`
                                    }
                                    strHTML += `<td><label class="totalTxt" name="pro_Calculate_count_${TaskID}" id="lblWeeklyTotal_${ProjectID}_${TaskID}_${SubTaskTypeID}">${ActualWork}</label>`
                                    strHTML += '<input id="TotalAllocationDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + ConvertToDecimal(Work) + '"</input>'
                                    strHTML += '<input id="TotalActualDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input>'
                                    strHTML += '<input id="TotalActualDynamicDurationhidden' + ProjectID + '_' + TaskID + '_' + SubTaskTypeID + '" type="hidden" value="' + TaskActualWork + '"</input></td></tr>';
                                }
                                ProjectIdOld = ProjectID;
                            }
                            //Task Binding ends here
                        }
                        $("#TimesheetInfoTbl_Body").html(strHTML);
                        $(`.ExpsuperTab1`).collapse('show');
                        if (Result != "" || Result != undefined) {
                            alertify.set('notifier', 'position', 'top-right');
                            //alertify.success('Daily Activity copied successfully.');
                            //alertify.success('<%=MyBase.GetResourceString("A_DACopied")%>');
                            alertify.success("Daily activity copied successfully. However, the task has not been saved yet. Please save it explicitly.");
                        }
                        timesheetEntries = [];
                        //Commented and Added By Riddhesh Patil on 18 Feb 2025 for Issue of 24hrs wrong valdation.
                        // $('input.edtTimeInput1').each(function () {
                        $('.ExpsuperTab1 input.edtTimeInput1').each(function () {
                        //End of Commented and Added By Riddhesh Patil on 18 Feb 2025 for Issue of 24hrs wrong valdation.
                            //debugger
                            var $input = $(this);
                            var $descriptionTextarea = $input.closest("td").find(".TaskDescDropdown textarea");
                            var checkboxId = `#IsTaskComplete_${$input.data('projectid-id')}_${$input.data('taskid-id')}_${$input.data('subtasktypeid-id')}`;
                            var $checkbox = $(checkboxId);
                            var TaskComplete = $checkbox.is(':checked');
                            var entry = {
                                DailyActivityEntryID: $(this).data('daid-id'),
                                TaskID: $(this).data('taskid-id'),
                                ProjectID: $(this).data('projectid-id'),                                
                                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                                //Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                                ProxyResourceID: '<%= Session("intUserId") %>',
                                //End of Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                                EmployeeID: SessionEmployeeId,
                                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                                EntryDate: new Date($(this).data('entrydate-id')).toLocaleDateString('en-US'),
                                //EntryDate: "27/11/2024",
                                Duration: $(this).val().replace(":", "."),
                                Description: $descriptionTextarea.val().replace(/'/g, "''"),
                                SubTaskTypeID: $(this).data('subtasktypeid-id'),
                                //IsDurationChange: txtDuChRow.value,
                                IsTaskComplete: TaskComplete,
                                //ActualPercentComplete: workComp,
                                //bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                                //StoryPoint: storypoint,
                                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                                Day: $(this).data('day-id'),
                                ConfirmFlag: 0,
                                //Added By Dipali V On 19th Feb 2025 For Alert Issue
                                IsAllowToFillDAAfterValidate: 0,
                                //End of Added By Dipali V On 19th Feb 2025 For Alert Issue
                                TaskName: $(this).data('taskname-id'),
                                ProjectName: $(this).data('projectname-id'),
                                //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                                IsCorrectEntry: 1,
                                //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue


                            };
                            var existingEntryIndex = timesheetEntries.findIndex(e => e.ProjectID == entry.ProjectID && e.TaskID == entry.TaskID && e.Day == entry.Day);
                            if (existingEntryIndex !== -1) {
                                timesheetEntries.splice(existingEntryIndex, 1);
                            }
                            if (parseFloat(entry.DailyActivityEntryID) > 0) {
                                timesheetEntries.push(entry);
                            } else {
                                if (!isNaN(parseFloat(entry.Duration)) && parseFloat(entry.Duration) != 0) {
                                    timesheetEntries.push(entry);
                                }
                            }
                        });
                        console.log(timesheetEntries);
                        $("#CopyPrevWeek").prop("disabled", true);
                        $('[data-bs-toggle="tooltip"]').tooltip();

                        $("#loadMoreBtn").hide();
                        $('#loadLessBtn').hide();
                    } else {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.error('No data available to copy.');
                        //alertify.error('There are no daily activities available to copy.');
                        alertify.error('<%=MyBase.GetResourceString("A_NoDAToCopy")%>');
                        $("#CopyPrevWeek").prop("disabled", true);
                        $('[data-bs-toggle="tooltip"]').tooltip();
                    }
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error('No data available to copy.');
                    //alertify.error('There are no daily activities available to copy.');
                    alertify.error('<%=MyBase.GetResourceString("A_NoDAToCopy")%>');
                    $("#CopyPrevWeek").prop("disabled", true);
                    $('[data-bs-toggle="tooltip"]').tooltip();
                }
            }
            else if (TimesheetStatus == "Approved"){
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error('You cannot copy daily activities for an approved timesheet.');
                alertify.error('<%=MyBase.GetResourceString("A_CannotCopyDA")%>');
                //$("#CopyPrevWeek").prop("disabled", true);
                $('[data-bs-toggle="tooltip"]').tooltip();
                $("#CopyPrevWeek").prop("checked", false);
            }
            else if (TimesheetStatus == "Ready for approval") {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error('You cannot copy daily activities for an approved timesheet.');
                alertify.error("You cannot copy daily activities for a submitted timesheet.");
                //$("#CopyPrevWeek").prop("disabled", true);
                $('[data-bs-toggle="tooltip"]').tooltip();
                $("#CopyPrevWeek").prop("checked", false);
            }
        }

        $("body").on("change", ".edtTimeInput1", function () {
            //debugger            
            var $input = $(this);
            var $descriptionTextarea = $input.closest("td").find(".TaskDescDropdown textarea");
            var checkboxId = `#IsTaskComplete_${$input.data('projectid-id')}_${$input.data('taskid-id')}_${$input.data('subtasktypeid-id')}`;
            var $checkbox = $(checkboxId);
            var TaskComplete = $checkbox.is(':checked');
            var storypointId = `#StoryPoint_${$input.data('projectid-id')}_${$input.data('taskid-id')}_${$input.data('subtasktypeid-id')}_${$input.data('day-id')}`
            storypoint = $(storypointId).val() ? $(storypointId).val() : "0";
            var entry = {
                DailyActivityEntryID: $(this).data('daid-id'),
                TaskID: $(this).data('taskid-id'),
                ProjectID: $(this).data('projectid-id'),
                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                //Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                ProxyResourceID: '<%= Session("intUserId") %>',
                //End of Added by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                EmployeeID: SessionEmployeeId,
                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                EntryDate: new Date($(this).data('entrydate-id')).toLocaleDateString('en-US'),
                //EntryDate: "27/11/2024",
                Duration: $(this).val().replace(":", "."),
                Description: $descriptionTextarea.val().replace(/'/g, "''"),
                SubTaskTypeID: $(this).data('subtasktypeid-id'),
                //IsDurationChange: txtDuChRow.value,
                IsTaskComplete: TaskComplete,
                //ActualPercentComplete: workComp,
                //bitResourceTaskComplete: objResourceLevelTaskCompletion.value,
                StoryPoint: storypoint,
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                Day: $(this).data('day-id'),
                ConfirmFlag: 0,
                //Added By Dipali V On 19th Feb 2025 For Alert Issue
                IsAllowToFillDAAfterValidate: 0,
                //End of Added By Dipali V On 19th Feb 2025 For Alert Issue
                TaskName: $(this).data('taskname-id'),
                ProjectName: $(this).data('projectname-id'),
                IsAgileProject: $(this).data('isagileproject-id'),
                //Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
                IsCorrectEntry: 1,
                //End of Added by Vishal Mane on 27/06/2025 to fix first days timesheet entry getting blank issue
            };
            var existingEntryIndex = timesheetEntries.findIndex(e => e.ProjectID == entry.ProjectID && e.TaskID == entry.TaskID && e.Day == entry.Day);
            if (existingEntryIndex !== -1) {
                timesheetEntries.splice(existingEntryIndex, 1);
            }
            if (parseFloat(entry.DailyActivityEntryID) > 0) {
                timesheetEntries.push(entry);
            } else {
                if (!isNaN(parseFloat(entry.Duration)) && parseFloat(entry.Duration) != 0) {
                    timesheetEntries.push(entry);
                }
            }

        });
        
        var strUrlTimesheet = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        function SubmitTS_OnClick() {
            //debugger
            var ActualHours = $("#txtActualHrs").text();            
            var timeParts = ActualHours.split(':');
            var hours = parseInt(timeParts[0], 10); 
            var minutes = parseInt(timeParts[1], 10); 
            var totalMinutes = (hours * 60) + minutes;
            if (totalMinutes  != 0) {
                var IsDAFilledHrs = $("#txtWeeklyTotal").text();
                if (IsDAFilledHrs == "00:00") {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error('Please fill/save timesheet entry.');
                    alertify.error('<%=MyBase.GetResourceString("A_FillTimesheet")%>');
                    return false;
                }
                if (ValidateSubmitTS() == 1) {
                    return false;
                }
                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                var proxyResourceEmpID = $("#cboProxyResource").val();
                var taskparameters;
                if (proxyResourceEmpID != 0) {
                    taskparameters = {
                        intProxyUserID: parseInt('<%= Session("intUserID") %>'),
                        employeeID: parseInt(proxyResourceEmpID),
                        dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                        dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                        intTimesheetID: 0,
                        StatusCode: "R",
                        ReportFormat: "",
                        intMobileView: 0
                    }
                }
                else {
                    taskparameters = {
                        intProxyUserID: 0,
                        //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                        //employeeID: '<%= Session("intUserID") %>',
                        employeeID: parseInt(SessionEmployeeId),
                        //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                        dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                        dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                        intTimesheetID: 0,
                        StatusCode: "R",
                        ReportFormat: "",
                        intMobileView: 0
                    }
                }
                console.log(taskparameters);
                //End of Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo                
                $.ajax({                    
                    url: strUrl + '/api/TimesheetEntryNew/GenerateTimesheet',
                    type: "POST",
                    data: JSON.stringify(taskparameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json; charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                        if (taskparameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                        }
                    },
                    success: function (data) {
                        var arrData = data.split('$');
                        if (arrData[0] == 1) {
                            window.open('../Email/SendEmail.aspx?MessageID=434&TimesheetID=' + arrData[1] + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                        }
                        //ReloadTApprovalData(EmployeeID);
                        GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
                        GetTaskData(SessionEmployeeId);
                        //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
                        EnableDisbaleDATextbox();
                        //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
                    },
                    error: function (err) {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                })

            }else {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error('Please fill daily activity.');
                alertify.error('<%=MyBase.GetResourceString("A_FillDA")%>');
            }

        }

        function ValidateSubmitTS() {
            var Flag = 0;
            var taskparameters = {                
                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                //intEmployeeID: '<%= Session("intUserID") %>',
                intEmployeeID: SessionEmployeeId,
                //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
                dtFromDate: new Date($("#weekPicker2").attr("StartDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
                dtToDate: new Date($("#weekPicker2").attr("EndDate")).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" }),     //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
            }
            var param = JSON.stringify(taskparameters);
            var data = AJAXCallWithResult("/api/TimesheetEntryNew/ValidateTimesheet", param, false);
            if (data == "") {
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('' + data + '');
                Flag = 1;
            }
            return Flag;
        }
        function ConvertToDecimal(intVal) {

            var objVal = '' + intVal + '';

            if (objVal.length == 1) {
                var fmtMon = '0' + objVal + ':00';
                objVal = fmtMon;
            }
            if (objVal.length == 2) {
                var fmtMon = objVal + ':00';
                objVal = fmtMon;
            }
            if (objVal.length == 3) {
                var fmtMon = objVal.replace('.', ':');

                fmtMonx = fmtMon.indexOf(':');
                if (fmtMonx == 1) {
                    objVal = '0' + fmtMon + '0';
                }
                if (fmtMonx == -1) {
                    objVal = objVal + ':00';
                }
                if (fmtMonx == 2) {
                    objVal = objVal + '00';
                }
            }
            if (objVal.length == 4) {
                var fmtMon = objVal.replace('.', ':');
                fmtMonx = fmtMon.indexOf(':');
                if (fmtMonx == 2)
                    objVal = '' + fmtMon + '0';
                if (fmtMonx == 1)
                    objVal = '0' + fmtMon + '';
            }
            if (objVal.length >= 5) {

                var fmtMon = objVal.replace('.', ':');
                fmtMonx = fmtMon.indexOf(':');
                var fmtMon_New = fmtMon.split(":");
                if (fmtMonx == 1)
                    objVal = '0' + fmtMon + '';
                if (fmtMonx == 2)
                    objVal = '' + fmtMon + '';
                if (fmtMonx == 3) {
                    objVal = fmtMon + '0';
                }
                if (fmtMonx == 4 && fmtMon.length > 5) {
                    if (fmtMon_New[1] != "") {
                        if (fmtMon_New[1].length == 1) {
                            objVal = '0' + fmtMon
                        } else {
                            objVal = fmtMon;

                        }
                    }
                }
                else {
                    objVal = fmtMon;
                }
            }
            return objVal;
        }

        var IsGloabl = 0;
        function EditTimesheet() {
            IsGloabl = 1;
            $('#TimesheetInfoTbl tbody tr').each(function () {
                var statusFlag = $(this).find('.edtTimeInput').data('statusflag-id');
                if (statusFlag == "J") {
                    $(this).find('.edtTimeInput').prop('readonly', false); // Make input editable
                }
            });
            $("#txtEditTS").hide();
            $("#saveTimesheetBtn").show();
        }
        var StoryPointCount = 0;
        var OldTaskID = 0, CurrentTaskID = 0;
        function StoryPoint_OnChangeNew(objTextBox) {
            //debugger
            var fn_argument = arguments.length;
            var Isvalid = 0;
            if (objTextBox.value != "") {
                if (objTextBox.value != objTextBox.defaultValue) {
                    var EntryID = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'Entry');
                    var DAID = (objTextBox.id).replace((objTextBox.id).substring(0, (objTextBox.id).indexOf("_")), 'DA');
                    var arrData = EntryID.split('_');
                    var ProjectID = arrData[1];
                    var TaskID = arrData[2];
                    var SubTaskTypeID = arrData[3];
                    var objEntryDate = document.getElementById(EntryID);
                    var objDAID = document.getElementById(DAID);
                    CurrentTaskID = TaskID;
                    if (OldTaskID == 0) {
                        OldTaskID = CurrentTaskID;
                    }
                    if (fn_argument == 2) {
                        if (CurrentTaskID == OldTaskID) {
                            StoryPointCount = (StoryPointCount - 0) + (objTextBox.value - 0);
                        }
                        else {
                            StoryPointCount = 0;
                        }
                        var taskParameters = {
                            TaskID: TaskID,
                            StoryPoint: StoryPointCount,
                            dtFromDate: objEntryDate.value,
                            DAID: objDAID.value,
                        }
                    }
                    else {
                        var taskParameters = {
                            TaskID: TaskID,
                            StoryPoint: objTextBox.value,
                            dtFromDate: objEntryDate.value,
                            DAID: objDAID.value,
                        }
                    }
                    $.ajax({
                        url: strUrl + '/api/TimesheetEntryNew/ValidateStoryPoint',
                        type: "POST",
                        data: JSON.stringify(taskParameters),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        async: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                            if (taskParameters) {
                                xhr.setRequestHeader("Params", encryptString(isJson(taskParameters) ? taskParameters : JSON.stringify(taskParameters)));
                            }
                        },
                        success: function (data) {
                            if (data != "") {
                                showAlert(data, 'alert-danger');
                                objTextBox.value = "0";
                                Isvalid = 1;
                            }
                        },
                        error: function (err) {
                            console.log(err);
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
            }
            if (Isvalid == 1) {
                return false;
            }
            else {
                return true
            }
        }

        function validateInput(input) {
            input.value = input.value.replace(/[^0-9]/g, '');
        }

        function CheckHHMMFormat(obj) {           
            var totalDuration = obj.replace(".", ":");
            if (!(/^\d{2}:\d{2}$/.test(totalDuration))) {
                return true;
            }
            return false;
        }


        //Added by Gauri P on 20/01/2025 for My Timesheet Tab

        // Check or Uncheck All checkboxes
        $("#TS_CheckAll").change(function () {
            var checked = $(this).is(":checked");
            if (checked) {
                $(".checkMyTS").each(function () {
                    if ($(this).is(':disabled')) {
                        $(this).prop("checked", false);
                    } else {
                        $(this).prop("checked", true);
                    }
                });
            } else {
                $(".checkMyTS").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // $('#trainingPlanTbl').on('draw.dt', function () {
        // Changing state of CheckAll checkbox
        $(".checkMyTS").click(function () {
            if ($(".checkMyTS").length === $(".checkMyTS:checked").length) {
                $("#TS_CheckAll").prop("checked", true);
            } else {
                $("#TS_CheckAll").prop("checked", false);
            }
        });

       
        $(".cancelEdtDetpanel").click(function () {
            $("table tr").removeClass("rowhiglight");
            $(".ShowHisDetailpanel").hide();
            // $(".backbtn, .addbtn, .deletebtn, .borderbox, .filter").removeClass("DisableContent").parent().css("cursor", "auto");
            $(".table").resize();
        });

        $('#MyTimesheetInfoTbl').wrap('<div class="dataTables_scroll" />');

        $('#GetMyTimesheetHistoryle').wrap('<div class="dataTables_scroll" />');

        function resizeSection() {
            var tblheight = $(window).height();
            $('#MyTimesheetInfoTbl_wrapper .dataTables_scroll').css({ 'height': tblheight - 200, "overflow-y": "auto" });
            $('#GetMyTimesheetHistoryle_wrapper .dataTables_scroll').css({ 'height': tblheight - 400, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        
        function GetTimesheetEntry(TimeSheetID, FromDate, ToDate) {          
            $("#btnCloseMyTimesheet").click();
            var fromDateObject = new Date(FromDate).toLocaleDateString("en-US", { timeZone: "Asia/Kolkata" });       //Added and modified by Vishal Mane on 29/07/2025 to fix timezone issue
            $('#weekPicker2').datepicker('setDate', fromDateObject);
            $('#weekPicker2').trigger('change');
            ClearFilter(0, "Prj");
            WhereClause = "";
            $("#filterSection").hide();            
            GetTimeSheetWeekHeaderDetails(SessionEmployeeId);
            GetTaskData(SessionEmployeeId);
            //Added by Dipali V on 21st April 2026 to implement Flexible Timesheet Submission feature
            EnableDisbaleDATextbox();
            //End of Added by Vishal Mane on 17/02/2026 to implement Flexible Timesheet Submission feature
        }

        var InitialCount = 0;
        var FinalCount = 0;
        $(".chckHead").change(function () {
            //debugger
            var allPages = MyTimesheetMasterTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {                   
                    $('input[type="checkbox"]:not(:disabled)', allPages).prop('checked', true);
                    var rows = $("#MyTimesheetInfoTbl").dataTable().fnGetNodes();                    
                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    InitialCount = 0;
                }
            }
            var rows = $("#MyTimesheetInfoTbl").dataTable().fnGetNodes();
            for (var i = 0; i < rows.length; i++) {
                if ($(rows[i]).find('input[name="checkDelete"]:checked').length > 0) {
                    InitialCount = InitialCount + 1;
                }
            }
        });        

        $(document).on('change', '.checkMyTS', function () {
            //debugger
            var isChecked = $(this).is(':checked');            
            if (isChecked) {
                FinalCount = FinalCount + 1;
            } else {
                FinalCount = InitialCount - 1;
            } 
            if (InitialCount == FinalCount) {
                $('#TS_CheckAll').prop('checked', true);
            }
            else if (InitialCount != 0 && InitialCount != FinalCount){
                $('#TS_CheckAll').prop('checked', false);
            }                
            else if (FinalCount == RejectedCount) {
                $('#TS_CheckAll').prop('checked', true);
            }
        });
        var MyTimesheetMasterTable;
        var RejectedCount = 0;
        function PlotMyTimesheetList(flag) {
            //debugger 
            if (flag == 1) {
                $("#cboStatusMyTS").val("0");
                $("#cboStatusMyTS").val("0").selectpicker('refresh');
            }
            $('#TS_CheckAll').prop('checked', false);
            $("#BtnCancelHistory").click();         
            var StatusCode = $("#cboStatusMyTS").val();
            if (StatusCode == 'J' || StatusCode == '0') {
                $("#resubmitMyTSBtn").show();
                $("#deleteMyTSBtn").show();
            } else {
                $("#resubmitMyTSBtn").hide();
                $("#deleteMyTSBtn").hide();
            }
            var taskparameters = {                
                //Added by Vishal Mane on 20/08/2025 to get Proxy Resource related Timesheet Data
                intEmployeeID: SessionEmployeeId,
                ProxyResourceID: '<%= Session("intUserId") %>',
                //End of Added by Vishal Mane on 20/08/2025 to get Proxy Resource related Timesheet Data
                Flag: StatusCode,
            }
            var param = JSON.stringify(taskparameters);
            //Commented and Modified by Vishal Mane on 20/08/2025 to get Proxy Resource related Timesheet Data
            //var data = AJAXCallWithResult("/api/TimesheetEntryNew/PlotMyTimesheetList", param, false);
            var data = AJAXCallWithResult("/api/TimesheetEntryNew/PlotMyTimesheetList_Proxy", param, false);
            //Commented and Modified by Vishal Mane on 20/08/2025 to get Proxy Resource related Timesheet Data
            var strHTML = "";
            $('#MyTimesheetInfoTbl').DataTable().destroy();
            if (data.length != 0) {
                for (var i = 0; i < data.length; i++) {
                    var MyTimesheetObject = data[i];
                    var TimeSheetID = MyTimesheetObject.TimesheetID;
                    var CreatedDate = MyTimesheetObject.CreatedDate;
                    var Period = MyTimesheetObject.Period;
                    var FromDate = MyTimesheetObject.FromDate;
                    var ToDate = MyTimesheetObject.Todate;
                    var ActualHours = MyTimesheetObject.ActualHours;
                    var StatusDescription = MyTimesheetObject.StatusDescription;
                    var Comment = MyTimesheetObject.Comment;                    
                    var AllTotal = formatTime(ActualHours);
                    strHTML += `<tr> <td>${CreatedDate}</td>`

                    //strHTML += `<td><a href="javascript:;" data-bs-dismiss="offcanvas">${FromDate} to ${ToDate}</a></td>`                        
                    strHTML += "<td class='mtdateperiod'> " +
                        "<input  id='FrmId_" + TimeSheetID + "' CboResource_OnChange type='hidden' value='" + FromDate + "'/>" +
                        "<input  id='ToId_" + TimeSheetID + "' type='hidden'  value='" + ToDate + "'>" +
                        "<a onclick='GetTimesheetEntry(&quot;" + TimeSheetID + "&quot;, &quot;" + FromDate + "&quot;, &quot;" + ToDate + "&quot;)' href='javascript:void(0)'>" + Period + "</a></td>"

                    strHTML +=`<td>${AllTotal}</td>`
                    strHTML += `<td><div class="d-flex justify-content-center gap-2">`
                    if (StatusDescription == 'Approved') {
                        strHTML += '<div class="statusDiv d-flex justify-content-start mx-0" data-bs-toggle="tooltip" title="Approved">'
                        strHTML += '<span class="statusBox statusApproved mx-2">&nbsp;</span><label class="crsrLink">Approved</label></div>'
                    }
                    if (StatusDescription == 'Rejected') {
                        strHTML += '<div class="statusDiv d-flex justify-content-start mx-0" data-bs-toggle="tooltip" title="Rejected">'
                        strHTML += '<span class="statusBox statusRejected mx-2">&nbsp;</span><label class="crsrLink">Rejected</label></div>'
                    }
                    if (StatusDescription == 'Ready for approval') {
                        strHTML += '<div class="statusDiv d-flex justify-content-start mx-0" data-bs-toggle="tooltip" title="Submitted ">'
                        strHTML += '<span class="statusBox statusSubmitted mx-2">&nbsp;</span><label class="crsrLink">Submitted</label></div>'
                    }
                    //strHTML += '<a href="javascript:;" class="textUndrln me-2" onclick="GetMyTimesheetHistory(' + TimeSheetID +')">'
                    strHTML += "<a href='javascript:;' class='textUndrln me-2' onclick=\"GetMyTimesheetHistory('" + TimeSheetID + "', '" + Period + "')\">";

                    strHTML += '<i class="fas fa-history" data-bs-toggle="tooltip" title="Show History"></i></a></div></td>'

                    var truncatedComment = Comment.length > 35 ? Comment.substring(0, 35) + " ..." : Comment;

                    strHTML += "<td class='text-start comment'><span class='comment' title='" + Comment.replace("'", "&quot;") + "' data-bs-toggle='tooltip' data-placement='left' data-container='body'>" + truncatedComment + "</span></td>";
                    strHTML += `<td><div class="custom_chckbox">`
                    if (StatusDescription == 'Rejected') {
                        strHTML += '<input class="checkMyTS" type="checkbox" id="Tapprovalall_' + TimeSheetID + '" name="checkDelete" />'
                        strHTML += '<label for= "Tapprovalall_' + TimeSheetID + '" class="checkChild"></label></div></td></tr>'
                    }
                    else {
                        strHTML += "<input type='checkbox'  id='Tapprovalall_" + TimeSheetID + "'disabled  style='cursor:not-allowed'>"
                        strHTML += "<label for='Tapprovalall_" + TimeSheetID + "'  style='cursor:not-allowed'></label>";
                    }
                }
                $("#MyTimesheetInfoTbl_Body").html(strHTML);
            }
            else {                
                $("#MyTimesheetInfoTbl_Body").html(strHTML);
            }
            MyTimesheetMasterTable = $('#MyTimesheetInfoTbl').dataTable({
                "paging": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": true,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "bAutoWidth": false,
                "ordering": false,
                "info": false,
            });
            var rows = $("#MyTimesheetInfoTbl").dataTable().fnGetNodes();
            for (var i = 0; i < rows.length; i++) {
                var nonDisabledCheckboxes = $('input[type="checkbox"]:not(:disabled)', rows[i]);               
                RejectedCount += nonDisabledCheckboxes.length;
            }
        }

        function GetMyTimesheetHistory(TimesheetID, TSperiod) {
            //debugger
            $(".ShowHisDetailpanel").show();
            $(".offcanvas-body").animate(
                {
                    scrollTop: $(".ShowHisDetailpanel").offset().top - 60,
                },
                "1000"
            );
            $(".table").resize();

            $("#TS_Period").text(TSperiod);
            var taskparameters = {
                intTimesheetID: TimesheetID,
            }
            var param = JSON.stringify(taskparameters);
            var TimesheetHistoryLists = AJAXCallWithResult("/api/TimesheetEntryNew/GetMyTimesheetHistory", param, false);
            var strHTML = "";
            $('#GetMyTimesheetHistoryle').DataTable().destroy();
            if (TimesheetHistoryLists.length != 0) {
                for (var i = 0; i < TimesheetHistoryLists.length; i++) {
                    var HistoryObject = TimesheetHistoryLists[i];
                    var DateAndTime = HistoryObject.DateAndTime;
                    var ModifiedBy = HistoryObject.ModifiedBy;
                    var Field = HistoryObject.Field;
                    var OldValue = HistoryObject.OldValue;
                    var NewValue = HistoryObject.NewValue;
                    var StatusDescription = HistoryObject.StatusDescription;
                    var CreatedDate = HistoryObject.CreatedDate;
                    var UpdatedDate = HistoryObject.UpdatedDate;
                    var ActionTakenBy = HistoryObject.ActionTakenBy;
                    var ActionTaken = HistoryObject.ActionTaken;
                    var ApproverName = HistoryObject.ApproverName;

                    strHTML += '<tr><td>'
                    strHTML += '<div class="d-flex justify-content-center gap-2">'

                    if (StatusDescription == 'Approved') {
                        strHTML += '<div class="statusDiv d-flex justify-content-start mx-0" data-bs-toggle="tooltip" title="Approved">'
                        strHTML += '<span class="statusBox statusApproved mx-2">&nbsp;</span><label class="crsrLink">Approved</label></div>'
                    }
                    if (StatusDescription == 'Rejected') {
                        strHTML += '<div class="statusDiv d-flex justify-content-start mx-0" data-bs-toggle="tooltip" title="Rejected">'
                        strHTML += '<span class="statusBox statusRejected mx-2">&nbsp;</span><label class="crsrLink">Rejected</label></div>'
                    }
                    if (StatusDescription == 'Submitted') {
                        strHTML += '<div class="statusDiv d-flex justify-content-start mx-0" data-bs-toggle="tooltip" title="Submitted ">'
                        strHTML += '<span class="statusBox statusSubmitted mx-2">&nbsp;</span><label class="crsrLink">Submitted</label></div>'
                    }
                    strHTML += '</td>'

                    strHTML += '<td>' + (CreatedDate ? CreatedDate : '') + '</td>';
                    strHTML += '<td>' + (UpdatedDate ? UpdatedDate : '') + '</td>';
                    strHTML += '<td>' + (ActionTakenBy ? ActionTakenBy : '') + '</td>';
                    strHTML += '<td>' + (ActionTaken ? ActionTaken : '') + '</td>';
                    strHTML += '<td>' + (ApproverName ? ApproverName : '') + '</td></tr>';
                }
            }
            else {
                strHTML = "";
            }            
            $("#GetMyTimesheetHistoryle_Body").html(strHTML);
            $('#GetMyTimesheetHistoryle').dataTable({                
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "bAutoWidth": false,
                "ordering": false,
                "info": false,
            });
        }

        $("#deleteMyTSBtn").click(function () {                       
            var selectedTimesheetID = [];
            var rows = $("#MyTimesheetInfoTbl").dataTable().fnGetNodes();
            for (var i = 0; i < rows.length; i++) {
                if ($(rows[i]).find('input[name="checkDelete"]:checked').length > 0) {
                    var timesheetID = $(rows[i]).find('input[name="checkDelete"]:checked').attr('id').split('Tapprovalall_')[1];
                    selectedTimesheetID.push(timesheetID);
                }
            }
            if (selectedTimesheetID.length == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select at least one record to delete.");
                return false;
            }
            else {
                $("#deleteinfomodal").modal("show");
            }
        });
        
        function DeleteData() {
            var rows = $("#MyTimesheetInfoTbl").dataTable().fnGetNodes();
            for (var i = 0; i < rows.length; i++) {               
                if ($(rows[i]).find('input[name="checkDelete"]:checked').length > 0) {
                    var timesheetID = $(rows[i]).find('input[name="checkDelete"]:checked').attr('id').split('Tapprovalall_')[1];                    
                    DeleteMyTimesheet(timesheetID);
                }
            }
            alertify.set('notifier', 'position', 'top-right');
            alertify.success("Timesheet deleted successfully.");
            $("#deleteinfomodal").modal("hide");
            PlotMyTimesheetList();
        }

        function DeleteMyTimesheet(ids) {
            //debugger
            var taskparameters = {
                intTimesheetID: ids,
            }
            var param = JSON.stringify(taskparameters);
            var data = AJAXCallWithResult("/api/TimesheetEntryNew/DeleteMyTimesheet", param, false);            
        }

        $("#resubmitMyTSBtn").click(function () {
            var selectedTimesheetID = [];
            var rows = $("#MyTimesheetInfoTbl").dataTable().fnGetNodes();
            for (var i = 0; i < rows.length; i++) {
                if ($(rows[i]).find('input[name="checkDelete"]:checked').length > 0) {
                    var timesheetID = $(rows[i]).find('input[name="checkDelete"]:checked').attr('id').split('Tapprovalall_')[1];
                    selectedTimesheetID.push(timesheetID);
                }
            }
            if (selectedTimesheetID.length == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select at least one record to resubmit.");
                return false;
            }
            else {
                $("#submitinfomodal").modal("show");
            }
        });
        function SubmitData() { 
            var SelectedEmpID = [];
            var rows = $("#MyTimesheetInfoTbl").dataTable().fnGetNodes();
            for (var i = 0; i < rows.length; i++) {
                if ($(rows[i]).find('input[name="checkDelete"]:checked').length > 0) {                    
                    var timesheetID = $(rows[i]).find('input[name="checkDelete"]:checked').attr('id').split('Tapprovalall_')[1];
                    var Fromdate = $(rows[i]).find('input[id="FrmId_' + timesheetID + '"]').val();
                    var Todate = $(rows[i]).find('input[id="ToId_' + timesheetID + '"]').val();
                    var entry = {
                        TimesheetID: timesheetID,
                        dtFromDate: Fromdate,
                        dtToDate: Todate,
                    };
                    SelectedEmpID.push(entry);
                }
            }
            SelectedEmpID.forEach(function (entry) {
                SubmitAjaxCall(entry.TimesheetID, entry.dtFromDate, entry.dtToDate);
            });
        }

        function SubmitAjaxCall(TimesheetID, FromDate, ToDate) {
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //FilteredEmpID = SessionEmployeeId;
            //if (FilteredEmpID != 0) {
            //    if (ValidateMySubmitTS(FilteredEmpID, FromDate, ToDate) == 1) {
            //        return false;
            //    }
            //}
            //taskparameters = {
            //    intProxyUserID: 0,
            //    employeeID: FilteredEmpID,
            //    dtFromDate: FromDate,
            //    dtToDate: ToDate,
            //    intTimesheetID: TimesheetID,
            //    StatusCode: "R",
            //}
            var proxyResourceEmpID = $("#cboProxyResource").val();
            if (proxyResourceEmpID == undefined) {
                proxyResourceEmpID = 0;
            }
            if (proxyResourceEmpID != 0) {
                if (ValidateMySubmitTS(proxyResourceEmpID, FromDate, ToDate) == 1) {
                    return false;
                }
            }
            var taskparameters;
            if (proxyResourceEmpID != 0) {
                taskparameters = {
                    intProxyUserID: '<%= Session("intUserID") %>',
                    employeeID: proxyResourceEmpID,
                    dtFromDate: FromDate,
                    dtToDate: ToDate,
                    intTimesheetID: TimesheetID,
                    StatusCode: "R",
                }
            }
            else {
                taskparameters = {
                    intProxyUserID: 0,
                    employeeID: SessionEmployeeId,
                    dtFromDate: FromDate,
                    dtToDate: ToDate,
                    intTimesheetID: TimesheetID,
                    StatusCode: "R",
                }
            }
            //End of Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            $.ajax({
                //url: strUrl + '/api/MyTimesheet/GenerateMyTimesheet',
                url: strUrl + '/api/TimesheetEntryNew/GenerateMyTimesheet',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? taskparameters : JSON.stringify(taskparameters)));
                    }
                },
                success: function (data) {
                    if (data == 1) {
                        window.open('../Email/SendEmail.aspx?MessageID=434&TimesheetID=' + TimesheetID + '', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                    }
                    PlotMyTimesheetList();
                    $("#submitinfomodal").modal('hide');
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })

        }

        function ValidateMySubmitTS(EmployeeID, FromDate, ToDate) {
            var Flag = 0;                    
            var taskparameters = {
                intEmployeeID: EmployeeID,
                dtFromDate: FromDate,
                dtToDate: ToDate,
            }
            var param = JSON.stringify(taskparameters);
            var data = AJAXCallWithResult("/api/TimesheetEntryNew/ValidateTimesheet", param, false);
            if (data == "") {
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('' + data + '');
                Flag = 1;

            }
            return Flag;
        }        

        function DownloadReport(ReportFormat) {
            //Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            //var FilteredEmpID = SessionEmployeeId;
            //if (FilteredEmpID == undefined) {
            //    FilteredEmpID = 0;
            //}
            //var StatusCode = $("#cboStatusMyTS").val();
            //if (StatusCode == '0') {
            //    StatusCode = "Null";
            //}
            //if (FilteredEmpID != 0) {
            //    taskparameters = {
            //        intProxyUserID: 0,
            //        employeeID: FilteredEmpID,
            //        StatusCode: StatusCode,
            //        ReportFormat: ReportFormat,
            //    }
            //}
            var FilteredEmpID = $("#cboProxyResource").val();
            if (FilteredEmpID == undefined) {
                FilteredEmpID = 0;
            }
            var StatusCode = $("#cboStatusMyTS").val();
            if (StatusCode == '0') {
                StatusCode = "Null";
            }
            if (FilteredEmpID != 0) {
                taskparameters = {
                    intProxyUserID: '<%= Session("intUserID") %>',
                    employeeID: FilteredEmpID,
                    StatusCode: StatusCode,
                    ReportFormat: ReportFormat,
                }
            }
            else {
                taskparameters = {
                    intProxyUserID: 0,
                    employeeID: '<%= Session("intUserID") %>',
                    StatusCode: StatusCode,
                    ReportFormat: ReportFormat,
                }
            }
            //End of Commented and Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
            $.ajax({
                url: strUrl + '/api/TimesheetEntryNew/ExportDocument',
                type: "POST",
                data: JSON.stringify(taskparameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Timesheet"));
                    if (taskparameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(taskparameters) ? param : JSON.stringify(taskparameters)));
                    }
                },
                success: function (data) {
                    console.log(data);
                    //alert("Success");
                    if (data == "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Records not available to download Report.');
                        //showAlert('Records not available to download Report.', 'alert-danger');
                        // alert("NOT");
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
        //End of Added by Gauri P on 20/01/2025 for My Timesheet Tab
    </script>
</body>
</html>
