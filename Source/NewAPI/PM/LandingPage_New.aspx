<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LandingPage_New.aspx.vb" Inherits="PbNIT.LandingPage_New" %>

<!DOCTYPE html>

<html>
    
<%CommonFunctions.General.PlotPageHeadTag("Overview")%>

<head runat="server">
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">--%>
    <title>Overview</title>
    <%--<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/calendar-gc.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_new.css" type="text/css" />

    <style>
    * {
        margin: 0;
        padding: 0;
        /* Changed By Madhuri.K on 26-03-2026 */
        font-size: 11.5px !important;
        box-sizing: border-box;
    }
    /* Added by Madhuri for calendar view */
    .legend ul {
        margin-top: 19px;
    }
    .gc-calendar table.calendar {
        margin-top: 12px !important;
    }
    /* End of Added by Madhuri for calendar view */
    .pageHeading {
        color: #1e40af;
        font-weight: 600;
        font-size: 16px; /* Modified By Madhuri.K On 26-03-2026 */
        margin: 0 0 0.25rem 0;
        /* display: flex;
        align-items: center; */
    }
    .SecHeading {
        color: #215199;
        font-weight: 500;
        font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
        margin: 0 0 0.25rem 0;
    }

    h1.page-title {
        font-size: 24px; /* Modified By Madhuri.K On 26-03-2026 */
        font-weight: 700;
        color: #0f62fe;
        margin-bottom: 18px;
    }

    .profitImg {
        width: 35px;
        height: 35px;
        color: #1e40af;
    }

    /* Modified by Gauri to make profile image smaller  */
    .profileImg {
        width: 85px;
        height: 85px;
        border-radius: 50%;
        margin-left: auto;
    }

    /* header row */
    .project-header {
        /* background: #ffffff;
        border-radius: 6px 6px 0 0;
        /* border: 1px solid #e0e3ee; */
        padding: 4px 0 0;
        margin-bottom: 0; 
        /* background: #e7edf0; */
    }

    .project-header .small {
        font-size: 11px;
    }

    @media (min-width: 768px) {
        .GFI_IMG {
            max-width: 60% !important;
        }
    }

    @media (max-width: 768px) {

        /* You can add additional styles if needed for mobile */
        .carousel-inner {
            height: 175px;
        }

        .iconCards {
            cursor: pointer;
        }

        .mob_profileInfo {
            display: flex;
            flex-wrap: wrap;
            align-content: space-around;
        }

        .GFI_IMG {
            max-width: 65% !important;
        }
    }

    @media (min-width: 320px) {
        .GFI_IMG {
            max-width: 25% !important;
        }
    }

    @media (min-width: 425px) {
        .GFI_IMG {
            max-width: 25% !important;
        }
    }

    @media (max-width: 768px) {
        .pageHeading {
            font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .smallTxt {
            font-size: 10px;
        }

    }

    @media (max-width: 480px) {
        .mob_profileInfo {
            display: flex;
            flex-wrap: wrap;
            align-content: space-around;
        }
    }

    /* Status Dropdown css starts */
    .statusColors .dropdown-menu li a span.text {
        /* display: inline-block; */
        /* margin: auto; */
        display: flex !important;
        align-items: center;
    }

    .statusColors .filter-option-inner-inner {
        display: flex;
        align-items: center;
    }

    .statusDiv {
        align-items: center;
        width: 120px;
        text-align: left;
        margin: auto;
    }

    .statusDiv label {
        font-size: 12px;
    }

    .statusBox {
        display: inline-block;
        border-radius: 50%;
        min-width: 8px;
        height: 8px;
    }
    .statusApproved {
        /* background-color: #c8ff00; */
        background-color: #5fd96f;
    }
    .statusRejected {
        background-color: #dd4b39;
    }

    .statusSubmitted {
        background-color: #00c0ef;
    }
    /* Status Dropdown css starts */

    .table thead tr th,
    .table tbody tr td {
        text-align: center;
    }

    .table thead tr:hover th,
    .table tbody tr:hover td {
        color: #122b95;
        font-weight: 500;
    }

    .text_red {
        color: #ef343b !important;
    }

    .txt_Blue {
        color: #133ea1 !important;
    }

    a:hover,
    a:focus {
        text-decoration: none;
    }

    .text_red {
        color: #ef343b !important;
    }

    .txt_Blue {
        color: #133ea1 !important;
    }
    .text_red {
        color: #ef343b !important;
    }
    .txt_Blue {
        color: #3b4f99;
    }
    .mandatoryTxt {
        color: #f00;
    }
    .greyTxt {
        color: #414042;
    }

    .bgGreen {
        background-color: #52c273;
    }

    .bgYellow {
        background-color: #f6c000;
    }

    .orangeBg {
        background-color: #F08000;
    }
    
    /* .graybg {
        background-color: #E7EDF0;
    } */

    .btnyellow {
        /* background-color: #fbce3a; */
        /* background-color: #fbaa16; */
        background-color: #f39d00;
        color: #fff;
    }

    .btnyellow:hover {
        /* background-color: #fbce3a; */
        /* background-color: #fbaa16; */
        background-color: #f39d00;
        color: #FFF;
    }

    .calendarContent .legend{
        position: absolute;
        z-index: 1;
        right: 0;
    }

    .NotificationsContent::-webkit-scrollbar-track,
    .tasksContent::-webkit-scrollbar-track {
        /* -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        border-radius: 10px; */
        background-color: #F5F5F5;
    }

    .NotificationsContent::-webkit-scrollbar,
    .tasksContent::-webkit-scrollbar {
        width: 5px;
        background-color: #F5F5F5;
    }

    .NotificationsContent::-webkit-scrollbar-thumb,
    .tasksContent::-webkit-scrollbar-thumb {
        border-radius: 5px;
        /* -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3); */
        background-color: #eee;
    }
    .gc-calendar .gc-calendar-header .gc-calendar-month-year {
        margin-left: 0px;
    }
    .timeReportContent {
        width: 190px;
    }
    .noteDiv {
        background: #fff8e6;
        border: 1px solid #facc6b;
        border-radius: 8px;
        padding: 2px 14px;
        font-size: 12px;
        color: #374151;
        display: inline-block;
    }

    .detail-offcanvas .offcanvas-header {
            background: #ffffff;
            box-shadow: 0 1px 0 #e5e7eb;
        }

        .detail-offcanvas .offcanvas-title {
            font-size: 16px;
        }

        /* Close pill button */
        .detail-offcanvas .btn.btn-light {
            font-size: 13px;
        }
        .topLabel span {
            font-size: 13px;
        }
        .fw-500 {
            font-weight: 500;
        }

        .font-weight-600 {
            font-weight: 600;
        }
        .table {
            --bs-table-striped-bg: #f7f7f7;
        }
        .offcanvas-85 {
            --bs-offcanvas-width: 85%;
        }
        .event a{
            background-image: none;
        }

    /* Added by Gauri - Fullscreen loader overlay for this page */
        .loader-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 100%;
            height: 100%;
            background-color: transparent;
            z-index: 2000;
        }
    
        /* Centered loader GIF inside overlay */
        .loader-overlay .loader {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        }
    
        /* Added by Gauri - Initial page-load preloader (center GIF before JS runs) */
        .preloader {
            position: fixed;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
            z-index: 2100;
            /* above overlay so GIF is visible even before JS initializes */
        }

        /* ====== CALENDAR GREEN HIGHLIGHTING FIX ====== */
        /* Added by Madhuri - isGreen=1: JS applies background directly to the TD after render */
        /* The gc-calendar plugin puts className on an inner element, NOT the <td>,
           so we use applyCalendarGreenBg() in JS to walk up to the <td> and set inline style. */

        /* Green stripe background applied by JS directly on the <td> */
        td.ts-green-td {
            /* background: linear-gradient(228deg, #d6f5e5 25%, #a8e6c1 25%, #a8e6c1 50%, #d6f5e5 50%, #d6f5e5 75%, #a8e6c1 75%) !important; */
            background-color: #a6ffce;
            background-size: 5px 6px !important;
        }

        /* Day number circle on green days */
        .gc-calendar .tsGreen .day-number,
        .gc-calendar .day.tsGreen .day-number,
        .gc-calendar td .tsGreen .day-number,
        td.ts-green-td .day-number {
            /* background: linear-gradient(135deg, #34c97a 0%, #27ae60 100%) !important; */
            color: #27ae60  !important;
            font-weight: bold;
            border-radius: 50%;
            /* width: 30px; */
            /* height: 30px; */
            display: inline-flex;
            align-items: center;
            justify-content: center;
            /* box-shadow: 0 2px 6px rgba(39, 174, 96, 0.35); */
        }

        /* Holiday styling */
        .gc-calendar .holiday .day-number,
        .gc-calendar .day.holiday .day-number,
        .gc-calendar td.holiday .day-number {
            background-color: #00c0ef !important;
            color: white !important;
            font-weight: bold;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        /* Current day highlight */
        .gc-calendar .today {
            background-color: #fde8aa !important;
            background-image: none !important;
        }

        /* Ensure event class applies to table cells */
        .gc-calendar td.event {
            position: relative;
        }

        div[role="progressbar"] {
            /* all: unset !important; */
            display: block !important;
            width: 100% !important;
            height: auto !important;
            /* background: none !important; */
            background: none;
            border-radius: 20px !important;
            animation: none !important;
            /* --fg: #369; */
            --bg: #def;
            place-items: flex-start;
            --pgPercentage: unset;
            background-color: #e9ecef; /* grey track */
        }

        div[role="progressbar"]::before{
            counter-reset: percentage var(--value);
            content: "";
        }

        .progress > div {
            height: 10px;
            border-radius: 18px;
        }
        .progress, .progress>.progress-bar, .progress .progress-bar, .progress>.progress-bar .progress-bar {
            border-radius: 7px;
        }
        div[role="progressbar"][aria-valuenow]::before{
            content: "";
        }
        .dropdown-menu, .dropdown-menu .inner {
            min-height: 1px !important;
            max-width: 100%;
        }

        /* ====== LEGEND STYLES ====== */
        /* Legend item base style */
        .legend ul li span {
            display: inline-block;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            margin: 0 8px;
            cursor: pointer;
            
        }

        /* Holiday legend - Blue */
        .lgdHoliday {
            /* background-color: #00c0ef !important; */
            background-color: yellow !important;
            background-image: none;
        }

        /* Today legend - Yellow/Gold */
        .lgdPlannedday {
            background-color: #ffde97 !important;
            background-image: none;
        }
        .today {
            background-image: none;
        }

        /* Weekend legend - You can customize this color */
        .lgdPH {
            background-color: #cccccc !important;
        }

        /* NEW - Reported Efforts legend - Gradient matching calendar */
        .lgdReportedEfforts {
            /* background: linear-gradient(135deg, #77e0b6 0%, #5fd96f 100%) !important; */
            box-shadow: 0 2px 4px rgba(119, 224, 182, 0.3);
            background-image: none;
        }
        /* End of Added by Madhuri for calendar view */
    </style>

</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
    <div id="OverviewSec" class="preloader"></div>

    <!-- Page Loader - Show immediately -->
    <div class="loader-overlay" id="loaderOverlay" style="display: none;">
        <div class="loader"></div>
    </div>

    <%--commented by Aditya J. on 23-02-2026 for removing role access from landing page--%>
    <!--  Added By Gauri on 17 Feb 2026 for the Role Access -->
    <%--<%If m_blnViewAccess = True Then%>--%>
    <!--End of Added By Gauri on 17 Feb 2026 for the Role Access -->
    <%--End of commented by Aditya J. on 23-02-2026 for removing role access from landing page--%>

    <div class="page-wrapper" id="OverviewWrapper" style="display:none;">
        <div class="graybg project-header d-flex flex-wrap align-items-center justify-content-between gap-2">
                <div style="margin-left: 0;">
                    <h2 class="pageHeading">
                        <img src="../../../Whizible2.0-new/dist/img/OverviewDashboard.png" class="profitImg me-2" />
                        <%=MyBase.GetResourceString("C_Oview")%>
                    </h2>
                </div>
        </div>

        <section id="content-wrapper" class="content_wrapper">
            <div class="TabsSec">
                <div class="profileSec">
                    <!-- Desktop view start here comment -->
                    <div class="container-fluid px-3">
                        <div class="row main_header_02">
                            <!-- Profile Image start here -->
                            <div class="col-5 col-sm-1 col-md-1 ps-0 pe-0">
                                <!-- Modified by Gauri on 20 Feb 2025 -->
                                <div class="profImgSec mt-4 d-flex justify-content-center">
                                    <!-- <img src="../../../Whizible2.0-new/dist/img/blankprofile.png" alt="" -->
                                    <!-- <img src="http://192.168.2.116/WhizDev26/Images/Photo/8513d623.png" alt="" -->
                                    <img class="profileImg img-fluid" id="OverviewProfileImage">
                                </div>
                            </div>
                            <!-- Modified by Madhuri.K on 26-03-2026 -->
                            <div class="col-12 col-sm-4 col-md-4 ps-0 pe-0">
                                <div class="profileInfo">
                                    <div class="profileName mb-2">
                                        <span class="SecHeading"><%=MyBase.GetResourceString("C_Wlcm")%>, </span>
                                        <span id="OverviewEmpName" class="SecHeading"></span>
                                    </div>
                                    <!-- Commented By Madhuri.K on 23-02-2026 -->
                                    <div class="mb-3">
                                        <!-- <img src="../../../Whizible2.0-new/dist/img/profile-pic.jpg" id="OverviewEmpImage"
                                            alt="" class="smallImg"> -->
                                        <span id="OverviewEmpRole" class="smallTxt"></span>
                                    </div>
                                    <div class="profileContent row">
                                        <span class="col-12 col-sm-12"><%=MyBase.GetResourceString("C_HaveWonderfulDay")%>
                                        </span>
                                    </div>
                                </div>

                                <!-- Desktop View section start here -->
                                <!-- <div class="IconsSection mt-2 d-lg-block d-none"> -->
                                <div class="IconsSection mt-2">
                                    <div class="row greyTxt">
                                        <div class="col-sm-4 col-4">
                                            <div class="iconCards" id="MyProjectIcon" data-bs-toggle="offcanvas"
                                                data-bs-target="#MyProjectsOffcanvas">
                                                <div class="IconCardImg"><img
                                                        src="../../../Whizible2.0-new/dist/img/Project-icon.svg"
                                                        alt=""></div>
                                                <div class="IconCardTxt text-center mt-2" style="color: #1e40af;"> <%=MyBase.GetResourceString("C_Projs")%></style=></div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 col-4">
                                            <div class="iconCards" id="MyTasksIcon" data-bs-toggle="offcanvas"
                                                data-bs-target="#MyTasksOffcanvas">
                                                <div class="IconCardImg"><i class="far fa-file-alt"></i></div>
                                                <div class="IconCardTxt text-center mt-2" style="color: #1e40af;"> <%=MyBase.GetResourceString("C_Tasks")%></style=></div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 col-4">
                                            <div class="iconCards" id="MyTimesheetIcon" data-bs-toggle="offcanvas"
                                                data-bs-target="#MyTimesheetOffcanvas">
                                                <div class="IconCardImg"><i class="fas fa-tasks"></i></div>
                                                <div class="IconCardTxt text-center mt-2" style="color: #1e40af;"> <%=MyBase.GetResourceString("C_TSheets")%></style=></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Desktop View section end here -->
                            </div>
                            <div class="col-12 col-sm-4 col-md-4 ps-0 pe-0">
                                <div id="carouselAlertIndicators" class="carousel slide"
                                    data-bs-ride="carousel">
                                    <div class="carousel-inner"> </div>
                                    <div class="carousel-indicators mt-0">
                                        <button type="button"
                                            data-bs-target="#carouselAlertIndicators"
                                            data-bs-slide-to="0" class="active" aria-current="true"
                                            aria-label="Slide 1"></button>
                                        <button type="button"
                                            data-bs-target="#carouselAlertIndicators"
                                            data-bs-slide-to="1" aria-label="Slide 2"></button>
                                        <button type="button"
                                            data-bs-target="#carouselAlertIndicators"
                                            data-bs-slide-to="2" aria-label="Slide 3"></button>
                                        <button type="button"
                                            data-bs-target="#carouselAlertIndicators"
                                            data-bs-slide-to="3" aria-label="Slide 4"></button>
                                        <button type="button"
                                            data-bs-target="#carouselAlertIndicators"
                                            data-bs-slide-to="4" aria-label="Slide 5"></button>
                                    </div>
                                </div>
                            </div>
                             <!-- Modified by Madhuri.K on 26-03-2026 -->
                            <!-- Modified by Gauri on 20 Feb 2025 -->
                            
                            <!-- Profile Image end here -->

                            <!-- Notification section start here -->
                            <div class="col-12 col-sm-4 col-md-3">
                                <div class="NotificationsSec" id="NeedAttentionSec">
                                    <div class="secTitle mb-2"><%=MyBase.GetResourceString("C_NeedAttention")%></div>
                                    <div class="NotificationsContent"></div>
                                </div>
                            </div>
                            <!-- Notification section end here -->
                        </div>
                    </div>
                    <!-- Desktop view end here comment -->

                    <div class="container-fluid mt-3">
                        <!-- Current Tasks section start here -->
                        <div class="TasksSection">
                            <div class="row">
                                <div class="col-sm-6 col-12 col-md-5 col-lg-3">
                                    <div class="currentTaskSec flex-1">
                                        <div class="secTitle"><%=MyBase.GetResourceString("C_CurrTasks")%></div>

                                        <div class="tasksContent" id="CurrTasksContent">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-12 col-sm-6 col-lg-6 col-md-7 ps-0 pe-1 ">
                                    <div class="myReportSection flex-1 pe-0 ">
                                        <div class="d-flex justify-content-between px-3">
                                            <div class="reportTitle mt-2"><%=MyBase.GetResourceString("C_MyUtlztion")%></div>

                                            <div class="monthSelectpicker d-flex mt-2">
                                                <select class="selectpicker" data-live-search="true" id="weekSelect"> </select>                                                
                                            </div>
                                        </div>

                                        <div class="row mt-5">
                                            <div class="col-12 col-sm-12 col-md-12 col-lg-5">
                                                <div class="reportGraphSection">
                                                    <div class="circular_progressbar" aria-valuenow="60"
                                                        aria-valuemin="0" aria-valuemax="100" style="--value:60"></div>
                                                    <!-- <div class="weekNoChart">Week 1</div> -->
                                                </div>
                                            </div>
                                            <div id="MyTimesheetReportSec"
                                                class="col-sm-12 col-12 col-md-12 col-lg-7 d-flex flex-column justify-content-center gap-4">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-3 col-md-12">
                                    <div class="calendarSec flex-1">
                                        <div class="secTitle"><%=MyBase.GetResourceString("C_MyTimeline")%></div>

                                        <div class="calendarContent position-relative">
                                            <!-- <div class="legend"></div> -->
                                            <div class="legend">
                                                <ul class="d-flex justify-content-end list-unstyled">
                                                    <!-- <li><label class="mx-1"><%=MyBase.GetResourceString("C_Legends")%> :</label></li> -->
                                                    <li class="pt-1"><span class="lgdHoliday" data-bs-toggle="tooltip"
                                                            title="Holiday"></span></li>
                                                    <li class="pt-1"><span class="lgdPlannedday"
                                                            data-bs-toggle="tooltip" title="Today"></span>
                                                    </li>
                                                    <!-- <li class="pt-1"><span class="lgdPH" data-bs-toggle="tooltip"
                                                            data-bs-container="body" aria-label="Weekend"
                                                            data-bs-original-title="Weekend"></span></li> -->
                                                    <li class="pt-1"><span class="lgdReportedEfforts" data-bs-toggle="tooltip"
                                                            title="Reported Efforts"></span></li>
                                                </ul>
                                            </div>
                                            <div id="monthly_calendar" class="w-100"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Current Tasks section end here -->
                    </div>
                </div>
            </div>
        </section>

        <!-- My Projects Details Offcanvas screen start here -->
        <div class="offcanvas detail-offcanvas offcanvas-85 offcanvas-end" data-bs-scroll="false" tabindex="-1" id="MyProjectsOffcanvas">
            <div class="offcanvas-body">
                <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                    <div class="row flex-grow-1">
                        <div class="col-sm-10">
                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_MyProjDetls")%></h5>
                        </div>
                        <div class="col-sm-2 text-end">
                            <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                                data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="noteDiv mt-2">
                    <div class="snapshot-note-header d-flex-align-items-center mb-1">
                        <i class="fa fa-exclamation-triangle me-1" style="color: #f59e0b;"></i>
                        <span class="font-weight-600"> <%=MyBase.GetResourceString("C_Note")%> : </span>
                        <span> <%=MyBase.GetResourceString("C_MyProjDetlsNote")%> </span>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="row px-2">
                        <table class="table table-hover table-striped myProjectTbl mt-3" width="100%"
                            id="MyProjectsDetlsTbl">
                            <thead>
                                <tr>
                                    <th class="col-sm-3 text-start"><%=MyBase.GetResourceString("C_ProjName")%></th>
                                    <th><%=MyBase.GetResourceString("C_Status")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_StDate")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_EndDate")%></th>
                                    <th><%=MyBase.GetResourceString("C_ProjDuration")%></th>
                                    <th><%=MyBase.GetResourceString("C_AllctnPercentage")%></th>
                                    <th><%=MyBase.GetResourceString("C_TPlanEfforts")%></th>
                                    <th><%=MyBase.GetResourceString("C_ActWorkHrs")%></th>
                                    <th><%=MyBase.GetResourceString("C_BillHrs")%></th>
                                    <th><%=MyBase.GetResourceString("C_NonBillHrs")%></th>
                                </tr>
                            </thead>
                            <tbody id="MyProjectsDetlsTblBody"></tbody>
                        </table>
                    </div>

                    <div class="cstm_pagination mt-2" id="paginationControlsProjects">
                        <div class="d-flex justify-content-end w-100">
                            <div class="buttons" style="display:flex; align-items:center; gap:10px;">
                            <!-- <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span> -->
                            <span class="spntotal">Total Records: </span>
                            <span class="spntotal" id="TotalRecordsProjects"></span>

                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end" style="margin:0px!important">
                                <li class="page-item" id="btnPreviousProjects">
                                    <a class="page-link" aria-label="Previous" onclick="PrevProjectsList()" id="LinkPreviousProjects">
                                    <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </li>

                                <li class="page-item" id="btnNextProjects">
                                    <a class="page-link" aria-label="Next" onclick="NextProjectsList()" id="LinkNextProjects">
                                    <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </li>
                                </ul>
                            </nav>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- My Projects Details Offcanvas screen end here -->

        <!-- My Timesheet Details Offcanvas screen start here -->
        <div class="offcanvas detail-offcanvas offcanvas-85 offcanvas-end" data-bs-scroll="false" tabindex="-1"
            id="MyTimesheetOffcanvas">
            <div class="offcanvas-body">
                <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                    <div class="row flex-grow-1">
                        <div class="col-sm-10">
                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_MyTS_Dtls")%></h5>
                        </div>
                        <div class="col-sm-2 text-end">
                            <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                                data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="container-fluid pt-3">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="row">
                                <label class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_Status")%></label>
                                <div class="col-sm-6 Status_TS_Div">
                                    <select class="selectpicker statusColors" id="Status_TS_Input">
                                        <option><%=MyBase.GetResourceString("C_SelStatus")%></option>
                                        <option value="V"
                                            data-content="<span class='statusBox statusApproved mx-2'>&nbsp;</span> Approved">
                                        </option>
                                        <option value="J"
                                            data-content="<span class='statusBox statusRejected mx-2'>&nbsp;</span> Rejected">
                                        </option>
                                        <option value="R"
                                            data-content="<span class='statusBox statusSubmitted mx-2'>&nbsp;</span> Submitted">
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row px-2">
                        <table class="table table-hover table-striped myTimesheetTbl mt-3" width="100%"
                            id="MyTimesheetDetlsTbl">
                            <thead>
                                <tr>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_SubmDate")%></th>
                                    <th class="col-sm-3"><%=MyBase.GetResourceString("C_Time")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_ActWorkHrs")%></th>
                                    <th class="col-sm-3"><%=MyBase.GetResourceString("C_Status")%></th>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_ApproveRejectComment")%></th>
                                </tr>
                            </thead>
                            <tbody id="MyTimesheetDetlsTblBody">
                            </tbody>
                        </table>
                    </div>

                    <div class="cstm_pagination mt-2" id="paginationControlsTimesheet">
                        <div class="d-flex justify-content-end w-100">
                            <div class="buttons" style="display:flex; align-items:center; gap:10px;">
                            <!-- <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span> -->
                            <span class="spntotal">Total Records: </span>
                            <span class="spntotal" id="TotalRecordsTimesheet"></span>

                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end" style="margin:0px!important">
                                <li class="page-item" id="btnPreviousTimesheet">
                                    <a class="page-link" aria-label="Previous" onclick="PrevTimesheetList()" id="LinkPreviousTimesheet">
                                    <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </li>

                                <li class="page-item" id="btnNextTimesheet">
                                    <a class="page-link" aria-label="Next" onclick="NextTimesheetList()" id="LinkNextTimesheet">
                                    <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </li>
                                </ul>
                            </nav>
                            </div>
                        </div>
                        </div>

                </div>
            </div>
        </div>
        <!-- My Timesheet Details Offcanvas screen end here -->

        <!-- My Tasks Details Offcanvas screen start here -->
        <div class="offcanvas detail-offcanvas offcanvas-85 offcanvas-end" data-bs-scroll="false" tabindex="-1" id="MyTasksOffcanvas">
            <div class="offcanvas-body">
                <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                    <div class="row flex-grow-1">
                        <div class="col-sm-10">
                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_MyTasksDtls")%></h5>
                        </div>
                        <div class="col-sm-2 text-end">
                            <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                                data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="row px-2">
                        <table class="table table-hover table-striped myTasksTbl mt-3" width="100%"
                            id="MyTasksDetlsTbl">
                            <thead>
                                <tr>
                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_TaskName")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_ProjName")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_StDate")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_EndDate")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_BaselineStartDate")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_BaselineEndDate")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_ActStartDate")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_ActEndDate")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_WorkHrs")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_ActWorkHrs")%></th>
                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_Status")%></th>
                                </tr>
                            </thead>
                            <tbody id="MyTasksDetlsTblBody"></tbody>
                        </table>
                    </div>

                    <!-- Task Pagination -->
                    <div class="cstm_pagination mt-2" id="paginationControlsTasks">
                        <div class="d-flex justify-content-end w-100">
                            <div class="buttons" style="display:flex; align-items:center; gap:10px;">
                            <!-- <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span> -->
                            <span class="spntotal">Total Records: </span>
                            <span class="spntotal" id="TotalRecordsTasks"></span>

                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end" style="margin:0px!important">
                                <li class="page-item" id="btnPreviousTasks">
                                    <a class="page-link" aria-label="Previous" onclick="PrevTasksList()" id="LinkPreviousTasks">
                                    <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </li>

                                <li class="page-item" id="btnNextTasks">
                                    <a class="page-link" aria-label="Next" onclick="NextTasksList()" id="LinkNextTasks">
                                    <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </li>
                                </ul>
                            </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- My Tasks Details Offcanvas screen end here -->

        <!-- Timesheet Entry Offcanvas screen start here -->
        <div class="offcanvas offcanvas-70 offcanvas-end " data-bs-scroll="false" tabindex="-1" id="TS_EntryOffcanvas">
            <div class="offcanvas-body">
                <div class="graybg container-fluid py-1 mb-2">
                    <div class="row">
                        <div class="col-sm-6 col-10">
                            <h5 class="pgtitle mb-0"><%=MyBase.GetResourceString("C_TS_Entry")%></h5>
                        </div>
                        <div class="col-sm-6 col-2 text-end">
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
                                aria-label="Close"></button>
                        </div>
                    </div>
                </div>
                <div class="TS_DetailsSec">
                    <div class="row">
                        <div class="col-sm-8 col-12">
                            <div class="topLabel text-end"><%=MyBase.GetResourceString("C_OverallEffortOfDay")%> -<span class="font-weight-500"> 
                                <i class="far fa-clock"></i> <span id="ActualTS_Efforts"></span> / <span id="ExpTS_Efforts"></span> </span></div>
                        </div>
                        <div class="col-sm-4 col-12">
                            <div class="nextBtnDiv d-flex justify-content-end gap-2 pe-3">
                                <button class="btn btnyellow" id="saveTimesheetBtn" onclick="saveTimesheetButtonClick()" data-bs-toggle="tooltip"
                                    data-bs-original-title="Save"><%=MyBase.GetResourceString("C_Save")%></button>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-sm-6 col-12">
                            <div class="calendarDate ps-3"><i class="fas fa-calendar-check pe-1"></i> 
                                <!-- Modified by Gauri to bind Date and Time dynamically on 20 Feb 2025 -->
                                <span id="TS_EntryDate" class="pe-2"> </span>
                                <span id="TS_EntryDay"> </span>
                                <!-- <span class="ps-3">Monday</span> -->
                            </div>
                        </div>
                        <div class="col-sm-6 col-12 text-end">
                            <div class="pe-3">(<span class="mandatoryTxt">*</span> <%=MyBase.GetResourceString("C_Mandatory")%>)</div>
                        </div>
                    </div>
                    <div class="timesheetFields py-3">
                        <div class="row">
                            <div class="col-sm-8 col-12">
                                <div class="row mb-3">
                                    <label class="col-sm-4 col-4 text-end required mt-2"><%=MyBase.GetResourceString("C_Proj")%></label>
                                    <div class="col-sm-7 col-7">
                                        <select class="selectpicker" data-live-search="true" id="Project_TS_Select" onchange="ProjectOnChange()"> </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="col-sm-4 col-4 text-end required mt-2"><%=MyBase.GetResourceString("C_Task")%></label>
                                    <div class="col-sm-7 col-7 ">
                                        <select class="selectpicker" data-live-search="true" id="Task_TS_Select"></select>
                                    </div>
                                    <div class="col-sm-1 col-1">
                                        <!-- Modified by Gauri on 21 Feb 2025 -->
                                        <img src="../../../Whizible2.0-new/dist/img/info-circle.svg" alt="Info"
                                            id="TaskInfoIcon" class="task-info-icon mt-3"  data-bs-html="true"
                                        >
                                        <!-- data-bs-toggle="popover" data-bs-trigger="hover focus"
                                        data-bs-content="<div class='taskDetails'><div class='row'><div class='col-sm-6 col-6 text-end txt_Blue'>Start Date:</div><div class='col-sm-6 col-6'>25 Jun 2024</div></div><div class='row'><div class='col-sm-6 col-6 text-end txt_Blue'>End Date:</div><div class='col-sm-6 col-6'>05 Jul 2024</div></div><div class='row'><div class='col-sm-6 col-6 text-end txt_Blue'>Planned Effort:</div><div class='col-sm-6 col-6'>08:00</div></div><div class='row'><div class='col-sm-6 col-6 text-end txt_Blue'>Actual Effort:</div><div class='col-sm-6 col-6'>07:30</div></div></div>" -->
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="col-sm-4 col-4 text-end mt-2"><%=MyBase.GetResourceString("C_FromTime")%></label>
                                    <div class="col-sm-7 col-7 d-flex">
                                        <select class="selectpicker" data-live-search="true" id="FromTimeHr_TS_Input" disabled="true"><option value=""><%=MyBase.GetResourceString("C_Hour")%></option></select>
                                        <label class="text-end mt-2 px-2"><%=MyBase.GetResourceString("C_Hr")%></label>
                                        <select class="selectpicker" data-live-search="true" id="FromTimeMin_TS_Input" disabled="true"><option value=""><%=MyBase.GetResourceString("C_Mins")%></option></select>

                                        <label class="text-end mt-2 px-2"><%=MyBase.GetResourceString("C_Min")%></label>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="col-sm-4 col-4 text-end mt-2"><%=MyBase.GetResourceString("C_ToTime")%></label>
                                    <div class="col-sm-7 col-7 d-flex">
                                        <select class="selectpicker" data-live-search="true" id="ToTimeHr_TS_Input" disabled="true"><option value=""><%=MyBase.GetResourceString("C_Hour")%></option></select>
                                        <label class="text-end mt-2 px-2"><%=MyBase.GetResourceString("C_Hr")%></label>
                                        <select class="selectpicker" data-live-search="true" id="ToTimeMin_TS_Input" disabled="true"><option value=""><%=MyBase.GetResourceString("C_Mins")%></option></select>
                                        <label class="text-end mt-2 px-2"><%=MyBase.GetResourceString("C_Min")%></label>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="col-sm-4 col-4 text-end required mt-2"><%=MyBase.GetResourceString("C_DAType")%></label>
                                    <div class="col-sm-7 col-7">
                                        <select class="selectpicker" data-live-search="true" id="DA_Type_TS_Input"> </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="col-sm-4 col-4 text-end required mt-2"><%=MyBase.GetResourceString("C_Eff")%></label>
                                    <div class="col-sm-3 col-3">
                                        <input type="text" class="form-control text-center" id="Eff_TS_Input"
                                            data-bs-toggle="tooltip" value="00:00"
                                            title="Enter Your Effort in hh:mm format">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="col-sm-4 col-4 text-end required mt-2"><%=MyBase.GetResourceString("C_Desc")%></label>
                                    <div class="col-sm-7 col-7">
                                        <textarea class="form-control" rows="3" id="Desc_TS_Input"
                                            placeholder="Enter Description (Max 255 Characters)"
                                            maxlength="255"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Timesheet Entry Offcanvas screen end here -->

        <!--Confirmation message Modal Added By Gauri -->
        <div id="ConfirmMessagemodalinfo" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" id="btnConfirmTaskNo1" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Msg")%></h4>
                    </div>
                    <div class="modal-body">
                        <span class="sm_txt" id="ConfirmationMsg"></span>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" id="btnConfirmTaskNo"><%=MyBase.GetResourceString("C_No")%></button>
                        <button class="btn btnyellow" data-bs-toggle="modal" data-bs-dismiss="modal" id="btnConfirmTaskYes" onclick="saveTimesheetDAEntry()"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--End of Confirmation message Modal Added By Gauri -->
    </div>

    <div class="clearfix"></div>

    <%--commented by Aditya J. on 23-02-2026 for removing role access from landing page--%>
    <%--<%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_AuthAlert")%></p>
        </div>
     </div>
    <%End If %>--%>
    <%--End of commented by Aditya J. on 23-02-2026 for removing role access from landing page--%>

    <!-- REQUIRED JS SCRIPTS -->
   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.calendar.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
   <%-- <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <!-- ChartJS 1.0.1 -->
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/calendar-gc.min.js"></script>

    <script>
        // Added by Gauri on 10/02/2025
        // Global variables
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        var strUrl2 = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';

        //commented by Aditya J. on 23-02-2026
        // Added by Gauri to set project ID null if no project is in session on 19 Feb 2025
        //if (!defaultProjectID) {
        //    defaultProjectID=null;
        //}

        var defaultEmployeeID = <%= Session("intUserID") %>;        // Employee ID From session
        var defaultEmployeeName = '<%= Session("strUserName") %>';      // Employee Name From session
        var defaultRoleName = null;         
        var defaultProjectName = null;      // Project Name From session
        var selectedWeek = 0;        // Week selected in dropdown

        // Added by Gauri to set pagination items on 20 Feb 2025
        var projectsTotalItems = null;
        var tasksTotalItems = null;
        var timesheetTotalItems = null;

        var currentYear = new Date().getFullYear();
        var currentMonth = new Date().getMonth() + 1; // 1-12

        var calYear = currentYear;
        var calMonthIndex = currentMonth - 1; // 0-11


        var TimesheetState = {
            mode: null,              // "TASK" or "TIMELINE"
            taskID: 0,
            scheduleTaskID: 0,
            selectedDate: null,

            projectID: 0,
            fromTime: "",
            toTime: "",
            pendingDAEntryPayload: null,   // Store DA entry payload when user tries to save timesheet with pending DA entry, so that it can be used in confirmation modal
            skipValidation: false
        };

         $(document).on("click", function () {
             $(".tooltip").remove();
         });

        $(document).ready(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();
            alertify.set('notifier', 'position', 'top-right');

            $("#OverviewEmpName").text(defaultEmployeeName);
            $("#OverviewEmpRole").text(defaultRoleName);
            $("#TimesheetAlert").toast("show");

            var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
            var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
                return new bootstrap.Popover(popoverTriggerEl);
            });

            $(".Notification_Cross").click(function () {
                $(this).closest(".Notification_Card").remove();
            });

            $('[data-bs-toggle="popover"]').popover();

            getAlertCarouselList(defaultEmployeeID);
            getNeedAttentionList(defaultEmployeeID);
            getCurrentTasksList(defaultEmployeeID);
            // Modified by Gauri to pass Employee ID on 20 Feb 2025
            getProfileData(defaultEmployeeID);
            GetAllEmployeeList();       // Added by Gauri to get Role Name on 21 Feb 2025 

            $('.selectpicker').selectpicker();
            // 2) Bind options SECOND
            bindWeekDropdown();  // adds Select Week + Week 01..52

            // 3) Set current week THIRD (after options exist)
            selectedWeek = String(getCurrentWeek());
            $("#weekSelect").selectpicker("val", selectedWeek);
            $("#weekSelect").selectpicker("refresh");

            // 4) Initial API call
            getMyTimesheetReport(defaultEmployeeID, selectedWeek);

            // 5) Bind change event ONCE
            bindWeekChange();

            renderMonthlyCalendar(defaultEmployeeID, currentYear, currentMonth);

            $("#Status_TS_Input").selectpicker();

            $("#Status_TS_Input").selectpicker("val", "R");
            $("#Status_TS_Input").selectpicker("refresh");

            // change event
            $("#Status_TS_Input").off("changed.bs.select").on("changed.bs.select", function () {
                var statusCode = $(this).val();   // V/J/R
                currentTSPage = 1;

                if (!statusCode || statusCode === "Select Status") return;

                loadMyTimesheetDetails(defaultEmployeeID, statusCode, 1);
            });

            bindHourMinutePickers();

            // Added by Gauri - Initial page load complete: hide preloader and show main content
            $("#OverviewSec").hide();
            $("#OverviewWrapper").show();

        });

        // Enhanced AJAX helper with better error handling
        function AJAXCallWithResult(url, type, param, async) {
            var result = null;
            var fullUrl = strUrl.endsWith('/') ? strUrl + url : strUrl + '/' + url;
            
            $.ajax({
                url: fullUrl,
                type: type || "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset=utf-8",

                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    // Always add Params header for POST requests
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    // Return the complete response object to preserve pagination info
                    result = data;
                },
                error: function (xhr, status, error) {
                    if (xhr.status === 401) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%=MyBase.GetResourceString("A_AuthenticationFailed")%>', 'error', 5);
                    } else {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                    }
                }
            });

            // For synchronous calls, return the result directly
            if (!async) {
                return result;
            }

            // For asynchronous calls, return AjaxResult (legacy behavior)
            return AjaxResult;
        }

        //Added By Gauri - Loader functions
        function showLoader() {
            document.getElementById('loaderOverlay').style.display = 'block';
            loaderShown = true;
            loaderStartTime = Date.now();
        }

        function hideLoader() {
            if (!loaderShown) return;

            var elapsedTime = Date.now() - loaderStartTime;
            var minDisplayTime = 1500; // Minimum 1.5 seconds

            if (elapsedTime < minDisplayTime) {
                setTimeout(function () {
                    document.getElementById('loaderOverlay').style.display = 'none';
                    loaderShown = false;
                }, minDisplayTime - elapsedTime);
            } else {
                document.getElementById('loaderOverlay').style.display = 'none';
                loaderShown = false;
            }
        }

        // Added by Gauri - to bind dropdown value
        function bindHourMinutePickers() {
            // Build arrays like React
            var hours = Array.from({ length: 24 }, (_, i) => String(i).padStart(2, "0"));
            var minutes = Array.from({ length: 60 }, (_, i) => String(i).padStart(2, "0"));

            function fillSelect($select, placeholderText, values) {
                $select.empty();
                $select.append(`<option value="">${placeholderText}</option>`);

                values.forEach(function (v) {
                    $select.append(`<option value="${v}">${v}</option>`);
                });

                // refresh bootstrap-select UI
                $select.selectpicker("refresh");
            }

            fillSelect($("#FromTimeHr_TS_Input"), "Hour", hours);
            fillSelect($("#ToTimeHr_TS_Input"), "Hour", hours);

            fillSelect($("#FromTimeMin_TS_Input"), "Minutes", minutes);
            fillSelect($("#ToTimeMin_TS_Input"), "Minutes", minutes);
        }

        // Added by Gauri - to call API on week change
        function bindWeekChange() {
            $("#weekSelect").off("changed.bs.select");

            $("#weekSelect").on("changed.bs.select", function () {
                selectedWeek = $(this).val();

                if (selectedWeek && selectedWeek !== "0") {
                    getMyTimesheetReport(defaultEmployeeID, selectedWeek);
                }
            });
        }

        //Added by Aditya J. on 11-03-2026 for dynamic tooltip
        var weekDropdownInitialized = false;
        //End of Added by Aditya J. on 11-03-2026 for dynamic tooltip
        function bindWeekDropdown() {
            var $select = $("#weekSelect");
            $select.empty();

            $select.append(`<option value="0">Select Week</option>`);

            for (var i = 1; i <= 52; i++) {
                var weekNumber = String(i).padStart(2, "0");
                $select.append(`<option value="${i}">Week ${weekNumber}</option>`);
            }

            $select.selectpicker("refresh");

            //Added by Aditya J. on 11-03-2026 for dynamic tooltip
            var $btn = $select.closest(".bootstrap-select").find("button.dropdown-toggle");

            const existing = bootstrap.Tooltip.getInstance($btn[0]);
            if (existing) existing.dispose();

            // title as function - reads selected value dynamically every time tooltip opens
            new bootstrap.Tooltip($btn[0], {
                title: function () {
                    var selectedText = $("#weekSelect").find("option:selected").text();
                    return selectedText ? selectedText : "Select a Week";
                },
                trigger: "hover",
                delay: { show: 100, hide: 100 },
            });

            if (!weekDropdownInitialized) {
                $select.on("show.bs.select", function () {
                    const tooltipInstance = bootstrap.Tooltip.getInstance($btn[0]);
                    if (tooltipInstance) tooltipInstance.hide();
                });
                weekDropdownInitialized = true;
            }
            //End of Added by Aditya J. on 11-03-2026 for dynamic tooltip
        }

        // Added by Gauri - to get current week binded to dropdown
        function getCurrentWeek() {
            var firstDayOfYear = new Date(new Date().getFullYear(), 0, 1);
            var pastDaysOfYear = (new Date() - firstDayOfYear) / 86400000;
            return Math.ceil((pastDaysOfYear + firstDayOfYear.getDay() + 1) / 7);
        }

        /* Added by Madhuri for calendar view */
        function mapCalendarEvents(apiRows, year, monthNo) {
            // monthNo from API call is 1-12; JS Date expects 0-11
            var monthIndex = (parseInt(monthNo, 10) || 1) - 1;

            return (apiRows || []).map(function (row) {
                // var cls = "tsRed";
                // var color = "red";
                var cls = "black";
                var color = "black";

                if (row.isHoilday === 1) {
                    cls = "holiday";
                    color = "blue";
                } else if (row.isGreen === 1) {
                    cls = "tsGreen";
                    color = "green";
                     backgroundColor = "#d4edda";
                }

                return {
                    date: new Date(year, monthIndex, row.day),
                    eventName: "",          // keep empty if you just want color marking
                    className: cls,
                    dateColor: color,
                    meta: row               // keep full row for click handling
                };
            });
        }
        /* End of Added by Madhuri for calendar view */

        // Global variables for calendar

        // Added by Gauri - to bind GET API for My Timeline
        var calYear = new Date().getFullYear();
        var calMonth = new Date().getMonth() + 1; // 1-12
        var currentYear = calYear;
        var currentMonth = calMonth;
        var selectedTimelineDate = null;
        var isRenderingCalendar = false; // Prevent infinite loops

        function renderMonthlyCalendar(empID, year, monthNo) {
            isRenderingCalendar = true;
            
            // Update global state FIRST
            calYear = year;
            calMonth = monthNo;
            currentYear = year;
            currentMonth = monthNo;
            
            var url = `api/LandingDB/GetCalendarView?empID=${empID}&year=${year}&monthNo=${monthNo}`;
            var result = AJAXCallWithResult(url, "GET", null, false);

            var rows = (result && Array.isArray(result.data)) ? result.data : [];
            
            // Map API data to calendar events
            var events = rows.map(function (row) {
                var cls = "";
                var color = "inherit";

                if (row.isHoilday === 1) {
                    cls = "holiday";
                    color = "blue";
                } else if (row.isGreen === 1) {
                    cls = "tsGreen";
                    color = "green";
                 }

                return {
                    date: new Date(year, monthNo - 1, row.day), // monthNo is 1-12, JS Date needs 0-11
                    eventName: "",
                    className: cls,
                    dateColor: color,
                    meta: row
                };
            });

            // Clear calendar container completely
            $("#monthly_calendar").empty();
            
            // Store callback functions to maintain them during re-render
            var onPrevCallback = function(newDate) {
                var year = newDate.getFullYear();
                var monthNo = newDate.getMonth() + 1;
                isRenderingCalendar = false;
                renderMonthlyCalendar(defaultEmployeeID, year, monthNo);
            };
            
            var onNextCallback = function(newDate) {
                var year = newDate.getFullYear();
                var monthNo = newDate.getMonth() + 1;
                isRenderingCalendar = false;
                renderMonthlyCalendar(defaultEmployeeID, year, monthNo);
            };
            
            var onClickCallback = function (e, data) {
                var day = data?.date;
                if (!day) day = data;
                day = parseInt(day, 10);

                if (isNaN(day)) {
                    console.warn("Invalid clicked day:", data);
                    alertify.error("Unable to read selected day.");
                    return;
                }

                var clickedDate = new Date(calYear, calMonth - 1, day);
                openTimelineEntry(clickedDate);
            };

            // Initialize calendar with events and callbacks
            $("#monthly_calendar").calendarGC({
                events: events,
                onPrevMonth: onPrevCallback,
                onNextMonth: onNextCallback,
                onclickDate: onClickCallback
            });
            
            // CRITICAL FIX: Force sync the plugin's internal state with our API data
            setTimeout(function() {
                if (typeof gcObject !== 'undefined' && gcObject.pickedDate) {
                    var targetDate = new Date(year, monthNo - 1, 1);
                    
                    // Check if plugin's internal month differs from API month
                    if (gcObject.pickedDate.getFullYear() !== year || 
                        gcObject.pickedDate.getMonth() !== (monthNo - 1)) {
                        
                        // Update plugin's internal picked date
                        gcObject.pickedDate = targetDate;
                        gcObject.options.events = events;
                        
                        // Re-attach callbacks to prevent loss
                        gcObject.options.onPrevMonth = onPrevCallback;
                        gcObject.options.onNextMonth = onNextCallback;
                        gcObject.options.onclickDate = onClickCallback;
                        
                        // Force re-render with correct date
                        gcObject.render();
                    } 
                }
                
                isRenderingCalendar = false;

                // GREEN TD BACKGROUND FIX:
                // gc-calendar puts className on an inner <a>/<div>, NOT on <td> itself.
                // So CSS "td.tsGreen" never matches. Walk up from .tsGreen to the <td>
                // and apply the striped green background directly as an inline style.
                applyCalendarGreenBg();

                console.log("Calendar rendering complete");
            }, 50);
        }

        // Added by Madhuri - Apply green striped background directly on the <td>
        // after gc-calendar renders. The plugin puts className on an inner element,
        // NOT on the <td>, so pure CSS targeting "td.tsGreen" never works.
        function applyCalendarGreenBg() {
            // Clear any previously applied green TDs (for month navigation re-renders)
            $("#monthly_calendar td.ts-green-td").each(function () {
                $(this).removeClass("ts-green-td");
                $(this).css("background", "");
                $(this).css("background-size", "");
            });

            // Find every element that has the tsGreen class inside the calendar
            $("#monthly_calendar .tsGreen").each(function () {
                // Walk up the DOM to the nearest <td>
                var $td = $(this).closest("td");
                if ($td.length) {
                    // Apply striped green background directly on the TD
                    $td.css({
                        // "background": "repeating-linear-gradient(" +
                        //     "135deg," +
                        //     "#d6f5e5 0px, #d6f5e5 5px," +
                        //     "#a8e6c1 5px, #a8e6c1 10px" +
                        //     ")",
                        "background-color": "#a6ffce",
                        "background-size": "14px 14px"
                    });
                    $td.addClass("ts-green-td");
                }
            });
        }

        // Added by Gauri - helper function to get alert UI config based on type of alert on 10 Feb 2025
        function getAlertUIConfig(typeDec) {
            const type = (typeDec || "").toLowerCase();

            if (type.includes("birthday")) {
                return {
                    badgeClass: "bdayBadge",
                    badgeText: "Birthday",
                    img: "../../../Whizible2.0-new/dist/img/birthdaygirl-happybirthday.gif"
                };
            }

            if (type.includes("timesheet")) {
                return {
                    badgeClass: "AlertBadge",
                    badgeText: "Timesheet Alert",
                    img: "../../../Whizible2.0-new/dist/img/timesheet_alert.png"
                };
            }

            if (type.includes("task")) {
                return {
                    badgeClass: "SuccessBadge",
                    badgeText: "New Task Assigned",
                    img: "../../../Whizible2.0-new/dist/img/task_new.jpg"
                };
            }

            if (type.includes("approval")) {
                return {
                    badgeClass: "AlertBadge",
                    badgeText: "Approval Pending",
                    img: "../../../Whizible2.0-new/dist/img/approval_pending.png"
                };
            }

            if (type.includes("project")) {
                return {
                    badgeClass: "SuccessBadge",
                    badgeText: "New Project Assigned",
                    img: "../../../Whizible2.0-new/dist/img/project_new.jpg"
                };
            }

            return {
                badgeClass: "AlertBadge",
                badgeText: "Notification",
                img: "../../../Whizible2.0-new/dist/img/approval_pending.png"
            };
        }

        // Added by Gauri - Get Alert Carousel List API call and render function on 10 Feb 2025
        function getAlertCarouselList(empID) {
            var url = "api/LandingDB/GetMessage?empID=" + empID;
            var result = AJAXCallWithResult(url, "GET", null, false);

            var $carouselInner = $("#carouselAlertIndicators .carousel-inner");
            var $indicators = $("#carouselAlertIndicators .carousel-indicators");

            $carouselInner.empty();
            $indicators.empty();

            if (!result || !Array.isArray(result.data) || result.data.length === 0) {
                $carouselInner.append(`
                    <div class="carousel-item active">
                        <div class="card bdayCard">
                            <div class="card-body text-center p-4">
                                <span class="text-muted">No alerts available</span>
                            </div>
                        </div>
                    </div>
                `);
                return;
            }

            result.data.forEach(function (item, index) {
                var ui = getAlertUIConfig(item.typeDec);
                var isActive = index === 0 ? "active" : "";

                // Slide
                var slideHtml = `
                    <div class="carousel-item ${isActive}">
                        <div class="card bdayCard">
                            <div class="card-body px-0">
                                <div class="bdayContent p-2">
                                    <div class="row">
                                        <div class="col-6 col-sm-4 pe-0">
                                            <div class="text-start">
                                                <img src="${ui.img}" class="GIF_Img mx-auto img-fluid">
                                            </div>
                                        </div>
                                        <div class="col-6 col-sm-8">
                                            <span class="badge ${ui.badgeClass} mb-2">
                                                ${ui.badgeText}
                                            </span>
                                            <div>
                                                <span class="carouselTxt">
                                                    "${item.content}"
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                `;

                // Indicator
                var indicatorHtml = `
                    <button type="button"
                        data-bs-target="#carouselAlertIndicators"
                        data-bs-slide-to="${index}"
                        class="${isActive}"
                        ${isActive ? 'aria-current="true"' : ""}
                        aria-label="Slide ${index + 1}">
                    </button>
                `;

                $carouselInner.append(slideHtml);
                $indicators.append(indicatorHtml);
            });
        }

        // Added by Gauri - helper function to get attention icon class based on type of alert on 10 Feb 2025
        function getAttentionIcon(iconName) {
            switch (iconName) {
                case "Bell":
                    return "fas fa-bell";
                case "Flag":
                    return "fas fa-flag";
                case "Comment":
                    return "fas fa-comments";
                default:
                    return "fas fa-info-circle";
            }
        }

        // Added by Gauri - to remove alerts div on cross icon click 
        function removeAttentionItem(el) {
            $(el).closest(".Notification_Card").fadeOut(200, function () {
                $(this).remove();
            });
        }

        // Added by Gauri - Get My Projects API call and render function on 10 Feb 2025
        $("#MyProjectIcon").on("click", function () {
            // Added by Gauri to fix pagination issue on 20 Feb 2025
            var CurrentPage = 1;
            loadProjectDetailsLists(CurrentPage);
        });

        // Added by Gauri to fix pagination issue on 20 Feb 2025
        function loadProjectDetailsLists(CurrentPage){
            // var pageNo = 1; 
            var url = `api/LandingDB/GetProject?empID=${defaultEmployeeID}&PageNo=${CurrentPage}`;
            var result = AJAXCallWithResult(url, "GET", null, false);

            // Added by Gauri to store pagination items on 20 Feb 2025
            if (result && result.data && result.data.length > 0) {
                projectsTotalItems = result.data[0].totalCount || result.data.length;
            } else {
                projectsTotalItems = 0;
            }

            var $tbody = $("#MyProjectsDetlsTblBody");
            $tbody.empty();

            if (!result || !Array.isArray(result.data) || result.data.length === 0) {
                $tbody.append(`
                    <tr>
                        <td colspan="10" class="text-center text-muted">
                            No projects found
                        </td>
                    </tr>
                `);
                return;
            }

            // ---------- Status badge mapping ----------
            function getStatusBadge(status) {
                switch ((status || "").toLowerCase()) {
                    case "initiated" || "initiated'":
                        return `<span class="badge bg-info">Initiated</span>`;
                    case "started":
                        return `<span class="badge bg-primary">Started</span>`;
                    case "in progress":
                        return `<span class="badge bg-warning">In Progress</span>`;
                    case "closed":
                        return `<span class="badge bg-success">Closed</span>`;
                    default:
                        return `<span class="badge bg-secondary">${status === null ? "N/A" : status}</span>`;
                }
            }

            result.data.forEach(function (item) {
                var rowHtml = `
                    <tr class="Project-item" data-projectid="${item.projectID}">
                        <td class="text-start">
                            ${item.projectName || "N/A"}
                        </td>
                        <td>
                            ${getStatusBadge(item.status) || "N/A"}
                        </td>
                        <td>
                            ${formatDateDDMMMYYYY(item.startDate) || "N/A"}
                        </td>
                        <td>
                            ${formatDateDDMMMYYYY(item.endDate) || "N/A"}
                        </td>
                        <td>
                            ${item.projectDuration ?? "N/A"}
                        </td>
                        <td>
                            ${item.allPecentage || "N/A"}
                        </td>
                        <td>
                            ${item.tPeffort || "N/A"}
                        </td>
                        <td>
                            ${item.aworkH || "N/A"}
                        </td>
                        <td>
                            ${item.billableH || "N/A"}
                        </td>
                        <td>
                            ${item.nonBillableHours || "N/A"}
                        </td>
                    </tr>
                `;

                $tbody.append(rowHtml);
            });

            initProjectsPagination();
        }

        // Added by Gauri to change date format on 20 Feb 2025
        function formatDateSafe(dateStr) {
            if (!dateStr) return "";   // handles null, undefined, ""
            
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return "";

            return d.toLocaleDateString('en-GB', {
                day: '2-digit',
                month: 'short',
                year: 'numeric'
            });
        }

        // Added by Gauri - Get My Tasks API call and render function on 10 Feb 2025
        $("#MyTasksIcon").on("click", function () {
            var CurrentPage = 1;
            loadTaskDetailsList(CurrentPage);
        });

        // Modified by Gauri for pagination issue on 20 Feb 2025
        function loadTaskDetailsList(CurrentPage){
            var pageNo = 1;
            var url = `api/LandingDB/GetMyTasks?empID=${defaultEmployeeID}&PageNo=${CurrentPage}`;
            var result = AJAXCallWithResult(url, "GET", null, false);

            if (result && result.data && result.data.length > 0) {
                tasksTotalItems = result.data[0].totalCount || result.data.length;
            } else {
                tasksTotalItems = 0;
            }

            var $tbody = $("#MyTasksDetlsTblBody");
            $tbody.empty();

            if (!result || !Array.isArray(result.data) || result.data.length === 0) {
                $tbody.append(`
                    <tr>
                        <td colspan="11" class="text-center text-muted">
                            No tasks found
                        </td>
                    </tr>
                `);
                return;
            }

            // ---------- Status mapping ----------
            function getStatusUI(status, isDelayed) {
                var stageClass = "stageDraft";
                var label = status || "NA";

                switch ((status || "").toLowerCase()) {
                    case "open":
                        stageClass = "stageDraft";
                        break;
                    case "in progress":
                        stageClass = "stageInProgress";
                        break;
                    case "completed":
                        stageClass = "stageCompleted";
                        break;
                    case "on hold":
                        stageClass = "stageHold";
                        break;
                }

                // delayed task indicator
                if (isDelayed === 1) {
                    stageClass += " stageDelayed";
                }

                return `
                    <div class="statusDiv d-flex justify-content-center">
                        <span class="statusBox ${stageClass} mx-2"></span>
                        <label data-bs-toggle="tooltip" title="${label}">
                            ${label}
                        </label>
                    </div>
                `;
            }

            // ---------- Row Binding ----------
            result.data.forEach(function (item) {

                // Modified by Gauri to store pagination items on 20 Feb 2025
                var rowHtml = `
                    <tr class="Task-item" data-taskid="${item.taskid}">
                        <td>${item.taskName || "N/A"}</td>
                        <td>${item.projectName || "N/A"}</td>
                        <td>${formatDateSafe(item.startDate) || "N/A"}</td>
                        <td>${formatDateSafe(item.endDate) || "N/A"}</td>
                        <td>${formatDateSafe(item.bStartDate) || "N/A"}</td>
                        <td>${formatDateSafe(item.bEndDate) || "N/A"}</td>
                        <td>${formatDateSafe(item.aStartDate) || "N/A"}</td>
                        <td>${formatDateSafe(item.aEndDate) || "N/A"}</td>
                        <td>${item.tPwork || "N/A"}</td>
                        <td>${item.aworkH || "N/A"}</td>
                        <td class="text-start">
                            ${getStatusUI(item.status, item.tdelay) || "N/A"}
                        </td>
                    </tr>
                `;

                $tbody.append(rowHtml);
            });

            initTasksPagination();

            // Enable tooltips after binding
            $('[data-bs-toggle="tooltip"]').tooltip();
        }

        // Added by Gauri - Get My Timesheet API call and render function on 10 Feb 2025
        $("#MyTimesheetIcon").on("click", function () {
            // Modified by Gauri to fix pagination issue on 20 Feb 2025
            var CurrentPage = 1;
            var initialStatus = $("#Status_TS_Input").val() || "R";
            loadMyTimesheetDetails(defaultEmployeeID, initialStatus, CurrentPage);      // Default Submitted should passed
        });

        // Pagination for Projects Table
        var projectsCurrentPage = 1;
        var projectsItemsPerPage = 5;
        var projectsTotalItems = 0;
        var projectsTotalPages = 0;

        // Modified by Gauri to fix pagination issue on 20 Feb 2025
        function initProjectsPagination() {
            // var $rows = $("#MyProjectsDetlsTblBody tr.Project-item");
            // projectsTotalItems = $rows.length;
            projectsTotalPages = Math.ceil(projectsTotalItems / projectsItemsPerPage);

            $("#TotalRecordsProjects").text(projectsTotalItems);

            // If no rows, disable both buttons
            // if (projectsTotalItems === 0) {
            if (projectsTotalPages <= 1) {
                $("#btnPreviousProjects, #btnNextProjects").addClass("fa-disabled");
                $("#LinkPreviousProjects, #LinkNextProjects").addClass("disabled");
                return;
            }

            showProjectsPage(projectsCurrentPage);
        }

        // Modified by Gauri to fix pagination issue on 20 Feb 2025
        function showProjectsPage(page) {
            projectsCurrentPage = page;
            updateProjectsPaginationControls();
        }

        function updateProjectsPaginationControls() {
            $("#btnPreviousProjects").removeClass("fa-disabled");
            $("#btnNextProjects").removeClass("fa-disabled");
            $("#LinkPreviousProjects").removeClass("disabled");
            $("#LinkNextProjects").removeClass("disabled");

            if (projectsCurrentPage <= 1) {
                $("#btnPreviousProjects").addClass("fa-disabled");
                $("#LinkPreviousProjects").addClass("disabled");
            }

            if (projectsCurrentPage >= projectsTotalPages) {
                $("#btnNextProjects").addClass("fa-disabled");
                $("#LinkNextProjects").addClass("disabled");
            }
        }

        function PrevProjectsList() {
            // Modified by Gauri to fix pagination issue on 20 Feb 2025
            if (projectsCurrentPage > 1) {
                projectsCurrentPage--;
                loadProjectDetailsLists(projectsCurrentPage);
            }
        }

        function NextProjectsList() {
            // Modified by Gauri to fix pagination issue on 20 Feb 2025
            if (projectsCurrentPage < projectsTotalPages) {
                projectsCurrentPage++;
                loadProjectDetailsLists(projectsCurrentPage);
            }
        }
        // End of Pagination for Projects Table

        // Pagination for Tasks Table
        var tasksCurrentPage = 1;
        var tasksItemsPerPage = 5;
        var tasksTotalItems = 0;
        var tasksTotalPages = 0;

        // Modified by Gauri to fix pagination issue on 20 Feb 2025
        function initTasksPagination() {
            // var $rows = $("#MyTasksDetlsTblBody tr.Task-item");
            // tasksTotalItems = $rows.length;
            tasksTotalPages = Math.ceil(tasksTotalItems / tasksItemsPerPage);

            $("#TotalRecordsTasks").text(tasksTotalItems);

            // If no rows, disable both buttons
            // if (tasksTotalItems === 0) {
            if (tasksTotalPages <= 1) {
                $("#btnPreviousTasks, #btnNextTasks").addClass("fa-disabled");
                $("#LinkPreviousTasks, #LinkNextTasks").addClass("disabled");
                return;
            }

            showTasksPage(tasksCurrentPage);
        }

        // Modified by Gauri to fix pagination issue on 20 Feb 2025
        function showTasksPage(page) {
            tasksCurrentPage = page;
            updateTasksPaginationControls();
        }

        function updateTasksPaginationControls() {
            $("#btnPreviousTasks").removeClass("fa-disabled");
            $("#btnNextTasks").removeClass("fa-disabled");
            $("#LinkPreviousTasks").removeClass("disabled");
            $("#LinkNextTasks").removeClass("disabled");

            if (tasksCurrentPage <= 1) {
                $("#btnPreviousTasks").addClass("fa-disabled");
                $("#LinkPreviousTasks").addClass("disabled");
            }

            if (tasksCurrentPage >= tasksTotalPages) {
                $("#btnNextTasks").addClass("fa-disabled");
                $("#LinkNextTasks").addClass("disabled");
            }
        }

        function PrevTasksList() {
            // Modified by Gauri to fix pagination issue on 20 Feb 2025
            if (tasksCurrentPage > 1) {
                tasksCurrentPage--;
                loadTaskDetailsList(tasksCurrentPage);
            }
        }

        function NextTasksList() {
            // Modified by Gauri to fix pagination issue on 20 Feb 2025
            if (tasksCurrentPage < tasksTotalPages) {
                tasksCurrentPage++;
                loadTaskDetailsList(tasksCurrentPage);
            }
        }

        // End of Pagination for Tasks Table

        // Added by Gauri - to bind GET API on Timesheet details offcanvas screen
        function loadMyTimesheetDetails(empID, TimesheetStatusCode, CurrentPage) {
            //debugger
            var url = `api/LandingDB/GetMyTimesheet?empID=${empID}&TimesheetStatusCode=${TimesheetStatusCode}&PageNo=${CurrentPage}`;
            var result = AJAXCallWithResult(url, "GET", null, false);

            if (result && result.data && result.data.length > 0) {
                timesheetTotalItems = result.data[0].totalCount || result.data.length;
            } else {
                timesheetTotalItems = 0;
            }

            var $tbody = $("#MyTimesheetDetlsTblBody");
            $tbody.empty();

            if (!result || !Array.isArray(result.data) || result.data.length === 0) {
                $tbody.append(`
                    <tr>
                        <td colspan="5" class="text-center text-muted">No timesheets found</td>
                    </tr>
                `);

                initTimesheetPagination();
                return;
            }

            function formatDate(dtStr) {
                if (!dtStr) return "-";
                var d = new Date(dtStr);
                if (isNaN(d.getTime())) return dtStr;
                // Example: 03-Oct-2025
                return d.toLocaleDateString("en-GB", {
                    day: "2-digit",
                    month: "short",
                    year: "numeric"
                }).replace(/ /g, "-");
            }

            function getStatusUI(statusText, statusCode) {
                // Map to your CSS class names in UI
                var cls = "statusSubmitted";
                var title = statusText || "Submitted";
                var label = statusText || "Submitted";

                // If you prefer to use code:
                // R = Submitted, V = Approved, J = Rejected
                if (statusCode === "V") cls = "statusApproved";
                else if (statusCode === "J") cls = "statusRejected";
                else cls = "statusSubmitted";

                return `
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox ${cls} mx-2">&nbsp;</span>
                        <label data-bs-toggle="tooltip" title="${title}">${label}</label>
                    </div>
                `;
            }

            result.data.forEach(function (item) {
                //Commented and added by Vishal Mane on 05/06/2026 to display submitted date
                //var submittedDate = formatDateDDMMMYYYY(item.submittedDate);  
                var submittedDate = item.submittedDate;
                //End of Commented and added by Vishal Mane on 05/06/2026 to display submitted date
                var period = item.tPeriod || "-";
                var hours = item.aworkH || "00:00";
                var remark = item.remark ? item.remark : "-";

                var rowHtml = `
                    <tr class="Timesheet-item">
                        <td>${submittedDate}</td>
                        <td>${period}</td>
                        <td>${hours}</td>
                        <td class="text-start">
                            ${getStatusUI(item.status, TimesheetStatusCode)}
                        </td>
                        <td>${remark}</td>
                    </tr>
                `;

                $tbody.append(rowHtml);
            });

            initTimesheetPagination();

            // re-enable tooltips after rendering
            $('[data-bs-toggle="tooltip"]').tooltip();
        }

        // Pagination for Timesheet List
        var timesheetCurrentPage = 1;
        var timesheetItemsPerPage = 5;
        var timesheetTotalItems = 0;
        var timesheetTotalPages = 0;

        // Modified by Gauri to fix pagination issue on 20 Feb 2025
        function initTimesheetPagination() {
            // var $rows = $("#MyTimesheetDetlsTblBody tr.Timesheet-item");
            // timesheetTotalItems = $rows.length;
            timesheetTotalPages = Math.ceil(timesheetTotalItems / timesheetItemsPerPage);

            // Update total records count
            $("#TotalRecordsTimesheet").text(timesheetTotalItems);

            // Show first page
            showTimesheetPage(timesheetCurrentPage);
        }

        function showTimesheetPage(page) {
            timesheetCurrentPage = page;

            // Update controls
            updateTimesheetPaginationControls();
        }

        function updateTimesheetPaginationControls() {
            $("#btnPreviousTimesheet").removeClass("fa-disabled");
            $("#btnNextTimesheet").removeClass("fa-disabled");
            $("#LinkPreviousTimesheet").removeClass("disabled");
            $("#LinkNextTimesheet").removeClass("disabled");

            // Disable previous
            if (timesheetCurrentPage <= 1) {
                $("#btnPreviousTimesheet").addClass("fa-disabled");
                $("#LinkPreviousTimesheet").addClass("disabled");
            }

            // Disable next
            if (timesheetCurrentPage >= timesheetTotalPages) {
                $("#btnNextTimesheet").addClass("fa-disabled");
                $("#LinkNextTimesheet").addClass("disabled");
            }
        }

        function PrevTimesheetList() {
            // Modified by Gauri to fix pagination issue on 20 Feb 2025
            if (timesheetCurrentPage > 1) {
                timesheetCurrentPage--;

                // Added by Gauri to pass selected statusCode on 21 Feb 2025
                var statusCode = $("#Status_TS_Input").val() || "R";
                loadMyTimesheetDetails(defaultEmployeeID, statusCode, timesheetCurrentPage);
            }
        }

        function NextTimesheetList() {
            // Modified by Gauri to fix pagination issue on 20 Feb 2025
            if (timesheetCurrentPage < timesheetTotalPages) {
                timesheetCurrentPage++;

                // Added by Gauri to pass selected statusCode on 21 Feb 2025
                var statusCode = $("#Status_TS_Input").val() || "R";
                loadMyTimesheetDetails(defaultEmployeeID, statusCode, timesheetCurrentPage);
            }
        }

        // Added by Gauri - Need Attention List API call and render function on 10 Feb 2025
        function getNeedAttentionList(empID) {
            var url = "api/LandingDB/GetAttention?empID=" + empID;
            var result = AJAXCallWithResult(url, "GET", null, false);

            var $container = $(".NotificationsContent");
            $container.empty();

            if (!result || !result.data || result.data.length === 0) {
                $container.append(`
                    <div class="text-muted text-center py-3">
                        No items need your attention
                    </div>
                `);
                return;
            }

            result.data.forEach(function (item) {
                var iconClass = getAttentionIcon(item.icon);
                var cardHtml = `
                    <div class="Notification_Card mb-2">
                        <div class="row align-items-start gx-0">
                            
                            <div class="col-sm-1 col-1 col-md-1 px-0 text-center">
                                <i class="${iconClass} ntfIcn mt-2"></i>
                            </div>

                            <div class="col-sm-9 col-9 col-md-9">
                                <div class="NotificationCardTitle d-flex justify-content-between text_red">
                                    ${item.typeDec}
                                </div>
                                <div class="NotificationSpan">
                                    ${item.content}
                                </div>
                            </div>

                            <div class="col-sm-1 col-1 col-md-1 text-center">
                                <i class="fas fa-times Notification_Cross"
                                onclick="removeAttentionItem(this)"></i>
                            </div>

                        </div>
                    </div>
                `;

                $container.append(cardHtml);
            });
        }

        // Added by Gauri - to show status icon UI
        function getTaskStatusBadge(status) {
            switch (status) {
                case "Yet to Start":
                    return { cls: "badgeRed", text: "Pending" };
                case "In Progress":
                    return { cls: "badgeOrange", text: "In Progress" };
                case "Completed":
                    return { cls: "badgeGreen", text: "Completed" };
                default:
                    return { cls: "badgeSecondary", text: status };
            }
        }

        // Added by Gauri - Get Current Tasks API call and render function on 10 Feb 2025
        function getCurrentTasksList(empID) {
            var url = "api/LandingDB/GetCurrentTasks?empID=" + empID;
            var result = AJAXCallWithResult(url, "GET", null, false);

            var $container = $("#CurrTasksContent");
            $container.empty();

            if (!result || !result.data || result.data.length === 0) {
                $container.append(`
                    <div class="text-muted text-center py-3">
                        No current tasks assigned
                    </div>
                `);
                return;
            }

            result.data.forEach(function (task) {
                var badge = getTaskStatusBadge(task.taskStatus);
                var timesheetIcon = task.timesheetEnable === 1
                    ? `<span class="iconCardsnew" onclick="openTimesheetOffcanvas('TASK', { taskId: ${task.taskID} })">
                            <i class="fas fa-check-circle text-success iconCardsnew"
                            style="cursor: pointer !important;"
                            data-bs-toggle="tooltip"
                            data-bs-title="Fill the Timesheet"></i>
                    </span>`
                    : ``;

                var cardHtml = `
                    <div class="card mb-2" data-taskid="${task.taskID}">
                        <div class="card-body">

                            <div class="d-flex justify-content-between mb-2">
                                <div>
                                    <i class="fas fa-bars-staggered pe-2"></i>
                                    <span class="tasksTxt">
                                        ${task.taskName}
                                    </span>
                                </div>
                                <div class="badge badgecolor ${badge.cls}">
                                    ${badge.text}
                                </div>
                            </div>

                            <div class="alert alertTxt d-flex justify-content-between py-1" role="alert">
                                <span>
                                    ${task.content}
                                </span>
                                <div>
                                    ${timesheetIcon}
                                </div>
                            </div>

                        </div>
                    </div>
                `;

                $container.append(cardHtml);
            });

            //Added by Aditya J. on 11-03-2026 for tooltip issue
            document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
                const existing = bootstrap.Tooltip.getInstance(el);
                if (existing) existing.dispose();
                new bootstrap.Tooltip(el);
            });
            //End of Added by Aditya J. on 11-03-2026 for tooltip issue
        }

        // Added by Gauri - to bind timesheet details for TASK and TIMELINE mode
        var currentTimesheetMode = null;
        var selectedTimelineDate = null;
        function openTimesheetOffcanvas(mode, payload) {
            
            new bootstrap.Offcanvas(document.getElementById('TS_EntryOffcanvas')).show();
            
            currentTimesheetMode = mode;
            resetTimesheetForm(); // Clear everything first

            if (mode === "TIMELINE") {
                // Enable all fields
                disableTopFields(false);

                // Set selected date
                // $("#TS_EntryDate").text(payload.date);
                selectedTimelineDate = payload.date; 
            }

            if (mode === "TASK") {
                // Disable top fields
                disableTopFields(true);

                // Always today only
                // $("#TS_EntryDate").text(new Date());
                // $("#TS_EntryDate").text(TimesheetState.selectedDate);

                // Fetch & bind task details
                // bindTaskDetails(payload.taskId);
                bindTaskDADetails(payload.taskId, defaultEmployeeID);
            }


            // Show correct offcanvas based on device
            // if (window.matchMedia("(max-width: 425px)").matches) {
            //     new bootstrap.Offcanvas(document.getElementById('TS_Mobile_DetailsOffcanvas')).show();
            // } else {
            //     new bootstrap.Offcanvas(document.getElementById('TS_EntryOffcanvas')).show();
            // }
        }

        function disableTopFields(disabled) {
            // example ids – adjust to your actual ids
            $("#Project_TS_Select").prop("disabled", disabled).selectpicker("refresh");
            $("#Task_TS_Select").prop("disabled", disabled).selectpicker("refresh");
            $("#FromTimeHr_TS_Input").prop("disabled", disabled).selectpicker("refresh");
            $("#FromTimeMin_TS_Input").prop("disabled", disabled).selectpicker("refresh");
            $("#ToTimeHr_TS_Input").prop("disabled", disabled).selectpicker("refresh");
            $("#ToTimeMin_TS_Input").prop("disabled", disabled).selectpicker("refresh");
            $("#DA_Date_Input").prop("disabled", disabled);
            $("#DayName_Label").toggleClass("disabled", disabled); // if label
        }

        function resetTimesheetForm() {
            $("#Project_TS_Select").selectpicker("val", "");
            $("#Task_TS_Select").selectpicker("val", "");
            $("#DA_Type_TS_Input").selectpicker("val", "");

            $("#Efforts_Input").val("00:00");
            $("#Description_Input").val("");

            $(".selectpicker").selectpicker("refresh");
        }

        // Added by Gauri - to format dates
        function formatDateDDMMMYYYY(dateStr) {
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return "-";
            return d.toLocaleDateString("en-GB", {
                day: "2-digit",
                month: "short",
                year: "numeric"
            }).replace(/ /g, " ");
        }


        // Added by Gauri - GET API to get profile details
        function getProfileData(EmployeeID) {
            if (!EmployeeID) {
                setDefaultProfile();
                return;
            }

            $.ajax({
                url: strUrl2 + '/api/RM_EmployeeMaster/GetEmployeeDetails',
                type: "POST",
                data: JSON.stringify(EmployeeID),
                contentType: "application/json;charset-utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));

                    if (EmployeeID) {
                        xhr.setRequestHeader("Params",
                            encryptString(isJson(EmployeeID) ? EmployeeID : JSON.stringify(EmployeeID))
                        );
                    }
                },
                success: function (MEData) {
                    if (!MEData) {
                        setDefaultProfile();
                        return;
                    }

                    // Role Bind
                    var roleName = MEData.RoleName || MEData.Role || "Employee";
                    $("#OverviewEmpRole").text(roleName);

                    // Profile Image Bind
                    if (!MEData.ProfilePicURL || MEData.ProfilePicURL === "") {
                        $("#OverviewProfileImage").attr("src", "../../../Whizible2.0-new/dist/img/blankprofile.png");
                        $("#hiddenProfilePath").val("");
                    } else {
                        $("#OverviewProfileImage").attr("src", MEData.ProfilePicURL);
                        $("#hiddenProfilePath").val(MEData.ProfilePicURL);
                    }
                },
                error: function () {
                    setDefaultProfile();
                }
            });
        }

        // Added by Gauri - GET API to get Role Name details
        var EmployeeDetails;
        function GetAllEmployeeList() {
            $.ajax({
                url: strUrl2 + '/api/RM_EmployeeMaster/GetAllEmployee',
                type: "POST",
                data: JSON.stringify({ EmpWhereClause: "" }),
                contentType: "application/json;charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    xhr.setRequestHeader("Params",
                        encryptString(JSON.stringify({ EmpWhereClause: "" }))
                    );
                },
                success: function (data) {
                    EmployeeDetails = data;

                    if (!EmployeeDetails || EmployeeDetails.length === 0) {
                        $("#OverviewEmpRole").text("");
                        return;
                    }

                    // Find logged-in employee
                    var loggedInEmp = EmployeeDetails.find(function (emp) {
                        return emp.EmployeeID == defaultEmployeeID;
                    });

                    // Bind Role
                    $("#OverviewEmpRole").text(
                        loggedInEmp ? loggedInEmp.RoleName : ""
                    );
                },
                error: function () {
                    $("#OverviewEmpRole").text("");
                }
            });
        }

        // Added by Gauri on 21 Feb 2026 - to set default profile image if no image
        function setDefaultProfile() {
            $("#OverviewProfileImage")
                .attr("src", "../../../Whizible2.0-new/dist/img/blankprofile.png");
            $("#hiddenProfilePath").val("");
        }


        // Added by Gauri - to bind week doghnut graph
        function bindWeekCircularProgress(qinboxData, week) {
            if (!Array.isArray(qinboxData)) return;

            // Get Doughnut item (for percentage)
            var doughnutItem = qinboxData.find(x => x.typeDec === "Doughnut");
            var percent = 0;

            if (doughnutItem) {
                percent = Number(doughnutItem.actualValue) || 0;
                percent = Math.min(Math.max(percent, 0), 100);
            }

            // Get Weekly Bar item (for headerValue text)
            var weeklyBarItem = qinboxData.find(x =>
                x.typeDec === "Bar" &&
                x.header &&
                x.header.toLowerCase().includes("weekly")
            );

            var headerValueText = weeklyBarItem?.headerValue || "";
            var label = `'Week ${String(week).padStart(2, "0")}'`;

            // Bind values
            $(".circular_progressbar")
                .css("--value", percent)
                .css("--label", label)
                .attr("aria-valuenow", percent)
                .text(headerValueText);   // show 17/40 inside circle
        }

        // Added by Gauri - Get My Timesheet Report API call and render function on 10 Feb 2025
        function getMyTimesheetReport(empID, week) {
            // Guard: if week not selected
            if (!week || week === "0") {
                $("#MyTimesheetReportSec").html(`
                    <div class="text-muted text-center py-3">
                        Please select a week
                    </div>
                `);
                return;
            }
            
            var url = "api/LandingDB/GetMyTimesheetGrpah?empID=" + empID + "&week=" + week;
            var result = AJAXCallWithResult(url, "GET", null, false);

            // Bind circular progress bar (Doughnut)
            bindWeekCircularProgress(result.data, week);

            var $container = $("#MyTimesheetReportSec");
            $container.empty();

            if (!result || !Array.isArray(result.data) || result.data.length === 0) {
                $container.append(`
                    <div class="text-muted text-center py-3">
                        No timesheet data available
                    </div>
                `);
                return;
            }

            // ---------- Helpers ----------
            function toNumber(val) {
                var n = Number(val);
                return isNaN(n) ? 0 : n;
            }

            function normalizePercent(val) {
                return Math.min(Math.max(toNumber(val), 0), 100);
            }

            function getProgressColor(actualVal) {
                var v = toNumber(actualVal);

                if (v <= 0) return "bg-secondary";   // 0%
                if (v >= 100) return "bgGreen";   // 100%+
                if (v >= 80) return "orangeBg";    // 80–99
                return "bgYellow";                  // 1–79
            }

            // ---------- Doughnut (if required later) ----------
            var doughnutItem = result.data.find(x => x.typeDec === "Doughnut");
            if (doughnutItem) {
                var doughnutVal = normalizePercent(doughnutItem.actualValue);

                $("#TimesheetDoughnut").css("--value", doughnutVal)
                                    .attr("aria-valuenow", doughnutVal)
                                    .text(doughnutItem.headerValue || "0:00/0:00");
            }

            // ---------- Bar Items ----------
            result.data
                .filter(item => item.typeDec !== "Doughnut")
                .forEach(function (item) {

                    var progressVal = normalizePercent(item.actualValue);
                    var progressColor = getProgressColor(item.actualValue);

                    var cardHtml = `
                        <div class="col-sm-12 col-12 col-md-12 col-lg-12 d-flex flex-column justify-content-center gap-4 mb-3">
                            <div class="row justify-content-end">

                                <div class="col-sm-3 d-flex align-items-center justify-content-end">
                                    <div class="timeReportDiv ${progressColor}">
                                        <i class="far fa-clock"></i>
                                    </div>
                                </div>

                                <div class="col-sm-9 col-12 col-md-9 col-lg-9">
                                    <div class="row">

                                        <div class="timeReportContent ms-2 ps-0 d-flex justify-content-between text-start">
                                            <div class="report_txt">
                                                ${item.header}<br>
                                                <span class="fw-500">${item.headerValue}</span>
                                            </div>
                                            <div class="report_txt">
                                                ${progressVal}%
                                            </div>
                                        </div>

                                        <div class="progress ms-2 ps-0"
                                            role="progressbar"
                                            aria-valuenow="${progressVal}"
                                            aria-valuemin="0"
                                            aria-valuemax="100">
                                            <div class="progress-bar ${progressColor}"
                                                style="width:${progressVal}%">
                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>
                    `;

                    $container.append(cardHtml);
                });
        }

        // Added by Gauri - to bind project dropdown on Timesheet screen
        function bindProjectDropdown(userID, callback) {
            var url = `api/MyTimesheetEntry/GetTimesheetDADetailsDropDown?UserID=${userID}&FieldName=ProjectId`;
            var result = AJAXCallWithResult(url, "GET", null, false);
            var $select = $("#Project_TS_Select");

            $select.empty();
            $select.append(`<option value="">Select Project</option>`);

            var list = result?.data?.listTimesheetEntryDropDown;

            if (!Array.isArray(list) || list.length === 0) {
                $select.prop("disabled", true).selectpicker("refresh");
                if (typeof callback === "function") callback(false);
                return;
            }

            $select.prop("disabled", false);

            list.forEach(function (item) {
                // IMPORTANT: trim + String
                $select.append(`<option value="${String(item.id).trim()}">${item.name}</option>`);
            });

            $select.selectpicker("refresh");

            if (typeof callback === "function") callback(true);
        }

        // Added by Gauri - to call Task dropdown API on on project change
        function ProjectOnChange() {
            var projectID = $("#Project_TS_Select").val();
            var userID = defaultEmployeeID;

            resetTaskDropdown(); // clear old tasks immediately

            if (!projectID) return;

            bindTaskDropdown(userID, projectID);
        }

        // Added by Gauri - To call GET API on Task dropdown onchange on 21 Feb 2025
       $(document).on('changed.bs.select change', '#Task_TS_Select', function () {
            var taskID = $(this).val();

            if (!taskID) {
                $("#TaskInfoIcon").hide();
                return;
            }

            $("#TaskInfoIcon").show();
            bindTaskTimelinePopoverDetails(taskID, defaultEmployeeID);      // Modified by Gauri to pass Employee in session on 21 Feb 2025
        });



        // Added by Gauri - to bind task dropdown on Timesheet screen
        function bindTaskDropdown(userID, projectID, callback) {
            var url = `api/MyTimesheetEntry/GetTimesheetDADetailsDropDown?UserID=${userID}&ProjectID=${projectID}&FieldName=Task`;
            var result = AJAXCallWithResult(url, "GET", null, false);

            var $task = $("#Task_TS_Select");
            var list = result?.data?.listTimesheetEntryDropDown || [];

            // destroy old picker UI (important)
            try { $task.selectpicker("destroy"); } catch (e) { }

            // rebuild options
            var html = `<option value="">Select Task</option>`;
            if (Array.isArray(list) && list.length) {
                list.forEach(function (item) {
                    html += `<option value="${String(item.id).trim()}">${item.name}</option>`;
                });
            }
            $task.html(html);

            // re-init picker + enable
            $task.prop("disabled", false);
            $task.selectpicker();          // init again
            $task.selectpicker("refresh"); // refresh UI

            if (typeof callback === "function") callback();
        }

        // Added by Gauri - to update Task popover details
        function updateTaskInfoPopover(startDate, endDate, plannedEffort, actualEffort) {
            var html = `
            <div class='taskDetails'>
                <div class='row'>
                <div class='col-sm-6 col-6 text-end txt_Blue'>Start Date:</div>
                <div class='col-sm-6 col-6'>${startDate}</div>
                </div>
                <div class='row'>
                <div class='col-sm-6 col-6 text-end txt_Blue'>End Date:</div>
                <div class='col-sm-6 col-6'>${endDate}</div>
                </div>
                <div class='row'>
                <div class='col-sm-6 col-6 text-end txt_Blue'>Planned Effort:</div>
                <div class='col-sm-6 col-6'>${plannedEffort}</div>
                </div>
                <div class='row'>
                <div class='col-sm-6 col-6 text-end txt_Blue'>Actual Effort:</div>
                <div class='col-sm-6 col-6'>${actualEffort}</div>
                </div>
            </div>
            `;

            // target the info icon (add an id to the img for easier selection)
            // <img id="TaskInfoIcon" ...>
            var $icon = $("#TaskInfoIcon");

            $icon.attr("data-bs-content", html);

            // Re-init popover safely
            var el = $icon[0];
            if (el) {
                bootstrap.Popover.getInstance(el)?.dispose();
                new bootstrap.Popover(el, { trigger: "hover focus", html: true });
            }
        }

        // Added by Gauri - to reset task dropdown
        function resetTaskDropdown() {
            var $task = $("#Task_TS_Select");
            $task.empty();
            $task.append(`<option value="">Select Task</option>`);
            $task.prop("disabled", true);
            $task.selectpicker("refresh");
        }

        // Added by Gauri - to bind DA dropdown on Timesheet screen
        function bindDATypeDropdown(userID) {
            var url = `api/MyTimesheetEntry/GetTimesheetDADetailsDropDown?UserID=${userID}&FieldName=datype`;
            var result = AJAXCallWithResult(url, "GET", null, false);
            var $select = $("#DA_Type_TS_Input");

            // Clear existing options
            $select.empty();

            // Add default option
            $select.append(`<option value="">Select DA Type</option>`);

            if (!result ||
                !result.data ||
                !Array.isArray(result.data.listTimesheetEntryDropDown) ||
                result.data.listTimesheetEntryDropDown.length === 0) {

                $select.prop("disabled", true);
                $select.selectpicker("refresh");
                return;
            }

            var list = result.data.listTimesheetEntryDropDown;

            $select.prop("disabled", false);

            list.forEach(function (item) {
                $select.append(`
                    <option value="${item.id}">
                        ${item.name}
                    </option>
                `);
            });

            $select.selectpicker("refresh");
        }

        // Added by Gauri to Call popover details API on 21 Feb 2026
        function bindTaskTimelinePopoverDetails(taskID, userID){
            var infoUrl = `api/MyTimesheetEntry/GetTimesheetDATaskDetails?TaskID=${taskID}&UserID=${userID}`;
            var infoRes = AJAXCallWithResult(infoUrl, "GET", null, false);

            var taskInfo = infoRes?.data?.listTimesheetEntryTaskDetails?.[0];

            if (taskInfo) {
                updateTaskInfoPopover(
                    taskInfo.startDate || "-",
                    taskInfo.endDate || "-",
                    taskInfo.plannedEfforts || "00:00",
                    taskInfo.actualWork || "00:00"
                );
            }
        }

        // Added by Gauri - to bind Current Task GET API
        function bindTaskDADetails(taskID, userID) {
            TimesheetState.mode = "TASK";
            TimesheetState.taskID = taskID;

            // Added by Gauri on 21 Feb 2025
            var $icon = $(".task-info-icon");
            $icon.attr("data-taskid", taskID);
            $icon.data("taskid", taskID);

            var url = `api/MyTimesheetEntry/GetCurrentTaskDADetails?TaskID=${taskID}&UserID=${userID}`;

            var res = AJAXCallWithResult(url, "GET", null, false);

            var details = res?.data?.listCurrentTaskDADetails?.[0] || null;

            if (!details) {
                alertify.error("No task details found.");
                return;
            }

            TimesheetState.projectID = details.projectID;
            TimesheetState.selectedDate = details.daDate;
            TimesheetState.actualDA = details.actualDA; // used as TotalDuration
            TimesheetState.fromTime = details.startHrh + ":" + details.startMin;
            TimesheetState.toTime = details.endHrh + ":" + details.endMin;
            TimesheetState.totalDuration = details.overAllDayEfforts;

            $("#ActualTS_Efforts").text(details.overAllDayEfforts || "00:00");
            $("#ExpTS_Efforts").text(details.expectedDA || "00:00");
            $("#TS_EntryDate").text(details.daDate || "");
            $("#TS_EntryDay").text(details.daMonth || "");

            bindProjectDropdown(userID, function () {
                var pid = String(details.projectID).trim();

                // bind project
                $("#Project_TS_Select")
                    .prop("disabled", false)                // enable first
                    .selectpicker("val", pid)
                    .selectpicker("refresh")
                    .prop("disabled", true)                 // then disable
                    .selectpicker("refresh");

                // then bind tasks
                bindTaskDropdown(userID, details.projectID, function () {
                    $("#Task_TS_Select")
                        .selectpicker("val", String(details.taskID).trim())
                        .prop("disabled", true)
                        .selectpicker("refresh");
                });

            });

            bindDATypeDropdown(userID);

            // setSelectpickerValue("#Project_TS_Select", details.projectID || "");
            // setSelectpickerValue("#Task_TS_Select", details.taskID || "");
            setSelectpickerValue("#FromTimeHr_TS_Input", details.startHrh || "");
            setSelectpickerValue("#FromTimeMin_TS_Input", details.startMin || "");

            // Bind To Time
            setSelectpickerValue("#ToTimeHr_TS_Input", details.endHrh || "");
            setSelectpickerValue("#ToTimeMin_TS_Input", details.endMin || "");

            // Bind Effort
            $("#Eff_TS_Input").val(details.overAllDayEfforts || "00:00");
            
            // Added by Gauri to clear description field value when open offcanvas on 19 feb 2025
            $("#Desc_TS_Input").val(""); 

            // Added by Gauri to Call popover details API on 21 Feb 2026
            bindTaskTimelinePopoverDetails(taskID, userID);
        }

        // Added by Gauri - Function on offcanvas click based on TASK and TIMELINE mode
        function openTimelineEntry(clickedDate) {
            TimesheetState.mode = "TIMELINE";
            // TimesheetState.scheduleTaskID = 0;
            TimesheetState.selectedDate = clickedDate; // Date object

            resetTimesheetForm();
            
            new bootstrap.Offcanvas(document.getElementById("TS_EntryOffcanvas")).show();
            
            // Added by Gauri to clear description field value when open offcanvas on 19 feb 2025
            $("#Desc_TS_Input").val(""); 

            // Bind DA details for clicked date
            bindTimelineDADetails(clickedDate, defaultEmployeeID);
        }

        // Added by Gauri - to bind selectpicker dropdowns
        function setSelectpickerValue(selector, value, refresh = true) {
            var v = (value === null || value === undefined) ? "" : String(value).trim();
            $(selector).selectpicker("val", v);
            if (refresh) $(selector).selectpicker("refresh");
        }

        // Added by Gauri - to bind My Timeline GET API
        function bindTimelineDADetails(dateObj, userID) {
            if (!dateObj || isNaN(new Date(dateObj).getTime())) return;

            TimesheetState.mode = "TIMELINE";
            TimesheetState.userID = userID;
            TimesheetState.selectedDate = new Date(dateObj);

            // Just load dropdown lists (no selection binding)
            bindProjectDropdown(userID, function () {

                bindDATypeDropdown(userID, function () {

                    // If project already selected by user, load tasks for it
                    var selectedProjectID = $("#Project_TS_Select").val();
                    if (selectedProjectID) {
                        bindTaskDropdown(userID, selectedProjectID, function () { });
                    }
                });
            });

            var d = new Date(dateObj);
            var day = d.getDate();
            var month = d.getMonth() + 1;
            var year = d.getFullYear();

            var url = `api/MyTimesheetEntry/GetTimesheetDADetails?Day=${day}&Month=${month}&Year=${year}&UserID=${userID}`;
            var res = AJAXCallWithResult(url, "GET", null, false);

            var details = res?.data?.listTimesheetDADetails?.[0];

            // If nothing returned → keep defaults
            if (!details) {
                setSelectpickerValue("#FromTimeHr_TS_Input", "");
                setSelectpickerValue("#FromTimeMin_TS_Input", "");
                setSelectpickerValue("#ToTimeHr_TS_Input", "");
                setSelectpickerValue("#ToTimeMin_TS_Input", "");
                $("#Eff_TS_Input").val("00:00");

                $("#ActualTS_Efforts").text("00:00");
                $("#ExpTS_Efforts").text("00:00");
                $("#TS_EntryDate").text("");
                $("#TS_EntryDay").text("");

                TimesheetState.actualDA = "00:00";
                return;
            }

            // Bind From Time
            setSelectpickerValue("#FromTimeHr_TS_Input", details.startHrh || "");
            setSelectpickerValue("#FromTimeMin_TS_Input", details.startMin || "");

            // Bind To Time
            setSelectpickerValue("#ToTimeHr_TS_Input", details.endHrh || "");
            setSelectpickerValue("#ToTimeMin_TS_Input", details.endMin || "");

            // Bind effort + labels
            $("#Eff_TS_Input").val(details.actualDA || "00:00");
            $("#ActualTS_Efforts").text(details.actualDA || "00:00");
            $("#ExpTS_Efforts").text(details.expectedDA || "00:00");
            $("#TS_EntryDate").text(details.daDate || "");
            $("#TS_EntryDay").text(details.daMonth || "");

            // Save for ValidateDAEntry TotalDuration
            TimesheetState.actualDA = details.actualDA || "00:00";
            TimesheetState.fromTime = details.startHrh + ":" + details.startMin;
            TimesheetState.toTime = details.endHrh + ":" + details.endMin;
        }

        // Added by Gauri - to bind POST API for Task
        function postTaskTimesheet() {
            TimesheetState.mode = "TASK";

            var fromTime = TimesheetState.fromTime || "";
            var toTime = TimesheetState.toTime || "";
            var totalDA = TimesheetState.totalDuration || "";

            // var projectID = parseInt($('#Project_TS_Select').val() || 0);
            // var taskID = parseInt($('#Task_TS_Select').val() || 0);
            var daType = $('#DA_Type_TS_Input').val() || "N";
            var efforts = ($('#Eff_TS_Input').val() || "").trim();
            var description = ($('#Desc_TS_Input').val() || "").trim();

            // Added by Gauri to add validation alert on 20 Feb 2025
            var parts = efforts.split(":");
            var hours = parseInt(parts[0], 10);
            var minutes = parseInt(parts[1], 10);

            var totalMinutes = (hours * 60) + minutes;

            if (totalMinutes > 1440) {   // 24 * 60
                alertify.error("You can book only 24 hours in a day.");
                return;
            }

            var hhmmRegex = /^([0-1][0-9]|2[0-3]):([0-5][0-9])$/;
            // var hhmmRegex = /^(?:([0-1][0-9]|2[0-3]):([0-5][0-9])|24:00)$/;
            if (!hhmmRegex.test(efforts)) {
                alertify.error('<%=MyBase.GetResourceString("A_EffortsHHMM")%>');
                return;
            }

            // Added by Gauri - To add 24 Hours alert on 21 Feb 2025
            var currentMinutes = convertHHMMToMinutes(efforts);
            var existingMinutes = convertHHMMToMinutes(totalDA);
            var finalMinutes = currentMinutes + existingMinutes;

            if (finalMinutes > 1440) {
                alertify.error("You can book only 24 hours in a day.");
                return;
            }

            if (!daType) { alertify.error('<%=MyBase.GetResourceString("A_DA_TypeBlank")%>'); return; }
            if (!efforts || efforts === "00:00") { alertify.error('<%=MyBase.GetResourceString("A_EffortsBlank")%>'); return; }
            if (!description) { alertify.error('<%=MyBase.GetResourceString("A_DescBlank")%>'); return; }

            var entryDateISO = getEntryDateISO_FromDaDate_Plus1(TimesheetState.selectedDate);

            var entryData = {
                entryDate: entryDateISO,
                userID: defaultEmployeeID || 0,
                projectID: TimesheetState.projectID || 0,
                taskID: TimesheetState.taskID || 0,
                // subTaskID: 0,
                fromTime: fromTime,
                toTime: toTime,
                daType: daType,
                duration: efforts,
                // totalDuration: totalDA,
                description: description
            };

            // TimesheetState.pendingDAEntryPayload = entryData;

            var entryData1 = {
                entryDate: entryDateISO,
                userID: defaultEmployeeID || 0,
                projectID: TimesheetState.projectID || 0,
                taskID: TimesheetState.taskID || 0,
                // subTaskID: 0,
                fromTime: fromTime,
                toTime: toTime,
                daType: daType,
                duration: efforts,
                description: description,
                // TotalDuration: totalDA
            };

            // ---- Validate ----
            var validateUrl = "api/MyTimesheetEntry/ValidateDAEntry";
            var validateRes = AJAXCallWithResult(validateUrl, "POST", JSON.stringify(entryData1), false);

            var validationErrors = extractValidationErrors(validateRes);

            if (!validationErrors) {
                alertify.error("Validation failed.");
                // $("#ConfirmMessagemodalinfo").modal("show");
                return;
            }

            // ---- Success + type==0 → Post ----
            if (validationErrors === "Success") {
                var typeVal = validateRes?.data?.[0]?.type;
                if (typeVal === 0) {
                    // directly post DA entry
                    TimesheetState.pendingDAEntryPayload = entryData;
                    return saveTimesheetDAEntry(); 
                }
                return;
            }

            // Modified by Gauri to add validation alerts on 19 feb 2025
            var trimmedError = validationErrors.trim();

            // ---- Confirm required ----
            if ((trimmedError || "").startsWith("You were allocated") ||
                (trimmedError || "").startsWith("Entry date for")) {

                // $("#ConfirmationMsg").html(validationErrors + "<br/><br/>Do you want to continue?");
                $("#ConfirmationMsg").html(trimmedError);
                $("#ConfirmMessagemodalinfo").modal("show");
                return;
            }

            // Added by Gauri - to handle Other validation errors on 20 Feb 2025
            // $("#ConfirmationMsg").text(validationErrors);
            // $("#ConfirmMessagemodalinfo").modal("show");
            alertify.error(trimmedError);
        }

        // Added by Gauri - to format date 
        function getEntryDateISO_FromDaDate_Plus1(daDateStr) {
            if (!daDateStr) return new Date().toISOString();
            var d = new Date(daDateStr); // "05 Feb 2026"
            if (isNaN(d.getTime())) return new Date().toISOString();
            d.setDate(d.getDate() + 1);
            return d.toISOString();
        }

        // Added by Gauri - Build validationErrors exactly like React logic
        function extractValidationErrors(validationResult) {
            var arr = validationResult && validationResult.data ? validationResult.data : [];
            if (!Array.isArray(arr)) return "";
            return arr
                .filter(function (x) { return x && x.validationMessage; })
                .map(function (x) { return x.validationMessage; })
                .join(", ");
        }

        // Added by Gauri - Convert HH:mm to minutes on 21 Feb 2025
        function convertHHMMToMinutes(timeStr) {
            if (!timeStr || !timeStr.includes(":")) return 0;

            var parts = timeStr.split(":");
            var hrs = parseInt(parts[0], 10) || 0;
            var mins = parseInt(parts[1], 10) || 0;

            return (hrs * 60) + mins;
        }

        // Added by Gauri - to bind POST API for Timeline
        function postTimelineTimesheet() {
            var fromTime = TimesheetState.fromTime || "";
            var toTime = TimesheetState.toTime || "";
            var totalDA = TimesheetState.actualDA || "";

            var projectID = parseInt($('#Project_TS_Select').val() || 0);
            var taskID = parseInt($('#Task_TS_Select').val() || 0);
            var daType = $('#DA_Type_TS_Input').val() || "N";
            var efforts = ($('#Eff_TS_Input').val() || "").trim();
            var description = ($('#Desc_TS_Input').val() || "").trim();

            // Added by Gauri to add validation alert on 20 Feb 2025
            // var hhmmRegex = /^([0-1][0-9]|2[0-3]):([0-5][0-9])$/;
            var hhmmRegex = /^([0-9]{1,2}):([0-5][0-9])$/;

            if (!hhmmRegex.test(efforts)) {
                alertify.error('<%=MyBase.GetResourceString("A_EffortsHHMM")%>');
                return;
            }

            // Added by Gauri - To add 24 Hours alert on 21 Feb 2025
            var currentMinutes = convertHHMMToMinutes(efforts);
            var existingMinutes = convertHHMMToMinutes(totalDA);
            var finalMinutes = currentMinutes + existingMinutes;

            if (finalMinutes > 1440) {
                alertify.error("You can book only 24 hours in a day.");
                return;
            }

            if (!projectID) { alertify.error('<%=MyBase.GetResourceString("A_ProjBlank")%>'); return; }
            if (!taskID) { alertify.error('<%=MyBase.GetResourceString("A_TaskBlank")%>'); return; }
            
            if (!daType) { alertify.error('<%=MyBase.GetResourceString("A_DA_TypeBlank")%>'); return; }
            if (!efforts || efforts === "00:00") { alertify.error('<%=MyBase.GetResourceString("A_EffortsBlank")%>'); return; }
            if (!description) { alertify.error('<%=MyBase.GetResourceString("A_DescBlank")%>'); return; }

            var entryDateISO = getEntryDateISO_FromDaDate_Plus1(TimesheetState.selectedDate);

            var entryData = {
                entryDate: entryDateISO,
                userID: defaultEmployeeID || 0,
                projectID: Number(projectID),
                taskID: Number(taskID),
                // subTaskID: 0,
                fromTime: fromTime,
                toTime: toTime,
                daType: daType,
                duration: efforts,
                // totalDuration: totalDA,
                description: description
            };

            var entryData1 = {
                entryDate: entryDateISO,
                userID: defaultEmployeeID || 0,
                projectID: Number(projectID),
                taskID: Number(taskID),
                // subTaskID: 0,
                fromTime: fromTime,
                toTime: toTime,
                daType: daType,
                duration: efforts,
                description: description,
                TotalDuration: totalDA
            };

            // ---- VALIDATE ----
            var validateUrl = "api/MyTimesheetEntry/ValidateDAEntry";
            var validationResult = AJAXCallWithResult(validateUrl, "POST", JSON.stringify(entryData1), false);

            var validationErrors = extractValidationErrors(validationResult);

            if (!validationErrors) {
                alertify.error("Validation failed.");
                return;
            }

            if (validationErrors === "Success") {
                var typeVal = validationResult?.data?.[0]?.type;
                if (typeVal === 0) {
                    // directly post DA entry
                    TimesheetState.pendingDAEntryPayload = entryData;
                    return saveTimesheetDAEntry(); 
                }
                return;
            }

            // Modified by Gauri to add validation alerts on 19 feb 2025
            var trimmedError = validationErrors.trim();

            // SPECIAL CONFIRMATION CASE
            if (trimmedError.startsWith("You were allocated") ||
                trimmedError.startsWith("Entry date for")) {

                // Store payload temporarily
                TimesheetState._pendingTimelinePayload = entryData;
                TimesheetState.pendingDAEntryPayload = entryData;

                $("#ConfirmMessagemodalinfo").modal("show");
                $("#ConfirmationMsg").html(trimmedError);

                return;
            }

            // Added by Gauri - to handle OTHER VALIDATION ERRORS on 20 Feb 2025
            // $("#ConfirmMessagemodalinfo").modal("show");
            // $("#ConfirmationMsg").text(validationErrors);
            alertify.error(trimmedError);
        }

        // Added by Gauri - Function to call Save button click on offcanvas screen
        function saveTimesheetButtonClick() {
            if (TimesheetState.mode === "TASK") {
                return postTaskTimesheet();
            }
            if (TimesheetState.mode === "TIMELINE") {
                return postTimelineTimesheet();
            }
            return; // safety
        }

        // Added by Gauri - Function to call on YES button click on confirmation modal pop up
        function saveTimesheetDAEntry() {
            // if (!TimesheetState.pendingDAEntryPayload) {
            //     alertify.error("No pending entry to save.");
            //     return;
            // }

            var postUrl = "api/MyTimesheetEntry/PostDAEntryForDay";
            var postRes = AJAXCallWithResult(postUrl, "POST", JSON.stringify(TimesheetState.pendingDAEntryPayload), false);

            var msg = postRes?.data?.[0]?.validationMessage;

            if (msg === "Success") {
                alertify.success('<%=MyBase.GetResourceString("A_TS_SavedSuccess")%>');
                new bootstrap.Offcanvas(document.getElementById('TS_EntryOffcanvas')).hide();
                renderMonthlyCalendar(defaultEmployeeID, currentYear, currentMonth);
                // Added by Gauri to fix refresh list on 20 Feb 2025
                getCurrentTasksList(defaultEmployeeID);
            } else {
                alertify.error('<%=MyBase.GetResourceString("A_TS_SavedFailed")%>');
            }

            TimesheetState.pendingDAEntryPayload = null;
        }

    </script>

</body>
</html>
