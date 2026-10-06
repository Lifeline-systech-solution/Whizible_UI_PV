<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Support_Engineer_Dashboard.aspx.vb" Inherits="Whizible.Support_Engineer_Dashboard" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css?v=1">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom_dashboard.css?date=<%=DateTime.Now %>">   
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />

    <style type="text/css">
       /* .carousel-indicators {
    bottom: -60px;
}*/
       select.form-select {
    -webkit-appearance: menulist;
}
/*       .table-fixed-header thead tr th {
    white-space: normal;
}*/
.MainDiv {
    overflow: auto;
    height: 55vh;
}
        .stickyTblHeader {
            position: sticky !important;
        }
        .main_profile {
            display: flex;
            border: 1px dotted #ddd;
                padding: 14px;
    margin: -14px;
            border-radius: 18px;
            flex-wrap: nowrap;
            flex-direction: column;
            justify-content: center;
        }
        .small_Txt{
            font-size:12px;
        }
        .smallImg {
            width: 20px;
            height: auto;
        }
        .checkIcn {
            position: absolute;
            left: 196px;
            top: 45%;
            font-size: 11px;
            color: #248aff;
        }
        .badgeIcn {
            color: #badaff;
            /* position: relative; */
            font-size: 18px;
        }
        .smallTxt {
            font-size: 13px;
            color: #9ea3b7;
        }
        .leve_div {
            font-size: 13px;
            color: #ff6a00;
        }
        .pageHeading {
            font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 600;
        }
        .logo_section {
            display: flex;
            align-items: center;
        }




        .top_blue_text {
            font-size: 25px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #2B55CE;
            font-weight: 500;
            padding: 3px;
        }
        .blue_text {
            font-size: 16px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #2B55CE;
            font-weight: 500;
            padding: 2px;
        }
        .top_yellow_text {
            font-size: 25px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #ff9900;
            font-weight: 500;
            padding: 3px;
        }
        .top_voil_text {
            font-size: 25px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #ec23ed;
            font-weight: 500;
            padding: 3px;
        }
        .yellow_text {
            font-size: 16px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #ff9900;
            font-weight: 500;
            padding: 2px;
        }
        .voil_text {
            font-size: 16px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #ec23ed;
            font-weight: 500;
            padding: 2px;
        }
        .top_black_text {
            font-size: 25px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
        }
        .card_border {
            border: none !important;
        }
        .card_header_border {
            border: 1px solid #ddd;
        }
        .bg_light_red {
            background-color: #fff4f4;
        }
        .bg_light_blue {
            background-color: #edecfd;
        }
        .bg_light_orange {
            background-color: #fffcdd;
        }
        .space_word {
            word-spacing: 3px;
            padding-left: 15px;
        }
        .red_txt {
            color:#ff0000;
            font-weight:500;
        }
        .card_bottom {
            border-bottom: 1px dotted #ddd;
        }
        #scorer-1-inner-div {
            position: absolute;
            left: 27%;
            top: 50%;
            width: 59%;
            /* height: 60%; */
            border-top-left-radius: 360px;
            border-top-right-radius: 360px;
            background-color: #ffffff;
            z-index: 2;
        }
        #scorer-1-inner-div-5 {
            position: absolute;
            /* left: 2%; */
            top: 100%;
            width: 17%;
            height: 0%;
            border-radius: 50%;
            background-color: #000000;
            z-index: 2;
        }
        .scorer-1-tick {
            position: absolute;
            top: 38px;
            left: 77%;
            width: 166%;
            height: 3px;
            background-color: #000000;
            animation-name: ticker-mover-1;
            animation-duration: 2s;
            animation-iteration-count: infinite;
            animation-timing-function: linear;
            border-top-left-radius: 50%;
            border-bottom-left-radius: 50%;
            border-top-right-radius: 5%;
            border-bottom-right-radius: 5%;
        }
        @keyframes ticker-mover-1 {
            0% {
                transform-origin: right center;
                transform: rotate(0deg);
            }

            33% {
                transform-origin: right center;
                transform: rotate(120deg);
            }

            66% {
                transform-origin: right center;
                transform: rotate(120deg);
            }

            100% {
                transform-origin: right center;
                transform: rotate(120deg);
            }
        }

        .aline_content {
            display: flex;
            align-items: center;
            justify-content: space-evenly;
        }
        .boxInbox {
            border: 1px dashed #ddd;
            border-radius: 10px;
        }
        .rating_Fstar {
            color: #ffb300;
        }
       
        .Tickets_graphSection {
            width: 36vw;
        }


        .span_Orgtext {
            font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #ff9900;
        }
        .span_green_text {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #0da31a;
        }
 
        .ProgressTitle {
         /*   color: #d3d3d3;*/
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        .iniProgress {
            height: 7px;
        }
/*            .iniProgress .progress-bar {
                border-radius: 10px;
            }*/

        .bgGreen {
            background-color: #52c273;
        }
        .bgblue {
            background-color: #4881fb;
        }

        .text_green {
            color: green;
        }
        .d-inline {
            padding: 6px;
            border-bottom: 1px solid #ddd;
        }
        .bg_Milestone {
            background-color: #f1f8ff !important;
            /* color: #124801 !important;*/
        }
        .table-fixed-header tbody tr td, .table tbody tr td {
            font-weight: 400;
        /*    text-align: left;*/
            vertical-align: middle;
        }
        .first_col {
            width: 80px;
            min-width: 80px;
            max-width: 80px;
            left: 0px;
            z-index: 1;
        }
        .second_col {
            width: 250px;
            min-width: 250px;
            max-width: 250px;
    /*        left: 80px;*/
            left: 0px;
            z-index: 1;
        }
        .third_col {
            width: 100px;
            min-width: 100px;
            max-width: 100px;
            /*left: 330px;*/
            left: 80px;
            z-index: 1;
        }
        .forth_col {
            width: 100px;
            min-width: 100px;
            max-width: 100px;
            /*  left: 430px;*/
            left: 330px;
            z-index: 1;
        }
        .sticky_col {
            position: -webkit-sticky;
            position: sticky;
            background-color: white;
            z-index: 1;
        }

        .bg_grayTD {
            background-color: #f9f9f9 !important;
        }

        .scrollTable:hover {
            overflow: auto !important;
        }

        .scrollTable {
            scrollbar-width: thin;
        }

             .scrollTable {
                overflow: hidden !important;
            }
        .MainDiv {
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        

        /* Style Wired */
        .switch {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 15px;
        }
        .slider {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            border-radius: 30px;
            border: 1px solid #ddd;
            cursor: pointer;
            border: 4px solid transparent;
            overflow: hidden;
            transition: .4s;
            background: #ddd
        }

            .slider:before {
                position: absolute;
                content: "";
                width: 100%;
                height: 100%;
                background: #fff;
                border-radius: 30px;
                transform: translateX(-20px);
                transition: .4s
            }

        input:checked + .slider:before {
            transform: translateX(20px);
            background: #fff
        }

        input:checked + .slider {
            border: 4px solid #4263c1;
            background: #4263c1
        }

        .score_count {
/*            position: absolute;
            top: 66px;
            left: 42px;*/
            font-size: 18px;
            font-weight: 500;
            color: #1b8915;
        }

        .carousel-inner:hover{
            overflow-y: auto;
            scrollbar-width: thin;
        }
        .fnt-13 {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        .ticketCarousel{
            height: 235px;
        }
    </style>
</head>

<body class="hold-transition bgwhite sidebar-mini fixed">

  <% If m_blnViewAccess = True Then %>

    <!-- Content Wrapper. Contains page content -->
    <div class="bgwhite resource_allocation">
        <div class="container-fluid pt-1 pb-1 mb-1 mx-0 test-end graybg">
            <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_Support_Engineer_Dashboard") %></h5>
            <div class="clearfix"></div>
        </div>
        <div class="px-3">
            <div class="row mb-0 py-2">
                <div class="col-10 col-sm-8 offset-sm-4 col-md-7 offset-md-5 col-lg-5 offset-lg-7">
                    <div class=" row pe-0 py-0 ">
                        <div class="col-4 col-sm-6 text-end">
                            <label for="CntryCodeEdtInput" class=" mt-2"><%= MyBase.GetResourceString("C_Employee") %></label>
                        </div>
                        <div class="col-8 col-sm-6 text-start">       
             <%=CommonFunctions.HTMLControls.DrawComboBox("dd_EMPFilter_ID", "usp_Sel_Whizible2_Emp_tbl_CRM_Query_Master " & Session("intUserID"),,, "onchange='filterEmployee();' class='form-select ' ", , ,) %>                      
                        </div>
                    </div>
                </div>
            </div>
            <div class="TabsSec">
                <div class="profileSec">
                    <div class="container-fluid p-3">
                        <div class="CardsAcc_flex">
                            <div class="row">
                                <!-- Profile Image start here -->
                                <div class="col-12 col-sm-4 col-lg-2 d-flex">
                                    <div class="main_profile">
                                        <div class="profImgSec position-relative d-inline-block">
                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" alt="" class="profileImg img-fluid">
                                        </div>
                                        <div class="profileInfo">
                                            <div class="profileName mb-0 mt-1 d-flex justify-content-between">
                                                <div class=""><span class="pageHeading"></span></div>
                                            </div>
                                            <div class="mb-1">
                                                <img src="../../../Whizible2.0-new/dist/img/profile-pic.jpg" alt="" class="smallImg">
                                                <span id="profileTitle" class="smallTxt"></span>
                                            </div>
                                            <div class="">
                                                <span class="leve_div"></span>
                                            </div>
                                            <div class="">
                                                <span class="pe-1"><%= MyBase.GetResourceString("C_All") %></span>
                                                <label class="switch me-1 pb-2">
                                                    <input type="checkbox" id ="btn_switch_ID"
                                                        onclick="isValidData();"
                                                        >
                                                    <span class="slider"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Profile Image end here -->
                                <div class="col-12 col-sm-8 col-lg-10 d-flex">
                                    <div class="CardsAcc_flex">
                                        <div class="row">
                                            <div class="col-12 col-sm-6 col-lg-3 d-flex mb-1">
                                                <div class="card cardkblu_view ontime_data card_border CardsAcc_flex">
                                                    <div class="card-header card_header_border">
                                                        <div class=""><%= MyBase.GetResourceString("C_Live_Tickets") %></div>
                                                    </div>
                                                    <div class="">
                                                        <div class="card cardkblu_view ontime_data mt-2 bg_light_red">
                                                            <div class="card-body pt-0">
                                                                <div class="justify-content-between">
                                                                    <div class="row d-flex">
                                                                        <div class="col-sm-12 text-center">
                                                                            <div class="IniCode py-1">
                                                                                <span class="top_red_text" id="spn_OpenTicketCount_ID"></span>                                                                            
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-12 py-0">
                                                                            <div class="text-center red_text"><%= MyBase.GetResourceString("C_Open") %></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="card-img text-end">
                                                                <span data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">
                                                                    <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#moredetails_OffcvsScreen_Open"><i class="fas fa-exclamation Card_View_whiz clearedStage1" onclick="resetOpenTicketsDetails()"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="card cardkblu_view ontime_data mt-2 bg_light_orange">
                                                            <div class="card-body pt-0">
                                                                <div class="justify-content-between">
                                                                    <div class="row d-flex">
                                                                        <div class="col-sm-12 text-center">
                                                                            <div class="IniCode py-1">
                                                                                <span class="top_yellow_text" id="spn_UnassignedTickets_ID"></span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-12 py-0">
                                                                            <div class="text-center yellow_text"><%= MyBase.GetResourceString("C_Unassigned") %></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="card-img text-end">
                                                                <span data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details" aria-describedby="tooltip398203">
                                                                    <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#moredetails_OffcvsScreen_Unassigned" ><i class="fas fa-exclamation Card_View_whiz clearedStage_orange" onclick="resetUnassignedTicketsDetails()"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6 col-lg-3 d-flex mb-1">
                                                <div class="card cardkblu_view ontime_data CardsAcc_flex">
                                                    <div class="card-header">
                                                        <div class=""><%= MyBase.GetResourceString("C_FRT") %></div>
                                                    </div>
                                                    <div class="">
                                                        <div class="cardkblu_view ontime_data mt-2">
                                                            <div class="justify-content-between">
                                                                <div class="row d-flex">
                                                                    <div class="col-sm-12 text-center">
                                                                        <div class="IniCode py-1 card_bottom">
                                                                            <div class="top_black_text" id="frtID"></div>
                                                                            <div class="space_word">
                                                                                <div class=""><%= MyBase.GetResourceString("C_frt_inner") %></div>
                                                                                <div class="">
                                                                                    <span class="red_txt" id="spn_YesPercent_ID"><i class="fas fa-caret-up"></i></span>
                                                                                    <span class=""><%= MyBase.GetResourceString("C_yesterday") %></span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-12 text-center mt-2">
                                                                        <div class="IniCode py-1">
                                                                            <span class="top_yellow_text" id="spn_frtSLA_ID"></span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-12 py-0">
                                                                        <div class="text-center yellow_text"><%= MyBase.GetResourceString("C_within_sla") %></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6 col-lg-3 d-flex mb-1">
                                                <div class="card cardkblu_view ontime_data CardsAcc_flex">
                                                    <div class="card-header">
                                                        <div class=""><%= MyBase.GetResourceString("C_Overall_CSAT") %></div>
                                                    </div>
                                                    <div class="card-body pt-0 aline_content">
                                                        <div class="row d-flex">
                                                            <div class="col-sm-12 text-center">
                                                                <div class="IniCode">
                                                                    <div id="scorer-1-inner-div">
                                                                        <div id="scorer-1-inner-div-5">
                                                                            <div class="scorer-1-tick">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <canvas id="SCAT_Graph" style="width:100%;">
                                                                    </canvas>
                                                                </div>
                                                                <div class="score_count" id="csatOverall"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6 col-lg-3 d-flex CardsAcc_flex mb-1">
                                                <div class="row CardsAcc_flex">
                                                    <div class="col-12 col-sm-12">
                                                        <div class="card cardkblu_view ontime_data bg_light_blue CardsAcc_flex">
                                                            <div class="card-body pt-0 d-flex justify-content-center">
                                                                <div class="row">
                                                                    <div class="col-sm-12 text-center">
                                                                        <div class="IniCode py-2">
                                                                            <span class="top_blue_text" id="spn_highPriorityTickets_ID"></span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-12 py-0">
                                                                        <div class="text-center blue_text"><%= MyBase.GetResourceString("C_high_priority") %></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="card-img text-end">
                                                                <span data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">
                                                                    <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#moredetails_OffcvsScreen_HighPriority"><i class="fas fa-exclamation Card_View_whiz clearedStage1" onclick="resetHighPriorityTicketsDetails()"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-12 col-sm-12">
                                                        <div class="card cardkblu_view ontime_data mt-4 bg_light_blue CardsAcc_flex">
                                                            <div class="card-body pt-0 d-flex justify-content-center">
                                                                <div class="row">
                                                                    <div class="col-sm-12 text-center">
                                                                        <div class="IniCode py-2">
                                                                            <span class="top_blue_text" id="spn_monthCSAT_ID"></span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-12 py-0">
                                                                        <div class="text-center blue_text"><%= MyBase.GetResourceString("C_CSAT_Month") %></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="card-img text-end">
                                                                <span data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">
                                                                    <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#moredetails_OffcvsScreen_MonthCSAT"><i class="fas fa-exclamation Card_View_whiz clearedStage1" onclick="resetCSATTicketDetails()"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="CardsAcc_flex mt-2">
                <div class="row">
                    <div class="col-12 col-sm-12 col-lg-5 d-flex">
                        <div class="card cardkblu_view ontime_data mt-2 CardsAcc_flex">
                            <div class="card-header ">
                                <div class="card_top_heading"><%= MyBase.GetResourceString("C_New_Closed") %></div>
                            </div>
                            <div class="card-body">
                                <div class="legends-div d-flex justify-content-center" id="legends-div">
                                    <div class="row g-0">
                                        <div class="col-sm-6 col-4">
                                            <div class="legends legend2">
                                                <div class="legend-box"></div>
                                                <div class="l-name"><%= MyBase.GetResourceString("C_New") %></div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-6">
                                            <div class="legends legend3">
                                                <div class="yellow-box"></div>
                                                <div class="l-name"><%= MyBase.GetResourceString("C_Closed") %></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center" id="">
                                    <div class="Tickets_graphSection aline_content mt-4 CardsAcc_flex">
                                        <canvas id="Tickets_VolumeChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-12 col-lg-5 d-flex">
                        <div class="card cardkblu_view ontime_data mt-2 CardsAcc_flex ">
                            <div class="card-header ">
                                <div class="card_top_heading">
                                    <div class="d-flex justify-content-between">
                                        <div class=""><%= MyBase.GetResourceString("C_Cust_feedback") %></div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body" id="customerFeedbackClear" >
                                <div id="carousel_Customer" class="carousel slide" data-bs-ride="false">
                                    <div class="carousel-inner" id="feedbackContainer_ID" >
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                 
                    <div class="col-12 col-sm-12 col-lg-2">
                        <div class="row CardsAcc_flex">
                            <div class="col-6 col-sm-6 col-lg-12 d-flex">
                                <div class="card cardkblu_view  ontime_data mt-2 CardsAcc_flex ">
                                    <div class="card-header">
                                        <div class=""><%= MyBase.GetResourceString("C_Open_Tickets") %></div>
                                    </div>
                                    <div class="card-body pt-0">
                                        <div id="carousel_OpenTickets" class="carousel slide" data-bs-ride="false">
                                            <div class="carousel-inner" id="TicketsContainer_ID" >
                                                <div class="carousel-item ticketCarousel active" >
                                                    <div class="row d-flex">
                                                        <div class="col-sm-12 text-start ">
                                                            <div class="row">
                                                                <div class="col-6 col-sm-7 col-lg-7 text-start">
                                                                    <div class="canvas-con">
                                                                        <p class="medium_center_text" id="p_HighOpenTickets_ID"></p>
                                                                        <div class="canvas-con-inner">
                                                                            <canvas id="HighOpenTickets" style="width:95px; height:72px;"></canvas>
                                                                        </div>
                                                                        <div id="my-legend-con" class="legend-con"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-6 col-sm-7 col-lg-5 ps-2 text-start flex_display CardsAcc_flex">
                                                                    <span class="span_text fnt-13"><%= MyBase.GetResourceString("C_High") %></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 text-start">
                                                            <div class="row">
                                                                <div class="col-6 col-sm-7 col-lg-7 text-start">
                                                                    <div class="canvas-con">
                                                                        <p class="medium_center_text" id="p_MediumOpenTickets_ID"></p>
                                                                        <div class="canvas-con-inner">
                                                                            <canvas id="MediumOpenTickets" style="width:95px; height:72px;"></canvas>
                                                                        </div>
                                                                        <div id="my-legend-con" class="legend-con"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-6 col-sm-7 col-lg-5 ps-2 text-start flex_display CardsAcc_flex">
                                                                    <span class="span_pinktext fnt-13" style="width:50px; height:10px;"><%= MyBase.GetResourceString("C_Medium") %></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 text-start">
                                                            <div class="row">
                                                                <div class="col-6 col-sm-7 col-lg-7 text-start">
                                                                    <div class="canvas-con">
                                                                        <p class="medium_center_text" id="p_LowOpenTickets_ID"></p>
                                                                        <div class="canvas-con-inner">
                                                                            <canvas id="LowOpenTickets" style="width:95px; height:72px;"></canvas>
                                                                        </div>
                                                                        <div id="my-legend-con" class="legend-con"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-6 col-sm-7 col-lg-5 ps-2 text-start flex_display CardsAcc_flex">
                                                                    <span class="span_bluetext fnt-13"><%= MyBase.GetResourceString("C_Low") %></span>
                                                                </div>
                                                            </div>
                                                        </div> 
                                                    </div>
                                                </div>

                                                <div class="carousel-item ticketCarousel" >
                                                    <div class="row d-flex">
                                                        <div class="col-sm-12 text-start ">
                                                            <div class="row">
                                                                <div class="col-6 col-sm-7 col-lg-7 text-start">
                                                                    <div class="canvas-con">
                                                                        <p class="medium_center_text" id="p_C_HighOpenTickets_ID"></p>
                                                                        <div class="canvas-con-inner">
                                                                            <canvas id="C_HighOpenTickets" class="ticketCanvas" style="width:95px; height:72px;"></canvas>
                                                                        </div>
                                                                        <div id="my-legend-con" class="legend-con"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-6 col-sm-7 col-lg-5 ps-2 text-start flex_display CardsAcc_flex">
                                                                    <span class="span_text fnt-13">Critical High</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 text-start">
                                                            <div class="row">
                                                                <div class="col-6 col-sm-7 col-lg-7 text-start">
                                                                    <div class="canvas-con">
                                                                        <p class="medium_center_text" id="p_C_MediumOpenTickets_ID"></p>
                                                                        <div class="canvas-con-inner">
                                                                            <canvas id="C_MediumOpenTickets" style="width:95px; height:72px;"></canvas>
                                                                        </div>
                                                                        <div id="my-legend-con" class="legend-con"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-6 col-sm-7 col-lg-5 ps-2 text-start flex_display CardsAcc_flex">
                                                                    <span class="span_pinktext fnt-13" style="width:50px; height:10px;"><%= MyBase.GetResourceString("C_Medium") %></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 text-start">
                                                            <div class="row">
                                                                <div class="col-6 col-sm-7 col-lg-7 text-start">
                                                                    <div class="canvas-con">
                                                                        <p class="medium_center_text" id="p_C_LowOpenTickets_ID"></p>
                                                                        <div class="canvas-con-inner">
                                                                            <canvas id="C_LowOpenTickets" style="width:95px; height:72px;"></canvas>
                                                                        </div>
                                                                        <div id="my-legend-con" class="legend-con"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-6 col-sm-7 col-lg-5 ps-2 text-start flex_display CardsAcc_flex">
                                                                    <span class="span_bluetext fnt-13"><%= MyBase.GetResourceString("C_Low") %></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="carousel-indicators py-2">
                                                    <button type="button" data-bs-target="#carousel_OpenTickets" data-bs-slide-to="0" class="active btn_carousel" aria-current="true" aria-label="Slide 1"></button>
                                                    <button type="button" data-bs-target="#carousel_OpenTickets" data-bs-slide-to="1" class="btn_carousel" aria-label="Slide 2"></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-6 col-sm-6 col-lg-12 d-flex">
                                <div class="card cardkblu_view  ontime_data mt-2">
                                    <div class="card-header">
                                        <div class=""><%= MyBase.GetResourceString("C_Current_Week") %></div>
                                    </div>
                                    <div class="card-body pt-0">
                                        <div class="row d-flex">
                                            <div class="col-12 col-sm-6 col-lg-12 text-start ">
                                                <div class="row">
                                                    <div class="col-6 col-sm-7 col-lg-7 text-start">
                                                        <div class="canvas-con">
                                                            <p class="medium_center_text" id="p_ResolTicket_ID"></p>
                                                            <div class="canvas-con-inner">
                                                                <canvas id="ResolvedTickets" style="width:95px; height:72px;"></canvas>
                                                            </div>
                                                            <div id="my-legend-con" class="legend-con"></div>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-sm-7 col-lg-5 ps-0 text-start flex_display CardsAcc_flex ">
                                                        <span class="span_green_text fnt-13"><%= MyBase.GetResourceString("C_Resolved_Tickets") %></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6 col-lg-12 text-start ">
                                                <div class="row">
                                                    <div class="col-6 col-sm-7 col-lg-7 text-start">
                                                        <div class="canvas-con">
                                                            <p class="medium_center_text" id="p_ClosTicket_ID"></p>
                                                            <div class="canvas-con-inner">
                                                                <canvas id="CloseTickets" style="width:95px; height:72px;"></canvas>
                                                            </div>
                                                            <div id="my-legend-con" class="legend-con"></div>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 col-sm-7 col-lg-5 ps-0 text-start flex_display CardsAcc_flex ">
                                                        <span class="span_Orgtext fnt-13"><%= MyBase.GetResourceString("C_Closed_Tickets") %></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="CardsAcc_flex mt-2 mb-2">
                <div class="row">
                    <div class="col-12 col-sm-12 col-lg-5 d-flex">
                        <div class="CardsAcc_flex">
                            <div class="row">
                                <div class="col-12 col-sm-6 col-lg-6 d-flex">
                                    <div class="card cardkblu_view ontime_data mt-2 CardsAcc_flex">
                                        <div class="card-header">
                                            <div class=""><%= MyBase.GetResourceString("C_Target_Today") %></div>
                                        </div>
                                        <div class="card-body pt-0 aline_content">
                                            <div class="row d-flex">
                                                <div class="col-12 col-sm-12 text-center">
                                                    <div class="IniCode">
                                                        <div id="scorer-1-inner-div">
                                                            <div id="scorer-1-inner-div-5">
                                                                <div class="scorer-1-tick">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="speed_graphSection">
                                                            <canvas id="SLATargets" style="width:100%;">
                                                            </canvas>
                                                        </div>
                                                    </div>
                                                    <div class="score_count" id="SLATarget_Percent_ID"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-6 col-lg-6 d-flex CardsAcc_flex">
                                    <div class="card cardkblu_view ontime_data mt-2 CardsAcc_flex">
                                        <div class="card-header ">
                                            <div class="card_top_heading">
                                                <div class="d-flex justify-content-between">
                                                    <div class=""><%= MyBase.GetResourceString("C_Cust_feedback_Percentage") %></div>                                                
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="row gy-3" id ="feedbackPercen_Id">                                             
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </div>
                    </div>
                    <div class="col-12 col-sm-12 col-lg-2 d-flex">
                                                <div class="card cardkblu_view ontime_data card_border mt-2 CardsAcc_flex">
                                                    <div class="card-header card_header_border">
                                                        <div class=""><%= MyBase.GetResourceString("C_Active_SLA") %></div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6 col-sm-6 col-lg-12">
                                                            <div class="card cardkblu_view ontime_data mt-2">
                                                                <div class="card-body pt-0">
                                                                    <div class="justify-content-between">
                                                                        <div class="row d-flex">
                                                                            <div class="col-sm-12 text-center">
                                                                                <div class="IniCode py-1">
                                                                                    <span class="top_voil_text" id="spn_slaBreached_Id"></span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-12 py-0">
                                                                                <div class="text-center voil_text"><%= MyBase.GetResourceString("C_Breached") %></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card-img text-end">
                                                                    <span data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">
                                                                        <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#moredetails_OffcvsScreen_Breached">                                                                                                                                                    
                                                                            <i class="fas fa-exclamation Card_View_whiz clearedStage1"onclick="resetBreachedTicketDetailsAccEmp()"></i>
                                                                        </a>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-6 col-sm-6 col-lg-12">
                                                            <div class="card cardkblu_view ontime_data mt-2">
                                                                <div class="card-body pt-0">
                                                                    <div class="justify-content-between">
                                                                        <div class="row d-flex">
                                                                            <div class="col-sm-12 text-center">
                                                                                <div class="IniCode py-1">
                                                                                    <span class="top_yellow_text" id="spn_slaUnbreached_Id"></span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-12 py-0">
                                                                                <div class="text-center yellow_text"><%= MyBase.GetResourceString("C_Unbreached") %></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card-img text-end">
                                                                    <span data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details" aria-describedby="tooltip398203">
                                                                        <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#moredetails_OffcvsScreen_unBreached"><i class="fas fa-exclamation Card_View_whiz clearedStage_orange" onclick="resetUnbreachedTicketDetailsAccEmp()"></i></a>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div> 
                                                    </div>
                                                    </div>

                                </div>
                                <div class="col-12 col-sm-12 col-lg-5 d-flex">
                                    <div class="CardsAcc_flex">
                                        <div class="row">
                                            <div class="col-sm-7 mt-2">
                                                <div class="card cardkblu_view  ontime_data CardsAcc_flex">
                                                    <div class="card-header">
                                                        <div class=""><%= MyBase.GetResourceString("C_Recently_Breached") %></div>
                                                    </div>
                                                    <div class="card-body pt-2" id="recentBreached_ID" >
                                                        <div id="carousel_Recently_breached" class="carousel slide" data-bs-ride="false">

                                                        </div>
                                                    </div>


                                                </div>
                                            </div>

                                            <div class="col-sm-5 mt-2">
                                                <div class="card cardkblu_view ontime_data CardsAcc_flex">
                                                    <div class="card-header">
                                                        <div class=""><%= MyBase.GetResourceString("C_Customer_Tickets_Open") %></div>
                                                    </div>
                                                    <div class="card-body  mt-0" id="CustOpenTicket_ID">                                                      
                                                    </div>
                                                    <div class="card-img text-end">
                                                        <span data-bs-toggle="tooltip" title="More Details">
                                                            <a href="javascript:;" data-bs-toggle="offcanvas"
                                                               data-bs-target="#moredetails_OffcvsScreen_CustOpen"><i class="fas fa-exclamation Card_View_whiz clearedStage_orange" onclick="resetCustOpenicketDetails()"></i></a>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>  
                                        </div>  
                                </div>
                                    </div>
                                </div>
       
        </div>
        
       
           <!-- More Details for Tickets  Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
             id="moredetails_OffcvsScreen_Open" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                               <span> <%= MyBase.GetResourceString("C_Tickets_Details") %></span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="Ticketes_Tab_Open" class="CountryInfo">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label><%= MyBase.GetResourceString("C_Department") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                                  
             <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_Open_ID", "usp_Sel_Whizible2_Dept_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetOpenTicketsDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label><%= MyBase.GetResourceString("C_Customer") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                            
                              <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_CustFilter_Open_ID", "usp_Sel_Whizible2_Cust_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetOpenTicketsDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="">
                        <table id="tbl_TicketsDetails_Open" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-0" style="width:100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_ID") %></th>
                                    <th class="col-sm-2"><%= MyBase.GetResourceString("C_Subject") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Request_Type") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Priority") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor_Name") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requested_On") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Last_Updated") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Exp._Date_of_Resol..") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Status") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Assigned_To") %></th>                                
                                </tr>
                            </thead>
                            <tbody id ="offcanvasDynamicAppendData_Open">
                              
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- More Details for Tickets  Offcanvas Section ends -->












     
         <!-- More Details for Tickets  Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
             id="moredetails_OffcvsScreen_Unassigned" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                               <span> <%= MyBase.GetResourceString("C_Tickets_Details") %></span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="Ticketes_Tab_Unassigned" class="CountryInfo">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label><%= MyBase.GetResourceString("C_Department") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                                  
             <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_Unassigned_ID", "usp_Sel_Whizible2_Dept_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetUnassignedTicketsDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label><%= MyBase.GetResourceString("C_Customer") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                            
                              <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_CustFilter_Unassigned_ID", "usp_Sel_Whizible2_Cust_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetUnassignedTicketsDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="">
                        <table id="tbl_TicketsDetails_Unassigned" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-0" style="width:100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_ID") %></th>
                                    <th class="col-sm-2"><%= MyBase.GetResourceString("C_Subject") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Request_Type") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Priority") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor_Name") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requested_On") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Last_Updated") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Exp._Date_of_Resol..") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Status") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Assigned_To") %></th>                                
                                </tr>
                            </thead>
                            <tbody id ="offcanvasDynamicAppendData_Unassigned">
                              
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- More Details for Tickets  Offcanvas Section ends -->

     
         <!-- More Details for Tickets  Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
             id="moredetails_OffcvsScreen_HighPriority" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                               <span> <%= MyBase.GetResourceString("C_Tickets_Details") %></span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="Ticketes_Tab_HighPriority" class="CountryInfo">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label><%= MyBase.GetResourceString("C_Department") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                       
             <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_HighPriority_ID", "usp_Sel_Whizible2_Dept_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetHighPriorityTicketsDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                  <label><%= MyBase.GetResourceString("C_Customer") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                           
                              <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_CustFilter_HighPriority_ID", "usp_Sel_Whizible2_Cust_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetHighPriorityTicketsDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="">
                        <table id="tbl_TicketsDetails_HighPriority" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-0" style="width:100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_ID") %></th>
                                    <th class="col-sm-2"><%= MyBase.GetResourceString("C_Subject") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Request_Type") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Priority") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor_Name") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requested_On") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Last_Updated") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Exp._Date_of_Resol..") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Status") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Assigned_To") %></th>                                  
                                </tr>
                            </thead>
                            <tbody id ="offcanvasDynamicAppendData_HighPriority">
                               
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- More Details for Tickets  Offcanvas Section ends -->


          <!-- More Details for Tickets  Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
             id="moredetails_OffcvsScreen_MonthCSAT" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                               <span> <%= MyBase.GetResourceString("C_Tickets_Details") %></span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="Ticketes_Tab_HighPriority_MonthCSAT" class="CountryInfo">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label><%= MyBase.GetResourceString("C_Department") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                          
             <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_MonthCSAT_ID", "usp_Sel_Whizible2_Dept_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetCSATTicketDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                  <label><%= MyBase.GetResourceString("C_Customer") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                                  
                              <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_CustFilter_MonthCSAT_ID", "usp_Sel_Whizible2_Cust_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetCSATTicketDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="">
                        <table id="tbl_TicketsDetails_MonthCSAT" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-0" style="width:100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                   <th class="col-sm-1"><%= MyBase.GetResourceString("C_ID") %></th>
                                    <th class="col-sm-2"><%= MyBase.GetResourceString("C_Subject") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Request_Type") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Priority") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor_Name") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requested_On") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Last_Updated") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Exp._Date_of_Resol..") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Status") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Assigned_To") %></th>                                  
                                </tr>
                            </thead>
                            <tbody id ="offcanvasDynamicAppendData_MonthCSAT">

                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- More Details for Tickets  Offcanvas Section ends -->

          <!-- More Details for Tickets  Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
             id="moredetails_OffcvsScreen_CustOpen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                               <span> <%= MyBase.GetResourceString("C_Tickets_Details") %></span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="Ticketes_Tab_HighPriority_CustOpen" class="CountryInfo">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label><%= MyBase.GetResourceString("C_Department") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                                  
             <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_CustOpen_ID", "usp_Sel_Whizible2_Dept_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetCustOpenicketDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                  <label><%= MyBase.GetResourceString("C_Customer") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                         
                              <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_CustFilter_CustOpen_ID", "usp_Sel_Whizible2_Cust_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetCustOpenicketDetails();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="">
                        <table id="tbl_TicketsDetails_CustOpen" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-0" style="width:100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_ID") %></th>
                                    <th class="col-sm-2"><%= MyBase.GetResourceString("C_Subject") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Request_Type") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Priority") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor_Name") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requested_On") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Last_Updated") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Exp._Date_of_Resol..") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Status") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Assigned_To") %></th>                                   
                                </tr>
                            </thead>
                            <tbody id ="offcanvasDynamicAppendData_CustOpen">
                              
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- More Details for Tickets  Offcanvas Section ends -->


         <!-- More Details for Tickets  Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
             id="moredetails_OffcvsScreen_Breached" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                               <span> <%= MyBase.GetResourceString("C_Tickets_Details") %></span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="Ticketes_Tab_HighPriority_Breached" class="CountryInfo">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label><%= MyBase.GetResourceString("C_Department") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                                 
             <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_Breached_ID", "usp_Sel_Whizible2_Dept_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetBreachedTicketDetailsAccEmp();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                  <label><%= MyBase.GetResourceString("C_Customer") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                             
                              <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_CustFilter_Breached_ID", "usp_Sel_Whizible2_Cust_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetBreachedTicketDetailsAccEmp();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="">
                        <table id="tbl_TicketsDetails_Breached" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-0" style="width:100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_ID") %></th>
                                    <th class="col-sm-2"><%= MyBase.GetResourceString("C_Subject") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Request_Type") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Priority") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor_Name") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requested_On") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Last_Updated") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Exp._Date_of_Resol..") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Status") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Assigned_To") %></th>
                                  
                                </tr>
                            </thead>
                            <tbody id ="offcanvasDynamicAppendData_Breached">
                               
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- More Details for Tickets  Offcanvas Section ends -->
                         
         <!-- More Details for Tickets  Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
             id="moredetails_OffcvsScreen_unBreached" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                               <span> <%= MyBase.GetResourceString("C_Tickets_Details") %></span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="Ticketes_Tab_HighPriority_unBreached" class="CountryInfo">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label><%= MyBase.GetResourceString("C_Department") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                                 
                 <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_Unbreached_ID", "usp_Sel_Whizible2_Dept_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetUnbreachedTicketDetailsAccEmp();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                  <label><%= MyBase.GetResourceString("C_Customer") %></label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">                                 
                              <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_CustFilter_Unbreached_ID", "usp_Sel_Whizible2_Cust_Dropdown_tbl_CRM_Query_Master",,, "onchange = 'GetUnbreachedTicketDetailsAccEmp();' class='form-select ' ", , ,) %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="">
                        <table id="tbl_TicketsDetails_unBreached" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-0" style="width:100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_ID") %></th>
                                    <th class="col-sm-2"><%= MyBase.GetResourceString("C_Subject") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Request_Type") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Priority") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requestor_Name") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Requested_On") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Last_Updated") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Exp._Date_of_Resol..") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Status") %></th>
                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_Assigned_To") %></th>
                                  
                                </tr>
                            </thead>
                            <tbody id ="offcanvasDynamicAppendData_unBreached">
                                
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- More Details for Tickets  Offcanvas Section ends -->

    </div>
    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->

    <%Else %>
    <div >
          <div class="alert alert-danger" role="alert">
     <%= MyBase.GetResourceString("C_Not_Authorized") %>
    </div>
    </div>
    <%End If %>



    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <!--<script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>-->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script type="text/javascript">

        function resizeSection() {
            var tblheight = $(window).height();
            $('#tbl_TicketsDetails_Open_wrapper .dataTables_scroll #offcanvasDynamicAppendData_Open').css({ 'height': tblheight - 250, "overflow-y": "auto" });
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserId = '<%= Session("intUserID") %>';
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Helpdesk").ToString()%>'
        var UserName = '<%= Session("strUserName") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
      


       // These two array is today achieved SLA ID and Active Breached and Unbreached ID's are there .
        var queryId = [];
        var slaqueryId = [];
        var activeBreahedSLADetailsID = [];
        var activeUnBreahedSLADetailsID = [];
        var sla_ActiveTarget_PriorID = [];
        var today_SLA_Percentage = 0;
        var yesterday_percent=0;


        var TotalPages = 0;
        var TotalPagesCount;
        var isNextDisabled = false;
        var isPreviousDisabled = false;
        var PageNumber;
        var PageCounter = 1;
        var selectedRows = [];


       // Added by Vyankat B on December 19, 2024, to initialize various functions for retrieving ticket counts and employee-specific data in the document.ready function.

        $(document).ready(function () {
            
            GetHRMLogin();
            GetCountOfUnassignedTickets();
            GetCountOfHighPriorityTickets();
            IsValidId();
            GetCountOfOpenTickets();
            GetCountOfOpenTickPriority();
            GetCustOpenTickCountAccoEMP();
            GetResCloTickCountAccoEMP();
            GetNewticketvsClosTickCountAccoEMP();
            GetOverallCSATAccoEMP();
            GetSLABreachedQueryIDTickAccEmp();
            GetSelMonthlyCSATAccEmp();
            GetSLARecentlyBreachedTickets();
            GetCustomerFeedbackAccEmp();
            GetCustomerFeedbackPercentageAccEmp();
            GetProfileDetails();
            GetSLAQueryID_Tick_Acc_Emp();
            GetSelSLAPriorTick_Acc_Emp();
            updateIcon();

        });
        //End of Added by Vyankat B on December 19, 2024, to initialize various functions for retrieving ticket counts and employee-specific data in the document.ready function.


        //Added By Vyankat B On 25th Nov 2024 for  To get the all customer under login HRM      
        var toggleEmployee ;
        function GetHRMLogin() {
           ;

            var Parameters = {
                CustomerID: SessionEmployeeId
            };

            var  result = AJAXCallWithResult("/api/SupportEngineerDashboard/GetHRMLogin", Parameters, false);

            if (result && result.length > 0) {

                toggleEmployee = "";

                result.forEach(employee => {

                    toggleEmployee += employee.EmployeeID + ", ";
                });                          
            }     
        }
        // End of Added By Vyankat B On 25th Nov 2024 If Billing Currency not set then should consider IR currency


       // Added by Vyankat B on December 19, 2024, to convert the date into a formatted date format.
        function formatDate(strDate) {

            var date = new Date(strDate);

            var day = date.getDate();
            var month = date.toLocaleString('en-us', { month: 'short' });
            var year = date.getFullYear();

            return `${day} ${month} ${year}`;
        }
        //End of  Added by Vyankat B on December 19, 2024, to convert the date into a formatted date format.


        //Added By Vyankat B On 25th Nov 2024 for  the to reset the previous selected data in the deatils table
        function resetUnassignedTicketsDetails() {

            PageNumber = 1;

            $('#ddl_DeptFilter_Unassigned_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_Unassigned_ID').prop('selectedIndex', 0);
         
            GetUnassignedTicketsDetails();
        }
        //End of Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table


        //Added By Vyankat B On 25th Nov 2024 for  To get  all unassigned Ticket details  
        function GetUnassignedTicketsDetails() {

            let PageNumber = PageCounter;

            $("#tbl_TicketsDetails_Unassigned").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Unassigned").empty();

            if (element) {
                var Employee = UserName;
            } else {
                var Employee = $('#dd_EMPFilter_ID').val();
            }
            

            DepartmentName = $('#ddl_DeptFilter_Unassigned_ID').val();
            CustomerName = $('#ddl_CustFilter_Unassigned_ID').val();
            var Parameters = {
                EmployeeID: Employee.toString(),
                CustomerID: CustomerName,
                Department: DepartmentName,
                PageNo: PageNumber.toString()
            }

            var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/GetUnassignedTicketsDetails",Parameters, false);
            console.log(strResult);

            if (strResult != undefined) {
                var newrow = "";

                for (i = 0; i < strResult.length; i++ ) {

                    newrow += `<tr>
                    <td>
                        ${strResult[i].QueryID}
                    </td>
                    <td>
                        ${strResult[i].Subject}
                    </td>
                    <td>
                        ${strResult[i].RequestType}
                    </td>
                    <td>
                        ${strResult[i].Priority}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${formatDate(strResult[i].SubmittedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ModifiedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ExpectedResolvedDate)}
                    </td>
                    <td>
                        <div class="statusDiv d-flex justify-content-start">
                            <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                            <a href="javascript:;">
                                <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                            </a>
                        </div>
                    </td>

                    <td>
                     <div class="statusDiv d-flex justify-content-start">
                           ${strResult[i].AssignToName || 'Unassigned'}
                        </div>
                    </td>

                    <!--<td>
                        <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#UnitOffcvsScreen" aria-controls="offcanvasWithBothOptions">
                            <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">${strResult[i].AssignToName}</i>
                        </a>
                    </td>-->
                </tr>`
                }

                $("#offcanvasDynamicAppendData_Unassigned").append(newrow);

                $('#tbl_TicketsDetails_Unassigned').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false,
                    "scrollY": true,

                });
                updatePaginationButtons_Uassigned(strResult.length, PageNumber);

            }
            else {
                return;
            }
        }
        //End of Added By Vyankat B On 25th Nov 2024 for  To get  all unassigned Ticket details 



        // Added By Vyankat B On 6th jan 2025 for the pagination 
        function updatePaginationButtons_Uassigned(recordCount, currentPage) {




            if (currentPage === 1) {
                $('#tbl_TicketsDetails_Unassigned_previous').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_Unassigned_previous').removeClass('disabled').on('click', function () {
                    console.log('Previous button clicked for High Priority Tickets!');
                    PageCounter--;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetUnassignedTicketsDetails();
                });
            }

            if (recordCount < 10) {
                $('#tbl_TicketsDetails_Unassigned_next').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_Unassigned_next').removeClass('disabled').on('click', function () {
                    console.log('Next button clicked for High Priority Tickets!');
                    PageCounter++;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetUnassignedTicketsDetails();
                });
            }
        }
        //End of Added By Vyankat B On 6th jan 2025 for the pagination 




        //Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected in the details page
        function resetOpenTicketsDetails() {

            PageCounter = 1;
            $('#ddl_DeptFilter_Open_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_Open_ID').prop('selectedIndex', 0);

            GetOpenTicketsDetails();
        }
        // End of Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected in the details page


        //Added By Vyankat B On 25th Nov 2024 for  To get  Open Tickets details
        function GetOpenTicketsDetails() {

            let PageNumber = PageCounter;


            $("#tbl_TicketsDetails_Open").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Open").empty();
          
           

            if (element) {

                Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];

            } else {
                Employee = $('#dd_EMPFilter_ID').val();
            }                      
                DepartmentName = $('#ddl_DeptFilter_Open_ID').val();
                CustomerName = $('#ddl_CustFilter_Open_ID').val();

                var Parameters = {
                    EmployeeID: Employee.toString(),
                    Department: DepartmentName,
                    CustomerID: CustomerName,
                    PageNo: PageNumber.toString()
                }

                var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/GetOpenTicketDetails", Parameters, false);
                console.log(strResult);

                if (strResult != undefined) {
                    var newrow = "";

                    for (i = 0; i < strResult.length; i++) {

                        newrow += `<tr>
                    <td>
                        ${strResult[i].QueryID}
                    </td>
                    <td>
                        ${strResult[i].Subject}
                    </td>
                    <td>
                        ${strResult[i].RequestType}
                    </td>
                    <td>
                        ${strResult[i].Priority}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${formatDate(strResult[i].SubmittedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ModifiedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ExpectedResolvedDate)}
                    </td>
                    <td>
                        <div class="statusDiv d-flex justify-content-start">
                            <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                            <a href="javascript:;">
                                <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                            </a>
                        </div>
                    </td>
                   
                    <td>

                    <div class="statusDiv d-flex justify-content-start">
                           ${strResult[i].AssignToName}
                        </div>

                       
                    </td>
                </tr>`
                    }

                    $("#offcanvasDynamicAppendData_Open").append(newrow);

                    $('#tbl_TicketsDetails_Open').dataTable({
                        "paging": true,
                        "pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": false,
                        "retrieve": true,
                        "bAutoWidth": false,
                        "info": false,
                        "scrollY": true,
                        "scrollX": true,

                    });
                    $('#tbl_TicketsDetails_Open').wrap('<div class="dataTables_scroll" />');
                    updatePaginationButtons_Open(strResult.length, PageNumber);

                }


        }             
        // End of Added By Vyankat B On 25th Nov 2024 for  To get  Open Tickets details


        function updatePaginationButtons_Open(recordCount, currentPage) {




            if (currentPage === 1) {
                $('#tbl_TicketsDetails_Open_previous').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_Open_previous').removeClass('disabled').on('click', function () {
                    console.log('Previous button clicked for High Priority Tickets!');
                    PageCounter--;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetOpenTicketsDetails();
                });
            }

            if (recordCount < 10) {
                $('#tbl_TicketsDetails_Open_next').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_Open_next').removeClass('disabled').on('click', function () {
                    console.log('Next button clicked for High Priority Tickets!');
                    PageCounter++;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetOpenTicketsDetails();
                });
            }
        }




        //Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table
        function resetCSATTicketDetails() {

            PageCounter = 1;

            $('#ddl_DeptFilter_MonthCSAT_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_MonthCSAT_ID').prop('selectedIndex', 0);

            GetCSATTicketDetails();
        }
        //End of Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table


        //Added By Vyankat B On 25th Nov 2024 for To get  CSAT Ticket Details
        function GetCSATTicketDetails() {

            let PageNumber = PageCounter;


            $("#tbl_TicketsDetails_MonthCSAT").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_MonthCSAT").empty();

            if (element) {

                Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];

            } else {
                Employee = $('#dd_EMPFilter_ID').val();
            }
                DepartmentName = $('#ddl_DeptFilter_MonthCSAT_ID').val();
                CustomerName = $('#ddl_CustFilter_MonthCSAT_ID').val();
            var Parameters = {
                    EmployeeID: Employee.toString(),
                    Department: DepartmentName,
                    CustomerID: CustomerName,
                    PageNo: PageNumber.toString()

                }

                var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/GetCSATTicketDetails", Parameters, false);
                console.log(strResult);

                if (strResult != undefined) {
                    var newrow = "";

                    for (i = 0; i < strResult.length; i++) {

                        newrow += `<tr>
                    <td>
                        ${strResult[i].QueryID}
                    </td>
                    <td>
                        ${strResult[i].Subject}
                    </td>
                    <td>
                        ${strResult[i].RequestType}
                    </td>
                    <td>
                        ${strResult[i].Priority}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${formatDate(strResult[i].SubmittedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ModifiedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ExpectedResolvedDate)}
                    </td>
                    <td>
                        <div class="statusDiv d-flex justify-content-start">
                            <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                            <a href="javascript:;">
                                <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                            </a>
                        </div>
                    </td>
                    <td>
                         <div class="statusDiv d-flex justify-content-start">
                           ${strResult[i].AssignToName}
                        </div>
                   </td>
                    <!--<td>
                        <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#UnitOffcvsScreen" aria-controls="offcanvasWithBothOptions">
                            <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">${strResult[i].AssignToName}</i>
                        </a>
                    </td>-->
                </tr>`
                    }

                    $("#offcanvasDynamicAppendData_MonthCSAT").append(newrow);

                    $('#tbl_TicketsDetails_MonthCSAT').dataTable({
                        "paging": true,
                        "pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": false,
                        "retrieve": true,
                        "bAutoWidth": false,
                        "info": false,
                        "scrollY": true,
                        "scrollX": true,

                    });

                    updatePaginationButtons_MonthlyCSAT(strResult.length, PageNumber);
                }
        }         
        //End of Added By Vyankat B On 25th Nov 2024 for To get  CSAT Ticket Details 



        //Added By Vyankat B On 6th jan 2025 for the pagination 
        function updatePaginationButtons_MonthlyCSAT(recordCount, currentPage) {




            if (currentPage === 1) {
                $('#tbl_TicketsDetails_MonthCSAT_previous').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_MonthCSAT_previous').removeClass('disabled').on('click', function () {
                    console.log('Previous button clicked for High Priority Tickets!');
                    PageCounter--;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetCSATTicketDetails();
                });
            }

            if (recordCount < 10) {
                $('#tbl_TicketsDetails_MonthCSAT_next').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_MonthCSAT_next').removeClass('disabled').on('click', function () {
                    console.log('Next button clicked for High Priority Tickets!');
                    PageCounter++;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetCSATTicketDetails();
                });
            }
        }
        //End of Added By Vyankat B On 6th jan 2025 for the pagination 



        //Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table
        function resetCustOpenicketDetails() {
           
            PageCounter = 1;

            $('#ddl_DeptFilter_CustOpen_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_CustOpen_ID').prop('selectedIndex', 0);

            GetCustOpenicketDetails();
        }
        //End of Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table


        //Added By Vyankat B On 25th Nov 2024 for To get  Customer Open Tickets Details 
        function GetCustOpenicketDetails() {
            
            let PageNumber = PageCounter;

            $("#tbl_TicketsDetails_CustOpen").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_CustOpen").empty();

            if (element) {

                Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];

            } else {
                Employee = $('#dd_EMPFilter_ID').val();
            }

            DepartmentName = $('#ddl_DeptFilter_CustOpen_ID').val();
            CustomerName = $('#ddl_CustFilter_CustOpen_ID').val();
            var Parameters = {
                EmployeeID: Employee.toString(),
                Department: DepartmentName,
                CustomerID: CustomerName,
                PageNo: PageNumber.toString()

            }

            var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/GetCustOpenicketDetails", Parameters, false);
            console.log(strResult);

            if (strResult != undefined) {
                var newrow = "";

                for (i = 0; i < strResult.length; i++) {

                    newrow += `<tr>
                    <td>
                        ${strResult[i].QueryID}
                    </td>
                    <td>
                        ${strResult[i].Subject}
                    </td>
                    <td>
                        ${strResult[i].RequestType}
                    </td>
                    <td>
                        ${strResult[i].Priority}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${formatDate(strResult[i].SubmittedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ModifiedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ExpectedResolvedDate)}
                    </td>
                    <td>
                        <div class="statusDiv d-flex justify-content-start">
                            <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                            <a href="javascript:;">
                                <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                            </a>
                        </div>
                    </td>
                    <td>
                         <div class="statusDiv d-flex justify-content-start">
                           ${strResult[i].AssignToName}
                        </div>
                     </td>
                    <!--<td>
                        <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#UnitOffcvsScreen" aria-controls="offcanvasWithBothOptions">
                            <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">${strResult[i].AssignToName}</i>
                        </a>
                    </td>-->
                </tr>`
                }

                $("#offcanvasDynamicAppendData_CustOpen").append(newrow);

                $('#tbl_TicketsDetails_CustOpen').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false,
                    "scrollY": true,
                    "scrollX": true,

                });

                updatePaginationButtons_CustOpenTkt(strResult.length, PageNumber);
            }
        }
        //End of Added By Vyankat B On 25th Nov 2024 for To get  Customer Open Tickets Details 



        //Added By Vyankat B On 6th jan 2025 for the pagination 
        function updatePaginationButtons_CustOpenTkt(recordCount, currentPage) {




            if (currentPage === 1) {
                $('#tbl_TicketsDetails_CustOpen_previous').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_CustOpen_previous').removeClass('disabled').on('click', function () {
                    console.log('Previous button clicked for High Priority Tickets!');
                    PageCounter--;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetCustOpenicketDetails();
                });
            }

            if (recordCount < 10) {
                $('#tbl_TicketsDetails_CustOpen_next').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_CustOpen_next').removeClass('disabled').on('click', function () {
                    console.log('Next button clicked for High Priority Tickets!');
                    PageCounter++;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetCustOpenicketDetails();
                });
            }
        }
        //End of Added By Vyankat B On 6th jan 2025 for the pagination 



        //Added By Vyankat B On 25th Nov 2024 for To calculate the Count Of Unassigned Tickets
        var Employee;
        function GetCountOfUnassignedTickets() {
         

            if (element) {
                var Employee = SessionEmployeeId;
            } else {
                var Employee = $('#dd_EMPFilter_ID').val();

            }                      
                var Parameters = {
                    EmployeeID: Employee.toString()

                }

                var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/UnassignedTicketsCount", Parameters, false);
                console.log(strResult);

                if (strResult !== null) {
                    $("#spn_UnassignedTickets_ID").text(strResult);

                }
                else {
                    return;
                }
                     
        }
        //End of Added By Vyankat B On 25th Nov 2024 for To calculate the Count Of Unassigned Tickets


        //Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table
        function resetHighPriorityTicketsDetails() {

            PageCounter = 1;

            $('#ddl_DeptFilter_HighPriority_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_HighPriority_ID').prop('selectedIndex', 0);

            GetHighPriorityTicketsDetails();
        }
        //End of Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table


        // Added By Vyankat B On 25th Nov 2024 for To get High Priority Tickets Details
        function GetHighPriorityTicketsDetails() {
           

            let TotalPages = 0;
            let PageNumber = PageCounter;

            selectedRows.length = 0;

            $("#tbl_TicketsDetails_HighPriority").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_HighPriority").empty();

            let Employee = element
                ? (toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [])
                : $('#dd_EMPFilter_ID').val();

            let DepartmentName = $('#ddl_DeptFilter_HighPriority_ID').val();
            let CustomerName = $('#ddl_CustFilter_HighPriority_ID').val();

            let Parameters = {
                EmployeeID: Employee.toString(),
                Department: DepartmentName,
                CustomerID: CustomerName,
                PageNo: PageNumber.toString()
            };

            var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/HighPriorityTicketsDetails", Parameters, false);
            console.log(strResult);

            if (strResult && strResult.length > 0) {
                let newrow = "";
                strResult.forEach(ticket => {
                    newrow += `
            <tr>
                <td>${ticket.QueryID}</td>
                <td>${ticket.Subject}</td>
                <td>${ticket.RequestType}</td>
                <td>${ticket.Priority}</td>
                <td>${ticket.CustomerID}</td>
                <td>${ticket.CustomerID}</td>
                <td>${formatDate(ticket.SubmittedDate)}</td>
                <td>${formatDate(ticket.ModifiedDate)}</td>
                <td>${formatDate(ticket.ExpectedResolvedDate)}</td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                        <a href="javascript:;">
                            <label class="crsrLink" data-bs-toggle="tooltip" title="Open">${ticket.Status}</label>
                        </a>
                    </div>
                </td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        ${ticket.AssignToName}
                    </div>
                </td>
            </tr>`;
                });

                $("#offcanvasDynamicAppendData_HighPriority").append(newrow);

                $('#tbl_TicketsDetails_HighPriority').dataTable({
                    paging: true,
                    pageLength: 10,
                    bLengthChange: false,
                    bFilter: false,
                    ordering: false,
                    responsive: true,
                    destroy: false,
                    retrieve: true,
                    bAutoWidth: false,
                    info: false,
                    scrollY: true,
                    scrollX: true
                });

                updatePaginationButtons_HighPrior(strResult.length, PageNumber);
            }
        }

        //Added By Vyankat B On 6th jan 2025 for the pagination 
        function updatePaginationButtons_HighPrior(recordCount, currentPage) {




            if (currentPage === 1) {
                $('#tbl_TicketsDetails_HighPriority_previous').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_HighPriority_previous').removeClass('disabled').on('click', function () {
                    console.log('Previous button clicked for High Priority Tickets!');
                    PageCounter--;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetHighPriorityTicketsDetails();
                });
            }

            if (recordCount < 10) { 
                $('#tbl_TicketsDetails_HighPriority_next').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_HighPriority_next').removeClass('disabled').on('click', function () {
                    console.log('Next button clicked for High Priority Tickets!');
                    PageCounter++;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetHighPriorityTicketsDetails();
                });
            }
        }
        //End of Added By Vyankat B On 6th jan 2025 for the pagination 

       
    


        //Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table
        function resetUnbreachedTicketDetailsAccEmp() {

            PageCounter = 1;

            $('#ddl_DeptFilter_Unbreached_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_Unbreached_ID').prop('selectedIndex', 0);
            GetUnbreachedTicketDetailsAccEmp();
        }
        //End of Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table


        // Added By Vyankat B On 25th Nov 2024 for To get Unbreached Ticket Details 
        function GetUnbreachedTicketDetailsAccEmp() {

            let PageNumber = PageCounter;


            $("#tbl_TicketsDetails_unBreached").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_unBreached").empty();

            Employee = $('#dd_EMPFilter_ID').val();
        
            DepartmentName = $('#ddl_DeptFilter_Unbreached_ID').val();
            CustomerName = $('#ddl_CustFilter_Unbreached_ID').val();
           
            var Parameters = {
                STRResultQueryId: activeUnBreahedSLADetailsID.join(','),
                Department: DepartmentName,
                CustomerID: CustomerName,
                PageNo: PageNumber.toString()

            }

            var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/GetUnbreachedTicketsDetailsAccEmp", Parameters, false);
            console.log(strResult);

            if (strResult != undefined) {
                var newrow = "";

                for (i = 0; i < strResult.length; i++) {

                    newrow += `<tr>
                    <td>
                        ${strResult[i].QueryID}
                    </td>
                    <td>
                        ${strResult[i].Subject}
                    </td>
                    <td>
                        ${strResult[i].RequestType}
                    </td>
                    <td>
                        ${strResult[i].Priority}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${formatDate(strResult[i].SubmittedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ModifiedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ExpectedResolvedDate)}
                    </td>
                    <td>
                        <div class="statusDiv d-flex justify-content-start">
                            <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                            <a href="javascript:;">
                                <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                            </a>
                        </div>
                    </td>
                    <td>
                          <div class="statusDiv d-flex justify-content-start">
                           ${strResult[i].AssignToName}
                        </div>
                      </td>
                    <!--<td>
                        <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#UnitOffcvsScreen" aria-controls="offcanvasWithBothOptions">
                            <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">${strResult[i].AssignToName}</i>
                        </a>
                    </td>-->
                </tr>`
                }

                $("#offcanvasDynamicAppendData_unBreached").append(newrow);

                $('#tbl_TicketsDetails_unBreached').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false,
                    "scrollY": true,
                    "scrollX": true,

                });

                updatePaginationButtons_Unbreached(strResult.length, PageNumber);


            }
            else {
                return;
            }
        }
        // End of Added By Vyankat B On 25th Nov 2024 for To get Unbreached Ticket Details 



        //Added By Vyankat B On 6th jan 2025 for the pagination 
        function updatePaginationButtons_Unbreached(recordCount, currentPage) {




            if (currentPage === 1) {
                $('#tbl_TicketsDetails_unBreached_previous').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_unBreached_previous').removeClass('disabled').on('click', function () {
                    console.log('Previous button clicked for High Priority Tickets!');
                    PageCounter--;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetUnbreachedTicketDetailsAccEmp();
                });
            }

            if (recordCount < 10) {
                $('#tbl_TicketsDetails_unBreached_next').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_unBreached_next').removeClass('disabled').on('click', function () {
                    console.log('Next button clicked for High Priority Tickets!');
                    PageCounter++;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetUnbreachedTicketDetailsAccEmp();
                });
            }
        }
        //End of Added By Vyankat B On 6th jan 2025 for the pagination 


        // Added By Vyankat B On 25th Nov 2024 for the calculate the percentage  of High Priority Tickets

        var Employee;
        function GetCountOfHighPriorityTickets() {

           

          if (element) {

               Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];
            } else {
                Employee = $('#dd_EMPFilter_ID').val();

          }

          var Parameters = {
             EmployeeID: Employee.toString()
          }
          var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/HighPriorityTicketsCount", Parameters, false);
          console.log(strResult);

          if (strResult !== null) {

             $("#spn_highPriorityTickets_ID").text(strResult + "%");
          }
        }               
        //End of  Added By Vyankat B On 25th Nov 2024 for the calculate the percentage  of High Priority Tickets

     
        //Added By Vyankat B On 25th Nov 2024 for the to check the login Employee ID is HRM or not  the percentage .
        var isIdPresent = false;
        function IsValidId() {
            
          
            var strResult1 = AJAXCallWithResult("/api/SupportEngineerDashboard/GetHRMID", '', false);
            console.log(strResult1);


            isIdPresent = strResult1.some(item => item.CRMID == SessionEmployeeId);
            return isIdPresent;
        }
        //End of  Added By Vyankat B On 25th Nov 2024 for the to check the login Employee ID is HRM or not  the percentage .


        //Added By Vyankat B On 25th Nov 2024 for the to if login Employee id is valid or not , if they are valid they  function will be execute 
        function isValidData() {
          
          

            if (!element) {

                if (IsValidId()) {

                    toggleSwitch(true);

                    GetResCloTickCountAccoEMP();
                    GetNewticketvsClosTickCountAccoEMP();
                    GetCountOfOpenTickets();
                    GetCustomerFeedbackAccEmp();
                    GetCustomerFeedbackPercentageAccEmp();
                    GetCountOfOpenTickPriority();
                    GetOverallCSATAccoEMP();
                    GetCountOfHighPriorityTickets();
                    GetSelMonthlyCSATAccEmp();

                    GetCustOpenTickCountAccoEMP(); //

                    GetSLABreachedQueryIDTickAccEmp();
                    GetSLAQueryID_Tick_Acc_Emp();
                    GetCountOfUnassignedTickets();
                    GetSelSLAPriorTick_Acc_Emp();
                   
                    GetSLARecentlyBreachedTickets();

                }
                else {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%= MyBase.GetResourceString("A_HRM_Login_Alert")  %>');

                    toggleSwitch(false);

                }
            }
            else {
                toggleSwitch(false);

                GetResCloTickCountAccoEMP();
                GetNewticketvsClosTickCountAccoEMP();
                GetCountOfOpenTickets();
                GetCustomerFeedbackAccEmp();
                GetCustomerFeedbackPercentageAccEmp();
                GetCountOfOpenTickPriority();
                GetOverallCSATAccoEMP();
                GetCountOfHighPriorityTickets();
                GetSelMonthlyCSATAccEmp();

                GetCustOpenTickCountAccoEMP();

                GetSLABreachedQueryIDTickAccEmp();
                GetSLAQueryID_Tick_Acc_Emp();
                GetCountOfUnassignedTickets();
                GetSelSLAPriorTick_Acc_Emp();
                GetSLARecentlyBreachedTickets();
            }

        }
        //End of Added By Vyankat B On 25th Nov 2024 for the to if login Employee id is valid or not , if they are valid they  function will be execute 


       //Added By Vyankat B On 25th Nov 2024 for the execute they all function  when i click on 'Select Employee' dropdown . 
        function filterEmployee() {

            toggleSwitch(false);

            GetProfileDetails();
            GetCountOfOpenTickets();
            GetCustomerFeedbackAccEmp();
            GetCustomerFeedbackPercentageAccEmp();
            GetSelMonthlyCSATAccEmp();
            GetCustOpenTickCountAccoEMP();
            GetNewticketvsClosTickCountAccoEMP();
            GetCountOfOpenTickPriority();
            GetOverallCSATAccoEMP();
            GetCountOfHighPriorityTickets();
            GetResCloTickCountAccoEMP();
            GetSLAQueryID_Tick_Acc_Emp();
            GetSLABreachedQueryIDTickAccEmp();
            GetOpenTicketsDetails();
            GetCSATTicketDetails();
            GetHighPriorityTicketsDetails();
            GetCustOpenicketDetails();
            GetUnbreachedTicketDetailsAccEmp();
            GetBreachedTicketDetailsAccEmp();
            GetSelSLAPriorTick_Acc_Emp();
            GetCountOfUnassignedTickets();           
            GetSLARecentlyBreachedTickets();
            updateIcon();
           
        }
        //End of Added By Vyankat B On 25th Nov 2024 for the execute they all function  when i click on 'Select Employee' dropdown . 


        //Added By Vyankat B On 25th Nov 2024  they are used for when i click on the toggle button that btn value set to 'True/False' .
        var element; 
        function toggleSwitch(state) {
           ;
          
            $('#btn_switch_ID').prop('checked', state);
           
            element = $('#btn_switch_ID').prop('checked');
            console.log(`Switch programmatically set to ${state ? "ON" : "OFF"}`);
            console.log("Current state of switch stored in element:", element);
           
            $('#btn_switch_ID').trigger('change');
          
            if (element) {
                console.log("Switch is checked.");
            } else {
                console.log("Switch is not checked.");
            }
        }
       //End of Added By Vyankat B On 25th Nov 2024  they are used for when i click on the toggle button that btn value set to 'True/False' .


       //Added By Vyankat B On 25th Nov 2024  they are used for calculating the Open Tickets Count  .
         var EmployeeID;
         function GetCountOfOpenTickets() {
       
        
             if (element) {

                 Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];
             } else {
                 Employee = $('#dd_EMPFilter_ID').val();
             }
             var Parameters = {
                EmployeeID: Employee.toString()
             }
            var strResult1 = AJAXCallWithResult("/api/SupportEngineerDashboard/GetOpenTickets", Parameters, false);
            console.log(strResult1);

           if (strResult1 !== null) {
               $("#spn_OpenTicketCount_ID").text(strResult1);

           }

         }
        //End of Added By Vyankat B On 25th Nov 2024  they are used for calculating the Open Tickets Count  .


        //Added By Vyankat B On 25th Nov 2024  they are used for calculating the priority of Open Tickets  .
        var Employee;
           function GetCountOfOpenTickPriority() {

               if (element) {

                   Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];

               } else {

                   Employee = $('#dd_EMPFilter_ID').val();

               }

                   var Parameters = {
                      EmployeeID: Employee.toString()
                   }

                   var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/GetOpenTickPrior", Parameters, false);
                   console.log(strResult);

                   if (strResult !== undefined && strResult.length > 0) {

                       let high_Prior_count = [];
                       let medium_Prior_count = [];
                       let small_Prior_count = [];

                       let high_CR_Prior_count = [];
                       let medium_CR_Prior_count = [];
                       let small_CR_Prior_count = [];

                       strResult.forEach(data => {

                           high_Prior_count.push(data.High_Open_Prior_Count);
                           medium_Prior_count.push(data.Medium_Open_Prior_Count);
                           small_Prior_count.push(data.Low_Open_Prior_Count);

                           high_CR_Prior_count.push(data.High_CR_Open_Prior_Count);
                           medium_CR_Prior_count.push(data.Medium_CR_Open_Prior_Count);
                           small_CR_Prior_count.push(data.Low_CR_Open_Prior_Count);
                       });

                       $("#p_HighOpenTickets_ID").text(high_Prior_count[0] + "%");
                       $("#p_MediumOpenTickets_ID").text(medium_Prior_count[0] + "%");
                       $("#p_LowOpenTickets_ID").text(small_Prior_count[0] + "%");

                       $("#p_C_HighOpenTickets_ID").text(high_CR_Prior_count[0] + "%");
                       $("#p_C_MediumOpenTickets_ID").text(medium_CR_Prior_count[0] + "%");
                       $("#p_C_LowOpenTickets_ID").text(small_CR_Prior_count[0] + "%");

                       const existingChart5 = Chart.getChart('HighOpenTickets');
                       if (existingChart5) {
                           existingChart5.destroy();
                       }

                       const ctx3 = document.getElementById('HighOpenTickets');
                       new Chart(ctx3, {
                           "chart": {
                               "showBorder": "2",
                           },
                           type: 'doughnut',
                           data: {
                               labels: ['High', ''],
                               datasets: [{
                                   label: false,
                                   data: high_Prior_count,
                                   borderWidth: 1,
                                   barThickness: 10,
                                   backgroundColor: ['#1748d5', '#ddd'],
                               }],

                           },
                           options: {
                               maintainAspectRatio: false,
                               responsive: true,
                               reverse: true,
                               cutout: '80%',
                               /*                radius: '50%',*/
                               plugins: {
                                   title: {
                                       display: true,
                                       text: '',
                                       color: '#414042',
                                       align: 'start',
                                       padding: {
                                           /*        bottom: 20*/
                                       },
                                       font: {
                                           // size: 18,
                                           // weight: 600
                                           size: 13,
                                           weight: 600

                                       }
                                   },
                                   legend: {
                                       display: false,
                                       position: 'bottom',
                                       reverse: true,

                                       labels: {
                                           color: '#414042',
                                           boxWidth: 20,
                                           boxHeight: 20,
                                       }
                                   }
                               }
                           }
                       });

                       // High level open tickets script End here
                       const existingChartHigh = Chart.getChart('C_HighOpenTickets');
                       if (existingChartHigh) {
                           existingChartHigh.destroy();
                       }

                       const ctxHigh = document.getElementById('C_HighOpenTickets');
                       new Chart(ctxHigh, {
                           "chart": {
                               "showBorder": "2",
                           },
                           type: 'doughnut',
                           data: {
                               labels: ['High', ''],
                               datasets: [{
                                   label: false,
                                   data: high_CR_Prior_count,
                                   borderWidth: 1,
                                   barThickness: 10,
                                   backgroundColor: ['#1748d5', '#ddd'],
                               }],

                           },
                           options: {
                               maintainAspectRatio: false,
                               responsive: true,
                               reverse: true,
                               cutout: '80%',
                               /*                radius: '50%',*/
                               plugins: {
                                   title: {
                                       display: true,
                                       text: '',
                                       color: '#414042',
                                       align: 'start',
                                       padding: {
                                           /*        bottom: 20*/
                                       },
                                       font: {
                                           // size: 18,
                                           // weight: 600
                                           size: 13,
                                           weight: 600

                                       }
                                   },
                                   legend: {
                                       display: false,
                                       position: 'bottom',
                                       reverse: true,

                                       labels: {
                                           color: '#414042',
                                           boxWidth: 20,
                                           boxHeight: 20,
                                       }
                                   }
                               }
                           }
                       });
                       // High level open tickets script End here






                       // Medium level open tickets script start here
                       const existingChart6 = Chart.getChart('MediumOpenTickets');
                       if (existingChart6) {
                           existingChart6.destroy();
                       }

                       const ctx4 = document.getElementById('MediumOpenTickets');
                       new Chart(ctx4, {
                           "chart": {
                               "showBorder": "2",
                           },
                           type: 'doughnut',
                           data: {
                               labels: ['Medium', ''],
                               datasets: [{
                                   label: false,
                                   data: medium_Prior_count,
                                   borderWidth: 1,
                                   barThickness: 10,
                                   backgroundColor: ['#ec23ed', '#ddd'],
                               }],

                           },
                           options: {
                               maintainAspectRatio: false,
                               responsive: true,
                               reverse: true,
                               cutout: '80%',
                               /*                radius: '50%',*/
                               plugins: {

                                   title: {
                                       display: true,
                                       text: '',
                                       color: '#414042',
                                       align: 'start',
                                       padding: {
                                           /*        bottom: 20*/
                                       },
                                       font: {
                                           // size: 18,
                                           // weight: 600
                                           size: 13,
                                           weight: 600

                                       }
                                   },
                                   doughnutlabel: {
                                       labels: [
                                           {
                                               text: '550',
                                               font: {
                                                   size: 90,
                                                   weight: 'bold',
                                               },
                                           },
                                           {
                                               text: 'total',
                                           },
                                       ],
                                   },
                                   legend: {
                                       display: false,
                                       position: 'bottom',
                                       reverse: true,

                                       labels: {
                                           color: '#414042',
                                           boxWidth: 20,
                                           boxHeight: 20,
                                       }
                                   }
                               }
                           }
                       });
                       // Medium level open tickets script End here  


                       // Medium level open tickets script start here
                       const existingChartM = Chart.getChart('C_MediumOpenTickets');
                       if (existingChartM) {
                           existingChartM.destroy();
                       }

                       const ctxM = document.getElementById('C_MediumOpenTickets');
                       new Chart(ctxM, {
                           "chart": {
                               "showBorder": "2",
                           },
                           type: 'doughnut',
                           data: {
                               labels: ['Medium', ''],
                               datasets: [{
                                   label: false,
                                   data: medium_CR_Prior_count,
                                   borderWidth: 1,
                                   barThickness: 10,
                                   backgroundColor: ['#ec23ed', '#ddd'],
                               }],

                           },
                           options: {
                               maintainAspectRatio: false,
                               responsive: true,
                               reverse: true,
                               cutout: '80%',
                               /*                radius: '50%',*/
                               plugins: {

                                   title: {
                                       display: true,
                                       text: '',
                                       color: '#414042',
                                       align: 'start',
                                       padding: {
                                           /*        bottom: 20*/
                                       },
                                       font: {
                                           // size: 18,
                                           // weight: 600
                                           size: 13,
                                           weight: 600

                                       }
                                   },
                                   doughnutlabel: {
                                       labels: [
                                           {
                                               text: '550',
                                               font: {
                                                   size: 90,
                                                   weight: 'bold',
                                               },
                                           },
                                           {
                                               text: 'total',
                                           },
                                       ],
                                   },
                                   legend: {
                                       display: false,
                                       position: 'bottom',
                                       reverse: true,

                                       labels: {
                                           color: '#414042',
                                           boxWidth: 20,
                                           boxHeight: 20,
                                       }
                                   }
                               }
                           }
                       });
                       // Medium level open tickets script End here

                       // Low level open tickets script start here
                       const existingChart7 = Chart.getChart('LowOpenTickets');
                       if (existingChart7) {
                           existingChart7.destroy();
                       }

                       const ctx5 = document.getElementById('LowOpenTickets');
                       new Chart(ctx5, {
                           "chart": {
                               "showBorder": "2",
                           },
                           type: 'doughnut',
                           data: {
                               labels: ['Low', ''],
                               datasets: [{
                                   label: false,
                                   data: small_Prior_count,
                                   borderWidth: 1,
                                   barThickness: 10,
                                   backgroundColor: ['#8da2f1', '#ddd'],
                               }],

                           },
                           options: {
                               maintainAspectRatio: false,
                               responsive: true,
                               reverse: true,
                               cutout: '80%',
                               /*                radius: '50%',*/
                               plugins: {
                                   title: {
                                       display: true,
                                       text: '',
                                       color: '#414042',
                                       align: 'start',
                                       padding: {
                                           /*        bottom: 20*/
                                       },
                                       font: {
                                           // size: 18,
                                           // weight: 600
                                           size: 13,
                                           weight: 600

                                       }
                                   },
                                   legend: {
                                       display: false,
                                       position: 'bottom',
                                       reverse: true,

                                       labels: {
                                           color: '#414042',
                                           boxWidth: 20,
                                           boxHeight: 20,
                                       }
                                   }
                               }
                           }
                       });
                   }
           }
        //End of Added By Vyankat B On 25th Nov 2024  they are used for calculating the priority of Open Tickets  .


        //Added By Vyankat B On 25th Nov 2024  they are used for calculating Customer Open Ticket count   .
        var Employee;
        function GetCustOpenTickCountAccoEMP() {                                
        

            if (element) {

                Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];

            } else {

                Employee = $('#dd_EMPFilter_ID').val();

            }
                var Parameters = {

                   EmployeeID: Employee.toString()

                }

                var strResult1 = AJAXCallWithResult("/api/SupportEngineerDashboard/GetCutOpenTickCount", Parameters, false);

                if (strResult1 !== null) {

                    let CustName = [];
                    let OpenTickCount = [];

                    strResult1.forEach(data => {

                        CustName.push(data.CustomerName);
                        OpenTickCount.push(data.Open_Ticket_Count);

                    });

                    const container = document.querySelector("#CustOpenTicket_ID");
                    container.innerHTML = "";
                    CustName.forEach((name, index) => {
                        const count = OpenTickCount[index];
                        const row = document.createElement("div");
                        row.classList.add("d-flex", "justify-content-between", "d-inline", "mt-2");
                        row.innerHTML = `
                      <div>${name}</div>
                      <div>${count}</div>
                            `;
                        container.appendChild(row);
                    });
                }

        }          
       //End of Added By Vyankat B On 25th Nov 2024  they are used for calculating Customer Open Ticket count   .
      

       //Added By Vyankat B On 25th Nov 2024  they are used for calculating percentage of Resolved and Closed Tickets    .
        var Employee;
        function GetResCloTickCountAccoEMP() {
           
            if (element) {
                Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];


            }else {
                Employee = $('#dd_EMPFilter_ID').val();

            }

            var Parameters = {

                EmployeeID: Employee.toString().toString()

            }

            var strResult1 = AJAXCallWithResult("/api/SupportEngineerDashboard/GetResCloTickCount", Parameters, false);


            if (strResult1 !== null) {


                let resolvedTickCount = [];

                let ClosedTickCount = [];


                strResult1.forEach(data => {


                    resolvedTickCount.push(data.resolved_count);

                    ClosedTickCount.push(data.closed_count);


                });


                $("#p_ResolTicket_ID").text(resolvedTickCount[0] + "%");

                $("#p_ClosTicket_ID").text(ClosedTickCount[0] + "%");


                const resolvedTickets = Chart.getChart('ResolvedTickets');


                if (resolvedTickets) {


                    resolvedTickets.destroy();


                }


                // High level open tickets script start here

                    const ctxRe = document.getElementById('ResolvedTickets');

                    new Chart(ctxRe, {

                        "chart": {

                            "showBorder": "2",

                        },
                        type: 'doughnut',
                        data: {
                            labels: ['Resolved', ''],
                            datasets: [{
                                label: false,
                                data: resolvedTickCount,
                                borderWidth: 1,
                                barThickness: 10,
                                backgroundColor: ['#0da31a', '#ddd'],
                            }],
                        },
                        options: {
                            maintainAspectRatio: false,
                            responsive: true,
                            reverse: true,
                            cutout: '80%',
                            plugins: {
                                title: {
                                    display: true,
                                    text: '',
                                    color: '#414042',
                                    align: 'start',
                                    padding: {
                                       
                                    },
                                    font: {                                     
                                        size: 13,
                                        weight: 600
                                    }
                                },
                                legend: {
                                    display: false,
                                    position: 'bottom',
                                    reverse: true,
                                    labels: {
                                        color: '#414042',
                                        boxWidth: 20,
                                        boxHeight: 20,
                                    }
                                }
                            }
                        }
                    });
                    // High level open tickets script End here


                    // Medium level open tickets script start here
                    const closeTickets = Chart.getChart('CloseTickets');

                    if (closeTickets) {

                        closeTickets.destroy();
                    }

                    const ctxClose = document.getElementById('CloseTickets');
                    new Chart(ctxClose, {
                        "chart": {
                            "showBorder": "2",
                        },
                        type: 'doughnut',

                        data: {
                            labels: ['Close', ''],
                            datasets: [{
                                label: false,
                                data: ClosedTickCount,
                                borderWidth: 1,
                                barThickness: 10,
                                backgroundColor: ['#ff9900', '#ddd'],
                            }],
                        },

                        options: {
                            maintainAspectRatio: false,
                            responsive: true,
                            reverse: true,
                            cutout: '80%',

                            plugins: {
                                title: {
                                    display: true,
                                    text: '',
                                    color: '#414042',
                                    align: 'start',
                                    padding: {                               
                                    },

                                    font: {
                                        
                                        size: 13,
                                        weight: 600
                                    }
                                },

                                doughnutlabel: {
                                    labels: [
                                        {
                                            text: '550',
                                            font: {
                                                size: 90,
                                                weight: 'bold',
                                            },

                                        },

                                        {
                                            text: 'total',
                                        },
                                    ],
                                },

                                legend: {

                                    display: false,
                                    position: 'bottom',
                                    reverse: true,

                                    labels: {
                                        color: '#414042',
                                        boxWidth: 20,
                                        boxHeight: 20,
                                    }
                                }
                            }
                        }
                    });

            }
        }
        //End of Added By Vyankat B On 25th Nov 2024  they are used for calculating percentage of Resolved and Closed Tickets    .

      
              //Added By Vyankat B On 25th Nov 2024  they are used for calculating count of New tickets and Closed Tickets .
              var Employee;
                function GetNewticketvsClosTickCountAccoEMP() {
               

                       if (element) {

                        Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];

                       } else {
                        Employee = $('#dd_EMPFilter_ID').val();
                       }
                        var Parameters = {
                           EmployeeID: Employee.toString()
                        }
                        var strResult1 = AJAXCallWithResult("/api/SupportEngineerDashboard/GetNewticketvsClosTickCount", Parameters, false);


                        if (strResult1 !== null) {
                            let dayCount = [];
                            let newTickCount = [];
                            let closedTickCount = [];

                            strResult1.forEach(data => {
                                dayCount.push(data.CurrentDate);
                                newTickCount.push(data.New_Ticket_Count);
                                closedTickCount.push(data.Closed_Count);
                            });

                            const tickets_VolumeChart1 = Chart.getChart('Tickets_VolumeChart');
                            if (tickets_VolumeChart1) {
                                tickets_VolumeChart1.destroy();
                            }

                            //get the line chart canvas
                            var ctx = $("#Tickets_VolumeChart");

                            //line chart data
                            var data = {
                                labels: dayCount,
                                datasets: [{
                                    label: "New",
                                    data: newTickCount,
                                    backgroundColor: "#2B55CE",
                                    borderColor: "#2B55CE",
                                    borderWidth: 1.5,
                                    fill: false,
                                    lineTension: 0,
                                    radius: 3
                                },
                                {
                                    label: "Closed",
                                    data: closedTickCount,
                                    backgroundColor: "#ff9900",
                                    borderColor: "#ff9900",
                                    borderWidth: 1.5,
                                    fill: false,
                                    lineTension: 0,
                                    radius: 3
                                },
                                ]
                            };

                            //options
                            var options = {
                                responsive: true,
                                plugins: {
                                    legend: {
                                        display: false
                                    }
                                },
                                scales: {
                                    y: {

                                        max: 25,
                                        min: 0,
                                        ticks: {
                                            color: '#0d0e0e',
                                            stepSize: 5
                                        },
                                        title: {
                                            display: true,
                                            text: 'No. / %',
                                            fontSize: 20,
                                            color: "black",
                                        },
                                    },
                                    x: {
                                        beginAtZero: true,
                                        scaleOverride: true,
                                        title: {
                                            display: true,
                                            text: 'Date',
                                            fontSize: 20,
                                            color: "black",
                                        },
                                    }

                                },
                                title: {
                                    display: true,
                                    position: "top",
                                    text: "Line Graph",
                                    fontSize: 18,
                                    fontColor: "#111"
                                },
                                legend: {
                                    display: true,
                                    position: "bottom",
                                    labels: {
                                        fontColor: "#333",
                                        fontSize: 16
                                    }
                                }
                            };

                            //create Chart class object
                            var chart = new Chart(ctx, {
                                type: "line",
                                data: data,
                                options: options
                            });
                        }
                }
               // End of Added By Vyankat B On 25th Nov 2024  they are used for calculating count of New tickets and Closed Tickets .


               //Added By Vyankat B On 25th Nov 2024 for the get of percentage of the overall CSAT  .
              var Employee;
               function GetOverallCSATAccoEMP() {
              

                   if (element) {

                       Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];
                   } else {
                       Employee = $('#dd_EMPFilter_ID').val();
                   }
                    var Parameters = {
                       EmployeeID: Employee.toString()
                    }
                    var strResult1 = AJAXCallWithResult("/api/SupportEngineerDashboard/GetOverallCSAT", Parameters, false);

                    if (strResult1 !== null) {
                        let csaPercentage = [];
                        let total_CSAT = [];

                        strResult1.forEach(data => {
                            csaPercentage.push(data.CSATpercentage);                           
                        });

                        if (csaPercentage[0] == null) {

                            $("#csatOverall").text("0%");
                        }

                        $("#csatOverall").text(csaPercentage[0] + "%");

                        const csat_Graph = Chart.getChart('SCAT_Graph');
                        if (csat_Graph) {
                            csat_Graph.destroy();
                        }

                        const ctx1 = document.getElementById('SCAT_Graph');

                         total_CSAT = [csaPercentage[0], 100 - csaPercentage[0]];

                        let labels = [];
                        let backgroundColor = [];

                        if (csaPercentage[0] > 80) {
                            labels = ['High', ''];
                            backgroundColor = ['rgba(235, 28, 36, 1)', 'Gray'];
                        } else if (csaPercentage[0] > 40 && csaPercentage[0] <= 80) {
                            labels = ['Medium', ''];
                            backgroundColor = ['rgba(255, 165, 0, 1)', 'Gray'];
                        } else if (csaPercentage[0] <= 40) {
                            labels = ['Low', ''];
                            backgroundColor = ['rgba(34, 139, 34, 1)', 'Gray'];
                        }

                       const isTotalCSATEmpty = total_CSAT.every(value => value === 0);

                       const  chartDataCSAT = isTotalCSATEmpty
                            ? [1, 1]
                            : total_CSAT;

                        new Chart(ctx1, {
                            "chart": {
                                "showBorder": "1",
                            },
                            type: 'doughnut',
                   
                            data:{
                                labels: labels,
                                datasets: [{
                                    label: false,
                                    data: chartDataCSAT,
                                    borderWidth: 1,
                                    barThickness: 30,
                                    backgroundColor: backgroundColor,
                                }]
                            },
                            options: {
                                maintainAspectRatio: false,
                                responsive: true,
                                rotation: -90,
                                circumference: 180,

                                plugins: {
                                    title: {
                                        display: true,
                                        text: '',
                                        color: '#414042',
                                        align: 'start',
                                        padding: {
                                            /*        bottom: 20*/
                                        },
                                        font: {
                                            // size: 18,
                                            // weight: 600
                                            size: 13,
                                            weight: 600
                                        }
                                    },
                                    legend: {
                                        display: false,
                                        position: 'bottom',

                                        labels: {
                                            color: '#414042',
                                            boxWidth: 20,
                                            boxHeight: 20,
                                        }
                                    }
                                }
                            }
                        });
                    }
               }          
         //End of Added By Vyankat B On 25th Nov 2024 for the get of percentage of the overall CSAT  .


         // Added By Vyankat B On 25th Nov 2024 for the get SLA Target Today .

        var Employee;
        function GetSLATargetTodayAccoEMP() {


            $("#SLATarget_Percent_ID").empty();
            $("#frtID").empty();
            $("#frtID").text("0m");
            $("#spn_frtSLA_ID").empty();
            $("#spn_frtSLA_ID").text("0%");
            $("#spn_YesPercent_ID").empty();
            $("#spn_YesPercent_ID").text("0%");
            
            today_SLA_Percentage = 0;
            yesterday_percent = 0;

            if (queryId.length==0) {
                $("#SLATarget_Percent_ID").text( "0%");
                return;
            }
           
            var Parameters = {
                STRResultQueryId: queryId.join(',')
            }
           
                strResult5 = AJAXCallWithResult("/api/SupportEngineerDashboard/GetSLATargetToday", Parameters, false);
                queryId = [];
              

                if (strResult5 && strResult5.length > 0) {


                    $("#SLATarget_Percent_ID").text(strResult5[0].Percentage_SLA + "%");

                    today_SLA_Percentage = strResult5[0].Percentage_SLA;
                    yesterday_percent = strResult5[3].Percentage_SLA;

                    $("#frtID").text(strResult5[1].Percentage_SLA +"m" );
                    $("#spn_frtSLA_ID").text(strResult5[0].Percentage_SLA + "%");
                    $("#spn_YesPercent_ID").text(strResult5[3].Percentage_SLA + "%");

                   // console.log('newwww' + csaPercentage);
                }

                else {
                    return;
                } 
        }
        //End of  Added By Vyankat B On 25th Nov 2024 for the get SLA Target Today .


       //Added By Vyankat B On 6th jan 2025 for the to show icon according to yesterday SLA 
        function updateIcon() {

            const span_Element = $('#spn_YesPercent_ID');
            const iconElement = span_Element.find('i');

            if (yesterday_percent >= 0) {

                iconElement.removeClass('fa-caret-down').addClass('fa-caret-up').show();
                span_Element.html(`<i class="fas fa-caret-up"></i> ${yesterday_percent}%`);


            }else if (yesterday_percent < 0) {
                iconElement.removeClass('fa-caret-up').addClass('fa-caret-down').show();
                span_Element.html(`<i class="fas fa-caret-down"></i> ${Math.abs(yesterday_percent)}%`);


            }

        }
       //End of Added By Vyankat B On 6th jan 2025 for the to show icon according to yesterday SLA 



        // Added By Vyankat B On 25th Nov 2024 for the calculate today's SLA ID's  .
        var strResultQueryId;
        var Employee;
        function GetSLABreachedQueryIDTickAccEmp() {
           

            
            if (element) {

                Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];

            } else {

                Employee = $('#dd_EMPFilter_ID').val();

            }

                var Parameters = {
                   EmployeeID: Employee.toString()
                }

                strResultQueryId = AJAXCallWithResult("/api/SupportEngineerDashboard/GetSLABreachedQueryIDTickAccEmp", Parameters, false);

                if (strResultQueryId !== null) {

                    strResultQueryId.forEach(data => {

                        slaqueryId.push(data.queryId)

                    });

                    console.log(slaqueryId);
                    GetSLAActiveBreachedCount();
                }
        }
        //End of Added By Vyankat B On 25th Nov 2024 for the calculate today's SLA ID's  .


        // Added By Vyankat B On 25th Nov 2024 for the calculate of monthly CSAT tickets.
        var Employee;
        function GetSelMonthlyCSATAccEmp() {

            if (element) {

                 Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];
            } else {
                Employee = $('#dd_EMPFilter_ID').val();
            }
                 var Parameters = {
                    EmployeeID: Employee.toString()
                 }

                var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/GetSelMonthlyCSATAcc_Emp", Parameters, false);

                 if (strResult !== null) {

                     $("#spn_monthCSAT_ID").text(strResult[0].MonthCSATpercentage + "%");
                 }
        }
        //End of  Added By Vyankat B On 25th Nov 2024 for the calculate of monthly CSAT tickets.


        // Added By Vyankat B On 25th Nov 2024 for the calculate active breached  and Unbreached tickets ID also count of these .
        var Employee;
        function GetSLAActiveBreachedCount() {

            Employee = $('#dd_EMPFilter_ID').val();
       
            $("#spn_slaUnbreached_Id").empty();
            $("#spn_slaBreached_Id").empty();

            if (slaqueryId.length == 0) {
                $("#SLATarget_Percent_ID").text("0%");      
            }
            var Parameters = {
                STRResultQueryId: slaqueryId.join(',')
            }

           var  strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/GetSLAActiveBreachedCount", Parameters, false);
            
            slaqueryId = [];

           // sla_ActiveTarget_PriorID = [];

            activeBreahedSLADetailsID.length=0;
            activeUnBreahedSLADetailsID=[];

            strResult.forEach((data, index) => {
                if (data && data.MetricValue) {
                    if (index === 3) {
                        activeBreahedSLADetailsID.push(data.MetricValue || null);
                    }
                    if (index === 1) {
                        activeUnBreahedSLADetailsID.push(data.MetricValue || null);
                    }
                    if (index === 0) {
                        $("#spn_slaUnbreached_Id").text(data.MetricValue);
                    }
                    if (index === 2) {
                        $("#spn_slaBreached_Id").text(data.MetricValue);
                    }
                }
            });

            console.log("SLABREACHEDID" + activeBreahedSLADetailsID);
            if (strResult !== null && strResult.length > 0) {

               
                

            } else {

                $("#spn_slaUnbreached_Id").text("0");
                $("#spn_slaBreached_Id").text("0");

            }
        }
        //End of Added By Vyankat B On 25th Nov 2024 for the calculate active breached  and Unbreached tickets ID also count of these .


        // Added By Vyankat B On 25th Nov 2024 for find the Recently Breached Tickets .
        var Employee;
        function GetSLARecentlyBreachedTickets() {
         

            const Parameters = {
                STRResultQueryId: activeBreahedSLADetailsID.join(',')
            };

            breachedTicketsData = AJAXCallWithResult("/api/SupportEngineerDashboard/GetSLARecentlyBreachedTickets", Parameters, false);

            $('#recentBreached_ID').empty();

            let carouselIndicators1 = "";
            let carouselHtml1 = "";
     
            const filteredBreachedTickets = (data) => {
              
                return data.filter((ticket) => {

                    const match = ticket.FormattedRemainingHrsMin.match(/(-?\d+)hr\s*(-?\d+)min/);

                    if (match) {
                        const dayMatch = ticket.FormattedRemainingHrsMin.match(/(-?\d+)Day/);
                        const day = dayMatch ? parseInt(dayMatch[1], 10) : 0;
                        const hours = parseInt(match[1], 10);
                        const minutes = parseInt(match[2], 10);
                        const totalMinutes = day * 1440 + hours * 60 + minutes;

                        // Store user-friendly time in ticket for later display
                        if (totalMinutes <= 0) {
                            const absMinutes = Math.abs(totalMinutes);
                            const absHours = Math.floor(absMinutes / 60);
                            const remainingMinutes = absMinutes % 60;

                            // Format the time difference as a readable string
                            if (absHours > 0) {
                                ticket.UserFriendlyTime = `${absHours} hour${absHours > 1 ? 's' : ''} ago`;
                            } else {
                                ticket.UserFriendlyTime = `${remainingMinutes} minute${remainingMinutes > 1 ? 's' : ''} ago`;
                            }
                            return totalMinutes >= -1440; // Include tickets breached in the last 3 hours
                        }
                    }
                    return false;
                });
            };

            const filteredData = filteredBreachedTickets(breachedTicketsData);

            const pageSize = 4;
            const totalPages = Math.ceil(filteredData.length / pageSize);
           
            // Initialize the carousel structure
            carouselHtml1 += `
              <div id="carousel_Recently_breached" class="carousel slide" data-bs-ride="false">
              <div class="carousel-inner">
             `;

            // Add carousel items for each page of records
            if (filteredData.length > 0) {
                for (let i = 0; i < totalPages; i++) {

                    // Start a new carousel item for each page
                    carouselHtml1 += `
                <div class="carousel-item carousel__min_height ${i === 0 ? 'active' : ''}">
                    <div class="MainDiv table-responsive mt-0">
                        <table class="bgwhite table table-border-none Breached_detailtbl mb-0" style="width:100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th>ID</th>
                                    <th>SLA</th>
                                    
                                    <th>Breached at</th>
                                </tr>
                            </thead>
                            <tbody>
                      `;

                    // Add up to 4 records for this page
                    const currentPageData = filteredData.slice(i * pageSize, (i + 1) * pageSize);

                    currentPageData.forEach(item => {
                        carouselHtml1 += `
                    <tr>
                        <td class=""><a href="javascript:;">${item.QueryID}</a></td>
                        <td>${item.SLAName.split(' ')[0]}</td>
                     
                        <td>
                            <div class="">
                                ${item.UserFriendlyTime}
                            </div>
                        </td>
                    </tr>
                     `;
                    });

                    carouselHtml1 += '</tbody></table></div></div>'; // Close the current carousel item

                    // Add the corresponding indicator for this page
                    carouselIndicators1 += `
                <button type="button" data-bs-target="#carousel_Recently_breached" 
                        data-bs-slide-to="${i}" 
                        class="${i === 0 ? 'active' : ''} btn_carousel" 
                        aria-label="Slide ${i + 1}">
                </button>
                 `;
                }

                carouselHtml1 += `
            
            <div class="carousel-indicators mt-4">
                ${carouselIndicators1}
            </div>
            </div>
            </div>
           `;
                recentBreached_ID.innerHTML = carouselHtml1;
            }
        }
        //End of Added By Vyankat B On 25th Nov 2024 for find the Recently Breached Tickets .
 

        //Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table
        function resetBreachedTicketDetailsAccEmp() {
           
            PageCounter = 1;

            $('#ddl_DeptFilter_Breached_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_Breached_ID').prop('selectedIndex', 0);



            GetBreachedTicketDetailsAccEmp();
        }
        //End of Added By Vyankat B On 25th Nov 2024 for  the to Reset the previous selected data in the deatils table


        // Added By Vyankat B On 25th Nov 2024 for To get Breached Ticket Details
        function GetBreachedTicketDetailsAccEmp() {
         
            let PageNumber = PageCounter;

            $("#tbl_TicketsDetails_Breached").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Breached").empty();

           

            DepartmentName = $('#ddl_DeptFilter_Breached_ID').val();
            CustomerName = $('#ddl_CustFilter_Breached_ID').val();

            console.log("activeID's"+activeBreahedSLADetailsID);
            var Parameters = {
                STRResultQueryId: activeBreahedSLADetailsID.join(','),
                Department: DepartmentName,
                CustomerID: CustomerName,
                PageNo: PageNumber.toString()
            }

            var strResult = AJAXCallWithResult("/api/SupportEngineerDashboard/GetBreachedTicketDetailsAccEmp", Parameters, false);
            console.log(strResult);

            if (strResult != undefined) {
                var newrow = "";

                for (i = 0; i < strResult.length; i++) {

                    newrow += `<tr>
                    <td>
                        ${strResult[i].QueryID}
                    </td>
                    <td>
                        ${strResult[i].Subject}
                    </td>
                    <td>
                        ${strResult[i].RequestType}
                    </td>
                    <td>
                        ${strResult[i].Priority}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${strResult[i].CustomerID}
                    </td>
                    <td>
                        ${formatDate(strResult[i].SubmittedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ModifiedDate)}
                    </td>
                    <td>
                        ${formatDate(strResult[i].ExpectedResolvedDate)}
                    </td>
                    <td>
                        <div class="statusDiv d-flex justify-content-start">
                            <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                            <a href="javascript:;">
                                <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                            </a>
                        </div>
                    </td>
                    <td><div class="statusDiv d-flex justify-content-start">
                           ${strResult[i].AssignToName}
                        </div></td>
                    <!--<td>
                        <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#UnitOffcvsScreen" aria-controls="offcanvasWithBothOptions">
                            <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">${strResult[i].AssignToName}</i>
                        </a>
                    </td>-->
                </tr>`
                }

                $("#offcanvasDynamicAppendData_Breached").append(newrow);

                $('#tbl_TicketsDetails_Breached').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false,

                    "scrollY": true,
                    "scrollX": true,
                    // "scrollX": true,
                   // "fixedHeader": true,

                });

                updatePaginationButtons_breached(strResult.length, PageNumber);

            }
            else {
                return;
            }
        }
        //End of  Added By Vyankat B On 25th Nov 2024 for To get Breached Ticket Details


        //Added By Vyankat B On 6th jan 2025 for the pagination
        function updatePaginationButtons_breached(recordCount, currentPage) {




            if (currentPage === 1) {
                $('#tbl_TicketsDetails_Breached_previous').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_Breached_previous').removeClass('disabled').on('click', function () {
                    console.log('Previous button clicked for High Priority Tickets!');
                    PageCounter--;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetBreachedTicketDetailsAccEmp();
                });
            }

            if (recordCount < 10) {
                $('#tbl_TicketsDetails_Breached_next').addClass('disabled').off('click');
            } else {
                $('#tbl_TicketsDetails_Breached_next').removeClass('disabled').on('click', function () {
                    console.log('Next button clicked for High Priority Tickets!');
                    PageCounter++;
                    $('#tbl_TicketsDetails_HighPriority_paginate .paginate_button.current').text(PageCounter);
                    GetBreachedTicketDetailsAccEmp();
                });
            }
        }
       //End of Added By Vyankat B On 6th jan 2025 for the pagination


        // Added By Vyankat B On 25th Nov 2024 for the calculate of customer  feedback and rating of these customer  .
        var Employee;
        function GetCustomerFeedbackAccEmp() {
         

            if (element) {
                 Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];
            } else {
                Employee = $('#dd_EMPFilter_ID').val();

            }

            var Parameters = {

               EmployeeID: Employee.toString()

            }


            var strResultQueryId = [];


            strResultQueryId = AJAXCallWithResult("/api/SupportEngineerDashboard/GetCustomerFeedbackAccEmp", Parameters, false);

            $('#feedbackContainer_ID').empty();

            if (strResultQueryId && strResultQueryId.length > 0) {
                            // Arrays to store the customer data

                let customerName = [];

                let rating = [];

                let feedback = [];

                let recentTime = [];


                strResultQueryId.forEach(data => {

                    customerName.push(data.CustomerID);

                    rating.push(data.Rating);

                    feedback.push(data.FeedbackComments);

                    recentTime.push(data.RecentTime);

                });


                var feedbackContainer = $('#feedbackContainer_ID')[0];



                var itemsPerCarousel = 5;

                var carouselHTML = '';

                var carouselIndicatorsHTML = '';


                strResultQueryId.forEach((data, index) => {


                    if (index % itemsPerCarousel === 0) {


                        if (index !== 0) carouselHTML += '</div></div>';



                        carouselHTML += `
                <div class="carousel-item carousel_height ${index === 0 ? 'active' : ''}">
                    <div class="mt-4">
            `;



                        carouselIndicatorsHTML += `
                <button type="button" data-bs-target="#carousel_Customer" 
                        data-bs-slide-to="${Math.floor(index / itemsPerCarousel)}" 
                        class="${index === 0 ? 'active' : ''} btn_carousel" 
                        aria-label="Slide ${Math.floor(index / itemsPerCarousel) + 1}">
                </button>
            `;

                    }


                    var stars = Array(5)

                        .fill('<span class="rating_Fstar"><i class="far fa-star"></i></span>')

                        .fill('<span class="rating_Fstar"><i class="fas fa-star"></i></span>', 0, data.Rating)

                        .join('');


                    carouselHTML += `
            <div class="d-flex justify-content-between d-inline my-3">
                <div class="text-start">
                    <div>
                        <i class="fas fa-thumbs-up like_thum me-2"></i>
                        <span class="small_Txt">${data.FeedbackComments}</span>
                    </div>
                    <div class="ml-4">
                        <span class="small_blu_text">${data.RecentTime}</span>
                    </div>
                </div>
                <div class="text-end">
                    <div class="Custromer_name">
                        <span class="span_text">${data.CustomerID}</span>
                    </div>
                    <div class="ml-4 d-flex">
                        <div class="gap-1">${stars}</div>
                    </div>
                </div>
            </div>
        `;

                });

                carouselHTML += '</div></div>';

                feedbackContainer.innerHTML = `
               
                ${carouselHTML}
                
                <div class="carousel-indicators mt-4">
                ${carouselIndicatorsHTML}
               
                </div>
                `;

            }



            else {


                $('#feedbackContainer_ID')[0].innerHTML = `

                 <div class="text-center my-4">

                 <p class="text-muted"> No data is present...! </p>

                 </div>

                `;

            }
        }
        //End of Added By Vyankat B On 25th Nov 2024 for the calculate of customer  feedback and rating of these customer  .


        // Added By Vyankat B On 25th Nov 2024 for the calculate of customer  feedback percentage under the selected Employee  .
        var Employee;
        function GetCustomerFeedbackPercentageAccEmp() {
         

            if (element) {

                Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];

            } else {
                Employee = $('#dd_EMPFilter_ID').val();
            }

            var Parameters = {

               EmployeeID: Employee.toString()

            }


            var strResultQueryId = AJAXCallWithResult("/api/SupportEngineerDashboard/GetCustomerFeedbackPercentageAccEmp", Parameters, false);


            if (strResultQueryId && strResultQueryId.length > 0) {


                let feedbackPercent = [];

                let customerName = [];


                strResultQueryId.forEach(data => {

                    feedbackPercent.push(data.feedbackPercentage);

                    customerName.push(data.CustomerID);

                });



                document.querySelector("#feedbackPercen_Id").innerHTML = '';




                for (let i = 0; i < feedbackPercent.length; i++) {


                    const progressRow = `
                       <div class="row gy-3">
                       <div class="col-sm-12">
                       <div class="ProgressTitle d-flex justify-content-between">
                        <div>${customerName[i]}</div>
                        <div>${feedbackPercent[i]}%</div>
                      </div>
                     <div class="progress iniProgress" role="progressbar" aria-valuenow="${feedbackPercent[i]}" aria-valuemin="0" aria-valuemax="100">
                        <div class="progress-bar bgblue" style="width: ${feedbackPercent[i]}%;"></div>
                      </div>
                    </div>
                   </div>
                    `;


                    document.querySelector("#feedbackPercen_Id").innerHTML += progressRow;

                }


            }
            else {


                document.querySelector("#feedbackPercen_Id").innerHTML = `
               <div class="row gy-3">
                  <div class="col-sm-12">
                    <div class="ProgressTitle d-flex justify-content-between">
                        <div>No data is present... !</div>
                    </div>
                 </div>
               </div>`;


            }

        }                     
        
        // End of Added By Vyankat B On 25th Nov 2024 for the calculate of customer  feedback percentage under the selected Employee  .


        // Added By Vyankat B On 25th Nov 2024 for the calculate of customer  feedback percentage under the selected Employee  .
        var strResultQueryId;
        var Employee;
        function GetSLAQueryID_Tick_Acc_Emp() {
          
            if (element) {

                Employee = toggleEmployee ? toggleEmployee.split(", ").map(emp => emp.trim()) : [];

            } else {
                Employee = $('#dd_EMPFilter_ID').val();

            }
                var Parameters = {
                   EmployeeID: Employee.toString()
                }

                strResultQueryId = AJAXCallWithResult("/api/SupportEngineerDashboard/GetSLAQueryID_Tick_Acc_Emp", Parameters, false);

                if (strResultQueryId !== null) {


                    strResultQueryId.forEach(data => {
                        queryId.push(data.QueryId)
                    });

                    console.log(queryId);

                    GetSLATargetTodayAccoEMP();
                }
        }
        //End of  Added By Vyankat B On 25th Nov 2024 for the calculate of customer  feedback percentage under the selected Employee  .


        // Added By Vyankat B On 25th Nov 2024 for the get SLA Priority of todays tickets .
        var Employee;
        function GetSelSLAPriorTick_Acc_Emp() {
          
                
                let slaPriorCount = [];

                slaPriorCount = [today_SLA_Percentage, 100 - today_SLA_Percentage];
             
                    const sla_Target = Chart.getChart('SLATargets');
                    if (sla_Target) {
                        sla_Target.destroy();
                    }
             
                let labels = [];
                let backgroundColor = [];

                if (today_SLA_Percentage > 80) {
                    labels = ['High', ''];
                    backgroundColor = ['rgba(235, 28, 36, 1)', 'Gray'];
                } else if (today_SLA_Percentage > 40 && today_SLA_Percentage <= 80) {
                    labels = ['Medium', ''];
                    backgroundColor = ['rgba(255, 165, 0, 1)', 'Gray'];
                } else if (today_SLA_Percentage <= 40) {
                    labels = ['Low', ''];
                    backgroundColor = ['rgba(34, 139, 34, 1)', 'Gray'];
                }

                const slaTargetGraph = slaPriorCount.every(value => value === 0);

                const chartslaPriorCountT = slaTargetGraph
                    ? [1, 1, 1]
                    : slaPriorCount;

                const ctx12 = document.getElementById('SLATargets');

                new Chart(ctx12,
                    {
                        "chart": {
                            "showBorder": "1",
                        },
                        type: 'doughnut',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: false,
                                data: chartslaPriorCountT,
                                borderWidth: 1,
                                barThickness: 30,
                                backgroundColor: backgroundColor,
                            }]
                        },
                        options: {
                            maintainAspectRatio: false,
                            responsive: true,
                            rotation: -90,
                            circumference: 180,

                            plugins: {
                                title: {
                                    display: true,
                                    text: '',
                                    color: '#414042',
                                    align: 'start',
                                    padding: {
                                        /*        bottom: 20*/
                                    },
                                    font: {
                                        // size: 18,
                                        // weight: 600
                                        size: 13,
                                        weight: 600
                                    }
                                },
                                legend: {
                                    display: false,
                                    position: 'bottom',

                                    labels: {
                                        color: '#414042',
                                        boxWidth: 20,
                                        boxHeight: 20,
                                    }
                                }
                            }
                        }
                    });
            
        }
        //End of Added By Vyankat B On 25th Nov 2024 for the get SLA Priority of todays tickets.

               
        // Added By Vyankat B On 25th Nov 2024 for the calculate of profile details of selected emplyee.
        function GetProfileDetails() {
          

            var Employee = $('#dd_EMPFilter_ID').val();
            $('.pageHeading').text($('#dd_EMPFilter_ID option:selected').text());


            var Parameters = {
                EmployeeID: Employee
            }

            strResultQueryId = AJAXCallWithResult("/api/SupportEngineerDashboard/GetProfileDetails", Parameters, false);

            if (strResultQueryId !== null && strResultQueryId.length > 0) {
                $('#profileTitle').text(strResultQueryId[0].EmployeeProfile);
                if (strResultQueryId.length > 1) {
                    $('.leve_div').text(`[ Planed Leaves : ${strResultQueryId[1].EmployeeProfile} ]`);
                } else {
                    $('.leve_div').text('[ Planed Leaves : 0 ]');
                }
            } else {
                $('#profileTitle').text('No Role Assigned');
                $('.leve_div').text('[ Planed Leaves : 0 ]');
            }


        }    
        // End of Added By Vyankat B On 25th Nov 2024 for the calculate of profile details of selected emplyee.



       // Added By Vyankat B On 25th Nov 2024 for the fetching data from Server.
        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {

            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: JSON.stringify(param),
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-Helpdesk"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;

                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }
       //End of Added By Vyankat B On 25th Nov 2024 for the fetching data from Server.
        
    </script>
</body>

</html>