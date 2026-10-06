<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Requester_Customer_Client.aspx.vb" Inherits="Whizible.Requester_Customer_Client" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Support Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css?v=1">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Requestor_custom.css">

    <style type="text/css">
       /* by durgesh*/

          .graphSection {
            position: relative;
            width: 100%;
            overflow: hidden;
          }

       /* end by durgesh*/

        #NewTicketsGraph {
            width: 100% !important;
            height: auto !important;
            max-height: 450px; /* Adjust as needed */
        }

         #SubmittedTicketsGraph{
           width: 100% !important;
           height: auto !important;
           max-height: 250px; /* Adjust as needed */
         }

      
        h5.pgtitle {
            margin: 0px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .TabsSec {           
            border-radius: 10px;
            box-shadow: 0 0 0.9rem rgba(0, 0, 0, .1);
        }

        .profileImg {
            width: 190px;
            height: auto;
            border-radius: 15px;
            margin-left: auto;
        }

        .main_profile {
            border: 2px dotted #ddd;
            padding: 17px;
            border-radius: 10px;
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

        .card-img {
            margin-top: -25px;            
            margin-left: 5px;
            z-index: 100;
        }

        .clearedStage1 {
            background-color: #ff6161;
            text-align: center;
            color: #fff;
            font-size: 7px;
        }

        .CardViewIniImg {
            width: 15px;
            height: 15px;
            border-radius: 50%;
            padding: 5px;
        }

        .clearedStage_orange {
            background-color: #ffb300;
            text-align: center;
            color: #fff;
            font-size: 7px;
        }

        .top_red_text {
            font-size: 28px;
            color: #ef343b;
            font-weight: 500;
            /* padding: 3px; */
        }

        .top_green_text {
            font-size: 28px;
            color: #00a65a;
            font-weight: 500;
            /* padding: 3px; */
        }

        .top_orange_text {
            font-size: 28px;
            color: #ff6a00;
            font-weight: 500;
            /* padding: 3px; */
        }

        .red_text {
            font-size: 19px;
            color: #ef343b;
            font-weight: 500;
            padding: 2px;
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
            color: #ff0000;
            font-weight: 500;
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
            top: 66px;
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
        /* .IniCardsAcc .card {
            flex: 1;
        } */
        .aline_content {
            display: flex;
            align-items: center;
            justify-content: space-evenly;
        }

        .boxInbox {
            border: 1px dashed #ddd;
            border-radius: 10px;
        }

        .logoImg {
            width: 85px;
        }

        .rating_Fstar {
            color: #ffb300;
        }

        .like_thum {
            color: #fff;
            background-color: #2B55CE;
            padding: 5px;
            border-radius: 50%;
        }

        .yellow_like_thum {
            color: #fff;
            background-color: #eb9429;
            padding: 5px;
            border-radius: 50%;
        }

        .green_like_thum {
            color: #fff;
            background-color: #0ebf3c;
            padding: 5px;
            border-radius: 50%;
        }

        .Tickets_graphSection {
            position: relative;
            height: 45vh;
            width: 36vw;
        }

        .legends-div .legends {
            display: flex;
            padding: 10px;
        }

        .legends-div .legend-box {
            width: 25px;
            height: 20px;
            background-color: #2B55CE;
        }

        .legends-div .yellow-box {
            width: 25px;
            height: 20px;
            background-color: #ff9900;
        }

        .legends-div .legends .l-name {
            margin-left: 4px;
            width: 70px;
            flex-grow: 1;
        }

        .blu_text {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #2B55CE;
            margin-left: 35px;
        }

        .small_Txt {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .canvas-con {
            display: flex;
            align-items: center;
            justify-content: center;
            /* min-height: 365px; */
            position: relative;
        }

        .medium_center_text {
            position: relative;
            left: 68px;
            margin-top: 35px;
        }

        .span_text {
            font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #1748d5;
        }

        .span_pinktext {
            font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #ec23ed;
        }

        .flex_display {
            display: flex;
            /* vertical-align: middle; */
            flex-wrap: wrap;
            align-content: space-around;
            justify-content: start;
            margin-top: 24px
        }

        .ProgressTitle {
            /*   color: #d3d3d3;*/
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .iniProgress {
            height: 7px;
        }
        

        .bgGreen {
            background-color: #52c273;
        }

        .bgblue {
            background-color: #4881fb;
        }

        .table-fixed-header thead tr th, .table thead tr th {
            background: #e7edf0;
            color: #464a4c;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 400;
        }

        .table-fixed-header tbody tr th, .table tbody tr td {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
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
            text-align: left;
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
            left: 80px;
            z-index: 1;
        }

        .third_col {
            width: 100px;
            min-width: 100px;
            max-width: 100px;
            left: 330px;
            z-index: 1;
        }

        .forth_col {
            width: 100px;
            min-width: 100px;
            max-width: 100px;
            left: 430px;
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

        .card-body {
            padding: 5px;
        }

        .statusClosed {
            background-color: #00a65a;
        }

        .statusBox {
            display: inline-block;
            border-radius: 50%;
            min-width: 10px;
            height: 10px;
        }

        .statusDiv {
            width: unset;
        }

            .statusDiv label {
                font-weight: 400;
            }

        .statusRejected {
            background-color: #dd4b39;
        }
       /*Commented By Dipali V on 1th April 2026*/
/* select.form-select {
     -webkit-appearance: menulist;
 }*/
/*End of Commented By Dipali V on 1th April 2026*/
        /*Added By Dipali V On 19th FEB 2025 For ICON Color Changes */
        .redIconBg {
            background-color: lightgray !important;
        }

        .orangeIconBg {
            background-color: lightgray !important;
        }

        .greenIconBg {
            background-color: lightgray !important;
        }
        /*End of Added By Dipali V On 19th FEB 2025 For ICON Color Changes */
    </style>
</head>

<body class="hold-transition bgwhite sidebar-mini fixed">

  <% If m_blnViewAccess Then %>

    <!-- Content Wrapper. Contains page content -->
    <div class="bgwhite resource_allocation">
        <div class="container-fluid pt-1 pb-1 mb-1 test-end graybg">
            <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_ReqCust") %></h5>
            <div class="clearfix"></div>
        </div>
        <div class="container-fluid">
            <div class="row mb-0 py-2">
                <div class="col-10 col-sm-8 offset-sm-4 col-md-7 offset-md-5 col-lg-5 offset-lg-7">
                    <div class="row pe-3 py-0">
                        <div class="col-4 col-sm-6 text-end">
                            <label for="cboCustomerNameSelectID" class="mt-2"><%= MyBase.GetResourceString("C_Customer") %> </label>
                        </div>
                        <div class="col-8 col-sm-6">
                            <!-- Added By Vyankat B on 12/11/2024-->
                            <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerNameSelectID", "usp_Whizible2_GetCustomerNames",,, "class='form-select selectpicker' data-live-search='true'",,,) %>
                           <!--End of  Added By Vyankat B on 12/11/2024-->
                           
                        </div>
                    </div>
                </div>
            </div>
        </div>      
        <div class="TabsSec mb-3">
                <div class="profileSec">
                    <div class="container-fluid p-3">
                        <div class="row">
                            <!-- Customer Info start here -->
                            <div class="col-12 col-sm-5 col-lg-3 d-flex mb-2">
                                <div class="main_profile flex-1 position-relative">
                                    <div class="profileName py-3">
                                        <span class="pageHeading voilet_txt" id="cusPageHead"></span>
                                    </div>
                                    <div class="">
                                        <span class="leve_div"><%= MyBase.GetResourceString("C_TotpThisWeek") %> </span>
                                    </div>
                                    <div class="">
                                        <!-- Added By Vyankat B on 12/11/2024-->
                                        <span class="font-weight-500 yellow_txt largeTxt" id="txttotalperthisweekid"></span>
                                        <!-- Added By Vyankat B on 12/11/2024-->
                                    </div>

                                    <div class="cardIcon greenIconBg" data-bs-toggle="offcanvas" data-bs-target="#totalPerThisWeekTicket_OffcvsScreen" >
                                        <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                    </div>
                                </div>
                            </div>
                            <!-- Customer Info end here -->
                            <!-- Tickets Count start here -->
                            <div class="col-12 col-sm-7 col-lg-3 mb-2">
                                <div class="IniCardsSec">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="card mb-2">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-sm-12 text-center position-relative">
                                                            <!-- Added By Vyankat B on 12/11/2024-->
                                                            <div class="top_yellow_text" id="tktunassignedcountid"></div>
                                                            <!--End of  Added By Vyankat B on 12/11/2024-->
                                                            <div class=""><%= MyBase.GetResourceString("C_UnTicket") %>
                                                            </div>
                                                            <div class="cardIcon redIconBg" data-bs-toggle="offcanvas" data-bs-target="#unassignedTickets_OffcvsScreen">
                                                               <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details" ></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-4 col-sm-4 d-flex pe-0">
                                                    <div class="card flex-1 position-relative">
                                                        <div class="card-body">
                                                            <div class="row">
                                                                <div class="col-sm-12 text-center">
                                                                    <!-- Added By Vyankat B on 12/11/2024-->
                                                                    <div class="top_red_text" id ="lblopenStatus"></div>
                                                                    <!--End of  Added By Vyankat B on 12/11/2024-->
                                                                    <div class="red_txt"><%= MyBase.GetResourceString("C_Opn") %></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="cardIcon redIconBg" data-bs-toggle="offcanvas" data-bs-target="#opeStatus_OffcvsScreen">
                                                            <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-4 col-sm-4 d-flex pe-0">
                                                    <div class="card flex-1 position-relative">
                                                        <div class="card-body">
                                                            <div class="row">
                                                                <div class="col-sm-12 text-center position-relative px-1">
                                                                    <!-- Added By Vyankat B on 12/11/2024-->
                                                                    <div class="top_green_text" id ="lblresolvedStatus"></div>
                                                                    <!--End of  Added By Vyankat B on 12/11/2024-->
                                                                    <div class="green_txt"><%= MyBase.GetResourceString("C_Resol") %></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="cardIcon greenIconBg" data-bs-toggle="offcanvas" data-bs-target="#resolvedTickets_OffcvsScreen">
                                                            <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-4 col-sm-4 d-flex">
                                                    <div class="card flex-1 position-relative">

                                                        <div class="card-body">
                                                            <div class="row">
                                                                <div class="col-sm-12 text-center position-relative px-1">
                                                                    <!-- Added By Vyankat B on 12/11/2024-->
                                                                    <div class="top_orange_text" id ="lblclosedStatus"></div>
                                                                    <!--End of  Added By Vyankat B on 12/11/2024-->
                                                                    <div class="orange_txt"><%= MyBase.GetResourceString("C_Clo") %></div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="cardIcon orangeIconBg" data-bs-toggle="offcanvas" data-bs-target="#closedStatus_OffcvsScreen">
                                                            <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details" ></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Tickets Count end here -->
                            <!-- Tickets Updates start here -->
                            <div class="col-12 col-sm-12 col-lg-6 my-auto pt-lg-0 pt-3" id="ticketsInfoSec">
                                <div class="row">
                                    <div class="col-6 col-sm-2 d-flex mb-2 ps-0">
                                        <div class="cardBoxShadow position-relative py-3 flex-1">
                                            <div class="row">
                                                <div class="col-sm-12 text-center">
                                                    <div class="blue_txt ticketHeight"><%= MyBase.GetResourceString("C_Ticket") %></div>
                                                    <!-- Added By Vyankat B on 12/11/2024-->
                                                    <div class="largeTxt blue_txt font-weight-500" id="tktcountid"></div>
                                                      <!-- End of Added By Vyankat B on 12/11/2024-->
                                                </div>
                                            </div>
                                            <div class="cardIcon redIconBg" data-bs-toggle="offcanvas" data-bs-target="#allTicket_OffcvsScreen" >
                                                <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details" ></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-sm-2 d-flex mb-2 ps-0">
                                        <div class="cardBoxShadow position-relative py-3 flex-1">
                                            <div class="row">
                                                <div class="col-sm-12 text-center">
                                                    
                                                    <div class="blue_txt ticketHeight"><%= MyBase.GetResourceString("C_Bck") %></div>
                                                    <!-- Added By Vyankat B on 12/11/2024-->
                                                    <div class="largeTxt blue_txt font-weight-500" id="txtbacklogid"></div>
                                                    <!-- End of Added By Vyankat B on 12/11/2024-->
                                                </div>
                                            </div>
                                            <div class="cardIcon greenIconBg" data-bs-toggle="offcanvas" data-bs-target="#backlogTicket_OffcvsScreen">
                                                <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-sm-2 d-flex mb-2 ps-0">
                                        <div class="cardBoxShadow position-relative py-3 flex-1">
                                            <div class="row">
                                                <div class="col-sm-12 text-center">
                                                    <div class="blue_txt ticketHeight"><%= MyBase.GetResourceString("C_Ovedue") %></div>
                                                    <!-- Added By Vyankat B on 12/11/2024-->
                                                    <div class="largeTxt blue_txt font-weight-500" id="txtoverdueid"></div>
                                                    <!-- End of Added By Vyankat B on 12/11/2024-->
                                                </div>
                                            </div>
                                            <div class="cardIcon orangeIconBg" data-bs-toggle="offcanvas" data-bs-target="#overdueTicket_OffcvsScreen">
                                                <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-sm-2 d-flex mb-2 ps-0">
                                        <div class="cardBoxShadow position-relative py-3 flex-1">
                                            <div class="row">
                                                <div class="col-sm-12 text-center">
                                                    <div class="blue_txt ticketHeight"><%= MyBase.GetResourceString("C_InThisMonth") %></div>
                                                    <!-- Added By Vyankat B on 12/13/2024-->
                                                    <div class="largeTxt blue_txt font-weight-500" id="txtinflowthismonthid"></div>                             
                                                    <div class="smallGreyTxt" id="monthid"></div>
                                                    <!-- End of Added By Vyankat B on 12/11/2024-->
                                                </div>
                                            </div>
                                            <div class="cardIcon redIconBg" data-bs-toggle="offcanvas" data-bs-target="#inflowThisMonthTicket_OffcvsScreen">
                                                <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details" id ="InflowthismonthBtn"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-sm-2 d-flex mb-2 ps-0">
                                        <div class="cardBoxShadow position-relative py-3 flex-1">
                                            <div class="row">
                                                <div class="col-sm-12 text-center">
                                                    <div class="blue_txt ticketHeight"><%= MyBase.GetResourceString("C_ReThisMonth") %></div>
                                                    <!-- Added By Vyankat B on 14/11/2024-->
                                                    <div class="largeTxt blue_txt font-weight-500" id="txtresolvedthismonthid"></div>
                                                    <div class="smallGreyTxt" id="monthids"></div>
                                                     <!-- Added By Vyankat B on 14/11/2024-->
                                                </div>
                                            </div>
                                            <div class="cardIcon orangeIconBg" data-bs-toggle="offcanvas" data-bs-target="#resolvedThisMonthTicket_OffcvsScreen">
                                                <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details" id="resolvedThisMonthBtn"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6 col-sm-2 d-flex mb-2 ps-0">
                                        <div class="cardBoxShadow position-relative py-3 flex-1">
                                            <div class="row">
                                                <div class="col-sm-12 text-center">
                                                    <div class="blue_txt ticketHeight"><%= MyBase.GetResourceString("C_ReInTime") %></div>
                                                     <!-- Added By Vyankat B on 14/11/2024-->
                                                    <div class="largeTxt blue_txt font-weight-500" id ="txtresolvedthistimeid"></div>
                                                    <div class="smallGreyTxt" id="monthidss"></div>
                                                    <!-- End of Added By Vyankat B on 14/11/2024-->
                                                </div>
                                            </div>
                                            <div class="cardIcon greenIconBg" data-bs-toggle="offcanvas" data-bs-target="#resolvedInTimeTicket_OffcvsScreen">
                                                <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details" id="resolvedInTimeBtn"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>                          
                        </div>
                    </div>
                </div>
            </div>

            <div class="graphSec mb-3">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-4 col-lg-3 d-flex flex-column">
                            <div class="card bg_light_blue flex-1 mb-3 position-relative">
                                <div class="card-body p-3 text-center text-sm-start">
                                    <div class="font-weight-500 mb-4"><%= MyBase.GetResourceString("C_kTimes") %></div>
                                    <div class="row mb-4">
                                        <div class="col-sm-12">
                                            <div class="keyFrameDiv">
                                                <div>
                                                    <!-- Added By Vyankat B on 09/12/2024-->
                                                    <span class="XlargeTxt blue_txt font-weight-500" id="lblavgFRTThisWeek"></span>
                                                    <span class="largeTxt blue_txt font-weight-500">m</span>                                                  
                                                    <!-- End of Added By Vyankat B on 09/12/2024-->
                                                </div>
                                                <div class="blue_txt"><%= MyBase.GetResourceString("C_AvgResp") %></div>
                                                <div class="blue_txt">
                                                    <span class="green_txt font-weight-500">
                                                        <i class="fas fa-caret-down" id="txtrespLastWeek"></i>

                                                    </span> vs. Last Week</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="keyFrameDiv">
                                                <div>
                                                    <!-- Added By Vyankat B on 09/12/2024-->
                                                    <span class="XlargeTxt blue_txt font-weight-500" id="lblavgResolThisWeek"></span>
                                                    <span class="largeTxt blue_txt font-weight-500">h</span>
                                                    <!-- End of Added By Vyankat B on 09/12/2024-->
                                                    </div>
                                                <div class="blue_txt"><%= MyBase.GetResourceString("C_AvgResol") %></div>
                                                <div class="blue_txt"><span class="green_txt font-weight-500" ><i class="fas fa-caret-down"  id="txtresolLastWeek"></i></span> vs. Last Week</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="cardIcon redIconBg" data-bs-toggle="offcanvas" data-bs-target="#keyTimesdetails_OffcvsScreen">
                                    <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                </div>
                            </div>
                            <div class="card flex-1 mb-3">
                                <div class="card-header">
                                    <div class=""><%= MyBase.GetResourceString("C_CR") %></div>
                                </div>
                                <div class="card-body p-2">
                                    <!-- <div class="font-weight-500">Priority</div> -->
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="pieChartSection">
                                                <canvas id="convertedCR_Graph"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="cardIcon orangeIconBg" data-bs-toggle="offcanvas" data-bs-target="#cRdetails_OffcvsScreen">
                                    <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-8 col-lg-6 d-flex">


                            <div class="card flex-1 position-relative mb-3">
                                <div class="card-header">
                                    <div class=""><%= MyBase.GetResourceString("C_newTicPrio") %></div>
                                </div>
                                <div class="card-body d-flex align-items-center p-3">
                                    <!-- <div class="font-weight-500 mb-2">New Tickets Created Monthly As Per Priority</div> -->
                                    <div class="row flex-1">
                                        <div class="col-sm-12 d-flex">
                                            <div class="graphSection flex-1">
                                                <canvas id="NewTicketsGraph"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="cardIcon redIconBg" data-bs-toggle="offcanvas" data-bs-target="#newTicketdetails_OffcvsScreen">
                                    <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                </div>
                            </div>


                        </div>
                        <div class="col-sm-12 col-lg-3 d-flex">
                            <div class="row flex-1">
                                <div class="col-sm-4 col-lg-12 d-flex">
                                    <div class="card position-relative flex-1 mb-2">
                                        <div class="card-header">
                                            <div class=""><%= MyBase.GetResourceString("C_Prior") %></div>
                                        </div>
                                        <div class="card-body p-2">
                                            <!-- <div class="font-weight-500">Priority</div> -->
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="pieChartSection">
                                                        <canvas id="ticketPriorityGraph"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="cardIcon orangeIconBg" data-bs-toggle="offcanvas" data-bs-target="#prioritydetails_OffcvsScreen">
                                            <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4 col-lg-12 d-flex">
                                    <div class="card position-relative flex-1 mb-2">
                                        <div class="card-header">
                                            <div class=""><%= MyBase.GetResourceString("C_Severity") %></div>
                                        </div>
                                        <div class="card-body p-2">
                                            <!-- <div class="font-weight-500">Severity</div> -->
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="pieChartSection">
                                                        <canvas id="ticketSeverityGraph"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="cardIcon greenIconBg" data-bs-toggle="offcanvas" data-bs-target="#severitydetails_OffcvsScreen">
                                            <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4 col-lg-12 d-flex">
                                    <div class="card position-relative flex-1 mb-3">
                                        <div class="card-body d-flex justify-content-center align-items-center">
                                            <div class="row">
                                                <div class="col-sm-12 text-center">
                                                    <div class="blue_txt py-2"><%= MyBase.GetResourceString("C_Breach") %></div>
                                                    <div class="largeTxt blue_txt font-weight-500" id="txtslaBreachPerGoingtoBreach"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="cardIcon redIconBg" data-bs-toggle="offcanvas" data-bs-target="#breachdetails_OffcvsScreen">
                                            <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="graphSec">
                <div class="container-fluid">
                    <div class="row pe-5">
                        <div class="col-sm-12 col-lg-6 d-flex">
                            <div class="row mb-3 flex-1">
                                <div class="col-sm-12 d-flex">
                                    <div class="card flex-1 position-relative">
                                        <div class="card-header">
                                            <div class=""><%= MyBase.GetResourceString("C_TicVol") %></div>
                                        </div>
                                        <div class="card-body p-3">
                                            <!-- <div class="font-weight-500 mb-2">Ticket Volume</div> -->

                                            <div class="TicketsTabsSec">
                                                <ul class="nav nav-tabs TeamTabsList px-3" id="AllTeamTabs" role="tablist">
                                                    <li class="nav-item" role="presentation">
                                                        <button class="nav-link active" id="TabSubmitted" data-bs-toggle="tab" data-bs-target="#SubmittedTicketsTab"
                                                            type="button" role="tab" aria-selected="true">
                                                            <%= MyBase.GetResourceString("C_Sub") %>
                                                        </button>
                                                    </li>
                                                    <li class="nav-item" role="presentation">
                                                        <button class="nav-link" id="TabOpen" data-bs-toggle="tab" data-bs-target="#OpenTicketsTab"
                                                            type="button" role="tab" aria-selected="false">
                                                            <%= MyBase.GetResourceString("C_Opn") %>
                                                        </button>
                                                    </li>
                                                    <li class="nav-item" role="presentation">
                                                        <button class="nav-link" id="TabDue" data-bs-toggle="tab" data-bs-target="#DueTicketsTab"
                                                            type="button" role="tab" aria-selected="false">
                                                            <%= MyBase.GetResourceString("C_Due") %>
                                                        </button>
                                                    </li>
                                                    <li class="nav-item" role="presentation">
                                                        <button class="nav-link" id="TabResolved" data-bs-toggle="tab" data-bs-target="#ResolvedTicketsTab"
                                                            type="button" role="tab" aria-selected="false">
                                                            <%= MyBase.GetResourceString("C_Resol") %>
                                                        </button>
                                                    </li>
                                                    <li class="nav-item" role="presentation">
                                                        <button class="nav-link" id="TabClosed" data-bs-toggle="tab" data-bs-target="#ClosedTicketsTab"
                                                            type="button" role="tab" aria-selected="false">
                                                            <%= MyBase.GetResourceString("C_Clo") %>
                                                        </button>
                                                    </li>
                                                </ul>

                                                <div class="tab-content" id="nav-tabContent">
                                                    <!-- Submitted Tickets Tab Start here -->
                                                    <div class="tab-pane fade show active pt-4" id="SubmittedTicketsTab" role="tabpanel">
                                                        <div class="bargraphSection">
                                                            <canvas id="SubmittedTicketsGraph"></canvas>
                                                        </div>
                                                    </div>

                                                    <!-- Open Tickets Tab Start here -->
                                                    <div class="tab-pane fade show pt-4" id="OpenTicketsTab" role="tabpanel">
                                                        <div class="bargraphSection">
                                                            <canvas id="OpenTicketsGraph"></canvas>
                                                        </div>
                                                    </div>

                                                    <!-- Due Tickets Tab Start here -->
                                                    <div class="tab-pane fade show pt-4" id="DueTicketsTab" role="tabpanel">
                                                        <div class="bargraphSection">
                                                            <canvas id="DueTicketsGraph"></canvas>
                                                        </div>
                                                    </div>

                                                    <!-- Resolved Tickets Tab Start here -->
                                                    <div class="tab-pane fade show pt-4" id="ResolvedTicketsTab" role="tabpanel">
                                                        <div class="bargraphSection">
                                                            <canvas id="ResolvedTicketsGraph"></canvas>
                                                        </div>
                                                    </div>

                                                    <!-- Closed Tickets Tab Start here -->
                                                    <div class="tab-pane fade show pt-4" id="ClosedTicketsTab" role="tabpanel">
                                                        <div class="bargraphSection">
                                                            <canvas id="ClosedTicketsGraph"></canvas>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="cardIcon redIconBg" data-bs-toggle="offcanvas" data-bs-target="#ticketVolumedetails_OffcvsScreen">
                                            <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details" id="tabId"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-lg-6 d-flex">
                            <div class="row mb-3 flex-1">
                                <div class="col-sm-12 col-12 d-flex">
                                    <div class="card flex-1 position-relative currMonthCard">
                                        <div class="card-header">
                                            <div class=""><%= MyBase.GetResourceString("C_CurMon") %></div>
                                        </div>
                                        <div class="card-body p-3">
                                           <div class="table-responsive pt-3">
                                                <table id="CurrentMonthTbl" class="table table-hover" style="width: 100%">
                                                    <thead class="stickyTblHeader">
                                                        <tr>
                                                            <th class="col-sm-4 text-start">Type</th>
                                                            <th class="col-sm-2">Met(%)</th>
                                                            <th class="col-sm-2">Not Met(%)</th>
                                                            <th class="col-sm-2">Not Acknowledged(%) </th>
                                                            <th class="col-sm-2">Not Occured(%) </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                  
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="cardIcon greenIconBg" data-bs-toggle="offcanvas" data-bs-target="#currentMonth_OffcvsScreen">
                                            <i class="fas fa-exclamation" data-bs-toggle="tooltip" title="More Details"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- More Details for Tickets Details Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="Dashboard_Offcanvas" aria-labelledby="Leave_OffcvsScreen">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Ticket Details</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="LeaveTab" class="LeaveInfo">
                    <div class="row py-2">
                        <div class="col-sm-12">
                            <div class="nextBtnDiv text-end">
                                <button class="btn borderbtn" type="button" id="closeCntryBtn" data-bs-dismiss="offcanvas"
                                    aria-label="Close" data-bs-toggle="tooltip" title="Close">
                                    Close
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_leaveDetails" class="table table-hover" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-4 text-start">Requestor</th>
                                    <th class="col-sm-3 text-start">Subject</th>
                                    <th class="col-sm-2">Agent</th>
                                    <th class="col-sm-1 text-start">Status</th>
                                    <th class="col-sm-2 text-start">Last Updated</th>
                                    <th class="col-auto">&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="requestorDiv">
                                            <div class="row">
                                                <div class="col-sm-2">
                                                    <div class="profile_Ini bg_light_blue" id="profile_Ini1"></div>
                                                </div>
                                                <div class="col-sm-10">
                                                    <div>Helpdesk</div>
                                                    <div>support@helpdesk.com</div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Learn how to solve tickets effictively</td>
                                    <td class="text-center">Anna Smart</td> 
                                    <td><span class="badge bg-primary">Open
                                        </span></td>
                                    <td>46 minutes ago</td>
                                    <td>
                                        <a href="javascript:;" class="disabledIcn" data-bs-toggle="offcanvas" data-bs-target="#UnitOffcvsScreen" aria-disabled="true">
                                            <i class="fas fa-ellipsis-h" data-bs-toggle="tooltip" title="More Details"></i>
                                        </a>
                                    </td>
                                </tr>
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- More Details for Employee Leave Offcanvas Section ends -->
        <!-- More Details for Tickets  Offcanvas Section starts -->
    <!-- Added By Tanvi P on 18/11/2024-->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="allTicket_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="TicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentTickets", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentTickets();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                    
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                     <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerTickets", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerTickets();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_TicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                   <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                               
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    <!-- End of Added By Tanvi P on 18/11/2024-->
    <!-- Added By Tanvi P on 18/11/2024-->
    <!--Backlog -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="backlogTicket_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Backlog Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="BacklogTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentBacklog", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentBacklog();' class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                                </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerBacklog", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerBacklog();'class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_backlogTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!-- End of Added By Tanvi P on 18/11/2024-->
    <!-- Overdue -->
    <!-- Added By Tanvi P on 18/11/2024-->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="overdueTicket_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Overdue Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="OverdueTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentOverdue", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentOverdue();' class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                                </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerOverdue", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerOverdue();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_overdueTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!--End of Added By Tanvi P on 18/11/2024-->
    <!-- Added By Tanvi P on 20/11/2024-->
    <!--Priority -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="prioritydetails_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Priority Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="PriorityTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentPriorityDetails", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentPriorityDetails();' class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerPriorityDetails", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerPriorityDetails();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_priorityTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!-- End of Added By Tanvi P on 20/11/2024-->
    <!-- Added By Tanvi P on 20/11/2024-->
     <!--Severity -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="severitydetails_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Severity Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="SeverityTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentSeverityDetails", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentSeverityDetails();' class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                     <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerSeverityDetails", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerSeverityDetails();'  class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_severityTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!-- End of Added By Tanvi P on 20/11/2024-->
    <!-- Added By Tanvi P on 12/11/2024-->
    <!--SLA Breach -->


     <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
           id="breachdetails_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
           <div class="offcanvas-body">

               <div class="container-fluid py-2 graybg mb-2">
                   <div class="row align-items-center">
                       <div class="col-10 col-sm-10">
                           <div class="d-flex align-items-center font-weight-600">
                                <span>Breach Details</span>
                           </div>
                       </div>
                       <div class="col-2 col-sm-2 text-end">
                           <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                               <i class="fas fa-times"></i>
                           </a>
                       </div>
                   </div>
               </div>

               <div id="BreachTicketDetailsSec">
                   <div class="row mb-2">
                       <div class="col-sm-6 col-lg-5">
                           <div class="row form-group mb-2">
                               <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                   <label>Department</label>
                               </div>
                               <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentBreachDetails", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentBreachDetails();' class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                           </div>
                       </div>
                       <div class="col-sm-6 col-lg-5">
                           <div class="row form-group mb-2">
                               <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                   <label>Customer </label>
                               </div>
                               <div class="col-sm-7 col-lg-7 col-8">
                                     <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerBreachDetails", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerBreachDetails();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                           </div>
                       </div>
                   </div>
                   <div class="MainDiv">
                       <table id="tbl_breachTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                           <thead class="stickyTblHeader">
                               <tr>
                                   <th class="col-sm-1 text-center">ID</th>
                                   <th class="col-sm-2 text-center">Subject</th>
                                   <th class="col-sm-1 text-start">Request Type</th>
                                   <th class="col-sm-1 text-start">Priority</th>
                                   <th class="col-sm-1 text-start">Requestor</th>
                                   <th class="col-sm-1 text-start">Requestor Name</th>
                                   <th class="col-sm-1 text-start">Requested On</th>
                                   <th class="col-sm-1 text-start">Last Updated</th>                                    
                                   <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                   <th class="col-sm-1">Status</th>
                                   <th class="col-sm-1 text-start">Assign To</th>
                               </tr>
                           </thead>
                           <tbody>
                               
                           </tbody>
                       </table>
                   </div>
               </div>
           </div>
       </div>


    <!-- End of Added By Tanvi P on 20/11/2024-->
     <!--  Added By Tanvi P on 10/112/2024-->
     <!--CR -->

    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="keyTimesdetails_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Key Times Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="KeyTimesTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentKTTickets", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentKTTickets();' class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerKTDetails", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerKTDetails();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_KeyTimeTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!-- End of Added By Tanvi P on 10/12/2024-->
    <!--  Added By Tanvi P on 20/11/2024-->
     <!--CR -->

    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="cRdetails_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>CR Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="CRTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentCRTickets", "usp_spGetDepartmentNames",,, "class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerCRDetails", "usp_Whizible2_GetNewCustomerNames",,, "class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_CRTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!-- End of Added By Tanvi P on 20/11/2024-->
    <!--  Added By Tanvi P on 20/11/2024-->

    <!--New Tickets Created Monthly As Per Priority -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="newTicketdetails_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>New Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="newTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentNewTickets", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentNewTickets();' class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerNewTickets", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerNewTickets();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_newTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!-- End of Added By Tanvi P on 20/11/2024-->
    <!-- Added By Tanvi P on 20/11/2024-->

    <!-- for Current Month -->


    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="currentMonth_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Current Month Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="slaTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboDepartmentCurrentMonth", "usp_spGetDepartmentNames",,, "onchange='GetDepartmentCurrentMonth();' class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerCurrentMonth", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetCustomerCurrentMonth();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_CurrentMonthTbl" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>





    <!-- End of Added By Tanvi P on 20/11/2024-->
    <!-- Added By Tanvi P on 20/11/2024-->

    <!-- Ticket Volume -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="ticketVolumedetails_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Tickets Volume Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="ticketVolumeDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentTicketVolume", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentTicketVolume();' class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerNewVolume", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetCustomerNewVolume();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_ticketVolumeDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    <!-- End of Added By Tanvi P on 20/11/2024-->
    <!--  Added By Tanvi P on 22/11/2024-->

    <!-- Inflow This Month -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="inflowThisMonthTicket_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>InflowThisMonth Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div id="InflowThisMonthTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentInflowThisMonth", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentInflowThisMonth();'  class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                   <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerInflowThisMonth", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerInflowThisMonth();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_inflowThisMonthTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!--  End of Added By Tanvi P on 22/11/2024-->
     <!-- Resolved This Month -->

    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="resolvedThisMonthTicket_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>ResolvedThisMonth Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div id="ResolvedThisMonthTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentResolvedThisMonth", "usp_spGetDepartmentNames",,, "class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerResolvedThisMonth", "usp_Whizible2_GetNewCustomerNames",,, "class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_resolvedThisMonthTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!--  Added By Tanvi P on 22/11/2024-->

      <!-- Resolved In Time -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="resolvedInTimeTicket_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Resolved In Time Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div id="ResolvedInTimeTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("departmentResolvedInTime", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentResolvedInTime();'  class='form-select selectpicker' data-live-search='true'",,,) %>                               
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                   <% CommonFunctions.HTMLControls.DrawComboBox("customerResolvedInTime", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerResolvedInTime();'  class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_resolvedInTimeTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    <!--  End of Added By Tanvi P on 22/11/2024-->



     <!--  Added By Tanvi P on 22/11/2024-->
     <!-- Total Per This Week -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="totalPerThisWeekTicket_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Total per This Week Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div id="TotalperThisWeekTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label >Department</label>
                                </div>
                                <div class ="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentTotalPerThisWeek", "usp_spGetDepartmentNames",,, "onchange = 'GetdepartmentTotalPerThisWeek();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   

                                </div>                               
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class ="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerNameTotalPerThisWeek", "usp_Whizible2_GetNewCustomerNames",,, "onchange = 'GetCustomerNameTotalPerThisWeek();'class='form-select selectpicker' data-live-search='true'",,,) %>
                                    
                                   
                                </div>  
                                
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_totalPerThisWeekDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody id="offcanvastktThiswk">
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
     <!--  End of Added By Tanvi P on 22/11/2024-->
     <!--  Added By Tanvi P on 23/11/2024-->

     <!-- Open Status details -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="opeStatus_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Open Status Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div id="OpenStatusTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class ="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentOpenStatus", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentOpenStatus();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   

                                </div> 
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbocustomerOpenStatus", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetcustomerOpenStatus();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_openStatusDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
     <!--  End of Added By Tanvi P on 23/11/2024-->
     <!--  Added By Tanvi P on 23/11/2024-->

     <!-- Closed Status details -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="closedStatus_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Closed Status Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div id="ClosedStatusTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label for="cbodepartmentClosedStatus">Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentClosedStatus", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentClosedStatus();'class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                  <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerClosedStatus", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetCustomerClosedStatus();'class='form-select selectpicker' data-live-search='true'",,,) %>
                                     
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_closedStatusDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
     <!--  End of Added By Tanvi P on 23/11/2024-->

     <!--  Added By Tanvi P on 23/11/2024-->
    <!-- Resolved -->
    <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
            id="resolvedTickets_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-10 col-sm-10">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Resolved Tickets Details</span>
                            </div>
                        </div>
                        <div class="col-2 col-sm-2 text-end">
                            <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                                <i class="fas fa-times"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div id="resolvedDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label for="cbodepartmentResolvedStatus">Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentResolvedStatus", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentResolvedStatus();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerResolvedStatus", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetCustomerResolvedStatus();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="MainDiv">
                        <table id="tbl_ResolvedTicketsDetails" class="table table-bordered  table-fixed-header mb-1" style="width: 100%">
                           <thead class="stickyTblHeader">
    <tr>
                                    <th class="col-sm-1 text-center">ID</th>
                                    <th class="col-sm-2 text-center">Subject</th>
                                    <th class="col-sm-1 text-start">Request Type</th>
                                    <th class="col-sm-1 text-start">Priority</th>
                                    <th class="col-sm-1 text-start">Requestor</th>
                                    <th class="col-sm-1 text-start">Requestor Name</th>
                                    <th class="col-sm-1 text-start">Requested On</th>
                                    <th class="col-sm-1 text-start">Last Updated</th>                                    
                                    <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1 text-start">Assign To</th>
    </tr>
</thead>

                            <tbody>
                               
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
     <!--  End of Added By Tanvi P on 23/11/2024-->

    <!--  Added By Tanvi P on 25/11/2024-->
        <!-- Offcanvas for Unassigned Tickets More Details -->
<div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="unassignedTickets_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
    <div class="offcanvas-body">
        <div class="container-fluid py-2 graybg mb-2">
            <div class="row align-items-center">
                <div class="col-10 col-sm-10">
                    <div class="d-flex align-items-center font-weight-600">
                        <span>Unassigned Ticket Details</span>
                    </div>
                </div>
                <div class="col-2 col-sm-2 text-end">
                    <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                        <i class="fas fa-times"></i>
                    </a>
                </div>
            </div>
        </div>
         <div id="UnassignedTicketDetailsSec">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbodepartmentUnassignedTickets", "usp_spGetDepartmentNames",,, "onchange='GetdepartmentUnassignedTickets();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-5">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCustomerNameUnassigned", "usp_Whizible2_GetNewCustomerNames",,, "onchange='GetCustomerNameUnassigned();' class='form-select selectpicker' data-live-search='true'",,,) %>
                                    
                                </div>
                            </div>
                        </div>
                    </div>

        <!-- Table for Unassigned Tickets -->
        <table id="tbl_UnassignedTicketsDetails" class="table table-bordered table-fixed-header mb-1" style="width: 100%">
            <thead class="stickyTblHeader">
                <tr>
                    <th class="col-sm-1 text-center">ID</th>
                    <th class="col-sm-2 text-center">Subject</th>
                     <th class="col-sm-1 text-start">Request Type</th>
                     <th class="col-sm-1 text-start">Priority</th>
                     <th class="col-sm-1 text-start">Requestor</th>
                     <th class="col-sm-1 text-start">Requestor Name</th>
                     <th class="col-sm-1 text-start">Requested On</th>
                     <th class="col-sm-1 text-start">Last Updated</th>                                    
                     <th class="col-sm-1 text-start">Exp.Date of Resol..</th>
                     <th class="col-sm-1">Status</th>
                     <th class="col-sm-1 text-start">Assign To</th>
                </tr>
            </thead >
            <tbody>
                <!-- This will be populated dynamically -->
            </tbody>
        </table>
    </div>
</div>

   <!-- End of Added By Tanvi P on 25/11/2024-->
        <!-- More Details for aLL Tickets  Offcanvas Section ends -->
       
    </div>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    ...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- ./wrapper -->
    <!-- Added by Tanvi P on 10/12/2024 -->

     <%Else %>
    <div id="m_blnViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            
            <p style="margin-top: 136px; font-weight: 700;">You are Not Authorized to this Page </p>
        </div>       
    </div>
    <%End If %>

    <!-- End of Added by Tanvi P 10/12/2024-->


    <!-- REQUIRED JS SCRIPTS -->

    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script type="text/javascript">



 // Added by Vyankat B on 22 jan 2025 for the globally accessing declared value .

        var newCustomerID;
        var departmentID;
        var overDueID;
        var resInTime;
        var keyTimesdetails;
        var GoingToSLACount1;
        var GoingToSLACount2;
        var GoingToSLACountID;
        var CurrentMonthSLAIDs;

        var customerID;
        var departmentID;
        var newCustomerID;




        //Added By Tanvi P on 13 / 11 / 2024
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Helpdesk").ToString()%>';
        var UserName = '<%= Session("strUserName") %>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var m_blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var m_blnEditAccess = '<%= m_blnEditAccess%>';
        var m_blnViewAccess = '<%= m_blnViewAccess%>';


        //AjaxCall Function
        var AjaxResult;
        function AJAXCallWithResult(url, param, async) {
            // 
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
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
                    AjaxResult = data;
                    // console.log(data); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                },
                error: function (err) {
                    // console.log(err); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
            return AjaxResult
        }

        var selectedCustomerId = $('#cboCustomerNameSelectID').val();

        $(document).ready(function () {

            var selectedCustomerId = $('#cboCustomerNameSelectID').val();

            // If no customer is selected, default to customer with ID = 1
            if (!selectedCustomerId) {
                selectedCustomerId = 1;  // Set default customer ID as 1
            }

            fetchTicketCountForCustomerSelected(selectedCustomerId);
            fetchPriorityChart(selectedCustomerId);
            fetchSeverityChart(selectedCustomerId);
            fetchCRChart(selectedCustomerId);
            fetchMonthlyPriorData(selectedCustomerId);
            fetchCurrentMonthData(selectedCustomerId);
            fetchGetAvgResolThisWeek(selectedCustomerId);

            fetchSubmittedStatMonthlyData(selectedCustomerId);
            fetchOpenMonthlyData(selectedCustomerId);
            fetchDueStatMonthlyData(selectedCustomerId);
            fetchResolvedStatMonthlyData(selectedCustomerId);
            fetchClosedStatMonthlyData(selectedCustomerId);
            $('#cusPageHead').text($('#cboCustomerNameSelectID option:selected').text());
        });


        $('#cboCustomerNameSelectID').on('change', function () {

            var selectedCustomerName = $('#cboCustomerNameSelectID option:selected').text();
            fetchTicketCountForCustomerSelected($('#cboCustomerNameSelectID option:selected').val());
            fetchPriorityChart($('#cboCustomerNameSelectID option:selected').val());
            fetchSeverityChart($('#cboCustomerNameSelectID option:selected').val());
            fetchCRChart($('#cboCustomerNameSelectID option:selected').val());
            fetchMonthlyPriorData($('#cboCustomerNameSelectID option:selected').val());
            fetchCurrentMonthData($('#cboCustomerNameSelectID option:selected').val());
            fetchGetAvgResolThisWeek($('#cboCustomerNameSelectID option:selected').val());


            fetchSubmittedStatMonthlyData($('#cboCustomerNameSelectID option:selected').val());
            fetchOpenMonthlyData($('#cboCustomerNameSelectID option:selected').val());
            fetchDueStatMonthlyData($('#cboCustomerNameSelectID option:selected').val());
            fetchResolvedStatMonthlyData($('#cboCustomerNameSelectID option:selected').val());
            fetchClosedStatMonthlyData($('#cboCustomerNameSelectID option:selected').val());
            $('#cusPageHead').text(selectedCustomerName);
        });



        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();

        });

        $(document).on("click", function () {
            $(".tooltip").remove();
        });

        //   Added By Tanvi P on 26 / 11 / 2024
        //  datatable

        $('#tbl_TicketsDetails').DataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });

      



        //datatable
        $('#tbl_backlogTicketsDetails').dataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });
       


        $('#tbl_overdueTicketsDetails').dataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });

       


        $('#tbl_inflowThisMonthTicketsDetails').DataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });


        





        $('#tbl_ResolvedTicketsDetails').DataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });

       



        $('#tbl_UnassignedTicketsDetails').DataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });

       


        $('#tbl_resolvedThisMonthTicketsDetails').DataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });

       


        $('#tbl_resolvedInTimeTicketsDetails').dataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });
      



        $('#tbl_priorityTicketsDetails').dataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });

       

        //datatable
        $('#tbl_severityTicketsDetails').dataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });
       



        $('#tbl_breachTicketsDetails').dataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });

        


        //datatable
        $('#tbl_KeyTimeTicketsDetails').dataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });
       



        $('#tbl_CRTicketsDetails').DataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });



       


        //datatable
        $('#tbl_newTicketsDetails').dataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });
      
        $('#tbl_ticketVolumeDetails').DataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });


        
        // Added by Durgesh on 21 jan 2025 for the current month SLA 

        $('#CurrentMonthTbl').DataTable({
            "paging": false,
            "searching": false,
            "lengthChange": false,
            "info": false,
            "bAutoWidth": false,
            "order": [],
        });

        // End of Added by Durgesh on 21 jan 2025 for the current month SLA 


        $('#tbl_openStatusDetails').DataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });


      


        $('#tbl_closedStatusDetails').DataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });

       




        $('#tbl_totalPerThisWeekDetails').DataTable({

            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }

        });

       


        //datatable
        $('#tbl_CurrentMonthTbl').dataTable({
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false, // Disable responsive to allow horizontal scroll
            "destroy": false,
            "retrieve": true,
            "bAutoWidth": false,
            "info": false,
            "scrollY": "65vh",  // Enables vertical scrolling (adjust height as needed)
            "scrollX": true,    // Enables horizontal scrolling
            "scrollCollapse": true,  // Collapse empty space if fewer rows exist
            "fixedHeader": true,  // Keeps header fixed while scrolling vertically
            "fixedColumns": { // Ensures headers align with horizontal scroll
                leftColumns: 0,
                rightColumns: 0
            }
        });

       


        $(document).ready(function () {
            //
            function updateColumns($table, startIndex) {
                var numColumns = Math.max(
                    $table.find('thead th.sprintCol').length,
                    $table.find('tbody tr:first-child td.sprintCol').length
                );
                var endIndex = Math.min(startIndex + 5, numColumns);

                $table.find(".sprintCol").hide();
                $table.find("thead th.sprintCol").slice(startIndex, endIndex).css('display', 'table-cell');
                $table.find("tbody tr").each(function () {
                    $(this).find('td.sprintCol').slice(startIndex, endIndex).css('display', 'table-cell');
                });
            }

            $('.ExcelUploadTbl').each(function () {
                var $table = $(this);
                var startIndex = 0;

                // Initialize the table with the first 5 columns shown
                updateColumns($table, startIndex);

                $table.data('startIndex', startIndex);

                // var $container = $table.closest('.container');
                var $nextBtn = $table.parent(".scrollTable").find('.Excel_NextMonthBtn');
                var $prevBtn = $table.parent(".scrollTable").find('.Excel_PrevMonthBtn');

                $nextBtn.on('click', function () {
                    var currentIndex = $table.data('startIndex');
                    var numColumns = Math.max(
                        $table.find('thead th.sprintCol').length,
                        $table.find('tbody tr:first-child td.sprintCol').length
                    );
                    if (currentIndex + 5 < numColumns) {
                        currentIndex += 5;
                        updateColumns($table, currentIndex);
                        $table.data('startIndex', currentIndex);
                    }
                });

                $prevBtn.on('click', function () {
                    var currentIndex = $table.data('startIndex');
                    if (currentIndex > 0) {
                        currentIndex -= 5;
                        updateColumns($table, currentIndex);
                        $table.data('startIndex', currentIndex);
                    }
                });
            });
        });



        // Added by Vyankat B on 22 jan 2025 for the Function to get ticket counts based on customer selected

        function fetchTicketCountForCustomerSelected(customerID) {

            // Prepare parameters to send
            var Parameters = { CustomerID: customerID };
            var param = JSON.stringify(Parameters);

            // Call the AJAX function for both TotalTicketsPerWeek and UnassignedTicketCount
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketCountForCustomerSelected", param, false);

            // Check if the result is not null and handle the results
            if (result !== null) {

                // Assuming the result is an object with properties for both values
                $('#txttotalperthisweekid').text(result[0].TotalTicketsPerWeek);  // Total/ThisWeek
                $('#tktcountid').text(result[0].TicketCount); //Ticket Count
                $('#txtbacklogid').text(result[0].BacklogTicketCount); //Backlog Ticket Count
                $('#tktunassignedcountid').text(result[0].UnassignedTicketCount); // Unassigned ticket count
                $('#lblclosedStatus').text(result[0].CloseStatusTicketCount); // Close System status ticket count
                $('#lblopenStatus').text(result[0].OpenStatusTicketCount); // open System status ticket count
                $('#lblresolvedStatus').text(result[0].ResolvedStatusTicketCount); // Resolved System status ticket count
                $('#txtinflowthismonthid').text(result[0].InflowThisMonthTicketCount); // InflowThisMonth ticket count
                $('#txtresolvedthismonthid').text(result[0].ResolvedThisMonthTicketCount); // ResolvedThisMonth ticket count
            } else {
                $('#txttotalperthisweekid').text('0');
                $('#tktunassignedcountid').text('0');
                $('#tktcountid').text('0');
                $('#txtbacklogid').text('0');
                $('#lblclosedStatus').text('0');
                $('#lblopenStatus').text('0');
                $('#lblresolvedStatus').text('0');
                $('#txtinflowthismonthid').text('0');
                $('#txtresolvedthismonthid').text('0');
            }
        }


        // Added by Vyankat B on 22 jan 2025 for the Function to get Pie chart Priority

        function fetchPriorityChart(customerID) {

            // Prepare the parameters for the API call
            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);

            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult('/api/RequesterCustomerClient/GetPriorityPieChart', param, false);

            // Check if the result is valid and contains expected data
            if (result !== null) {
                var data = result[0]; // Assuming result is an array with the data

                let columnName = [];
                let priorityValue = [];
                let backgroundColors = [];

                const color = [
                    '#2596be', '#1bb977', '#f44336', '#ff9800', '#9c27b0', '#2196f3', '#4caf50', '#ff5722', '#673ab7', '#3f51b5'
                ];

                for (const [key, value] of Object.entries(data)) {
                    columnName.push(key);
                    priorityValue.push(value);

                }

                columnName.forEach((_, index) => {
                    backgroundColors.push(color[index % color.length]);
                });

                // Check if chart already exists, if yes, destroy it
                const existingPriorityChart = Chart.getChart('ticketPriorityGraph');
                if (existingPriorityChart) {
                    existingPriorityChart.destroy();
                }

                // Create new chart
                const ctx = document.getElementById('ticketPriorityGraph').getContext('2d');
                var priorityChart = new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: columnName,
                        datasets: [{
                            data: priorityValue,
                            backgroundColor: backgroundColors,
                        }]
                    },
                    options: {
                        maintainAspectRatio: false,
                        responsive: true,
                        plugins: {
                            title: {
                                display: false,
                                text: 'Priority',
                                color: '#414042',
                                align: 'center',
                                padding: { bottom: 20 },
                                font: { size: 16, weight: 600 }
                            },
                            legend: {
                                display: true,
                                position: 'left',
                                labels: {
                                    color: '#414042',
                                    boxWidth: 15,
                                    boxHeight: 15
                                },
                                onClick: function (event, legendItem, legend) {
                                    const labelText = legendItem.text;

                                    // Open offcanvas screen on legend click
                                    var offcanvasElement = document.getElementById('prioritydetails_OffcvsScreen');
                                    var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                                    offcanvas.show();
                                }
                            }
                        }
                    },
                });

            } else {

            }
        }

        //End of  Added by Vyankat B on 22 jan 2025 for the Function to get Pie chart Priority


        // Added by Vyankat B on 22 jan 2025 for the  Function to get Pie chart Severity

        function fetchSeverityChart(customerID) {

            // Prepare the parameters for the API call
            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult('/api/RequesterCustomerClient/GetSeverityPieChart', param, false);

            // Check if the result is valid and contains expected data
            if (result !== null) {

                let severityName = [];
                let severityCount = [];
                let colors1 = [
                    '#2596be', '#1bb977', '#f44336', '#ff9800', '#9c27b0',
                    '#2196f3', '#4caf50', '#ff5722', '#673ab7', '#3f51b5'
                ];
                let backgroundColors1 = [];

                // Loop through the result array and extract data
                result.forEach((item, index) => {
                    severityName.push(item.Severity);       // Push Severity names into the array
                    severityCount.push(item.TicketCount);  // Push corresponding TicketCount into the array
                    backgroundColors1.push(colors1[index % colors1.length]); // Assign colors dynamically
                });

                // Destroy the existing chart if it exists
                const existingSeverityChart = Chart.getChart('ticketSeverityGraph');
                if (existingSeverityChart) {
                    existingSeverityChart.destroy();
                }

                // Create the new pie chart with dynamic data
                const ctx3 = document.getElementById('ticketSeverityGraph').getContext('2d');
                var severityChart = new Chart(ctx3, {
                    type: 'pie',
                    data: {
                        labels: severityName,
                        datasets: [{
                            data: severityCount,
                            backgroundColor: backgroundColors1
                        }]
                    },
                    options: {
                        maintainAspectRatio: false,
                        responsive: true,
                        plugins: {
                            title: {
                                display: false,
                                text: 'Severity',
                                color: '#414042',
                                align: 'center',
                                padding: {
                                    bottom: 20
                                },
                                font: {
                                    size: 16,
                                    weight: 400
                                }
                            },
                            legend: {
                                display: true,
                                position: 'left',
                                labels: {
                                    color: '#414042',
                                    boxWidth: 15,
                                    boxHeight: 15
                                },
                                onClick: function (event, legendItem, legend) {
                                    const labelText = legendItem.text;
                                    var offcanvasElement = document.getElementById('severitydetails_OffcvsScreen');
                                    var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                                    offcanvas.show();
                                }
                            }
                        }
                    },
                });
            } else {

            }



        }

        //End of  Added by Vyankat B on 22 jan 2025 for the  Function to get Pie chart Severity


        // Added by Vyankat B on 22 jan 2025 for the to get Pie chart for CR

        function fetchCRChart(customerID) {

            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult('/api/RequesterCustomerClient/GetCRData', param, false);

            // Check if the result is valid and contains expected data
            if (result !== null) {
                var data = result[0]; // Assuming result is an array with the data

                let cr_count = data.Closed_SubRequestType_Count || 0;
                let total_cr_count = data.Total_SubRequestType_Count || 0;

                // Destroy the existing chart if it exists
                const existingChart5 = Chart.getChart('convertedCR_Graph');
                if (existingChart5) {
                    existingChart5.destroy();
                }

                // Create the new doughnut chart with dynamic data
                const ctx9 = document.getElementById('convertedCR_Graph').getContext('2d');
                new Chart(ctx9, {
                    type: 'doughnut',
                    data: {
                        labels: ['Total Count', 'CR Count'], // Labels for the chart
                        datasets: [{
                            data: [total_cr_count, cr_count], // Data for the chart
                            backgroundColor: ['#1bb977', '#ec7103d9'] // Colors for the sections
                        }]
                    },
                    options: {
                        maintainAspectRatio: false,
                        indexAxis: 'y',
                        elements: {
                            bar: {
                                borderWidth: 2,
                            }
                        },
                        responsive: true,
                        plugins: {
                            title: {
                                display: false,
                                text: '',
                                color: '#414042',
                                align: 'center',
                                padding: {
                                    bottom: 20
                                },
                                font: {
                                    size: 16,
                                    weight: 600
                                }
                            },
                            legend: {
                                display: true,
                                position: 'left',
                                labels: {
                                    color: '#414042',
                                    boxWidth: 20,
                                    boxHeight: 20,
                                },
                                onClick: function (event, legendItem, legend) {
                                    const offcanvasElement = document.getElementById('cRdetails_OffcvsScreen');
                                    const offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                                    offcanvas.show();
                                }
                            }
                        }
                    }
                });
            } else {
                alert("Failed to retrieve data 4!");
            }


        }
        //End of  Added by Vyankat B on 22 jan 2025 for the to get Pie chart for CR


        // Added by Vyankat B on 22 jan 2025 for the to get New Tickets Created Monthly As Per Priority

        function fetchMonthlyPriorData(customerID) {



            // Prepare the parameters for the API call
            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);

            const colors = [
                '#2596be', '#1bb977', '#f44336', '#ff9800', '#9c27b0', '#2196f3', '#4caf50', '#ff5722', '#673ab7', '#3f51b5'
            ];

            var result = AJAXCallWithResult('/api/RequesterCustomerClient/GetMonthlyPriorData', param, false);

            if (result !== null && result.length > 0) {

                let columns = Object.keys(result[0]).filter(key => key !== 'Month_Year');

                let monthYear = [];


                monthYear = result.map(data => data.Month_Year);

                let dynamicArrays = {};


                columns.forEach((column, index) => {
                    dynamicArrays[column] = [];
                });


                result.forEach(data => {
                    columns.forEach(column => {
                        dynamicArrays[column].push(data[column]);
                    });
                });


                const existingChart = Chart.getChart('NewTicketsGraph');
                if (existingChart) {
                    existingChart.destroy();
                }


                var ctx1 = document.getElementById('NewTicketsGraph').getContext('2d');
                var ticketsGraph = new Chart(ctx1, {
                    type: 'bar',
                    data: {
                        labels: monthYear,  // Set month-year labels for the X-axis
                        datasets: columns.map((column, index) => ({
                            label: column,  // Set the label dynamically
                            data: dynamicArrays[column],  // Set the data dynamically from the API response
                            backgroundColor: colors[index % colors.length],  // Alternate colors for the bars
                            stack: 'Stack 0',  // Stack the bars
                        }))
                    },
                    options: {
                        maintainAspectRatio: false,
                        responsive: true,
                        interaction: {
                            intersect: false,
                        },
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                labels: {
                                    color: '#414042',
                                    boxWidth: 20,
                                    boxHeight: 20,
                                },
                                onClick: function (event, legendItem, legend) {
                                    const index = legendItem.datasetIndex;
                                    const datasetLabel = legend.chart.data.datasets[index].label;

                                    // Show the offcanvas
                                    var offcanvasElement = document.getElementById('newTicketdetails_OffcvsScreen');
                                    var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                                    offcanvas.show();
                                },
                            },
                        },
                        scales: {
                            x: {
                                stacked: true,
                            },
                            y: {
                                stacked: true,
                            },
                        },
                    },
                });


            } else {


            }

        }
        //End of Added by Vyankat B on 22 jan 2025 for the to get New Tickets Created Monthly As Per Priority


        // Added by Durgesh D on 22 jan 2025 for the to get fetchCurrentMonthData

        function fetchCurrentMonthData(customerID) {
            // Get the current date
            var currentDate = new Date();

            // Format the date to 'yyyy-MM'
            var formattedDate = currentDate.getFullYear() + '-' + ('0' + (currentDate.getMonth() + 1)).slice(-2);

            // Define the parameters for the AJAX call
            var Parameters = {
                CustomerID: customerID,
                OnDate: formattedDate
            };
            var param = JSON.stringify(Parameters);

            // Make the AJAX call to the specified endpoint and get the result
            var data = AJAXCallWithResult("/api/RequesterCustomerClient/GetCurrentMonthDataOfSla", param, false);

            let ack = 0, resp = 0, resv = 0, cls = 0;

            let ack_met = 0, ack_not_met = 0, ack_not_ack = 0, ack_not_occ = 0;
            let resp_met = 0, resp_not_met = 0, resp_not_ack = 0, resp_not_occ = 0;
            let resv_met = 0, resv_not_met = 0, resv_not_ack = 0, resv_not_occ = 0;
            let cls_met = 0, cls_not_met = 0, cls_not_ack = 0, cls_not_occ = 0;

            var dataTable = $('#CurrentMonthTbl').DataTable();
            dataTable.clear();

            data.forEach(dt => {
                if (dt.SLACategory == 'Acknowledgement') {
                    ack++;
                    if (dt.MetApplicable == 'Met') {
                        ack_met++;
                    } else if (dt.MetApplicable == 'Not Met') {
                        ack_not_met++;
                    } else if (dt.MetApplicable == 'Not Acknowledged') {
                        ack_not_ack++;
                    } else {
                        ack_not_occ++;
                    }
                } else if (dt.SLACategory == 'Response') {
                    resp++;
                    if (dt.MetApplicable == 'Met') {
                        resp_met++;
                    } else if (dt.MetApplicable == 'Not Met') {
                        resp_not_met++;
                    } else if (dt.MetApplicable == 'Not Acknowledged') {
                        resp_not_ack++;
                    } else {
                        resp_not_occ++;
                    }
                } else if (dt.SLACategory == 'Resolution') {
                    resv++;
                    if (dt.MetApplicable == 'Met') {
                        resv_met++;
                    } else if (dt.MetApplicable == 'Not Met') {
                        resv_not_met++;
                    } else if (dt.MetApplicable == 'Not Acknowledged') {
                        resv_not_ack++;
                    } else {
                        resv_not_occ++;
                    }
                } else if (dt.SLACategory == 'Closure') {
                    cls++;
                    if (dt.MetApplicable == 'Met') {
                        cls_met++;
                    } else if (dt.MetApplicable == 'Not Met') {
                        cls_not_met++;
                    } else if (dt.MetApplicable == 'Not Acknowledged') {
                        cls_not_ack++;
                    } else {
                        cls_not_occ++;
                    }
                }
            });

            let ack_met_per = ((ack_met / ack) * 100).toFixed(2);
            ack_met_per = isNaN(ack_met_per) ? '0.0' : ack_met_per;
            let ack_not_met_per = ((ack_not_met / ack) * 100).toFixed(2);
            ack_not_met_per = isNaN(ack_not_met_per) ? '0.0' : ack_not_met_per;
            let ack_not_ack_per = ((ack_not_ack / ack) * 100).toFixed(2);
            ack_not_ack_per = isNaN(ack_not_ack_per) ? '0.0' : ack_not_ack_per;
            let ack_not_occ_per = ((ack_not_occ / ack) * 100).toFixed(2);
            ack_not_occ_per = isNaN(ack_not_occ_per) ? '0.0' : ack_not_occ_per;

            let resp_met_per = ((resp_met / resp) * 100).toFixed(2);
            resp_met_per = isNaN(resp_met_per) ? '0.0' : resp_met_per;
            let resp_not_met_per = ((resp_not_met / resp) * 100).toFixed(2);
            resp_not_met_per = isNaN(resp_not_met_per) ? '0.0' : resp_not_met_per;
            let resp_not_ack_per = ((resp_not_ack / resp) * 100).toFixed(2);
            resp_not_ack_per = isNaN(resp_not_ack_per) ? '0.0' : resp_not_ack_per;
            let resp_not_occ_per = ((resp_not_occ / resp) * 100).toFixed(2);
            resp_not_occ_per = isNaN(resp_not_occ_per) ? '0.0' : resp_not_occ_per;

            let resv_met_per = ((resv_met / resv) * 100).toFixed(2);
            resv_met_per = isNaN(resv_met_per) ? '0.0' : resv_met_per;
            let resv_not_met_per = ((resv_not_met / resv) * 100).toFixed(2);
            resv_not_met_per = isNaN(resv_not_met_per) ? '0.0' : resv_not_met_per;
            let resv_not_ack_per = ((resv_not_ack / resv) * 100).toFixed(2);
            resv_not_ack_per = isNaN(resv_not_ack_per) ? '0.0' : resv_not_ack_per;
            let resv_not_occ_per = ((resv_not_occ / resv) * 100).toFixed(2);
            resv_not_occ_per = isNaN(resv_not_occ_per) ? '0.0' : resv_not_occ_per;

            let cls_met_per = ((cls_met / cls) * 100).toFixed(2);
            cls_met_per = isNaN(cls_met_per) ? '0.0' : cls_met_per;
            let cls_not_met_per = ((cls_not_met / cls) * 100).toFixed(2);
            cls_not_met_per = isNaN(cls_not_met_per) ? '0.0' : cls_not_met_per;
            let cls_not_ack_per = ((cls_not_ack / cls) * 100).toFixed(2);
            cls_not_ack_per = isNaN(cls_not_ack_per) ? '0.0' : cls_not_ack_per;
            let cls_not_occ_per = ((cls_not_occ / cls) * 100).toFixed(2);
            cls_not_occ_per = isNaN(cls_not_occ_per) ? '0.0' : cls_not_occ_per;

            let overall_met = ((ack_met + resp_met + resv_met + cls_met) / (ack + resp + resv + cls) * 100).toFixed(2);
            overall_met = isNaN(overall_met) ? '0.0' : overall_met;
            let overall_not_met = ((ack_not_met + resp_not_met + resv_not_met + cls_not_met) / (ack + resp + resv + cls) * 100).toFixed(2);
            overall_not_met = isNaN(overall_not_met) ? '0.0' : overall_not_met;
            let overall_not_ack = ((ack_not_ack + resp_not_ack + resv_not_ack + cls_not_ack) / (ack + resp + resv + cls) * 100).toFixed(2);
            overall_not_ack = isNaN(overall_not_ack) ? '0.0' : overall_not_ack;
            let overall_not_occ = ((ack_not_occ + resp_not_occ + resv_not_occ + cls_not_occ) / (ack + resp + resv + cls) * 100).toFixed(2);
            overall_not_occ = isNaN(overall_not_occ) ? '0.0' : overall_not_occ;

            // Batch adding rows to improve performance
            dataTable.rows.add([
                ['Acknowledgement', ack_met_per, ack_not_met_per, ack_not_ack_per, ack_not_occ_per],
                ['Response', resp_met_per, resp_not_met_per, resp_not_ack_per, resp_not_occ_per],
                ['Resolution', resv_met_per, resv_not_met_per, resv_not_ack_per, resv_not_occ_per],
                ['Closure', cls_met_per, cls_not_met_per, cls_not_ack_per, cls_not_occ_per],
                ['Overall', overall_met, overall_not_met, overall_not_ack, overall_not_occ]
            ]).draw();
        }

        //End of added by Durgesh D on 22 jan 2025 for the to get fetchCurrentMonthData


        // Added by Vyankat B on 22 jan 2025 Function to get Avg.Resolution This Week

        function fetchGetAvgResolThisWeek(customerID) {

            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetAvgResolThisWeek", param, false);

            // Check if the result is not null and update the UI accordingly
            if (result !== null) {

                overDueID = `'${result[0].OverDueQueryIDs}'`;
                resInTime = `'${result[0].ResInTimeQueryIDs}'`;
                keyTimesdetails = `'${result[0].DetailsQueryIDs}'`;

                $('#lblavgFRTThisWeek').text(result[0].FRTThisWeek);
                $('#lblavgResolThisWeek').text(result[0].ResThisWK);
                $('#txtrespLastWeek').text(result[0].VSFRTLastWk);
                $('#txtresolLastWeek').text(result[0].VSResLastWk);
                $('#txtoverdueid').text(result[0].OverDueCount);
                // $('#txtslaBreachPerGoingtoBreach').text(result[0].OverDueCount);


                $('#txtresolvedthistimeid').text(result[0].ResInTime);

                GoingToSLACount1 = result[0].OverDueCount
                GoingToSLACount2 = result[0].GoingToSLACount;
                GoingToSLACountID = `'${result[0].GoingToSLACountIDs}'`;

                CurrentMonthSLAIDs = `'${result[0].CurrentMonthSLAID}'`;


                $('#txtslaBreachPerGoingtoBreach').text(`${GoingToSLACount1}/${GoingToSLACount2}`);


                // Assuming the first element in the result contains the count
            } else {
                $('#lblavgResolThisWeek').text('0.00');
                $('#lblavgFRTThisWeek').text('0.00');
                $('#txtrespLastWeek').text('0.00');
                $('#txtresolLastWeek').text('0.00');
                $('#txtoverdueid').text('0.00');
                $('#txtresolvedthistimeid').text('0.00');
            }

        }

        //End of added by Vyankat B on 22 jan 2025 Function to get Avg.Resolution This Week







        // Added by Vyankat B on 22 jan 2025 for the Function to get Submitted Ticket Volume

        function fetchSubmittedStatMonthlyData(customerID) {


            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);
            //Call the AJAX function with the required parameters
            var result = AJAXCallWithResult('/api/RequesterCustomerClient/GetSubStatMonthlyData', param, false);

            // Check if the result is valid and contains expected data
            if (result !== null) {
                // Prepare data arrays
                let monthYear = [];
                let submittedStatCount = [];
                let totalStatCount = [];
                let submTotRatio = [];

                //Process the response data
                result.forEach(data => {
                    monthYear.push(data.Month_Year);
                    submittedStatCount.push(data.Submitted_Stat_Count);
                    totalStatCount.push(data.Total_Stat_Count);
                    submTotRatio.push(data.Subm_Tot_Ratio);
                });

                // Destroy the existing chart (if exists) to avoid multiple instances
                const existingSubChart = Chart.getChart('SubmittedTicketsGraph');
                if (existingSubChart) {
                    existingSubChart.destroy();
                }

                // Create the new chart
                const ctx = document.getElementById('SubmittedTicketsGraph');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: monthYear,
                        datasets: [{
                            label: 'Submitted',
                            data: submittedStatCount,
                            borderWidth: 1,
                            barThickness: 30,
                            maxBarThickness: 30,
                            minBarLength: 2,
                            backgroundColor: '#2596be', // You can use a static color if all bars are the same
                        }],
                    },
                    options: {
                        maintainAspectRatio: false,
                        responsive: true,
                        scales: {
                            x: {
                                title: {
                                    display: false,
                                },
                                grid: {
                                    offset: false,
                                    color: "#B3B3B3",
                                    tickColor: '#FFF',
                                }
                            },
                            y: {
                                max: 7,
                                min: 0,
                                ticks: {
                                    stepSize: 1
                                },
                                title: {
                                    display: false,
                                },
                                grid: {
                                    tickColor: '#FFF',
                                },
                                beginAtZero: true,
                                color: "#B3B3B3"
                            }
                        },
                        plugins: {
                            title: {
                                display: false,
                                text: 'Initiatives planned vs converted',
                                color: '#414042',
                                align: 'start',
                                padding: {
                                    bottom: 20
                                },
                                font: {
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
            } else {

            }

        }

        //End of added by Vyankat B on 22 jan 2025 for the Function to get Submitted Ticket Volume



        // Added by Vyankat B on 22 jan 2025 for the Function to get Open Ticket Volume

        function fetchOpenMonthlyData(customerID) {


            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);

            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult('/api/RequesterCustomerClient/GetOpenStatMonthlyData', param, false);

            //  Check if the result is valid and contains expected data
            if (result !== null) {
                //   Prepare data arrays
                let monthYear = [];
                let openStatCount = [];
                let totalStatCount = [];
                let openTotRatio = [];

                // Process the response data
                result.forEach(data => {
                    monthYear.push(data.Month_Year);
                    openStatCount.push(data.Open_Stat_Count);
                    totalStatCount.push(data.Total_Stat_Count);
                    openTotRatio.push(data.Open_Tot_Ratio);
                });

                //  Destroy the existing chart (if exists) to avoid multiple instances
                const existingOpenChart = Chart.getChart('OpenTicketsGraph');
                if (existingOpenChart) {
                    existingOpenChart.destroy();
                }

                // Create the new chart
                const ctx = document.getElementById('OpenTicketsGraph');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: monthYear,
                        datasets: [{
                            label: 'Open',
                            data: openStatCount,
                            borderWidth: 1,
                            barThickness: 30,
                            maxBarThickness: 30,
                            minBarLength: 2,
                            backgroundColor: '#2596be', // Set a static color for all bars
                        }],
                    },
                    options: {
                        maintainAspectRatio: false,
                        responsive: true,
                        scales: {
                            x: {
                                title: {
                                    display: false,
                                },
                                grid: {
                                    offset: false,
                                    color: "#B3B3B3",
                                    tickColor: '#FFF',
                                }
                            },
                            y: {
                                max: 7,
                                min: 0,
                                ticks: {
                                    stepSize: 1
                                },
                                title: {
                                    display: false,
                                },
                                grid: {
                                    tickColor: '#FFF',
                                },
                                beginAtZero: true,
                                color: "#B3B3B3"
                            }
                        },
                        plugins: {
                            title: {
                                display: false,
                                text: 'Open tickets data',
                                color: '#414042',
                                align: 'start',
                                padding: {
                                    bottom: 20
                                },
                                font: {
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
            } else {


            }

        }

        //End of added by Vyankat B on 22 jan 2025 for the Function to get Open Ticket Volume


        // Added by Vyankat B on 22 jan 2025 for the Function to get Due Ticket Volume

        function fetchDueStatMonthlyData(customerID) {
            // Prepare the parameters for the API call
            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);

            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult('/api/RequesterCustomerClient/GetDueStatMonthlyData', param, false);

            //Check if the result is valid and contains expected data
            if (result !== null) {
                // Prepare data arrays
                let monthYear = [];
                let dueStatCount = [];
                let totalStatCount = [];

                // Process the response data
                result.forEach(data => {
                    monthYear.push(data.Month_Year);
                    dueStatCount.push(data.due_Stat_Count);
                    totalStatCount.push(data.Total_Stat_Count);
                });

                //Destroy the existing chart (if exists) to avoid multiple instances
                const existingDueChart = Chart.getChart('DueTicketsGraph');
                if (existingDueChart) {
                    existingDueChart.destroy();
                }

                // Create the new chart
                const ctx = document.getElementById('DueTicketsGraph');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: monthYear,
                        datasets: [{
                            label: 'Due',
                            data: dueStatCount,
                            borderWidth: 1,
                            barThickness: 30,
                            maxBarThickness: 30,
                            minBarLength: 2,
                            backgroundColor: '#2596be', // Set a static color for all bars
                        }],
                    },
                    options: {
                        maintainAspectRatio: false,
                        responsive: true,
                        scales: {
                            x: {
                                title: {
                                    display: false,
                                },
                                grid: {
                                    offset: false,
                                    color: "#B3B3B3",
                                    tickColor: '#FFF',
                                }
                            },
                            y: {
                                max: 7,
                                min: 0,
                                ticks: {
                                    stepSize: 1
                                },
                                title: {
                                    display: false,
                                },
                                grid: {
                                    tickColor: '#FFF',
                                },
                                beginAtZero: true,
                                color: "#B3B3B3"
                            }
                        },
                        plugins: {
                            title: {
                                display: false,
                                text: 'Due tickets data',
                                color: '#414042',
                                align: 'start',
                                padding: {
                                    bottom: 20
                                },
                                font: {
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
            } else {

            }

        }

        //End of Added by Vyankat B on 22 jan 2025 for the Function to get Due Ticket Volume



        // Added by Vyankat B on 22 jan 2025 for the Function to get for Resolved Ticket Volume

        function fetchResolvedStatMonthlyData(customerID) {
            // Prepare the parameters for the API call
            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);

            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult('/api/RequesterCustomerClient/GetResolvedStatMonthlyData', param, false);

            // Check if the result is valid and contains expected data
            if (result !== null) {
                // Prepare data arrays
                let monthYear = [];
                let resolvedStatCount = [];
                let totalStatCount = [];
                let resolvedTotRatio = [];

                // Process the response data
                result.forEach(data => {
                    monthYear.push(data.Month_Year);
                    resolvedStatCount.push(data.Resolved_Stat_Count);
                    totalStatCount.push(data.Total_Stat_Count);
                    resolvedTotRatio.push(data.Resolved_Tot_Ratio);
                });

                //Destroy the existing chart (if exists) to avoid multiple instances
                const existingResolvedChart = Chart.getChart('ResolvedTicketsGraph');
                if (existingResolvedChart) {
                    existingResolvedChart.destroy();
                }

                // Create the new chart
                const ctx = document.getElementById('ResolvedTicketsGraph');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: monthYear,
                        datasets: [{
                            label: 'Resolved',
                            data: resolvedStatCount,
                            borderWidth: 1,
                            barThickness: 30,
                            maxBarThickness: 30,
                            minBarLength: 2,
                            backgroundColor: '#2596be', // Set a static color for all bars
                        }],
                    },
                    options: {
                        maintainAspectRatio: false,
                        responsive: true,
                        scales: {
                            x: {
                                title: {
                                    display: false,
                                },
                                grid: {
                                    offset: false,
                                    color: "#B3B3B3",
                                    tickColor: '#FFF',
                                }
                            },
                            y: {
                                max: 7,
                                min: 0,
                                ticks: {
                                    stepSize: 1
                                },
                                title: {
                                    display: false,
                                },
                                grid: {
                                    tickColor: '#FFF',
                                },
                                beginAtZero: true,
                                color: "#B3B3B3"
                            }
                        },
                        plugins: {
                            title: {
                                display: false,
                                text: 'Resolved tickets data',
                                color: '#414042',
                                align: 'start',
                                padding: {
                                    bottom: 20
                                },
                                font: {
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
            } else {

            }

        }

        //End of added by Vyankat B on 22 jan 2025 for the Function to get for Resolved Ticket Volume


        // Added by Vyankat B on 22 jan 2025 for the Function for closed Ticket Volume

        function fetchClosedStatMonthlyData(customerID) {
            // Prepare the parameters for the API call
            var Parameters = {
                CustomerID: customerID
            };
            var param = JSON.stringify(Parameters);

            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult('/api/RequesterCustomerClient/GetClosedStatMonthlyData', param, false);

            // Check if the result is valid and contains expected data
            if (result !== null) {
                // Prepare data arrays
                let monthYear = [];
                let closedStatCount = [];
                let totalStatCount = [];
                let closedTotRatio = [];

                // Process the response data
                result.forEach(data => {
                    monthYear.push(data.Month_Year);
                    closedStatCount.push(data.Closed_Stat_Count);
                    totalStatCount.push(data.Total_Stat_Count);
                    closedTotRatio.push(data.Closed_Tot_Ratio);
                });

                // Destroy the existing chart (if exists) to avoid multiple instances
                const existingClosedChart = Chart.getChart('ClosedTicketsGraph');
                if (existingClosedChart) {
                    existingClosedChart.destroy();
                }

                // Create the new chart
                const ctx = document.getElementById('ClosedTicketsGraph');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: monthYear,
                        datasets: [{
                            label: 'Closed',
                            data: closedStatCount,
                            borderWidth: 1,
                            barThickness: 30,
                            maxBarThickness: 30,
                            minBarLength: 2,
                            backgroundColor: '#2596be', // Set a static color for all bars
                        }],
                    },
                    options: {
                        maintainAspectRatio: false,
                        responsive: true,
                        scales: {
                            x: {
                                title: {
                                    display: false,
                                },
                                grid: {
                                    offset: false,
                                    color: "#B3B3B3",
                                    tickColor: '#FFF',
                                }
                            },
                            y: {
                                max: 7,
                                min: 0,
                                ticks: {
                                    stepSize: 1
                                },
                                title: {
                                    display: false,
                                },
                                grid: {
                                    tickColor: '#FFF',
                                },
                                beginAtZero: true,
                                color: "#B3B3B3"
                            }
                        },
                        plugins: {
                            title: {
                                display: false,
                                text: 'Closed tickets data',
                                color: '#414042',
                                align: 'start',
                                padding: {
                                    bottom: 20
                                },
                                font: {
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
            } else {
                // alert("No data found for the selected customer.");
            }
        }

        //End of added by Vyankat B on 22 jan 2025 for the Function for closed Ticket Volume



        // Added by Vyankat B on 22 jan 2025 for the To get details of Total Per This Week  

        function GetdepartmentTotalPerThisWeek() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTotalPerThisWeek option:selected').val();
            newCustomerID = $('#cboCustomerNameTotalPerThisWeek option:selected').val();

            // Call the function to load ticket details
            fetchGetTicketDetailsforTotalperThisweekTickets(customerID, departmentID, newCustomerID);
        };

        function GetCustomerNameTotalPerThisWeek() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTotalPerThisWeek option:selected').val();
            newCustomerID = $('#cboCustomerNameTotalPerThisWeek option:selected').val();

            // Call the function to load ticket details
            fetchGetTicketDetailsforTotalperThisweekTickets(customerID, departmentID, newCustomerID);
        };





        // When the #totalPerThisWeekTicket_OffcvsScreen is clicked
        $('#totalPerThisWeekTicket_OffcvsScreen').on('shown.bs.offcanvas', function () {



            $("#cbodepartmentTotalPerThisWeek").val(0);
            $("#cboCustomerNameTotalPerThisWeek").val(0);

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTotalPerThisWeek option:selected').val();
            newCustomerID = $('#cboCustomerNameTotalPerThisWeek option:selected').val();
            // Call the function loadGetTicketDetailsforTotalperThisweekTickets when clicked
            fetchGetTicketDetailsforTotalperThisweekTickets(customerID, departmentID, newCustomerID);
        });



        //Added by Vyankat B for the fomatting the input date 

        function formatDate(strDate) {

            var date = new Date(strDate);

            var day = date.getDate();
            var month = date.toLocaleString('en-us', { month: 'short' });
            var year = date.getFullYear();

            return `${day} ${month} ${year}`;
        }




        // Added by Vyankat B on 22 jan 2025 for the  Function to get details of Total Per This Week

        function fetchGetTicketDetailsforTotalperThisweekTickets() {


            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };


            var param = JSON.stringify(Parameters);

            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforTotalperThisweekTickets", param, false);



            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_totalPerThisWeekDetails').DataTable();
                dataTable.clear();  // Clear any existing data*/

                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_totalPerThisWeekDetails tbody tr td').addClass('text-center');

            }
            else {

                var dataTable = $('#tbl_totalPerThisWeekDetails').DataTable();
                dataTable.clear();  // Clear any existing data*/
                // No data found, display a "No tickets found" message in the table
                $('#tbl_totalPerThisWeekDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of  Added by Vyankat B on 22 jan 2025 for the  Function to get details of Total Per This Week





        // To get details of Unassigned Tickets        
        function GetdepartmentUnassignedTickets() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentUnassignedTickets option:selected').val();
            newCustomerID = $('#cboCustomerNameUnassigned option:selected').val();

            // Call the function to load ticket details
            fetchTicketDetailsforUnassignedTickets(customerID, departmentID, newCustomerID);
        };

        function GetCustomerNameUnassigned() {




            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentUnassignedTickets option:selected').val();
            newCustomerID = $('#cboCustomerNameUnassigned option:selected').val();

            // Call the function to load ticket details
            fetchTicketDetailsforUnassignedTickets(customerID, departmentID, newCustomerID);

        };



        // When the #unassignedTickets_OffcvsScreen is clicked
        $('#unassignedTickets_OffcvsScreen').on('shown.bs.offcanvas', function () {



            $("#cbodepartmentUnassignedTickets").val(0);
            $("#cboCustomerNameUnassigned").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentUnassignedTickets option:selected').val();
            newCustomerID = $('#cboCustomerNameUnassigned option:selected').val();
            // Call the function fetchTicketDetailsforUnassignedTickets when clicked
            fetchTicketDetailsforUnassignedTickets(customerID, departmentID, newCustomerID);
        });




        // Added by Vyankat B on 22 jan 2025 for the Function to give details for Unassigned Tickets

        function fetchTicketDetailsforUnassignedTickets() {



            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };


            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforUnassignedTickets", param, false);



            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_UnassignedTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data*/
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? 'Unassigned'
                    ]).draw();
                });

                $('#tbl_UnassignedTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_UnassignedTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data*/
                // No data found, display a "No tickets found" message in the table
                $('#tbl_UnassignedTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }
        }

        //End of added by Vyankat B on 22 jan 2025 for the Function to give details for Unassigned Tickets



        ////To get details for open status
        function GetdepartmentOpenStatus() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentOpenStatus option:selected').val();
            newCustomerID = $('#cbocustomerOpenStatus option:selected').val();

            fetchGetTicketDetailsforOpenStatus(customerID, departmentID, newCustomerID);

        };

        function GetcustomerOpenStatus() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentOpenStatus option:selected').val();
            newCustomerID = $('#cbocustomerOpenStatus option:selected').val();
            fetchGetTicketDetailsforOpenStatus(customerID, departmentID, newCustomerID);

        };


        // When the #opeStatus_OffcvsScreen is clicked
        $('#opeStatus_OffcvsScreen').on('shown.bs.offcanvas', function () {



            $("#cbodepartmentOpenStatus").val(0);
            $("#cbocustomerOpenStatus").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentOpenStatus option:selected').val();
            newCustomerID = $('#cbocustomerOpenStatus option:selected').val();
            // Call the function fetchGetTicketDetailsforOpenStatus when clicked
            fetchGetTicketDetailsforOpenStatus(customerID, departmentID, newCustomerID);
        });





        // Added by Vyankat B on 22 jan 2025 for the Function to get Details for Open Status

        function fetchGetTicketDetailsforOpenStatus() {

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };


            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforOpenStatusTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_openStatusDetails').DataTable();
                dataTable.clear();  // Clear any existing data*/
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_openStatusDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_openStatusDetails').DataTable();
                dataTable.clear();  // Clear any existing data*/

                // No data found, display a "No tickets found" message in the table
                $('#tbl_openStatusDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of added by Vyankat B on 22 jan 2025 for the Function to get Details for Open Status


        //To get details for resolved status
        function GetdepartmentResolvedStatus() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentResolvedStatus option:selected').val();
            newCustomerID = $('#cboCustomerResolvedStatus option:selected').val();

            fetchGetTicketDetailsforResolvedStatus(customerID, departmentID, newCustomerID);

        };

        function GetCustomerResolvedStatus() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentResolvedStatus option:selected').val();
            newCustomerID = $('#cboCustomerResolvedStatus option:selected').val();
            fetchGetTicketDetailsforResolvedStatus(customerID, departmentID, newCustomerID);
        };




        // When the #opeStatus_OffcvsScreen is clicked
        $('#resolvedTickets_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentResolvedStatus").val(0);
            $("#cboCustomerResolvedStatus").val(0);

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentResolvedStatus option:selected').val();
            newCustomerID = $('#cboCustomerResolvedStatus option:selected').val();

            // Call the function fetchGetTicketDetailsforResolvedStatus when clicked
            fetchGetTicketDetailsforResolvedStatus(customerID, departmentID, newCustomerID);
        });


        // Added by Vyankat B on 22 jan 2025 for the Function to get details for resolved STATUS tickets

        function fetchGetTicketDetailsforResolvedStatus(customerID, departmentID, newCustomerID) {
            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforResolvedStatusTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_ResolvedTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_ResolvedTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_ResolvedTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // No data found, display a "No tickets found" message in the table
                $('#tbl_ResolvedTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of  added by Vyankat B on 22 jan 2025 for the Function to get details for resolved STATUS tickets


        //To get details for close status
        function GetdepartmentClosedStatus() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentClosedStatus option:selected').val();
            newCustomerID = $('#cboCustomerClosedStatus option:selected').val();

            fetchGetTicketDetailsforClosedStatus(customerID, departmentID, newCustomerID);
        };

        function GetCustomerClosedStatus() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentClosedStatus option:selected').val();
            newCustomerID = $('#cboCustomerClosedStatus option:selected').val();
            fetchGetTicketDetailsforClosedStatus(customerID, departmentID, newCustomerID);
        };



        // When the #closedStatus_OffcvsScreen is clicked
        $('#closedStatus_OffcvsScreen').on('shown.bs.offcanvas', function () {


            $("#cbodepartmentClosedStatus").val(0);
            $("#cboCustomerClosedStatus").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentClosedStatus option:selected').val();
            newCustomerID = $('#cboCustomerClosedStatus option:selected').val();
            // Call the function fetchGetTicketDetailsforClosedStatus when clicked
            fetchGetTicketDetailsforClosedStatus(customerID, departmentID, newCustomerID);

        });


        // Added by Vyankat B on 22 jan 2025 for the Function to get details for closed status

        function fetchGetTicketDetailsforClosedStatus(customerID, departmentID, newCustomerID) {

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforClosedStatusTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_closedStatusDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([             
                            ticket.ID,
                            ticket.Subject,
                            ticket.RequestType,
                            ticket.Priority,
                            ticket.Requestor ?? '',
                            ticket.RequestorName ?? '',
                            ticket.RequestedOn ?? '',
                            ticket.LastUpdated ?? '',
                            ticket.ExpDateofResol ?? '',
                            ticket.Status ?? '',
                            ticket.AssignTo ?? ''
                        ]).draw();
                });

                $('#tbl_closedStatusDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_closedStatusDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_closedStatusDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of added by Vyankat B on 22 jan 2025 for the Function to get details for closed status


        // for  Tickets
        function GetdepartmentTickets() {


            customerId = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTickets option:selected').val();
            newCustomerID = $('#cbocustomerTickets option:selected').val();

            fetchTicketDetailsforTickets(customerId, departmentID, newCustomerID);
        };

        function GetcustomerTickets() {

            customerId = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTickets option:selected').val();
            newCustomerID = $('#cbocustomerTickets option:selected').val();
            fetchTicketDetailsforTickets(customerId, departmentID, newCustomerID);
        };


        //// When the #allTicket_OffcvsScreen is clicked
        $('#allTicket_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentTickets").val(0);
            $("#cbocustomerTickets").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTickets option:selected').val();
            newCustomerID = $('#cbocustomerTickets option:selected').val();
            // Call the function fetchTicketDetailsforTickets when clicked
            fetchTicketDetailsforTickets(customerID, departmentID, newCustomerID);
        });




        // Added by Vyankat B on 22 jan 2025 for the Function to get details for tickets

        function fetchTicketDetailsforTickets(customerID, departmentID, newCustomerID) {
            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {

                var dataTable = $('#tbl_TicketsDetails').DataTable();

                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_TicketsDetails tbody tr td').addClass('text-center');

            }
            else {

                var dataTable = $('#tbl_TicketsDetails').DataTable();

                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_TicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of added by Vyankat B on 22 jan 2025 for the Function to get details for tickets


        // for Backlog Tickets
        function GetdepartmentBacklog() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentBacklog option:selected').val();
            newCustomerID = $('#cbocustomerBacklog option:selected').val();

            fetchGetTicketDetailsforBacklogTickets(customerID, departmentID, newCustomerID);
        };

        function GetcustomerBacklog() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentBacklog option:selected').val();
            newCustomerID = $('#cbocustomerBacklog option:selected').val();
            fetchGetTicketDetailsforBacklogTickets(customerID, departmentID, newCustomerID);
        };


        // When the #backlogTicket_OffcvsScreen is clicked

        $('#backlogTicket_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentBacklog").val(0);
            $("#cbocustomerBacklog").val(0);
            var customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentBacklog option:selected').val();
            newCustomerID = $('#cbocustomerBacklog option:selected').val();
            // Call the function fetchGetTicketDetailsforBacklogTickets when clicked
            fetchGetTicketDetailsforBacklogTickets(customerID, departmentID, newCustomerID);
        });



        // Added by Vyankat B on 22 jan 2025 for the Function to get details of Backlog tickets

        function fetchGetTicketDetailsforBacklogTickets(customerID, departmentID, newCustomerID) {

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforBacklogTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_backlogTicketsDetails').DataTable();
                dataTable.clear();  // Clear existing data

                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_backlogTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_backlogTicketsDetails').DataTable();
                dataTable.clear();  // Clear existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_backlogTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of Added by Vyankat B on 22 jan 2025 for the Function to get details of Backlog tickets


        // for Inflow This Month Tickets
        function GetdepartmentInflowThisMonth() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentInflowThisMonth option:selected').val();
            newCustomerID = $('#cbocustomerInflowThisMonth option:selected').val();

            fetchGetTicketDetailsforinflowThisMonthTickets(customerID, departmentID, newCustomerID);
        };

        function GetcustomerInflowThisMonth() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentInflowThisMonth option:selected').val();
            newCustomerID = $('#cbocustomerInflowThisMonth option:selected').val();
            fetchGetTicketDetailsforinflowThisMonthTickets(customerID, departmentID, newCustomerID);
        };



        // When the #inflowThisMonthTicket_OffcvsScreen is clicked
        $('#inflowThisMonthTicket_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentInflowThisMonth").val(0);
            $("#cbocustomerInflowThisMonth").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentInflowThisMonth option:selected').val();
            newCustomerID = $('#cbocustomerInflowThisMonth option:selected').val();
            // Call the function fetchGetTicketDetailsforinflowThisMonthTickets when clicked
            fetchGetTicketDetailsforinflowThisMonthTickets(customerID, departmentID, newCustomerID);
        });


        // Added by Vyankat B on 22 jan 2025 for the Function to get details of Inflow this month tickets

        function fetchGetTicketDetailsforinflowThisMonthTickets(customerID, departmentID, newCustomerID) {
            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforinflowThisMonthTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_inflowThisMonthTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_inflowThisMonthTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_inflowThisMonthTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_inflowThisMonthTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of Added by Vyankat B on 22 jan 2025 for the Function to get details of Inflow this month tickets




        $('#cbodepartmentResolvedThisMonth').on('change', function () {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentResolvedThisMonth option:selected').val();
            newCustomerID = $('#cbocustomerResolvedThisMonth option:selected').val();

            fetchGetTicketDetailsforResolvedThisMonthTickets(customerID, departmentID, newCustomerID);
        });

        $('#cbocustomerResolvedThisMonth').on('change', function () {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentResolvedThisMonth option:selected').val();
            newCustomerID = $('#cbocustomerResolvedThisMonth option:selected').val();
            fetchGetTicketDetailsforResolvedThisMonthTickets(customerID, departmentID, newCustomerID);
        });


        // When the #resolvedThisMonthTicket_OffcvsScreen is clicked

        $('#resolvedThisMonthTicket_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentResolvedThisMonth").val(0);
            $("#cbocustomerResolvedThisMonth").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentResolvedThisMonth option:selected').val();
            newCustomerID = $('#cbocustomerResolvedThisMonth option:selected').val();
            // Call the function fetchGetTicketDetailsforResolvedThisMonthTickets when clicked
            fetchGetTicketDetailsforResolvedThisMonthTickets(customerID, departmentID, newCustomerID);
        });


        // Added by Vyankat B on 22 jan 2025 for Function to get details of Resolved This Month tickets

        function fetchGetTicketDetailsforResolvedThisMonthTickets(customerID, departmentID, newCustomerID) {

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforresolvedInMonthTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_resolvedThisMonthTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_resolvedThisMonthTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_resolvedThisMonthTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_resolvedThisMonthTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }
        //End of  Added by Vyankat B on 22 jan 2025 for Function to get details of Resolved This Month tickets

        // for Priority Tickets
        function GetdepartmentPriorityDetails() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentPriorityDetails option:selected').val();
            newCustomerID = $('#cbocustomerPriorityDetails option:selected').val();

            fetchGetTicketDetailsforPriority(customerID, departmentID, newCustomerID);
        };

        function GetcustomerPriorityDetails() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentPriorityDetails option:selected').val();
            newCustomerID = $('#cbocustomerPriorityDetails option:selected').val();

            fetchGetTicketDetailsforPriority(customerID, departmentID, newCustomerID);
        };



        // When the #prioritydetails_OffcvsScreen is clicked
        $('#prioritydetails_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentPriorityDetails").val(0);
            $("#cbocustomerPriorityDetails").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentPriorityDetails option:selected').val();
            newCustomerID = $('#cbocustomerPriorityDetails option:selected').val();
            // Call the function fetchGetTicketDetailsforPriority when clicked
            fetchGetTicketDetailsforPriority(customerID, departmentID, newCustomerID);
        });


        // Added by Vyankat B on 22 jan 2025 for Function to get details for Priority  

        function fetchGetTicketDetailsforPriority(customerID, departmentID, newCustomerID) {

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforPriorityTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_priorityTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_priorityTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_priorityTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_priorityTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of  Added by Vyankat B on 22 jan 2025 for Function to get details for Priority  


        // for Severity Tickets
        function GetdepartmentSeverityDetails() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentSeverityDetails option:selected').val();
            newCustomerID = $('#cbocustomerSeverityDetails option:selected').val();

            fetchGetTicketDetailsforSeverity(customerID, departmentID, newCustomerID);
        };

        function GetcustomerSeverityDetails() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentSeverityDetails option:selected').val();
            newCustomerID = $('#cbocustomerSeverityDetails option:selected').val();
            fetchGetTicketDetailsforSeverity(customerID, departmentID, newCustomerID);
        };


        // When the #severitydetails_OffcvsScreen is clicked
        $('#severitydetails_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentSeverityDetails").val(0);
            $("#cbocustomerSeverityDetails").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentSeverityDetails option:selected').val();
            newCustomerID = $('#cbocustomerSeverityDetails option:selected').val();
            // Call the function fetchGetTicketDetailsforSeverity when clicked
            fetchGetTicketDetailsforSeverity(customerID, departmentID, newCustomerID);
        });




        // Added by Vyankat B on 22 jan 2025 for Function to get details for Severity

        function fetchGetTicketDetailsforSeverity(customerID, departmentID, newCustomerID) {

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforSeverityTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_severityTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_severityTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_severityTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_severityTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of Added by Vyankat B on 22 jan 2025 for Function to get details for Severity



        // for CR Tickets
        $('#cbodepartmentCRTickets').on('change', function () {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentCRTickets option:selected').val();
            newCustomerID = $('#cbocustomerCRDetails option:selected').val();

            fetchGetTicketDetailsforCR(customerID, departmentID, newCustomerID);
        });

        $('#cbocustomerCRDetails').on('change', function () {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentCRTickets option:selected').val();
            newCustomerID = $('#cbocustomerCRDetails option:selected').val();
            fetchGetTicketDetailsforCR(customerID, departmentID, newCustomerID);
        });


        //    // When the #cRdetails_OffcvsScreen is clicked
        $('#cRdetails_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentCRTickets").val(0);
            $("#cbocustomerCRDetails").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentCRTickets option:selected').val();
            newCustomerID = $('#cbocustomerCRDetails option:selected').val();
            // Call the function fetchGetTicketDetailsforCR when clicked
            fetchGetTicketDetailsforCR(customerID, departmentID, newCustomerID);
        });



        // Added by Vyankat B on 22 jan 2025 for Function for details of CR Tickets

        function fetchGetTicketDetailsforCR(customerID, departmentID, newCustomerID) {

            var Parameters = {
                CustomerID: customerID, /*$("#cboNewCustomerIDSelectID").val(),*/
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforCRTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_CRTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_CRTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_CRTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_CRTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of Added by Vyankat B on 22 jan 2025 for Function for details of CR Tickets




        // for New Tickets Created Monthly As Per Priority
        function GetdepartmentNewTickets() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentNewTickets option:selected').val();
            newCustomerID = $('#cbocustomerNewTickets option:selected').val();

            fetchGetTicketDetailsfornewTickets(customerID, departmentID, newCustomerID);
        };

        function GetcustomerNewTickets() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentNewTickets option:selected').val();
            newCustomerID = $('#cbocustomerNewTickets option:selected').val();
            fetchGetTicketDetailsfornewTickets(customerID, departmentID, newCustomerID);
        };



        // When the #newTicketdetails_OffcvsScreen is clicked
        $('#newTicketdetails_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentNewTickets").val(0);
            $("#cbocustomerNewTickets").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentNewTickets option:selected').val();
            newCustomerID = $('#cbocustomerNewTickets option:selected').val();
            // Call the function fetchGetTicketDetailsfornewTickets when clicked
            fetchGetTicketDetailsfornewTickets(customerID, departmentID, newCustomerID);
        });


        // Added by Vyankat B on 22 jan 2025 for Function to get deatils for New Tickets Created Monthly As Per Priority

        function fetchGetTicketDetailsfornewTickets(customerID, departmentID, newCustomerID) {

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID
            };

            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforNewTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_newTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_newTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_newTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_newTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }
        //End of  added by Vyankat B on 22 jan 2025 for Function to get deatils for New Tickets Created Monthly As Per Priority


        function GetdepartmentKTTickets() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentKTTickets option:selected').val();
            newCustomerID = $('#cbocustomerKTDetails option:selected').val();
            fetchGetTicketDetailsforKeyTimes(customerID, departmentID, newCustomerID);
        };

        function GetcustomerKTDetails() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentKTTickets option:selected').val();
            newCustomerID = $('#cbocustomerKTDetails option:selected').val();
            fetchGetTicketDetailsforKeyTimes(customerID, departmentID, newCustomerID);
        };




        // When the #keyTimesdetails_OffcvsScreen is clicked
        $('#keyTimesdetails_OffcvsScreen').on('shown.bs.offcanvas', function () {

            $("#cbodepartmentKTTickets").val(0);
            $("#cbocustomerKTDetails").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentKTTickets option:selected').val();
            newCustomerID = $('#cbocustomerKTDetails option:selected').val();
            // Call the function fetchGetTicketDetailsforKeyTimes when clicked
            fetchGetTicketDetailsforKeyTimes(customerID, departmentID, newCustomerID);
        });



        // Added by Vyankat B on 22 jan 2025 for Function for details of CR Tickets

        function fetchGetTicketDetailsforKeyTimes(customerID, DepartmentID, NewCustomerID) {

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: DepartmentID,
                NewCustomerID: NewCustomerID,
                DetailsQueryIDs: keyTimesdetails
            };
            var param = JSON.stringify(Parameters);

            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforKeyTimes", param, false);

            if (result !== null && result.length > 0) {

                var dataTable = $('#tbl_KeyTimeTicketsDetails').DataTable();

                dataTable.clear();

                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_KeyTimeTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_KeyTimeTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_KeyTimeTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

        //End of Added by Vyankat B on 22 jan 2025 for Function for details of CR Tickets


        // for Current Month details
        function GetDepartmentCurrentMonth() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cboDepartmentCurrentMonth option:selected').val();
            newCustomerID = $('#cboCustomerCurrentMonth option:selected').val();

            fetchDetailsforCurrentMonth(customerID, departmentID, newCustomerID);
        };

        function GetCustomerCurrentMonth() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cboDepartmentCurrentMonth option:selected').val();
            newCustomerID = $('#cboCustomerCurrentMonth option:selected').val();
            fetchDetailsforCurrentMonth(customerID, departmentID, newCustomerID);
        };


        // When the #currentMonth_OffcvsScreen is clicked
        $('#currentMonth_OffcvsScreen').on('shown.bs.offcanvas', function () {
            // 
            $("#cboDepartmentCurrentMonth").val(0);
            $("#cboCustomerCurrentMonth").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cboDepartmentCurrentMonth option:selected').val();
            newCustomerID = $('#cboCustomerCurrentMonth option:selected').val();
            // Call the function fetchDetailsforCurrentMonth when clicked
            fetchDetailsforCurrentMonth(customerID, departmentID, newCustomerID);
        });


        // Added by Vyankat B on 22 jan 2025 for Function for details of SLA for Current Month

        function fetchDetailsforCurrentMonth(customerID, departmentID, newCustomerID) {

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID,
                DetailsQueryIDs: CurrentMonthSLAIDs
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetDetailsforCurrentMonth", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_CurrentMonthTbl').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_CurrentMonthTbl tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_CurrentMonthTbl').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_CurrentMonthTbl tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }


        }




        var selectedTab = 'Submitted';  // Default to 'Submitted' if no tab is selected

        customerID = $('#cboCustomerNameSelectID option:selected').val();
        departmentID = $('#cbodepartmentTicketVolume option:selected').val();
        newCustomerID = $('#cboCustomerNewVolume option:selected').val();



        // Capture the values when #TabSubmitted is clicked
        $('#TabSubmitted').on('click', function () {
            selectedTab = 'Submitted'; // Set the selected tab to 'Submitted'

            // Fetch the relevant customer, department, and customer name from the selects
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTicketVolume option:selected').val();
            newCustomerID = $('#cboCustomerNewVolume option:selected').val();
        });

        // Capture the values when #TabOpen is clicked
        $('#TabOpen').on('click', function () {
            selectedTab = 'Open'; // Set the selected tab to 'Open'

            // Fetch the relevant customer, department, and customer name from the selects
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTicketVolume option:selected').val();
            newCustomerID = $('#cboCustomerNewVolume option:selected').val();
        });

        // Capture the values when #TabDue is clicked
        $('#TabDue').on('click', function () {
            selectedTab = 'Due'; // Set the selected tab to 'Due'

            // Fetch the relevant customer, department, and customer name from the selects
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTicketVolume option:selected').val();
            newCustomerID = $('#cboCustomerNewVolume option:selected').val();
        });

        // Capture the values when #TabResolved is clicked
        $('#TabResolved').on('click', function () {
            selectedTab = 'Resolved'; // Set the selected tab to 'Resolved'

            // Fetch the relevant customer, department, and customer name from the selects
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTicketVolume option:selected').val();
            newCustomerID = $('#cboCustomerNewVolume option:selected').val();
        });

        // Capture the values when #TabClosed is clicked
        $('#TabClosed').on('click', function () {
            selectedTab = 'Closed'; // Set the selected tab to 'Closed'

            // Fetch the relevant customer, department, and customer name from the selects
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTicketVolume option:selected').val();
            newCustomerID = $('#cboCustomerNewVolume option:selected').val();
        });

        // When the department or customer dropdown changes, trigger the fetch function
        function GetdepartmentTicketVolume() {
          /*  debugger*/
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTicketVolume option:selected').val();
            newCustomerID = $('#cboCustomerNewVolume option:selected').val();
            fetchTicketVolumeDatadetails(customerID, departmentID, newCustomerID, selectedTab);

        };

        function GetCustomerNewVolume() {
            /*debugger*/

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentTicketVolume option:selected').val();
            newCustomerID = $('#cboCustomerNewVolume option:selected').val();
            fetchTicketVolumeDatadetails(customerID, departmentID, newCustomerID, selectedTab);

        };


        // Trigger the function when #ticketVolumedetails_OffcvsScreen is shown
        $('#ticketVolumedetails_OffcvsScreen').on('shown.bs.offcanvas', function () {




            // If no tab is selected, default to 'Submitted'
            if (!selectedTab) {
                selectedTab = 'Submitted'; // Default to 'Submitted' if no tab is selected

            }

            // Reset values
            $("#cbodepartmentTicketVolume").val(0);
            $("#cboCustomerNewVolume").val(0);

            // console.log("Offcanvas shown for Tab:", selectedTab); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

            // Handle based on the selected tab
            if (selectedTab === 'Submitted') {


                //  console.log("Loading data for TabSubmitted", customerID, DepartmentID, NewCustomerID); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

                if (customerID && departmentID && newCustomerID) {

                    customerID = $('#cboCustomerNameSelectID option:selected').val();
                    departmentID = $('#cbodepartmentTicketVolume option:selected').val();
                    newCustomerID = $('#cboCustomerNewVolume option:selected').val();

                    fetchTicketVolumeDatadetails(customerID, departmentID, newCustomerID, selectedTab);
                } else {
                    // console.log("Missing data for TabSubmitted."); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                }
            } else if (selectedTab === 'Open') {


                //  console.log("Loading data for TabOpen", customerID, DepartmentID, NewCustomerID); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

                if (customerID && departmentID && newCustomerID) {

                    customerID = $('#cboCustomerNameSelectID option:selected').val();
                    departmentID = $('#cbodepartmentTicketVolume option:selected').val();
                    newCustomerID = $('#cboCustomerNewVolume option:selected').val();

                    fetchTicketVolumeDatadetails(customerID, departmentID, newCustomerID, selectedTab);
                } else {
                    // console.log("Missing data for TabOpen."); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                }
            } else if (selectedTab === 'Due') {
                // console.log("Loading data for TabDue", customerID, DepartmentID, NewCustomerID); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

                if (customerID && departmentID && newCustomerID) {

                    customerID = $('#cboCustomerNameSelectID option:selected').val();
                    departmentID = $('#cbodepartmentTicketVolume option:selected').val();
                    newCustomerID = $('#cboCustomerNewVolume option:selected').val();

                    fetchTicketVolumeDatadetails(customerID, departmentID, newCustomerID, selectedTab);
                } else {
                    // console.log("Missing data for TabDue."); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                }
            } else if (selectedTab === 'Resolved') {
                // console.log("Loading data for TabResolved", customerID, DepartmentID, NewCustomerID); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

                if (customerID && departmentID && newCustomerID) {

                    customerID = $('#cboCustomerNameSelectID option:selected').val();
                    departmentID = $('#cbodepartmentTicketVolume option:selected').val();
                    newCustomerID = $('#cboCustomerNewVolume option:selected').val();

                    fetchTicketVolumeDatadetails(customerID, departmentID, newCustomerID, selectedTab);
                } else {
                    // console.log("Missing data for TabResolved."); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                }
            } else if (selectedTab === 'Closed') {
                //    console.log("Loading data for TabClosed", customerId, DepartmentID, NewCustomerID); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

                if (customerID && departmentID && newCustomerID) {

                    customerID = $('#cboCustomerNameSelectID option:selected').val();
                    departmentID = $('#cbodepartmentTicketVolume option:selected').val();
                    newCustomerID = $('#cboCustomerNewVolume option:selected').val();

                    fetchTicketVolumeDatadetails(customerID, departmentID, newCustomerID, selectedTab);
                } else {
                    // console.log("Missing data for TabClosed."); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                }
            } else {
                // console.log("No tab selected."); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            }
        });







        // Added by Vyankat B on 22 jan 2025 for function to get details for Submitted Ticket Volume

        function fetchTicketVolumeDatadetails(customerID, departmentID, newCustomerID, statusflag) {


            //debugger

            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID,
                StatusFlag: statusflag
            };

            var param = JSON.stringify(Parameters);

            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforTicketVolume", param, false);

            // console.log("AJAX result:", result); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

            if (result !== null && result.length > 0) {

                var dataTable = $('#tbl_ticketVolumeDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_ticketVolumeDetails tbody tr td').addClass('text-center');
            } else {

                var dataTable = $('#tbl_ticketVolumeDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                $('#tbl_ticketVolumeDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }
        }

        //End of Added by Vyankat B on 22 jan 2025 for function to get details for Submitted Ticket Volume



        //for Overdue Tickets
        function GetdepartmentOverdue() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentOverdue option:selected').val();
            newCustomerID = $('#cbocustomerOverdue option:selected').val();

            fetchGetDetailsforOverdueTickets(customerID, departmentID, newCustomerID);
        };

        function GetcustomerOverdue() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentOverdue option:selected').val();
            newCustomerID = $('#cbocustomerOverdue option:selected').val();
            fetchGetDetailsforOverdueTickets(customerID, departmentID, newCustomerID);
        };



        // When the #overdueTicket_OffcvsScreen is clicked
        $('#overdueTicket_OffcvsScreen').on('shown.bs.offcanvas', function () {
            // 
            $("#cbodepartmentOverdue").val(0);
            $("#cbocustomerOverdue").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentOverdue option:selected').val();
            newCustomerID = $('#cbocustomerOverdue option:selected').val();
            // Call the function fetchGetDetailsforOverdueTickets when clicked
            fetchGetDetailsforOverdueTickets(customerID, departmentID, newCustomerID);
        });


        // Added by Vyankat B on 22 jan 2025 for Function to get details of Overdue tickets

        function fetchGetDetailsforOverdueTickets(customerID, departmentID, newCustomerID) {



            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID,
                OverDueID: overDueID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforOverdueTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_overdueTicketsDetails').DataTable();
                dataTable.clear();
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_overdueTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_overdueTicketsDetails').DataTable();
                dataTable.clear();

                // No data found, display a "No tickets found" message in the table
                $('#tbl_overdueTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }
        }

        //End of Added by Vyankat B on 22 jan 2025 for Function to get details of Overdue tickets

        // for Resolved In Time Tickets
        function GetdepartmentResolvedInTime() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#departmentResolvedInTime option:selected').val();
            newCustomerID = $('#customerResolvedInTime option:selected').val();

            fetchGetDetailsforResolvedInTimeTickets(customerID, departmentID, newCustomerID);
        };

        function GetcustomerResolvedInTime() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#departmentResolvedInTime option:selected').val();
            newCustomerID = $('#customerResolvedInTime option:selected').val();
            fetchGetDetailsforResolvedInTimeTickets(customerID, departmentID, newCustomerID);
        };




        // When the #resolvedInTimeTicket_OffcvsScreen is clicked
        $('#resolvedInTimeTicket_OffcvsScreen').on('shown.bs.offcanvas', function () {
            // 
            $("#departmentResolvedInTime").val(0);
            $("#customerResolvedInTime").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#departmentResolvedInTime option:selected').val();
            newCustomerID = $('#customerResolvedInTime option:selected').val();
            // Call the function fetchGetDetailsforResolvedInTimeTickets when clicked
            fetchGetDetailsforResolvedInTimeTickets(customerID, departmentID, newCustomerID);
        });




        // Added by Vyankat B on 22 jan 2025 for Function to get details of Resolved In Time tickets

        function fetchGetDetailsforResolvedInTimeTickets(customerID, departmentID, newCustomerID) {



            var Parameters = {
                CustomerID: customerID,
                DepartmentID: departmentID,
                NewCustomerID: newCustomerID,
                ResInTimeIDs: resInTime



            };
            var param = JSON.stringify(Parameters);

            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforresolvedInTimeTickets", param, false);

            if (result !== null && result.length > 0) {

                var dataTable = $('#tbl_resolvedInTimeTicketsDetails').DataTable();

                dataTable.clear();

                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_resolvedInTimeTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_resolvedInTimeTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_resolvedInTimeTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }
        }

        //End of added by Vyankat B on 22 jan 2025 for Function to get details of Resolved In Time tickets



        //for Sla breach
        function GetdepartmentBreachDetails() {


            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentBreachDetails option:selected').val();
            newCustomerID = $('#cbocustomerBreachDetails option:selected').val();

            fetchGetDetailsforBreach(customerID, departmentID, newCustomerID);
        };

        function GetcustomerBreachDetails() {

            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentBreachDetails option:selected').val();
            newCustomerID = $('#cbocustomerBreachDetails option:selected').val();
            fetchGetDetailsforBreach(customerID, departmentID, newCustomerID);
        };



        // When the #breachdetails_OffcvsScreen is clicked
        $('#breachdetails_OffcvsScreen').on('shown.bs.offcanvas', function () {
            // 
            $("#cbodepartmentBreachDetails").val(0);
            $("#cbocustomerBreachDetails").val(0);
            customerID = $('#cboCustomerNameSelectID option:selected').val();
            departmentID = $('#cbodepartmentBreachDetails option:selected').val();
            newCustomerID = $('#cbocustomerBreachDetails option:selected').val();
            // Call the function fetchGetDetailsforBreach when clicked
            fetchGetDetailsforBreach(customerID, departmentID, newCustomerID);
        });



        // Added by Vyankat B on 22 jan 2025 for Function to get details for SLA Breach

        function fetchGetDetailsforBreach(customerID, DepartmentID, NewCustomerID) {



            var Parameters = {
                CustomerID: customerID,
                DepartmentID: DepartmentID,
                DetailsQueryIDs: GoingToSLACountID,
                NewCustomerID: NewCustomerID
            };
            var param = JSON.stringify(Parameters);
            // Call the AJAX function with the required parameters
            var result = AJAXCallWithResult("/api/RequesterCustomerClient/GetTicketDetailsforBreachTickets", param, false);
            // Check if the result is not null and update the UI accordingly
            if (result !== null && result.length > 0) {
                var dataTable = $('#tbl_breachTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data
                // Loop through the result data and populate rows in the DataTable
                result.forEach(function (ticket) {
                    dataTable.row.add([
                        ticket.ID,
                        ticket.Subject,
                        ticket.RequestType,
                        ticket.Priority,
                        ticket.Requestor ?? '',
                        ticket.RequestorName ?? '',
                        ticket.RequestedOn ?? '',
                        ticket.LastUpdated ?? '',
                        ticket.ExpDateofResol ?? '',
                        ticket.Status ?? '',
                        ticket.AssignTo ?? ''
                    ]).draw();
                });

                $('#tbl_breachTicketsDetails tbody tr td').addClass('text-center');
            }
            else {

                var dataTable = $('#tbl_breachTicketsDetails').DataTable();
                dataTable.clear();  // Clear any existing data

                // No data found, display a "No tickets found" message in the table
                $('#tbl_breachTicketsDetails tbody').html('<tr><td colspan="11" class="text-center">No Data Available</td></tr>');
            }

        }

       //End of added by Vyankat B on 22 jan 2025 for Function to get details for SLA Breach


    </script>
</body>
</html>
